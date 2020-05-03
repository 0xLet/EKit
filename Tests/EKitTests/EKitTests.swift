import XCTest
@testable import EKit

final class EKitTests: XCTestCase {
    let path = "https://unicode.org/Public/emoji/12.0/emoji-test.txt"
    let keywords = ["guard"]
    let charactersToRemove = "!(),:"
    let replacements = [
        ("#","hashtag"),
        ("*", "star"),
        ("1st", "first"),
        ("2nd", "second"),
        ("3rd", "third")
    ]
    
    var sema = DispatchSemaphore(value: 0)
    var emojis = [String]()
    
    func testLoadAllFullQualifiedEmojis() {
        guard let url = URL(string: path) else {
            XCTFail()
            return
        }
        
        let task = URLSession.shared
            .dataTask(with: url) { (data, response, error) in
                // 1F617                                      ; fully-qualified     # 😗 kissing face
                let regexPattern = #"([0-9| |A-Z]+); (\D+) # (\S+) ([a-z|:|\-"|,| |A-Z|#|*|0-9|(|)|"|!|']+)\n"#
                guard let data = data,
                    let file = String(data: data, encoding: .utf8),
                    let regex = try? NSRegularExpression(pattern: regexPattern,
                                                         options: []) else {
                                                            XCTFail()
                                                            return
                }
                let nsrange = NSRange(file.startIndex..<file.endIndex,
                                      in: file)
                
                regex.enumerateMatches(in: file,
                                       options: [],
                                       range: nsrange) { (match, _, stop) in
                                        guard let match = match else { return }
                                        
                                        let unicode = file[Range(match.range(at: 1), in: file)!]
                                            .trimmingCharacters(in: .whitespaces)
                                            .split(separator: " ")
                                            .map { #"\"# + "u{\($0)}"}
                                            .joined()
                                        
                                        let type = file[Range(match.range(at: 2), in: file)!]
                                        
                                        var name = file[Range(match.range(at: 4), in: file)!]
                                            .replacingOccurrences(of: "-", with: " ")
                                            .replacingOccurrences(of: " ", with: "_")
                                            .lowercased()
                                        
                                        self.charactersToRemove.forEach { char in
                                            name = name.replacingOccurrences(of: "\(char)", with: "")
                                        }
                                        
                                        self.replacements.forEach { pair in
                                            name = name.replacingOccurrences(of: pair.0, with: pair.1)
                                        }
                                        
                                        if type.contains("fully-qualified") {
                                            if self.keywords.contains(name) {
                                                self.emojis.append("case `\(name)` = \"\(unicode)\"")
                                            } else {
                                                self.emojis.append("case \(name) = \"\(unicode)\"")
                                            }
                                        }
                }
                
                print("=====(GENERATED CODE START)=====")
                
                print("""
                    public enum E: String, CaseIterable {
                        public typealias RawValue = String
                    """)
                
                self.emojis.forEach { print("\t\($0)") }
                
                print("}")
                
                print("======(GENERATED CODE END)======")
                
                
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
