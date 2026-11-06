import Link from "next/link";
import styles from "./home.module.css";

export default function Home() {
  return (
    <main className={styles.home}>
      <h1 className={styles.title}>Postman API Clients_1</h1>
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
            <span className={styles.disabled} aria-disabled="true">
              View Database Logs
            </span>
          </div>
        </section>
        <section className={styles.card} aria-labelledby="blinkride-title">
          <h2 id="blinkride-title">BlinkRide Postman</h2>
          <div className={styles.links}>
            <Link href="/blinkride/driver-native">BR Driver Native App</Link>
            <Link href="/blinkride/io-web-portal">BR IO Web Portal</Link>
            <Link href="/blinkride/customer-app">BR Customer App</Link>
            <span className={styles.disabled} aria-disabled="true">
              View Database Logs
            </span>
          </div>
        </section>
        <section className={styles.card} aria-labelledby="gft-title">
          <h2 id="gft-title">GFT Postman</h2>
          <div className={styles.links}>
<<<<<<< HEAD
            <Link href="/gft-postman">GFT Postman</Link>
            <span className={styles.disabled} aria-disabled="true">View Database Logs</span>
=======
            <span className={styles.disabled} aria-disabled="true">
              GFT Postman
            </span>
>>>>>>> 4254edc24e1a8056f6c081bb1447e64869bb9c93
          </div>
        </section>
      </div>
    </main>
  );
}
