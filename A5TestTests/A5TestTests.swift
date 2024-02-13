//
//  A5TestTests.swift
//  A5TestTests
//
//  Created by Grace Flikke24 on 1/24/24.
//

import XCTest
@testable import A5Test

final class A5TestTests: XCTestCase {
    
    // test if returns the correct number of tokens
    func testNumTokens() {
        // given
        let phrase = "hello world!"
        
        // when ---- ! force unwraps the value so we can use the count method
        let wordsArray = tokenizePhrase(phrase)!
        let numTokens = wordsArray.count
        
        // then
        XCTAssertEqual(numTokens, 2)
    }
    
    // test if makes everything lowercase
    func testLowercase() {
        // given
        let phrase = "Hello woRld"
        
        // when
        let wordsArray = tokenizePhrase(phrase)!
        // there might be a better way to do this...but I'm not exactly sure how
        let word1 = wordsArray[0]
        let character1 = word1[word1.index(word1.startIndex, offsetBy: 0)]
        let word2 = wordsArray[1]
        let character2 = word2[word2.index(word2.startIndex, offsetBy: 2)]
        
        // then
        XCTAssertEqual(character1, "h")
        XCTAssertEqual(character2, "r")
    }
    
    // test if all whitespace is removed
    func testWhiteSpace() {
        // given
        let phrase = "hello    world"
        var numWhiteSpaces = 0
        
        // when
        let wordsArray = tokenizePhrase(phrase)!
        for word in wordsArray {
            for character in word {
                if (character.isWhitespace) {
                    numWhiteSpaces += 1
                }
            }
            
            // then ---- there might be a better way to test this? but I tried looking & this is the best I could come up with
            XCTAssertEqual(numWhiteSpaces, 0)
        }
    }
    
    // test if all punctuation is removed
    func testPunctuation() {
        // given
        let phrase = "hello, world!"
        
        // when
        let wordsArray = tokenizePhrase(phrase)!
        var numNonLetters = 0
        
        for word in wordsArray {
            for character in word {
                if (character.isLetter == false) {
                    numNonLetters += 1
                }
            }
        }
        
        // then ---- same as above, not sure if better way to do this
        XCTAssertEqual(numNonLetters, 0)
        
    }
    // test that just one word returns 1 token
    func testOneWord() {
        // given
        let phrase = "hello"
        
        // when
        let wordsArray = tokenizePhrase(phrase)!
        
        // then
        XCTAssertEqual(wordsArray.count, 1)
    }
    
    // test nil is returned when a empty string is entered
    func testEmptyString() {
        // given
        let phrase = "    "
        
        // when
        let wordsArray = tokenizePhrase(phrase)
        
        // then
        XCTAssertNil(wordsArray)
    }
    
    // word appears 1 time
    func testAppearsOnce() {
        let occurancesCount = countOccurances(["hi", "hello"], "hello")
        XCTAssertEqual(occurancesCount, 1)
    }
    
    // word appears multiple times
    func testAppearsMultiple() {
        let occurancesCount = countOccurances(["hello", "hi", "hello"], "hello")
        XCTAssertEqual(occurancesCount, 2)
    }
    
    // word doesn't appear
    func testDoesNotAppear() {
        let occurancesCount = countOccurances(["hello", "hi"], "goodbye")
        XCTAssertEqual(occurancesCount, 0)
    }
    
    // word is subset of string
    func testAppearsSubset() {
        let occurancesCount = countOccurances(["hello", "hi"], "ell")
        XCTAssertEqual(occurancesCount, 0)
    }
    
    // empty text or empty keyword
    func testEmptyStrings() {
        let occurancesCount = countOccurances([], "hi")
        XCTAssertNil(occurancesCount)
    }
    
    
    // test that returns correct count of keywords
    func testKeywordCount() {
        // given
        let wordsToAnalyze = ["hi", "hello", "goodbye", "hello", "hola", "adios"]
        
        // when
        let keywordCountArray = analyzeTextKeywords(text: wordsToAnalyze, keywords: ["hello", "goodbye"])
        
        // then
        XCTAssertEqual(keywordCountArray, [2, 1])
        
    }
    
    // test that no keywords returns array of 0
    func testNoKeywords() {
        // given
        let wordsToAnalyze = ["hi", "hello", "goodbye", "hello", "hola", "adios"]
        
        // when
        let keywordCountArray = analyzeTextKeywords(text: wordsToAnalyze, keywords: ["swift", "code"])
        
        // then
        XCTAssertEqual(keywordCountArray, [0, 0])
    }
    
    // test that no text returns array of 0
    func testNoText() {
        // given
        let wordsToAnalyze: [String] = []
        // when
        let keywordCountArray = analyzeTextKeywords(text: wordsToAnalyze, keywords: ["swift", "code"])
        // then
        XCTAssertEqual(keywordCountArray, [0, 0])
    }
    
    // test that empty keywords returns empty array
    func testEmptyKeywords() {
        // given
        let wordsToAnalyze = ["hi", "hello", "goodbye", "hello", "hola", "adios"]
        // when
        let keywordCountArray = analyzeTextKeywords(text: wordsToAnalyze, keywords: [])!
        
        // then
        XCTAssertEqual(keywordCountArray.count, 0)
    }
    
    
    // tests that correct weight is computed
    func testCorrectWeight() {
        let weight = computeTextWeight(counts: [1, 2, 3], weights: [1, 2, 3])
        XCTAssertEqual(weight, 14)
    }
    
    // tests that empty array returns 0
    func testEmptyArrays() {
        let weight = computeTextWeight(counts: [], weights: [])
        XCTAssertEqual(weight, 0)
    }
    

    // tests that array lengths that don't match returns error
    func testDifferentLengths() {
        let weight = computeTextWeight(counts: [0, 1], weights: [0, 1, 2])
        XCTAssertNil(weight)
    }

    
    // tests for each label based on value input
    func testStronglyNegative() {
        let category = categorizeValue(value: -15)
        XCTAssertEqual(category, "Strongly Negative")
    }
    
    func testNegative() {
        let category = categorizeValue(value: -2)
        XCTAssertEqual(category, "Negative")
    }
    
    func testNeutral() {
        let category = categorizeValue(value: 1)
        XCTAssertEqual(category, "Neutral")
    }
    
    func testPositive() {
        let category = categorizeValue(value: 14)
        XCTAssertEqual(category, "Positive")
    }
    
    func testStronglyPositive() {
        let category = categorizeValue(value: 15)
        XCTAssertEqual(category, "Strongly Positive")
    }
}
