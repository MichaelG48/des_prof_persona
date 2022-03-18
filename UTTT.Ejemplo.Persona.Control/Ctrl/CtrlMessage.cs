using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Text;

namespace UTTT.Ejemplo.Persona.Control.Ctrl
{
    public static class CtrlMessage
    {
        public static void showMessage(this System.Web.UI.Page _page, String _message)
        {
            _page.ClientScript.RegisterStartupScript(_page.GetType(),
                   Guid.NewGuid().ToString(),
                   "alert( '" + _message + "');", true);

            //_page.ClientScript.RegisterClientScriptBlock(_page.GetType(), "ClientScript", "<script type='text/javascript'> $(function(){ $('#dlgResultado').dialog({ modal: true, resizable: false, autoOpen: true, draggable: false, open: function(type, data){$(this).parent().appendTo('form')} }); }); </script>");

        }

        public static void showMessageException(this System.Web.UI.Page _page, String _message)
        {
            SendEmail("michael_glz48@outlook.es", _message);
            String mensaje = "Error de tipo " + _message + ". Ponerse en contacto con su administrador de sistema";
            _page.ClientScript.RegisterStartupScript(_page.GetType(),
                   "ClientScript",
                   "<SCRIPT>alert( '" + mensaje + "');</SCRIPT>");
        }

        private static void SendEmail(string EmailDestino, string exepMesssage)
        {
            string EmailOrigen = "michael.gonzalez1205@gmail.com";
            string Contrasena = "@Michael.48";
            MailMessage oMailMessage = new MailMessage(EmailOrigen, EmailDestino, "Exception Error",
                "<p>An error has ocurred in <a href='http://dw-prof.somee.com/PersonaPrincipal.aspx'>http://dw-prof.somee.com</a> </p><br>Details:<br>" + exepMesssage);

            oMailMessage.IsBodyHtml = true;

            SmtpClient oSmtpClient = new SmtpClient("smtp.gmail.com");
            oSmtpClient.EnableSsl = true;
            oSmtpClient.UseDefaultCredentials = false;
            oSmtpClient.Port = 587;
            oSmtpClient.Credentials = new System.Net.NetworkCredential(EmailOrigen, Contrasena);

            oSmtpClient.Send(oMailMessage);
            oSmtpClient.Dispose();
        }
    }
}
