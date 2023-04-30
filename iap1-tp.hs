-- Completar con los datos del grupo
--
-- Nombre de Grupo: xx
-- Integrante 1: Nombre Apellido, email, LU
-- Integrante 2: Nombre Apellido, email, LU
-- Integrante 3: Juan Pablo Tarela, juanptarela@gmail.com, 151/23
-- Integrante 4: Mateo Otazúa Arce, tazuarce@gmail.com, 88/23

type Usuario = (Integer, String) -- (id, nombre)
type Relacion = (Usuario, Usuario) -- usuarios que se relacionan
type Publicacion = (Usuario, String, [Usuario]) -- (usuario que publica, texto publicacion, likes)
type RedSocial = ([Usuario], [Relacion], [Publicacion])

-- Funciones basicas

usuarios :: RedSocial -> [Usuario]
usuarios (us, _, _) = us

relaciones :: RedSocial -> [Relacion]
relaciones (_, rs, _) = rs

publicaciones :: RedSocial -> [Publicacion]
publicaciones (_, _, ps) = ps

idDeUsuario :: Usuario -> Integer
idDeUsuario (id, _) = id 

nombreDeUsuario :: Usuario -> String
nombreDeUsuario (_, nombre) = nombre 

usuarioDePublicacion :: Publicacion -> Usuario
usuarioDePublicacion (u, _, _) = u

likesDePublicacion :: Publicacion -> [Usuario]
likesDePublicacion (_, _, us) = us

-- Ejercicios

-- Ejercicio 1 - tazuarce

-- hace una lista con los nombres de los usuarios de la red social
nombresDeUsuarios :: RedSocial -> [String]
nombresDeUsuarios redX = (proyectarNombres (usuarios(redX)))

proyectarNombres :: [Usuario] -> [String]
proyectarNombres [] = []
proyectarNombres (u:us) = (nombreDeUsuario u) : (proyectarNombres us)

-- describir qué hace la función: .....
amigosDe :: RedSocial -> Usuario -> [Usuario]
amigosDe (_ , [], _) _ = []

amigosDe red u
    | userInFst (head rels) u == True = [snd (head rels)] ++ amigosDe (usuarios red, tail (relaciones red), publicaciones red) u
    | userInSnd (head rels) u == True = [fst (head rels)] ++ amigosDe (usuarios red, tail (relaciones red), publicaciones red) u
    | otherwise                       = amigosDe (usuarios red, tail (relaciones red), publicaciones red) u
    where rels = relaciones red

userInFst :: Relacion -> Usuario -> Bool
userInFst rel u
    | idDeUsuario u == idDeUsuario (fst rel) = True
    | otherwise = False

userInSnd :: Relacion -> Usuario -> Bool
userInSnd rel u
    | idDeUsuario u == idDeUsuario (snd rel) = True
    | otherwise = False    

-- describir qué hace la función: .....
cantidadDeAmigos :: RedSocial -> Usuario -> Int
cantidadDeAmigos = undefined

-- describir qué hace la función: .....
usuarioConMasAmigos :: RedSocial -> Usuario
usuarioConMasAmigos = undefined

-- describir qué hace la función: .....
estaRobertoCarlos :: RedSocial -> Bool
estaRobertoCarlos = undefined

-- Recibe una red social y un usuario perteneciente a la red social y devuelve una lista con todas sus publicaciones.
publicacionesDe :: RedSocial -> Usuario -> [Publicacion]
publicacionesDe (_, _, []) _ = [] -- caso base
publicacionesDe red u
 | u == usuarioDePublicacion (head pubs) = [head pubs] ++ publicacionesDe (usuarios red, relaciones red, tail pubs) u
 | otherwise = [] ++ publicacionesDe (usuarios red, relaciones red, tail pubs) u
 where pubs = publicaciones red 

-- tests: 
-- publicacionesDe ([(0, "Andre"), (1, "Tazu"), (2, "Juan Pablo"), (3, "Alejo")], [], [((0,"Andre"), "", []), ((0, "Andre"), "", []), ((2,"Juan Pablo"), "",[]), ((1,"Tazu"), "", [])]) (0, "Andre")

-- describir qué hace la función: dar una lista con las publicaciones que le gustaron al usuario
publicacionesQueLeGustanA :: RedSocial -> Usuario -> [Publicacion]
publicacionesQueLeGustanA red u = perteneceUsuarioalaLista u (publicaciones red)            -- llamo a otra funcion que da la lista de
                                                                                            -- publicaciones que le dio like el usuario
--auxiliar--
perteneceUsuarioalaLista :: Usuario -> [Publicacion] -> [Publicacion]
perteneceUsuarioalaLista u pub  | longitud (tail pub) == longitud pub && pertenece u (likesDePublicacion (head pub)) = pub
                                | longitud pub <= 1 = []
                                | likesDePublicacion (head pub) /= [] && pertenece u (likesDePublicacion (head pub)) = head pub : perteneceUsuarioalaLista u (tail pub)
                                | otherwise = perteneceUsuarioalaLista u (tail pub)

-- describir qué hace la función: .....
lesGustanLasMismasPublicaciones :: RedSocial -> Usuario -> Usuario -> Bool
lesGustanLasMismasPublicaciones = undefined

-- describir qué hace la función: .....
tieneUnSeguidorFiel :: RedSocial -> Usuario -> Bool
tieneUnSeguidorFiel = undefined

-- describir qué hace la función: .....
existeSecuenciaDeAmigos :: RedSocial -> Usuario -> Usuario -> Bool
existeSecuenciaDeAmigos = undefined

--

longitud :: [t] -> Integer
longitud [] = 0
longitud (_:xs) = 1 + longitud xs

pertenece :: (Eq t) => t -> [t] -> Bool
pertenece e [] = False
pertenece e (x:xs) = e == x || pertenece e xs

-- TESTS

usuario1 = (1, "Juan")
usuario2 = (2, "Natalia")
usuario3 = (3, "Pedro")
usuario4 = (4, "Mariela")
usuario5 = (5, "Natalia")

relacion1_2 = (usuario1, usuario2)
relacion1_3 = (usuario1, usuario3)
relacion1_4 = (usuario4, usuario1) -- Notar que el orden en el que aparecen los usuarios es indistinto
relacion2_3 = (usuario3, usuario2)
relacion2_4 = (usuario2, usuario4)
relacion3_4 = (usuario4, usuario3)

publicacion1_1 = (usuario1, "Este es mi primer post", [usuario2, usuario4])
publicacion1_2 = (usuario1, "Este es mi segundo post", [usuario4])
publicacion1_3 = (usuario1, "Este es mi tercer post", [usuario2, usuario5])
publicacion1_4 = (usuario1, "Este es mi cuarto post", [])
publicacion1_5 = (usuario1, "Este es como mi quinto post", [usuario5])

publicacion2_1 = (usuario2, "Hello World", [usuario4])
publicacion2_2 = (usuario2, "Good Bye World", [usuario1, usuario4])

publicacion3_1 = (usuario3, "Lorem Ipsum", [])
publicacion3_2 = (usuario3, "dolor sit amet", [usuario2])
publicacion3_3 = (usuario3, "consectetur adipiscing elit", [usuario2, usuario5])

publicacion4_1 = (usuario4, "I am Alice. Not", [usuario1, usuario2])
publicacion4_2 = (usuario4, "I am Bob", [])
publicacion4_3 = (usuario4, "Just kidding, i am Mariela", [usuario1, usuario3])


usuariosA = [usuario1, usuario2, usuario3, usuario4]
relacionesA = [relacion1_2, relacion1_4, relacion2_3, relacion2_4, relacion3_4]
publicacionesA = [publicacion1_1, publicacion1_2, publicacion2_1, publicacion2_2, publicacion3_1, publicacion3_2, publicacion4_1, publicacion4_2]
redA = (usuariosA, relacionesA, publicacionesA)

usuariosB = [usuario1, usuario2, usuario3, usuario5]
relacionesB = [relacion1_2, relacion2_3]
publicacionesB = [publicacion1_3, publicacion1_4, publicacion1_5, publicacion3_1, publicacion3_2, publicacion3_3]
redB = (usuariosB, relacionesB, publicacionesB)

-- auxiliares --
longitud :: [t] -> Integer
longitud [] = 0
longitud (_ :xs) = 1 + longitud xs

pertenece :: (Eq t) => t -> [t] -> Bool
pertenece e s   | e == head s = True
                | longitud s > 1 && e /= head s = pertenece e (tail s)
                | otherwise = False 