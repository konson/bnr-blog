//
//  PostMetadata.swift
//  Blog Nerd Ranch
//
//  Created by Chris Downie on 8/28/18.
//  Copyright © 2018 Chris Downie. All rights reserved.
//

import Foundation

struct PostMetadata : Codable {
    let title : String
    let publishDate : Date
    let author: Author
    let summary: String
    let postId : String
    
    // this allows for grouping my month
    var monthString : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let publishDateString = dateFormatter.string(from: self.publishDate as Date)
        return publishDateString
    }

}

struct Author : Codable {
    let name : String
    let image : String
    let title : String
}
