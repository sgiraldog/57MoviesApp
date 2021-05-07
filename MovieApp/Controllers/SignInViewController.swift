//
//  SignInViewController.swift
//  MovieApp
//
//  Created by Sebastián Giraldo Gómez on 6/05/21.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var authViewModel: AuthViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        localize()
        self.authViewModel = AuthViewModel()
    }
    
    func localize() {
        usernameTextField.placeholder = "username".localized
        passwordTextField.placeholder = "password".localized
        loginButton.setTitle("login".localized.uppercased(), for: .normal)
    }
    
    @IBAction func signInAction(_ sender: Any) {
        if validateInput() {
            let username = usernameTextField.text!
            let password = passwordTextField.text!
            
            let usernameStatus = self.authViewModel.saveDataOnKeychain(key: "username", data: username)
            let passwordStatus = self.authViewModel.saveDataOnKeychain(key: "password", data: password)
            let sessionStatus = self.authViewModel.saveDataOnKeychain(key: "isLoggedIn", data: true)
            
            if usernameStatus && passwordStatus && sessionStatus {
                self.performSegue(withIdentifier: "signInSegue", sender: self)
            } else {
                self.showAlert(title: "oops".localized, message: "errorFound".localized)
            }
        }
    }
    
    func validateInput() -> Bool{
        guard let username = usernameTextField.text, !username.isEmpty else {
            self.showAlert(title: "validation".localized, message: "typeValidUsername".localized)
            return false
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            self.showAlert(title: "validation".localized, message: "typeValidPassword".localized)
            return false
        }
        
        if let validationMessage = self.authViewModel.validateUser(username: username, password: password) {
            self.showAlert(title: "validation".localized, message: validationMessage)
            return false
        }
        return true
    }
    
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok".localized, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
