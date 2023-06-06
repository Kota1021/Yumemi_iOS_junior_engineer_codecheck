//
//  Yumemi_iOS_junior_engineer_codecheckTests.swift
//  Yumemi_iOS_junior_engineer_codecheckTests
//
//  Created by 松本幸太郎 on 2023/05/31.
//

import XCTest

@testable import Yumemi_iOS_junior_engineer_codecheck

final class Yumemi_iOS_junior_engineer_codecheckTests: XCTestCase {
    
    /// checks Model's fetching function.
    func testFetchPrefecture() throws{
        let model = PrefectureModel()
        
        let validYMDDate = YearMonthDay(from: Date())
        let invalidYMDDate = YearMonthDay(year: 0, month: 0, day: 0)
        
        let validInput = FetchInput(name: "a", birthday: validYMDDate, bloodType: .a, today: validYMDDate)
        let invalidInput = FetchInput(name: "", birthday: invalidYMDDate, bloodType: .a, today: validYMDDate)
        
        //check if sucseeds with valid input
        var sucsessContainer:YumemiAPIPrefecture? = nil
        // check if it can fetch data in one second
        var fetchExpectation:XCTestExpectation? = self.expectation(description: "fetched")
        
        model.fetchLuckyPrefecture(input: validInput){
        } onSuccess: { pref in
            sucsessContainer = pref
            XCTAssertNotNil(sucsessContainer)
            fetchExpectation?.fulfill()
        } onFailure: { _ in}
        self.waitForExpectations(timeout: 1)
        
        
        // check if fails with invalid input
        var errorContainer:Error? = nil
            model.fetchLuckyPrefecture(input: invalidInput){
            } onSuccess: { _ in
            } onFailure: { error in
                print(error)
                errorContainer = error
                XCTAssertNotNil(errorContainer)
            }
    }
    
    func testJSONload() throws {
        XCTAssertNotNil(ImageInfoSets.thumbnailURLs(of: "東京都") )
        XCTAssertNotNil(ImageInfoSets.randomThumbnailURL(of: "東京都") )
        XCTAssertNotNil(PrefectureLocations.location(of: "東京都") )
        }
    
    
    
}
