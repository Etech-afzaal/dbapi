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
        aria-expanded={isOpen && filteredActions.length > 0}
        aria-controls={`${id}-options`}
      />
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
