//
//  ClientTableViewCell.swift
//  TestfulApp
//
//  Created by Andrey Morichev on 17/02/16.
//  Copyright © 2016 Andrey Morichev. All rights reserved.
//

import UIKit

class ClientTableViewCell: UITableViewCell {

    @IBOutlet weak private var avatarImage: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var messageDateLabel: UILabel!
    @IBOutlet weak private var messageTextLabel: UILabel!
    @IBOutlet weak private var countUnreadMessageLabel: UILabel!
    
    @IBOutlet var viewsForCalculatingHeight: [UIView]!
    @IBOutlet var constraintsForCalculatingHeight: [NSLayoutConstraint]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setImageForAvatar(image: UIImage) {
        self.avatarImage.image = image
    }
    
    func configure(client: Client) {
        self.nameLabel.text = client.fullname
        if let lastMessage = client.getLastMessage() {
            self.messageDateLabel.text = self.dateRepresentation(lastMessage.date)
            self.messageTextLabel.text = lastMessage.text
        } else {
            self.messageDateLabel.text = ""
            self.messageTextLabel.text = ""
        }
        self.countUnreadMessageLabel.text = self.textForUnreadMessages(client.countUnreadMessages)
    }
    
    //MARK: Private utils
    
    private func dateRepresentation(date: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        return dateFormatter.stringFromDate(date)
    }
    
    private func textForUnreadMessages(count: Int) -> String {
        //TODO: localization
        return "+ \(count) messages"
    }
    
    //MARK: Class methods
    
    class func cellNib() -> UINib {
        return UINib(nibName: "ClientTableViewCell", bundle: NSBundle.mainBundle())
    }
    
    class func calculateHeight(textMessage: String, width: CGFloat) -> CGFloat {
        return 90.0
    }
    
}
