import Header from '@/components/Header'
import Footer from '@/components/Footer'

export default function SignUp() {
  return (
    <>
      <Header />
      <main className="flex-grow container mx-auto px-4 py-8">
        <div className="max-w-md mx-auto">
          <h2 className="text-3xl font-bold mb-4">Sign Up</h2>
          <form className="space-y-4">
            <div>
              <label htmlFor="name" className="block mb-1">Name</label>
              <input type="text" id="name" name="name" required className="w-full px-3 py-2 border rounded" />
            </div>
            <div>
              <label htmlFor="email" className="block mb-1">Email</label>
              <input type="email" id="email" name="email" required className="w-full px-3 py-2 border rounded" />
            </div>
            <div>
              <label htmlFor="password" className="block mb-1">Password</label>
              <input type="password" id="password" name="password" required className="w-full px-3 py-2 border rounded" />
            </div>
            <div>
              <label htmlFor="accountType" className="block mb-1">Account Type</label>
              <select id="accountType" name="accountType" className="w-full px-3 py-2 border rounded">
                <option value="individual">Individual</option>
                <option value="institution">Institution</option>
              </select>
            </div>
            <button type="submit" className="w-full bg-teal-600 text-white py-2 rounded hover:bg-teal-700">
              Sign Up
            </button>
          </form>
        </div>
      </main>
      <Footer />
    </>
  )
}