String errorConvert(String error) {
  if (error == 'wrong-password') {
    return 'Contraseña incorrecta';
  } else if (error == 'user-not-found') {
    return 'No existe usuario con el correo proporcionado';
  } else if (error == 'email-already-in-use') {
    return 'Email ya en uso';
  } else if (error == 'invalid-email') {
    return 'No es un Correo valido';
  } else if (error == 'too-many-requests') {
    return 'Demasiados Intentos, espere unos minutos';
  } else {
    return error;
  }
}
