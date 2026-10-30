import styles from "./PageSkeleton.module.css";

export default function PageSkeleton({ kind = "form" }) {
  if (kind === "home") {
    return (
      <main className={styles.home} aria-busy="true" aria-label="Loading home page">
        <div className={`${styles.shimmer} ${styles.title}`} />
        <div className={styles.cards}>
          <div className={`${styles.shimmer} ${styles.card}`} />
          <div className={`${styles.shimmer} ${styles.card}`} />
        </div>
      </main>
    );
  }

  return (
    <main className={styles.page} aria-busy="true" aria-label="Loading page">
      <div className={`${styles.shimmer} ${styles.title}`} />
      <div className={`${styles.shimmer} ${styles.subtitle}`} />
      <div className={styles.tabs}>
        <div className={`${styles.shimmer} ${styles.tab}`} />
        <div className={`${styles.shimmer} ${styles.tab}`} />
        <div className={`${styles.shimmer} ${styles.tab}`} />
      </div>
      <div className={styles.panel}>
        <div className={`${styles.shimmer} ${styles.label}`} />
        <div className={`${styles.shimmer} ${styles.field}`} />
        <div className={`${styles.shimmer} ${styles.label}`} />
        <div className={`${styles.shimmer} ${styles.textarea}`} />
        <div className={`${styles.shimmer} ${styles.label}`} />
        <div className={`${styles.shimmer} ${kind === "logs" ? styles.textarea : styles.field}`} />
        <div className={`${styles.shimmer} ${styles.button}`} />
      </div>
    </main>
  );
}
