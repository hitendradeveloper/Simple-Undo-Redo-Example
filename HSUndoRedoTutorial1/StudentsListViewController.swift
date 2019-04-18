//
//  StudentsListViewController.swift
//  HSUndoRedoTutorial1
//
//  Created by Hitendra on 18/04/19.
//  Copyright © 2019 Hitendra iDev. All rights reserved.
//

import UIKit

class StudentsListViewController: UIViewController {
  
  //IBOutlets:-
  @IBOutlet weak var btnAdd: UIBarButtonItem!
  @IBOutlet weak var btnUndo: UIBarButtonItem!
  @IBOutlet weak var btnRedo: UIBarButtonItem!
  
  @IBOutlet weak var tableview: UITableView!
  
  //iVars:-
  
  //list of students visible in tableview screen appear
  var students: [Student] = [
    Student.allStudents[0]
  ]
  
  //ViewController LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.enableDisbaleActionsButtons()
  }
}

//MARK:- IBActions + Enable/Disable UI buttons
extension StudentsListViewController {
  @IBAction func btnAddNewStudentDidTap(_ sender: UIBarButtonItem) {
    let index = self.students.count
    self.addNewStudent(at: index) //add student in array and update table
    self.addNewStudentUndoActionRegister(at: index) //register for Undo action
    
    self.enableDisbaleActionsButtons()
  }
  
  @IBAction func btnUndoDidTap(_ sender: UIBarButtonItem) {
    self.undoManager?.undo()
    self.enableDisbaleActionsButtons()
  }
  
  @IBAction func btnRedoDidTap(_ sender: UIBarButtonItem) {
    self.undoManager?.redo()
    self.enableDisbaleActionsButtons()
  }
  
  func enableDisbaleActionsButtons(){
    self.btnAdd.isEnabled = Student.allStudents.count > self.students.count
    self.btnUndo.isEnabled = self.undoManager?.canUndo ?? false
    self.btnRedo.isEnabled = self.undoManager?.canRedo ?? false
  }
}

//MARK:- Add/Remove Student : Data Actions
//       Data Change Actions + UI Updates
extension StudentsListViewController {
  func addNewStudent(at index: Int){
    let newStudent = Student.allStudents[index]
    self.students.append(newStudent)
    self.tableview.reloadData()
  }
  
  func removeNewStudent(at index: Int) {
    self.students.remove(at: index)
    self.tableview.reloadData()
  }
}

//MARK:- Add/Remove Student : Undo/Redo Actions
//       Register inverse Actions that automatically performs
extension StudentsListViewController {
  func addNewStudentUndoActionRegister(at index: Int){
    self.undoManager?.registerUndo(withTarget: self, handler: { (selfTarget) in
      selfTarget.removeNewStudent(at: index)
      selfTarget.removeNewStudentUndoActionRegister(at: index)
    })
  }
  
  func removeNewStudentUndoActionRegister(at index: Int){
    self.undoManager?.registerUndo(withTarget: self, handler: { (selfTarget) in
      selfTarget.addNewStudent(at: index)
      selfTarget.addNewStudentUndoActionRegister(at: index)
    })
  }
}

//MARK:- UITableViewDelegate + UITableViewDataSource
extension StudentsListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.students.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "StudentTableViewCell") as! StudentTableViewCell
    cell.student = self.students[indexPath.row]
    return cell
  }
}
