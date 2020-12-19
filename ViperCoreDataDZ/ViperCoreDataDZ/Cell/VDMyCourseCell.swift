//
//  VDMyCourseCellTableViewCell.swift
//  VDDZCoreData
//
//  Created by Admin on 05.12.2020.
//  Copyright © 2020 Admin. All rights reserved.
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
