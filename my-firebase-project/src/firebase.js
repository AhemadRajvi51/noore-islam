// Firebase SDK import karein
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";

// Firebase Configuration
const firebaseConfig = {
  apiKey: "AIzaSyBU0oQy6pLShzYsF5fgTKbmclgBbTKMqmY",
  authDomain: "noore-islam.firebaseapp.com",
  databaseURL: "https://noore-islam-default-rtdb.asia-southeast1.firebasedatabase.app",
  projectId: "noore-islam",
  storageBucket: "noore-islam.firebasestorage.app",
  messagingSenderId: "664661929031",
  appId: "1:664661929031:web:5eaf78433f411673de5562",
  measurementId: "G-9CTRJFMM2G"
};

// Firebase ko initialize karein
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);

// Firebase instance ko export karein taki doosri files me use kar sakein
export { app, analytics };
