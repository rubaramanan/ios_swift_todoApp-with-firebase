//
//  login.swift
//  catwalk
//
//  Created by student on 2/21/19.
//  Copyright © 2019 Kryptonite. All rights reserved.
//

import UIKit
import Firebase

class login: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var log: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        log.layer.cornerRadius=12
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: Any) {
        let temail=email.text
        let tpass=password.text
        let emi=isValidEmailAddress(emailAddressString: temail!)
        
        if(!(temail?.isEmpty)! && !(tpass?.isEmpty)!){
            if(emi==true){
                Auth.auth().signIn(withEmail: temail!, password: tpass!, completion: {(user,error)in
                    if error != nil {
                        self.alertView(message:(error?.localizedDescription)!)
                       
                        
                    }else{
                        
                        self.alertView(message: "login success")
                        
                        let homepage=self.storyboard?.instantiateViewController(withIdentifier: "homepage") as! Homepage
                        self.navigationController?.pushViewController(homepage, animated: true)
                    }
                })
            }else{
                alertView(message: "Please enter valid email")
            }
        }else{
            alertView(message: "please must fill all field")
        }
        
        
        
    }
    
    
    @IBAction func forgotpass(_ sender: Any) {
    }
    //this function for regular expression of email
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    //this function for alert message
    func alertView(message:String){
        let alert = UIAlertController(title: "Hi User", message:message ,preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            
        }
        
        alert.addAction(OKAction)
        
        self.present(alert, animated: true, completion:nil)
    }
    
}
