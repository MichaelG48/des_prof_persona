<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PersonaManager.aspx.cs" Inherits="UTTT.Ejemplo.Persona.PersonaManager" debug=false%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="css/styles.css" rel="stylesheet" />
        
    </style>
</head>
<body>
    <div class="flex-container-message">
        <div id="boxMessage" class="alert alert-danger"></div>
        
        <asp:Label ID="lblMessage" class="alert alert-danger" runat="server" ForeColor="Red" Visible="false"></asp:Label>
    </div>
    <div class="flex-container">
        <form id="formularioPersona" name ="formularioPersona" runat="server">
            <div class="page-title">
                <h2>Persona</h2>
                <asp:Label ID="lblAccion" runat="server" Text="Accion" Font-Bold="True"></asp:Label>
            </div>

            <div class="flex-box">
                <label for="ddlSexo">Sexo</label>
                <asp:DropDownList ID="ddlSexo" runat="server" 
                    onselectedindexchanged="ddlSexo_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvSexo" runat="server" ControlToValidate="ddlSexo" ErrorMessage="Selecciona el sexo" InitialValue="-1" ValidationGroup="vgvVali"></asp:RequiredFieldValidator>
            </div>
        
            <div class="flex-box">
                <label for="txtClaveUnica" id="txtClaveUnica_lbl">Clave Unica</label>
                <asp:TextBox ID="txtClaveUnica" onkeyup="validateClave(this)" onchange="mostrarLabel(this)" placeholder="Clave" Font-Names="txtClaveUnica" runat="server" ViewStateMode="Disabled"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvClave" runat="server" ControlToValidate="txtClaveUnica" ErrorMessage="Campo obligatorio"></asp:RequiredFieldValidator>

                <asp:RangeValidator ID="rvClaveUnica" runat="server" ControlToValidate="txtClaveUnica" ErrorMessage="*La clave sebe ser un número entre 1 y 999" MaximumValue="999" MinimumValue="1" Type="Integer"></asp:RangeValidator>
            </div>

            <div class="flex-box">                
                <label for="txtNombre" id="txtNombre_lbl">Nombre</label>
                <asp:TextBox ID="txtNombre" onkeyup="validateText(this)" onchange="mostrarLabel(this)" placeholder="Nombre" runat="server" ViewStateMode="Disabled"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre" ErrorMessage="Campo obligatorio"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revNombre" runat="server" ControlToValidate="txtNombre" ErrorMessage="Incluir solo letras y espacios" ValidationExpression="[a-zA-Z ]{2,254}"></asp:RegularExpressionValidator>

            </div>

            <div class="flex-box">
                <label for="txtAPaterno" id="txtAPaterno_lbl">Apellido paterno</label>
                <asp:TextBox ID="txtAPaterno" onkeyup="validateText(this)" onchange="mostrarLabel(this)" placeholder="Apellido paterno" runat="server" ViewStateMode="Disabled"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvApellidoM" runat="server" ControlToValidate="txtAPaterno" ErrorMessage="Campo obligatorio"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revAMaterno" runat="server" ControlToValidate="txtAPaterno" ErrorMessage="Incluir solo letras y espacios" ValidationExpression="[a-zA-Z ]{2,254}"></asp:RegularExpressionValidator>
            </div>

            <div class="flex-box">
                <label for="txtAMaterno" id="txtAMaterno_lbl">Apellido materno</label>
                <asp:TextBox ID="txtAMaterno" onkeyup="validateText(this)" onchange="mostrarLabel(this)" placeholder="Apellido materno" runat="server" ViewStateMode="Disabled"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvApellidoP" runat="server" ControlToValidate="txtAMaterno" ErrorMessage="Campo obligatorio"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revAPaterno" runat="server" ControlToValidate="txtAMaterno" ErrorMessage="Incluir solo letras y espacios" ValidationExpression="[a-zA-Z ]{2,254}"></asp:RegularExpressionValidator>
            </div>

            <div class="flex-box">
                <label for="txtCurp" id="txtCurp_lbl">CURP</label>
                <asp:TextBox ID="txtCurp" onkeyup="validateCurp(this)" onchange="mostrarLabel(this)" placeholder="Curp" maxlength="18" runat="server" ViewStateMode="Disabled"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCurp" runat="server" ControlToValidate="txtCurp" ErrorMessage="Campo obligatorio"></asp:RequiredFieldValidator>
            </div>
            <div class="flex-box-btn">
                <asp:Button ID="btnAceptar" runat="server" Text="Aceptar" onclick="btnAceptar_Click" ViewStateMode="Disabled" />
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" onclick="btnCancelar_Click" ViewStateMode="Disabled" />
            </div>
        </form>
    </div>
</body>
</html>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<script type="text/javascript">
    let gbl_result = {
        'excep_message': '',
        'name_input': ''
    }

    window.onload = function () {
        enviarFrmProspecto()
    }

    const mostrarLabel = (input) => {
        if ($('#' + input.id).val() != '') {
            $('#' + input.id + '_lbl').css('color', 'black');
            $('#' + input.id + '_lbl').css('transition', 'all 800ms');
        } else {
            $('#' + input.id + '_lbl').css('color', 'transparent');
            $('#' + input.id + '_lbl').css('transition', 'all 800ms');
        }
    }

    // CONTROLA EL ENVÍO DEL FORMULARIO PARA HACER VALIDACIONES
    const enviarFrmProspecto = () => {
        $("#formularioPersona").submit(function (e) {
            datos = $(this).serializeArray();
            if (!validarFormualarioRegistro(datos)) {
                e.preventDefault();
                return false;
            }
        });
    }

    // VALIDA QUE LOS CAMPOS NO ESTÉN VACÍOS
    const validarFormualarioRegistro = (datos) => {
        try {
            $(datos).each(function (index, campo) {
                if (!campo.name.includes("__")) {
                    if (campo.value == '') {
                        gbl_result.excep_message = "FALTA EL CAMPO:"
                        gbl_result.input = $(`#${campo.name}`);
                        gbl_result.placeholder = $(`#${campo.name}`)[0].placeholder;
                        throw gbl_result;
                    }
                }
            });

            closeMessage();
            return true;
        } catch (error) {
            error.input.focus()
            showMessage(error)
            return false;
        }
    }

    // VALIDA EL CAMPO CLAVE
    const validateClave = (inputClave) => {
        try {
            if (isNaN(parseInt(inputClave.value))) {
                gbl_result.excep_message = `EL CAMPO <b>${inputClave.placeholder}</b> DEBE SER NUMERICO`
                gbl_result.input = inputClave;
                gbl_result.placeholder = "";
                throw gbl_result;
            }
            closeMessage();
        }
        catch (error) {
            inputClave.focus()
            showMessage(error)
            return false;
        }
    }

    // VALIDA QUE EL VALOR RECIBIDO SEA SOLO TEXTO
    const validateText = (inputText) => {
        try{
            const typeText = new RegExp("^[a-zA-Z ]+$");
            if (!typeText.test(inputText.value)) {
                gbl_result.excep_message = `EL CAMPO <b>${inputText.placeholder}</b> NO PUEDE CONTENER NÚMEROS Y NO PUEDE ESTAR VACÍO`
                gbl_result.input = inputText
                gbl_result.placeholder = "";
                throw gbl_result;
            }
            closeMessage();
        }
        catch (error) {
            inputText.focus()
            showMessage(error)
            return false;
        }
    }

    // VALIDA EL CAMPO CURP
    const validateCurp = (inputCurp) => {
        try {
            const typeText = new RegExp("^[a-zA-Z0-9]+$");
            if (!typeText.test(inputCurp.value)) {
                gbl_result.excep_message = `EL CAMPO <b>${inputCurp.placeholder}</b> NO PUEDE CONTENER ESPACIOS Y NO PUEDE ESTAR VACÍO`
                gbl_result.input = inputCurp
                gbl_result.placeholder = "";
                throw gbl_result;
            }
            $('#boxMessage').html(``)
        }
        catch (error) {
            inputCurp.focus()
            showMessage(error)
            return false;
        }
    }

    // MUESTRA UN MENSAJE DE ERROR
    const showMessage = (error) => {
        $('#boxMessage').show('fast');
        $('#boxMessage').html(`<p style="color:red;margin:0;padding:0;">${error.excep_message} <b>${error.placeholder}</b><span onclick="closeMessage()" style="cursor:pointer;font-size: 27px;color: black;display: contents;">X</span></p>`)
    }

    const closeMessage = () => {
        $('#boxMessage').hide('fast');
    }
</script>


