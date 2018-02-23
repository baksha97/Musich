//  MIT License

//  Copyright (c) 2017 Satish Babariya

//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:

//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.


import Foundation
import UIKit
import Firebase

class Message {
    
    //MARK: Properties
    
    var owner: MessageOwner
    var type: MessageType
    var content: Any
    var timestamp: Int
    var image: UIImage?
    var fromID: String?
    
    //MARK: Methods
    class func downloadAllMessages(forID channelID: String, completion: @escaping (Message) -> Swift.Void) {
        if let currentUserID = Auth.auth().currentUser?.uid {
            Database.database().reference().child("channels").child(channelID).observe(.childAdded, with: { (snap) in
                if snap.exists() {
                    let receivedMessage = snap.value as! [String: Any]
                    let messageType = receivedMessage["type"] as! String
                    var type = MessageType.text
                    switch messageType {
                    case "photo":
                        type = .photo
                    case "location":
                        type = .location
                    default: break
                    }
                    let content = receivedMessage["content"] as! String
                    let fromID = receivedMessage["fromID"] as! String
                    let timestamp = receivedMessage["timestamp"] as! Int
                    if fromID == currentUserID {
                        let message = Message.init(type: type, content: content, owner: .receiver, timestamp: timestamp, fromID: fromID)
                        completion(message)
                    } else {
                        let message = Message.init(type: type, content: content, owner: .sender, timestamp: timestamp, fromID: fromID)
                        completion(message)
                    }
                }
            })
        }
    }
    
    func downloadImage(indexpathRow: Int, completion: @escaping (Bool, Int) -> Swift.Void)  {
        if self.type == .photo {
            let imageLink = self.content as! String
            let imageURL = URL.init(string: imageLink)
            URLSession.shared.dataTask(with: imageURL!, completionHandler: { (data, response, error) in
                if error == nil {
                    self.image = UIImage.init(data: data!)
                    completion(true, indexpathRow)
                }
            }).resume()
        }
    }
    
    //    class func markMessagesRead(forUserID: String)  {
    //        if let currentUserID = Auth.auth().currentUser?.uid {
    //            Database.database().reference().child("users").child(currentUserID).child("conversations").child(forUserID).observeSingleEvent(of: .value, with: { (snapshot) in
    //                if snapshot.exists() {
    //                    let data = snapshot.value as! [String: String]
    //                    let location = data["location"]!
    //                    Database.database().reference().child("conversations").child(location).observeSingleEvent(of: .value, with: { (snap) in
    //                        if snap.exists() {
    //                            for item in snap.children {
    //                                let receivedMessage = (item as! DataSnapshot).value as! [String: Any]
    //                                let fromID = receivedMessage["fromID"] as! String
    //                                if fromID != currentUserID {
    //                                    Database.database().reference().child("conversations").child(location).child((item as! DataSnapshot).key).child("isRead").setValue(true)
    //                                }
    //                            }
    //                        }
    //                    })
    //                }
    //            })
    //        }
    //    }
    
    
    func downloadLastMessage(forLocation: String, completion: @escaping () -> Swift.Void) {
        if let currentUserID = Auth.auth().currentUser?.uid {
            Database.database().reference().child("conversations").child(forLocation).observe(.value, with: { (snapshot) in
                if snapshot.exists() {
                    for snap in snapshot.children {
                        let receivedMessage = (snap as! DataSnapshot).value as! [String: Any]
                        self.content = receivedMessage["content"]!
                        self.timestamp = receivedMessage["timestamp"] as! Int
                        let messageType = receivedMessage["type"] as! String
                        let fromID = receivedMessage["fromID"] as! String
                        var type = MessageType.text
                        switch messageType {
                        case "text":
                            type = .text
                        case "photo":
                            type = .photo
                        case "location":
                            type = .location
                        default: break
                        }
                        self.type = type
                        if currentUserID == fromID {
                            self.owner = .receiver
                        } else {
                            self.owner = .sender
                        }
                        completion()
                    }
                }
            })
        }
    }
    
    class func send(message: Message, toChannelID: String, completion: @escaping (Bool) -> Swift.Void)  {
        if let currentUserID = Auth.auth().currentUser?.uid {
            switch message.type {
            case .location:
                let values = ["type": "location", "content": message.content, "fromID": currentUserID, "toChannelID": toChannelID, "timestamp": message.timestamp]
                Message.uploadMessage(withValues: values, toChannelID: toChannelID, completion: { (status) in
                    completion(status)
                })
            case .photo:
                let imageData = UIImageJPEGRepresentation((message.content as! UIImage), 0.5)
                let child = UUID().uuidString
                Storage.storage().reference().child("messagePics").child(child).putData(imageData!, metadata: nil, completion: { (metadata, error) in
                    if error == nil {
                        let path = metadata?.downloadURL()?.absoluteString
                        let values = ["type": "photo", "content": path!, "fromID": currentUserID, "toChannelID": toChannelID, "timestamp": message.timestamp] as [String : Any]
                        Message.uploadMessage(withValues: values, toChannelID: toChannelID, completion: { (status) in
                            completion(status)
                        })
                    }
                })
            case .text:
                let messageWithName = "\(String(describing: Auth.auth().currentUser!.email!)) - \(message.content as! String)"
                let values = ["type": "text", "content": messageWithName, "fromID": currentUserID, "toChannelID": toChannelID, "timestamp": message.timestamp] as [String : Any] //as [String ANY] ?? idk if delete
                Message.uploadMessage(withValues: values, toChannelID: toChannelID, completion: { (status) in
                    completion(status)
                })
            }
        }
    }
    ///first
    class func uploadMessage(withValues: [String: Any], toChannelID: String, completion: @escaping (Bool) -> Void) {
        if let currentUserID = Auth.auth().currentUser?.uid {
            print(currentUserID)
            Database.database().reference().child("channels").child(toChannelID).childByAutoId().setValue(withValues, withCompletionBlock: { (error, _) in
                if error == nil {
                    completion(true)
                } else {
                    completion(false)
                }
            })
        }
    }
    
    //MARK: Inits
    init(type: MessageType, content: Any, owner: MessageOwner, timestamp: Int, fromID: String) {
        self.type = type
        self.content = content
        self.owner = owner
        self.timestamp = timestamp
        self.fromID = fromID
    }
}

