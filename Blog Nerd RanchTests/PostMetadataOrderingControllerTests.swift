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
    
    func testSortWithNoPosts() {
        let ordering = DisplayOrdering(grouping: .none, sorting: .byPublishDate(recentFirst: false))
        
        let controller = PostMetadataOrderingController(ordering: ordering)
        let groups = controller.groups
        
        XCTAssertEqual(groups.count, 1)
        XCTAssertEqual(groups.first?.name, "Posts")
        XCTAssertEqual(groups.first?.postMetadata.count, 0)
    }
    
    func testSortPostsChrolonogically() {
        let ordering = DisplayOrdering(grouping: .none, sorting: .byPublishDate(recentFirst: false))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        
        guard let date1 = formatter.date(from: "Jul 15, 2018"),
            let date2 = formatter.date(from: "Jul 18, 2018"),
            let date3 = formatter.date(from: "Aug 1, 2018"),
            let date4 = formatter.date(from: "Aug 14, 2018"),
            let date5 = formatter.date(from: "Aug 22, 2018"),
            let date6 = formatter.date(from: "Aug 30, 2018") else { return }

        
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

        
        let testList = [post1, post2, post3, post4, post5, post6]
        
        let postMetadataList = [post6, post4, post5, post3, post2, post1]

        let controller = PostMetadataOrderingController(ordering: ordering)
        controller.postMetadataList = postMetadataList
        
        let groups = controller.groups
        
        XCTAssertEqual(groups.count, 1)
        XCTAssertEqual(groups.first?.name, "Posts")
        XCTAssertEqual(groups.first?.postMetadata.count, testList.count)
        XCTAssertEqual(groups.first?.postMetadata, testList)

    }
    
    func testSortPostsRecentFirst() {
        let ordering = DisplayOrdering(grouping: .none, sorting: .byPublishDate(recentFirst: true))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        
        guard let date1 = formatter.date(from: "Jul 15, 2018"),
            let date2 = formatter.date(from: "Jul 18, 2018"),
            let date3 = formatter.date(from: "Aug 1, 2018"),
            let date4 = formatter.date(from: "Aug 14, 2018"),
            let date5 = formatter.date(from: "Aug 22, 2018"),
            let date6 = formatter.date(from: "Aug 30, 2018") else { return }
        
        
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
        
        let postMetadataList = [post3, post5, post4, post6, post1, post2]
        
        let testList = [post6, post5, post4, post3, post2, post1]
        
        let controller = PostMetadataOrderingController(ordering: ordering)
        controller.postMetadataList = postMetadataList
        
        let groups = controller.groups
        
        XCTAssertEqual(groups.count, 1)
        XCTAssertEqual(groups.first?.name, "Posts")
        XCTAssertEqual(groups.first?.postMetadata, testList)
        XCTAssertEqual(groups.first?.postMetadata.count, testList.count)

    }
    
    func testGroupingPostsByAuthor() {
        let ordering = DisplayOrdering(grouping: .byAuthor, sorting: .byPublishDate(recentFirst: true))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        
        guard let date1 = formatter.date(from: "Jul 15, 2018"),
            let date2 = formatter.date(from: "Jul 18, 2018"),
            let date3 = formatter.date(from: "Aug 1, 2018"),
            let date4 = formatter.date(from: "Aug 14, 2018"),
            let date5 = formatter.date(from: "Aug 22, 2018"),
            let date6 = formatter.date(from: "Aug 30, 2018") else { return }
        
        
        let authorAbbeyOne = Author(name: "Abby One", image: "url", title: "Post Title 1")
        let authorBobTwo = Author(name: "Bob Two", image: "url", title: "Post Title 2")
        let authorCandiceThree = Author(name: "Candice Three", image: "url", title: "Post Title 3")
        
        let authorArray = [authorAbbeyOne, authorBobTwo, authorCandiceThree]
        
        let summary1 = "Lorem Ipsum"
        let summary2 = "It is a long established fact."
        let summary3 = "Many desktop publishing."
        let summary4 = "Standard dummy text ever."
        let summary5 = "Opposed to using Content here.."
        let summary6 = "Lorem ipsum will uncover."
        
        let post1 = PostMetadata(title: "First Post", publishDate: date1, author: authorAbbeyOne, summary: summary1, postId: "1")
        let post2 = PostMetadata(title: "Second Post", publishDate: date2, author: authorAbbeyOne, summary: summary2, postId: "2")
        let post3 = PostMetadata(title: "Third Post", publishDate: date3, author: authorAbbeyOne, summary: summary3, postId: "3")
        let post4 = PostMetadata(title: "Forth Post", publishDate: date4, author: authorBobTwo, summary: summary4, postId: "4")
        let post5 = PostMetadata(title: "Fifth Post", publishDate: date5, author: authorBobTwo, summary: summary5, postId: "5")
        let post6 = PostMetadata(title: "Sixth Post", publishDate: date6, author: authorCandiceThree, summary: summary6, postId: "6")
        
        let postMetadataList = [post6, post5, post4, post3, post2, post1]
        
        let controller = PostMetadataOrderingController(ordering: ordering)
        controller.postMetadataList = postMetadataList
        
        let groups = controller.groups
        
        XCTAssertEqual(groups.count, authorArray.count)
        XCTAssertEqual(groups[0].name, authorAbbeyOne.name)
        XCTAssertEqual(groups[1].name, authorBobTwo.name)
        XCTAssertEqual(groups[2].name, authorCandiceThree.name)
    }
    
    func testGroupingPostsByMonth() {
        let ordering = DisplayOrdering(grouping: .byMonth, sorting: .byPublishDate(recentFirst: true))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        
        guard let date1 = formatter.date(from: "Jul 15, 2018"),
            let date2 = formatter.date(from: "Jul 18, 2018"),
            let date3 = formatter.date(from: "Aug 1, 2018"),
            let date4 = formatter.date(from: "Aug 14, 2018"),
            let date5 = formatter.date(from: "Aug 22, 2018"),
            let date6 = formatter.date(from: "Aug 30, 2018") else { return }
        
        
        let authorAbbeyOne = Author(name: "Abby One", image: "url", title: "Post Title 1")
        let authorBobTwo = Author(name: "Bob Two", image: "url", title: "Post Title 2")
        let authorCandiceThree = Author(name: "Candice Three", image: "url", title: "Post Title 3")
                
        let summary1 = "Lorem Ipsum"
        let summary2 = "It is a long established fact."
        let summary3 = "Many desktop publishing."
        let summary4 = "Standard dummy text ever."
        let summary5 = "Opposed to using Content here.."
        let summary6 = "Lorem ipsum will uncover."
        
        let post1 = PostMetadata(title: "First Post", publishDate: date1, author: authorAbbeyOne, summary: summary1, postId: "1")
        let post2 = PostMetadata(title: "Second Post", publishDate: date2, author: authorAbbeyOne, summary: summary2, postId: "2")
        let post3 = PostMetadata(title: "Third Post", publishDate: date3, author: authorAbbeyOne, summary: summary3, postId: "3")
        let post4 = PostMetadata(title: "Forth Post", publishDate: date4, author: authorBobTwo, summary: summary4, postId: "4")
        let post5 = PostMetadata(title: "Fifth Post", publishDate: date5, author: authorBobTwo, summary: summary5, postId: "5")
        let post6 = PostMetadata(title: "Sixth Post", publishDate: date6, author: authorCandiceThree, summary: summary6, postId: "6")
        
        let postMetadataList = [post6, post1, post4, post3, post5, post2]
        
        let controller = PostMetadataOrderingController(ordering: ordering)
        controller.postMetadataList = postMetadataList
        
        let groups = controller.groups
        
        XCTAssertEqual(groups.count, 2)
        XCTAssertEqual(groups[0].name, "August")
        XCTAssertEqual(groups[1].name, "July")
    }
    
}
