//
//  HttpConnectionHandler.swift
//  letter_mouse
//
//  Created by mac on 31/03/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit


class HttpConnectionHandler {

    static let getInstance : HttpConnectionHandler = HttpConnectionHandler()
    var w3wResponseDelegate : W3WResponseDelegate?
    var findLetterResultDelegate : FindLetterResultDelegate?

    private init(){
        
    }
    
    func setW3WResponseDelegate(_ delegate : W3WResponseDelegate) {
        self.w3wResponseDelegate = delegate
    }
    func setFindLetterResultDelegate(_ delegate : FindLetterResultDelegate){
        self.findLetterResultDelegate = delegate
    }
    func httpUrlConnection (isSave : Bool, json : [String:String]){
        
        var url:String = "http://phwysl.dothome.co.kr/"
        if isSave {
            url += "send_letter.php"
        }
        else {
            url += "find_letter.php"
        }
        let urlStr = URL(string: url)!
        let session = URLSession.shared
        
        
        var request = URLRequest(url : urlStr)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
      
        let prefix = "json=" + stringify(json: json)
        request.httpBody = prefix.data(using: .utf8)
        print(prefix)
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                    print("error", error ?? "Unknown error")
                    return
            }
            
            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            let responseString = String(data: data, encoding: .utf8)
            var disableLineBreak = responseString?.replacingOccurrences(of: "\n", with: "\\n")
            print(disableLineBreak!)
           
            if let findLetterResultDelegate = self.findLetterResultDelegate, !isSave {
                findLetterResultDelegate.processFindLetterResult(disableLineBreak!)
            }
        }
        
        task.resume()
        
        
    }
    
    func stringify(json: Any, prettyPrinted: Bool = false) -> String {
        var options: JSONSerialization.WritingOptions = []
        if prettyPrinted {
            options = JSONSerialization.WritingOptions.prettyPrinted
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: options)
            if let string = String(data: data, encoding: String.Encoding.utf8) {
                return string
            }
        } catch {
            print(error)
        }
        
        return ""
    }
    

   
    func getWhat3WordsFromGPS(latitude:String, longitude :String) {
        
        var url:String = "https://api.what3words.com/v2/reverse?coords="
        url += latitude
        url += ","
        url += longitude
        url += "&display=full&format=json&key=KYM3G8LX";
        url += "&lang=ko";
        let urlStr = URL(string: url)!
        let session = URLSession.shared
        
        
        var request = URLRequest(url : urlStr)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) {(response, data, error) in
            guard let data = data else { return }
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                    print("error", error ?? "Unknown error")
                    return
            }
            
            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            
            if LetterController.getInstance.isSending {
                return
            }
            let responseString = String(data: data, encoding: .utf8)
            do {
                if let json = try JSONSerialization.jsonObject(with: data,options: .allowFragments) as? [String: Any]{
                    let j = json as NSDictionary
                    if let w3wResult = j["words"] as? String{
                        DispatchQueue.main.async {
                            if let delegate = self.w3wResponseDelegate{
                                delegate.processResult(w3wResult)
                            }
                        }
                    }
                }
            } catch let parseError {
                print("parsing error: \(parseError)")
                let responseString = String(data: data, encoding: .utf8)
                print("raw response: \(responseString)")
            }
           
            
            
        }
        
        task.resume()
        
    }
    

}
