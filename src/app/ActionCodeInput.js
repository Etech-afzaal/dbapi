"use client";

import { useMemo, useState } from "react";
import styles from "./ActionCodeInput.module.css";

export default function ActionCodeInput({ id, value, onChange, actions }) {
  const [isOpen, setIsOpen] = useState(false);
  const filteredActions = useMemo(() => {
    const query = value.trim().toLowerCase();
    return actions.filter((action) =>
      (action.code || "").toLowerCase().includes(query),
    );
  }, [actions, value]);

  return (
    <div className={styles.container}>
      <input
        id={id}
        name={id}
        value={value}
        onChange={(event) => {
          onChange(event);
          setIsOpen(true);
        }}
        onFocus={() => setIsOpen(true)}
        onBlur={() => setIsOpen(false)}
        autoComplete="off"
        className={styles.input}
        placeholder="Select or type an Action Code"
        role="combobox"
        aria-autocomplete="list"
        aria-expanded={isOpen}
        aria-controls={`${id}-options`}
      />
      <button
        type="button"
        className={styles.dropdownButton}
        aria-label={isOpen ? "Close action code options" : "Open action code options"}
        aria-expanded={isOpen}
        aria-controls={`${id}-options`}
        onMouseDown={(event) => event.preventDefault()}
        onClick={() => setIsOpen((open) => !open)}
      >
        <span className={`${styles.chevron} ${isOpen ? styles.chevronOpen : ""}`} aria-hidden="true" />
      </button>
      {isOpen && (
        <ul id={`${id}-options`} className={styles.options} role="listbox">
          <li role="option" aria-selected={false}>
            <button
              type="button"
              className={styles.option}
              onMouseDown={(event) => event.preventDefault()}
              onClick={() => {
                onChange({ target: { value: "custom" } });
                setIsOpen(false);
              }}
            >
              Custom Action Code
            </button>
          </li>
          {filteredActions.map((action) => (
            <li key={action.code} role="option" aria-selected={false}>
              <button
                type="button"
                className={styles.option}
                onMouseDown={(event) => event.preventDefault()}
                onClick={() => {
                  onChange({ target: { value: action.code } });
                  setIsOpen(false);
                }}
              >
                {action.code}
                {action.desc ? ` - ${action.desc}` : ""}
              </button>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}
