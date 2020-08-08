const username = document.getElementById("username");
const email = document.getElementById("email");
const pass = document.getElementById("pass");
const phone = document.getElementById("phone");
const dob = document.getElementById("dob");
const city = document.getElementById("city");
const state = document.getElementById("state");
const bg = document.getElementById("bg");
const bdonor = document.getElementById("donate");
const platdonor = document.getElementById("donate");
const plasdonor = document.getElementById("donate");

const button1 = document.getElementById("button1");

const database = firebase.firestore();

const usersCollection = database.collection('users');

button1.addEventListener("click", (e) => {
  e.preventDefault();
  usersCollection.doc(email.value).set({
      email: email.value,
      password: pass.value,
      phone: phone.value,
      dob:dob.value,
      city: city.value,
      state: state.value,
      "Blood Group": bg.value,
      blood_d: bdonor.value,
      Plate_d:platdonor.value,
      Plasma_d: plasdonor.value
  });
});
