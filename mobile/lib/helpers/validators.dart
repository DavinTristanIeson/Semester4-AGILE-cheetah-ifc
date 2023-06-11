String? validateEmail(String? email){
  if (email == null || email.isEmpty)
    return "Email harus diisi!";
  if (RegExp(r"/^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$/").hasMatch(email))
    return "Format email tidak sesuai!";
  return null;
}
String? validatePassword(String? password){
  if (password == null || password.isEmpty)
    return "Kata sandi harus diisi";
  if (password.length < 8)
    return "Kata sandi harus terdiri dari minimal 8 karakter";
  return null;
}
String? validateNewPassword(String? password){
  if (password == null || password.isEmpty)
    return null;
  else return validatePassword(password);
}
String? validateName(String? name){
  if (name == null || name.isEmpty)
    return "Nama harus diisi";
  if (name.length < 5)
    return "Nama harus terdiri dari minimal 5 karakter";
  if (!RegExp("^[a-zA-Z]+( [a-zA-Z]+)*\$").hasMatch(name))
    return "Nama hanya boleh terdiri dari huruf alfabet dan satu spasi antar-kata.";
  return null;
}
String? validateGender(bool? gender){
  if (gender == null)
    return "Jenis kelamin harus diisi";
  return null;
}
String? validatePhone(String? telp){
  if (telp == null || telp.isEmpty)
    return "No. telp harus diisi";
  if (!RegExp("^[0-9]{10,12}\$").hasMatch(telp))
    return "No. telp harus terdiri dari 10-12 angka";
  return null;
}
String? Function(String?) isNotEmpty(String errorMessage){
  return (String? value){
    if (value == null || value.isEmpty) return errorMessage;
    else return null;
  };
}