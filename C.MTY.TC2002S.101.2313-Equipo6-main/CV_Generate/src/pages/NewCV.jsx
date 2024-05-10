import NavigationBar from '../components/NavBar';
import Form from 'react-bootstrap/Form';

import Button from 'react-bootstrap/Button';
import Col from 'react-bootstrap/Col';
import Row from 'react-bootstrap/Row';

import './styles.css';

import { BrowserRouter as Router, Route, Routes } from 'react-router-dom'
import { useState, useEffect } from "react";
import { collection, getDocs, addDoc } from "firebase/firestore";
import { db } from '../config/firebaseConfig';
import "firebase/auth";
import {v4 as uuidv4} from "uuid";
import firebase from 'firebase/compat/app';



function NewCV() {
        const [idcv, setIdCV] = useState(uuidv4());
        const [apellido, setLastName] = useState("")
        const [nombre, setFirstName] = useState("")
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
        const user = firebase.auth().currentUser;
        const userEmail = user.email;

    
        const createCV = async () => {
            // Consulta la colección 'users' para obtener datos existentes del usuario
            try {
              const userQuerySnapshot = await db
                .collection("users")
                .where("email", "==", userEmail)
                .get();
          
              if (!userQuerySnapshot.empty) {
                const userDoc = userQuerySnapshot.docs[0];
                const userData = userDoc.data();
                const nombre = userData.firstName || "";
                const apellido = userData.lastName || "";
                const gmail = userData.email || "";
                const Phone = userData.phone || "";
          
                setLastName(apellido);
                setFirstName(nombre);
                setCorreo(gmail);
                setPhone(Phone);
              }
            } catch (error) {
              console.error("Error al obtener datos del usuario: ", error);
            }
            try {
                const datoCV = {
                    email: correo,
                };
            
                const docRefColection = await db.collection("cv").add(datoCV);
                const idCreadoCV = docRefColection.id;
                console.log("cv agregado: ", idCreadoCV);

                const querySnapshot = await db.collection("CVColection").where("email", "==", userEmail).get();

                    // Comprueba si la consulta devolvió algún resultado
                    if (!querySnapshot.empty) {
                    // Supongamos que solo deseas actualizar el primer documento que cumple con la condición
                    const docRef = querySnapshot.docs[0].ref;

                    // Utiliza el método 'update' en el documento encontrado
                    await docRef.update({
                        idCV: firebase.firestore.FieldValue.arrayUnion(idCreadoCV),
                    });

                    console.log("ID de CV agregado al array correctamente");
                    } else {
                    console.error("No se encontraron documentos que cumplan con la condición.");
                    }



                console.log("Coleccion de cv agregado: ", docRefColection.id);
                
                const datoEducation = {
                    degree: degree,
                    graduation: graduationDate,
                    school: school,
                    idCV: idCreadoCV,
                };
                
                const docEduColection = await db.collection("Education").add(datoEducation);
                console.log("Dato de Educacion Agregado: ", docEduColection.id);

                const datoProjects = {
                    name: Name,
                    activities: ProjectActivities,
                    duration: ProjectDuration,
                    summary: ProjectSummary,
                    idCV: idCreadoCV,
                };
                const docProjectsColection = await db.collection("MajorProjects").add(datoProjects);
                console.log("Dato de Proyectos Agregado: ", docProjectsColection.id);

                const datoAwards = {
                    awardDes: AwardDescription,
                    idCV: idCreadoCV,
                };
                const docAwardsColection = await db.collection("Awards").add(datoAwards);
                console.log("Dato de Awards Agregado: ", docAwardsColection.id);

                const datoCourses = {
                    cName: CourseName,
                    institute: Institution,
                    year: Year,
                    idCV: idCreadoCV,
                };
                const docCoursesColection = await db.collection("Courses").add(datoCourses);
                console.log("Dato de cursos agregado: ", docCoursesColection.id);

                const datoPLang = {
                    Name: name,
                    idCV: idCreadoCV,
                };
                const docPLangColection = await db.collection("ProgrammingLanguages").add(datoPLang);
                console.log("Dato de lenguajes de programación agregado: ", docPLangColection.id);

                const datoTech = {
                    techName: TechName,
                    idCV: idCreadoCV,
                };
                const docTechColection = await db.collection("Technologies").add(datoTech);
                console.log("Dato de tecnologías agregado: ", docTechColection.id);

                const datoExp = {
                    city: City,
                    country: Country,
                    state: State,
                    activities: activities,
                    company: companyName,
                    position: position,
                    start: startDate,
                    end: endDate,
                    idCV: idCreadoCV,
                };
                const docExpColection = await db.collection("WorkExperience").add(datoExp);
                console.log("Dato de experiencia agregado: ", docExpColection.id);

                }

                catch (error) {
                console.error("Error al agregar cv: ", error);
                }
            }

           
          
          
    return (
        <>
            <NavigationBar />

            <div class="mainPage">
                <div className="row justify-content-center">
                    <div className="col-md-6">

                        <br />
                        <h1 className="display-4 text-center">Create CV</h1>
                        <br />

                        <h2>CV Name</h2>

                        <Form>
                            <Form.Group className="mb-3" controlId="exampleForm.ControlInput1">
                                <Form.Label>CV Name</Form.Label>
                                <Form.Control type="text" placeholder="CV for Intern Job" />
                            </Form.Group>
                        </Form>

                        <h2>Personal Information</h2>

                        <Form>
                            <Form.Group className="mb-3" controlId="exampleForm.ControlInput1">
                                <Form.Label>Phone Number</Form.Label>
                                <Form.Control type="text" placeholder="555-555-5555" onChange = {(event) => {
                                    setPhone(event.target.value);
                                }} />
                                <Form.Label>Github</Form.Label>
                                <Form.Control type="text" placeholder="githubuser" onChange = {(event) => {
                                    setGithub(event.target.value);
                                }} />
                            </Form.Group>
                        </Form>

                        <h2>Education</h2>
                        <Form>
                            <Row className="mb-3">
                                <Form.Group as={Col} controlId="formGridEmail">
                                    <Form.Label>Name</Form.Label>
                                    <Form.Control type="text" placeholder="Name of School" onChange = {(event) => {
                                    setSchool(event.target.value);
                                }} />
                                </Form.Group>

                                <Form.Group as={Col} controlId="formGridPassword">
                                    <Form.Label>Degree</Form.Label>
                                    <Form.Control type="text" placeholder="Degree" onChange = {(event) => {
                                    setDegree(event.target.value);
                                }}/>
                                </Form.Group>
                            
                                <Form.Group as={Col} controlId="formGridAddress1">
                                    <Form.Label>Graduation Date</Form.Label>
                                    <Form.Control placeholder="May 2025" onChange = {(event) => {
                                    setGraduation(event.target.value);
                                }}/>
                                </Form.Group>
                            </Row>
                        </Form>

                        <div className="d-grid gap-2">
                            <Button variant="primary" size="lg">Add Education</Button>
                        </div>
                        <br />


                        <h2>Work Experience</h2>

                        <Form>
                            <Row className="mb-3">
                                <Form.Group as={Col} controlId="formGridEmail">
                                <Form.Label>Name</Form.Label>
                                <Form.Control type="text" placeholder="Name of Company" onChange = {(event) => {
                                    setCompany(event.target.value);
                                }}/>
                                </Form.Group>

                                <Form.Group as={Col} controlId="formGridPassword">
                                <Form.Label>Position</Form.Label>
                                <Form.Control type="text" placeholder="Position" onChange = {(event) => {
                                    setPosition(event.target.value);
                                }}/>
                                </Form.Group>
                            </Row>

                            <Form.Group className="mb-3" controlId="formGridAddress1">
                                <Form.Label>Employment Date</Form.Label>
                                <Form.Control placeholder="August 2015" onChange = {(event) => {
                                    setStartDate(event.target.value);
                                }}/>
                            </Form.Group>

                            <Form.Group className="mb-3" controlId="formGridAddress1">
                                <Form.Label>End Date</Form.Label>
                                <Form.Control placeholder="Present" onChange = {(event) => {
                                    setEndDate(event.target.value);
                                }}/>
                            </Form.Group>

                            <Form.Group className="mb-3" controlId="exampleForm.ControlTextarea1">
                                    <Form.Label>Description</Form.Label>
                                    <Form.Control as="textarea" rows={3} onChange = {(event) => {
                                    setWorkActivities(event.target.value);
                                }}/>
                            </Form.Group>

                            <Row className="mb-3">
                                <Form.Group as={Col} controlId="formGridCity">
                                <Form.Label>City</Form.Label>
                                <Form.Control onChange = {(event) => {
                                    setCity(event.target.value);
                                }}/>
                                </Form.Group>

                                <Form.Group as={Col} controlId="formGridState">
                                <Form.Label>State</Form.Label>
                                <Form.Control onChange = {(event) => {
                                    setState(event.target.value);
                                }}/>
                                </Form.Group>

                                <Form.Group as={Col} controlId="formGridCountry">
                                <Form.Label>Country</Form.Label>
                                <Form.Control onChange = {(event) => {
                                    setCountry(event.target.value);
                                }}/>
                                </Form.Group>
                            </Row>

                        </Form>

                        <div className="d-grid gap-2">
                            <Button variant="primary" size="lg">Add Work Experience</Button>
                        </div>
                        <br />

                        <h2>Major Projects</h2>

                        <Form>
                            <Row className="mb-3">
                                <Form.Group as={Col} controlId="formGridEmail">
                                <Form.Label>Name</Form.Label>
                                <Form.Control type="text" placeholder="Name of Project" onChange = {(event) => {
                                    setName(event.target.value);
                                }}/>
                                </Form.Group>

                                <Form.Group as={Col} controlId="formGridPassword">
                                <Form.Label>Work Duration</Form.Label>
                                <Form.Control type="text" placeholder="June 2014 - July 2014" onChange = {(event) => {
                                    setDuration(event.target.value);
                                }}/>
                                </Form.Group>
                            </Row>

                            <Form.Group className="mb-3" controlId="formGridAddress1">
                                <Form.Label>Description</Form.Label>
                                <Form.Control placeholder="The project consists of..."onChange = {(event) => {
                                    setSummary(event.target.value);
                                }} />
                            </Form.Group>

                            <Form.Group className="mb-3" controlId="exampleForm.ControlTextarea1">
                                    <Form.Label>Notable Details</Form.Label>
                                    <Form.Control as="textarea" rows={3} onChange = {(event) => {
                                    setActivities(event.target.value);
                                }}/>
                            </Form.Group>
                        </Form>

                        <div className="d-grid gap-2">
                            <Button variant="primary" size="lg">Add Major Project</Button>
                        </div>
                        <br />

                        <h2>Skills</h2>

                        <Form>
                            <Form.Group className="mb-3" controlId="exampleForm.ControlInput1">
                                <Form.Group className="mb-3" controlId="exampleForm.ControlTextarea1">
                                    <Form.Label>Programing Languages</Form.Label>
                                    <Form.Control as="textarea" rows={3} onChange = {(event) => {
                                    setPLangName(event.target.value);
                                }}/>
                                </Form.Group>

                                <Form.Group className="mb-3" controlId="exampleForm.ControlTextarea1">
                                    <Form.Label>Awards</Form.Label>
                                    <Form.Control as="textarea" rows={3} onChange = {(event) => {
                                    setAwardDescription(event.target.value);
                                }}/>
                                </Form.Group>

                                <Form.Group className="mb-3" controlId="exampleForm.ControlTextarea1">
                                    <Form.Label>Technologies</Form.Label>
                                    <Form.Control as="textarea" rows={3} onChange = {(event) => {
                                    setTechName(event.target.value);
                                }}/>
                                </Form.Group>

                                <Form.Group className="mb-3" controlId="exampleForm.ControlTextarea1">
                                    <Form.Label>Online Courses</Form.Label>
                                    <Form.Control as="textarea" rows={3} onChange = {(event) => {
                                    setCourseName(event.target.value);
                                }}/>
                                </Form.Group>
                            </Form.Group>
                        </Form>

                        <br />
                        <div className="d-grid gap-2">
                            <Button variant="success" size="lg" onClick ={createCV} >Create CV</Button>
                        </div>
                        <br />


                    </div>
                </div>
            </div>
  
            
  
  
          
        
        </>
  
  
    );
  }
  
  
  export default NewCV;