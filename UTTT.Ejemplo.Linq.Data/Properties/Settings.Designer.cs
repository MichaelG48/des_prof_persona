﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Este código fue generado por una herramienta.
//     Versión de runtime:4.0.30319.42000
//
//     Los cambios en este archivo podrían causar un comportamiento incorrecto y se perderán si
//     se vuelve a generar el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace UTTT.Ejemplo.Linq.Data.Properties {
    
    
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("Microsoft.VisualStudio.Editors.SettingsDesigner.SettingsSingleFileGenerator", "16.8.1.0")]
    public sealed partial class Settings : global::System.Configuration.ApplicationSettingsBase {
        
        private static Settings defaultInstance = ((Settings)(global::System.Configuration.ApplicationSettingsBase.Synchronized(new Settings())));
        
        public static Settings Default {
            get {
                return defaultInstance;
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.SpecialSettingAttribute(global::System.Configuration.SpecialSetting.ConnectionString)]
        //[global::System.Configuration.DefaultSettingValueAttribute("data source=DESKTOP-E9IOU6G\\SQLEXPRESS;\ndatabase=Persona;\nIntegrated Security=SSP" +
        [global::System.Configuration.DefaultSettingValueAttribute("workstation id=dbpersonadw.mssql.somee.com;packet size=4096;user id=michael_00;pwd=michael_00;data source=dbpersonadw.mssql.somee.com;persist security info=False;initial catalog=dbpersonadw")]
        public string PersonaConnectionString {
            get {
                return ((string)(this["PersonaConnectionString"]));
            }
        }
    }
}
