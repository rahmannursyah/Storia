//
//  Memory.swift
//  testingStoria 1.0
//
//  Created by Rahmannur Rizki Syahputra on 29/04/21.
//

import Foundation
import UIKit

struct Memories {
	var title: String
	var date: String
	var image: UIImage
	
	static func getMemories() -> [Memories] {
		return [
			Memories(title: "First time seeing snow", date: "10 Oct 2010", image: #imageLiteral(resourceName: "56266_1482062846754_5700114_o")),
			Memories(title: "President Nur", date: "20 Dec 2010", image: #imageLiteral(resourceName: "184682_1601616555522_1717414_n"))
		]
	}
}
