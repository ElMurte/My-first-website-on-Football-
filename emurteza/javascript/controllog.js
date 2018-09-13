
function validazionelogin() {
    var x = document.forms["loginf"]["username"].value;
    var y = document.forms["loginf"]["userpass"].value;
    if (x == "") {
        alert("inserire il nome utente");
        return false;
    }
    if (y == "") {
        alert("inserire la password");
        return false;
    }
    return true;
}
