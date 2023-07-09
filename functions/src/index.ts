import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();
// 새 영상이 있는지 listen 한 다음, db에 추가하고,db에 추가가 된다면 추가적인 정보를 그 영상에 추가해 줌.
export const onVideoCreated = functions.firestore.document("videos/{videoId}").onCreate(
    async (snapshot, context)=>{
        const spawn = require("child-process-promise").spawn;
        const video = snapshot.data();
        //업로드한 영상을 입력으로 가져와서 
        await spawn("ffmpeg", [
            "-i",
            video.fileUrl,
            "-ss", //이동하라
            "00:00:01.000", // 1초대의 시간으로
            "-vframes", // 프레임은 
            "1", // 첫번째 프레임
            "-vf", // video filter는
            "scale=150:-1", //가로는 150 세로는 -1(영상비율대로 자동길이)
            `/tmp/${snapshot.id}.jpg`, // 구글클라우드의 임시저장소에 저장 밑에서 storage로 옮겨야 함.
        ]);
        const storage = admin.storage();
        await storage.bucket().upload(`/tmp/${snapshot.id}.jpg`,{
            destination: `/thumbnails/${snapshot.id}.jpg`,
        },);
    });


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
