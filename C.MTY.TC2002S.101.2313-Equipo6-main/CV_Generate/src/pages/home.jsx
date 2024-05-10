import Button from 'react-bootstrap/Button';
import NavigationBar from '../components/NavBar';
import Stack from 'react-bootstrap/Stack';
import Card from 'react-bootstrap/Card';
import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import { PDFViewer } from '@react-pdf/renderer';
import PDF from '../components/PDF';
import './styles.css';
import { db } from '../config/firebaseConfig';
import { useState, useEffect } from "react";
import "firebase/auth";
import {v4 as uuidv4} from "uuid";
import firebase from 'firebase/compat/app';

function Home() {
    const [idcv, setIdCV] = useState("")
    const [lastName, setLastName] = useState("")
    const [firstName, setFirstName] = useState("")
    const [correo, setCorreo ] = useState("")
    const [phone, setPhone ] = useState("")
    const [github, setGithub ] = useState("")
    const [degree, setDegree ] = useState("")
    const [graduationDate, setGraduation ] = useState("")
    const [school, setSchool ] = useState("")
    const [Name, setName ] = useState("")
    const [ProjectActivities, setActivities ] = useState("")
    const [ProjectDuration, setDuration ] = useState("")
    const [ProjectSummary, setSummary ] = useState("")
    const [AwardDescription, setAwardDescription ] = useState("")
    const [CourseName, setCourseName ] = useState("")
    const [Institution, setInstitution ] = useState("")
    const [Year, setYear ] = useState("")
    const [name, setPLangName ] = useState("")
    const [yearsOfExperience, setYearsExperience ] = useState("")
    const [TechName, setTechName ] = useState("")
    const [City, setCity ] = useState("")
    const [Country, setCountry ] = useState("")
    const [State, setState ] = useState("")
    const [activities, setWorkActivities ] = useState("")
    const [companyName, setCompany ] = useState("")
    const [position, setPosition ] = useState("")
    const [startDate, setStartDate ] = useState("")
    const [endDate, setEndDate ] = useState("")
    const [index, setIndex] = useState(0); 


    const user = firebase.auth().currentUser;
    const userEmail = user.email;

    const deleteCV = async (index) => {
        try {
          // Verifica que userEmail tenga un valor definido
          if (!userEmail) {
            console.error("El valor de userEmail no está definido.");
            return;
          }
      
          // Consulta la colección 'CVColection' para encontrar el documento que contiene el array 'idCV'
          const querySnapshot = await db.collection("CVColection").where("email", "==", userEmail).get();
      
          // Comprueba si la consulta devolvió algún resultado
          if (!querySnapshot.empty) {
            // Supongamos que solo deseas actualizar el primer documento que cumple con la condición
            const docRef = querySnapshot.docs[0].ref;
      
            // Obtiene el array 'idCV' actual
            const currentIdCV = docRef.get("idCV");
      
            // Convierte el campo 'idCV' a un array si no lo es
            const idCVArray = Array.isArray(currentIdCV) ? currentIdCV : [];
      
            // Elimina el elemento deseado del array 'idCV' utilizando splice
            idCVArray.splice(index, 1);
      
            // Actualiza el documento en Firestore con el array 'idCV' modificado
            await docRef.update({
              idCV: idCVArray,
            });
      
            console.log("CV eliminado correctamente del array");
          } else {
            console.error("No se encontraron documentos que cumplan con la condición.");
          }
        } catch (error) {
          console.error("Error al eliminar CV del array:", error);
        }
      };


    const fetchData = async () => {
        try {
          // Consulta la colección 'todoList' en Firestore
            db.collection('users').where("email", "==", userEmail).onSnapshot((snapshot) => {
            if (!snapshot.empty) {
                const doc = snapshot.docs[0];
                const data = doc.data();
                const nombre = data?.firstName || '';
                const phone = data?.Phone || '';
                const apellido = data?.lastName || '';
                const gmail = data?.email || '';
                const Github = data?.github || '';
    
          
                setPhone(phone)
                setLastName(apellido)
                setFirstName(nombre)
                setCorreo(gmail)
                setGithub(Github)
            }});
            
            db.collection('CVColection').where("email", "==", userEmail).onSnapshot((snapshot) => {
                if (!snapshot.empty) {
                    const doc = snapshot.docs[0];
                    const data = doc.data();
                    // Verificamos si el campo 'idCV' existe y es un array
                    if (Array.isArray(data.idCV) && data.idCV.length > index) {
                        const elementoEnPosicionIndex = data.idCV[index];
    
                        setIdCV(elementoEnPosicionIndex)
                        // Realiza lo que necesites con el elemento en la posición index
                        console.log(elementoEnPosicionIndex);
                    } else {
                        setIdCV(elementoEnPosicionIndex)
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
                    const School = data?.school || '';
        
                    setDegree(degree)
                    setGraduation(graduation)
                    setSchool(School)
        
            }});
    
            db.collection('MajorProjects').where("idCV", "==", idcv).onSnapshot((snapshot) => {
                if (!snapshot.empty) {
                    const doc = snapshot.docs[0];
                    const data = doc.data();
                    const name = data?.Name || '';
                    const activities = data?.ProjectActivities || '';
                    const duration = data?.ProjectDuration || '';
                    const summary = data?.ProjectSummary || '';
        
                    setName(name)
                    setActivities(activities)
                    setDuration(duration)
                    setSummary(summary)
        
            }});
    
            db.collection('Awards').where("idCV", "==", idcv).onSnapshot((snapshot) => {
                if (!snapshot.empty) {
                    const doc = snapshot.docs[0];
                    const data = doc.data();
                    const awardDes = data?.AwardDescription || '';
        
                    setAwardDescription(awardDes)    
            }});
    
            db.collection('Courses').where("idCV", "==", idcv).onSnapshot((snapshot) => {
                if (!snapshot.empty) {
                    const doc = snapshot.docs[0];
                    const data = doc.data();
                    const cName = data?.CourseName || '';
                    const institute = data?.Institution || '';
                    const year = data?.Year || '';
        
                    setCourseName(cName)    
                    setInstitution(institute)   
                    setYear(year)   
            }});
    
            db.collection('ProgrammingLanguages').where("idCV", "==", idcv).onSnapshot((snapshot) => {
                if (!snapshot.empty) {
                    const doc = snapshot.docs[0];
                    const data = doc.data();
                    const Name = data?.name || '';
                    const yearsExp = data?.yearsOfExperience || '';
        
                    setPLangName(Name)    
                    setYearsExperience(yearsExp)   
            }});
    
            db.collection('Technologies').where("idCV", "==", idcv).onSnapshot((snapshot) => {
                if (!snapshot.empty) {
                    const doc = snapshot.docs[0];
                    const data = doc.data();
                    const techName = data?.TechName || '';
        
                    setTechName(techName)    
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
        
                    setCity(city)    
                    setCountry(country)   
                    setState(state)   
                    setWorkActivities(Activities)   
                    setCompany(company)   
                    setPosition(Position)
                    setStartDate(start)   
                    setEndDate(end)     
            }});
    
        } catch (error) {
          console.error('Error fetching todos:', error);
            }
          };

  return (
    <>
        
        <NavigationBar />

        <div  class="mainPage">

            

            <br />

            <h1 className="display-4 text-center">List of CVs</h1>

            <br />
        


            <div className="container">
                <div className="row justify-content-center">
                    <div className="col-md-6">

                    <Card>
                        <Card.Body>
                            <Card.Title>Titulo De CV</Card.Title>
                            <PDFViewer ><PDF name={firstName} lastname={lastName} telefono={phone} mail={correo} github={github} 
                            school={school} degree={degree} graduation={graduationDate}
                            companyName={companyName} position={position} startDate={startDate} endDate={endDate} city={City} country={Country} state={State} activities={activities}
                            projectName={Name} projectDuration={ProjectDuration} projectSummary={ProjectSummary} projectActivities={ProjectActivities} 
                            pLangName={name} awardDescription={AwardDescription} techName={TechName} courseName={CourseName} institution={Institution} year={Year}/></PDFViewer>
                            
                            
                            <Card.Text>
                                {' '}
                            </Card.Text>
                            <Button variant="primary" onClick={fetchData}>View CV</Button>{' '}
                            <Button variant="primary">Edit CV</Button>{' '}
                            <Button variant="success">Download CV PDF</Button>{' '}
                            <Button variant="success" onClick={() => deleteCV(index)}>Delete</Button>{' '}

                            <input
                            type="number"
                            placeholder="Enter index"
                            value={index}
                            onChange={(e) => setIndex(parseInt(e.target.value))}
                            />
                        </Card.Body>
                    </Card>



                    </div>
                </div>
            </div>
        </div>
            
      
    </>


  );
}


export default Home;



