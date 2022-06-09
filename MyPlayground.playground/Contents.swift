import UIKit

func findPair(value: Int) -> [Int] {
    let array = [8, 10, 2, 9, 7, 5]
    var firstNumber: Int = array[0]
    var secondNumber: Int?
    
    outer: for i in 0..<array.count - 1 {
        firstNumber = array[i]
        for j in i..<array.count  {
            if array[i] + array[j] == value {
                secondNumber = array[j]
                break outer
            }
        }
    }
    if let secondNumber = secondNumber {
        return [firstNumber, secondNumber]
    } else {
        return [-1]
    }
}

print(findPair(value: 11))
