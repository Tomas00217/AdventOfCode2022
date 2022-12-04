import std/strutils

proc first(elf1Min: int, elf1Max: int, elf2Min: int, elf2Max:int, c: int): int = 
    return (if (elf1Min <= elf2Min and elf1Max >= elf2Max) or (elf1Min >= elf2Min and elf1Max <= elf2Max): c + 1 else: c)

proc second(elf1Min: int, elf1Max: int, elf2Min: int, elf2Max:int, c: int): int = 
    return (if (elf1Max < elf2Min) or (elf2Max < elf1Min): c else: c + 1)

proc solution() =
    var part1 = 0
    var part2 = 0

    for line in lines "input.txt":
        let ranges = line.split(',')
        let (elf1Min, elf1Max) = (parseInt(ranges[0].split('-')[0]), parseInt(ranges[0].split('-')[1]))
        let (elf2Min, elf2Max) = (parseInt(ranges[1].split('-')[0]), parseInt(ranges[1].split('-')[1]))
        part1 = first(elf1Min, elf1Max, elf2Min, elf2Max, part1)
        part2 = second(elf1Min, elf1Max, elf2Min, elf2Max, part2)

    echo "Part 1: ", part1
    echo "Part 2: ", part2

solution()