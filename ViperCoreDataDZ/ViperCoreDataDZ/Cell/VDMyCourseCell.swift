//
//  VDMyCourseCellTableViewCell.swift
//  VDDZCoreData
//
//  Created by Viktor Deryabin on 05.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit

class VDMyCourseCell: UITableViewCell {
	
	@IBOutlet var name: UILabel?
	@IBOutlet var predmet: UILabel?
	@IBOutlet var prepod: UILabel?
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	static let cellIdentifier = "CourseCell"
	static let nibName = "courseDescriptionCell"
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
	func configureCell(withObject object: CourseViewModel) {
		name?.text = object.name
		predmet?.text = object.predmet
		prepod?.text = object.prepod
	}
}
