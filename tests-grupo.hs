

usuario1 = (1,"Alejo")
usuario2 = (2,"André")
usuario3 = (3,"Juan")
usuario4 = (4,"Tazu")

publicacion1_1 = (usuario1,"Este es mi primer posteo", [])
publicacion1_2 = (usuario1,"Este es mi segundo posteo", [])
publicacion2_2 = (usuario2, "Soy el unico posteo de Andre", [])
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