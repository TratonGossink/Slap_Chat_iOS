//
//  Constants.swift
//  Slap_Chat_iOS
//
//  Created by Traton Gossink on 4/14/23.
//

struct K {
    static let appName = "Slap 👏 Chat!"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    
    struct BrandColors {
        static let navyBlue = "BrandNavyBlue"
        static let yellow = "BrandYellow"
        static let grayBlue = "BrandGrayBlue"
        static let orange = "BrandOrange"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
