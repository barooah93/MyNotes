//
//  notesTableViewCell.swift
//  MyNotesApp
//
//  Created by Barooah, Brandon N on 1/5/18.
//  Copyright © 2018 personal. All rights reserved.
//

import UIKit

class notesTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setNotes(note:MyNotes){
        titleLabel.text = note.title
        detailsLabel.text = note.details
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy h:mm a"
        let now = dateFormatter.string(from: note.date_saved!)
        dateLabel.text = now
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
