/* eslint-disable react/prop-types */
import { Document, Page, View, Text, StyleSheet, Image, Link } from '@react-pdf/renderer';
import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';


// Estilos
const styles = StyleSheet.create({
  page: {
    fontFamily: 'Times-Roman',
    paddingTop: 30,
    paddingLeft: 40,
    paddingRight: 40,
    paddingBottom: 60,
  },
  section: {
    marginBottom: 20,
    padding: 10,
    backgroundColor: '#fff',
    borderRadius: 5,
    boxShadow: '0 2px 4px rgba(0, 0, 0, 0.2)',
  },
  row: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    padding: 10,
  },
  title: {
    fontSize: 16,
    fontWeight: 'bold',
    marginBottom: 10,
    textTransform: 'uppercase',
    borderBottom: '1pt solid #333',
    color: '#333',
  },
  nombre: {
    fontSize: 16,
    fontWeight: 'bold',
    marginBottom: 10,
    textTransform: 'uppercase',
    borderBottom: '1pt solid #333',
    color: '#333',
    textAlign: 'center',
  },
  subtitle: {
    fontSize: 14,
    fontWeight: 'bold',
    marginBottom: 5,
    color: '#555',
    boxShadow: '0 2px 4px rgba(0, 0, 0, 0.2)',
  },
  content: {
    fontSize: 11,
    marginBottom: 3,
    color: '#333',
  },
  contenti: {
    fontSize: 14,
    marginBottom: 3,
    color: '#333',
    fontWeight: 600,
  },
  contentc: {
    fontSize: 11,
    marginBottom: 3,
    color: '#333',
    textAlign: 'center',
  },
  contentr: {
    fontSize: 11,
    marginBottom: 3,
    color: '#333',
    textAlign: 'right',
  },
  separator: {
    borderBottomColor: '#333',
    borderBottomWidth: 1,
    marginTop: 10,
    marginBottom: 10,
  },
  certificadoContainer: {
    display: 'flex',
    flexDirection: 'row', // Alinear elementos en fila
    alignItems: 'center', // Alinear verticalmente al centro
    marginBottom: 10,
  },
  imageContainer: {
    flex: 1, // Ocupar 1/3 del espacio disponible
  },
  certificadoInfo: {
    flex: 2, // Ocupar 2/3 del espacio disponible
  },
});




// Create Document Component
const PDF = ({
  name, lastname, telefono, mail, github, 
  degree, graduation, school,
  city, country, state, activities, companyName, endDate, position, startDate,
  projectName, projectActivities, projectDuration, projectSummary,
  pLangName, 
  awardDescription,
  techName,
  courseName, institution, year
}) => (
  <Document>
    <Page size="A4" style={styles.page}>
      <View style={styles.section}>

        <Text style={styles.nombre}>{name} {lastname} </Text>
        <Text style={styles.contentr}>{telefono}</Text>
        <Text style={styles.contentr}>{mail}</Text>
        <Text style={styles.contentr}>{github}</Text>

      </View>

      <View style={styles.section}>

        <Text style={styles.title}>Education</Text>
        <View style={styles.row}>
          <Text style={styles.contenti}>{school}</Text>
          <Text style={styles.contentr}>{graduation}</Text>
        </View>
        <Text style={styles.content}>{degree}</Text>

      </View>

      <View style={styles.section}>

        <Text style={styles.title}>Work Experience</Text>

        <View style={styles.row}>
          <Text style={styles.contenti}>{companyName}</Text>
          <Text style={styles.contentr}>{city} {state} {country}</Text>
        </View>

        <View style={styles.row}>
          <Text style={styles.content}>{position}</Text>
          <Text style={styles.content}>{startDate} - {endDate}</Text>
        </View>

        <Text style={styles.content}>{activities}</Text>

      </View>

      <View style={styles.section}>

        <Text style={styles.title}>Major Projects</Text>
        
        <View style={styles.row}>
          <Text style={styles.contenti}>{projectName}</Text>
          <Text style={styles.contentr}>{projectDuration}</Text>
        </View>
        
        <Text style={styles.content}>{projectSummary}</Text>
        <Text style={styles.content}>{projectActivities}</Text>

      </View>

      <View style={styles.section}>
        <Text style={styles.title}>Skills</Text>

        <Text style={styles.subtitle}>Programming Languages</Text>
        <Text style={styles.content}>{pLangName}</Text>

        <Text style={styles.subtitle}>Awards</Text>
        <Text style={styles.content}>{awardDescription}</Text>

        <Text style={styles.subtitle}>Technologies</Text>
        <Text style={styles.content}>{techName}</Text>
      
        <Text style={styles.subtitle}>Online Courses</Text>
        <Text style={styles.content}>{courseName} - {institution} - {year}</Text>        
        
      </View>

      <Text
        style={{
          position: 'absolute',
          bottom: 30, // Ajusta la posición vertical según tu necesidad
          left: 0,
          right: 0,
          textAlign: 'center',
          fontSize: 10,
          color: '#777',
          }}>
      </Text>
    </Page>
  </Document>
);

export default PDF;