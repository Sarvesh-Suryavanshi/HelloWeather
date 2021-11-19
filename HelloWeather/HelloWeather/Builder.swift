//
//  Builder.swift
//  HelloWeather
//
//  Created by Sarvesh Suryavanshi on 19/11/21.
//

import Foundation
import UIKit

struct Builder {
    
    static func buildSideMenuView() -> SideMenuViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: SideMenuViewController.identifier) as? SideMenuViewController
        return view
    }
    
    static func buildSearchResultView() -> SearchResultsViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: SearchResultsViewController.identifier) as? SearchResultsViewController
        return view
    }
  
}
