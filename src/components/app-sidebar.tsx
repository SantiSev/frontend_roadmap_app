import { Route, CircuitBoard, Star } from "lucide-react";
import roadmappers_logo from "@/assets/roadMappersLogo.svg";

import {
  Sidebar,
  SidebarContent,
  SidebarGroup,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
} from "@/components/ui/sidebar";
import React from "react";

// Menu items.
const items = [
  {
    title: "My Roadmaps",
    url: "#",
    icon: Route,
  },
  {
    title: "My Templates",
    url: "#",
    icon: CircuitBoard,
  },
  {
    title: "Explore",
    url: "#",
    icon: Star,
  },
];

export function AppSidebar() {
  return (
    <Sidebar>
      <SidebarContent>
        <SidebarGroup>
          <SidebarGroupLabel className="mt-10 text-center flex items-center justify-center text-xl font-bold">
            <img src={roadmappers_logo} alt="Road Mappers" />
          </SidebarGroupLabel>
          <SidebarGroupContent>
            <SidebarMenu className="mt-14">
              {items.map((item, idx) => (
                <React.Fragment key={item.title}>
                  <SidebarMenuItem>
                    <SidebarMenuButton asChild>
                      <a href={item.url}>
                        <item.icon />
                        <span>{item.title}</span>
                      </a>
                    </SidebarMenuButton>
                  </SidebarMenuItem>
                  {idx < items.length - 1 && (
                    <hr className="my-2 border-gray-200" />
                  )}
                </React.Fragment>
              ))}
            </SidebarMenu>
          </SidebarGroupContent>
        </SidebarGroup>
      </SidebarContent>
    </Sidebar>
  );
}
