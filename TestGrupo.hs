module TestGrupo where

import Test.HUnit
import Solucion


run7 = runTestTT testSuite7
run8 = runTestTT testSuite8
run9 = runTestTT testSuite9

testSuite7 = test [
    "Caso 1: El usuario dio like a todas sus propias publicaciones" ~: (publicacionesQueLeGustanA redD usuario3) ~?= [publicacion3_1, publicacion3_2, publicacion3_3, publicacion3_4],
    "Caso 2: El usuario dio like a una sola publicacion" ~: (publicacionesQueLeGustanA redD usuario1) ~?= [publicacion3_2]
    ]

testSuite8 = test [
    "Caso 1: Los usuarios dieron like a las mismas publicaciones" ~: (lesGustanLasMismasPublicaciones redC usuario2 usuario3) ~?= True,
    "Caso 2: Los usuarios no dieron like a las mismas publicaciones" ~: (lesGustanLasMismasPublicaciones redD usuario2 usuario3) ~?= False,
    "Caso 3: Los usuarios no dieron like a ninguna publicacion" ~: (lesGustanLasMismasPublicaciones redC usuario1 usuario4) ~?= True
    ]

testSuite9 = test [
    "Caso 1: El usuario no tiene publicaciones" ~: (tieneUnSeguidorFiel redD usuario1) ~?= False,
    "Caso 2: Existe una publicacion sin likes" ~: (tieneUnSeguidorFiel redC usuario1) ~?= False,
    "Caso 3: Existe un seguidor fiel" ~: (tieneUnSeguidorFiel redC usuario3) ~?= True,
    "Caso 4: No existe un seguidor fiel" ~: (tieneUnSeguidorFiel redD usuario3) ~?= False
    ]

usuario1 = (1,"Alejo")
usuario2 = (2,"Andre")
usuario3 = (3,"Juan Pablo")
usuario4 = (4,"Tazu")

publicacion1_1 = (usuario1,"Este es mi primer posteo", [])
publicacion1_2 = (usuario1,"Este es mi segundo posteo", [])
publicacion2_2 = (usuario2, "Soy el unico posteo de Andre", [])
publicacion3_1 = (usuario3,"Tiramisu > Chocotorta",[usuario2, usuario3])
publicacion3_2 = (usuario3,"hoy juega river",[usuario1, usuario2, usuario3, usuario4] )
publicacion3_3 = (usuario3,"hoy llueve", [usuario2, usuario3])
publicacion3_4 = (usuario3, "No des like",[usuario3])
publicacion4_1 = (usuario4, "Buenos dias", [])
publicacion4_2 = (usuario4, "Buenas tardes", [])
publicacion4_3 = (usuario4, "Buenas noches", [])

usuariosC =  [usuario1,usuario2,usuario3,usuario4]
relacionesC = [(usuario1, usuario2),(usuario2, usuario3),(usuario3,usuario4)]
publicacionesC = [publicacion1_1, publicacion1_2, publicacion2_2, publicacion3_1, publicacion3_3]
redC = (usuariosC, relacionesC, publicacionesC)

usuariosD = [usuario1,usuario2,usuario3,usuario4]
relacionesD = [(usuario1, usuario2), (usuario3, usuario4)]
publicacionesD = [publicacion3_1, publicacion3_2, publicacion3_3, publicacion3_4]
redD = (usuariosD, relacionesD, publicacionesD)
