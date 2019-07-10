**AGREGAR LOS .ST**

En el archivo TusLibros.st está todo lo necesario para la cuarta iteración. De haber algún problema con la carga de este
archivo, cargar los otros 3 de la carpeta (si no hubo ningún problema, los otros 3 archivos no son necesarios).



**LEVANTAR SERVER**

Lo mejor para esto es correr en modo debug cualquiera de los tests de la clase TusLibrosServerControllerTest, 
ya que en el setUp de éstos tests se levanta el servidor con un sistema que sirve para el testeo (TusLibrosServerController new initializeWith: tusLibrosController)
y en el tearDown se destruye.



**ABRIR GUI**

Desde el workspace ejecutar la colaboración:

TusLibrosClientWindow open



**ALGUNAS COSAS ÚTILES PARA TESTEAR LA GUI**

Usuario y password válidos en nuestro sistema
User: Wilkinson
Password: Sr.Smalltalk

User: Juan
Password: CasiSmalltalk

User: Nico
Password: SmalltalkCreo
