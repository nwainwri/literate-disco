//
//  NetworkServicesProtocol.swift
//  LiterateDisco
//
//  Created by Nathan Wainwright on 2018-09-13.
//  Copyright © 2018 Nathan Wainwright. All rights reserved.
//

import Foundation

protocol NetworkServiceDelegate {
  func didGetQuote(author: String, quote: String)
  
  func didGetPhotoURL(photoURL: String)

}


