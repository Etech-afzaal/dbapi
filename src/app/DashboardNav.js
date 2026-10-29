"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import styles from "./DashboardNav.module.css";

const items = [
  { href: "/", label: "Elite Postman", icon: "document" },
  { href: "/flights", label: "FlightView API", icon: "plane" },
  { href: "/database_logs", label: "View Database Logs", icon: "database" },
  { href: "/xyzcar-res-mobule", label: "XYZCar Reservation Module", icon: "person" },
  { href: "/xyzcar-profle-module", label: "XYZCar Profile Module", icon: "person" },
];

function Icon({ name }) {
  if (name === "document") return <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M6 2.75h8l5 5V21a1 1 0 0 1-1 1H6a2 2 0 0 1-2-2V4.75a2 2 0 0 1 2-2Z"/><path d="M14 3v5h5M8 13h8M8 17h8"/></svg>;
  if (name === "plane") return <svg viewBox="0 0 24 24" aria-hidden="true"><path d="m2 14 8-2 4-8c.5-1 2-1 2.3.2l-1 7.1 5.5 2.1c1.6.6 1.4 2.9-.3 3.1l-6 .7-3.2 4.8c-.7 1-2.3.5-2.2-.7l.3-4.5-5.8-.4C1.8 16.3 1.4 14.8 2 14Z"/></svg>;
  if (name === "database") return <svg viewBox="0 0 24 24" aria-hidden="true"><ellipse cx="12" cy="5" rx="8" ry="3"/><path d="M4 5v14c0 1.7 3.6 3 8 3s8-1.3 8-3V5M4 12c0 1.7 3.6 3 8 3s8-1.3 8-3"/></svg>;
  return <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 12a5 5 0 1 0 0-10 5 5 0 0 0 0 10ZM3 22v-2a8 8 0 0 1 16 0v2H3Z"/></svg>;
}

export default function DashboardNav() {
  const pathname = usePathname();

  return (
    <nav className={styles.navigation} aria-label="Main navigation">
      {items.map(({ href, label, icon }) => {
        const active = pathname === href;
        return (
          <Link
            key={href}
            className={`${styles.link} ${active ? styles.active : ""}`}
            href={href}
            aria-current={active ? "page" : undefined}
          >
            <Icon name={icon} />
            <span>{label}</span>
          </Link>
        );
      })}
    </nav>
  );
}
