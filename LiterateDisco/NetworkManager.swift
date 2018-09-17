//
//  NetworkManager.swift
//  LiterateDisco
//
//  Created by Nathan Wainwright on 2018-09-12.
//  Copyright © 2018 Nathan Wainwright. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager {
  
  var netDelegate: NetworkServiceDelegate?
  
  // QUOTE RANDOM; POST:
  // http://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json
  
  func getQuote() -> (Quote){
    //    func getQuote() -> (author: String, quote: String){
    let quoteReturned = Quote()
    
    var replyData: (author: String, quote: String)
    
    replyData.author = ""
    replyData.quote = ""
    
    let url = URL(string: "https://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json")!
    let request = NSMutableURLRequest(url: url)
    
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    let task = URLSession.shared.dataTask(with: request as URLRequest) { (data: Data?, response: URLResponse?, error: Error?) in
      
      guard let data = data else {
        print("no data returned from server \(String(describing: error?.localizedDescription))")
        return
      }
      
      guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, Any> else {
        print("QUOTE: data returned is not json, or not valid")
        return
      }
      
      guard let response = response as? HTTPURLResponse else {
        print("no response returned from server \(String(describing: error))")
        return
      }
      
      guard response.statusCode == 200 else {
        // handle error
        print("an error occurred \(String(describing: json["error"]))")
        return
      }
      // GRAB HERE
      quoteReturned.author = json["quoteAuthor"] as! String
      quoteReturned.quote = json["quoteText"] as! String
      
      replyData.author = json["quoteAuthor"] as! String
      replyData.quote = json["quoteText"] as! String
      self.netDelegate?.didGetQuote(author: replyData.author, quote: replyData.quote)
    }
    task.resume()
    
    return quoteReturned
  }
  
  func getPhoto() -> Photo {
    let photoGotten = Photo()
    
    let url = URL(string: "https://api.imgur.com/3/gallery/hOF1g")!
    //    ## how to get a gallery on imgur
    //    curl "https://api.imgur.com/3/gallery/hOF1g" \
    //    -H 'Authorization: Client-ID a9a2f1a3769a31e'
    let request = NSMutableURLRequest(url: url)
    request.httpMethod = "GET"
    
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("Client-ID a9a2f1a3769a31e", forHTTPHeaderField: "Authorization")
    let task = URLSession.shared.dataTask(with: request as URLRequest) { (data: Data?, response: URLResponse?, error: Error?) in
      
      guard let data = data else {
        print("no data returned from server \(String(describing: error?.localizedDescription))")
        return
      }
      
      guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: Any] else {
        print("QUOTE: data returned is not json, or not valid")
        return
      }
      
      guard let imgurDataDict = json["data"] as? [String: Any] else {
        print("JSON: no data found")
        return
      }
      
      guard let imageArray = imgurDataDict["images"] as? [[String: Any]] else{
        print("JSON: no data found")
        return
      }
      
      let randomIndex = Int(arc4random_uniform(UInt32(imageArray.count)))
      
      let element = imageArray[randomIndex]
      
      guard let link = element["link"] as? String else{
        print("LINK: LINK returned is not json, or not valid")
        return
      }
      photoGotten.imageLocation = link
  
      guard let response = response as? HTTPURLResponse else {
        print("no response returned from server \(String(describing: error))")
        return
      }
      
      guard response.statusCode == 200 else {
        print("an error occurred with HTTP")
        return
      }
      // GRAB HERE
      
      self.netDelegate?.didGetPhotoURL(photoURL: link)
    }
    task.resume()
    return photoGotten
  }
}











