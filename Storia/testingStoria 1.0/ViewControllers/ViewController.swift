//
//  ViewController.swift
//  testingStoria 1.0
//
//  Created by Rahmannur Rizki Syahputra on 29/04/21.
//

import UIKit
import Photos

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
	
	var memories: [Memories] = Memories.getMemories()
	
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var secondView: UIView!
	@IBOutlet weak var defaultSegmentedControl: UISegmentedControl!
	
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	var items = [Memory]()
	
	var currentIndex: Int?
	var indexSelected = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView.dataSource = self
		collectionView.delegate = self
		defaultSegmentedControl.selectedSegmentIndex = 0
		fetchMemory()
	}
	
//	override func viewWillAppear(_ animated: Bool) {
//
//	}
	
	@IBAction func segmentedControl(_ sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex {
		case 0:
			collectionView.alpha = 1
			secondView.alpha = 0
		case 1:
			collectionView.alpha = 0
			secondView.alpha = 1
		default:
			print("selected index out of range")
		}
	}
	
	func fetchMemory() {
//		fetch the data from core data to display to collection view
		do {
			self.items = try context.fetch(Memory.fetchRequest())
			
			DispatchQueue.main.async {
				self.collectionView.reloadData()
				print("reload successfull")
			}
		}
		catch{
			print("Fetching data failed")
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//		return memories.count
		return self.items.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MM/dd/YY"
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemoriesCell", for: indexPath) as! MemoriesCollectionViewCell
		
		let memory = self.items[indexPath.row]
	
		cell.memoryTitle.text = memory.title
		cell.memoryDate.text = dateFormatter.string(from: (memory.dateMemory)!)
		
		if let data = memory.image as Data? {
			cell.memoryImage.image = UIImage(data: data)
			cell.memoryImage.layer.cornerRadius = 5
		} else {
			print("showing image from coredata failed")
		}
		cell.layer.cornerRadius = 8

		return cell
	}

	@IBAction func unwindToFirstView (_ sender: UIStoryboardSegue) {
		fetchMemory()
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
//		indexSelected = indexPath.row
//		let detailView = DetailViewController()
//
//		detailvc.item = items[indexSelected]
//		print(items[indexSelected].title)
//		present(detailvc, animated: true, completion: nil)
//		let detailView = segue.destination as? DetailViewController
		
		self.performSegue(withIdentifier: "detailMemoryView", sender: indexPath.row)
//		detailView.item = items[indexPath.row]
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//		let detailView = segue.destination as? DetailViewController


		guard let selectedIndex = sender as? Int else { return }
		if segue.identifier == "detailMemoryView" {

			let detailView = segue.destination as? DetailViewController
			detailView!.item = items[selectedIndex]
		}
	}
	
}
