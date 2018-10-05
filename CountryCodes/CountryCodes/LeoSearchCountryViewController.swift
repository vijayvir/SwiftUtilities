//
//  FPNSearchCountryViewController.swift
//  FlagPhoneNumber
//
//  Created by Aurélien Grifasi on 06/08/2017.
//  Copyright (c) 2017 Aurélien Grifasi. All rights reserved.
//

import Foundation
import UIKit
class LeoSearchCountryViewController: UITableViewController, UISearchResultsUpdating, UISearchControllerDelegate {

	var searchController: UISearchController?
	var list: [World.Country]?
	var results: [World.Country]?

	//var delegate: FPNDelegate?
    var closureDidSelectCountry : ((World.Country) -> Void)?
	init(countries: [World.Country]) {
		super.init(nibName: nil, bundle: nil)

		self.list = countries
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
    func flag(_ country: String) -> String {
        let base = 127397
        
        var usv = String.UnicodeScalarView()
        
        for i in country.utf16 {
            usv.append(UnicodeScalar(base + Int(i))!)
        }
        return String(usv)
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()

		initSearchBarController()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		if #available(iOS 11.0, *) {
			navigationItem.hidesSearchBarWhenScrolling = false
		} else {
			// Fallback on earlier versions
		}
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		searchController?.isActive = true
	}

	@objc private func dismissController() {
		dismiss(animated: true, completion: nil)
	}

	private func initSearchBarController() {
		searchController = UISearchController(searchResultsController: nil)
		searchController?.searchResultsUpdater = self
		searchController?.delegate = self

		if #available(iOS 9.1, *) {
			searchController?.obscuresBackgroundDuringPresentation = false
		} else {
			// Fallback on earlier versions
		}

		if #available(iOS 11.0, *) {
			navigationItem.searchController = searchController
		} else {
			searchController?.dimsBackgroundDuringPresentation = false
			searchController?.hidesNavigationBarDuringPresentation = true
			searchController?.definesPresentationContext = true

			//				searchController?.searchBar.sizeToFit()
			tableView.tableHeaderView = searchController?.searchBar
		}
		definesPresentationContext = true
	}

	private func getItem(at indexPath: IndexPath) -> World.Country {
		var array: [World.Country]!

		if let searchController = searchController, searchController.isActive && results != nil && results!.count > 0 {
			array = results
		} else {
			array = list
		}

		return array[indexPath.row]
	}

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let searchController = searchController, searchController.isActive {
			if let count = searchController.searchBar.text?.count, count > 0 {
				return results?.count ?? 0
			}
		}
		return list?.count ?? 0
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
		let country = getItem(at: indexPath)

		cell.textLabel?.text = " \(flag(country.sortName))  \(country.name)"   //country.name
		cell.detailTextLabel?.text = country.code
		//cell.imageView?.image =

		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)

       closureDidSelectCountry?(getItem(at: indexPath))
		searchController?.isActive = false
		searchController?.searchBar.resignFirstResponder()
	}

	// UISearchResultsUpdating

	func updateSearchResults(for searchController: UISearchController) {
		if list == nil {
			results?.removeAll()
			return
		} else if searchController.searchBar.text == "" {
			results?.removeAll()
			tableView.reloadData()
			return
		}

		if let searchText = searchController.searchBar.text, searchText.count > 0 {
			results = list!.filter({(item: World.Country) -> Bool in
                if item.name.lowercased().range(of: searchText.lowercased()) != nil {
					return true
                } else if item.code.lowercased().range(of: searchText.lowercased()) != nil {
					return true
                }
                  //  else if item.phoneCode?.lowercased().range(of: searchText.lowercased()) != nil {
//                    return true
//                }
				return false
			})
		}
		tableView.reloadData()
	}

	// UISearchControllerDelegate

	func didPresentSearchController(_ searchController: UISearchController) {
		DispatchQueue.main.async { [unowned self] in
			self.searchController?.searchBar.becomeFirstResponder()
		}
	}

	func willDismissSearchController(_ searchController: UISearchController) {
		results?.removeAll()
	}

	func didDismissSearchController(_ searchController: UISearchController) {
		dismissController()
	}
}
