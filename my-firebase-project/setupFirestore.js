const admin = require("firebase-admin");

// Firebase service account key JSON load kare
const serviceAccount = require("./serviceAccountKey.json");

// Firebase initiakize kare
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();

// "admin_settings" Collection me Document banaye
db.collection("admin_settings").doc("master").set({
  secret_code: "786786",
  admin_email: "your@email.com",
}).then(() => {
  console.log("admin_settings Created!");
});

// "content_filters" Collection में Document बनाएं
db.collection("content_filters").doc("islamic").set({
  keywords: ["violence", "adult", "haram"],
}).then(() => {
  console.log("content_filters Created!");
});
