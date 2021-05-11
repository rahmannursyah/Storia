//
//  MapViewController.swift
//  testingStoria 1.0
//
//  Created by Rahmannur Rizki Syahputra on 03/05/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

	@IBOutlet weak var mapView: MKMapView!
	
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	var items = [Memory]()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		mapView.delegate = self
		fetchMemory()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		mapView.delegate = self
		fetchMemory()
	}
	
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		guard !(annotation is MKUserLocation) else {
			return nil
		}

		var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")

		if annotationView == nil {
			annotationView = MKAnnotationView.init(annotation: annotation, reuseIdentifier: "custom")
			annotationView?.canShowCallout = true
		}
		else {
			annotationView?.annotation = annotation
		}
		print("masuk ke view for mapview")
		annotationView?.image = #imageLiteral(resourceName: "Maplocation2")

		return annotationView
		}
	
	func fetchMemory() {
		do {
			self.items = try context.fetch(Memory.fetchRequest())
			for item in items {
				let annotations = MKPointAnnotation()
				annotations.title = item.title
				let dateFormatter = DateFormatter()
				dateFormatter.dateFormat = "MM/dd/YY"
				annotations.subtitle = dateFormatter.string(from: item.dateMemory!)
				annotations.coordinate = CLLocationCoordinate2D(latitude: item.coordinateLat, longitude: item.coordinateLon)
				mapView.addAnnotation(annotations)
			}
		}
		catch {
			print("fetching data in map view controller failed")
		}
	}
	
}
