// Firebase SDK load kare
import { initializeApp } from "https://www.gstatic.com/firebasejs/10.5.0/firebase-app.js";
import { getFirestore, doc, getDoc } from "https://www.gstatic.com/firebasejs/10.5.0/firebase-firestore.js";

// 🔹 Firebase Config
const firebaseConfig = {
    apiKey: "YOUR_API_KEY",
    authDomain: "YOUR_PROJECT_ID.firebaseapp.com",
    projectId: "YOUR_PROJECT_ID",
    storageBucket: "YOUR_PROJECT_ID.appspot.com",
    messagingSenderId: "YOUR_SENDER_ID",
    appId: "YOUR_APP_ID"
};

// 🔹 Initialize Firebase
const app = initializeApp(firebaseConfig);
const db = getFirestore(app);

// 🔹 Firestore se Admin Settings hasil kare
async function getAdminSettings() {
    const docRef = doc(db, "admin_settings", "master");
    const docSnap = await getDoc(docRef);

    if (docSnap.exists()) {
        console.log("Admin Settings:", docSnap.data());
    } else {
        console.log("No such document!");
    }
}

getAdminSettings();
