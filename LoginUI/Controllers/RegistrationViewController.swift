//
//  RegistrationViewController.swift
//  LoginUI
//
//  Created by Rahul's MAC on 10/03/34.
//

import UIKit
import Alamofire
import FMDB

struct Student {
    var id: Int
    var name: String
    var branch: String
}

class RegistrationViewController: UIViewController {

    @IBOutlet weak var enterUserName: UITextField!
    
    @IBOutlet weak var enterEmailId: UITextField!
    
    @IBOutlet weak var enterPassword: UITextField!
    
    @IBOutlet weak var enterConfirmPassword: UITextField!
    
    @IBOutlet weak var enterDateOfBirth: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    var arrGenders: [String] = ["Male", "Female", "Other"]

    var arrStudents: [Student] = [Student(id: 1, name: "Rahul", branch: "rnw1"),
                                  Student(id: 2, name: "Rakshil", branch: "rnw2"),
                                  Student(id: 3, name: "Ayush", branch: "rnw3"),
                                  Student(id: 4, name: "Topi", branch: "rnw5"),
                                  Student(id: 5, name: "Ravi", branch: "rnw4")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
        // Do any additional setup after loading the view.
    }
    
    private func setUp()
    {
        [enterUserName,enterEmailId,enterPassword,enterConfirmPassword,enterDateOfBirth ,signInButton,loginButton].forEach
        {
            setCornerRadius(view: $0, cornerRadius: 10)
        }
        
        enterUserName.delegate = self
        enterEmailId.delegate = self
        enterPassword.delegate = self
//        enterConfirmPassword.becomeFirstResponder()
//        enterDateOfBirth.isSecureTextEntry = true
//        print(enterUserName.tag)
//        print(enterEmailId.tag)
//        print(enterPassword.tag)
//        print(enterConfirmPassword.tag)
//        print(enterDateOfBirth.tag)
        
        
        
//        genderPickerView.delegate = self
//        genderPickerView.dataSource = self
    }
    
    
    
    func setCornerRadius(view: UIView?, cornerRadius: CGFloat)
    {
        view?.layer.cornerRadius = cornerRadius
        view?.layer.masksToBounds = true
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton)
    {
        
//        if enterUserName.text == " " || enterEmailId.text == " " || enterPassword.text == " " || enterConfirmPassword.text == " "
//        {
//            displayAlert(message: "Enter valid information")
//        }
//        else if enterPassword.text?.count ?? 0 < 8 || enterConfirmPassword.text?.count ?? 0 < 8
//        {
//            displayAlert(message: "Enter valid information")
//        }
        
        if enterUserName.text == ""{
            displayAlert(message: "Enter userName")
        }else if enterEmailId.text == ""{
            displayAlert(message: "Enter Email")
        }else if enterPassword.text == ""{
            displayAlert(message: "Enter password")
        }else if enterConfirmPassword.text?.count ?? 0 < 8{
            displayAlert(message: "Enter valid password")
        }
        
        
        
//        if phonenumberOrEmailTextField.text == ""
//        {
//            displayActionsheet(message: "Please enter Your phone number or email")
//        } else if fullnameTextField.text == ""
//        {
//            displayActionsheet(message: "Please enter Your full name")
//        } else if passwordTextField.text == ""
//        {
//            displayActionsheet(message: "Please enter your Password")
//        } else if confirmPasswordTextField.text == ""
//        {
//            displayActionsheet(message: "Please enter your password")
//        } else if passwordTextField.text?.count ?? 0 <= 8
//        {
//            displayActionsheet(message: "Enter password of more than 8 characters")
//        } else if confirmPasswordTextField.text?.count ?? 0 <= 8
//        {
//            displayActionsheet(message: "Enter password of more than 8 characters")
//        } else if confirmPasswordTextField.text != passwordTextField.text
//        {
//            displayActionsheet(message: "Both password must be same")
//        }
        
//        With Database
        
        
        if enterEmailId.text?.count == 0 || enterUserName.text?.count == 0 || enterPassword.text?.count == 0 || enterConfirmPassword.text?.count == 0 {
            displayAlert(message: "Please Enter Someting")
            return
        }
        let query = "insert into registration(phoneNo, fullName, password, confirmPassword) values ('\(enterEmailId.text ?? "")','\(enterUserName.text ?? "")','\(enterPassword.text ?? "")','\(enterConfirmPassword.text ?? "")');"
        print(query)
        let databaseObject = FMDatabase(path: AppDelegate.databasePath)
        if databaseObject.open() {
            let result = databaseObject.executeUpdate(query, withArgumentsIn: [])
            if result == true {
                enterEmailId.text = ""
                enterUserName.text = ""
                enterPassword.text = ""
                enterConfirmPassword.text = ""
            } else {
                displayAlert(message: "Something Went Wrong")
                enterEmailId.text = ""
                enterUserName.text = ""
                enterPassword.text = ""
                enterConfirmPassword.text = ""
            }
        }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let apiCallingViewController: APICallingViewController = storyBoard.instantiateViewController(withIdentifier: "APICallingViewController") as! APICallingViewController
        navigationController?.pushViewController(apiCallingViewController, animated: true)
        

        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
            super.touchesBegan(touches, with: event)
            view.endEditing(true)
        }
        
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.layer.masksToBounds = true
    }
}

extension RegistrationViewController: UITextFieldDelegate
{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        switch textField.tag
        {
        case 0: return true
        case 1: return true
        case 2: return true
        case 3: return true
        case 4:
            view.endEditing(true)
            if textField.tag == 4 {
//                genderPickerView.isHidden = false
            }
            return false
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
//            enterPassword.becomeFirstResponder()
//        }
        print(textField.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 0{
            if string == "!"{
                return false
            }else{
                return true
            }
        }else if textField.tag == 2{
            if string.contains("/"){
                return false
            }else{
                return true
            }
        }
        return true
    }
    
    

    
    @IBAction func loginButtonTapped(_ sender: UIButton)
    {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
}


extension RegistrationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrStudents.count //arrGenders.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print(row)
        return arrStudents[row].name//arrGenders[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //print("Selected option \(arrGenders[row])")
//        genderTextField.text = arrStudents[row].name//arrGenders[row]
//        genderPickerView.isHidden = true
    }
    
}
    
//struct Registration: Decodable {
//    var email: String
//    var password: String
//}


