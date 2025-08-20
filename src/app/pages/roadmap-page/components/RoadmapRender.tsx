import { useCallback, useState } from "react";
import {
  ReactFlow,
  applyNodeChanges,
  applyEdgeChanges,
  addEdge,
  type EdgeChange,
  type NodeChange,
  type Connection,
} from "@xyflow/react";
import "@xyflow/react/dist/style.css";

import { Position, type Node } from "@xyflow/react";

const initialNodes: Node[] = [
  {
    id: "n1",
    position: { x: 0, y: 0 },
    data: { label: "Node 1" },
    type: "input",
    sourcePosition: Position.Right,
  },
  {
    id: "n2",
    position: { x: 100, y: 100 },
    data: { label: "Node 2" },
    sourcePosition: Position.Right,
    targetPosition: Position.Left,
  },
  {
    id: "n3",
    position: { x: 200, y: -100 },
    data: { label: "Node 3" },
    sourcePosition: Position.Right,
    targetPosition: Position.Left,
  },
  {
    id: "n4",
    position: { x: 300, y: 200 },
    data: { label: "Node 4" },
    sourcePosition: Position.Right,
    targetPosition: Position.Left,
  },
  {
    id: "n5",
    position: { x: 400, y: -200 },
    data: { label: "Node 5" },
    sourcePosition: Position.Right,
    targetPosition: Position.Left,
  },
  {
    id: "n6",
    position: { x: 500, y: 300 },
    data: { label: "Node 6" },
    sourcePosition: Position.Right,
    targetPosition: Position.Left,
  },
];
const initialEdges = [
  { id: "n1-n2", source: "n1", target: "n2" },
  { id: "n1-n3", source: "n1", target: "n3" },
  { id: "n2-n4", source: "n2", target: "n4" },
  { id: "n2-n5", source: "n2", target: "n5" },
  { id: "n5-n6", source: "n5", target: "n6" },
];

export default function RoadmapRender() {
  const [nodes, setNodes] = useState(initialNodes);
  const [edges, setEdges] = useState(initialEdges);

  const onNodesChange = useCallback(
    (changes: NodeChange[]) =>
      setNodes((nodesSnapshot) => applyNodeChanges(changes, nodesSnapshot)),
    [],
  );
  const onEdgesChange = useCallback(
    (changes: EdgeChange<{ id: string; source: string; target: string }>[]) =>
      setEdges((edgesSnapshot) => applyEdgeChanges(changes, edgesSnapshot)),
    [],
  );
  const onConnect = useCallback(
    (params: Connection) =>
      setEdges((edgesSnapshot) => addEdge(params, edgesSnapshot)),
    [],
  );

  return (
    <div className="h-full w-full">
      <ReactFlow
        nodes={nodes}
        edges={edges}
        onNodesChange={onNodesChange}
        onEdgesChange={onEdgesChange}
        onConnect={onConnect}
        fitView
      />
    </div>
  );
}
