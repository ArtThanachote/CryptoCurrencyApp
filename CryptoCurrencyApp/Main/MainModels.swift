//
//  MainModels.swift
//  CryptoCurrencyApp
//
//  Created by IT-EFW-65-03 on 21/6/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Main
{
  // MARK: Use cases
  
  enum CryptoCurrency
  {
    struct Request
    {
    }
    struct Response
    {
        var item : CryptoCurrencyModel?
        var currencyItem : Eur?
        var displayList : [Display] = []
    }
    struct ViewModel
    {
        var item : CryptoCurrencyModel?
        var currencyItem : Eur?
        var displayList : [Display] = []
    }
  }
}
