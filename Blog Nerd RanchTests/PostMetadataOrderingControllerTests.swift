//
//  Blog_Nerd_RanchTests.swift
//  Blog Nerd RanchTests
//
//  Created by Chris Downie on 8/28/18.
//  Copyright © 2018 Chris Downie. All rights reserved.
//

import XCTest
@testable import Blog_Nerd_Ranch

class PostMetadataOrderingControllerTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testOrderWithNoPosts() {
        let ordering = DisplayOrdering(grouping: .none, sorting: .byPublishDate(recentFirst: false))
        
        let controller = PostMetadataOrderingController(ordering: ordering)
        let groups = controller.groups
        
        XCTAssertEqual(groups.count, 1)
        XCTAssertEqual(groups.first?.name, "Posts")
        XCTAssertEqual(groups.first?.postMetadata.count, 0)
    }
    
    func testOrderWithPosts() {
        let ordering = DisplayOrdering(grouping: .none, sorting: .byPublishDate(recentFirst: false))
        
        let date6 = Date(timeInterval: -1000000, since: Date())
        let date5 = Date(timeInterval: -2000000, since: Date())
        let date4 = Date(timeInterval: -3000000, since: Date())
        let date3 = Date(timeInterval: -4000000, since: Date())
        let date2 = Date(timeInterval: -5000000, since: Date())
        let date1 = Date(timeInterval: -6000000, since: Date())
        
        let author1 = Author(name: "Jane One", image: "url", title: "Post Title 1")
        let author2 = Author(name: "Jane Two", image: "url", title: "Post Title 2")
        let author3 = Author(name: "Jane Three", image: "url", title: "Post Title 3")
        
        let summary1 = "Lorem Ipsum"
        let summary2 = "It is a long established fact."
        let summary3 = "Many desktop publishing."
        let summary4 = "Standard dummy text ever."
        let summary5 = "Opposed to using Content here.."
        let summary6 = "Lorem ipsum will uncover."
        
        let post1 = PostMetadata(title: "First Post", publishDate: date1, author: author1, summary: summary1, postId: "1")
        let post2 = PostMetadata(title: "Second Post", publishDate: date2, author: author1, summary: summary2, postId: "2")
        let post3 = PostMetadata(title: "Third Post", publishDate: date3, author: author1, summary: summary3, postId: "3")
        let post4 = PostMetadata(title: "Forth Post", publishDate: date4, author: author2, summary: summary4, postId: "4")
        let post5 = PostMetadata(title: "Fifth Post", publishDate: date5, author: author2, summary: summary5, postId: "5")
        let post6 = PostMetadata(title: "Sixth Post", publishDate: date6, author: author3, summary: summary6, postId: "6")
        
        let postMetadataList = [post1, post2, post3, post4, post5, post6]

        let controller = PostMetadataOrderingController(ordering: ordering)
        controller.postMetadataList = postMetadataList
        
        let groups = controller.groups
        
        XCTAssertEqual(groups.count, 1)
        XCTAssertEqual(groups.first?.name, "Posts")
        XCTAssertEqual(groups.first?.postMetadata.count, postMetadataList.count)
    }
    
    func testOrderChronologically() {
        let ordering = DisplayOrdering(grouping: .none, sorting: .byPublishDate(recentFirst: false))
        
        let date6 = Date(timeInterval: -1000000, since: Date())
        let date5 = Date(timeInterval: -2000000, since: Date())
        let date4 = Date(timeInterval: -3000000, since: Date())
        let date3 = Date(timeInterval: -4000000, since: Date())
        let date2 = Date(timeInterval: -5000000, since: Date())
        let date1 = Date(timeInterval: -6000000, since: Date())
        
        let author1 = Author(name: "Jane One", image: "url", title: "Post Title 1")
        let author2 = Author(name: "Jane Two", image: "url", title: "Post Title 2")
        let author3 = Author(name: "Jane Three", image: "url", title: "Post Title 3")
        
        let summary1 = "Lorem Ipsum"
        let summary2 = "It is a long established fact."
        let summary3 = "Many desktop publishing."
        let summary4 = "Standard dummy text ever."
        let summary5 = "Opposed to using Content here.."
        let summary6 = "Lorem ipsum will uncover."
        
        let post1 = PostMetadata(title: "First Post", publishDate: date1, author: author1, summary: summary1, postId: "1")
        let post2 = PostMetadata(title: "Second Post", publishDate: date2, author: author1, summary: summary2, postId: "2")
        let post3 = PostMetadata(title: "Third Post", publishDate: date3, author: author1, summary: summary3, postId: "3")
        let post4 = PostMetadata(title: "Forth Post", publishDate: date4, author: author2, summary: summary4, postId: "4")
        let post5 = PostMetadata(title: "Fifth Post", publishDate: date5, author: author2, summary: summary5, postId: "5")
        let post6 = PostMetadata(title: "Sixth Post", publishDate: date6, author: author3, summary: summary6, postId: "6")
        
        let postMetadataList = [post1, post2, post3, post4, post5, post6]
        
        let controller = PostMetadataOrderingController(ordering: ordering)
        controller.postMetadataList = postMetadataList
        
        let groups = controller.groups
        
        XCTAssertEqual(groups.count, 1)
        XCTAssertEqual(groups.first?.name, "Posts")
        XCTAssertEqual(groups.first?.postMetadata, postMetadataList)
        XCTAssertEqual(groups.first?.postMetadata.count, postMetadataList.count)

    }
    
    func testOrderChronologicallyPosts() {
        let ordering = DisplayOrdering(grouping: .none, sorting: .byPublishDate(recentFirst: true))
        
        let date6 = Date(timeInterval: -1000000, since: Date())
        let date5 = Date(timeInterval: -2000000, since: Date())
        let date4 = Date(timeInterval: -3000000, since: Date())
        let date3 = Date(timeInterval: -4000000, since: Date())
        let date2 = Date(timeInterval: -5000000, since: Date())
        let date1 = Date(timeInterval: -6000000, since: Date())
        
        let author1 = Author(name: "Jane One", image: "url", title: "Post Title 1")
        let author2 = Author(name: "Jane Two", image: "url", title: "Post Title 2")
        let author3 = Author(name: "Jane Three", image: "url", title: "Post Title 3")
        
        let summary1 = "Lorem Ipsum"
        let summary2 = "It is a long established fact."
        let summary3 = "Many desktop publishing."
        let summary4 = "Standard dummy text ever."
        let summary5 = "Opposed to using Content here.."
        let summary6 = "Lorem ipsum will uncover."
        
        let post1 = PostMetadata(title: "First Post", publishDate: date1, author: author1, summary: summary1, postId: "1")
        let post2 = PostMetadata(title: "Second Post", publishDate: date2, author: author1, summary: summary2, postId: "2")
        let post3 = PostMetadata(title: "Third Post", publishDate: date3, author: author1, summary: summary3, postId: "3")
        let post4 = PostMetadata(title: "Forth Post", publishDate: date4, author: author2, summary: summary4, postId: "4")
        let post5 = PostMetadata(title: "Fifth Post", publishDate: date5, author: author2, summary: summary5, postId: "5")
        let post6 = PostMetadata(title: "Sixth Post", publishDate: date6, author: author3, summary: summary6, postId: "6")
        
        let postMetadataList = [post6, post5, post4, post3, post2, post1]
        
        let controller = PostMetadataOrderingController(ordering: ordering)
        controller.postMetadataList = postMetadataList
        
        let groups = controller.groups
        
        XCTAssertEqual(groups.count, 1)
        XCTAssertEqual(groups.first?.name, "Posts")
        XCTAssertEqual(groups.first?.postMetadata, postMetadataList)
        XCTAssertEqual(groups.first?.postMetadata.count, postMetadataList.count)
        
    }
    
}
