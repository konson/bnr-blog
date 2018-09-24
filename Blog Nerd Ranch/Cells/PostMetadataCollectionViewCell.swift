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
    @IBOutlet var authorTitleLabel: UILabel!
    @IBOutlet var publishDateLabel: UILabel!
    @IBOutlet var summaryLabel: UILabel!
    @IBOutlet var imageView: UIImageView!

    var imageURL: URL?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.masksToBounds = false
        configure()
    }

    func configure() {
        
        let labelArray = [titleLabel, authorNameLabel, publishDateLabel, summaryLabel, authorTitleLabel]
        
        for label in labelArray {
            if let label = label {
                label.isAccessibilityElement = true
                label.accessibilityTraits = UIAccessibilityTraitStaticText
                label.lineBreakMode = .byWordWrapping
                label.numberOfLines = 0
            }
        }
        
        // Set accessibility
        titleLabel.accessibilityLabel = "Post Title"
        authorNameLabel.accessibilityLabel = "Author Name"
        publishDateLabel.accessibilityLabel = "Date Published"
        summaryLabel.accessibilityLabel = "Post Summary"
        authorTitleLabel.accessibilityLabel = "Author Title"
        
        // Format round image view
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightestGray.cgColor
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        
        // Style the content view to match website style
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5;
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowRadius = 2
        contentView.layer.shadowOffset = CGSize(width: 0, height: 5)
        contentView.layer.shadowOpacity = 0.1

    }
    
    func setAuthorImage() {
        self.imageView.image = UIImage(named: "genericProfile")
        guard let imageURL = self.imageURL else { return }
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: imageURL) { (data, response, error) in
            if let data = data, let image = UIImage(data: data)  {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
        task.resume()
    }
}
