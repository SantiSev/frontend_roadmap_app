import { Navigate, Outlet } from "react-router-dom";
import { useUserStore } from "../../../stores/useUserStore";

export default function PrivateGuard() {
  {
    // TODO: Implement a more robust authentication check, this is a placeholder implementation for testing purposes
    // The backend should ideally provide a way to check if the user is authenticated
    // and authorized to access the routes.
    // Also, there should be a way to handle token expiration and refresh.
  }
  const user = useUserStore((state) => state.user);

  return user != null ? <Outlet /> : <Navigate to="/login" replace />;
}
