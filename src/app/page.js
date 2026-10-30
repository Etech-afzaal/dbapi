import Link from "next/link";
import styles from "./home.module.css";

export default function Home() {
  return (
    <main className={styles.home}>
      <h1 className={styles.title}>Postman API Clients</h1>
      <div className={styles.cards}>
        <section className={styles.card} aria-labelledby="elite-title">
          <h2 id="elite-title">Elite Postman</h2>
          <div className={styles.links}>
            <Link href="/elite-postman">Elite Postman</Link>
            <Link href="/flights">FlightView API</Link>
            <Link href="/database_logs">View Database Logs</Link>
          </div>
        </section>
        <section className={styles.card} aria-labelledby="xyz-title">
          <h2 id="xyz-title">XYZCar Postman</h2>
          <div className={styles.links}>
            <Link href="/xyzcar-res-module">XYZCar Postman</Link>
            <span className={styles.disabled} aria-disabled="true">View Database Logs</span>
          </div>
        </section>
      </div>
    </main>
  );
}
