<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PersonaManager.aspx.cs" Inherits="UTTT.Ejemplo.Persona.PersonaManager" debug=false%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<link href="Content/bootstrap.min.css" rel="stylesheet" />--%>
    <!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous" />
    <link href="css/styles.css" rel="stylesheet" />
</head>
<body>
    <div class="flex-container-message">
        <div id="boxMessage" class="alert alert-danger"></div>
        
        <asp:Label ID="lblMessage" class="alert alert-danger" runat="server" ForeColor="Red" Visible="false"></asp:Label>
    </div>
    <div class="flex-container">
        <form id="formularioPersona" name="formularioPersona" class="flex-form row" runat="server">
            <div class="page-title">
                <h2>Persona</h2>
                <asp:Label ID="lblAccion" runat="server" Text="Accion" Font-Bold="True"></asp:Label>
            </div>

            <div class="flex-box col-12 col-sm-12 col-md-5 col-lg-4">
                <label for="ddlSexo" id="ddlSexo_lbl">Sexo</label>
                <asp:ScriptManager ID="ScriptManager1" runat="server" />
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" class="select">
                    <ContentTemplate>
                        <asp:DropDownList ID="ddlSexo" runat="server" 
                            onselectedindexchanged="ddlSexo_SelectedIndexChanged">
                        </asp:DropDownList>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlSexo" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
                <asp:RequiredFieldValidator ID="rfvSexo" runat="server" ControlToValidate="ddlSexo" ErrorMessage="Selecciona el sexo" InitialValue="-1"></asp:RequiredFieldValidator>
            </div>
        
            <div class="flex-box col-12 col-sm-12 col-md-5 col-lg-4">
                <label for="txtClaveUnica" id="txtClaveUnica_lbl">Clave Unica</label>
                <asp:TextBox ID="txtClaveUnica" onkeyup="validateClave(this)" onchange="mostrarLabel(this)" placeholder="Clave" Font-Names="txtClaveUnica" runat="server" ViewStateMode="Disabled"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvClave" runat="server" ControlToValidate="txtClaveUnica" ErrorMessage="Campo obligatorio"></asp:RequiredFieldValidator>

                <asp:RangeValidator ID="rvClaveUnica" runat="server" ControlToValidate="txtClaveUnica" ErrorMessage="*La clave sebe ser un número entre 1 y 999" MaximumValue="999" MinimumValue="1" Type="Integer"></asp:RangeValidator>
            </div>

            <div class="flex-box col-12 col-sm-12 col-md-5 col-lg-4">
                <label for="txtNombre" id="txtNombre_lbl">Nombre</label>
                <asp:TextBox ID="txtNombre" onkeyup="validateText(this)" onchange="mostrarLabel(this)" placeholder="Nombre" runat="server" ViewStateMode="Disabled"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre" ErrorMessage="Campo obligatorio"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revNombre" runat="server" ControlToValidate="txtNombre" ErrorMessage="Incluir solo letras y espacios" ValidationExpression="[a-zA-Z ]{2,254}"></asp:RegularExpressionValidator>

            </div>

            <div class="flex-box col-12 col-sm-12 col-md-5 col-lg-4">
                <label for="txtAPaterno" id="txtAPaterno_lbl">Apellido paterno</label>
                <asp:TextBox ID="txtAPaterno" onkeyup="validateText(this)" onchange="mostrarLabel(this)" placeholder="Apellido paterno" runat="server" ViewStateMode="Disabled"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvApellidoM" runat="server" ControlToValidate="txtAPaterno" ErrorMessage="Campo obligatorio"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revAMaterno" runat="server" ControlToValidate="txtAPaterno" ErrorMessage="Incluir solo letras y espacios" ValidationExpression="[a-zA-Z ]{2,254}"></asp:RegularExpressionValidator>
            </div>

            <div class="flex-box col-12 col-sm-12 col-md-5 col-lg-4">
                <label for="txtAMaterno" id="txtAMaterno_lbl">Apellido materno</label>
                <asp:TextBox ID="txtAMaterno" onkeyup="validateText(this)" onchange="mostrarLabel(this)" placeholder="Apellido materno" runat="server" ViewStateMode="Disabled"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvApellidoP" runat="server" ControlToValidate="txtAMaterno" ErrorMessage="Campo obligatorio"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revAPaterno" runat="server" ControlToValidate="txtAMaterno" ErrorMessage="Incluir solo letras y espacios" ValidationExpression="[a-zA-Z ]{2,254}"></asp:RegularExpressionValidator>
            </div>

            <div class="flex-box col-12 col-sm-12 col-md-5 col-lg-4">
                <label for="txtCurp" id="txtCurp_lbl">CURP</label>
                <asp:TextBox ID="txtCurp" onkeyup="validateCurp(this)" onchange="mostrarLabel(this)" placeholder="Curp" maxlength="18" runat="server" ViewStateMode="Disabled"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCurp" runat="server" ControlToValidate="txtCurp" ErrorMessage="Campo obligatorio"></asp:RequiredFieldValidator>
            </div>
            
            <div class="flex-box">
                <label for="txtfechanacimiento" id="txtfechanacimiento_lbl">Fecha de nacimiento</label>
                <div class="flex-box-date">
                    <asp:textbox ID="txtfechanacimiento" placeholder="Fecha de nacimiento" runat="server"  ViewStateMode="Disabled"></asp:textbox>
                    <asp:imagebutton id="imgpopup" runat="server" alt="calendar" CausesValidation="false" imageurl="https://d1csarkz8obe9u.cloudfront.net/posterpreviews/calendar-design-template-98d00f49dd312fb1aac808b09f521f76_screen.jpg?ts=1633715910"/>
                    <ajaxtoolkit:calendarextender id="calendarextender1" popupbuttonid="imgpopup" runat="server" targetcontrolid="txtfechanacimiento" format="dd/MM/yyyy" />
                    <asp:requiredfieldvalidator id="rfvfechanac" runat="server" controltovalidate="txtfechanacimiento" errormessage="Campo obligatorio"></asp:requiredfieldvalidator>
                </div>
            </div>
            
            <div class="flex-box-btn col-12 col-sm-12 col-md-5 col-lg-4">
                <asp:Button ID="btnAceptar" runat="server" Text="Aceptar" OnClick="btnAceptar_Click" />
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" UseSubmitBehavior="false" OnClick="btnCancelar_Click" CausesValidation="false"/>
            </div>
        </form>
    </div>
</body>
</html>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous" type="text/javascript"></script>
<script src="Scripts/src/scripts.js" type="text/javascript"></script>

