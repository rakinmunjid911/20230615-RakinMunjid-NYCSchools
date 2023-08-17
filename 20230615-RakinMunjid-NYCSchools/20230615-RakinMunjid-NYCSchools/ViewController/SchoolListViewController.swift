//
//  SchoolListViewController.swift
//  20230615-RakinMunjid-NYCSchools
//
//  Created by Rakin Munjid on 8/16/23.
//

import Foundation
import UIKit



class SchoolListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tableView = UITableView()
    let viewModel: SchoolListViewModel
    let networkService: NetworkServiceType

    // Loading indicator
    let activityIndicator = UIActivityIndicatorView(style: .large)

    // Dependency Injection in the initializer
       init(viewModel: SchoolListViewModel, networkService: NetworkServiceType = NetworkService()) {
           self.viewModel = viewModel
           self.networkService = networkService
           super.init(nibName: nil, bundle: nil)
       }

       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }


    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchRecords()
        setupActivityIndicator()
        setupFilterButton()
        setupGradientBackgroundForTableView()
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = self.view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }

        func fetchRecords() {
            activityIndicator.startAnimating()
            viewModel.fetchRecords { [weak self] (records, error) in
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.tableView.reloadData()
                }
            }
        }

    func setupActivityIndicator() {
           activityIndicator.center = view.center
           activityIndicator.hidesWhenStopped = true
           view.addSubview(activityIndicator)
       }

    func setupFilterButton() {
        let buttonTitle = "Filter"
        let filterButton = UIBarButtonItem(title: buttonTitle, style: .plain, target: self, action: #selector(filterTapped))
        self.navigationItem.rightBarButtonItem = filterButton
    }

    @objc func filterTapped() {

        let alertController = UIAlertController(title: "Filter Options", message: "Choose a filter", preferredStyle: .actionSheet)

        let alphabeticalAction = UIAlertAction(title: "Sort Alphabetically", style: .default) { [weak self] _ in
            self?.filterAlphabetically()
        }

        let boroughFilterAction = UIAlertAction(title: "Filter by Borough", style: .default) { [weak self] _ in
            self?.filterByBorough()
            }

        let clearFilterAction = UIAlertAction(title: "Clear Filters", style: .default) { [weak self] _ in
            self?.viewModel.clearFilter()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alertController.addAction(boroughFilterAction)
        alertController.addAction(alphabeticalAction)
        alertController.addAction(clearFilterAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
    }

    func filterAlphabetically() {
        viewModel.filterAlphabetically()
        tableView.reloadData()
    }

    func applyBoroughFilter(borough: String) {
        viewModel.applyBoroughFilter(borough: borough)
        tableView.reloadData()
    }

    // Clears the filter
    func clearFilter() {
        viewModel.clearFilter()
        tableView.reloadData()
    }

    func filterByBorough() {
        let alertController = UIAlertController(title: "Enter Borough", message: "Filter schools based on borough", preferredStyle: .alert)

        alertController.addTextField { (textField) in
            textField.placeholder = "Borough Name"
        }

        let filterAction = UIAlertAction(title: "Filter", style: .default) { [weak self, weak alertController] _ in
            if let borough = alertController?.textFields?.first?.text {
                self?.applyBoroughFilter(borough: borough)
            }
        }
        alertController.addAction(filterAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
    }

    private func setupGradientBackgroundForTableView() {
          let gradientLayer = CAGradientLayer()
          gradientLayer.colors = [UIColor.white.cgColor, UIColor.gray.cgColor]
          gradientLayer.locations = [0.0, 1.0]

          // Use the table view's bounds as the frame for the gradient layer.
          // This ensures the gradient covers the entire table view.
          gradientLayer.frame = tableView.bounds

          let backgroundView = UIView(frame: tableView.bounds)
          backgroundView.layer.insertSublayer(gradientLayer, at: 0)
          tableView.backgroundView = backgroundView
      }


    // MARK: - UITableViewDataSource methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.records.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let record = viewModel.records[indexPath.row]
        cell.textLabel?.text = record.name ?? "Unknown"
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = UIColor.clear

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        networkService.fetchSchoolData { result in
                switch result {
                case .success(let schools):
                    if let schoolData = schools.first(where: { $0.dbn == self.viewModel.records[indexPath.row].dbn }) {
                        DispatchQueue.main.async {
                            let detailVC = DetailViewController()
                            detailVC.viewModel.schoolData = self.viewModel.records[indexPath.row]
                            detailVC.viewModel.satData = schoolData

                            self.navigationController?.pushViewController(detailVC, animated: true)
                        }
                    } else {
                        DispatchQueue.main.async {
                                            self.showAlert(title: "Error", message: "No matching school data found.")
                                        }
                    }
                case .failure(let error):
                    print("Error fetching data: \(error.localizedDescription)")
                }
            }

            tableView.deselectRow(at: indexPath, animated: true)

    }

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }


    @objc func arrowButtonTapped(_ sender: UIButton) {
        // Handle button tap
        print("Arrow button tapped!")
    }
}

