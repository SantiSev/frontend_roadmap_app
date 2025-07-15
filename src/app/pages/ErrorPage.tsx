import { Link } from "react-router-dom";

export default function ErrorPage() {
  return (
    <div style={{ textAlign: "center", marginTop: "20vh" }}>
      <h1>Oops! Something went wrong.</h1>
      <p>Click the button below to return to the Home Page.</p>
      <Link to="/">Go back Home</Link>
    </div>
  );
}
