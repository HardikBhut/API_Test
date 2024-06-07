//
//  ViewController.swift
//  Test
//
//  Created by Hardik Bhut on 03/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
        registration(stremail: "test@gmail.com", strpassword: "test@1234")
        login(stremail: "test@gmail.com", strpassword: "test@1234")
        GetData()
        SubmitAPI()
        

        
    
    }
    
    func registration(stremail : String , strpassword : String) {
        
        let callurl = Globalvar.BaseURL.appending("register")
        guard let url = URL(string: callurl) else {
            print("Invalid URL")
            return
        }
        
        let loginRequest  = LoginRequest(email: stremail, password: strpassword)
        
        // Send the request
        URLSessionManager.shared.sendRequest(url: url, method: "POST", body: loginRequest) { result in
            switch result {
            case .success(let data):
                do {
                    if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                        print("Response JSON: \(jsonResponse)")
                    } else {
                        print("Response Data: \(String(data: data, encoding: .utf8) ?? "Invalid response data")")
                    }
                } catch {
                    print("Failed to handle response: \(error)")
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }
    
    func login(stremail : String , strpassword : String) {
        
        let callurl = Globalvar.BaseURL.appending("login")
        guard let url = URL(string: callurl) else {
            print("Invalid URL")
            return
        }
        
        let loginRequest  = LoginRequest(email: stremail, password: strpassword)
        
        // Send the request
        URLSessionManager.shared.sendRequest(url: url, method: "POST", body: loginRequest) { result in
            switch result {
            case .success(let data):
                do {
                    if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                        print("Response JSON: \(jsonResponse)")
                    } else {
                        print("Response Data: \(String(data: data, encoding: .utf8) ?? "Invalid response data")")
                    }
                } catch {
                    print("Failed to handle response: \(error)")
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }
    
    func GetData() {
        
        let callurl = Globalvar.BaseURL.appending("inspections/start")
        
        guard let url = URL(string: callurl) else {
            print("Invalid URL")
            return
        }
        
        // Send the request
        URLSessionManager.shared.sendRequest(url: url, method: "GET") { result in
            switch result {
            case .success(let data):
                do {
                    if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                        print("Response JSON: \(jsonResponse)")
                    } else {
                        print("Response Data: \(String(data: data, encoding: .utf8) ?? "Invalid response data")")
                    }
                } catch {
                    print("Failed to handle response: \(error)")
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }
    
    func SubmitAPI() {
        
        let callurl = Globalvar.BaseURL.appending("inspections/submit")
        
        guard let url = URL(string: callurl) else {
            print("Invalid URL")
            return
        }
        
        // Create the answer choices
        let answerChoice1 = AnswerChoiceModel(id: 1, text: "Yes")
        let answerChoice2 = AnswerChoiceModel(id: 2, text: "No")
        let answerChoices = [answerChoice1, answerChoice2]
        
        // Create the inspection object
        let inspection = Inspection(id: 1, name: "Is the drugs trolley locked?", answerChoices: answerChoices, selectedAnswerChoiceId: 1)
        let submitRequest = InspectionSubmitRequest(inspection: inspection)
        
        // Print the JSON to debug
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(submitRequest)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("JSON to be sent: \(jsonString)")
            }
        } catch {
            print("Failed to encode request: \(error)")
            return
        }
        
        // Send the request
        URLSessionManager.shared.sendRequest(url: url, method: "POST", body: submitRequest) { result in
            switch result {
            case .success(let data):
                do {
                    if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                        print("Response JSON: \(jsonResponse)")
                    } else {
                        print("Response Data: \(String(data: data, encoding: .utf8) ?? "Invalid response data")")
                    }
                } catch {
                    print("Failed to handle response: \(error)")
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    

    
  
}
    
  



