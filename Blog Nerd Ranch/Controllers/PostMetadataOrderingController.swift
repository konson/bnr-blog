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
        return [PostMetadataGroup(name: nil, postMetadata: postMetadataList)]
    }
}
