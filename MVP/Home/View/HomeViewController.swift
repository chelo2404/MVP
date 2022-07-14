//
//  ViewController.swift
//  MVP
//
//  Created by Marcelo Fernandez on 12/07/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let activityIndicator = UIActivityIndicatorView()
    let homeViewPresenter = HomeViewPresenter()
    var bands: [Band] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "Home"
        
        configureActivityIndicator()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "BandCell", bundle: nil), forCellReuseIdentifier: BandCell.identifier)
        
        homeViewPresenter.setDelegate(self)
        homeViewPresenter.getBands()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setConstraints()
    }
}

// Configure UI
extension HomeViewController {
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
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailsViewController = UIStoryboard(name: "DetailsViewController", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        detailsViewController.bandId = indexPath.row
        detailsViewController.modalPresentationStyle = .fullScreen
        
        if let navController = self.navigationController {
            navController.pushViewController(detailsViewController, animated: true)
        } else {
            self.present(detailsViewController, animated: true , completion: nil)
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bands.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BandCell.identifier, for: indexPath) as! BandCell
        cell.configureCellWith(model: bands[indexPath.row])
        return cell
    }
}

extension HomeViewController: HomeViewPresenterDelegate {
    func present(bands: [Band]) {
        self.bands = bands
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.activityIndicator.stopAnimating()
        }
    }
}
