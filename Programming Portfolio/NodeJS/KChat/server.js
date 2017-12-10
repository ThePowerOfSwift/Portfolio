var firebase = require('firebase-admin');
var request = require('request');
var FCM = require('fcm-node');

var API_KEY = "AAAAt1s_yAs:APA91bHvFDfCoR-DvrYl_MWtU6XiW0OhUBJF31WmIsZWrhx0qpAmoiA9BxqzZMVgUK-WIPduVHF_6LWot0TbKcZF_5sCd-62AzIYQjg6Jkglhz36GatOqMQUQ_MHoHmbke8DyduSJUYo";

var fcm = new FCM(API_KEY);

var serviceAccount = require("./kchat-3a393-firebase-adminsdk-z7xn2-31f767960d.json");
firebase.initializeApp({
  credential: firebase.credential.cert(serviceAccount),
  databaseURL: "https://kchat-3a393.firebaseio.com/"
});
ref = firebase.database().ref();



function listenForNotificationRequests() {
  var requests = ref.child('notificationRequests');
  requests.on('child_added', function(requestSnapshot) {
    var request = requestSnapshot.val();
    sendNotificationToUser(
      request.username, 
      request.message,
      function() {
        requestSnapshot.ref.remove();
      }
    );
  }, function(error) {
    console.error(error);
  });
};




function sendNotificationToUser(username, message, onSuccess) {
    var msg = {
        to: "/topics/user_"+username,
        notification: {
            sound: "default",
            badge: "2",
            title: "KChat Notification",
            body: message,
        },
        priority : 10,
        };

    fcm.send(msg, function(err, response){
        if (err) {
            console.log("Something has gone wrong!");
        } else {
            console.log("Successfully sent with response: ", response);
            onSuccess()
        }
    });
}

// start listening
listenForNotificationRequests();