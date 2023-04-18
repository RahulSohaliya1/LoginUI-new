//
//  ViewController.swift
//  LoginUI
//
//  Created by Rahul's MAC on 05/03/34.
//

import UIKit
import Alamofire
import FMDB

class LoginViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var enterEmailId: UITextField!
    @IBOutlet weak var enterPassword: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    @IBOutlet weak var facebookLoginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

    var arrUsers: [User] = []


    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUp()
//    loginAPI()
        


    }

    private func setUp()
    {
        [enterEmailId, enterPassword, loginButton, forgetPasswordButton, facebookLoginButton, signUpButton].forEach
        {
            setCornerRadius(view: $0, cornerRadius: 10)
        }

        enterEmailId.delegate = self
        enterPassword.delegate = self
        enterEmailId.becomeFirstResponder()
        enterPassword.isSecureTextEntry = true
        print(enterEmailId.tag)
        print(enterPassword.tag)

    }


    func setCornerRadius(view: UIView?, cornerRadius: CGFloat)
    {
        view?.layer.cornerRadius = cornerRadius
        view?.layer.masksToBounds = true
    }

    //    func setBorder(view: UIView?, color: UIColor, width: CGFloat)
    //    {
    //        view?.layer.borderColor = color.cgColor
    //        view?.layer.borderWidth = width
    //    }

    @IBAction func loginButtonTapped(_ sender: UIButton)
    {
//        if enterEmailId.text == " " || enterPassword.text == " "
//        {
//            displayAlert(message: "enter email and password")
//        }
//        else if enterEmailId.text?.count ?? 0 < 4 || enterPassword.text?.count ?? 0 < 8
//        {
//            displayAlert(message: "Enter Valid Email id and Password ")
//        }
        
        
//        if enterEmailId.text == "" {
//            displayAlert(message: "Enter Email")
//        } else if enterPassword.text == "" {
//            displayAlert(message: "Enter password")
//        }
        
        
        
        if enterEmailId.text == ""{
            displayAlert(message: "Please enter Your email")
        }else if enterPassword.text == ""{
            displayAlert(message: "Please enter Your password")
        }else if enterEmailId.text?.count ?? 0 <= 10{
            displayAlert(message: "Please enter Your Password")
        } else if enterPassword.text?.count ?? 0 <= 8{
            displayAlert(message: "Enter password of more than 8 characters")
        }
        
        
        
        //        With Database
                
                
                if enterEmailId.text?.count == 0 && enterPassword.text?.count == 0 {
                            displayAlert(message: "Please Enter Someting")
                            return
                        }
                        let query = "select * from registration;"
                        print(query)
                        let databaseObject = FMDatabase(path: AppDelegate.databasePath)
                        if databaseObject.open() {
                            let result = databaseObject.executeQuery(query, withArgumentsIn: [])
                            print(result as Any)
                            arrUsers = []
                            while result!.next() == true{
                                let phoneNo = result?.string(forColumn: "phoneNo")
                                let password = result?.string(forColumn: "password")
                                let user = User(phoneNo: phoneNo ?? "", password: password ?? "")
                                arrUsers.append(user)
                            }
                            print(arrUsers)
                            
                            if arrUsers.count > 0 {
                                
                            } else {
                                
                                displayAlert(message: "Please try agian")
                            }
                          
                        }
                
                
//                if enterEmailId.text?.count == 0 || enterPassword.text?.count == 0 {
//                    displayAlert(message: "Please Enter Someting")
//                    return
//                }
//                let query = "insert into user (name, password) values ('\(enterEmailId.text ?? "")','\(enterPassword.text ?? "")');"
//                print(query)
//                let databaseObject = FMDatabase(path: AppDelegate.databasePath)
//                if databaseObject.open() {
//                    let result = databaseObject.executeUpdate(query, withArgumentsIn: [])
//                    if result == true {
//                        enterEmailId.text = ""
//                        enterPassword.text = ""
//                    } else {
//                        displayAlert(message: "Something Went Wrong")
//                        enterEmailId.text = ""
//                        enterPassword.text = ""
//                    }
//                }
        

        

        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let APICallingViewController: APICallingViewController = storyBoard.instantiateViewController(withIdentifier: "APICallingViewController") as! APICallingViewController
        navigationController?.pushViewController(APICallingViewController, animated: true)

    }

    func displayAlert(message: String)
    {
        let alert: UIAlertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okButton: UIAlertAction = UIAlertAction(title: "ok", style: .default) { button in
            print("oky Button tapped")

        }
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesBegan(touches, with: event)
        view.layer.masksToBounds = true
    }

}
    extension LoginViewController: UITextViewDelegate
{
        
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
        {
            switch textField.tag
            {
            case 0: return true
            case 1: return true
            default: return true
            }
            
            //        switch textField.tag{
            //            case 1: return false
            //            default: return true
            //    }
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            print(textField.tag)
        }
        
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            return true
        }
        
        func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
            //        if textField.tag == 0 {
            //            passwordTectField.becomeFirstResponder()
            //        }
            print(textField.text ?? "")
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
        {
            if textField.tag == 0
            {
                if string == "<"
                {
                    return false
                }
                else
                {
                    return true
                }
            }
            else if textField.tag == 1
            {
                if string.contains("/")
                {
                    return false
                }
                else
                {
                    return true
                }
            }
            return true
        }
        
        
        
        @IBAction func forgotPasswordButtonTapped(_ sender: UIButton)
        {
            let storyBoard2: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let ForgetPasswordViewController: ForgetPasswordViewController = storyBoard2.instantiateViewController(withIdentifier: "ForgetPasswordViewController") as! ForgetPasswordViewController
            navigationController?.pushViewController(ForgetPasswordViewController, animated: true)
        }
        
        @IBAction func facebookLoginButtonTapped(_ sender: UIButton)
        {
            let storyBoard2: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let FacebookLoginViewController: FacebookLoginViewController = storyBoard2.instantiateViewController(withIdentifier: "FacebookLoginViewController") as! FacebookLoginViewController
            navigationController?.pushViewController(FacebookLoginViewController, animated: true)
        }
        
        @IBAction func signUpButtonTapped(_ sender: UIButton)
        {
            
            let storyBoard1: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let RegistrationViewController: RegistrationViewController = storyBoard1.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
            navigationController?.pushViewController(RegistrationViewController, animated: true)
        }
        
        struct User {
            var phoneNo: String
            var password: String
        }
        
    }
