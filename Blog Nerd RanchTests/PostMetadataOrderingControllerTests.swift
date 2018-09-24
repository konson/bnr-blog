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
}
