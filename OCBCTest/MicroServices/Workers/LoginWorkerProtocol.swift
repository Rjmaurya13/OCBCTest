//
//  WorkerProtocol.swift
//  OCBCTest
//
//  Created by Rajesh on 26/3/22.
//

import Foundation

public protocol LoginWorkerProtocol: AnyObject {
    func callLoginApi(request: LoginRequest)
    var delegate: LoginSuccessProtocol? {get set}
}
public protocol LoginSuccessProtocol: AnyObject {
    func didSuccesLogin(response: LoginResponse?)
    func didFailedLogin(error: Error?)
}

