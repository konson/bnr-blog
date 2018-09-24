//
//  Blog_Nerd_RanchUITests.swift
//  Blog Nerd RanchUITests
//
//  Created by Chris Downie on 8/28/18.
//  Copyright © 2018 Chris Downie. All rights reserved.
//

import XCTest

class Blog_Nerd_RanchUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThatTappingOnAMetadataCellShowsThatPost() {
        let app = XCUIApplication()
        let firstCell = app.collectionViews.children(matching: .cell).element(boundBy: 0)
        let titleText = firstCell.staticTexts.element(matching: .any, identifier: "Post Title").label
        firstCell.tap()
        let postDetailTitle = app.scrollViews.otherElements.staticTexts.element(matching: .any, identifier: "Post Title").label
        
        XCTAssertEqual(titleText, postDetailTitle)
    }

    func testThatGroupLabelAppearsWhenGroupSelected() {
        
        let app = XCUIApplication()
        app.navigationBars["Blog Nerd Ranch"].buttons["Group By"].tap()
        app.sheets.buttons["Author"].tap()

        //TODO: figure out how to access the actual text not just accessibility labels
        // I want to compare the header label text to make sure it matches the author name
        // This test is dependent on the data
        let collectionViewsQuery = app.collectionViews
        let headerText = collectionViewsQuery.staticTexts["Alima Heath"].label

        XCTAssertEqual(headerText, "Alima Heath")
    }
    
    
    func testThatAuthorGroupingOptionIsAvailable() {
        let app = XCUIApplication()
        app.navigationBars["Blog Nerd Ranch"].buttons["Group By"].tap()
        
        let sheetsQuery = app.sheets
        let authorLabel = sheetsQuery.buttons["Author"].label
        XCTAssertEqual(authorLabel, "Author")
    }
    
    func testThatMonthGroupingOptionIsAvailable() {
        let app = XCUIApplication()
        app.navigationBars["Blog Nerd Ranch"].buttons["Group By"].tap()
        
        let sheetsQuery = app.sheets
        let monthLabel = sheetsQuery.buttons["Month"].label
        XCTAssertEqual(monthLabel, "Month")
    }
    
    func testThatNoGroupingOptionIsAvailable() {
        let app = XCUIApplication()
        app.navigationBars["Blog Nerd Ranch"].buttons["Group By"].tap()
        
        let sheetsQuery = app.sheets
        let authorLabel = sheetsQuery.buttons["No Grouping"].label
        XCTAssertEqual(authorLabel, "No Grouping")
    }
    
    func testThatCancelGroupingOptionIsAvailable() {
        let app = XCUIApplication()
        app.navigationBars["Blog Nerd Ranch"].buttons["Group By"].tap()
        
        let sheetsQuery = app.sheets
        let authorLabel = sheetsQuery.buttons["No Grouping"].label
        XCTAssertEqual(authorLabel, "No Grouping")
    }
    
    func testThatSortByAuthorAscendingIsAvailable() {
        let app = XCUIApplication()
        app.navigationBars["Blog Nerd Ranch"].buttons["Sort"].tap()
        let sortLabel = app.sheets.buttons["Author from A to Z"].label
        XCTAssertEqual(sortLabel, "Author from A to Z")
    }
    
    func testThatSortByAuthorDescendingIsAvailable() {
        let app = XCUIApplication()
        app.navigationBars["Blog Nerd Ranch"].buttons["Sort"].tap()
        let sortLabel = app.sheets.buttons["Author from Z to A"].label
        XCTAssertEqual(sortLabel, "Author from Z to A")
    }
    
    func testThatSortByTitleAscendingIsAvailable() {
        let app = XCUIApplication()
        app.navigationBars["Blog Nerd Ranch"].buttons["Sort"].tap()
        let sortLabel = app.sheets.buttons["Title from A to Z"].label
        XCTAssertEqual(sortLabel, "Title from A to Z")
    }
    
    func testThatSortByTitleDescendingIsAvailable() {
        let app = XCUIApplication()
        app.navigationBars["Blog Nerd Ranch"].buttons["Sort"].tap()
        let sortLabel = app.sheets.buttons["Title from Z to A"].label
        XCTAssertEqual(sortLabel, "Title from Z to A")
        
    }
    
    func testThatSortChronologicallyIsAvailable() {
        let app = XCUIApplication()
        app.navigationBars["Blog Nerd Ranch"].buttons["Sort"].tap()
        let sortLabel = app.sheets.buttons["Chronologically"].label
        XCTAssertEqual(sortLabel, "Chronologically")
    }
    
    func testThatSortByRecentPostsIsAvailable() {
        let app = XCUIApplication()
        app.navigationBars["Blog Nerd Ranch"].buttons["Sort"].tap()
        let sortLabel = app.sheets.buttons["Recent Posts First"].label
        XCTAssertEqual(sortLabel, "Recent Posts First")
    }
    
    func testThatSortCancelIsAvailable() {
        let app = XCUIApplication()
        app.navigationBars["Blog Nerd Ranch"].buttons["Sort"].tap()
        let sortLabel = app.sheets.buttons["Cancel"].label
        XCTAssertEqual(sortLabel, "Cancel")
    }

}
