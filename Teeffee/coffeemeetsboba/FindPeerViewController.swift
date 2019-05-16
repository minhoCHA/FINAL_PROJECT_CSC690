//
//  ChatViewController.swift
//  coffeemeetsboba
//
//  Created by MinhoCha on 2019/4/4.
//  Copyright © 2019 MinhoCha. All rights reserved.
//
import UIKit
import MultipeerConnectivity
import Chatto
import ChattoAdditions

class FindPeerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ChatServiceDelegate{
    
    
    @IBOutlet weak var peerTable: UITableView!
    
    var chatService = ChatService()
    
    var selectedPeer : MCPeerID?
    
    var alert : UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        peerTable.delegate = self
        peerTable.dataSource = self

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "LOGO_round")
        imageView.image = image
        navigationItem.titleView = imageView
        peerTable.tableFooterView = UIView(frame: .zero)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        chatService.delegate = self
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if let selectedRow = peerTable.indexPathForSelectedRow {
            peerTable.deselectRow(at: selectedRow, animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatService.foundPeers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "peerCell") as? peerCell{
            cell.nameLabel.text = chatService.foundPeers[indexPath.row].displayName
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPeer = chatService.foundPeers[indexPath.row]
        self.alert = UIAlertController(title: "", message: " Waiting for \(selectedPeer!.displayName) to respond.", preferredStyle: UIAlertController.Style.alert)
        self.present(self.alert!, animated: true, completion: nil)
        self.chatService.invitePeer(peer: selectedPeer!)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != nil{
            if let dest = segue.destination as? ChatViewController{
                dest.peer = selectedPeer
                dest.chatService = self.chatService
                let dataSource = ChatDataSource(messages: [], pageSize: 50)
                dest.dataSource = dataSource
            }
        }
    }
    
    // MARK: - ChatServiceDelegate
    
    func foundPeer() {
        peerTable.reloadData()
    }
    
    func lostPeer() {
        peerTable.reloadData()
    }
    
    func invitationWasReceived(peerID: MCPeerID){
        OperationQueue.main.addOperation { () -> Void in
            let alert = UIAlertController(title: "", message: "\(peerID.displayName) wants to chat with you.", preferredStyle: UIAlertController.Style.alert)
            
            let acceptAction: UIAlertAction = UIAlertAction(title: "Accept", style: UIAlertAction.Style.default) { (alertAction) -> Void in
                self.chatService.invitationHandler(true, self.chatService.session)
                self.selectedPeer = peerID
                self.alert = UIAlertController(title: "", message: " Connecting with \(self.selectedPeer!.displayName).", preferredStyle: UIAlertController.Style.alert)
                self.present(self.alert!, animated: true, completion: nil)
            }
            
            let declineAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { (alertAction) -> Void in
                self.chatService.invitationHandler(false, nil)
            }
            
            alert.addAction(acceptAction)
            alert.addAction(declineAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func connectedWithPeer(peerID: MCPeerID){
        OperationQueue.main.addOperation { () -> Void in
            self.alert?.dismiss(animated: true, completion: {
                NSLog("before goToChatView")
                self.performSegue(withIdentifier: "goToChatView", sender: self)
            })
        }
    }
    
    func receiveMessage(text: String){
        NSLog("receiveMessage")
    }
    
    func connectionFailed() {
        self.alert?.dismiss(animated: true, completion: nil)
    }
    
}

class peerCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
}
