import { useUserStore } from "@/stores/useUserStore";

export default function RoadmapPage() {
  const user = useUserStore((state) => state.user);

  return (
    <div className="flex items-center justify-center">
      {user ? (
        <h1 className="text-2xl font-bold">
          Welcome to the Roadmap Page, {user.name}!
        </h1>
      ) : (
        <h1 className="text-2xl font-bold">
          Please log in to view your roadmap.
        </h1>
      )}
    </div>
  );
}
