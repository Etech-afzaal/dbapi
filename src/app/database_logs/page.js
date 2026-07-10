"use client";

import { useRouter } from "next/navigation";
import { useState, useEffect } from "react";
import styles from "./page.module.css";
import axios from "axios";
import Link from "next/link";
import { jsonrepair } from "jsonrepair";

import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";
import { format } from "date-fns";

const DatabaseViewer = () => {
  const router = useRouter();

  const today = new Date();
  const yesterday = new Date();
  yesterday.setDate(today.getDate() - 1);

  const [selectedActionCode, setSelectedActionCode] = useState("ALL");
  const [fromDate, setFromDate] = useState(yesterday);
  const [toDate, setToDate] = useState(today);
  const [limit, setLimit] = useState("25");

  const [actionCodes, setActionCodes] = useState([]);
  const [modalContent, setModalContent] = useState("");
  const [showModal, setShowModal] = useState(false);
  const [copied, setCopied] = useState(false);

  const [responseStatus, setResponseStatus] = useState("");
  const [inProgress, setInProgress] = useState(false);

  const [tableHeaders, setTableHeaders] = useState([]);
  const [allTableHeaders, setAllTableHeaders] = useState([]);
  const [tableRows, setTableRows] = useState([]);
  const [errorText, setErrorText] = useState("");

  useEffect(() => {
    const fetchActionCodes = async () => {
      try {
        const response = await fetch("/data/requestPayload.json");

        if (!response.ok) {
          throw new Error("Failed to load action codes");
        }

        const data = await response.json();

        const sorted = Array.isArray(data)
          ? data
              .slice()
              .sort((a, b) => (a.code || "").localeCompare(b.code || ""))
          : data;

        setActionCodes(sorted);
        // Restore previous logs
        const savedLogs = localStorage.getItem("databaseLogsState");

        if (savedLogs) {
          const parsed = JSON.parse(savedLogs);

          setResponseStatus(parsed.responseStatus || "");
          setAllTableHeaders(parsed.allTableHeaders || []);
          setTableHeaders(parsed.tableHeaders || []);
          setTableRows(parsed.tableRows || []);
        }
      } catch (error) {
        console.error("Error fetching action codes:", error);
      }
    };

    fetchActionCodes();
  }, []);

  const beautifyJson = (value) => {
    if (!value) return "";

    try {
      return JSON.stringify(JSON.parse(value), null, 2);
    } catch {
      try {
        return JSON.stringify(JSON.parse(jsonrepair(value)), null, 2);
      } catch {
        return String(value);
      }
    }
  };

  const tokenizeJDataRows = (str, startIndex) => {
    let i = startIndex;
    const rows = [];

    while (i < str.length && str[i] !== "[") i++;
    i++;

    while (i < str.length) {
      while (i < str.length && str[i] !== "[" && str[i] !== "]") i++;

      if (str[i] === "]") break;

      i++;

      const row = [];

      while (i < str.length) {
        while (i < str.length && str[i] !== '"') i++;

        if (i >= str.length) break;

        i++;

        const fieldStart = i;
        let depth = 0;

        while (i < str.length) {
          const c = str[i];

          if (c === "{" || c === "[") depth++;
          else if (c === "}" || c === "]") depth--;

          if (c === '"' && depth === 0) {
            let j = i + 1;

            while (j < str.length && /\s/.test(str[j])) j++;

            if (str[j] === "," || str[j] === "]") {
              row.push(str.slice(fieldStart, i));
              i = j;
              break;
            }
          }

          i++;
        }

        if (str[i] === "]") {
          i++;
          break;
        }

        if (str[i] === ",") {
          i++;
          continue;
        }
      }

      rows.push(row);

      while (i < str.length && /\s/.test(str[i])) i++;

      if (str[i] === ",") {
        i++;
        continue;
      }

      if (str[i] === "]") break;
    }

    return rows;
  };

  const parseDBAPIResponse = (value) => {
    let raw = value;

    while (typeof raw === "string") {
      try {
        raw = JSON.parse(raw);
      } catch {
        break;
      }
    }

    if (typeof raw !== "string") {
      return raw;
    }

    const repaired = JSON.parse(jsonrepair(raw));

    const jDataIndex = raw.indexOf('"JData"');
    const jDataStart = raw.indexOf("[", jDataIndex);

    if (jDataIndex !== -1 && jDataStart !== -1) {
      repaired.JData = tokenizeJDataRows(raw, jDataStart);
    }

    return repaired;
  };

  const formatCellValue = (cell) => {
    if (cell === null || cell === undefined) return "";

    if (typeof cell === "object") {
      return JSON.stringify(cell, null, 2);
    }

    return String(cell);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (!fromDate || !toDate || !limit) {
      setResponseStatus("Error");
      setErrorText("Please fill From Date, To Date, and Limit.");
      setTableHeaders([]);
      setTableRows([]);
      return;
    }

    if (!selectedActionCode) {
      setResponseStatus("Error");
      setErrorText("Please select an Action Code.");
      return;
    }

    setInProgress(true);
    setResponseStatus("");
    setErrorText("");
    setTableHeaders([]);
    setTableRows([]);

    try {
      const payloadResponse = await fetch("/data/requestPayload.json");
      const payloads = await payloadResponse.json();

      const selectedPayload = payloads.find(
        (item) => item.code === "S.DATABASE.LOGS",
      );

      if (!selectedPayload) {
        throw new Error("S.DATABASE.LOGS payload not found.");
      }

      const dbapiPayload = structuredClone(selectedPayload.payload);

      dbapiPayload.JsonReq.JData = {
        ...dbapiPayload.JsonReq.JData,
        p_ACTION_CODE: selectedActionCode,
        p_FROM_DATE: format(fromDate, "MM/dd/yyyy"),
        p_TO_DATE: format(toDate, "MM/dd/yyyy"),
        p_LIMIT: limit,
      };

      dbapiPayload.JsonReq.JHeader = {
        ...dbapiPayload.JsonReq.JHeader,
        ViewName: dbapiPayload.ViewName,
        ActionCode: dbapiPayload.ActionCode,
        RequestedURL: process.env.NEXT_PUBLIC_DBAPI_DEV_URL,
      };

      const response = await axios.post("/api/dblogs", {
        ...dbapiPayload,
        dbapiUrl: process.env.NEXT_PUBLIC_DBAPI_DEV_URL,
      });

      setResponseStatus(response.data.status);

      const parsedResponse = parseDBAPIResponse(response.data.text);

      const headings = parsedResponse?.JMetaData?.Headings || [];
      const rows = parsedResponse?.JData || [];

      const allColumns = headings.map((heading, index) => ({
        key: heading[0],
        label: heading[1],
        index,
      }));

      const visibleColumnKeys = [
        "LOG_ID",
        "ACTION_TIME",
        "ACTION_CODE",
        "PARAMS",
        "RESPONSE",
      ];

      const visibleColumns = allColumns.filter((column) =>
        visibleColumnKeys.includes(column.key),
      );

      setAllTableHeaders(allColumns);
      setTableHeaders(visibleColumns);
      setTableRows(rows);

      localStorage.setItem(
        "databaseLogsState",
        JSON.stringify({
          responseStatus: response.data.status,
          allTableHeaders: allColumns,
          tableHeaders: visibleColumns,
          tableRows: rows,
        }),
      );

      if (rows.length === 0) {
        setErrorText("No records found.");
      }
    } catch (error) {
      setResponseStatus("Error");
      setErrorText(error.message || "Something went wrong.");
      setTableHeaders([]);
      setTableRows([]);
    } finally {
      setInProgress(false);
    }
  };

  const handleCopy = () => {
    navigator.clipboard
      .writeText(modalContent)
      .then(() => {
        setCopied(true);
        setTimeout(() => setCopied(false), 2000);
      })
      .catch((err) => console.error("Failed to copy: ", err));
  };

  const handleRowClick = (row) => {
    const logId = row[0];

    localStorage.setItem(
      "selectedLogDetails",
      JSON.stringify({
        columns: allTableHeaders,
        row,
      }),
    );

    router.push(`/database_logs/${logId}`);
  };

  return (
    <div className={styles.container}>
      <h1 className={styles.heading}>Database Logs Viewer</h1>

      <div className={styles.lblLink}>
        <Link href="/">DBAPI</Link>
        <Link href="/flights">Flightview API</Link>
      </div>

      <form onSubmit={handleSubmit} className={styles.form}>
        <div className={styles.filterRow}>
          <div className={styles.field}>
            <label className={styles.label}>Select Action Code</label>

            <select
              value={selectedActionCode}
              onChange={(e) => setSelectedActionCode(e.target.value)}
              className={`${styles.input} ${styles.longInput}`}
            >
              <option value="ALL">All</option>

              {actionCodes.map((action) => (
                <option key={action.code} value={action.code}>
                  {action.code}
                </option>
              ))}
            </select>
          </div>

          <div className={styles.field}>
            <label className={styles.label}>From Date</label>

            <DatePicker
              selected={fromDate}
              onChange={(date) => setFromDate(date)}
              dateFormat="MM/dd/yyyy"
              className={styles.input}
              wrapperClassName={styles.datePickerWrapper}
            />
          </div>

          <div className={styles.field}>
            <label className={styles.label}>To Date</label>

            <DatePicker
              selected={toDate}
              onChange={(date) => setToDate(date)}
              dateFormat="MM/dd/yyyy"
              className={styles.input}
              wrapperClassName={styles.datePickerWrapper}
            />
          </div>

          <div className={styles.field}>
            <label className={styles.label}>Limit</label>

            <input
              type="number"
              value={limit}
              onChange={(e) => setLimit(e.target.value)}
              className={styles.input}
              min="1"
            />
          </div>

          <div className={styles.buttonWrapper}>
            <button type="submit" className={styles.submitButton}>
              {inProgress ? "Loading..." : "Fetch Database Logs"}
            </button>
          </div>
        </div>

        <div className={styles.formGroup}>
          <label className={styles.label}>Response Status</label>

          <input
            type="text"
            value={responseStatus}
            readOnly
            className={`${styles.input} ${styles.readOnlyInput}`}
          />
        </div>

        {errorText && (
          <div className={styles.formGroup}>
            <pre>
              <code className={styles.codeWrap}>{errorText}</code>
            </pre>
          </div>
        )}

        {tableRows.length > 0 && (
          <div className={styles.tableContainer}>
            <table className={styles.table}>
              <thead>
                <tr>
                  {tableHeaders.map((column) => (
                    <th key={column.key} data-col={column.key}>
                      {column.label}
                    </th>
                  ))}
                </tr>
              </thead>

              <tbody>
                {tableRows.map((row, rowIndex) => (
                  <tr
                    key={rowIndex}
                    onClick={() => handleRowClick(row)}
                    className={styles.clickableRow}
                  >
                    {tableHeaders.map((column) => (
                      <td
                        key={`${rowIndex}-${column.key}`}
                        data-col={column.key}
                      >
                        {(column.key === "PARAMS" ||
                          column.key === "RESPONSE") &&
                        row[column.index] ? (
                          <div className={styles.paramsPreview}>
                            <span className={styles.previewText}>
                              {formatCellValue(row[column.index])}
                            </span>

                            <button
                              type="button"
                              className={styles.seeMoreButton}
                              onClick={(e) => {
                                e.stopPropagation();
                                setModalContent(
                                  beautifyJson(row[column.index]),
                                );
                                setShowModal(true);
                              }}
                            >
                              See more
                            </button>
                          </div>
                        ) : (
                          formatCellValue(row[column.index])
                        )}
                      </td>
                    ))}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </form>

      {showModal && (
        <div className={styles.modalOverlay}>
          <div className={styles.modalBox}>
            <div className={styles.modalHeader}>
              <h3>Details</h3>

              <div className={styles.modalHeaderActions}>
                <button
                  type="button"
                  className={styles.copyButton}
                  onClick={handleCopy}
                >
                  {copied ? "Copied!" : "Copy"}
                </button>

                <button
                  type="button"
                  className={styles.closeButton}
                  onClick={() => {
                    setShowModal(false);
                    setCopied(false);
                  }}
                >
                  ×
                </button>
              </div>
            </div>

            <pre className={styles.modalContent}>{modalContent}</pre>
          </div>
        </div>
      )}
    </div>
  );
};

export default DatabaseViewer;
