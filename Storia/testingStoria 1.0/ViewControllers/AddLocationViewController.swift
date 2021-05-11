//
//  AddLocationViewController.swift
//  testingStoria 1.0
//
//  Created by Rahmannur Rizki Syahputra on 03/05/21.
//

import UIKit
import MapKit

class AddLocationViewController: UIViewController, UISearchBarDelegate, MKLocalSearchCompleterDelegate {

	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var searchResultsTable: UITableView!
	
	var locationName: Any = ""
	var coordinateLat: Double!
	var coordinateLong: Double!
//	auto completer
	var searchCompleter = MKLocalSearchCompleter()
	
//	buat ngedisplay result dari auto completer ke table viw
	var searchResults = [MKLocalSearchCompletion]()
	
    override func viewDidLoad() {
        super.viewDidLoad()

		searchCompleter.delegate = self
		searchBar?.delegate = self
		searchResultsTable?.delegate = self
		searchResultsTable?.dataSource = self
    }

	@IBAction func didTappedCancel(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	//	buat isi autocompletenya berubah sesuai dengan apa yang diketik user
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		searchCompleter.queryFragment = searchText
	}
	
	func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
		searchResults = completer.results
		searchResultsTable.reloadData()
	}
	
	func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
		// error
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "locationSelected" {
			let destVC = segue.destination as! AddNewViewController
			destVC.locationLabel.text = sender as! String
			destVC.lattitude = coordinateLat
			destVC.longitude = coordinateLong
		} else {
			print("identifier not found")
		}
	}
}

extension AddLocationViewController: UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return searchResults.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let searchResult = searchResults[indexPath.row]
		
		let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
		
		cell.textLabel?.text = searchResult.title
		cell.detailTextLabel?.text = searchResult.subtitle
		
		return cell
	}
	
	
}

extension AddLocationViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		let result = searchResults[indexPath.row]
		let searchRequest = MKLocalSearch.Request(completion: result)
		
		let search = MKLocalSearch(request: searchRequest)
		search.start { (response, error) in
					guard let coordinate = response?.mapItems[0].placemark.coordinate else {
						return
					}
			guard let name = response?.mapItems[0].name else {
				return
			}
			
			let lat = coordinate.latitude
			let lon = coordinate.longitude
			
			self.coordinateLat = lat
			self.coordinateLong = lon
			self.locationName = name
			print(self.coordinateLat)
			print(self.coordinateLong)
			print(self.locationName)
			self.performSegue(withIdentifier: "locationSelected", sender: self.locationName)
		}
		
	}
}
