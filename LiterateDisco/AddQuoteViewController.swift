//
//  AddQuoteViewController.swift
//  LiterateDisco
//
//  Created by Nathan Wainwright on 2018-09-15.
//  Copyright © 2018 Nathan Wainwright. All rights reserved.
//

import UIKit
import Nuke

protocol AddQuoteViewControllerDelegate {
  func didFinishQuote (finished: FinishedQuote)
}


class AddQuoteViewController: UIViewController, NetworkServiceDelegate {
  
  @IBOutlet weak var quoteContentView: QuoteView!
  @IBOutlet weak var newQuoteButtonPressed: UIButton!
  @IBOutlet weak var newPhotoButtonPressed: UIButton!
  
  var photoOne = Photo()
  var quoteOne = Quote()
  var finishedQuote = FinishedQuote()
  
  var authorReturn:String = ""
  var quoteReturn:String = ""
  
  var photoURLReturn:String = ""
  
  var networker = NetworkManager()
  
//  var discoDelegate: DiscoDanceDelegate?
  
  var addQuoteDelegate: AddQuoteViewControllerDelegate?
 
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    discoDelegate = self as! DiscoDanceDelegate
    networker.netDelegate = self as NetworkServiceDelegate
    
    photoOne = networker.getPhoto()
    quoteOne = networker.getQuote()
    
//    quoteOne.author = quoteOne.author
//    quoteOne.quote = quoteOne.quote
    
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
      self.quoteContentView.authorLabel.text? = self.authorReturn
      self.quoteContentView.quoteLabel.text? = self.quoteReturn
      self.quoteContentView.reloadInputViews()
    }
  }
  
  func didGetPhotoURL(photoURL: String) {
    guard let url = URL(string: photoURL) else{
      return
    }
    DispatchQueue.main.async {
      Nuke.loadImage(with: url, into: self.quoteContentView.photoImageView)
      self.quoteContentView.reloadInputViews()
    }
  }
  
  // MARK: BUTTON ACTIONS
  @IBAction func quoteButtonAction(_ sender: UIButton) {
    quoteOne = networker.getQuote()
  }
  
  @IBAction func photoButtonAction(_ sender: UIButton) {
    photoOne = networker.getPhoto()
  }
  
  @IBAction func saveButtonAction(_ sender: UIButton) {
    //    self.addQuoteDelegate?.saveDiscoLiterate(disco: photoOne, literate: quoteOne)
//    let renderer = UIGraphicsImageRenderer(size: quoteContentView.bounds.size)
//    let image = renderer.image { ctx in
//      view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
//    }
//
//    finishedQuote.author = quoteOne.author
//    finishedQuote.quote = quoteOne.quote
//    finishedQuote.photo = image
    
//    print(image)
//    print(finishedQuote)
//    discoDelegate?.finshedDance(finished: finishedQuote)
    
    didFinishQuote(finished: finishedQuote)
    
    dismiss(animated: true, completion: nil)
    //    performSegue(withIdentifier: "mainViewSegue", sender: self)
  }
  
  
  
  func didFinishQuote (finished: FinishedQuote) {
    let renderer = UIGraphicsImageRenderer(size: quoteContentView.bounds.size)
    let image = renderer.image { ctx in
      view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
    }
    
    finishedQuote.author = quoteOne.author
    finishedQuote.quote = quoteOne.quote
    finishedQuote.photo = image
    
      print(image)
    
    self.addQuoteDelegate?.didFinishQuote(finished: finishedQuote)
    
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
