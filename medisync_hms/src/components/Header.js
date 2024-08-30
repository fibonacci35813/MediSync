import Link from 'next/link'
import { Activity } from 'lucide-react'

export default function Header() {
  return (
    <header className="bg-white shadow-md">
      <div className="max-w-7xl mx-auto py-4 px-4 sm:px-6 lg:px-8 flex items-center justify-between">
        <div className="flex items-center">
          <Activity className="text-teal-600 w-8 h-8 mr-2" />
          <Link href="/" className="text-2xl font-bold text-teal-600">MediSync</Link>
        </div>
        <nav>
          <Link href="/signin" className="text-teal-600 hover:text-teal-800 mr-4">Sign In</Link>
          <Link href="/signup" className="bg-teal-600 text-white px-4 py-2 rounded hover:bg-teal-700">Sign Up</Link>
        </nav>
      </div>
    </header>
  )
}