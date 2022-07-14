//
//  HomeViewPresenter.swift
//  MVP
//
//  Created by Marcelo Fernandez on 12/07/2022.
//

import Foundation
import UIKit

protocol HomeViewPresenterDelegate: AnyObject {
    func present(bands: [Band])
}

typealias HomePresenterDelegate = HomeViewPresenterDelegate & UIViewController

class HomeViewPresenter {
    weak var delegate: HomePresenterDelegate?
    
    public func setDelegate(_ delegate: HomePresenterDelegate) {
        self.delegate = delegate
    }
    
    func getBands() {
        BandRepository.getBands { [weak self] response in
            switch(response) {
            case .success(bands: let bands):
                self?.delegate?.present(bands: bands)
            case .error(message: let message):
                self?.delegate?.present(bands: [Band(name: message, logo: nil, image: nil, info: nil, genre: nil)])
            }
        }
    }
}
