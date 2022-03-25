#region Using

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UTTT.Ejemplo.Linq.Data.Entity;
using System.Data.Linq;
using System.Linq.Expressions;
using System.Collections;
using UTTT.Ejemplo.Persona.Control;
using UTTT.Ejemplo.Persona.Control.Ctrl;
using System.Net.Mail;
using System.Globalization;

#endregion

namespace UTTT.Ejemplo.Persona
{
    public partial class PersonaManager : System.Web.UI.Page
    {
        #region Variables

        private SessionManager session = new SessionManager();
        private int idPersona = 0;
        private UTTT.Ejemplo.Linq.Data.Entity.Persona baseEntity;
        private DataContext dcGlobal = new DcGeneralDataContext();
        private int tipoAccion = 0;

        #endregion

        #region Eventos

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                this.Response.Buffer = true;
                this.session = (SessionManager)this.Session["SessionManager"];
                this.idPersona = this.session.Parametros["idPersona"] != null ?
                    int.Parse(this.session.Parametros["idPersona"].ToString()) : 0;
                if (this.idPersona == 0)
                {
                    this.baseEntity = new Linq.Data.Entity.Persona();
                    this.tipoAccion = 1;
                }
                else
                {
                    this.baseEntity = dcGlobal.GetTable<Linq.Data.Entity.Persona>().First(c => c.id == this.idPersona);
                    this.tipoAccion = 2;
                }

                if (!this.IsPostBack)
                {
                    if (this.session.Parametros["baseEntity"] == null)
                    {
                        this.session.Parametros.Add("baseEntity", this.baseEntity);
                    }
                    List<CatSexo> lista = dcGlobal.GetTable<CatSexo>().ToList();                  
                    this.ddlSexo.DataTextField = "strValor";
                    this.ddlSexo.DataValueField = "id";
                    
                    if (this.idPersona == 0)
                    {
                        this.lblAccion.Text = "Agregar";
                        //CalendarExtender1.SelectedDate = DateTime.Now;

                        CatSexo catTemp = new CatSexo();
                        catTemp.id = -1;
                        catTemp.strValor = "Seleccionar";
                        lista.Insert(0, catTemp);
                        this.ddlSexo.DataSource = lista;
                        this.ddlSexo.DataBind();
                    }
                    else
                    {
                        this.lblAccion.Text = "Editar";
                        this.txtNombre.Text = this.baseEntity.strNombre;
                        this.txtAPaterno.Text = this.baseEntity.strAPaterno;
                        this.txtAMaterno.Text = this.baseEntity.strAMaterno;
                        this.txtClaveUnica.Text = this.baseEntity.strClaveUnica;
                        this.txtCurp.Text = this.baseEntity.strCurp;

                        calendarextender1.SelectedDate = Convert.ToDateTime(this.baseEntity.dteFechaNac);

                        this.ddlSexo.DataSource = lista;
                        this.ddlSexo.DataBind();
                        this.setItem(ref this.ddlSexo, baseEntity.CatSexo.strValor);
                    }                
                }

            }
            catch (Exception _e)
            {
                this.showMessage("Ha ocurrido un problema al cargar la página");
                this.Response.Redirect("~/PersonaPrincipal.aspx", false);
            }

        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            try
            {
                //rfvSexo.Validate();
                //rfvClave.Validate();
                //rfvNombre.Validate();
                //rfvApellidoM.Validate();
                //rfvApellidoP.Validate();
                //rfvCurp.Validate();

                //rvClaveUnica.Validate();
                //revNombre.Validate();
                //revAMaterno.Validate();
                //revAPaterno.Validate();

                DataContext dcGuardar = new DcGeneralDataContext();
                UTTT.Ejemplo.Linq.Data.Entity.Persona persona = new Linq.Data.Entity.Persona();
                if (this.idPersona == 0)
                {
                    persona.strClaveUnica = this.txtClaveUnica.Text.Trim();
                    persona.strNombre = this.txtNombre.Text.Trim();
                    persona.strAMaterno = this.txtAMaterno.Text.Trim();
                    persona.strAPaterno = this.txtAPaterno.Text.Trim();
                    persona.strCurp = this.txtCurp.Text.Trim();
                    persona.idCatSexo = int.Parse(this.ddlSexo.Text);

                    string date = Request.Form[this.txtfechanacimiento.UniqueID];

                    persona.dteFechaNac = Request.Form[this.txtfechanacimiento.UniqueID];

                    String mensaje = String.Empty;
                    if (!this.validateInputs(persona, ref mensaje))
                    {
                        this.lblMessage.Text = mensaje;
                        this.lblMessage.Visible = true;
                        return;
                    }

                    dcGuardar.GetTable<UTTT.Ejemplo.Linq.Data.Entity.Persona>().InsertOnSubmit(persona);
                    dcGuardar.SubmitChanges();
                    this.showMessage("El registro se agregó correctamente.");
                    this.Response.Redirect("~/PersonaPrincipal.aspx", false);
                }
                if (this.idPersona > 0)
                {
                    var personaUpdate = (from Persona in dcGuardar.GetTable<UTTT.Ejemplo.Linq.Data.Entity.Persona>()
                                 where Persona.id == idPersona
                                 select Persona).FirstOrDefault();

                    personaUpdate.strClaveUnica = this.txtClaveUnica.Text.Trim();
                    personaUpdate.strNombre = this.txtNombre.Text.Trim();
                    personaUpdate.strAMaterno = this.txtAMaterno.Text.Trim();
                    personaUpdate.strAPaterno = this.txtAPaterno.Text.Trim();
                    personaUpdate.strCurp = this.txtCurp.Text.Trim();
                    personaUpdate.idCatSexo = int.Parse(this.ddlSexo.Text);

                    string date = Request.Form[this.txtfechanacimiento.UniqueID];

                    personaUpdate.dteFechaNac = Request.Form[this.txtfechanacimiento.UniqueID];

                    String mensaje = String.Empty;
                    if (!this.validateInputs(personaUpdate, ref mensaje))
                    {
                        this.lblMessage.Text = mensaje;
                        this.lblMessage.Visible = true;
                        return;
                    }

                    dcGuardar.SubmitChanges();
                    this.showMessage("El registro se editó correctamente.");
                    this.Response.Redirect("~/PersonaPrincipal.aspx", false);
                }
            }
            catch (Exception _e)
            {
                this.showMessageException(_e.Message);
            }
        }
        
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            try
            {              
                this.Response.Redirect("~/PersonaPrincipal.aspx", false);
            }
            catch (Exception _e)
            {
                this.showMessage("Ha ocurrido un error inesperado");
            }
        }

        protected void ddlSexo_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                int idSexo = int.Parse(this.ddlSexo.Text);
                Expression<Func<CatSexo, bool>> predicateSexo = c => c.id == idSexo;
                predicateSexo.Compile();
                List<CatSexo> lista = dcGlobal.GetTable<CatSexo>().Where(predicateSexo).ToList();
                CatSexo catTemp = new CatSexo();            
                this.ddlSexo.DataTextField = "strValor";
                this.ddlSexo.DataValueField = "id";
                this.ddlSexo.DataSource = lista;
                this.ddlSexo.DataBind();
            }
            catch (Exception)
            {
                this.showMessage("Ha ocurrido un error inesperado");
            }
        }

        #endregion

        #region Metodos

        public void setItem(ref DropDownList _control, String _value)
        {
            foreach (ListItem item in _control.Items)
            {
                if (item.Value == _value)
                {
                    item.Selected = true;
                    break;
                }
            }
            _control.Items.FindByText(_value).Selected = true;
        }

        public bool validateInputs(UTTT.Ejemplo.Linq.Data.Entity.Persona _persona, ref String _mensaje)
        {
            if (_persona.idCatSexo == -1)
            {
                _mensaje = "Seleccione Masculino o Femenino";
                return false;
            }
            int i = 0;
            if (int.TryParse(_persona.strClaveUnica, out i) == false)
            {
                _mensaje = "La Clave Unica no es un número";
                return false;
            }
            if (int.Parse(_persona.strClaveUnica) < 100 || int.Parse(_persona.strClaveUnica) > 999)
            {
                _mensaje = "La Clave Unica debe ser un número entre 100 y 999";
                return false;
            }
            if (_persona.strNombre.Equals(String.Empty))
            {
                _mensaje = "Debe capturar el nombre";
                return false;
            }
            if (_persona.strNombre.Length > 50)
            {
                _mensaje = "Los caracteres permitidos para nombre rebasan lo establecido de 50";
                return false;
            }
            if (_persona.strNombre.Length < 3)
            {
                _mensaje = "El nombre no es válido";
                return false;
            }

            if (_persona.strAPaterno.Equals(String.Empty))
            {
                _mensaje = "Debe capturar el apellido paterno";
                return false;
            }

            if (_persona.strAPaterno.Length > 50)
            {
                _mensaje = "Los caracteres permitidos para nombre rebasan lo establecido de 50 para el apellido paterno";
                return false;
            }
            if (_persona.strAPaterno.Length < 3)
            {
                _mensaje = "El apellido paterno no  es  válido";
                return false;
            }
            if (_persona.strAMaterno.Equals(String.Empty))
            {
                _mensaje = "Debe capturar el apellido materno";
                return false;
            }

            if (_persona.strAMaterno.Length > 50)
            {
                _mensaje = "Los caracteres permitidos para nombre rebasan lo establecido de 50 para A Materno";
                return false;
            }
            if (_persona.strAMaterno.Length < 3)
            {
                _mensaje = "El apellido materno no es válido";
                return false;
            }
            if (_persona.strCurp.Equals(String.Empty))
            {
                _mensaje = "Debe capturar la CURP";
                return false;
            }

            if (_persona.strCurp.Length > 50)
            {
                _mensaje = "Los caracteres permitidos para Curp rebasan lo establecido de 50";
                return false;
            }
            if (_persona.strCurp.Length < 18)
            {
                _mensaje = "Ingrese una CURP de 18 dígitos";
                return false;
            }
            return true;

        }

        
        #endregion
    }
}