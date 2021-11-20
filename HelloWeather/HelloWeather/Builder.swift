//
//  Builder.swift
//  HelloWeather
//
//  Created by Sarvesh Suryavanshi on 19/11/21.
//

import UIKit

/// Factory that builds and hands over view onjects on demand
struct Builder {
    
    private static let storyboardName = "Main"
    
    /// Builds and returns us side menu view
    /// - Returns: SideMenuViewController View
    static func buildSideMenuView() -> SideMenuViewController? {
        let storyboard = UIStoryboard(name: Builder.storyboardName, bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: SideMenuViewController.identifier) as? SideMenuViewController
        return view
    }
    
    /// Builds and returns us search results view
    /// - Returns: SearchResultsViewController View
    static func buildSearchResultView() -> SearchResultsViewController? {
        let storyboard = UIStoryboard(name: Builder.storyboardName, bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: SearchResultsViewController.identifier) as? SearchResultsViewController
        return view
    }
}
