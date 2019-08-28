//
//  NewToDoViewController.swift
//  ToDoList
//
//  Created by nhp on 8/24/19.
//  Copyright © 2019 nhp. All rights reserved.
//

import UIKit

class NewToDoViewController: UITableViewController {

    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var notesText: UITextView!
    @IBOutlet weak var saveNewToDoButton: UIBarButtonItem!
    
    var isPickerHidden = true
    
    let numberOfRowsAtSection: [Int] = [2, 1]
    let dateLabelIndexPath = IndexPath(row: 0, section: 0)
    let datePickerIndexPath = IndexPath(row: 1, section: 0)
    let notesTextIndexPath = IndexPath(row: 0, section: 1)
    
    let normalCellHeight:CGFloat = 80
    let largeCellHeight:CGFloat = 200
    
    var todo: ToDo?
 
    func updateSaveNewToDoButtonState() {
        let text = titleText.text ?? ""
        saveNewToDoButton.isEnabled = !text.isEmpty
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveNewToDoButtonState()
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        titleText.resignFirstResponder()
    }
    
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
        updateImageCompleteButton(bool: isCompleteButton.isSelected)
    }
    
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: dueDatePicker.date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // show info after passing model
        if let todo = todo {
            navigationItem.title = "To-Do"
            titleText.text = todo.title
            isCompleteButton.isSelected = todo.isComplete
            updateImageCompleteButton(bool: isCompleteButton.isSelected)
            dueDatePicker.date = todo.dueDate
            notesText.text = todo.notes
        } else {
            dueDatePicker.date = Date().addingTimeInterval(24*60*60)
        }
        
        updateDueDateLabel(date: dueDatePicker.date)
        updateSaveNewToDoButtonState()
        
    }
    
    func updateImageCompleteButton(bool:Bool){
        if(isCompleteButton.isSelected == false){
            isCompleteButton.setImage(UIImage(named: "cross"), for: .normal)
        }
        else{
            isCompleteButton.setImage(UIImage(named: "check"), for: .normal)
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows: Int = 0
        
        if section < numberOfRowsAtSection.count {
            rows = numberOfRowsAtSection[section]
        }
        
        return rows
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndexPath:
            return isPickerHidden ? 0 : 200
        case notesTextIndexPath:
            return largeCellHeight
        default:
            return normalCellHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == dateLabelIndexPath {
            isPickerHidden = !isPickerHidden
            dueDateLabel.textColor = isPickerHidden ? .black : tableView.tintColor
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveToDo" else { return }
        let title = titleText.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePicker.date
        let notes = notesText.text
        todo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
        
    }
    
    
    

}
