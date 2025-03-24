const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();
const db = admin.firestore();

// 🔹 API Endpoint: Admin Settings Get kare
exports.getAdminSettings = functions.https.onRequest(async (req, res) => {
    const docRef = db.collection("admin_settings").doc("master");
    const doc = await docRef.get();
    
    if (!doc.exists) {
        return res.status(404).send("Document not found");
    }

    res.json(doc.data());
});

// 🔹 API Endpoint: Content Filters Get kare
exports.getContentFilters = functions.https.onRequest(async (req, res) => {
    const docRef = db.collection("content_filters").doc("islamic");
    const doc = await docRef.get();

    if (!doc.exists) {
        return res.status(404).send("Document not found");
    }

    res.json(doc.data());
});
