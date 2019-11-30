struct Position {
    var xPosition: Int
    var yPosition: Int
}

enum Direction {
    case Left
    case Right
    case Up
    case Down
}

struct Go: CustomStringConvertible {
    let direction: Direction
    let distance: Int

    var description: String {
        return "direction: \(direction), distance: \(distance)"
    }
}

class Car: CustomStringConvertible {
    let model: String
    var position: Position

    init(model: String, position: Position) {
        self.model = model
        self.position = position
    }

    func move(direction: Direction, distance: Int) {
        switch direction {
        case Direction.Left:
            self.position.xPosition -= distance
        case Direction.Right:
            self.position.xPosition += distance
        case Direction.Up:
            self.position.yPosition += distance
        case Direction.Down:
            self.position.yPosition -= distance
        }
    }

    func execute(command: Go) {
        self.move(direction: command.direction, distance: command.distance)
    }

    var description: String {
        return "x: \(position.xPosition), y: \(position.yPosition)"
    }
}

var car = Car(model: "ModelS", position: Position(xPosition: 2, yPosition: 5))
print(car)
let command = Go(direction: Direction.Down, distance: 3)
print(command)
car.execute(command: command)
print(car)


extension String {
    static func random(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""
        while randomString.count < length {
            randomString.append(letters.randomElement()!)
        }
        return randomString
    }
}

let a = String.random(length: 6)
print(a)


let cafe = "Café du 🌍"
print(cafe)
// Prints "Café du 🌍"

print(cafe.unicodeScalars.count)
print(cafe.utf16)


extension Array{
    mutating func myShuffle(){
        let indexes = 0..<count
        indexes.forEach{ swapAt($0, indexes.randomElement()!) }
    }

    func myShuffled() -> Array{
        var shuffledCopy = self;
        shuffledCopy.myShuffle()
        return shuffledCopy
    }
}

import Foundation

func calcLetters(str: String) -> [String: Int] {
//    return str.components(separatedBy: " ")
    let words = str.split{ !$0.isLetter }
    return words.reduce(into: [String: Int]()) { res, item in
        res[String(item)] = (res[String(item)] ?? 0) + 1
    }
//    print(words)
//    return ["a": 2]
}

var arr = [1, 2, 3, 4, 5]
print(arr)
arr.myShuffle()
print(arr)
print(arr.myShuffled())

print(calcLetters(str: "a a  b b  cc  cdd cc cc a x, ynm"))
