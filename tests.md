# Tests

## General

```prolog
Nono=[[verd,lila,vermell,vermell],[blau,verd,blau,blau],[lila,blau,verd,verd],[verd,blau,vermell,verd]].
```

```prolog
Nono=[[verd,lila,vermell,vermell],
[blau,verd,blau,blau],
[lila,blau,verd,verd],
[verd,blau,vermell,verd]].
```

## Transpuesta de una matriz

```prolog
transposeMatrix([[1,2],[3,4]], L).
transposeMatrix([[1,2,3],[4,5,6],[7,8,9]], L).
```

## P1

```prolog
escriuNonograma([[verd,lila,vermell,vermell],[blau,verd,blau,blau],[lila, blau,verd,verd],[verd,blau,vermell, verd]]).
```

## P2

```prolog
mostraNonograma([[verd,lila,vermell,vermell],[blau,verd,blau,blau],[lila, blau,verd,verd],[verd,blau,vermell, verd]], 3, 5, 3, 1).
```

## P3

```prolog
ferNonograma([verd,blau,vermell],3,4,Nono).
```

## P4

```prolog
descriuNonograma([[verd,lila,vermell,vermell],[blau,verd,blau,blau],[lila,blau,verd,verd],[verd,blau,vermell,verd]], L).
```

## P5

```prolog
[
    [
        [[seguits, verd, 1], [seguits, lila, 1], [seguits, vermell, 2]],
        [[no_seguits, blau, 3], [seguits, verd, 1]],
        [[seguits, lila, 1], [seguits, blau, 1], [seguits, verd, 2]],
        [[no_seguits, verd, 2], [seguits, blau, 1], [seguits, vermell, 1]]
    ],
    [
        [[no_seguits, verd, 2], [seguits, blau, 1], [seguits, lila, 1]],
        [[seguits, lila, 1], [seguits, verd, 1], [seguits, blau, 2]],
        [[no_seguits, vermell, 2], [seguits, blau, 1], [seguits, verd, 1]],
        [[seguits, vermell, 1], [seguits, blau, 1], [seguits, verd, 2]]
    ]
]
```

```prolog
mostraPistesHorizontals([
    [
        [[seguits, verd, 1], [seguits, lila, 1], [seguits, vermell, 2]],
        [[no_seguits, blau, 3], [seguits, verd, 1]],
        [[seguits, lila, 1], [seguits, blau, 1], [seguits, verd, 2]],
        [[no_seguits, verd, 2], [seguits, blau, 1], [seguits, vermell, 1]]
    ],
    [
        [[no_seguits, verd, 2], [seguits, blau, 1], [seguits, lila, 1]],
        [[seguits, lila, 1], [seguits, verd, 1], [seguits, blau, 2]],
        [[no_seguits, vermell, 2], [seguits, blau, 1], [seguits, verd, 1]],
        [[seguits, vermell, 1], [seguits, blau, 1], [seguits, verd, 2]]
    ]
], 5,5 ,1, 1).
```

```prolog
mostraPistesVerticals([
    [
        [[seguits, verd, 1], [seguits, lila, 1], [seguits, vermell, 2]],
        [[no_seguits, blau, 3], [seguits, verd, 1]],
        [[seguits, lila, 1], [seguits, blau, 1], [seguits, verd, 2]],
        [[no_seguits, verd, 2], [seguits, blau, 1], [seguits, vermell, 1]]
    ],
    [
        [[no_seguits, verd, 2], [seguits, blau, 1], [seguits, lila, 1]],
        [[seguits, lila, 1], [seguits, verd, 1], [seguits, blau, 2]],
        [[no_seguits, vermell, 2], [seguits, blau, 1], [seguits, verd, 1]],
        [[seguits, vermell, 1], [seguits, blau, 1], [seguits, verd, 2]]
    ]
], 5,5 ,1, 1).
```

```prolog
[
    [
        [seguits,verd,1],[seguits,lila,1],[seguits,vermell,2]
    ],
    [
        [no_seguits,blau,3],[seguits,verd,1]
    ],
    [
        [seguits,lila,1],[seguits,blau,1],[seguits,verd,2]
    ],
    [
        [no_seguits,verd,2],[seguits,blau,1],[seguits,vermell,1]
    ]
]
```

```prolog
[
    [
        [no_seguits,blau,3],[seguits,verd,1]
    ],
    [
        [seguits,lila,1],[seguits,blau,1],[seguits,verd,2]
    ],
    [
        [no_seguits,verd,2],[seguits,blau,1],[seguits,vermell,1]
    ]
]
```

## P6

```prolog
resolNonograma([
    [
        [[seguits, verd, 1], [seguits, lila, 1], [seguits, vermell, 2]],
        [[no_seguits, blau, 3], [seguits, verd, 1]],
        [[seguits, lila, 1], [seguits, blau, 1], [seguits, verd, 2]],
        [[no_seguits, verd, 2], [seguits, blau, 1], [seguits, vermell, 1]]
    ],
    [
        [[no_seguits, verd, 2], [seguits, blau, 1], [seguits, lila, 1]],
        [[seguits, lila, 1], [seguits, verd, 1], [seguits, blau, 2]],
        [[no_seguits, vermell, 2], [seguits, blau, 1], [seguits, verd, 1]],
        [[seguits, vermell, 1], [seguits, blau, 1], [seguits, verd, 2]]
    ]
], S).
```