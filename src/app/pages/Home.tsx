import { useUserStore } from "../../stores/useUserStore";

export default function HomePage() {
  const user = useUserStore((state) => state.user);

  return (
    <div className="w-screen h-screen flex items-center justify-center flex-col">
      <h1 className="text-2xl font-bold">Welcome to Roadmap App</h1>
      <p>
        This is the homepage! later this should be the landing page to this
        website
      </p>
      {user && (
        <div className="mt-4">
          <p>
            <strong>Name:</strong> {user.name}
          </p>
          <p>
            <strong>Email:</strong> {user.email}
          </p>
        </div>
      )}
    </div>
  );
}
