
import XCTest
@testable import Froggy

final class FroggyTests: XCTestCase {
    
    private let baseURL = URL(string: "https://catfact.ninja")!
    
    private enum TestPaths: URLPath {
        case fact
        
        func path() -> String {
            switch self {
            case .fact: return "/fact"
            }
        }
    }
    
    private struct CatFactResponse: Codable {
        var fact: String
        var length: Int
    }
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testAppendPaths() async throws {
        XCTAssertNotNil(baseURL)
        XCTAssertEqual(baseURL.absoluteString, "https://catfact.ninja")
        
        let requestURL = baseURL.addPath(TestPaths.fact)
        XCTAssertNotNil(requestURL)
        
        let expectedFactURL = "https://catfact.ninja/fact"
        XCTAssertEqual(requestURL.absoluteString, expectedFactURL)
    }
    
    func testComposeQuery() async throws {
        let requestURL = baseURL.addPath(TestPaths.fact).addQueryItems([
            URLQueryItem(name: "max_length", value: "80")
        ])
        
        let expectedFactURL = "https://catfact.ninja/fact?max_length=80"
        XCTAssertEqual(requestURL.absoluteString, expectedFactURL)
    }
    
    func testQuerySucceeds() async throws {
        let request = baseURL
            .addPath(TestPaths.fact)
            .addQueryItems([
                URLQueryItem(name: "max_length", value: "80")
            ])
            .request()
        
        let expectedFactURL = "https://catfact.ninja/fact?max_length=80"
        XCTAssertEqual(request.url!.absoluteString, expectedFactURL)
        
        do {
            let session = URLSession(configuration: .default)
            let response: DataSourceResponse<CatFactResponse> = try await session.run(request)
            XCTAssertGreaterThanOrEqual(response.value.fact.count, 1)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
}

