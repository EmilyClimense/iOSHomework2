//
//  ViewController.swift
//  net8
//
//  Created by student on 2018/12/15.
//  Copyright © 2018年 at. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //学生
    var students = [Student]()
    //教师
    var teachers = [Teacher]()
    var tableTitle = ["Teacher", "Student"]
    var table: UITableView!
    var rightItem: UIBarButtonItem!
    var alert: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "table"
        self.view.backgroundColor = UIColor.white
        
        //生成Teacher对象
        for i in 1...3 {
            let temp = Teacher(title: "Teacher", firstName: "Juju", lastName: "\(i)", age: 21, gender: .female, department: .one)
            teachers.append(temp)
        }
        //生成Student对象
        for i in 21..<25 {
            let temp = Student(stuNo: 20151101 + i, firstName: "Liang ", lastName: "\(i)", age: 19, gender: .male, department: .two)
            students.append(temp)
        }
        
        //按全名排序
        teachers.sort { return $0.fullName < $1.fullName }
        students.sort { return $0.fullName < $1.fullName }
        
        //创建表视图，并设置代理和数据源
        table = UITableView(frame: self.view.bounds)
        table.delegate = self
        table.dataSource = self
        self.view.addSubview(table)
        
        //导航栏控制器右边的按钮
        rightItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(edit))
        self.navigationItem.rightBarButtonItem = rightItem
        
        //导航栏控制器左边的按钮
        let leftItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addStudent))
        self.navigationItem.leftBarButtonItem = leftItem
        
    }
    
    /// 添加学生提示框
    @objc func addStudent() {
        
        alert = UIAlertController(title: "hh", message: "ss", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "stuNo?"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "firstName?"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "lastName?"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "gender?"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "age?"
        }
        
        let OKBtn = UIAlertAction(title: "OK", style: .default) { (alert) in
            self.add()
        }
        let cancelBtn = UIAlertAction(title: "Cancle", style: .cancel, handler: nil)
        alert.addAction(OKBtn)
        alert.addAction(cancelBtn)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    /// 添加学生
    func add() {
        let no = Int(alert.textFields![0].text!)
        let firstName = alert.textFields![1].text!
        let lastName = alert.textFields![2].text!
        let gender: Gender
        switch alert.textFields![3].text! {
        case "男":
            gender = .male
        case "女":
            gender = .female
        default:
            gender = .unknow
        }
        let age = Int(alert.textFields![4].text!)
        let student = Student(stuNo: no!, firstName: firstName, lastName: lastName, age: age!, gender: gender)
        students.append(student)
        
        table.reloadData()
    }
    
    /// 编辑表视图
    @objc func edit() {
        if table.isEditing {
            rightItem.title = "Edit"
            table.isEditing = false
        } else {
            rightItem.title = "Finish"
            table.isEditing = true
        }
    }
    
    // MARK: delegate
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = tableTitle[indexPath.section]
        
        let name: String
        if indexPath.section == 0 {
            name = teachers[indexPath.row].fullName
        } else {
            name = students[indexPath.row].fullName
        }
        
        let message = "you selected \(category), name: \(name)"
        
        let alert = UIAlertController(title: "message", message: message, preferredStyle: .alert)
        let OKBtn = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(OKBtn)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: data source
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            if indexPath.section == 0 {
                teachers.remove(at: indexPath.row)
            } else {
                students.remove(at: indexPath.row)
            }
            
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if sourceIndexPath.section != destinationIndexPath.section {
            tableView.reloadData()
        } else {
            if sourceIndexPath.section == 0 {
                teachers.insert(teachers.remove(at: sourceIndexPath.row), at: destinationIndexPath.row)
            } else {
                students.insert(students.remove(at: sourceIndexPath.row), at: destinationIndexPath.row)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableTitle.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableTitle[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return teachers.count
        } else {
            return students.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = tableTitle[indexPath.section]
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil {
            let style: UITableViewCell.CellStyle = (identifier == "Teacher") ? .subtitle : .default
            cell = UITableViewCell(style: style, reuseIdentifier: identifier)
            cell?.accessoryType = .disclosureIndicator
        }
        
        switch identifier {
        case "Teacher":
            cell?.textLabel?.text = teachers[indexPath.row].fullName
            cell?.detailTextLabel?.text = teachers[indexPath.row].title
        case "Student":
            cell?.textLabel?.text = students[indexPath.row].fullName
        default:
            break
        }
        
        return cell!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
