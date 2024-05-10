import { BrowserRouter as Router, Route, Routes } from 'react-router-dom'
import SignIn from './pages/SignIn'
import SignUp from './pages/SignUp'
//import TypesExample from './pages/home'

import 'bootstrap/dist/css/bootstrap.min.css';

//import NavigationBar from './components/NavBar';
import Home from './pages/home';
import NewCV from './pages/NewCV';
import AuthCheck from './router/AuthCheck';
import Prueba from './pages/Prueba';


const App = () =>  {

    return (
      <div className="App">
        <Router>
          <Routes>
            <Route path='/' element={ <SignIn/> }/> 
            <Route path='/signup' element={ <SignUp/> }/> 
            <Route path='/home' element={ <AuthCheck><Home/></AuthCheck>  }/> 
            <Route path='/NewCV' element={  <AuthCheck><NewCV/></AuthCheck> }/> 
            <Route path='/prueba' element={ <Prueba/> }/> 

          </Routes>
        </Router>
      </div>
  )
  
}

export default App