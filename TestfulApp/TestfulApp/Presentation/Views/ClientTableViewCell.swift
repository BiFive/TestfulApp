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
    
    @IBOutlet var viewsForCalculatingWidth: [UIView]!
    @IBOutlet var constraintsForCalculatingWidth: [NSLayoutConstraint]!
    
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
        return String.localizedStringWithFormat(NSLocalizedString("ClientCell.+ %d message(s)", comment: "+Messages"), count)
    }
    
    //MARK: Class methods
    
    class func cellNib() -> UINib {
        return UINib(nibName: "ClientTableViewCell", bundle: NSBundle.mainBundle())
    }
    
    //MARK: Height calculattion
    
    static var cellHeightWithoutText: CGFloat? = nil
    static var cellWidthWitohutText: CGFloat? = nil
    static var textMessagefont: UIFont? = nil
    
    class func calculateHeight(textMessage: String, width: CGFloat) -> CGFloat {
        
        if self.cellHeightWithoutText == nil || self.textMessagefont == nil || self.cellHeightWithoutText == nil {
            let cellPrototype = self.cellNib().instantiateWithOwner(nil, options: nil)[0] as! ClientTableViewCell
            
            var height = self.calculateTotalHeight(cellPrototype.viewsForCalculatingHeight, constraints: cellPrototype.constraintsForCalculatingHeight)
            height += cellPrototype.layoutMargins.bottom + cellPrototype.layoutMargins.top + (cellPrototype.frame.height - cellPrototype.contentView.frame.height)
            self.cellHeightWithoutText = height
            
            var width = self.calculateTotalWidth(cellPrototype.viewsForCalculatingWidth, constraints: cellPrototype.constraintsForCalculatingWidth)
            width += cellPrototype.layoutMargins.left + cellPrototype.layoutMargins.right
            self.cellWidthWitohutText = width
            
            self.textMessagefont = cellPrototype.messageTextLabel.font
        }
        
        let attributedString = NSAttributedString(string: textMessage, attributes: [NSFontAttributeName : self.textMessagefont!])
        let textHeight = attributedString.boundingRectWithSize(CGSize(width: (width - self.cellWidthWitohutText!), height: CGFloat.max), options: .UsesLineFragmentOrigin, context: nil).size.height
        
        return ceil(textHeight) + self.cellHeightWithoutText!
    }
    
    private class func calculateTotalHeight(views: [UIView], constraints: [NSLayoutConstraint]) -> CGFloat {
        var height: CGFloat = 0
        for view in views {
            height += view.frame.size.height
        }
        
        for constraint in constraints {
            height += constraint.constant
        }
        
        return height
    }
    
    private class func calculateTotalWidth(views: [UIView], constraints: [NSLayoutConstraint]) -> CGFloat {
        var width: CGFloat = 0
        for view in views {
            width += view.frame.size.width
        }
        
        for constraint in constraints {
            width += constraint.constant
        }
        
        return width
    }
}
