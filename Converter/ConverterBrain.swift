//
//  ConverterBrain.swift
//  Converter
//
//  Created by Simon Anthony on 30/01/2015.
//  Copyright (c) 2015 Simon Anthony. All rights reserved.
//

import Foundation

class ConverterBrain {
// reference arrays of digits allowed for each base
    private let binaryDigits = ["0", "1"]
    private let decimalDigits = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    private let hexadecimalDigits = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"]
    private var asciiCharacters = [String: (String, Int, String)]()
    
    private let maxDigitsBin = 32
    private let maxDigitsDec = 9
    private let maxDigitsHex = 8
    
    private var mode = 0
    private var inputStack = [String]()
    
    private var binOutput = String()
    private var decOutput = String()
    private var hexOutput = String()
    private var asciiOutput = String()
    
    init() {
        // fill dictionary with an ascii key and corresponding values in binary, decimal and hexadecimal
        for i in 32..<127 {
            var key = ""
            key.append(Character(UnicodeScalar(i)))
            var bin = String(i, radix: 2)
            var hex = String(i, radix: 16)
            asciiCharacters[key] = (bin, i, hex)
        }
    }
    
// appendDigit - appends selected digit to inputStack for converting
    func appendDigit(digit: String) -> String {
        var formattedStack = String()
        switch mode {
        case 0:
            if (contains(binaryDigits, digit)) && (countElements(inputStack) < maxDigitsBin) {
                inputStack.append(digit)
            }
            return formatNumber(formatArrayToString(inputStack), insert: " ", spacing: 8).0
        case 1:
            if (contains(decimalDigits, digit)) && (countElements(inputStack) < maxDigitsDec) {
                inputStack.append(digit)
            }
            return formatNumber(formatArrayToString(inputStack), insert: ",", spacing: 3).0
        case 2:
            if (contains(hexadecimalDigits, digit)) && (countElements(inputStack) < maxDigitsHex) {
                inputStack.append(digit)
            }
            return formatNumber(formatArrayToString(inputStack), insert: " ", spacing: 2).0
        default:
            return "ERROR"
        }
    }
    
// setMode - select between binary, decimal or hex input modes
    func setMode(newMode: Int) -> Bool {
        mode = newMode
        clearStack()
        return true
    }
    
// clearStack - clears the current operation
    func clearStack() {
        inputStack.removeAll()
    }
    
// convertValue - takes current inputStack and converts to different base (bin, dec, hex) outputting result as a string
    func convertValue() -> (String, String, String, String) {
        var result: (String, String, String, String)
        var formattedString = String()
        
        formattedString = formatArrayToString(inputStack)
        
        switch mode {
        case 0:
            let temp = formatNumber(formattedString, insert: " ", spacing: 8)
            result.0 = formatLeadingZeros(temp.0, digits: temp.1)
            result.1 = formatNumber(bin2dec(result.0), insert: ",", spacing: 3).0
            result.2 = formatNumber(bin2hex(formattedString), insert: " ", spacing: 2).0
            result.3 = "ASCII"
        case 1:
            let binaryConversion = formatNumber(dec2bin(formattedString), insert: " ", spacing: 8)
            result.0 = formatLeadingZeros(binaryConversion.0, digits: binaryConversion.1)
            result.1 = formatNumber(formattedString, insert: ",", spacing: 3).0
            result.2 = formatNumber(bin2hex(dec2bin(formattedString)), insert: " ", spacing: 2).0
            result.3 = "ASCII"
        case 2:
            let temp = formatNumber(hex2bin(inputStack), insert: " ", spacing: 8)
            result.0 = formatLeadingZeros(temp.0, digits: temp.1)
            result.1 = formatNumber(bin2dec(temp.0), insert: ",", spacing: 3).0
            result.2 = formatNumber(formattedString, insert: " ", spacing: 2).0
            result.3 = "ASCII"
        case 3:
            result = ascii2all("Surprise!!!")
        default:
            return ("ERROR", "ERROR", "ERROR", "ERROR")
        }
        clearStack()
        return result
    }
    
// bin2dec - converts binary string into decimal string
    func bin2dec(input: String) -> String {
        var counter = countElements(input)
        var digit: Character
        var power = 1
        var result = 0
        
        let binary = input
        let number = strtol(binary, nil, 2)
        println(number)
        
        return ("\(number)")
        
//        while counter > 0 {
//            digit = input[advance(input.startIndex, counter-1)]
//            
//            switch digit {
//            case "0":
//                result += 0
//            case "1":
//                result += 1 * power
//            default:
//                power = power / 2
//                break
//            }
//            counter--
//            power *= 2
//        }
//        return "\(result)"
    }
    
// dec2bin - converts decimal string into binary string
    func dec2bin(input: String) -> String {
        var inputInt = input.toInt()!
        var divideCount = 0
        var result = ""
        
        while inputInt > 0 {
            if inputInt % 2 == 1 {
                result = "1" + result
            } else {
                result = "0" + result
            }
            inputInt = inputInt / 2
        }
        return result
    }
    
// hex2bin - converts hexadecimal String Array to binary string
    func hex2bin(input: [String]) -> String {
        var output = String()
        
        for count in 0...countElements(input)-1 {
            switch input[count] {
            case "0":
                output = output + "0000"
            case "1":
                output = output + "0001"
            case "2":
                output = output + "0010"
            case "3":
                output = output + "0011"
            case "4":
                output = output + "0100"
            case "5":
                output = output + "0101"
            case "6":
                output = output + "0110"
            case "7":
                output = output + "0111"
            case "8":
                output = output + "1000"
            case "9":
                output = output + "1001"
            case "A":
                output = output + "1010"
            case "B":
                output = output + "1011"
            case "C":
                output = output + "1000"
            case "D":
                output = output + "1101"
            case "E":
                output = output + "1110"
            case "F":
                output = output + "1111"
            default:
                break
            }
        }
        return output
    }
    
// bin2hex - converts binary string to hexadecimal string
    func bin2hex(input: String) -> String {
        var output = String()
        var binaryString = formatLeadingZeros(input, digits: countElements(input))
        var counter = countElements(binaryString)
        var temp: String
        
        var indexEnd = counter
        var indexStart = indexEnd - 4
        
        while indexStart >= 0 {
            temp = binaryString.substringWithRange(Range<String.Index>(
                start: advance(binaryString.startIndex, indexStart),
                end: advance(binaryString.startIndex, indexEnd)
                ))
            switch temp {
            case "0000":
                output = "0" + output
            case "0001":
                output = "1" + output
            case "0010":
                output = "2" + output
            case "0011":
                output = "3" + output
            case "0100":
                output = "4" + output
            case "0101":
                output = "5" + output
            case "0110":
                output = "6" + output
            case "0111":
                output = "7" + output
            case "1000":
                output = "8" + output
            case "1001":
                output = "9" + output
            case "1010":
                output = "A" + output
            case "1011":
                output = "B" + output
            case "1100":
                output = "C" + output
            case "1101":
                output = "D" + output
            case "1110":
                output = "E" + output
            case "1111":
                output = "F" + output
            default:
                break
            }
            indexEnd -= 4
            indexStart -= 4
        }
        return output
    }
    
// ascii2dec - converts ascii characters to corresponding decimal values
    func ascii2all(input: String) -> (String, String, String, String) {
        let asciiInput = input
        var counter = countElements(asciiInput)
        var output: (String, String, String, String) = ("", "", "", "")
        
        output.3 = asciiInput
        
        for i in 0..<counter {
            let char = asciiInput.substringWithRange(Range<String.Index>(
                start: advance(asciiInput.startIndex, i),
                end: advance(asciiInput.startIndex, i + 1)))
            if let temp = asciiCharacters[char] {
                output.0 = output.0 + " " + temp.0
                output.1 = output.1 + " \(temp.1)"
                output.2 = output.2 + " " + temp.2
            }
        }
        return output
    }
    
// formatArrayToString - removes array characters when printed as a string [ ,]
    func formatArrayToString(stackArray: [String]) -> String {
        var stackString = "\(stackArray)"
        stackString = stackString.stringByReplacingOccurrencesOfString("[", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        stackString = stackString.stringByReplacingOccurrencesOfString("]", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        stackString = stackString.stringByReplacingOccurrencesOfString(",", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        stackString = stackString.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        return stackString
    }
    
// formatNumber - format decimal number to thousands inserting commas
    func formatNumber(input: String, insert: String, spacing: Int) -> (String, Int) {
        var digitCount = countElements(input)
        var indexEnd = digitCount
        var indexStart = indexEnd - spacing
        var output = ""
        
        while indexStart > 0 {
            output = insert
                + input.substringWithRange(Range<String.Index>(
                    start: advance(input.startIndex, indexStart),
                    end: advance(input.startIndex, indexEnd)
                    ))
                + output
            indexStart -= spacing
            indexEnd -= spacing
        }
        if (indexStart <= 0) {
            output = input.substringWithRange(Range<String.Index>(
                start: advance(input.startIndex, 0),
                end: advance(input.startIndex, indexEnd)
                ))
                + output
        }
        //println("Input: \(input) -- Output: \(output) -- Insert: \(insert) -- Spacing: \(spacing)")
        return (output, digitCount)
    }
    
// formatLeadingZeros - inserts spaces after every 4 bits
    func formatLeadingZeros(input: String, digits: Int) -> String {
        var output = input
        var counter = digits
        while counter % 8 != 0 {
            output = "0" + output
            counter += 1
        }
        return output
    }
    
// substringByLength - splits a string sequence into multiple substrings of a given length
    func substringByLength(input: String, spacing: Int) -> [String] {
        var totalLength = countElements(input)
        var indexEnd = totalLength
        var indexStart = indexEnd - spacing
        var output = [String]()
        
        while indexStart > 0 {
            output.append(input.substringWithRange(Range<String.Index>(
                    start: advance(input.startIndex, indexStart),
                    end: advance(input.startIndex, indexEnd)
                    )))
            indexStart -= spacing
            indexEnd -= spacing
        }
        if (indexStart <= 0) {
            output.append(input.substringWithRange(Range<String.Index>(
                start: advance(input.startIndex, 0),
                end: advance(input.startIndex, indexEnd)
                )))
        }
        return output
    }
    
    
    
    
    
    
    
}