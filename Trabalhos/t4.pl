animal('gorila').
animal('gato').
animal('cachorro').
animal('chinchila').

play:-forall(animal(X), (write(X), nl)).

addAnimal:- read(Animal), assert(animal(Animal)). 