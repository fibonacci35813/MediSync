import Header from '@/components/Header'
import Footer from '@/components/Footer'

export default function SignIn() {
  return (
    <>
      <Header />
      <main className="flex-grow container mx-auto px-4 py-8">
        <div className="max-w-md mx-auto">
          <h2 className="text-3xl font-bold mb-4">Sign In</h2>
          <form className="space-y-4">
            <div>
              <label htmlFor="email" className="block mb-1">Email</label>
              <input type="email" id="email" name="email" required className="w-full px-3 py-2 border rounded" />
            </div>
            <div>
              <label htmlFor="password" className="block mb-1">Password</label>
              <input type="password" id="password" name="password" required className="w-full px-3 py-2 border rounded" />
            </div>
            <button type="submit" className="w-full bg-teal-600 text-white py-2 rounded hover:bg-teal-700">
              Sign In
            </button>
          </form>
        </div>
      </main>
      <Footer />
    </>
  )
}