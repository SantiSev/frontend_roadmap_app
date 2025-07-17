import { Navigate, Outlet } from "react-router-dom";
import { useUserStore } from "../../../stores/useUserStore";
import { SidebarProvider, SidebarTrigger } from "@/components/ui/sidebar";
import { AppSidebar } from "@/components/app-sidebar";

export default function PrivateGuard() {
  const { user, initialized } = useUserStore();

  if (!initialized) {
    return <div>Loading...</div>; // Or your preferred loading component
  }

  return user != null ? (
    <div className="w-screen h-screen relative">
      <SidebarProvider>
        <AppSidebar />
        <main>
          <SidebarTrigger />
          <Outlet />
        </main>
      </SidebarProvider>
    </div>
  ) : (
    <Navigate to="/login" replace />
  );
}
