import { Navigate, Outlet } from "react-router-dom";
import useAuth from "../../auth/useAuth";

export default function PrivateGuard() {
  {
    /* TODO: later replace this with react hooks to not use useAuth() */
  }
  const { isAuthenticated } = useAuth();

  return isAuthenticated != null ? (
    <Outlet />
  ) : (
    <Navigate to="/login" replace />
  );
}
