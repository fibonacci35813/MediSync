import Link from 'next/link'
import { 
  Calendar, Users, Building, UserPlus, Package, DollarSign, 
  Heart, Flask, FileText, Syringe, HelpCircle, Activity 
} from 'lucide-react'

const modules = [
  { name: 'Appointment Management', icon: Calendar, href: '/dashboard/appointments' },
  { name: 'Patient Management', icon: Users, href: '/dashboard/patients' },
  { name: 'Facility Management', icon: Building, href: '/dashboard/facilities' },
  { name: 'Staff Management', icon: UserPlus, href: '/dashboard/staff' },
  { name: 'Supply Management', icon: Package, href: '/dashboard/supplies' },
  { name: 'Financial Management', icon: DollarSign, href: '/dashboard/finance' },
  { name: 'Insurance Management', icon: Heart, href: '/dashboard/insurance' },
  { name: 'Laboratory Management', icon: Flask, href: '/dashboard/laboratory' },
  { name: 'Report Management', icon: FileText, href: '/dashboard/reports' },
  { name: 'Vaccination Management', icon: Syringe, href: '/dashboard/vaccinations' },
  { name: 'Support Management', icon: HelpCircle, href: '/dashboard/support' },
]

export default function DashboardSidebar() {
  return (
    <aside className="w-64 bg-white shadow-md">
      <div className="p-4 flex items-center">
        <Activity className="text-teal-600 w-8 h-8 mr-2" />
        <span className="text-xl font-bold text-teal-600">MediSync</span>
      </div>
      <nav className="mt-4">
        {modules.map((module) => (
          <Link 
            key={module.name} 
            href={module.href}
            className="flex items-center px-4 py-2 text-gray-700 hover:bg-teal-100"
          >
            <module.icon className="w-5 h-5 mr-2" />
            {module.name}
          </Link>
        ))}
      </nav>
    </aside>
  )
}