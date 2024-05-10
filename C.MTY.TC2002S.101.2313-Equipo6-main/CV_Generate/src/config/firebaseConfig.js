import firebase from "firebase/compat/app";
import 'firebase/compat/auth'
import 'firebase/compat/firestore';

// Initialize Firebase
export const app = firebase.initializeApp( {
    apiKey: "AIzaSyDGEEEhUE4_KpTCc7m2FVLUqtUjW5yf-GQ",
    authDomain: "cv-semana-tec.firebaseapp.com",
    projectId: "cv-semana-tec",
    storageBucket: "cv-semana-tec.appspot.com",
    messagingSenderId: "622828699083",
    appId: "1:622828699083:web:0a24e29f86b763df73ca4e"
});

export const storage = firebase.storage;
export const db = firebase.firestore();
export const auth = firebase.auth()