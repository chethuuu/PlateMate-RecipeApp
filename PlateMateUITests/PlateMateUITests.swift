//
//  PlateMateUITests.swift
//  PlateMateUITests
//
//  Created by Chethana on 2023-04-20.
//

import XCTest

final class PlateMateUITests: XCTestCase {

    func testExample() throws {
        
        let app = XCUIApplication()
        app.launch()
     
        let nextButton = app.buttons["Next"]
        nextButton.tap()
        nextButton.tap()
        app.buttons["Get Started"].tap()
        
        let toastStaticText = app.tables.cells.element(boundBy: 0).staticTexts["Toast"]
        toastStaticText.tap()
        
        let platemateFooddetailsviewNavigationBar = app.navigationBars["PlateMate.FoodDetailsView"]
        platemateFooddetailsviewNavigationBar.buttons["Edit"].tap()
        
        let nameField = app.textFields["Recipe Name"]
        nameField.tap()
        nameField.tap()
        app.buttons["Update Recipe"].tap()
        
        let platemateButton = platemateFooddetailsviewNavigationBar.buttons["PlateMate"]
        platemateButton.tap()
        
        // Find the individual table cell by index and tap it again
        let toastStaticText2 = app.tables.cells.element(boundBy: 0).staticTexts["Toast"]
        toastStaticText2.tap()
        
        platemateButton.tap()
              
        // Use XCTAssert and related functions to verify tests produce the correct results.
    }
}
