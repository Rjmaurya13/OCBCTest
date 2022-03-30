//
//  RegistrationWorker.swift
//  OCBCTest
//
//  Created by Rajesh on 27/3/22.
//

import Foundation

public class RegistrationWorker : RegistrationWorkerProtocol {
    private let networkClient: NetworkClient
    public var delegate: RegistrationSuccessProtocol?
    public init(networkClient: NetworkClient = NetworkClient.shared) {
        self.networkClient = networkClient
    }
    
    public func callRegistrationApi(request: RegistrationRequest) {        
        networkClient.requestObject(service: RegistrationServices.registration(requestPayload: request), httpMethod: "POST" , C: RegistrationResponse.self) { [weak self] (result, error) in
            if result != nil {
                self?.delegate?.didSuccesRegister(response: result)
            } else {
                self?.delegate?.didFailedRegister(erros: error)
            }
        }
    }
}
