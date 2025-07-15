import { Navigate, Outlet } from "react-router-dom";
import { useUserStore } from "../../../stores/useUserStore";

export default function PrivateGuard() {
  const user = useUserStore((state) => state.user);

  return user != null ? <Outlet /> : <Navigate to="/login" replace />;
}
