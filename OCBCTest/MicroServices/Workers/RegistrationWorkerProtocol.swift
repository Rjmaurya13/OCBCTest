//
//  RegistrationWorkerProtocol.swift
//  OCBCTest
//
//  Created by Rajesh on 27/3/22.
//

import Foundation

public protocol RegistrationWorkerProtocol: AnyObject {
    func callRegistrationApi(request: RegistrationRequest)
    var delegate: RegistrationSuccessProtocol? {get set}
}

public protocol RegistrationSuccessProtocol {
    func didSuccesRegister(response: RegistrationResponse?)
    func didFailedRegister(erros: Error?)
}
