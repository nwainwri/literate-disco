//
//  AddQuoteViewController.swift
//  LiterateDisco
//
//  Created by Nathan Wainwright on 2018-09-15.
//  Copyright © 2018 Nathan Wainwright. All rights reserved.
//

import UIKit
import Nuke

class AddQuoteViewController: UIViewController, NetworkServiceDelegate {

  @IBOutlet weak var quoteContentView: QuoteView!
  
  var photoOne = Disco()
  var quoteOne = Literate()
  
  var authorReturn:String = ""
  var quoteReturn:String = ""
  
  var photoURLReturn:String = ""
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      let networker = NetworkManager()
      networker.netDelegate = self as NetworkServiceDelegate
//      photoOne = networker.getPhoto()
      let tempTuple = networker.getQuote()
      quoteOne.author = tempTuple.author
      quoteOne.quote = tempTuple.quote
//      didGetPhotoURL(photoURL: photoOne.imageLocation)
//      
//      didGetQuote(author: quoteOne.author, quote: quoteOne.quote)
      
      quoteContentView.authorLabel.text = authorReturn
      quoteContentView.quoteLabel.text = quoteReturn
      quoteContentView.photoImageView.image = UIImage(named: "testImage")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  // MARK: NetworkDelegate Functions
  func didGetQuote(author: String, quote: String) {
    authorReturn = String(describing: author)
    quoteReturn = String(describing: quote)
    
    DispatchQueue.main.async {
//      self.authorReturn = author
//      self.quoteReturn = quote
//      self.quoteContentView.authorLabel.text = author
//      self.quoteContentView.quoteLabel.text = quote
//      guard let author = author else {
//        self.authorReturn = author
//      }
      
      self.quoteContentView.authorLabel.text? = self.authorReturn
      self.quoteContentView.quoteLabel.text? = self.quoteReturn
      self.quoteContentView.authorLabel.reloadInputViews()
      self.quoteContentView.quoteLabel.reloadInputViews()
      
    }
  }
  
  func didGetPhotoURL(photoURL: String) {
    guard let url = URL(string: photoURL) else{
      return
    }
    Nuke.loadImage(with: url, into: quoteContentView.photoImageView)
    DispatchQueue.main.async {
      self.quoteContentView.reloadInputViews()
    }
  }

  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
