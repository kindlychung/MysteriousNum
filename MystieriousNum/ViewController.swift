//
//  ViewController.swift
//  MystieriousNum
//
//  Created by Kaiyin Zhong on 12/14/16.
//  Copyright © 2016 vu.co.kaiyin. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    private var dataModel = DataModel()
    private var answer = 0
    private var keyData: (Int, [Int]) = (0, []) {
        didSet {
            tbl.reloadData()
        }
    }

    @IBOutlet weak var questionIndex: NSTextField!
    @IBOutlet weak var tbl: NSTableView!
    @IBAction func replay(_ sender: Any) {
        dataModel = DataModel()
        questionIndex.stringValue = "0:"
        answer = 0
        updateModel()
    }
    
    @IBAction func forward(_ sender: NSButton) {
        if sender.tag == 1 {
            answer += keyData.0
        }
        updateModel()
    }
    
    func updateModel() {
        let group = dataModel.nextGroup()
        if let g = group {
            self.keyData = g
            let s = questionIndex.stringValue
            questionIndex.stringValue = String(Int(String(s.characters.dropLast()))! + 1) + ":"
            return
        }
        let alert = NSAlert()
        alert.messageText = "You did have \(answer) on your mind, didn't you?"
        alert.runModal()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for (n, col) in tbl.tableColumns.enumerated() {
            col.identifier = String(n)
        }
        updateModel()
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return keyData.1.count / 8 + 1
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let colId = tableColumn!.identifier
        let colIndex = Int(colId)!
        let index = (row * 8) + colIndex
        let cell = tbl.make(withIdentifier: colId, owner: self) as! NSTableCellView
        if 0 <= index && index < keyData.1.count {
            cell.textField!.integerValue = keyData.1[index]
        } else {
            cell.textField!.stringValue = ""
        }
        return cell
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

