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

  
  // IMAGE RANDOM; https://picsum.photos/200/?random -- > WILL RETURN URL OF RANDOM SQUARE IMAGE
  // IMAGE RANDOM; https://picsum.photos/300/200/?random --> will return random landscape image
  
  // QUOTE RANDOM; POST:
  // http://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json
  
  
  func getQuote() -> (author: String, quote: String){
    var replyData: (author: String, quote: String)
    replyData.0 = ""
    replyData.1 = ""

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
      print("title:: \(String(describing: json["quoteAuthor"]))")
      
      print("title:: \(String(describing: json["quoteText"]))")
      
      replyData.0 = String(describing: json["quoteAuthor"])
      replyData.1 = String(describing: json["quoteText"])
      // need to put in delete to notify main page once data received.
      
      self.netDelegate?.didComplete(author: replyData.0, quote: replyData.1)
    }
    task.resume()
    
  
    return (replyData.0, replyData.1)
  }
  
  func getPhoto() -> UIImage {
    var testImage = UIImage()
    let url = URL(string: "https://picsum.photos/300/200/?random")!
    let request = NSMutableURLRequest(url: url)
    request.httpMethod = "GET"
    let task = URLSession.shared.dataTask(with: request as URLRequest) { (data: Data?, response: URLResponse?, error: Error?) in
      
      guard let data = data else {
        print("no data returned from server \(String(describing: error?.localizedDescription))")
        return
      }
      
      guard let response = response as? HTTPURLResponse else {
        print("no response returned from server \(String(describing: error))")
        return
      }
      
      guard response.statusCode == 200 else {
        // handle error
        print("an error occurred with HTTP")
        return
      }
      // GRAB HERE
      testImage = UIImage(data: data)!
    }
    task.resume()
    return testImage
  }
}











