//
//  StudentTableViewCell.swift
//  HSUndoRedoTutorial1
//
//  Created by Hitendra on 18/04/19.
//  Copyright © 2019 Hitendra iDev. All rights reserved.
//

import UIKit

class StudentTableViewCell: UITableViewCell {
  var student: Student! {
    didSet {
      self.textLabel?.text = self.student.name
      self.detailTextLabel?.text = self.student.studyInClass
    }
  }
}
