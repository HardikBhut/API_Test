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
        
        self.register(strEmail: "hardikbhut.1986@gmail.com", strPassword: "abc@1234") // for register
        self.login(strEmail: "hardikbhut.1986@gmail.com", strPassword: "abc@1234") // for login
        self.getData() // for inspection data
        self.sbumitInspection() // for submit data
        
    }
    
    func register(strEmail: String, strPassword : String) {
       
        let inputJson = ["email": strEmail,
                         "password": strPassword]
     
        RestAPI.sharedInstance.executeCommonRequest(parameter: inputJson, strFunName: "register")
        { result, error in
            
            if error == nil {
                
                let responce = result as! NSDictionary
                print(responce)
               
            } else {
               
                print(error?.localizedDescription ?? "")
            
            }
        }
    }
    
    func login(strEmail: String, strPassword : String) {
        
        let inputJson = ["email": strEmail,
                         "password": strPassword]
     
        RestAPI.sharedInstance.executeCommonRequest(parameter: inputJson, strFunName: "login")
        { result, error in
            
            if error == nil {

                let responce = result as! NSDictionary
                print(responce)
            
               
            } else {
                
                print(error?.localizedDescription ?? "")
               
            }
        }
    }
    
    func getData()
    {
        RestAPI.sharedInstance.executerGetCommonRequest(strFunName: "inspections/start")
        { result, error in
            
            if error == nil {
                
                // self.removeHUD()
                let responce = result as! NSDictionary
                //let keyExists = responce["isSuccessfull"] != nil
                print(responce)
                
            } else {
                
                print(error?.localizedDescription ?? "")
                
            }
        }
    }
    
    func sbumitInspection()
    {
        let tampArray = NSMutableArray()
        
        let inputJsonAnswer = ["questions": "Is the drugs trolley locked?",
                                   "answer": "No",
                                   ]
        
        tampArray.add(inputJsonAnswer)
        
        
        let inputJson = ["inspectionId": "13",
                         "inspectionType": "Clinical",
                         "survy" : tampArray] as [String : Any]
       
        
        print(inputJson)
     
        RestAPI.sharedInstance.executeCommonRequest(parameter: inputJson, strFunName: "inspections/submit")
        { result, error in
            
            if error == nil {
                
                let responce = result as! NSDictionary
                print(responce)
               
            } else {
               
                print(error?.localizedDescription ?? "")
            
            }
        }
    }
    
  
}



