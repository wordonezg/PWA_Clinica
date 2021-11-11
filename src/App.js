import "bootstrap/dist/css/bootstrap.min.css";
import axios from "axios";
import { Modal, ModalBody, ModalFooter, ModalHeader } from 'reactstrap';
import React from 'react';
import { Component } from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faEdit, faTrashAlt } from "@fortawesome/free-solid-svg-icons";
import logo from './assets/images/logo.svg';
import './assets/css/App.css';
import Menu from './Components/Menu';

const url = "https://localhost:44342/api/Cita";
const urlPost = "https://localhost:44342/api/Cita";
const urlPut = "https://localhost:44342/api/Cita";
const urlDelete = "https://localhost:44342/api/Cita";


class App extends Component {
  state = {
    mode:"online",
    data: [],
    modalInsertar: false,
    modalEliminar: false,
    form: {
      CodigoCita: 0,
      FechaHora: '',
      IdPaciente: 0,
      Nombres: '',
      Apellidos: '',
      IdClinica: 0,
      Clinica: '',
      FechaCita: '',
    },
    tipoModal: '',
  }

  modalEliminar = () => {
    this.setState({ modalEliminar: !this.state.modalEliminar });
  }

  modalInsertar = () => {
    this.setState({ modalInsertar: !this.state.modalInsertar });
  }

  seleccionarCita = (cita) => {
    this.setState({
      tipoModal: 'actualizar',
      form: {
        CodigoCita: cita.CodigoCita,
        FechaHora: cita.FechaHora,
        IdPaciente: cita.IdPaciente,
        IdClinica: cita.IdClinica,
        FechaCita: cita.FechaCita,
      }

    })
  }

  peticionesGet = () => {
    axios.get(url).then(response => {
      this.setState({ data: response.data });
    })
  }

  handleChange = async (e) => {
    e.persist();
    await this.setState({
      form: {
        ...this.state.form,
        [e.target.name]: e.target.value
      }
    });
  }

  peticionPost = async () => {
    delete this.state.form.CodigoCita;
    await axios.post(urlPost, this.state.form).then(response => {
      this.modalInsertar();
      this.peticionesGet();
    }).catch((error) => {
      console.log(error);
      localStorage.setItem("postData",JSON.stringify(this.state.form));
    });
  }

  peticionPut = async () => {
    console.log(this.state.form);
    await axios.put(urlPut + "/" + this.state.form.CodigoCita, this.state.form).then(response => {
      this.modalInsertar();
      this.peticionesGet();
    }).catch((error) => {
      console.log(error);
    });
  }

  peticionDelete = async () => {
    await axios.delete(urlDelete + "/" + this.state.form.CodigoCita).then(response => {
      this.modalEliminar();
      this.peticionesGet();
    }).catch((error) => {
      console.log(error);
    });
  }

  //Primera Carga
  componentDidMount() {
    
    axios.get(url).then(response => {
      this.setState({ data: response.data });
      localStorage.setItem("citas", JSON.stringify(response.data));
    }).catch(err => {
      let collection = JSON.parse(localStorage.getItem("citas"));
      this.setState({mode:'offline'});
      this.setState({ data: collection });
    })
  }

  componentDidUpdate(){
    
    let postData=JSON.parse(localStorage.getItem("postData"));
    if(postData!=null){
      console.log(postData);
      axios.post(urlPost,postData).then(response => {
        localStorage.removeItem("postData");
        this.modalInsertar();
        this.peticionesGet();
      }).catch((error) => {
        console.log(error);
        if(this.state.form.CodigoPaciente!=null){
          localStorage.setItem("postData",this.state.form);
        }
      });
    }
  }


  render() {
    const { form } = this.state;
    return (
      <React.Fragment>
        <Menu />
        <div className="App m-5">
          {this.state.mode==='offline'?
            <div className="alert alert-warning">offline mode</div>
            :null
          }
          <button type="button" className="btn btn-success" onClick={() => { this.setState({ form: null, tipoModal: 'insertar' }); this.modalInsertar() }}>Crear Cita</button>
          <table className="table">
            <thead>
              <tr>
                <th>Código</th>
                <th>Fecha Cita</th>
                <th>Paciente</th>
                <th>Clinica</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              {this.state.data.map(cita => {
                return (
                  <tr>
                    <td>{cita.CodigoCita}</td>
                    <td>{cita.FechaCita}</td>
                    <td>{cita.Nombres} {cita.Apellidos}</td>
                    <td>{cita.Clinica}</td>
                    <td>
                      <button type="button" className="btn btn-primary" onClick={() => { this.seleccionarCita(cita); this.modalInsertar(); }} ><FontAwesomeIcon icon={faEdit} /></button>
                      <button type="button" className="btn btn-danger" onClick={() => { this.seleccionarCita(cita); this.modalEliminar(); }}><FontAwesomeIcon icon={faTrashAlt} /></button>
                    </td>
                  </tr>
                )
              })}
            </tbody>
          </table>
          <Modal isOpen={this.state.modalInsertar}>
            <ModalHeader style={{ display: 'block' }}>
              <span style={{ float: 'right' }}>x</span>
            </ModalHeader>
            <ModalBody>
              <div className="form-group">
                {this.state.mode === 'offline' ?
                  <div className="alert alert-warning">offline mode</div>
                  : null
                }
                <label htmlFor="id">Codigo</label>
                <input className="form-control" type="text" name="CodigoCita" id="CodigoCita" readOnly value={form ? form.id_producto : this.state.data.length + 1} />

                <label htmlFor="producto">Fecha Cita</label>
                <input className="form-control" type="date" name="FechaCita" id="FechaCita" onChange={this.handleChange} value={form ? form.FechaCita : ''} />

                <label htmlFor="marca">Clinica</label>
                <select className="form-control" name="IdClinica" id="IdClinica" onChange={this.handleChange} value={form ? form.Clinica : 0}>
                  <option value="0">-- Seleccione --</option>
                  <option value="1">Rafel</option>
                  <option value="2">Esperanza</option>
                  <option value="3">La bendicion</option>
                  <option value="4">Santa Cruz</option>
                  <option value="5">Cruz Verde</option>
                </select>

                <label htmlFor="descripcion">Paciente</label>
                <input className="form-control" type="text" name="IdPaciente" id="IdPaciente" onChange={this.handleChange} value={form ? form.descripcion : ''} />


              </div>
            </ModalBody>
            <ModalFooter>
              {this.state.tipoModal == 'insertar' ?
                <button className="btn btn-success" onClick={() => this.peticionPost()}>
                  Insertar
                </button> : <button className="btn btn-primary" onClick={() => this.peticionPut()}>
                  Actualizar
                </button>
              }

              <button type="button" className="btn btn-dark" onClick={() => this.modalInsertar()}>Cancelar</button>

            </ModalFooter>
          </Modal>
          <Modal isOpen={this.state.modalEliminar}>
            <ModalBody>
              ¿Seguro que desea eliminar la cita {form && form.cita} ?
            </ModalBody>
            <ModalFooter>
              <button type="button" className="btn btn-danger" onClick={() => { this.peticionDelete() }}>Sí</button>
              <button type="button" className="btn btn-secondary" onClick={() => { this.modalEliminar(); }} >No</button>
            </ModalFooter>
          </Modal>
        </div>
      </React.Fragment>
    );
  }
}

export default App;

