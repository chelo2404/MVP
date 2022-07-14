//
//  DetailsViewPresenter.swift
//  MVP
//
//  Created by Marcelo Fernandez on 13/07/2022.
//

import Foundation
import UIKit

protocol DetailsViewPresenterDelegate: AnyObject {
    func presentBandInformation(_ band: Band?)
}

typealias DetailsPresenterDelegate = DetailsViewPresenterDelegate & UIViewController

class DetailsViewPresenter {
    weak var delegate: DetailsPresenterDelegate?
    
    public func setDelegate(_ delegate: DetailsPresenterDelegate) {
        self.delegate = delegate
    }
    
    public func getBandInformation(_ bandId: Int) {
        BandRepository.getBandInfo(with: bandId) { [weak self] band in
            self?.delegate?.presentBandInformation(band)
        }
    }
}
