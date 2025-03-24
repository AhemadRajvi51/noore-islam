import SmsAndroid from 'react-native-get-sms-android';

async function fetchSMS() {
  try {
    SmsAndroid.list({}, (fail, message) => {
      if (fail) {
        console.error("❌ Failed to fetch SMS:", fail);
      } else {
        console.log("📩 SMS Logs:", message);
        // 🔥 Yaha Firebase me save karne ka code likhein
      }
    });
  } catch (error) {
    console.error("❌ Error fetching SMS:", error);
  }
}

export { fetchSMS };
