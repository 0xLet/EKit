import XCTest
@testable import EKit

final class EKitTests: XCTestCase {
    var sema = DispatchSemaphore(value: 0)
    
    func testLoadAllFullQualifiedEmojis() {
        let path = "https://unicode.org/Public/emoji/12.0/emoji-test.txt"
        guard let url = URL(string: path) else {
            XCTFail()
            return
        }
        
        let task = URLSession.shared
            .dataTask(with: url) { (data, response, error) in
                guard let data = data,
                    let file = String(data: data, encoding: .utf8) else {
                        XCTFail()
                        return
                }
                // 1F617                                      ; fully-qualified     # 😗 kissing face
                let magic = #"([0-9| |A-Z]+); (\D+) # (\S+) ([a-z|:|\-"|,| |A-Z|#|*|0-9|(|)|"|!|']+)\n"#
                let regex = try? NSRegularExpression(pattern: magic, options: [])
                
                var emojis = [String]()
                
                let nsrange = NSRange(file.startIndex..<file.endIndex,
                                      in: file)
                
                regex?.enumerateMatches(in: file,
                                        options: [],
                                        range: nsrange) { (match, _, stop) in
                                            guard let match = match else { return }
                                            let unicode = file[Range(match.range(at: 1), in: file)!]
                                                .trimmingCharacters(in: .whitespaces)
                                                .split(separator: " ")
                                                .map { #"\"# + "u{\($0)}"}
                                                .joined()
                                            
                                            
                                            let name = file[Range(match.range(at: 4), in: file)!]
                                                .replacingOccurrences(of: ",", with: "")
                                                .replacingOccurrences(of: ":", with: "")
                                                .replacingOccurrences(of: "-", with: " ")
                                                .replacingOccurrences(of: " ", with: "_")
                                                .lowercased()
                                            
                                            let type = file[Range(match.range(at: 2), in: file)!]
                                            
                                            if type.contains("fully-qualified") {
                                                
                                                emojis.append("case \(name) = \(unicode)")
                                            }
                }
                
                print("Emojis: \(emojis)")
                
                self.sema.signal()
        }
        
        task.resume()
        sema.wait()
        
        XCTAssert(true)
    }
    
    func testAllEmojis() {
        E.allCases.forEach {
            print("\($0): \($0.rawValue)")
        }
    }
    
    static var allTests = [
        ("testLoadAllFullQualifiedEmojis", testLoadAllFullQualifiedEmojis),
        ("testAllEmojis", testAllEmojis)
    ]
}
