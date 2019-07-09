----LEVANTAR SERVER---

Lo mejor para esto es correr en modo debug cualquiera de los tests de la clase TusLibrosServerControllerTest, ya que en el setUp de éstos tests se levanta el servidor con un sistema que sirve para el testeo (TusLibrosServerController new initializeWith: tusLibrosController)



---ABRIR GUI---

Desde el workspace ejecutar la colaboración:

TusLibrosCartCreationWindow open



---ALGUNAS COSAS ÚTILES PARA TESTEAR LA GUI---

> Usuario y password válidos en nuestro sistema
User: Wilkinson
Password: Sr.Smalltalk