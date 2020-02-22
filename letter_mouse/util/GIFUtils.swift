import UIKit
import ImageIO
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}



extension UIImage {
    
//    public class func gifImageWithURL(_ gifUrl:String) -> UIImage? {
//        guard let bundleURL:URL? = URL(string: gifUrl)
//            else {
//                print("image named \"\(gifUrl)\" doesn't exist")
//                return nil
//        }
//        guard let imageData = try? Data(contentsOf: bundleURL!) else {
//            print("image named \"\(gifUrl)\" into NSData")
//            return nil
//        }
//
//        return gifImageWithData(imageData)
//    }
//
//    public class func gifImageWithName(_ name: String) -> UIImage? {
//        guard let bundleURL = Bundle.main
//            .url(forResource: name, withExtension: "gif") else {
//                print("SwiftGif: This image named \"\(name)\" does not exist")
//                return nil
//        }
//        guard let imageData = try? Data(contentsOf: bundleURL) else {
//            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
//            return nil
//        }
//
//        return gifImageWithData(imageData)
//    }
    
    class func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }
        
        if a < b {
            let c = a
            a = b
            b = c
        }
        
        var rest: Int
        while true {
            rest = a! % b!
            
            if rest == 0 {
                return b!
            } else {
                a = b
                b = rest
            }
        }
    }
    
    
    
}
