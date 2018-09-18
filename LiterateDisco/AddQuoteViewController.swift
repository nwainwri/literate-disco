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
  @IBOutlet weak var saveButtonPressed: UIButton!
  @IBOutlet weak var shareButtonPressed: UIButton!
  @IBOutlet weak var doneButtonPressed: UIButton!
  
  var photoOne = Photo()
  var quoteOne = Quote()
  var finishedQuote = FinishedQuote()
  
  var authorReturn:String = ""
  var quoteReturn:String = ""
  var photoReturn:UIImage?
  
  var photoURLReturn:String = ""
  var networker = NetworkManager()
  var addQuoteDelegate: AddQuoteViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
      
    networker.netDelegate = self as NetworkServiceDelegate
    
    if photoReturn == nil {
      photoOne = networker.getPhoto()
      quoteOne = networker.getQuote()
      newQuoteButtonPressed.isHidden = false
      newPhotoButtonPressed.isHidden = false
      saveButtonPressed.isHidden = false
      shareButtonPressed.isHidden = true
      doneButtonPressed.isHidden = true
    } else {
      quoteContentView.photoImageView.image = photoReturn
      quoteContentView.photoImageView.contentMode = .scaleAspectFill // doesn't work
      
      newQuoteButtonPressed.isHidden = true
      newPhotoButtonPressed.isHidden = true
      saveButtonPressed.isHidden = true
      shareButtonPressed.isHidden = false
      doneButtonPressed.isHidden = false
    }
    quoteContentView.authorLabel.text = authorReturn
    quoteContentView.quoteLabel.text = quoteReturn
    quoteContentView.photoImageView.image = photoReturn
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
    didFinishQuote(finished: finishedQuote)
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func shareButtonAction(_ sender: UIButton) {
    let postText: String = "Here's a great quote. 😅"
    let postImage: UIImage = photoReturn!
    let activityItems = [postText, postImage] as [Any]
    let activityController = UIActivityViewController(
      activityItems: activityItems,
      applicationActivities: nil
    )
    self.present(activityController, animated: true, completion: nil)
  }
  
  @IBAction func doneButtonAction(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  //MARK: Delegate functions
  func didFinishQuote (finished: FinishedQuote) {
    let renderer = UIGraphicsImageRenderer(size: quoteContentView.bounds.size)
    let image = renderer.image { ctx in
      view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
    }
    finishedQuote.author = quoteOne.author
    finishedQuote.quote = quoteOne.quote
    finishedQuote.photo = image
    self.addQuoteDelegate?.didFinishQuote(finished: finishedQuote)
  }
}
