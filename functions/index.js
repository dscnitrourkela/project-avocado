const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase)

var msgData

exports.notificationTrigger = functions.firestore.document(
    'nots/{notsId}'
).onCreate((snapshot, context) => {
    msgData=snapshot.data(); 

    var payload = {
        "notification": {
            "title":msgData.title,
            "body" :msgData.description,
            "sound":"default"
        },
        "data": {
            "click_action": "FLUTTER_NOTIFICATION_CLICK", 
            "id": "1", 
            "status": "done"
        }
    }
    return admin.messaging().sendToTopic('scs-not',payload).then((response) => {
        console.log('Pushed Notification');
    }).catch((err)=> {
        console.log(err);
    })

    })
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });
