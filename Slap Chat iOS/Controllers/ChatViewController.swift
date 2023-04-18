//
//  RegisterViewController.swift
//  Slap-Chat
//
//  Created by Traton Gossink on 3/7/23.
//

import UIKit
import Firebase


class ChatViewController: UIViewController {

 
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        title = K.appName
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
    }
    
    func loadMessages() {
        
        
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { (querySnapshot, error) in
            self.messages = []
            if let e = error {
                print("Error getting data: \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let sender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as?
                            String {
                            let newMessage = Message(sender: sender, body: messageBody)
                            self.messages.append(newMessage)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count-1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                    
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    

    @IBAction func sendPressed(_ sender: UIButton) {
            if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
                db.collection(K.FStore.collectionName).addDocument(data: [
                    K.FStore.senderField: messageSender,
                    K.FStore.bodyField: messageBody,
                    K.FStore.dateField: Date().timeIntervalSince1970]) { (error) in
                    if let e = error {
                        print("Issue saving data to database, \(e)")
                    } else {
                        print("Success")
                        self.messageTextfield.text = ""
                    }
                }
            }
        }
    
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem){
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    


}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        as! MessageCell
        cell.label.text = message.body
     
        
        
        if message.sender == Auth.auth().currentUser?.email{
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.grayBlue)
            cell.label.textColor = UIColor(named: K.BrandColors.orange)
        } else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.orange)
            cell.label.textColor = UIColor(named: K.BrandColors.grayBlue)
        }


        return cell
    }
    

}
