//
//  RegistrationViewController.swift
//  OCBCTest
//
//  Created by Rajesh on 26/3/22.
//

import UIKit

class RegistrationViewController: UIViewController, RegistrationPresenterToViewProtocol {
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var psdTextView: UIView!
    @IBOutlet weak var psdCnfTextView: UIView!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    private var registrationRequestModel: RegistrationRequest?
    @IBOutlet weak var actView: UIActivityIndicatorView!
    var presenter: RegistrationPresenterProtocol?
    
    init() {
        super.init(nibName: String(describing: RegistrationViewController.self),
                   bundle: Bundle(for: RegistrationViewController.self))
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    func stopAnimating() {
        DispatchQueue.main.async {
            self.actView.stopAnimating()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        actView.stopAnimating()
    }
    func setUpUI() {
        registrationRequestModel = RegistrationRequest(userName: "", password: "")
        btnRegister.addTarget(self, action:#selector(onRegistrationButtonTap), for: .touchUpInside)
        btnBack.addTarget(self, action:#selector(onBackButtonClick), for: .touchUpInside)
        txtUserName.delegate = self
        txtPassword.delegate = self
        txtConfirmPassword.delegate = self
        txtPassword.isSecureTextEntry = true
        txtConfirmPassword.isSecureTextEntry = true
        txtUserName.addTarget(self, action: #selector(userNameValueChanged), for: .editingChanged)
        txtPassword.addTarget(self, action: #selector(passwordValueChanged), for: .editingChanged)
        userNameView.layer.cornerRadius = 4
        psdTextView.layer.cornerRadius = 4
        psdCnfTextView.layer.cornerRadius = 4
        txtUserName.setBottomBorderOnlyWith(color: UIColor.gray.cgColor)
        txtPassword.setBottomBorderOnlyWith(color: UIColor.gray.cgColor)
        btnRegister.layer.cornerRadius = 4
    }
    
    @objc func onRegistrationButtonTap() {
        if txtUserName.text?.isEmpty ?? true || txtUserName.text?.count ?? 0 <= 6 {
            txtUserName.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            self.showToast(message: "Username should be minimum 6 character", seconds: 4)
        } else if txtPassword.text?.isEmpty ?? true || txtPassword.text?.count ?? 0 <= 6 {
            txtPassword.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            self.showToast(message: "Password should be minimum 6 character", seconds: 4)
        } else if txtConfirmPassword.text?.isEmpty ?? true ||  (txtPassword?.text != txtConfirmPassword?.text) {
            self.showToast(message: "Password and Confirm password dosen't match.", seconds: 4)
        } else {
            OCBCHelper.shared.userName = txtUserName.text
            actView.startAnimating()
            guard let model = self.registrationRequestModel else { return }
            presenter?.getRegistration(request: model)
        }
    }
}
extension RegistrationViewController {
    
    @objc func userNameValueChanged() {
        self.registrationRequestModel?.userName = txtUserName.text ?? ""
    }
    @objc func passwordValueChanged() {
        self.registrationRequestModel?.password = txtPassword.text ?? ""
    }
    @objc func onBackButtonClick() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtUserName:
            return txtPassword.becomeFirstResponder()
        case txtPassword:
            return txtConfirmPassword.becomeFirstResponder()
        default:
            return txtConfirmPassword.resignFirstResponder()
        }
    }
}
