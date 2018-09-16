//
//  ViewController.swift
//  LiterateDisco
//
//  Created by Nathan Wainwright on 2018-09-12.
//  Copyright © 2018 Nathan Wainwright. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NetworkServiceDelegate, AddQuoteDelegate{
  
  
  @IBOutlet weak var mainTableView: UITableView!
  var photoOne = Disco()
  var quoteOne = Literate()
  
  var authorReturn:String = ""
  var quoteReturn:String = ""
  
  var photoURLReturn:String = ""
  
  var discoLiterateArray = Array<Any>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    let networker = NetworkManager()
    networker.netDelegate = self as NetworkServiceDelegate
    
    mainTableView.delegate = self
    mainTableView.dataSource = self
    
    
    
    

//    let tempTuple = networker.getQuote()
//    print("QUOTE: \(tempTuple)")

//    let testPhoto = networker.getPhoto()
//    print("TEST: \(testPhoto)")

  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = mainTableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainTableViewCell
    cell.textLabel?.text = authorReturn
    cell.detailTextLabel?.text = photoURLReturn
//    cell.imageView?.image = photoOne
    
    return cell
  }
  
////  // NETWORK DELEGATE
//  func didComplete() -> (author: String, quote: String) {
//    authorReturn =
//  }
  func didGetQuote(author: String, quote: String) {
    authorReturn = author
    quoteReturn = quote
    
    DispatchQueue.main.async {
      self.mainTableView.reloadData()
    }
  }
  
  func didGetPhotoURL(photoURL: String) {
    photoURLReturn = photoURL
    DispatchQueue.main.async {
      self.mainTableView.reloadData()
    }
  }

  func saveDiscoLiterate(disco: Disco, literate: Literate) {
    discoLiterateArray.append([disco, literate])
    print("TEST ARRAY: \(discoLiterateArray)")
    //get stuff here
  }

}

