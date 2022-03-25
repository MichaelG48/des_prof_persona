<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="UTTT.Ejemplo.Persona.Error" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <h2>Ha ocurrido un error inesperado</h2>
    <p>Vuela a intentarlo, si el problema continua, contacte al administrador</p>
    <asp:HyperLink NavigateUrl="~/PersonaPrincipal.aspx" Text="Volver" runat="server" /> 
</body>
</html>
