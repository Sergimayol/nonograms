# Práctica 2: Lenguajes de programación

## TODO

- [x] Tarea 1 - 0.5
- [x] Tarea 2 - 1.5
- [x] Tarea 3 - 1.5
- [x] Tarea 4 - 2.5
- [x] Tarea 5 - 2.0
- [ ] Tarea 6 - 2.0
- [ ] Documentar funciones auxiliares en código.

## Anotaciones

No se si en la tarea 5, en las funciones se le pasa la descripción entera, o solo una de ellas.

Si solo se le pasa una de ellas quedaría la función de la siguiente forma:

```prolog
mostraPistesHoritzontals(DescHo, F, C, FInc, CInc):-
    cls,
    showHints(DescHo, F, C, FInc, CInc).

mostraPistesVerticals(DescVer, F, C, FInc, CInc):-
    cls,
    showHints(DescVer, F, C, FInc, CInc).
```