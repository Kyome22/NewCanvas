import DataLayer
import XCTest

@testable import Domain

final class CanvasServiceTests: XCTestCase {
    func test_homeDirectory() {
        let fileManagerClient = testDependency(of: FileManagerClient.self) {
            $0.homeDirectoryForCurrentUser = {
                URL(filePath: "/Users/user/Library/Containers/com.kyome.NewCanvas/Data/")
            }
        }
        let sut = CanvasService(.testValue, fileManagerClient)
        let actual = sut.homeDirectory
        XCTAssertEqual(actual, URL(filePath: "/Users/user/"))
    }

    func test_createCanvas_failedToCreateCGContext() {
        let sut = CanvasService(.testValue, .testValue)
        XCTAssertThrowsError(try sut.createCanvas(.tiff, .zero, .white)) {
            XCTAssertEqual($0 as? CanvasError, CanvasError.failedToCreateCGContext)
        }
    }

    func test_createCanvas_failedToMakeImageFromCGContext() {
        let sut = CanvasService(.testValue, .testValue)
        XCTAssertThrowsError(try sut.createCanvas(.tiff, CGSize(width: 50, height: 50), .white)) {
            XCTAssertEqual($0 as? CanvasError, CanvasError.failedToMakeImageFromCGContext)
        }
    }

    func test_createCanvas_failedToConvertDataFromImageRep() {
        let cgContextClient = testDependency(of: CGContextClient.self) {
            $0.makeImage = { _ in
                var rect = CGRect(x: 0, y: 0, width: 50, height: 50)
                let cgImage = NSImage(resource: .sample)
                    .cgImage(forProposedRect: &rect, context: nil, hints: nil)
                print(cgImage == nil)
                return cgImage
            }
        }
        let sut = CanvasService(cgContextClient, .testValue)
        XCTAssertThrowsError(try sut.createCanvas(.mp3, CGSize(width: 50, height: 50), .white)) {
            XCTAssertEqual($0 as? CanvasError, CanvasError.failedToConvertDataFromImageRep)
        }
    }
}
