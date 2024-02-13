//
//  ViewModel.swift
//  A5Test
//
//  Created by Grace Flikke24 on 1/24/24.
//

import Foundation

// tokenizePhrase function
func tokenizePhrase(_ text: String)->[String]? {
    // make all text lowercase
    var lowercasedText = text.lowercased()
    // remove punctuation BUT keep whitespace
    var noPunctuationString = lowercasedText.filter({ $0.isLetter == true || $0.isWhitespace == true})
    // split into array of strings & remove empty strings
    var wordArray = noPunctuationString.split(separator: " ", omittingEmptySubsequences: true)
    // return nil if there is nothing left of the string (the string was all whitespace)
    if (wordArray.count == 0) {
        return nil
    }
    var stringWordArray: [String] = wordArray.map({String($0)})
    /*
    // loop through array & remove all punctuation
    for index in splitStringArray.indices {
        var currentString = String(index)
        var currentIndex = 0
        // loop through each character in the word, if not a letter then remove it from the string
        for character in currentString {
            if character.isLetter == false {
                currentString.remove(at: currentString.index(currentString.startIndex, offsetBy: currentIndex))
                
                currentIndex -= 1
            }
            currentIndex += 1
        }
        splitStringArray[index] = currentString
        
    }
    */
    // return array
    return stringWordArray
}

// counts occurences of keyword
func countOccurances(_ text: [String], _ keyword: String) -> Int? {
    if (text.isEmpty || keyword.isEmpty) {
        return nil
    }
    var numOccurences = 0
    // loop through and see if each word in array matches keyword, if so add 1 to the count
    for word in text {
        if (word == keyword) {
            numOccurences += 1
        }
    }
    return numOccurences
}

// function to count number of times each word appears & returns it in an array
func analyzeTextKeywords(text: [String], keywords: [String]) -> [Int]? {
    // make array to store values, same length as keywords array
    var countArray = Array(repeating: 0, count: keywords.count)
    if (keywords.count == 0) {
        return []
    }
    // so this was trying to use the countOccurances function but there where problems when it returned nil so I'm not using it
    /*
    var index = 0
    // run countOccurances for each keyword & store the value
    for word in keywords {
        var numOccurances: Int? = countOccurances(text, word)!
        print(numOccurances)
        if (numOccurances == nil) {
            return nil
        } else {
            print(text)
            print(word)
            countArray[index] = numOccurances!
            print(countArray)
            index += 1
        }
    }
     */
    var index = 0
    // loop through text for each keyword
    for keyword in keywords {
        for word in text {
            // each time check if keyword matches text, if so then increase the value stored in countArray
            if (word == keyword) {
                countArray[index] += 1
            }
        }
        index += 1
    }
    return countArray
}

// function to calculate the weights of the text
func computeTextWeight(counts: [Int], weights: [Int]) -> Int? {
    // first check if same length & if 0
    if (counts.count != weights.count) {
        // WHAT DOES RAISES AN ERROR MEAN??? RETURN NILL???
        return  nil
    } else if (counts.count == 0) {
        return 0
    }
    // make some way to store multiplied values
    var countTimesWeight = Array(repeating: 0, count: counts.count)
    for index in counts.indices {
        countTimesWeight[index] = counts[index]*weights[index]
    }
    // add multiplied values together
    let weight = countTimesWeight.reduce(0, {x, y in x + y})
    // return total weight
    return weight
}

// function that categorizes based on weight
func categorizeValue(value: Int) -> String {
    if (value <= -15) {
        return "Strongly Negative"
    } else if (value <= -2) {
        return "Negative"
    } else if (value <= 1) {
        return "Neutral"
    } else if (value <= 14) {
        return "Positive"
    } else {
        return "Strongly Positive"
    }
}






