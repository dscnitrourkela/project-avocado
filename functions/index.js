const functions = require('firebase-functions');
const admin = require('firebase-admin');
const moment = require('moment-timezone');

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

    exports.slotBookTrigger = functions.database
    .ref('/slots/week1/{type}/{slot}')
    .onUpdate((change,context) => {
        const before = change.before.val();
        const after = change.after.val();
        if(before.status === after.status){
            return null;
        }
        else{
        const timestamp = moment().tz('Asia/Kolkata').format('YYYY-MM-DD HH:mm:ss');
        return change.after.ref.update({timestamp});
    }
    })

    exports.countTrigger = functions.database
    .ref('/slots/week1/{type}/{slot}')
    .onWrite(async (change) => {
        const ref = change.after.ref;
        const countRef = ref.parent.child('count');

        let increment;
        if (change.after.exists() && !change.before.exists()){
            increment = 1;
        } else if (!change.after.exists() && change.before.exists()){
            increment = -1;
        } else{
            return null;
        }

        await countRef.transaction((current) => {
            return(current || 0) + increment;
        });

        return null;
    });
    
    // // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });
