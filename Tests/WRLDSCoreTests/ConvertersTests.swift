//
//  ConvertersTests.swift
//  WRLDSTests
//
//  Created by Gillian Reynolds-Titko on 5/25/20.
//  Copyright © 2020 WRLDS. All rights reserved.

import XCTest
@testable import WRLDSCore

class ConvertersTests: XCTestCase {

    var sut: Converters!
    override func setUp() {
        super.setUp()
        sut = Converters()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testConverters_convertCents_returnsDollarsAndCents(){
        let givenCents = 1540
        let expectedDollars = 15.40
        let actualDollars = sut.convert(fromCents: givenCents)
        XCTAssertEqual(expectedDollars, actualDollars)
    }
    
    func testConverters_convertCents_returnsnil(){
        let givenCents: Int? = nil
        let actualDollars = sut.convert(fromCents: givenCents)
        XCTAssertNil(actualDollars)
    }
    
    func testConverters_formatDouble_ReturnsDollarsAndCents() {
        let givenDollars = 15.40
        let expectedFormat = "$15.40"
        let actualFormat = sut.formatDouble(toCurrency: givenDollars)
        XCTAssertEqual(expectedFormat, actualFormat)
    }
    
    //Tests accuracy to the seconds
    func testConverters_convertsTimeIntervalToDate() {
        let todaysDate = Date()
        let todaysMinute = NSCalendar.current.component(.minute, from: todaysDate)
        let todaysSecond = NSCalendar.current.component(.second, from: todaysDate)
        let interval = todaysDate.timeIntervalSince1970
        
        let expectedDate = sut.convertFromTimestamp(toDate: TimeInterval(interval))
        let expectedMinute = NSCalendar.current.component(.minute, from: expectedDate)
        let expectedSecond = NSCalendar.current.component(.second, from: expectedDate)
        XCTAssertEqual(todaysSecond, expectedSecond, "The seconds are not equal")
        XCTAssertEqual(todaysMinute, expectedMinute, "The minutes are not equal")
    }
}
