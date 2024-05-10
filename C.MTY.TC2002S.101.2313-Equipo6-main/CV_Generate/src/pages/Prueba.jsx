import { BrowserRouter as Router, Route, Routes } from 'react-router-dom'
import { useState, useEffect } from "react";
import { collection, getDocs } from "firebase/firestore";
import { db } from '../config/firebaseConfig';

function Prueba() {
  const [users, setDatos] = useState([]);
  const [cv, setCV] = useState([]);
  const [Education, setEducation] = useState([]);
  const [MajorProjects, setMajorProjects] = useState([]);
  const [Skills, setSkills] = useState([]);
  const [Awards, setAwards] = useState([]);
  const [Courses, setCourses] = useState([]);
  const [ProgrammingLanguages, setPLanguage] = useState([]);
  const [Technologies, setTech] = useState([]);
  const [WorkExperience, setExperience] = useState([]);

  const [idcv, setIdCV] = useState("")
  const [email, setEmail] = useState("");
  const [firstname, setFirstName] = useState("");
  const [lastname, setLastName] = useState("");

  const usersCollectionRef = collection(db, "users")
  const cvCollectionRef = collection(db, "cv")
  const eduCollectionRef = collection(db, "Education")
  const proCollectionRef = collection(db, "MajorProjects")
  const skillCollectionRef = collection(db, "Skills")
  const awardsCollectionRef = collection(db, "Awards")
  const coursesCollectionRef = collection(db, "Courses")
  const plangCollectionRef = collection(db, "ProgrammingLanguages")
  const techCollectionRef = collection(db, "Technologies")
  const expCollectionRef = collection(db, "WorkExperience")

  const userEmail = "tadeo34.barrera@gmail.com"

  const fetchData = async () => {
    try {
      // Consulta la colección 'todoList' en Firestore
        db.collection('users').where("email", "==", userEmail).onSnapshot((snapshot) => {
        if (!snapshot.empty) {
            const doc = snapshot.docs[0];
            const data = doc.data();
            const nombre = data?.firstName || '';
            const apellido = data?.lastName || '';
            const gmail = data?.email || '';

            console.log(nombre)
            console.log(apellido)
            console.log(gmail)

        }});
        
        db.collection('CVColection').where("email", "==", userEmail).onSnapshot((snapshot) => {
            if (!snapshot.empty) {
                const doc = snapshot.docs[0];
                const data = doc.data();
                const index = 0;
                // Verificamos si el campo 'idCV' existe y es un array
                if (Array.isArray(data.idCV) && data.idCV.length > index) {
                    const elementoEnPosicionIndex = data.idCV[index];

                    setIdCV(elementoEnPosicionIndex)
                    // Realiza lo que necesites con el elemento en la posición index
                    console.log(elementoEnPosicionIndex);
                } else {
                    console.log('El campo "idCV" no existe o la posición index está fuera de rango.');
                }
            }
        });

        db.collection('Education').where("idCV", "==", idcv).onSnapshot((snapshot) => {
            if (!snapshot.empty) {
                const doc = snapshot.docs[0];
                const data = doc.data();
                const degree = data?.degree || '';
                const graduation = data?.graduationDate || '';
                const school = data?.school || '';
    
                console.log(degree)
                console.log(graduation)
                console.log(school)
    
        }});

        db.collection('MajorProjects').where("idCV", "==", idcv).onSnapshot((snapshot) => {
            if (!snapshot.empty) {
                const doc = snapshot.docs[0];
                const data = doc.data();
                const name = data?.Name || '';
                const activities = data?.ProjectActivities || '';
                const duration = data?.ProjectDuration || '';
                const summary = data?.ProjectSummary || '';
    
                console.log(name)
                console.log(activities)
                console.log(duration)
                console.log(summary)
    
        }});

        db.collection('Awards').where("idCV", "==", idcv).onSnapshot((snapshot) => {
            if (!snapshot.empty) {
                const doc = snapshot.docs[0];
                const data = doc.data();
                const awardDes = data?.AwardDescription || '';
    
                console.log(awardDes)    
        }});

        db.collection('Courses').where("idCV", "==", idcv).onSnapshot((snapshot) => {
            if (!snapshot.empty) {
                const doc = snapshot.docs[0];
                const data = doc.data();
                const cName = data?.CourseName || '';
                const institute = data?.Institution || '';
                const year = data?.Year || '';
    
                console.log(cName)    
                console.log(institute)   
                console.log(year)   
        }});

        db.collection('ProgrammingLanguages').where("idCV", "==", idcv).onSnapshot((snapshot) => {
            if (!snapshot.empty) {
                const doc = snapshot.docs[0];
                const data = doc.data();
                const Name = data?.name || '';
                const yearsExp = data?.yearsOfExperience || '';
    
                console.log(Name)    
                console.log(yearsExp)   
        }});

        db.collection('Technologies').where("idCV", "==", idcv).onSnapshot((snapshot) => {
            if (!snapshot.empty) {
                const doc = snapshot.docs[0];
                const data = doc.data();
                const techName = data?.Name || '';
    
                console.log(techName)    
        }});

        db.collection('WorkExperience').where("idCV", "==", idcv).onSnapshot((snapshot) => {
            if (!snapshot.empty) {
                const doc = snapshot.docs[0];
                const data = doc.data();
                const city = data?.City || '';
                const country = data?.Country || '';
                const state = data?.State || '';
                const Activities = data?.activities || '';
                const company = data?.companyName || '';
                const Position = data?.position || '';
                const start = data?.startDate || '';
                const end = data?.endDate || '';
    
                console.log(city)    
                console.log(country)   
                console.log(state)   
                console.log(Activities)   
                console.log(company)   
                console.log(Position)
                console.log(start)   
                console.log(end)     
        }});

    } catch (error) {
      console.error('Error fetching todos:', error);
        }
      };

  useEffect(() => {


    fetchData()

    const getDatos = async () => {
      const data = await getDocs(usersCollectionRef)
      setDatos(data.docs.map((doc) => ({...doc.data(), id: doc.id})));
    };
    getDatos();
    
    const getCV = async () =>{
      const cvData = await getDocs(cvCollectionRef)
      setCV(cvData.docs.map((doc) => ({...doc.data(), id: doc.id})));
    };
    getCV();

    const getEducation = async () =>{
      const eduData = await getDocs(eduCollectionRef)
      setEducation(eduData.docs.map((doc) => ({...doc.data(), id: doc.id})));
    };
    getEducation();

    const getMajorProjects = async () =>{
      const proData = await getDocs(proCollectionRef)
      setMajorProjects(proData.docs.map((doc) => ({...doc.data(), id: doc.id})));
    };
    getMajorProjects();

    const getSkills = async () =>{
      const skillData = await getDocs(skillCollectionRef)
      setSkills(skillData.docs.map((doc) => ({...doc.data(), id: doc.id})));
    };
    getSkills();

    const getAwards = async () =>{
      const awardData = await getDocs(awardsCollectionRef)
      setAwards(awardData.docs.map((doc) => ({...doc.data(), id: doc.id})));
    };
    getAwards();

    const getCourses = async () =>{
      const courseData = await getDocs(coursesCollectionRef)
      setCourses(courseData.docs.map((doc) => ({...doc.data(), id: doc.id})));
    };
    getCourses();

    const getProgrammingLanguage = async () =>{
      const plangData = await getDocs(plangCollectionRef)
      setPLanguage(plangData.docs.map((doc) => ({...doc.data(), id: doc.id})));
    };
    getProgrammingLanguage();

    const getTech = async () =>{
      const techData = await getDocs(techCollectionRef)
      setTech(techData.docs.map((doc) => ({...doc.data(), id: doc.id})));
    };
    getTech();

    const getWorkExperience = async () =>{
      const expData = await getDocs(expCollectionRef)
      setExperience(expData.docs.map((doc) => ({...doc.data(), id: doc.id})));
    };
    getWorkExperience();
  }, []);
  {cv.map((curriculum) => {
  
  })}
  
  return (
    <div className ="App">
      {cv.map((curriculum) => {
        return (
          <div>
            {" "}
            <h1>Email: {curriculum.email}</h1>
          </div>
        );
      })}

      {users.map((user) => {
        return (
          <div>
            {" "}
            <h1>Git: {user.github}</h1>
            <h1>Tel: {user.telefono}</h1>
          </div>
        );
      })}

      {Education.map((edu) => {
        return (
          <div>
            {" "}
            <h1>Degree: {edu.degree}</h1>
            <h1>School: {edu.school}</h1>
          </div>
        );
      })}

      {MajorProjects.map((pro) => {
        return (
          <div>
            {" "}
            <h1>Name: {pro.Name}</h1>
            <h1>Activities: {pro.ProjectActivities}</h1>
          </div>
        );
      })}

      {Skills.map((ski) => {
        return (
          <div>
            {" "}
            <h1>Courses1: {ski.Courses1}</h1>
            <h1>test: {ski.test}</h1>
          </div>
        );
      })}

      {Awards.map((award) => {
        return (
          <div>
            {" "}
            <h1>Description: {award.AwardDescription}</h1>
          </div>
        );
      })}

      {Courses.map((course) => {
        return (
          <div>
            {" "}
            <h1>CourseName: {course.CourseName}</h1>
            <h1>Institution: {course.Institution}</h1>
            <h1>Year: {course.Year}</h1>
          </div>
        );
      })}

      {ProgrammingLanguages.map((lang) => {
        return (
          <div>
            {" "}
            <h1>LanguageName: {lang.name}</h1>
            <h1>YearsOfExperience: {lang.yearsOfExperience}</h1>
          </div>
        );
      })}
      
      {Technologies.map((tech) => {
        return (
          <div>
            {" "}
            <h1>Name: {tech.Name}</h1>
          </div>
        );
      })}

      {WorkExperience.map((exp) => {
        return (
          <div>
            {" "}
            <h1>City: {exp.City}</h1>
            <h1>Country: {exp.Country}</h1>
            <h1>State: {exp.State}</h1>
            <h1>Activities: {exp.activities}</h1>
            <h1>Position: {exp.position}</h1>
          </div>
        );
      })}
    </div>
  )


  /*
  return (
    <>
     <Router>
          <Routes>
            <Route path='/' element={ <SignIn/> }/> 
            <Route path='/signup' element={ <SignUp/> }/> 
          </Routes>
      </Router>
    </>
  )
  */
}

export default Prueba
