//
//  FridgeManagerTests.swift
//  FridgeManagerTests
//
//  Created by Greg on 08/11/2021.
//

import XCTest
@testable import Reciplease

class FridgeManagerTests: XCTestCase {
    
    var fridgeManager: FridgeManager!
    
    override func setUp() {
        super.setUp()
        
        self.fridgeManager = FridgeManager()
    }

    
    // MARK: add(ingredient:)

    func test_givenEmptyIngredients_whenAddIngredient_thenIngredientsNotEmpty() throws {
        
        // given
        XCTAssertTrue(fridgeManager.ingredients.isEmpty)
        
        // when
        try fridgeManager.add(ingredient: "pizza")
        
        // then
        XCTAssertFalse(fridgeManager.ingredients.isEmpty)
    }
    
    func test_givenEmptyIngredients_whenAddSpecificIngredient_thenIngredientIsAdded() throws {
        
        // given
        XCTAssertTrue(fridgeManager.ingredients.isEmpty)
        
        // when
        try fridgeManager.add(ingredient: "Pizza")
        
        // then
        let firstIngredient = try XCTUnwrap(fridgeManager.ingredients.first)
        XCTAssertEqual(firstIngredient, "pizza")
    }
    
    func test_givenIngredientIsAlreadyAdded_whenAddSameIngredient_thenAlreadyAddedError() throws {
        
        // given
        try fridgeManager.add(ingredient: "Pizza")
        XCTAssertEqual(fridgeManager.ingredients, ["pizza"])
        
        // when then
        
        XCTAssertThrowsError(try fridgeManager.add(ingredient: "Pizza"), "") { error in
            guard let error = error as? FridgeManager.Error else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(error, .failedToAddIngredientDueToAlreadyPresent)
        }

    
    }
    
    
    func test_givenIngredientUpperCasedIsAlreadyAdded_whenAddSameIngredientButLowerCased_thenAlreadyAddedError() throws {
        
        // given
        try fridgeManager.add(ingredient: "Pizza")
        XCTAssertEqual(fridgeManager.ingredients, ["pizza"])
        
        // when then
        
        XCTAssertThrowsError(try fridgeManager.add(ingredient: "pizza"), "") { error in
            guard let error = error as? FridgeManager.Error else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(error, .failedToAddIngredientDueToAlreadyPresent)
        }

    
    }
    
    func test_givenIngredientIsAlreadyAdded_whenAddSameIngredientButWithSpaceStartAndEnd_thenAlreadyAddedError() throws {
        
        // given
        try fridgeManager.add(ingredient: "pizza")
        XCTAssertEqual(fridgeManager.ingredients, ["pizza"])
        
        // when then
        
        XCTAssertThrowsError(try fridgeManager.add(ingredient: " pizza "), "") { error in
            guard let error = error as? FridgeManager.Error else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(error, .failedToAddIngredientDueToAlreadyPresent)
        }

    
    }
    
    
    
    
    func test_givenEmptyIngredients_whenAddEmptyIngredient_thenIngredientIsEmptyError() throws {
        
        // given
        XCTAssertTrue(fridgeManager.ingredients.isEmpty)
        
        // when then
        
        XCTAssertThrowsError(try fridgeManager.add(ingredient: ""), "") { error in
            guard let error = error as? FridgeManager.Error else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(error, .failedToAddIngredientDueToEmptyIngredient)
        }

    
    }
    
    
    func test_givenEmptyIngredients_whenAddOnlySpacesIngredient_thenIngredientIsEmptyError() throws {
        
        // given
        XCTAssertTrue(fridgeManager.ingredients.isEmpty)
        
        // when then
        
        XCTAssertThrowsError(try fridgeManager.add(ingredient: "   "), "") { error in
            guard let error = error as? FridgeManager.Error else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(error, .failedToAddIngredientDueToEmptyIngredient)
        }

    
    }
    
    
    
    // MARK: clearIngredients()
    
    
    func test_given2IngredientsAlreadyAdded_whenClearIngredients_thenIngredientsIsEmpty() throws {
        
        // given
        try fridgeManager.add(ingredient: "Pizza")
        try fridgeManager.add(ingredient: "Pasta")
        XCTAssertEqual(fridgeManager.ingredients, ["pizza", "pasta"])
        
        // when
        fridgeManager.clearIngredients()

        
        // then
        XCTAssertTrue(fridgeManager.ingredients.isEmpty)
    }
    
    


}
