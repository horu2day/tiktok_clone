import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();
// 새 영상이 있는지 listen 한 다음, db에 추가하고,db에 추가가 된다면 추가적인 정보를 그 영상에 추가해 줌.
export const onVideoCreated = functions.firestore.document("videos/{videoId}").onCreate(async (snapshot, context)=>{await snapshot.ref.update({hello:"from functions"});});


/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */



// Start writing functions
// https://firebase.google.com/docs/functions/typescript

// export const helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
