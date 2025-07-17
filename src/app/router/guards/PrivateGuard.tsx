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
        <main className="flex flex-1">
          <SidebarTrigger className="z-10 w-10 border-r h-full bg-sidebar flex items-start rounded-none pt-12" />
          <div className="flex-1 bg-gray-100 flex items-center justify-center">
            <Outlet />
          </div>
        </main>
      </SidebarProvider>
    </div>
  ) : (
    <Navigate to="/login" replace />
  );
}
