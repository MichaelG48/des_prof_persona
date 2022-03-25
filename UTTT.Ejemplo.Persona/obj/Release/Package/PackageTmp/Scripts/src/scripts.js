let gbl_result = {
    'excep_message': '',
    'name_input': ''
}

window.onload = function () {
    enviarFormulario()

    $('#btnCancelar').on('click', () => {
        
    })
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
const enviarFormulario = () => {
    $('#btnAceptar').on('click', (e) => {
        //$("#formularioPersona").submit(function (e) {
        datos = $("#formularioPersona").serializeArray();
            if (!validarFormualarioRegistro(datos)) {
                e.preventDefault();
                return false;
            }
        //});
    } )
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
        const typeText = new RegExp("^[0-9 ]+$");
        console.log(typeText.test(inputClave.value))
        if (!typeText.test(inputClave.value)) {
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
    try {
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
        closeMessage();
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