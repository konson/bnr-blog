//
//  PostMetadataCollectionViewCell.swift
//  Blog Nerd Ranch
//
//  Created by Chris Downie on 8/28/18.
//  Copyright © 2018 Chris Downie. All rights reserved.
//

import UIKit

class PostMetadataCollectionViewCell: UICollectionViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorNameLabel: UILabel!
    @IBOutlet var publishDateLabel: UILabel!
    @IBOutlet var summaryLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.masksToBounds = false
        configure()
    }

    func configure() {
        titleLabel.isAccessibilityElement = true
        titleLabel.accessibilityTraits = UIAccessibilityTraitStaticText
        titleLabel.accessibilityLabel = "Post Title"
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0


        
        //TODO: remove
//        authorNameLabel.text = "Earnest Hemmingway"
//        publishDateLabel.text = "Sept 22, 2018"
//        summaryLabel.text = 
    
        
        // Style the content view to match website style
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5;
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowRadius = 2
        contentView.layer.shadowOffset = CGSize(width: 0, height: 5)
        contentView.layer.shadowOpacity = 0.1
    }
}
