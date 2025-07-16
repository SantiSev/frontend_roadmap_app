import { createBrowserRouter, Navigate } from "react-router-dom";
import PrivateGuard from "./guards/PrivateGuard";
import PublicGuard from "./guards/PublicGuard";
import ErrorPage from "../pages/ErrorPage";
import SignIn from "../pages/SignIn";
import HomePage from "../pages/Home";

const router = createBrowserRouter([
  {
    path: "/login",
    element: (
      <PublicGuard>
        <SignIn />
      </PublicGuard>
    ),
  },
  {
    path: "/error",
    element: (
      <PublicGuard>
        <ErrorPage />
      </PublicGuard>
    ),
  },
  {
    path: "/",
    element: <PrivateGuard />,
    children: [
      {
        index: true,
        element: <HomePage />,
      },
    ],
  },
  {
    // Redirect any unmatched routes to the login page
    path: "*",
    element: <Navigate to="/error" />,
  },
]);

export default router;
