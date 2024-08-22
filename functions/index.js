/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.upwork_callback =
// onRequest({cors: [/upwork\.com$/]},(request, response) => {
exports.upwork_callback = onRequest(
    {cors: true},
    (request, response) => {
      logger.info("Upwork Callback Call", {structuredData: true});
      response.send("Ok");
    });
