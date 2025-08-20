import RoadmapRender from "@/app/pages/roadmap-page/components/RoadmapRender";
import RoadmapHeader from "./components/RoadmapHeader";

export default function RoadmapPage() {
  return (
    <div className="flex h-full w-full flex-col items-center justify-start gap-4">
      <RoadmapHeader />
      <RoadmapRender />
    </div>
  );
}
