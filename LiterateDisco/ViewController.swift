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

  var finishedQuotes = Array<FinishedQuote>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
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
    cell.textLabel?.text = finishedQuotes[indexPath.row].author
    cell.detailTextLabel?.text = finishedQuotes[indexPath.row].quote
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "showFinishedSegue", sender: self)
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
    
    if segue.identifier == "addVCSegue"{
      if let nextVC = segue.destination as? AddQuoteViewController {
        nextVC.addQuoteDelegate = self
      }
    } else if segue.identifier == "showFinishedSegue"{
      if let nextVC = segue.destination as? AddQuoteViewController {
        nextVC.photoReturn = finishedQuotes[mainTableView.indexPathForSelectedRow?.row ?? 0].photo
        nextVC.addQuoteDelegate = self
      }
    }
  }
}

