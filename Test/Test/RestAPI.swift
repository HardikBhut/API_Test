//
//  RestAPI.swift
//  Test
//
//  Created by Hardik Bhut on 03/06/24.
//

import Foundation
import Alamofire

final class RestAPI : NSObject{
    
    static let sharedInstance = RestAPI()
    private override init() {}
    
    // MARK: =====================  Web Service Common Method For Get ========================== //
    func executerGetCommonRequest(strFunName: String , completion: @escaping (_ success: Any? ,_ failresult: Error? ) -> Void)
    {
        let url = Globalvar.BaseURL.appending(strFunName)
        print("REQUEST URL:\n\(url)")
        let baseURl = URL(string: url)
        var mRequest = URLRequest(url:baseURl!)
        mRequest.httpMethod =  "GET"
        mRequest.addValue("application/json", forHTTPHeaderField:"Accept")
        
        AF.request(mRequest).responseJSON
        { response in
            
            switch response.result
            {

            case .success(let value):
                
                print(response.response?.statusCode ?? "")
                
                if let jsonDict = value as? NSDictionary {
                    
                    let data = try! JSONSerialization.data(withJSONObject: value as Any, options: .prettyPrinted)
                    let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    print("RESPONSE JSON:\n\(string as AnyObject)")
                    
                    completion(jsonDict,nil)
                } else if let jsonDict = value as? NSArray {
                    
                    let data = try! JSONSerialization.data(withJSONObject: value as Any, options: .prettyPrinted)
                    let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    print("RESPONSE JSON:\n\(string as AnyObject)")
                    
                    completion(jsonDict,nil)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                switch (response.error!._code)
                {
                case NSURLErrorTimedOut:
                    print(response.error ?? "0")
                    completion(["message":"Error occured"],error)
                    break
                case NSURLErrorNotConnectedToInternet:
                    completion(["message":"Please check internet connection"],error)
                    break
                default:
                    completion(["message":"Error occured"],error)
                }
            }
        }
    }
    
    // MARK: =====================  Web Service Common Method For Post ========================== //
    
    func executeCommonRequest( parameter:[String:Any],strFunName: String , completion: @escaping (_ success: Any? ,_ failresult: Error? ) -> Void)
    {
        //enableCertificatePinning()
       
        let url = Globalvar.BaseURL.appending(strFunName)
        print("REQUEST URL:\n\(url)")
        let baseURl = URL(string: url)
        var mRequest = URLRequest(url:baseURl!)
        mRequest.httpMethod =  "POST"
        
        let data = try! JSONSerialization.data(withJSONObject: parameter, options: JSONSerialization.WritingOptions.prettyPrinted)
        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        print("REQUEST JSON:\n\(json as AnyObject)")
        
        let headers = ["content-type": "application/json",
                       "cache-control": "no-cache"]
        

        
        mRequest.allHTTPHeaderFields = headers
        let postData = (try? JSONSerialization.data(withJSONObject: parameter, options: []))
        
        mRequest.httpBody = postData!
        
        AF.request(mRequest).responseJSON
        { response in
            
            print(response.response?.statusCode ?? "")
            
            switch response.result {
                
            case .success(let value):
                
                if let jsonDict = value as? NSDictionary {
                    
                    let data = try! JSONSerialization.data(withJSONObject: value as Any, options: .prettyPrinted)
                    let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    print("RESPONSE JSON:\n\(string as AnyObject)")
                    
                    completion(jsonDict,nil)
                } else if let jsonDict = value as? NSArray {
                    
                    let data = try! JSONSerialization.data(withJSONObject: value as Any, options: .prettyPrinted)
                    let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    print("RESPONSE JSON:\n\(string as AnyObject)")
                    
                    completion(jsonDict,nil)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                switch (response.error!._code) {
                case NSURLErrorTimedOut:
                    print(response.error ?? "0")
                    completion(["message":"Error occured"],error)
                    break
                case NSURLErrorNotConnectedToInternet:
                    completion(["message":"Please check internet connection"],error)
                    break
                default:
                    completion(["message":"Error occured"],error)
                }
            }
        }
    }
    
    func executeUploadCommonRequest( parameter:Data ,strFunName: String , completion: @escaping (_ success: Any? ,_ failresult: Error? ) -> Void)
    {
        let url = Globalvar.BaseURL.appending(strFunName)
        print("REQUEST URL:\n\(url)")
        let baseURl = URL(string: url)
        var mRequest = URLRequest(url:baseURl!)
        mRequest.httpMethod =  "POST"
   
        
        let headers = ["content-type": "application/json",
                       "cache-control": "no-cache"]
        
        mRequest.allHTTPHeaderFields = headers
      
        mRequest.httpBody = parameter
        
        AF.request(mRequest).responseJSON
        { response in
            
            switch response.result {
            case .success(let value):
                
//                URLSessionInstrumentation.enable(
//                    with: .init(
//                        delegateClass: SessionDelegate.self
//                    )
//                )
//                let session = URLSession(
//                    configuration: .default,
//                    delegate: SessionDelegate(),
//                    delegateQueue: nil
//                )
                
                if let jsonDict = value as? NSDictionary {
                    
                    let data = try! JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    print("RESPONSE JSON:\n\(string as AnyObject)")
                    
                    completion(jsonDict,nil)
                } else if let jsonDict = value as? NSArray {
                    
                    let data = try! JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    print("RESPONSE JSON:\n\(string as AnyObject)")
                    
                    completion(jsonDict,nil)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                switch (response.error!._code) {
                case NSURLErrorTimedOut:
                    print(response.error ?? "0")
                    completion(["message":"Error occured"],error)
                    break
                case NSURLErrorNotConnectedToInternet:
                    completion(["message":"Please check internet connection"],error)
                    break
                default:
                    completion(["message":"Error occured"],error)
                }
            }
        }
    }
    
}
