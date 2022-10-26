//
//  MovieAppTests.swift
//  MovieAppTests
//
//  Created by Nezih on 15.10.2022.
//

import XCTest
import Combine
@testable import MovieApp

final class MovieAppTests: XCTestCase {
    
    private var cancellables = Set<AnyCancellable>()
    
    override func setUp() async throws {
        try await super.setUp()
        cancellables.removeAll()
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
    }
    
    func testGettingMoviesWithMockEmptyResult() {
        let expectations = expectation(description: "Testing empty state with Mock API")
        
        let mockAPI = MockMovieAPI()
        mockAPI.loadState = .empty
        
        let viewModel = MoviesViewModel(apiService: mockAPI)
        viewModel.getMovies()
        
        viewModel.$movies
            .receive(on: RunLoop.main)
            .sink{ movies in
                XCTAssertTrue(movies?.results == nil, "Expected movies to be empty, but there are some values.")
                expectations.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("Exceptations failed. Error: \(error)")
            }
        }
        
    }
    
    func testGettingMoviesWithErrorResutlt() {
        let expectations = expectation(description: "Testing error state with Mock API")
        
        let mockAPI = MockMovieAPI()
        mockAPI.loadState = .error
        
        let viewModel = MoviesViewModel(apiService: mockAPI)
        viewModel.getMovies()
        
        viewModel.$error
            .receive(on: RunLoop.main)
            .sink { error in
                XCTAssertNotNil(error, "Expected to get an error, but recieved no error.")
                expectations.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("Exceptations failed. Error: \(error)")
            }
        }
        
        func testGettingMoviesWithSuccessResult() {
            let expectations = expectation(description: "Testing success state with Mock API")
            
            let mockAPI = MockMovieAPI()
            mockAPI.loadState = .loaded
            
            let viewModel = MoviesViewModel(apiService: mockAPI)
            viewModel.getMovies()
            
            viewModel.$movies
                .receive(on: RunLoop.main)
                .sink { movies in
                    XCTAssert(movies?.results.isEmpty == false, "Excepted to get schools, but data is empty.")
                    expectations.fulfill()
                }
                .store(in: &cancellables)
            
            waitForExpectations(timeout: 1.0) { error in
                if let error = error {
                    XCTFail("Exceptations failed. Error: \(error)")
                }
            }
        }
        
        func testPerformanceExample() throws {
            // This is an example of a performance test	 case.
            self.measure {
                // Put the code you want to measure the time of here.
            }
        }
        
    }
}
