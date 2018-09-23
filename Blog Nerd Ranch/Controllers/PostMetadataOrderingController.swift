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
    let name : String?
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
    
    var groups : [PostMetadataGroup] {
        // TODO: Group & Order the posts according to the `ordering` value.
        print("\(self.ordering.debugDescription)")

        var dictionary = Dictionary<String, [PostMetadata]>()
        var postMetadataGroupArray = [PostMetadataGroup]()
        switch ordering.grouping {
        case .byAuthor:
            let predicate = { (element: PostMetadata) in
                return element.author.name
            }
            dictionary = Dictionary(grouping: postMetadataList, by: predicate)
            
            for (key, value) in dictionary {
                postMetadataGroupArray.append(PostMetadataGroup(name: key, postMetadata: value))
            }
            
        case .byMonth:
            
            let predicate = { (element: PostMetadata) in
                return element.month
            }
            dictionary = Dictionary(grouping: postMetadataList, by: predicate)
            
            for (key, value) in dictionary {

                postMetadataGroupArray.append(PostMetadataGroup(name: key, postMetadata: value))
            }
            
        case .none:
            print("none!")
        }
        

        
        
        // set the sorting array
        var sortedList: [PostMetadata] = []
        switch ordering.sorting {
        case .alphabeticalByAuthor(let ascending):
            sortedList = ascending ? self.postMetadataList.sorted() { $0.author.name < $1.author.name } : self.postMetadataList.sorted() { $0.author.name > $1.author.name }
        case .alphabeticalByTitle(let ascending):
            sortedList = ascending ? self.postMetadataList.sorted() { $0.title < $1.title } : self.postMetadataList.sorted() { $0.title > $1.title }
        case .byPublishDate(let recentFirst):
            sortedList = recentFirst ? self.postMetadataList.sorted() { $0.publishDate > $1.publishDate } : self.postMetadataList.sorted() { $0.publishDate < $1.publishDate }
        }

        //return [PostMetadataGroup(name: nil, postMetadata: sortedList)]
        return postMetadataGroupArray.isEmpty ? [PostMetadataGroup(name: nil, postMetadata: sortedList)] : postMetadataGroupArray

    }
}
