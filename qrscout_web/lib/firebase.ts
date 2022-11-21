import firebase from 'firebase/app'
import 'firebase/auth'
import 'firebase/firestore'
import 'firebase/storage'
import 'firebase/database'

const firebaseConfig = {
    apiKey: "AIzaSyDkRIszZWIBuUmRsCLoCdnLsDDNdO3zAjc",
    authDomain: "qrscout.firebaseapp.com",
    projectId: "qrscout",
    storageBucket: "qrscout.appspot.com",
    messagingSenderId: "969041160175",
    appId: "1:969041160175:web:a5b4488791fa9b68a3f81a",
    measurementId: "G-B482R13MQT"
  };

    if (!firebase.apps.length) {
        firebase.initializeApp(firebaseConfig);
    }

    export const auth = firebase.auth();
    export const db = firebase.firestore();
    export const storage = firebase.storage();
    export const realtime = firebase.database();