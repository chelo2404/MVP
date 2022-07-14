//
//  DetailsViewController.swift
//  MVP
//
//  Created by Marcelo Fernandez on 13/07/2022.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController, DetailsViewPresenterDelegate {
    
    var bandId = 0
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bandName: UILabel!
    @IBOutlet weak var bandThumbnail: UIImageView!
    @IBOutlet weak var bandGenre: UILabel!
    @IBOutlet weak var bandInformation: UILabel!
    
    let activityIndicator = UIActivityIndicatorView()
    let detailsViewPresenter = DetailsViewPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "Information"
        setDefaultValues()
        configureActivityIndicator()
        detailsViewPresenter.setDelegate(self)
        detailsViewPresenter.getBandInformation(bandId)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setConstraints()
    }
    
    private func setDefaultValues() {
        self.bandName.text = ""
        self.bandGenre.text = ""
        self.bandInformation.text = ""
    }
    
    private func configureActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .black
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func setConstraints() {
        let constraints = [
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 40),
            activityIndicator.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func presentBandInformation(_ band: Band?) {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.bandName.text = band?.name
            self?.bandThumbnail.load(url: band?.image)
            self?.bandGenre.text = band?.genre?.rawValue
            self?.bandInformation.text = band?.info
            self?.scrollView.resizeScrollViewContentSize()
        }
    }
}
