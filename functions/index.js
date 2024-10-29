const functions = require("firebase-functions");
const admin = require("firebase-admin");
const cors = require("cors")(); // CORS konfigürasyonu
admin.initializeApp();

exports.getFilesList = functions.https.onRequest(async (req, res) => {
  cors(req, res, async () => { // CORS ile fonksiyon sarmalama
    const clientId = req.query.clientId;
    console.log("Received clientId:", clientId);

    if (!clientId) {
      res.status(400).send("Client ID is required");
      return;
    }

    try {
      const bucket = admin.storage().bucket();
      const [files] = await bucket.getFiles({
        prefix: `clients/${clientId}/reports/`,
      });

      const fileNames = files.map((file) => file.name);

      console.log("Fetched file names:", fileNames);
      res.status(200).send(fileNames);
    } catch (error) {
      console.error("Error fetching files:", error);
      res.status(500).send("Error fetching files");
    }
  });
});
