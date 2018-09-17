//
//  ViewController.swift
//  LiterateDisco
//
//  Created by Nathan Wainwright on 2018-09-12.
//  Copyright © 2018 Nathan Wainwright. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddQuoteViewControllerDelegate {

  @IBOutlet weak var mainTableView: UITableView!
//  var photoOne = Photo()
//  var quoteOne = Quote()
  
//  var authorReturn:String = ""
//  var quoteReturn:String = ""
//  var photoURLReturn:String = ""
  var finishedQuotes = Array<FinishedQuote>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
//    let networker = NetworkManager()
//    networker.netDelegate = self as NetworkServiceDelegate
    mainTableView.delegate = self
    mainTableView.dataSource = self
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  
  // MARK: tableview functions
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return finishedQuotes.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = mainTableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainTableViewCell
//    cell.textLabel?.text = authorReturn
//    cell.detailTextLabel?.text = photoURLReturn
    cell.textLabel?.text = finishedQuotes[indexPath.row].author
    cell.detailTextLabel?.text = finishedQuotes[indexPath.row].quote
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    let row = indexPath.row
//    let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "addVCSegue") as! AddQuoteViewController
//
//    secondVC.quoteContentView.authorLabel.text = finishedQuotes[row].author
//    secondVC.quoteContentView.quoteLabel.text = finishedQuotes[row].quote
//    secondVC.quoteContentView.photoImageView.image = finishedQuotes[row].photo
//
    performSegue(withIdentifier: "addVCSegue", sender: self)
    print("CLICKY")
//    secondVC.pushViewController(secondVC, animated: true)

    
  }
  
  
  //MARK: add button
  @IBAction func addButtonPressed(_ sender: UIButton) {
    performSegue(withIdentifier: "addVCSegue", sender: self)
  }
  
  
  // MARK: quote delegate function
  func didFinishQuote(finished: FinishedQuote) {
    ///
    finishedQuotes.append(finished)
    mainTableView.reloadData()
  }
  
  //MARK: for segue
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    switch(segue.identifier ?? "") {
    case "AddItem":
      print("Adding a quote")// should just go next
    case "ShowQuote":
      print("showing an old quote")
    default:
      fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
    
    
    
    
    
    
    
    if segue.identifier == "addVCSegue"{
      if let nextVC = segue.destination as? AddQuoteViewController {
        
        nextVC.addQuoteDelegate = self
      }
    }
  }
}

