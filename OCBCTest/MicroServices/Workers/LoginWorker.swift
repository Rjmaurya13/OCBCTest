//
//  Worker.swift
//  OCBCTest
//
//  Created by Rajesh on 26/3/22.
//
import Foundation

public class LoginWorker : LoginWorkerProtocol {
    public var delegate: LoginSuccessProtocol?
    
    // MARK: - Properties
    private let networkClient: NetworkClient
    
    public init(networkClient: NetworkClient = NetworkClient.shared) {
        self.networkClient = networkClient
    }
    
    public func callLoginApi(request: LoginRequest) {
        networkClient.requestObject(service: LoginService.login(requestPayload: request), httpMethod: "POST" , C: LoginResponse.self) { [weak self] (result, error) in
            if result != nil {
                if result?.status == "success" {
                    self?.delegate?.didSuccesLogin(response: result)
                } else {
                    self?.delegate?.didFailedLogin(error: error)
                }
            }
        }
    }
}
