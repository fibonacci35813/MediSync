import React, { useState, useEffect } from 'react';
import { Home, FileText, Bell, User, ChevronRight, AlertCircle, Calendar } from 'lucide-react';

// Mock API
const fetchData = () => {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve({
        name: 'John Doe',
        reminders: [
          { id: 1, text: 'Take Medication A', time: '2:00 PM' },
          { id: 2, text: 'Blood Pressure Check', time: '4:00 PM' },
        ],
        records: [
          { id: 1, type: 'Blood Test', date: '2024-07-15' },
          { id: 2, type: 'X-Ray', date: '2024-07-10' },
        ],
        alerts: [
          { id: 1, text: 'Your blood pressure reading is higher than usual. Consider scheduling a check-up.' },
        ],
      });
    }, 1000);
  });
};

const MediSyncApp = () => {
  const [activeTab, setActiveTab] = useState('Home');
  const [userData, setUserData] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchData().then((data) => {
      setUserData(data);
      setLoading(false);
    });
  }, []);

  const TabButton = ({ icon, label }) => (
    <button 
      onClick={() => setActiveTab(label)}
      className={`flex flex-col items-center p-2 ${activeTab === label ? 'text-blue-500' : 'text-gray-500'}`}
    >
      {icon}
      <span className="text-xs mt-1">{label}</span>
    </button>
  );

  const HomeScreen = () => (
    <div className="space-y-6">
      <h2 className="text-2xl font-semibold">Welcome, {userData?.name}</h2>
      
      <div className="grid grid-cols-2 gap-4">
        <button className="bg-white p-4 rounded-lg shadow flex items-center justify-center">
          <FileText className="text-blue-500 mr-2" />
          <span>View Reports</span>
        </button>
        <button className="bg-white p-4 rounded-lg shadow flex items-center justify-center">
          <Calendar className="text-blue-500 mr-2" />
          <span>Appointments</span>
        </button>
      </div>

      <div className="bg-white p-4 rounded-lg shadow">
        <h3 className="font-semibold mb-2">Upcoming Reminders</h3>
        {userData?.reminders.map((reminder) => (
          <div key={reminder.id} className="flex items-center text-sm text-gray-600 mb-2">
            <Bell size={16} className="mr-2" />
            <span>{reminder.text} - {reminder.time}</span>
          </div>
        ))}
      </div>

      {userData?.alerts.map((alert) => (
        <div key={alert.id} className="bg-red-100 p-4 rounded-lg shadow">
          <h3 className="font-semibold mb-2 flex items-center">
            <AlertCircle size={20} className="text-red-500 mr-2" />
            Health Alert
          </h3>
          <p className="text-sm">{alert.text}</p>
        </div>
      ))}
    </div>
  );

  const RecordsScreen = () => (
    <div className="space-y-6">
      <h2 className="text-2xl font-semibold">Medical Records</h2>
      {userData?.records.map((record) => (
        <div key={record.id} className="bg-white p-4 rounded-lg shadow flex justify-between items-center">
          <div>
            <h3 className="font-semibold">{record.type}</h3>
            <p className="text-sm text-gray-500">{record.date}</p>
          </div>
          <ChevronRight size={20} className="text-gray-400" />
        </div>
      ))}
    </div>
  );

  const RemindersScreen = () => (
    <div className="space-y-6">
      <h2 className="text-2xl font-semibold">Reminders</h2>
      {userData?.reminders.map((reminder) => (
        <div key={reminder.id} className="bg-white p-4 rounded-lg shadow flex justify-between items-center">
          <div>
            <h3 className="font-semibold">{reminder.text}</h3>
            <p className="text-sm text-gray-500">{reminder.time}</p>
          </div>
          <Bell size={20} className="text-blue-500" />
        </div>
      ))}
    </div>
  );

  const ProfileScreen = () => (
    <div className="space-y-6">
      <h2 className="text-2xl font-semibold">Profile</h2>
      <div className="bg-white p-4 rounded-lg shadow">
        <h3 className="font-semibold mb-2">Personal Information</h3>
        <p>Name: {userData?.name}</p>
        <p>Universal Health ID: UHI123456789</p>
      </div>
    </div>
  );

  return (
    <div className="w-full h-screen bg-gray-100 flex flex-col">
      <header className="bg-blue-500 text-white p-4 flex justify-between items-center">
        <h1 className="text-xl font-bold">MediSync</h1>
        <User size={24} />
      </header>

      <main className="flex-grow p-4 overflow-y-auto">
        {loading ? (
          <div className="flex items-center justify-center h-full">
            <p>Loading...</p>
          </div>
        ) : (
          <>
            {activeTab === 'Home' && <HomeScreen />}
            {activeTab === 'Records' && <RecordsScreen />}
            {activeTab === 'Reminders' && <RemindersScreen />}
            {activeTab === 'Profile' && <ProfileScreen />}
          </>
        )}
      </main>

      <nav className="bg-white border-t flex justify-around p-2">
        <TabButton icon={<Home size={24} />} label="Home" />
        <TabButton icon={<FileText size={24} />} label="Records" />
        <TabButton icon={<Bell size={24} />} label="Reminders" />
        <TabButton icon={<User size={24} />} label="Profile" />
      </nav>
    </div>
  );
};

export default MediSyncApp;