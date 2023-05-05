
{-
           /$$                                               /$$              
          | $$                                              | $$              
  /$$$$$$$| $$  /$$$$$$  /$$$$$$/$$$$   /$$$$$$  /$$$$$$$  /$$$$$$    /$$$$$$ 
 /$$_____/| $$ /$$__  $$| $$_  $$_  $$ /$$__  $$| $$__  $$|_  $$_/   /$$__  $$
| $$      | $$| $$$$$$$$| $$ \ $$ \ $$| $$$$$$$$| $$  \ $$  | $$    | $$$$$$$$
| $$      | $$| $$_____/| $$ | $$ | $$| $$_____/| $$  | $$  | $$ /$$| $$_____/
|  $$$$$$$| $$|  $$$$$$$| $$ | $$ | $$|  $$$$$$$| $$  | $$  |  $$$$/|  $$$$$$$
 \_______/|__/ \_______/|__/ |__/ |__/ \_______/|__/  |__/   \___/   \_______/
-}

-- Nombre de Grupo: Clemente
-- Integrante 1: Nombre Apellido, email, LU
-- Integrante 2: Alejo Parinelli,   alejoparinelli@gmail,com, 115/23
-- Integrante 3: Juan Pablo Tarela, juanptarela@gmail.com,    151/23
-- Integrante 4: Mateo Otazúa Arce, tazuarce@gmail.com,       88/23




{- 
   /$$     /$$                              
  | $$    |__/                              
 /$$$$$$   /$$  /$$$$$$   /$$$$$$   /$$$$$$$
|_  $$_/  | $$ /$$__  $$ /$$__  $$ /$$_____/
  | $$    | $$| $$  \ $$| $$  \ $$|  $$$$$$ 
  | $$ /$$| $$| $$  | $$| $$  | $$ \____  $$
  |  $$$$/| $$| $$$$$$$/|  $$$$$$/ /$$$$$$$/
   \___/  |__/| $$____/  \______/ |_______/ 
              | $$                          
              | $$                          
              |__/                          
-}

type Usuario = (Integer, String) -- (id, nombre)
type Relacion = (Usuario, Usuario) -- usuarios que se relacionan
type Publicacion = (Usuario, String, [Usuario]) -- (usuario que publica, texto publicacion, likes)
type RedSocial = ([Usuario], [Relacion], [Publicacion])




{-
 /$$                           /$$                              
| $$                          |__/                              
| $$$$$$$   /$$$$$$   /$$$$$$$ /$$  /$$$$$$$  /$$$$$$   /$$$$$$$
| $$__  $$ |____  $$ /$$_____/| $$ /$$_____/ |____  $$ /$$_____/
| $$  \ $$  /$$$$$$$|  $$$$$$ | $$| $$        /$$$$$$$|  $$$$$$ 
| $$  | $$ /$$__  $$ \____  $$| $$| $$       /$$__  $$ \____  $$
| $$$$$$$/|  $$$$$$$ /$$$$$$$/| $$|  $$$$$$$|  $$$$$$$ /$$$$$$$/
|_______/  \_______/|_______/ |__/ \_______/ \_______/|_______/ 
-}

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





{- 
                                             /$$           /$$                    
                                            |__/          |__/                    
  /$$$$$$  /$$  /$$$$$$   /$$$$$$   /$$$$$$$ /$$  /$$$$$$$ /$$  /$$$$$$   /$$$$$$$
 /$$__  $$|__/ /$$__  $$ /$$__  $$ /$$_____/| $$ /$$_____/| $$ /$$__  $$ /$$_____/
| $$$$$$$$ /$$| $$$$$$$$| $$  \__/| $$      | $$| $$      | $$| $$  \ $$|  $$$$$$ 
| $$_____/| $$| $$_____/| $$      | $$      | $$| $$      | $$| $$  | $$ \____  $$
|  $$$$$$$| $$|  $$$$$$$| $$      |  $$$$$$$| $$|  $$$$$$$| $$|  $$$$$$/ /$$$$$$$/
 \_______/| $$ \_______/|__/       \_______/|__/ \_______/|__/ \______/ |_______/ 
     /$$  | $$                                                                    
    |  $$$$$$/                                                                    
     \______/                                                                     
-}


{- 
1111
  11
  11
  11
111111 
-}

-- recibe una red social y hace una lista con los nombres de los usuarios de esa red
nombresDeUsuarios :: RedSocial -> [String]
nombresDeUsuarios redX = (proyectarNombres (usuarios(redX)))

proyectarNombres :: [Usuario] -> [String]
proyectarNombres [] = []
proyectarNombres (user:users) = (nombreDeUsuario user) : (proyectarNombres users)

{-  
 2222
22  22
   22
  22
222222 
-}

-- Toma una red social junto con un usuario dentro de esta, y devuelve una lista de los usuarios con quien se relaciona. 
amigosDe :: RedSocial -> Usuario -> [Usuario]
amigosDe red user = amigosDeAux (relaciones red) user

-- Creo una funcion auxiliar que haga recursión unicamente sobre los elementos que me interesan de la red social
amigosDeAux :: [Relacion] -> Usuario -> [Usuario]
amigosDeAux [] _ = [] -- Caso base
amigosDeAux (rel:rels) user 
    | user == fst rel = (snd rel) : restoDeAmigos 
    | user == snd rel = (fst rel) : restoDeAmigos 
    | otherwise       = restoDeAmigos
    where restoDeAmigos = amigosDeAux rels user

{-  
 3333
33  33
   333
33  33
 3333 
-}

-- toma un usuario en una red social e indica la cantidad de amigos que tiene
cantidadDeAmigos :: RedSocial -> Usuario -> Int
cantidadDeAmigos redX user = longitud (amigosDe redX user)

{- 
44  44
44  44
444444
    44
    44
-}

-- toma una red social, y devuelve su usuario con más amigos (si varios tienen la mayor cantidad, da uno de ellos)
usuarioConMasAmigos :: RedSocial -> Usuario
usuarioConMasAmigos redX = compararAmigos redX (usuarios(redX)) -- usa una función auxiliar para hacer recursión sobre la lista de usuarios fácilmente

-- recursión comparando la cantidad de amigos de n-1 y n, devolviendo el que sea mayor
compararAmigos :: RedSocial -> [Usuario] -> Usuario
compararAmigos redX (user:users)
    | users == [] = user
    | (cantidadDeAmigos redX user) >= (cantidadDeAmigos redX (topUserOnRight)) = user
    | otherwise = (topUserOnRight)
    where topUserOnRight = compararAmigos redX users

{- 
555555
55
55555
    55
55555
-}

-- toma una red social, y devuelve True si tiene un usuario con mas de 1,000,000 amigos 
estaRobertoCarlos :: RedSocial -> Bool
estaRobertoCarlos red = cantidadDeAmigos red (usuarioConMasAmigos red) > 1000000

-- 👏👏👏 muy buena manera de resolverlo
-- igual, la función "usuarioConMasAmigos" hace un montón de comparaciones que no son necesarias para "estaRobertoCarlos"
-- creo que sería más eficiente una función que especificamente vea si el primer usuario de la lista "es Roberto Carlos", y si no, mirar al primero del resto de usuarios, y así recursivamente
-- apenas encuentre alguien con más de un millón de amigos, daría True; tardaría como mucho n pasos, pero podría tardar 1 paso
-- "usuarioConMasAmigos" necesita ver sí o sí todos los usuarios y para hacer comparaciones tarda sí o sí 2n-1 pasos maso; el doble 
-- firma: tazu 

{- 
 6666
66
66666
66  66
 6666
-}

-- Recibe una red social y un usuario perteneciente a la red social y devuelve una lista con todas sus publicaciones.
publicacionesDe :: RedSocial -> Usuario -> [Publicacion]
publicacionesDe (_, _, []) _ = [] -- caso base
publicacionesDe red user
    | user == usuarioDePublicacion pub = [pub] ++ publicacionesDe (usuarios red, relaciones red, pubs) user
    | otherwise = [] ++ publicacionesDe (usuarios red, relaciones red, pubs) user
    where (pub:pubs) = publicaciones red
    --where restoDePubsDeUser = publicacionesDe (usuarios red, relaciones red, pubs) user
    --firma: tazu

-- tests: 
-- publicacionesDe ([(0, "Andre"), (1, "Tazu"), (2, "Juan Pablo"), (3, "Alejo")], [], [((0,"Andre"), "", []), ((0, "Andre"), "", []), ((2,"Juan Pablo"), "",[]), ((1,"Tazu"), "", [])]) (0, "Andre")

{- 
777777
   77
  77
 77
77
-}

-- Dar una lista con las publicaciones que le gustaron al usuario
publicacionesQueLeGustanA :: RedSocial -> Usuario -> [Publicacion]
publicacionesQueLeGustanA red user = proyectarPublicaciones user (publicaciones red)           -- llamo a otra funcion que da la lista de
                                                                                               -- publicaciones que le dio like el usuario
--auxiliar--
proyectarPublicaciones :: Usuario -> [Publicacion] -> [Publicacion]
proyectarPublicaciones _ [] = []
proyectarPublicaciones user (pub:pubs)
    | pertenece user (likesDePublicacion pub) = pub : proyectarPublicaciones user pubs --verifico que el user le dio like
    | otherwise = proyectarPublicaciones user pubs                                     --si el user no dio like sigo comprobando con el resto de pubs  
    -- where restoDePubs = proyectarPublicaciones user pubs

{- 
 8888
88  88
 8888
88  88
 8888
-}

-- Devuelce True si dos usuarios le dieron like a exactamente las mismas publicaciones de una red
lesGustanLasMismasPublicaciones :: RedSocial -> Usuario -> Usuario -> Bool
lesGustanLasMismasPublicaciones red user1 user2 = publicacionesQueLeGustanA red user1 == publicacionesQueLeGustanA red user2

{- 
 9999
99  99
 99999
    99
 9999
-}

-- Me dan una red y un usuario y tengo que definir si en las publicaciones de ese ususario en esa red hay otro usuario2 que le dio like a sus publicaciones
tieneUnSeguidorFiel :: RedSocial -> Usuario -> Bool
tieneUnSeguidorFiel red user = seguidorFielEnPublicaciones (publicacionesDe red user) (quitar user (usuarios red))


-- auxiliar --

seguidorFielEnPublicaciones :: [Publicacion] -> [Usuario] -> Bool
seguidorFielEnPublicaciones _ [] = False                                 --por la funcion likeoTodasLasPubs verifica si un usuario
seguidorFielEnPublicaciones [] _ = False                                 --le dio like a todas las publicaciones de la lista.
seguidorFielEnPublicaciones pubs (user:users)                            --de no ser asi, prueba con el siguiente usuario de la lista
    | likeoTodasLasPubs pubs user = True                                         
    | not (likeoTodasLasPubs pubs user) = seguidorFielEnPublicaciones pubs users

-- arreglo de tazu
{- seguidorFielEnPublicaciones :: [Publicacion] -> [Usuario] -> Bool
seguidorFielEnPublicaciones _ [] = False
seguidorFielEnPublicaciones [] _ = False
seguidorFielEnPublicaciones pubs (user:users) = likeoTodasLasPubs pubs user || seguidorFielEnPublicaciones pubs users -}


likeoTodasLasPubs :: [Publicacion] -> Usuario -> Bool
likeoTodasLasPubs (pub:pubs) user
    | pubs == [] && pertenece user (likesDePublicacion pub) = True            --esta funcion verifica si un usuario pertenece
    | pertenece user (likesDePublicacion pub) = likeoTodasLasPubs pubs user   --a la lista de likes de cada publicacion de un lista
    | otherwise = False

--arreglo de tazu
{- likeoTodasLasPubs :: [Publicacion] -> Usuario -> Bool
likeoTodasLasPubs [] _ = True -- la consigna indica que para una lista vacía de publicaciones debería dar negativo, pero no es problema porque ya está cubierto por un condicional en "seguidorFielEnPublicaciones"
likeoTodasLasPubs (pub:pubs) user = pertenece user (likesDePublicacion pub) && likeoTodasLasPubs pubs user -}

{- 
1111    0000
  11   00  00
  11   00  00
  11   00  00
111111  0000
-}

-- Dada una red social y un user1 y un user2, decide si existe
-- alguna cadena de relaciones que cominece con user1 y termine con user2.
existeSecuenciaDeAmigos :: RedSocial -> Usuario -> Usuario -> Bool
existeSecuenciaDeAmigos red user1 user2 = existeSecuenciaDeAmigosAux red (amigosDe red user1) user2

-- Recorre recursivamente las relaciones de la red, quitando las ya visitadas
-- hasta encontrar (o no) a user2.
existeSecuenciaDeAmigosAux :: RedSocial -> [Usuario] -> Usuario -> Bool
existeSecuenciaDeAmigosAux _ [] _ = False
existeSecuenciaDeAmigosAux red (user:users) user2
    | relaciones red == [] = False
    | pertenece user2 (user:users) = True
    | otherwise = existeSecuenciaDeAmigosAux redSinUser users user2 || existeSecuenciaDeAmigosAux redSinUser (amigosDe red user) user2
    where redSinUser = (usuarios red, quitarRelacionesCon user (relaciones red), publicaciones red)

-- Elimina todas las relaciones de la lista que incluyen a user.
quitarRelacionesCon :: Usuario -> [Relacion] -> [Relacion]
quitarRelacionesCon _ [] = []
quitarRelacionesCon user (rel:rels) 
    | user == fst rel || user == snd rel = quitarRelacionesCon user rels
    | otherwise = rel : quitarRelacionesCon user rels
    --where relsSinUser = quitarRelacionesCon user rels
    --firma: tazu 

{-
                               /$$ /$$ /$$                                        
                              |__/| $$|__/                                        
  /$$$$$$  /$$   /$$ /$$   /$$ /$$| $$ /$$  /$$$$$$   /$$$$$$   /$$$$$$   /$$$$$$$
 |____  $$| $$  | $$|  $$ /$$/| $$| $$| $$ |____  $$ /$$__  $$ /$$__  $$ /$$_____/
  /$$$$$$$| $$  | $$ \  $$$$/ | $$| $$| $$  /$$$$$$$| $$  \__/| $$$$$$$$|  $$$$$$ 
 /$$__  $$| $$  | $$  >$$  $$ | $$| $$| $$ /$$__  $$| $$      | $$_____/ \____  $$
|  $$$$$$$|  $$$$$$/ /$$/\  $$| $$| $$| $$|  $$$$$$$| $$      |  $$$$$$$ /$$$$$$$/
 \_______/ \______/ |__/  \__/|__/|__/|__/ \_______/|__/       \_______/|_______/             
-}


longitud :: [t] -> Int
longitud [] = 0
longitud (_:xs) = 1 + longitud xs

pertenece :: (Eq t) => t -> [t] -> Bool
pertenece e [] = False
pertenece e (x:xs) = e == x || pertenece e xs

quitar :: (Eq t) => t -> [t] -> [t]
quitar n (x:xs)
    | pertenece n (x:xs) == False = (x:xs)
    | n == x = xs
    | n /= x = x : quitar n xs








{- 
   /$$                           /$$             
  | $$                          | $$             
 /$$$$$$    /$$$$$$   /$$$$$$$ /$$$$$$   /$$$$$$$
|_  $$_/   /$$__  $$ /$$_____/|_  $$_/  /$$_____/
  | $$    | $$$$$$$$|  $$$$$$   | $$   |  $$$$$$ 
  | $$ /$$| $$_____/ \____  $$  | $$ /$$\____  $$
  |  $$$$/|  $$$$$$$ /$$$$$$$/  |  $$$$//$$$$$$$/
   \___/   \_______/|_______/    \___/ |_______/ 
-}


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
relacionesA = [relacion1_2, relacion3_4]
publicacionesA = [publicacion1_1, publicacion1_2, publicacion2_1, publicacion2_2, publicacion3_1, publicacion3_2, publicacion4_1, publicacion4_2]
redA = (usuariosA, relacionesA, publicacionesA)

usuariosB = [usuario1, usuario2, usuario3, usuario5]
relacionesB = [relacion1_2, relacion2_3]
publicacionesB = [publicacion1_3, publicacion1_4, publicacion1_5, publicacion3_1, publicacion3_2, publicacion3_3]
redB = (usuariosB, relacionesB, publicacionesB)

{- 

        (            *             )              
   (    )\ )       (  `         ( /(   *   )      
   )\  (()/(  (    )\))(   (    )\())` )  /( (    
 (((_)  /(_)) )\  ((_)()\  )\  ((_)\  ( )(_)))\   
 )\___ (_))  ((_) (_()((_)((_)  _((_)(_(_())((_)  
((/ __|| |   | __||  \/  || __|| \| ||_   _|| __| 
 | (__ | |__ | _| | |\/| || _| | .` |  | |  | _|  
  \___||____||___||_|  |_||___||_|\_|  |_|  |___| 
                                                  
                                                                                
                                                                                
                     *%.      ##                                                
                  #               %..*,                                         
                #            @ @   (...,,                                       
               ,                   (.%...,(                                     
                %                 .*(..&&#.*                                    
                  ,#            ,%,(.&&&&..%                                    
                  ................./&&&@..%                                     
                ,....*,,,,.,......&&&&&..*                                      
        &,......................(,,&@*.*&%                                      
     /,......................../   %..#/..&                                     
    %........................&   %...& ...#/                                    
   (.......................%   &...#    &&&@.                                   
   /.....................#.  &..../     /.#&&&&&#(,  .                          
    %..................%.  (....#       @&&&/&#@@,&.&@.(                        
      %..............&   ./.../,        #%.&&&.&&.&@.@&%/                       
         ,@#.....(&     %...%            &&&&,#&&.&&/%&&*            *%&.       
                         .,             &.&.(&&&%%&&&(&.          (,.....%      
                                       #..&       /..*           %,.......%     
                                     /...(        /..*        .%...,#...../     
                                    &..*          #..*     *(...*(.,/.....,,    
                                   ....&          %..*  #*...(*,,.........,,    
                                   ....&          &..,....#.   %........../     
                      *.....##.     %..%          &....%.      *..........%     
                     &...........// ...,                       *........../     
                      (.............%%..&                      #.........*      
                        %............./..%                      .(.......(      
                           .%,............(.                                    
                                (#..........,#                                  
                                      (%,.....&                                 
                                                                                
                                                                                
 -}
