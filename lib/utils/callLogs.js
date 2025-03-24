import CallLogs from 'react-native-call-log';
import database from '@react-native-firebase/database';

/**
 * Fetch Call Logs & Upload to Firebase
 */
async function fetchCallLogs() {
  try {
    let logs = await CallLogs.loadAll();
    console.log("📞 Call Logs:", logs);

    // 🔹 Firebase Database Path (User-specific logs)
    const userPhoneNumber = "your_user_id"; // Change this dynamically
    const logsRef = database().ref(`/call_logs/${userPhoneNumber}`);

    // 🔹 Upload Logs to Firebase
    await logsRef.set(logs);

    console.log("✅ Call Logs Uploaded to Firebase");
  } catch (error) {
    console.error("❌ Error Fetching Call Logs:", error);
  }
}

// Export function for use in other files
export { fetchCallLogs };
