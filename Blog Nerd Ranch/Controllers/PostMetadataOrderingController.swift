//
//  PostOrderingController.swift
//  Blog Nerd Ranch
//
//  Created by Chris Downie on 9/3/18.
//  Copyright © 2018 Chris Downie. All rights reserved.
//

import Foundation

/// Represents a named group of posts. The nature of the group depends on the ordering it was created with
struct PostMetadataGroup {
    let name : String
    let postMetadata: [PostMetadata]
}

/// Group & sort posts based on the given ordering.
class PostMetadataOrderingController {
    var ordering : DisplayOrdering
    var postMetadataList : [PostMetadata]
    
    init(ordering: DisplayOrdering, postMetadata: [PostMetadata] = []) {
        self.ordering = ordering
        self.postMetadataList = postMetadata
    }
    
    //TODO: Fix - Sorting with group. When group type and sort type match
    // not sorting properly. Date sort should sort both group order
    // and elements inside group
    
    //TODO: Refactor! In a big way.
    
    //TODO: Fix - why is this firing so many times?
    var groups : [PostMetadataGroup] {

//        print("Inside groups:\(self.ordering.debugDescription)")
        
        var sortedList = postMetadataList // set default if no group is selected
        switch ordering.sorting {
        case .alphabeticalByAuthor(let ascending):
            sortedList = ascending ? self.postMetadataList.sorted() { $0.author.name < $1.author.name } : self.postMetadataList.sorted() { $0.author.name > $1.author.name }
        case .alphabeticalByTitle(let ascending):
            sortedList = ascending ? self.postMetadataList.sorted() { $0.title < $1.title } : self.postMetadataList.sorted() { $0.title > $1.title }
        case .byPublishDate(let recentFirst):
            sortedList = recentFirst ? self.postMetadataList.sorted() { $0.publishDate > $1.publishDate } : self.postMetadataList.sorted() { $0.publishDate < $1.publishDate }
        }

        var dictionary = Dictionary<String, [PostMetadata]>()
        var postMetadataGroupArray = [PostMetadataGroup]()
        
        switch ordering.grouping {
        case .byAuthor:
            dictionary = Dictionary(grouping: sortedList, by: { (post: PostMetadata) in return post.author.name })
        case .byMonth:
            dictionary = Dictionary(grouping: sortedList, by: { (post: PostMetadata) in return post.month })
        case .none:
            dictionary["Posts"] = sortedList
        }
        
        for (group, posts) in dictionary {
            postMetadataGroupArray.append(PostMetadataGroup(name: group, postMetadata: posts))
            switch ordering.sorting {
            case .alphabeticalByAuthor(let ascending):
                postMetadataGroupArray = ascending ? postMetadataGroupArray.sorted() { $0.name < $1.name } : postMetadataGroupArray.sorted() { $0.name > $1.name }
            case .alphabeticalByTitle(let ascending):
                postMetadataGroupArray = ascending ? postMetadataGroupArray.sorted() { $0.name < $1.name } : postMetadataGroupArray.sorted() { $0.name > $1.name }
            case .byPublishDate(let recentFirst):
                // must sort by date
                print("Need to sort groups by date")
            }
        }

        return postMetadataGroupArray

    }
}
