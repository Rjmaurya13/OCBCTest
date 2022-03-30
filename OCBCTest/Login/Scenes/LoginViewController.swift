//
//  LoginViewController.swift
//  OCBCTest
//
//  Created by Rajesh on 26/3/22.
//

import UIKit

class LoginViewController: UIViewController, LoginPresenterToViewProtocol {
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var actView: UIActivityIndicatorView!
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var psdTextView: UIView!
    @IBOutlet weak var btnRegister: UIButton!
    private var loginRequestModel: LoginRequest?
    var presenter: LoginPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        actView.stopAnimating()
        txtUserName.text = ""
        txtPassword.text = ""
    }
    func setUpUI() {
        loginRequestModel = LoginRequest(username: "", password: "")
        btnLogin.addTarget(self, action:#selector(onLoginButtonTap), for: .touchUpInside)
        btnRegister.addTarget(self, action:#selector(onRegisterTap), for: .touchUpInside)
        txtUserName.delegate = self
        txtPassword.delegate = self
        txtPassword.isSecureTextEntry = true
        txtUserName.addTarget(self, action: #selector(userNameValueChanged), for: .editingChanged)
        txtPassword.addTarget(self, action: #selector(passwordValueChanged), for: .editingChanged)
        userNameView.layer.cornerRadius = 4
        psdTextView.layer.cornerRadius = 4
        btnLogin.layer.cornerRadius = 4
        btnRegister.layer.cornerRadius = 4

        txtUserName.setBottomBorderOnlyWith(color: UIColor.gray.cgColor)
        txtPassword.setBottomBorderOnlyWith(color: UIColor.gray.cgColor)
    }
    init() {
        super.init(nibName: String(describing: LoginViewController.self),
                   bundle: Bundle(for: LoginViewController.self))
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    @objc private func onLoginButtonTap() {
        if txtUserName.text?.isEmpty ?? true || txtUserName.text?.count ?? 0 <= 6 {
            txtUserName.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            self.showToast(message: "Username should be minimum 6 character", seconds: 4)
        } else if txtPassword.text?.isEmpty ?? true {
            txtPassword.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            self.showToast(message: "Password should be minimum 6 character", seconds: 4)
        } else {
            actView.startAnimating()
            guard let model = self.loginRequestModel else { return }
            presenter?.getLogin(request: model)
        }
    }
    func stopAnimating() {
        DispatchQueue.main.async {
            self.actView.stopAnimating()
        }
    }
    @objc private  func userNameValueChanged() {
        self.loginRequestModel?.username = txtUserName.text ?? ""
    }
    @objc private func passwordValueChanged() {
        self.loginRequestModel?.password = txtPassword.text ?? ""
    }
    @objc func onRegisterTap() {
        presenter?.goToRegister()
    }
}

extension LoginViewController: UITextFieldDelegate {    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtUserName:
            guard let text = txtUserName.text else {return true}
            self.loginRequestModel?.username = text
            return txtPassword.becomeFirstResponder()
        case txtPassword:
            guard let text = txtPassword.text else {return true}
            self.loginRequestModel?.password = text
            return txtPassword.resignFirstResponder()
        default: break
        }
        return true
    }
}
