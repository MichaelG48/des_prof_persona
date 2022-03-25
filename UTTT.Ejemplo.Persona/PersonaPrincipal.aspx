<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PersonaPrincipal.aspx.cs" Inherits="UTTT.Ejemplo.Persona.PersonaPrincipal"  debug=false%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="css/styles.css" rel="stylesheet" />

</head>
<body>
    <div class="flex-container">
        <div class="flex-box">
            <div class="page-title">
                <h2>Personas</h2>
            </div>

        </div>
        <div class="flex-box">
            <form id="form1" class="flex-form" runat="server">
                <div class="flex-content-options">
                    <div class="flex-group-searh">
                        <asp:TextBox ID="txtNombre" onchange="mostrarLabel(this)" runat="server" Width="174px" 
                            ViewStateMode="Disabled" placeholder="Buscar por nombre"></asp:TextBox>
                        
                        <asp:DropDownList ID="ddlSexo" runat="server">
                        </asp:DropDownList>

                        <asp:Button ID="btnBuscar" runat="server" Text="Buscar" 
                            onclick="btnBuscar_Click" ViewStateMode="Disabled" />
                    </div>
                    <div class="flex-group-select">
                    </div>
                    <div class="flex-group-searh">
                        <asp:Button ID="btnAgregar" runat="server" Text="Agregar" 
                            onclick="btnAgregar_Click" ViewStateMode="Disabled" />
                    </div>

                </div>

                <asp:GridView ID="dgvPersonas" runat="server" 
                    AllowPaging="True" AutoGenerateColumns="False" DataSourceID="DataSourcePersona" 
                    Width="1067px" CellPadding="3" GridLines="Horizontal" 
                    onrowcommand="dgvPersonas_RowCommand" BackColor="White" 
                    BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" 
                    ViewStateMode="Disabled">
                    <AlternatingRowStyle BackColor="#EEEEEE" />
                    <Columns>
                        <asp:BoundField DataField="strClaveUnica" HeaderText="Clave Unica" 
                            ReadOnly="True" SortExpression="strClaveUnica" />
                        <asp:BoundField DataField="strNombre" HeaderText="Nombre" ReadOnly="True" 
                            SortExpression="strNombre" />
                        <asp:BoundField DataField="strAPaterno" HeaderText="APaterno" ReadOnly="True" 
                            SortExpression="strAPaterno" />
                        <asp:BoundField DataField="strAMaterno" HeaderText="AMaterno" ReadOnly="True" 
                            SortExpression="strAMaterno" />
                        <asp:BoundField DataField="CatSexo" HeaderText="Sexo" 
                            SortExpression="CatSexo" />
                        <asp:BoundField DataField="strCurp" HeaderText="CURP" 
                            SortExpression="strCurp" />
                        <asp:BoundField DataField="dteFechaNac" HeaderText="Fecha de Nacimiento" 
                            SortExpression="dteFechaNac" />

                        <asp:TemplateField HeaderText="Editar">
                            <ItemTemplate>
                                <asp:ImageButton runat="server" ID="imgEditar" CommandName="Editar" CommandArgument='<%#Bind("id") %>' ImageUrl="https://jooinn.com/images/edit-1.png" />
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" Width="50px" />
                    
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Eliminar" Visible="True">
                            <ItemTemplate>
                                <asp:ImageButton runat="server" ID="imgEliminar" CommandName="Eliminar" CommandArgument='<%#Bind("id") %>' ImageUrl="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAclBMVEX///8AAAB9fX3o6Og9PT2dnZ3l5eXd3d36+vqZmZm8vLxubm6EhITHx8daWloSEhLw8PBiYmJCQkI3NzepqanQ0NCzs7Pf398gICCnp6dVVVXGxsYpKSlPT08JCQlnZ2dJSUmRkZF3d3cWFhYnJyeJiYkBCTsIAAAEg0lEQVR4nO2dbXeiMBBGRZQXrYoKqFVL0fr//+Ky6+meYyaWJCSZuPvczzCdW0aSjEFGI0dk8eJ2XkW9nJoyLVwl4ZC4vHz1233z2R65E9Ykaz/V9f5wXc+4k9agmGrq3dlXGXfmitRnI8GOccKduxK5qV/HtuLOvp/d+wDBjjz0Sk0nwwS7SuVW+Jl0M1Qwim7cEj9RnYYLdlcx3EItBpfonZZb5CljO4JRtOA2ecKQYeKRU8rtIiXdWzOMLkF+FI1nMjJCnIjPbApGEbcOpRg4lxEpuYUIsw95pqt5eayeMps+W2WdQ1sUF40szX2jsFio5ZKhXcRUeh3UxrUiv0pODu12KlvzbpQLrZKcfQ1srSi5Co3GRagkY2lYZVrQBCda1+BAb1TvrpI1QjIY1loBMslg4yhXM+ice6sZQXKrip2kash64CXsoEvLkNqLtMZWO90YdGUydZGqIQlpXqy1pyS0TEPq2KRbMbub9nidkAFn7iJVQ2h/Rr/CEvJfahxkago1PGjHiEml/3OGZAIOQ2sUcS8zYpgrnPVIRap0qRDDwgKkmjabSR9bMqv86j2HxCBfF1/7TzqP64Ezn6y12EBzw2RQ0yqx2j9zRT7AcMmdvBrac+C/1NypK/JhKpjp7jZgw7ROj8HfZb5ZGhq+SpFG0cZwyCi5E1dma/hdFQzDAYYwDB8Y/r+GrzPi631HImkJvQ5vSoa0vfs6qDWRYRgyMIRh+MAQhuEDQxiGDwxhGD6KhmRTxOugZpjt0gd2C6J8FA75iaqePqecqQdKk7mYx03Mw7C7H5OHfZj21JH9gbb2hVFDpu27MDQGht6AoTEw9AYMjYGhN2BoDAy9AUNjFAwLEbI7uf+IrPcITsPb+pGG/M7MWDjiXTwiOywfj1iS5544DclzTyQ72icQDd/EI8ieSk5DcTPxihiSGOIzwtSQ5A9DGMIQhjCEIQxhCEMYwhCGMIQhDGEIQxjCEIYwhCEMYQhDGMIQhjCEIQxhCEMYwhCGMIQhDGEIQxjCEIYwhCEMYQhDGMIQhjCEIQxhCEMYwhCGMIQhDGEIQxjCEIYwhCEMYQhDGMIQhjCEIQxhCEMYwhCGMIShC0MbvyNM8g/qd4TJG4924hGlcEBOYhzFGPT3pBkN/QBDY2DoDRgaA0NvwNAYakjGcz8Qw4OlwPGnGFmccXmicWVYrMXIb5Yi6xGTF6SWliLTOfG5sBRai9mHkMYHmd+bMhUNo9pWaA0yUkonMjc3pSaGK3F154EbycJeKVX0/bl7a/8+RTJaSNHcXniywO0Ub14/iwtSopG9W+lI9kH8zWSc+6FtxHvMHXuCo0L6B7hZWjQknaYgsHq3S7ltJMzJW8uGQFt97FwtTx3TE7eRiMWh4g4d9XnZ2xYcjcir21lZOVjexJJhnw/SD7dBEpCiE8FOkazPuHC2Pt0FchVzqyPhIy23XMfW7bKmJj0b34xdt8EK+TrDF/vKYYV+k+Vn+WLGOV+NryZfMWv9LzZOl4PXvkKxq+r2MvfEOD+miYfyBICLX1BYqdSs+Gj/AAAAAElFTkSuQmCC" OnClientClick="javascript:return confirm('¿Está seguro de querer eliminar el registro seleccionado?', 'Mensaje de sistema')"/>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="50px" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Direccion">
                            <ItemTemplate>
                                <asp:ImageButton runat="server" ID="imgDireccion" CommandName="Direccion" CommandArgument='<%#Bind("id") %>' ImageUrl="https://cdn3.iconfinder.com/data/icons/unicons-vector-icons-pack/32/location-512.png" />
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="50px" />
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <HeaderStyle BackColor="black" Font-Bold="True" ForeColor="#F7F7F7" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <RowStyle BackColor="#FFFFFF" ForeColor="#4A3C8C" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <SortedAscendingCellStyle BackColor="#F4F4FD" />
                    <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
                    <SortedDescendingCellStyle BackColor="#D8D8F0" />
                    <SortedDescendingHeaderStyle BackColor="#3E3277" />
                </asp:GridView>

                <asp:LinqDataSource ID="DataSourcePersona" runat="server" 
                    ContextTypeName="UTTT.Ejemplo.Linq.Data.Entity.DcGeneralDataContext" 
                    onselecting="DataSourcePersona_Selecting" 
                    Select="new (strNombre, strAPaterno, strAMaterno, CatSexo, strClaveUnica, id, strCurp, dteFechaNac)" 
                    TableName="Persona" EntityTypeName="">
                </asp:LinqDataSource>
            </form>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous" type="text/javascript"></script>
    <script src="Scripts/src/scripts.js" type="text/javascript"></script>

</body>
</html>
