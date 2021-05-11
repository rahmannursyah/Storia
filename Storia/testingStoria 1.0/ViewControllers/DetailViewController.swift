//
//  DetailViewController.swift
//  testingStoria 1.0
//
//  Created by Rahmannur Rizki Syahputra on 02/05/21.
//

import UIKit
import Foundation

class DetailViewController: UIViewController {

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var imageHolder: UIImageView!
	@IBOutlet weak var oneWordLabel: UILabel!
	@IBOutlet weak var detailLabel: UILabel!
	@IBOutlet weak var wholeDetailView: UIView!
	@IBOutlet weak var viewImage: UIView!
	@IBOutlet weak var viewDetail: UIView!
	
	var item : Memory?
	
	override func viewDidLoad() {
        super.viewDidLoad()
		viewImage.layer.cornerRadius = 8
		viewDetail.layer.cornerRadius = 8
		showDetail()
    }
    
	func showDetail() {
		guard let detailData = item else { return }
		title = detailData.location
		
		titleLabel.text = detailData.title
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MM/dd/YY"
		locationLabel.text = dateFormatter.string(from: detailData.dateMemory!)
		if let data = detailData.image as Data? {
			imageHolder.image = UIImage(data: data)
			imageHolder.layer.cornerRadius = 8
		} else {
			print("showing image failed")
		}
		oneWordLabel.text = detailData.oneWord
		detailLabel.text = detailData.detail
		
	}

}
