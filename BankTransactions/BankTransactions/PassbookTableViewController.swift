//
//  PassbookTableViewController.swift
//  BankTransactions
//
//  Created by Shamli on 10/16/17.
//  Copyright © 2017 Atos. All rights reserved.
//

import UIKit

class PassbookTableViewController: UITableViewController {
    //tuple type needs to be declared here too??
    typealias Transactions = (transId: Int, amount: Double, balance:Double, transType: String)
    
    public var passbook:[Transactions] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return passbook.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "passbookCell", for: indexPath)
        //let transactionPart1: String = String(passbook[indexPath.row].transId) + "\t\t\t" + String(passbook[indexPath.row].amount)
        //let transactionPart2: String = passbook[indexPath.row].transType + "\t\t\t" + String(passbook[indexPath.row].balance)
        //cell.textLabel?.text = transactionPart1 + "\t\t\t" + transactionPart2
        cell.textLabel?.text = String(passbook[indexPath.row].transId) + "\t\t\t" + String(passbook[indexPath.row].amount) + "\t\t\t" + passbook[indexPath.row].transType + "\t\t\t" + String(passbook[indexPath.row].balance)
        if passbook[indexPath.row].transType == "CR" {
            cell.contentView.backgroundColor = UIColor.green
            //cell.backgroundView?.backgroundColor = UIColor.green
            //cell.tintColor = UIColor.green
        }
        else {
            cell.contentView.backgroundColor = UIColor.red
            //cell.backgroundView?.backgroundColor = UIColor.red
            //cell.tintColor = UIColor.red
        }
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
