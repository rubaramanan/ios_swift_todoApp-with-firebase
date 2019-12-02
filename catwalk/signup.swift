//
//  signup.swift
//  catwalk
//
//  Created by student on 2/21/19.
//  Copyright © 2019 Kryptonite. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import DLRadioButton

class signup: UIViewController,UITextFieldDelegate{

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var cpass: UITextField!
    @IBOutlet weak var sign: UIButton!
    @IBOutlet weak var male: DLRadioButton!
    @IBOutlet weak var Female: DLRadioButton!
    var gender : String!
    var db: Firestore!
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.sign.layer.cornerRadius=12
        age.delegate=self   //delegate use pannum textfield
        db=Firestore.firestore()
        // Do any additional setup after loading the view.
    }

    @IBAction func isMale(_ sender: DLRadioButton) {
        if male.tag==0{
            gender="male"
        }
    }
    @IBAction func isFemale(_ sender: DLRadioButton) {
        if Female.tag==0{
            gender="female"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func create_click(_ sender: Any) {
        
        let temail=email.text
        let tfname=fname.text
        let tage=age.text
        let tgender=gender
        let tpass=pass.text
        let tcpass=cpass.text
        let emi=isValidEmailAddress(emailAddressString: temail!)
        let pssi=isPasswordValid(tpass!)
        let nString = tpass! as NSString
        
        
        
        if(!(temail?.isEmpty)! && !(tfname?.isEmpty)! && !(tpass?.isEmpty)! && !(tcpass?.isEmpty)! && (tgender != nil)){
            if(emi==true){
                if(nString.length>=8){
                    if(pssi==true){
                        
                        Auth.auth().createUser(withEmail: temail!, password: tpass!, completion: {(user,error)in
                            if error==nil{
                                Auth.auth().currentUser?.sendEmailVerification(completion: {(error)in
                                  // self.alertView(message: "successfully signup please check email")
                                    print("successfully signup please check email")
                                    let ref=self.db.collection("user").document(temail!).setData([
                                        "Username": tfname,
                                        "age": tage,
                                        "gender":tgender
                                    ]){err in
                                        if err==nil{
                                            self.alertView(message: "save")
                                        }else{
                                            print(err?.localizedDescription)
                                        }
                                    }
                                    
                        })
                                
                            }else{
                                self.alertView(message:(error?.localizedDescription)!)
                                
                            }
                        })
                    }else{
                        alertView(message: "please enter same password")
                    }
                }else{
                    alertView(message: "please enter Strong oassword")
                }
                
            }else{
                alertView(message: "please enter valid email")
            }
            
        }else{
            alertView(message: "you must fill all field")
        }
        
        
        
        
    }
    
   // this function for email syntax validation
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
    
    // this function for alert message
    func alertView(message:String){
    let alert = UIAlertController(title: "Hi User", message:message ,preferredStyle: .alert)
    
    let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in

        
    }
    
    alert.addAction(OKAction)
    
    self.present(alert, animated: true, completion:nil)
    }
    
    
    //this function for both passwords are match
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    // this one use delegate for age only integer
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        let allowchar=CharacterSet.decimalDigits
       // let allowCharset=CharacterSet(charactersIn: allowchar)
        let typecharset=CharacterSet(charactersIn: string)
        return allowchar.isSuperset(of: typecharset)
        
    }
 
    }
    

