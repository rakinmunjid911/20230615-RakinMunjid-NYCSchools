//
//  ViewController.swift
//  20230615-RakinMunjid-NYCSchools
//
//  Created by Rakin Munjid on 8/15/23.
//

import UIKit

//class WelcomeViewController: UIViewController {
//
//    private let scrollView = UIScrollView()
//    private var headerStackView = UIStackView()
//    private let button = UIButton()
//    private let headerString = "New York City Schools"
//
//    private let headerLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textAlignment = .center
//        label.font = UIFont.italicSystemFont(ofSize: 32)
//        label.numberOfLines = 0  // Allows the label to wrap if the school name is long.
//        return label
//    }()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Setting up gradient
//                let gradientLayer = CAGradientLayer()
//                gradientLayer.colors = [UIColor.white.cgColor, UIColor.systemTeal.cgColor] // Gradient from white to light blue
//                gradientLayer.frame = view.bounds
//                view.layer.insertSublayer(gradientLayer, at: 0)
//        self.view.addSubview(scrollView)
//        scrollView.addSubview(headerStackView)
//        self.scrollView.backgroundColor = .clear
//        setupView()
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        headerStackView.translatesAutoresizingMaskIntoConstraints = false
//        view.addConstraints([
//            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            headerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            headerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
//                            ])
//        // Do any additional setup after loading the view.
//    }
//
//    private func setupView() {
//        headerStackView.axis = .vertical
//        headerStackView.alignment = .center
//        headerStackView.distribution = .fillEqually
//        headerStackView.spacing = view.safeAreaLayoutGuide.layoutFrame.height/2
//
//        headerLabel.text = headerString
//        headerLabel.textAlignment = .center
//        button.setTitle("See List", for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
//
//        // Apply shadow
//        button.layer.shadowColor = UIColor.black.cgColor
//        button.layer.shadowOffset = CGSize(width: 0, height: 2)
//        button.layer.shadowOpacity = 0.5
//        button.layer.shadowRadius = 10.0
//
//        // Rounding the corners
//        button.layer.cornerRadius = 10
//
//
//
//        button.addTarget(self, action: #selector(showRecordsTapped), for: .touchUpInside)
//        headerStackView.addArrangedSubview(headerLabel)
//        headerStackView.addArrangedSubview(button)
//    }
//
//
//    @objc func showRecordsTapped() {
//        let recordsVC = SchoolListViewController()
//        self.navigationController?.pushViewController(recordsVC, animated: true)
//        // If you aren't inside a UINavigationController or if you want to present it modally, use:
//        // present(recordsVC, animated: true, completion: nil)
//    }
//
//}

class WelcomeViewController: UIViewController {

    private let scrollView = UIScrollView()
    private var headerStackView = UIStackView()
    private let button = UIButton()
    private let headerLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
        setupScrollView()
        setupHeaderStackView()
        setupView()
    }

    private func setupGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.systemTeal.cgColor]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupHeaderStackView() {
        scrollView.addSubview(headerStackView)
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    private func setupView() {
        headerStackView.axis = .vertical
        headerStackView.alignment = .center
        headerStackView.distribution = .fillEqually
        headerStackView.spacing = view.safeAreaLayoutGuide.layoutFrame.height / 2

        setupHeaderLabel()
        setupButton()

        headerStackView.addArrangedSubview(headerLabel)
        headerStackView.addArrangedSubview(button)
    }

    private func setupHeaderLabel() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.text = "New York City Schools"
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.italicSystemFont(ofSize: 32)
        headerLabel.numberOfLines = 0
    }

    private func setupButton() {
        button.setTitle("See List", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.applyShadow()
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(showRecordsTapped), for: .touchUpInside)
    }

    @objc func showRecordsTapped() {
        let networkService = NetworkService()
        let schoolListViewModel = SchoolListViewModel(networkService: networkService)
        let recordsVC = SchoolListViewController(viewModel: schoolListViewModel)
        navigationController?.pushViewController(recordsVC, animated: true)
    }
}

extension CALayer {
    func applyShadow() {
        shadowColor = UIColor.black.cgColor
        shadowOffset = CGSize(width: 0, height: 2)
        shadowOpacity = 0.5
        shadowRadius = 10.0
    }
}


