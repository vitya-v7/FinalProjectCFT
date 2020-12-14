//
//  VDMyCourseCellTableViewCell.swift
//  VDDZCoreData
//
//  Created by Андрей Белкин on 19.07.17.
//  Copyright © 2017 Viktor Deryabin. All rights reserved.
//

import UIKit

class VDMyCourseCell: UITableViewCell,configuringCell {
	@IBOutlet var name: UILabel?
	@IBOutlet var predmet: UILabel?
	@IBOutlet var prepod: UILabel?
	override func awakeFromNib() {
    	super.awakeFromNib()
    	// Initialization code
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
    	super.setSelected(selected, animated: animated)

    	// Configure the view for the selected state
	}
	func configureCell(withObject object: Special) {
    	//cell.textLabel!.text = event.timestamp!.description
    	//cell.
    	let course = object as! VDCourseSpecial
    	name?.text = course.name
    	predmet?.text = course.predmet
    	prepod?.text = String("\(course.prepod?.firstName ?? "Default") \(course.prepod?.lastName ?? "Prepod")")
	}
}
