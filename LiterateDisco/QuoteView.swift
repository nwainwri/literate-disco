//
//  QuoteView.swift
//  LiterateDisco
//
//  Created by Nathan Wainwright on 2018-09-15.
//  Copyright © 2018 Nathan Wainwright. All rights reserved.
//

import UIKit
import Nuke


class QuoteView: UIView {

  @IBOutlet var contentView: UIView!
  
  @IBOutlet weak var quoteLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var photoImageView: UIImageView!
  
  
  override init(frame: CGRect) { // for using CustomView in code
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) { // for using CustmoView in IB
    super.init(coder: aDecoder)
    commonInit()
  }
  
  private func commonInit() {
    // do stuff here
    
    Bundle.main.loadNibNamed("QuoteView", owner: self, options: nil)
    addSubview(contentView)
    contentView.frame = self.bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }
  
}
