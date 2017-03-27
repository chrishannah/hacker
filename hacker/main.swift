//
//  main.swift
//  hacker
//
//  Created by Christopher Hannah on 27/03/2017.
//  Copyright © 2017 Christopher Hannah. All rights reserved.
//

import Foundation

let arguments = CommandLine.arguments

let hackerNews = HackerNews()

func printUsage() {
    print("Usage: hacker [options]")
    print("")
    print("Options:")
    print("")
    print("    -n, --new        The newest 20 submissions.")
    print("    -t, --top        The current top 20 submissions.")
    print("    -b, --best       The current best 20 submissions.")
    print("    -h, --help       Output this usage guide.")
    print("")
    print("Example:")
    print("")
    print("    hacker --new")
    print("")
}

func getNumberEmoji(_ number: Int) -> String {
    let numberString = "\(number)"
    var emojiString = ""
    for char in numberString.characters {
        switch (char) {
        case "0":
            emojiString.append("0️⃣ ")
            break
        case "1":
            emojiString.append("1️⃣ ")
            break
        case "2":
            emojiString.append("2️⃣ ")
            break
        case "3":
            emojiString.append("3️⃣ ")
            break
        case "4":
            emojiString.append("4️⃣ ")
            break
        case "5":
            emojiString.append("5️⃣ ")
            break
        case "6":
            emojiString.append("6️⃣ ")
            break
        case "7":
            emojiString.append("7️⃣ ")
            break
        case "8":
            emojiString.append("8️⃣ ")
            break
        case "9":
            emojiString.append("9️⃣ ")
            break
        default:
            break
        }
    }
    return emojiString
}

func printItems(_ type: HackerNews.ListType) {
    var items: [Int] = []
    
    switch(type) {
    case .Top:
        items = hackerNews.getTopList()
        break
    case .Best:
        items = hackerNews.getBestList()
        break
    case .New:
        items = hackerNews.getNewList()
        break
    }
    
    for num in 0...19 {
        let story = hackerNews.getStory(id: items[num])
        print("\(getNumberEmoji(num+1)):")
        print("📰  \(story.title)")
        print("🔗  \(story.url)")
        print("🗣  \(story.by)")
        print("📈  \(story.score)")
        print("")
    }
}


if (arguments.count) == 2 {
    switch (arguments[1]) {
    case "-n":
        printItems(.New)
        break
    case "--new":
        printItems(.New)
        break
    case "-t":
        printItems(.Top)
        break
    case "--top":
        printItems(.Top)
        break
    case "-b":
        printItems(.Best)
        break
    case "--best":
        printItems(.Best)
        break
    case "-h":
        printUsage()
        break
    case "--help":
        printUsage()
        break
    default:
        print("Invalid command, use 'hacker --help' to see the help guide.")
        break
    }
} else {
    print("Invalid command, use 'hacker --help' to see the help guide.")
}

