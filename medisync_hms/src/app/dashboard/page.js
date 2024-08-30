import DashboardSidebar from '@/components/DashboardSidebar'

export default function Dashboard() {
  return (
    <div className="flex h-screen bg-gray-100">
      <DashboardSidebar />
      <main className="flex-1 p-8">
        <h1 className="text-3xl font-bold mb-4">Dashboard</h1>
        <p>Welcome to your MediSync HMS Dashboard. Select a module from the sidebar to get started.</p>
      </main>
    </div>
  )
}