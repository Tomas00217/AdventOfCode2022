import std/deques
import std/strutils
import std/re
import std/algorithm

proc parseCrates(crateStructure: string): seq[Deque[string]] =
    var stacks: seq[Deque[string]]

    for i in 0..8:
        stacks.add(initDeque[string]())
    
    var crateLines = crateStructure.split("\n")
    for i in 0..<crateLines.len()-1:
        var line = crateLines[i]
        for j in 0..8:
            var crate = line[j*4 + 1]
            if $crate != " ":
                stacks[j].addFirst($crate)

    stacks

proc part1(amount: int, positionFrom:int, positionTo:int, stacks: var seq[Deque[string]]) = 
    for i in 0..<amount:
        var crate = stacks[positionFrom-1].popLast()
        stacks[positionTo-1].addLast(crate)

proc part2(amount: int, positionFrom:int, positionTo:int, stacks: var seq[Deque[string]]) =
    var crates: seq[string]

    for i in 0..<amount:
        var crate = stacks[positionFrom-1].popLast()
        crates.add(crate)

    for crate in reversed(crates):
        stacks[positionTo-1].addLast(crate)

proc solution(isFirstPart: bool) =
    var file = readFile("input.txt")
    var parts = file.split("\r\n\r\n")
    var crateStructure = parts[0]
    var moves = parts[1]

    var stacks = parseCrates(crateStructure)

    var moveLines = moves.split("\n")

    for line in moveLines:
        var nums = line.findAll(re"\d+")
        var amount = parseInt(nums[0])
        var positionFrom = parseInt(nums[1])
        var positionTo = parseInt(nums[2])

        if isFirstPart:
            part1(amount, positionFrom, positionTo, stacks)
        else:
            part2(amount, positionFrom, positionTo, stacks)

    var result = ""
    for i in 0..<stacks.len():
        result &= stacks[i].popLast()
    
    echo result


solution(true)
solution(false)