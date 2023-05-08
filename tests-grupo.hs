

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
la funcion publicacionesQueLeGustanA con la redD y usuario8, el usuario 8 le dio like solo a
sus publicaciones, por ende espero que la funcion me devuelva todas sus publicaciones de
la redD, con esos valores la funcion devuelve :

[((8,"Juan Pablo"),"hoy juega river",[(6,"Alejo"),(7,"Andre"),(8,"Juan Pablo"),(9,"Tazu")]),
((8,"Juan Pablo"),"hoy llueve",[(7,"Andre"),(8,"Juan Pablo")]),
((8,"Juan Pablo"),"No des like",[(8,"Juan Pablo")])]

estas son correctamente todas las pubs del usuario8 en la redD que le dio like.
si ahora probamos con usuario6 en la misma red como sabemos que le dio like a 1 sola
publicacion, en la redD, espero recibir solo esa publicacion:

[((8,"Juan Pablo"),"hoy juega river",[(6,"Alejo"),(7,"Andre"),(8,"Juan Pablo"),(9,"Tazu")])]

---
8.
en la redC, los usuario 7 y 8 le dieron like a las mismas publicaciones
entonces espero recibir true de la funcion

"lesGustanLasMismasPublicaciones redC usuario7 usuario8" devuelve "True"

en la redD, el usuario7 no le dio like a las mismas publicaciones que
el usuario 8, espero recibir False

"lesGustanLasMismasPublicaciones redD usuario7 usuario8" devuelve "False"

en la redC, los usuarios 6 y 9 no le dieron like a ninguna publicaion
entonces las publicaciones a las que le dieron like son las mismas (ninguna)
espero recibir True 

"lesGustanLasMismasPublicaciones redC usuario6 usuario9" devuelve "True"

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