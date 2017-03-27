//
//  HackerNews.swift
//  hacker
//
//  Created by Christopher Hannah on 27/03/2017.
//  Copyright © 2017 Christopher Hannah. All rights reserved.
//

import Foundation

class HackerNews {
    let baseURL: URL
    let session: URLSession
    
    var maxItem: Int
    
    init() {
        baseURL = URL(string: "https://hacker-news.firebaseio.com/v0/")!
        session = URLSession.shared
        maxItem = 0
        checkMaxItem()
    }
    
    func checkMaxItem() {
        let maxItemURL = URL(string: baseURL.absoluteString + "maxitem.json")!
        
        let task = session.dataTask(with: maxItemURL, completionHandler: { (data, response, error) in
            if error != nil {
                print("error: \(error)")
            } else if data != nil {
                if let string = String(data: data!, encoding: .utf8) {
                    if Int(string) != nil {
                        let value = Int(string)!
                        self.updateMaxItem(maxItemValue: value)
                    }
                } else {
                    print("unable to convert data to string")
                }
            }
        })
        task.resume()
    }
    
    func updateMaxItem(maxItemValue: Int) {
        self.maxItem = maxItemValue
    }
    
    func getItem(id: Int) -> Data {
        let getItemURL = URL(string: baseURL.absoluteString + "item/\(id).json")!
        
        let semaphore = DispatchSemaphore(value: 0);
        
        var itemData = Data()
        
        let task = session.dataTask(with: getItemURL, completionHandler: { (data, response, error) in
            if error != nil {
                print("error: \(error)")
            } else if data != nil {
                itemData = data!
                semaphore.signal()
            }
        })
        
        task.resume()
        
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        
        return itemData
    }
    
    func getStory(id: Int) -> Story {
        let storyData = getItem(id: id)
        
        var by: String = ""
        var descendants: Int = 0
        var id: Int = 0
        var kids: [Int] = []
        var score: Int = 0
        var time: Int = 0
        var title: String = ""
        var url: String = ""
        
        if let dictionary = convertToDictionary(data: storyData) {
            if let byValue = dictionary["by"] {
                by = byValue as! String
            }
            if let descendantsValue = dictionary["descendants"] {
                descendants = descendantsValue as! Int
            }
            if let idValue = dictionary["id"] {
                id = idValue as! Int
            }
            if let kidsValue = dictionary["kids"] as? [Int] {
                kids = kidsValue
            }
            if let scoreValue = dictionary["score"] {
                score = scoreValue as! Int
            }
            if let timeValue = dictionary["time"] {
                time = timeValue as! Int
            }
            if let titleValue = dictionary["title"] {
                title = titleValue as! String
            }
            if let urlValue = dictionary["url"] {
                url = urlValue as! String
            }
        }
        
        let story = Story(by: by, descendants: descendants, id: id, kids: kids, score: score, time: time, title: title, url: url)
        return story
    }
    
    func getList(type: ListType) -> Data {
        let getListURL = URL(string: baseURL.absoluteString + "\(type.rawValue)stories.json")!
        
        let semaphore = DispatchSemaphore(value: 0);
        
        var listData = Data()
        
        let task = session.dataTask(with: getListURL, completionHandler: { (data, response, error) in
            if error != nil {
                print("error: \(error)")
            } else if data != nil {
                listData = data!
                semaphore.signal()
            }
        })
        
        task.resume()
        
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        
        return listData
    }
    
    func getNewList() -> [Int] {
        let listData = getList(type: .New)
        var list: [Int] = []
        
        if let listValue = convertToArray(data: listData) {
            list = listValue
        }
        
        return list
    }
    
    func getTopList() -> [Int] {
        let listData = getList(type: .Top)
        var list: [Int] = []
        
        if let listValue = convertToArray(data: listData) {
            list = listValue
        }
        
        return list
    }
    func getBestList() -> [Int] {
        let listData = getList(type: .Best)
        var list: [Int] = []
        
        if let listValue = convertToArray(data: listData) {
            list = listValue
        }
        
        return list
    }
    
    enum ListType: String {
        case New = "new"
        case Top = "top"
        case Best = "best"
    }
    
    struct Story {
        let by: String
        let descendants: Int
        let id: Int
        let kids: [Int]
        let score: Int
        let time: Int
        let title: String
        let url: String
    }
    
    func convertToDictionary(data: Data) -> [String: Any]? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func convertToArray(data: Data) -> [Int]? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [Int]
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}

