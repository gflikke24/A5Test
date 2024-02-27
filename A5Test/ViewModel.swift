//
//  ViewModel.swift
//  A5Test
//
//  Created by Grace Flikke24 on 1/24/24.
//

import Foundation

class TextAnalysisLogic: ObservableObject {
    @Published var response: String = ""
    @Published var emotionWord: String = ""
    
    @Published var showTextView = true
    @Published var showAnalysisView = false
    
    @Published var tokenArray: [String] = [""]
    @Published var countArray: [Int] = []
    @Published var responseWeight: Int = 0
    @Published var sentiment: String = ""
    @Published var quote: String = ""

    @Published var keywords : [String] = ["alert","inspired","determined","attentive","active","afraid","nervous","upset","guilty","hostile","enthusiastic","proud","strong","scared","irritable","ashamed","interested","distressed","excited","jittery","vigilant","ashamed","inspired","nervous","determined","attentive","jittery","active","afraid","proud","happy","content","joyful","excited","grateful","stressed","anxious","calm","overwhelmed","relaxed","sad","melancholy","hopeful","despair","frustrated","satisfied","bored","curious","insecure","confident","angry","annoyed","apathetic","motivated","discouraged","elated","gloomy","inspired","lonely","connected","tired","amazing", "wonders", "worst","terrible","incredible","marvelous","disastrous","horrific","exceptional","delightful","catastrophic","appalling","exhilarating","pleasant","unpleasant","depressing","satisfying","frustrating","joyous","troubling","blissful","annoying","enthralling","dreadful","inspiring","distressing","thrilling","displeasing","heartwarming","alarming","dope","epic","trash","woke","cancelled","goat","legit","ratchet","squad goals","trolled","winning","fail","glow up","hater","on point","overrated","slept on","stoked","try-hard","whack","dank","clapped","fire","litty","shady","boujee","poppin'","canceled","cheugy","stan","toxic","bomb","cringey","lit","meh","chill","hyped","cringe","ghosted","salty","vibing","lame","basic","thirsty","slay","fire","snatched","fomo","gucci","sus","bussin","bet","radical","gnarly","bogus","groovy","wicked","lame","fly","phat","bummer","chill","square","psyched","stoked","dweeb","tight","fresh","cheesy","slick","beat","copacetic","hella","busted","slammin","radical","tubular","spaz","trippin'","cancelled","sleepy","tired","intrigued","curious","bored","relaxed","energized","drained","interested","indifferent","focused","distracted","excited","apathetic", "great", "bad"]
    
    @Published var values : [Int] = [3,4,4,3,3,-4,-4,-5,-3,-5,5,4,4,-4,-4,-3,4,-5,5,-4,3,-4,5,-4,4,3,-3,3,-5,4,5,4,5,4,3,-4,-5,3,-4,4,-5,-3,4,-5,-4,3,-2,3,-4,5,-5,-3,-3,4,-4,5,-4,5,-5,4,-2, 5, 4, -5, -4, 5, 4, -5, -4, 5, 4,-5,-4,5,3,-3,-5,3,-3,5,-3,5,-2,4,-5,4,-4,5,-2,4,-3,3,3,-3,2,-3,3,2,-2,3,-3,3,-3,3,-2,3,-2,2,3,-2,-3,2,-3,3,3,-2,-1,3,-3,-2,3,-3,3,-3,3,0,2,3,-3,-4,-2,2,-3,-2,-2,3,3,2,-3,2,-2,3,1,3,2,-3,3,3,-3,3,2,-2,2,-2,3,3,-2,2,2,-2,2,-2,2,2,-3,3,3,3,-2,-1,-3,0,-1,2,2,-2,2,3,-3,2,0,2,-2,3,-2,3, -3]
    
    @Published var phrases: [String: [String]] = [
        "Strongly Positive": [
            "You're vibing high and inspiring others to reach for their best selves. Keep shining, your energy is magnetic!",
            "Your positivity is like a superpower, transforming challenges into opportunities. Keep this flow going!",
            "Like the brightest star in the night sky, your positivity lights the way for yourself and others. Shine on!",
            "Your energy is a beacon of hope and inspiration. Continue to spread your light wherever you go.",
            "The universe celebrates your radiant spirit. Keep harnessing this positive energy to uplift those around you."
        ],
        "Positive": [
            "You've got that glow of someone who's found their flow. Keep riding this wave of positivity and see where it takes you.",
            "Your positive mindset is your ticket to every adventure. Stay open, stay curious, and watch the universe align for you.",
            "Every step forward is a step towards your dreams. Keep moving with this positive momentum!",
            "Positivity is your superpower, turning everyday moments into magic. Keep weaving this magic into your life.",
            "The seeds of positivity you plant today will bloom into tomorrow's joys. Keep nurturing your garden of positivity."
        ],
        "Neutral": [
            "Embracing the pause between the highs and lows is where growth happens. You're exactly where you need to be.",
            "Neutral is the new starting line. From here, you can sprint or stroll into your next chapter with clarity and purpose.",
            "In stillness, we find our strength. Your calm center is a powerful force for navigating life's ups and downs.",
            "Balance is not something you find; it's something you create. Your equilibrium is a testament to your wisdom.",
            "The beauty of neutrality is in its potential. What wonderful path will you choose from this balanced place?"
        ],
        "Negative": [
            "It's okay to not be okay. Honor your feelings, breathe through them, and remember, you're stronger than your toughest day.",
            "Turn your challenges into your teachers. Each breath is a new beginning, a chance to reset and rise again.",
            "Dark clouds may hover, but they bring the rain that nourishes growth. Embrace the growth, even when it's hard.",
            "Remember, it's during our struggles that we often grow the most. You are being shaped into something even more amazing.",
            "Feelings are like waves: they come and go. Let yourself feel, but don't forget, brighter days are on the horizon."
        ],
        "Strongly Negative": [
            "In the shadows, we find our inner light. Trust the process, lean into self-care, and watch yourself emerge stronger.",
            "Life's toughest storms prove the strength of our anchors. Hold fast to your inner calm; this too shall pass, leaving you more grounded than ever.",
            "Even in the darkest moments, your spirit's light can shine through. Find that light within, it will guide you home.",
            "Your resilience in the face of adversity is your true strength. This challenge is but a chapter in your epic story.",
            "Pain and struggle are part of the journey, but they are not the entire story. Keep turning the pages, a new chapter awaits."
        ]
    ]

    func saveTextInput(text: String) {
        response = text
    }
    
    // tokenizePhrase function
    func tokenizePhrase(_ text: String)->[String]? {
        // make all text lowercase
        let lowercasedText = text.lowercased()
        // remove punctuation BUT keep whitespace
        let noPunctuationString = lowercasedText.filter({ $0.isLetter == true || $0.isWhitespace == true})
        // split into array of strings & remove empty strings
        let wordArray = noPunctuationString.split(separator: " ", omittingEmptySubsequences: true)
        // return nil if there is nothing left of the string (the string was all whitespace)
        if (wordArray.count == 0) {
            return nil
        }
        let stringWordArray: [String] = wordArray.map({String($0)})
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
    
    func chooseQuote(text: String) {
        quote = (phrases[text]?.randomElement())!
    }
    
    func analyzePhrase() {
        tokenArray = tokenizePhrase(response)!
        countArray = analyzeTextKeywords(text: tokenArray, keywords: keywords)!
        responseWeight = computeTextWeight(counts: countArray, weights: values)!
        sentiment = categorizeValue(value: responseWeight)
        chooseQuote(text: sentiment)
    }
}






