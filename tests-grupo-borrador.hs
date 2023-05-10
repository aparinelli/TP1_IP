

usuario1 = (1,"Alejo")
usuario2 = (2,"André")
usuario3 = (3,"Juan Pablo")
usuario4 = (4,"Tazu")

publicacion1_1 = (usuario1,"Este es mi primer posteo", [])
publicacion1_2 = (usuario1,"Este es mi segundo posteo", [])
publicacion2_2 = (usuario2, "Soy el unico posteo de Andre", [])
publicacion3_1 = (usuario3,"Tiramisu > Chocotorta",[])
publicacion3_2 = (usuario3,"hoy juega river",[usuario1, usuario2, usuario3, usuario4] )
publicacion3_3 = (usuario3,"hoy llueve", [usuario2, usuario3])
publicacion4_1 = (usuario4, "Buenos dias", [])
publicacion4_2 = (usuario4, "Buenas tardes", [])
publicacion4_3 = (usuario4, "Buenas noches", [])

-- esto está abierto a modificaciones. charlemos las modificaciones 
-- que hagamos para verificar que no interferimos con otros tests de otro.
usuariosC =  [usuario1,usuario2,usuario3,usuario4]
relacionesC = [(usuario1, usuario2),(usuario2, usuario3),(usuario3,usuario4)]
publicacionesC = [publicacion1_1, publicacion1_2, publicacion2_1, publicacion2_2]
redC = (usuariosC, relacionesC, publicacionesC)

usuariosD = [usuario1,usuario2,usuario3,usuario4]
relacionesD = [(usuario1, usuario2), (usuario3, usuario4)]
publicacionesD = [] -- LLENAR
redD = (usuariosD, relacionesD, publicacionesD)

{-
usuario6 = (6,"Alejo")
usuario7 = (7,"Andre")
usuario8 = (8,"Juan Pablo")
usuario9 = (9,"Tazu")

publicacion6_1 = (usuario6,"Este es mi primer posteo", [])
publicacion6_2 = (usuario6,"Este es mi segundo posteo", [])
publicacion7_2 = (usuario7, "Soy el unico posteo de Andre", [])
publicacion8_1 = (usuario8,"Tiramisu > Chocotorta",[usuario7, usuario8])
publicacion8_2 = (usuario8,"hoy juega river",[usuario6, usuario7, usuario8, usuario9] )
publicacion8_3 = (usuario8,"hoy llueve", [usuario7, usuario8])
publicacion8_4 = (usuario8, "No des like",[usuario8])
publicacion9_1 = (usuario9, "Buenos dias", [])
publicacion9_2 = (usuario9, "Buenas tardes", [])
publicacion9_3 = (usuario9, "Buenas noches", [])

usuariosC =  [usuario6,usuario7,usuario8,usuario9]
relacionesC = [(usuario6, usuario7),(usuario7, usuario8),(usuario8,usuario9)]
publicacionesC = [publicacion6_1, publicacion6_2, publicacion7_2, publicacion8_1, publicacion8_3]
redC = (usuariosC, relacionesC, publicacionesC)

usuariosD = [usuario6,usuario7,usuario8,usuario9]
relacionesD = [(usuario6, usuario7), (usuario8, usuario9)]
publicacionesD = [publicacion8_2, publicacion8_3, publicacion8_4] -- LLENAR
redD = (usuariosD, relacionesD, publicacionesD)
-} -- esta es una plantilla que modifique para poder usar todos los usuarios de test al mismo tiempo
   -- fijense si les sirve, hice pruebas del ej  7, 8 y 9 adaptadas a esto -JP

{--
6.

Problema a testear: publicacionesDe

(1)
red = redC
user = usuario1
res = [publicacion1_1, publicacion1_2]

(2)
red = redC
user = usuario3
res = []

---
7.

”Caso 1: No hay publicaciones ” ˜ : (publicacionesQueLeGustanA redE usuario6) ˜?= []
”Caso 2: No dio likes ” ˜ : (publicacionesQueLeGustanA redC usuario6) ˜?= []
”Caso 3: Likes en redC ” ˜ : (publicacionesQueLeGustanA redC usuario7) ˜?= [publicacion3_1, publicacion3_3]
”Caso 4: Likes en redD ” ˜ : (publicacionesQueLeGustanA redD usuario7) ˜?= [publicacion3_2, publicacion3_3]

---
8.

”Caso 1: No hay publicaciones ” ˜ : (lesGustanLasMismasPublicaciones redE usuario8 usuario6) ˜?= True
”Caso 2: Uno de los dos no dio likes ” ˜ : (lesGustanLasMismasPublicaciones redC usuario6 usuario7) ˜?= False
”Caso 3: Dieron like a pubs distintas ” ˜ : (lesGustanLasMismasPublicaciones redD usuario7 usuario8) ˜?= False
”Caso 4: Dieron like a las mismas pubs ” ˜ : (lesGustanLasMismasPublicaciones redD usuario 6 usuario9) ˜?= True
”Caso 5: Ninguno dio like ” ˜ : (lesGustanLasMismasPublicaciones redC usuario6 usuario9) ˜?= True

---
9.

”El usuario no publico ” ˜ : (tieneUnSeguidorFiel redD usuario6) ˜?= False
”Existe 1 Pub. sin likes ” ˜ : (tieneUnSeguidorFiel redC usuario6) ˜?= False
”Hay 1 seguidor fiel ” ˜ : (tieneUnSeguidorFiel redC usuario8) ˜?= True
”No hay 1 seguidor fiel ” ˜ : (tieneUnSeguidorFiel redD usuario8) ˜?= False


---------------------------tests 7, 8 y 9 fueron basados en :--------------------------------
usuario6 = (6,"Alejo")
usuario7 = (7,"Andre")
usuario8 = (8,"Juan Pablo")
usuario9 = (9,"Tazu")

publicacion6_1 = (usuario6,"Este es mi primer posteo", [])
publicacion6_2 = (usuario6,"Este es mi segundo posteo", [])
publicacion7_2 = (usuario7, "Soy el unico posteo de Andre", [])
publicacion8_1 = (usuario8,"Tiramisu > Chocotorta",[usuario7, usuario8])
publicacion8_2 = (usuario8,"hoy juega river",[usuario6, usuario7, usuario8, usuario9] )
publicacion8_3 = (usuario8,"hoy llueve", [usuario7, usuario8])
publicacion8_4 = (usuario8, "No des like",[usuario8])
publicacion9_1 = (usuario9, "Buenos dias", [])
publicacion9_2 = (usuario9, "Buenas tardes", [])
publicacion9_3 = (usuario9, "Buenas noches", [])

usuariosC =  [usuario6,usuario7,usuario8,usuario9]
relacionesC = [(usuario6, usuario7),(usuario7, usuario8),(usuario8,usuario9)]
publicacionesC = [publicacion6_1, publicacion6_2, publicacion7_2, publicacion8_1, publicacion8_3]
redC = (usuariosC, relacionesC, publicacionesC)

usuariosD = [usuario6,usuario7,usuario8,usuario9]
relacionesD = [(usuario6, usuario7), (usuario8, usuario9)]
publicacionesD = [publicacion8_2, publicacion8_3, publicacion8_4]
redD = (usuariosD, relacionesD, publicacionesD)

usuariosE = [usuario6,usuario7,usuario8,usuario9]
relacionesE = [(usuario6, usuario7), (usuario8, usuario9)]
publicacionesE = []
redE = (usuariosE, relacionesE, publicacionesE)
-------------------------------------------------------------------------------------------------
---
10. 

(1)
red = redC
user1 = usuario1
user2 = usuario4
res = True

(2)
red = redC
user1 = usuario1
user2 = usuario2
res = True

(3)
red = redD
user1 = usuario1
user2 = usuario4
res = False

--}