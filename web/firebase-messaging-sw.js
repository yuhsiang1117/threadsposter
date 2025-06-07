// web/firebase-messaging-sw.js

importScripts('https://www.gstatic.com/firebasejs/10.12.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.12.0/firebase-messaging-compat.js');

firebase.initializeApp({
  apiKey: "AIzaSyBk4e1In1TyDwj6Zre4WyOGV6EasYHAw3c",
  authDomain: "final-project-db4d2.firebaseapp.com",
  projectId: "final-project-db4d2",
  messagingSenderId: "798765806641",
  appId: "1:798765806641:web:02a58ad86f6eb264a71110"
});

const messaging = firebase.messaging();
