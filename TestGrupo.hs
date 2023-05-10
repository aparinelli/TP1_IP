module TestGrupo where

import Test.HUnit
import Solucion

run6 = runTestTT testSuite6
run7 = runTestTT testSuite7
run8 = runTestTT testSuite8
run9 = runTestTT testSuite9
run10 = runTestTT testSuite10

testSuite6 = test [
    "Caso 1: El usuario tiene dos o mas publicaciones" ~: (publicacionesDe redC usuario1) ~?= [publicacion1_1, publicacion1_2],
    "Caso 2: El usuario tiene una unica publicacion" ~: (publicacionesDe redC usuario2) ~?= [publicacion2_1],
    "Caso 3: El usuario no tiene publicaciones" ~: (publicacionesDe redD usuario2) ~?= []
    ]

testSuite7 = test [
    "Caso 1: No hay publicaciones " ~: (publicacionesQueLeGustanA redE usuario1) ~?= []
    "Caso 2: No dio likes " ~: (publicacionesQueLeGustanA redC usuario1) ~?= []
    "Caso 3: Likes en redC " ~: (publicacionesQueLeGustanA redC usuario2) ~?= [publicacion3_1, publicacion3_3]
    "Caso 4: Likes en redD " ~: (publicacionesQueLeGustanA redD usuario2) ~?= [publicacion3_1, publicacion3_2, publicacion3_3]
    ]

testSuite8 = test [
    "Caso 1: No hay publicaciones " ~: (lesGustanLasMismasPublicaciones redE usuario3 usuario1) ~?= True
    "Caso 2: Uno de los dos no dio likes " ~: (lesGustanLasMismasPublicaciones redC usuario1 usuario2) ~?= False
    "Caso 3: Dieron like a pubs distintas " ~: (lesGustanLasMismasPublicaciones redD usuario2 usuario3) ~?= False
    "Caso 4: Dieron like a las mismas pubs " ~: (lesGustanLasMismasPublicaciones redD usuario1 usuario4) ~?= True
    "Caso 5: Ninguno dio like " ~: (lesGustanLasMismasPublicaciones redC usuario1 usuario4) ~?= True
    ]

testSuite9 = test [
    "Caso 1: El usuario no tiene publicaciones" ~: (tieneUnSeguidorFiel redD usuario1) ~?= False,
    "Caso 2: Existe una publicacion sin likes" ~: (tieneUnSeguidorFiel redC usuario1) ~?= False,
    "Caso 3: Existe un seguidor fiel" ~: (tieneUnSeguidorFiel redC usuario3) ~?= True,
    "Caso 4: No existe un seguidor fiel" ~: (tieneUnSeguidorFiel redD usuario3) ~?= False
    ]

testSuite10 = test [
    "Caso 1: Existe una cadena de dos amigos" ~: (existeSecuenciaDeAmigos redC usuario1 usuario2) ~?= True,
    "Caso 2: Existe una cadena de dos o mas amigos" ~: (existeSecuenciaDeAmigos redC usuario1 usuario3) ~?= True,
    "Caso 3: No existe una cadena" ~: (existeSecuenciaDeAmigos redD usuario1 usuario4) ~?= False
    ]

usuario1 = (1,"Alejo")
usuario2 = (2,"Andre")
usuario3 = (3,"Juan Pablo")
usuario4 = (4,"Tazu")

publicacion1_1 = (usuario1,"Este es mi primer posteo", [])
publicacion1_2 = (usuario1,"Este es mi segundo posteo", [])
publicacion2_1 = (usuario2, "Soy el unico posteo de Andre", [])
publicacion3_1 = (usuario3,"Tiramisu > Chocotorta",[usuario2, usuario3])
publicacion3_2 = (usuario3,"hoy juega river",[usuario1, usuario2, usuario3, usuario4] )
publicacion3_3 = (usuario3,"hoy llueve", [usuario2, usuario3])
publicacion3_4 = (usuario3, "No des like",[usuario3])
publicacion4_1 = (usuario4, "Buenos dias", [])
publicacion4_2 = (usuario4, "Buenas tardes", [])
publicacion4_3 = (usuario4, "Buenas noches", [])

usuariosC =  [usuario1,usuario2,usuario3,usuario4]
relacionesC = [(usuario1, usuario2),(usuario2, usuario3),(usuario3,usuario4)]
publicacionesC = [publicacion1_1, publicacion1_2, publicacion2_1, publicacion3_1, publicacion3_3]
redC = (usuariosC, relacionesC, publicacionesC)

usuariosD = [usuario1,usuario2,usuario3,usuario4]
relacionesD = [(usuario1, usuario2), (usuario3, usuario4)]
publicacionesD = [publicacion3_1, publicacion3_2, publicacion3_3, publicacion3_4]
redD = (usuariosD, relacionesD, publicacionesD)

usuariosE = [usuario1,usuario2,usuario3,usuario4]
relacionesE = [(usuario1, usuario2), (usuario3, usuario4)]
publicacionesE = []
redE = (usuariosE, relacionesE, publicacionesE)
