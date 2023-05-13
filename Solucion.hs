module Solucion where
-- Nombre de Grupo: Clemente
-- Integrante 1: André Viollaz, andre.viollaz@gmail.com,      870/23
-- Integrante 2: Alejo Parinelli,   alejoparinelli@gmail.com, 115/23
-- Integrante 3: Juan Pablo Tarela, juanptarela@gmail.com,    151/23
-- Integrante 4: Mateo Otazúa Arce, tazuarce@gmail.com,       88/23

{- TIPOS -}

type Usuario = (Integer, String) -- (id, nombre)
type Relacion = (Usuario, Usuario) -- usuarios que se relacionan
type Publicacion = (Usuario, String, [Usuario]) -- (usuario que publica, texto publicacion, likes)
type RedSocial = ([Usuario], [Relacion], [Publicacion])

{- BÁSICAS -}

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

{- EJERCICIOS -}

{- 1 -}

-- Dada una red, devuelve una lista con los nombres de los usuarios de esa red.
nombresDeUsuarios :: RedSocial -> [String]
nombresDeUsuarios redX = (proyectarNombres (usuarios(redX)))

proyectarNombres :: [Usuario] -> [String]
proyectarNombres [] = []
proyectarNombres (user:users) = (nombreDeUsuario user) : (proyectarNombres users)

{- 2 -}

-- Dada una red y uno de sus usuarios, devuelve una lista de los usuarios con quienes se relaciona. 
amigosDe :: RedSocial -> Usuario -> [Usuario]
amigosDe red user = amigosDeAux (relaciones red) user

-- Función auxiliar que hace recursión unicamente sobre los elementos que me interesan de la red social.
amigosDeAux :: [Relacion] -> Usuario -> [Usuario]
amigosDeAux [] _ = [] 
amigosDeAux (rel:rels) user 
    | user == fst rel = (snd rel) : restoDeAmigos 
    | user == snd rel = (fst rel) : restoDeAmigos 
    | otherwise       = restoDeAmigos
    where restoDeAmigos = amigosDeAux rels user

{- 3 -}

-- Dado un usuario y una red, indica la cantidad de amigos que tiene en la red.
cantidadDeAmigos :: RedSocial -> Usuario -> Int
cantidadDeAmigos redX user = longitud (amigosDe redX user)

{- 4 -}

-- Dada una red, devuelve su usuario con más amigos (si varios tienen la mayor cantidad, da uno de ellos)
usuarioConMasAmigos :: RedSocial -> Usuario
usuarioConMasAmigos redX = compararAmigos redX (usuarios(redX))

-- Función auxiliar que hace recursión comparando la cantidad de amigos de n-1 y n, devolviendo el que sea mayor
compararAmigos :: RedSocial -> [Usuario] -> Usuario
compararAmigos redX (user:users)
    | users == [] = user
    | (cantidadDeAmigos redX user) >= (cantidadDeAmigos redX (topUserOnRight)) = user
    | otherwise = (topUserOnRight)
    where topUserOnRight = compararAmigos redX users

{- 5 -}

-- Dada una red, devuelve True si tiene un usuario con mas de 10 amigos.
estaRobertoCarlos :: RedSocial -> Bool
estaRobertoCarlos red = cantidadDeAmigos red (usuarioConMasAmigos red) > 10

{- 6 -}

-- Dada una red y un usuario perteneciente a esta, devuelve una lista con todas sus publicaciones.
publicacionesDe :: RedSocial -> Usuario -> [Publicacion]
publicacionesDe (_, _, []) _ = [] 
publicacionesDe red user
    | user == usuarioDePublicacion pub = [pub] ++ restoDePubsDeUser
    | otherwise = [] ++ restoDePubsDeUser
    where (pub:pubs) = publicaciones red
          restoDePubsDeUser = publicacionesDe (usuarios red, relaciones red, pubs) user

{- 7 -}

-- Dada una red  una lista con las publicaciones que le gustaron al usuario
-- llamo a otra funcion que da la lista de publicaciones que le dio like el usuario
publicacionesQueLeGustanA :: RedSocial -> Usuario -> [Publicacion]
publicacionesQueLeGustanA red user = proyectarPublicaciones user (publicaciones red)          
                                                                                               
--verifico que el user le dio like si el user no dio like sigo comprobando con el resto de pubs 
proyectarPublicaciones :: Usuario -> [Publicacion] -> [Publicacion]
proyectarPublicaciones _ [] = []
proyectarPublicaciones user (pub:pubs)
    | pertenece user (likesDePublicacion pub) = pub : proyectarPublicaciones user pubs       
    | otherwise = proyectarPublicaciones user pubs                  

{- 8 -}

--- Dados dos usuarios, devuelve True si y solo si ambos dieron like a exactamente las mismas publicaciones de una red.
lesGustanLasMismasPublicaciones :: RedSocial -> Usuario -> Usuario -> Bool
lesGustanLasMismasPublicaciones red user1 user2 = dieronLikes user1 (publicacionesQueLeGustanA red user1) user2 (publicacionesQueLeGustanA red user2)

-- Esta funcion se encarga de verificar si ningun usuario le dio like a alguna publicacion
-- De no ser asi, emplea la funcion perteneceEnLikes
dieronLikes :: Usuario -> [Publicacion] -> Usuario -> [Publicacion] -> Bool
dieronLikes _ [] _ [] = True
dieronLikes _ [] _ _ = False
dieronLikes _ _ _ [] = False
dieronLikes user1 pubs1 user2 pubs2 = perteneceEnLikes user1 pubs2 && perteneceEnLikes user2 pubs1

-- Esta funcion comprueba que el usuario pertenezca a todas las lista de likes
-- Sin importar el orden
perteneceEnLikes :: Usuario -> [Publicacion] -> Bool
perteneceEnLikes _ [] = True
perteneceEnLikes user (pub:pubs) = pertenece user (likesDePublicacion pub) && perteneceEnLikes user pubs


{- 9 -}

-- Dada una red y un usuario, devuelve True si y solo si en las publicaciones de ese ususario en esa red hay otro usuario2 que le dio like a todas sus publicaciones.
tieneUnSeguidorFiel :: RedSocial -> Usuario -> Bool
tieneUnSeguidorFiel red user = seguidorFielEnPublicaciones (publicacionesDe red user) (quitar user (usuarios red))

--por la funcion likeoTodasLasPubs verifica si un usuario le dio like a todas las publicaciones de la lista.
--de no ser asi, prueba con el siguiente usuario de la lista
seguidorFielEnPublicaciones :: [Publicacion] -> [Usuario] -> Bool
seguidorFielEnPublicaciones _ [] = False                               
seguidorFielEnPublicaciones [] _ = False                                 
seguidorFielEnPublicaciones pubs (user:users)                            
    | likeoTodasLasPubs pubs user = True                                         
    | not (likeoTodasLasPubs pubs user) = seguidorFielEnPublicaciones pubs users

--esta funcion verifica si un usuario pertenece a la lista de likes de cada publicacion de un lista
likeoTodasLasPubs :: [Publicacion] -> Usuario -> Bool
likeoTodasLasPubs (pub:pubs) user
    | pubs == [] && pertenece user (likesDePublicacion pub) = True          
    | pertenece user (likesDePublicacion pub) = likeoTodasLasPubs pubs user 
    | otherwise = False

{- 10 -}

-- Dada una red y un user1 y un user2, devuelve True si y solo si existe alguna cadena de relaciones que cominece con user1 y termine con user2.
existeSecuenciaDeAmigos :: RedSocial -> Usuario -> Usuario -> Bool
existeSecuenciaDeAmigos red user1 user2 = existeSecuenciaDeAmigosAux red (amigosDe red user1) user2

-- Función auxiliar que recorre las relaciones de la red, quitando las ya visitadas hasta encontrar (o no) a user2.
existeSecuenciaDeAmigosAux :: RedSocial -> [Usuario] -> Usuario -> Bool
existeSecuenciaDeAmigosAux _ [] _ = False
existeSecuenciaDeAmigosAux red (user:users) user2
    | relaciones red == [] = False
    | pertenece user2 (user:users) = True
    | pertenece user2 (amigosDe red user) = True
    | otherwise = existeSecuenciaDeAmigosAux redSinUser (amigosDe red user) user2 || existeSecuenciaDeAmigosAux redSinUser users user2
    where redSinUser = (usuarios red, quitarRelacionesCon user (relaciones red), publicaciones red)

-- Función auxiliar que elimina de una lista de relaciones todas las relaciones que incluyen a un user dado.
quitarRelacionesCon :: Usuario -> [Relacion] -> [Relacion]
quitarRelacionesCon _ [] = []
quitarRelacionesCon user (rel:rels) 
    | user == fst rel || user == snd rel = relsSinUser
    | otherwise = rel : relsSinUser
    where relsSinUser = quitarRelacionesCon user rels

{- AUXILIARES -}


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