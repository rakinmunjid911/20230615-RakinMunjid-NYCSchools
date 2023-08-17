//
//  DetailViewController.swift
//  20230615-RakinMunjid-NYCSchools
//
//  Created by Rakin Munjid on 8/17/23.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {

    // MARK: - Properties
    var viewModel: DetailViewModel = DetailViewModel() {
        didSet {
            updateUI()
        }
    }

    private lazy var scrollView = createScrollView()
    private lazy var contentView = createContentView()

    private lazy var nameOverviewStack: UIStackView = createStackView()
    private lazy var satDataStack: UIStackView = createStackView()

    lazy var schoolNameLabel = createLabel(textAlignment: .center)
    lazy var overviewLabel = createLabel(textAlignment: .left, fontSize: 14)

    lazy var satTestTakersLabel = createLabel()
    lazy var satCriticalReadingLabel = createLabel()
    lazy var satMathScoreLabel = createLabel()
    lazy var satWritingScoreLabel = createLabel()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        // Constraints for the scrollView to fill the entire view
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            // Constraints for the contentView to dictate the size of the scrollView's content
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),  // Ensures content view doesn't scroll horizontally
        ])

        nameOverviewStack.addArrangedSubview(schoolNameLabel)
        nameOverviewStack.addArrangedSubview(overviewLabel)

        // Add subviews to the satDataStack
        satDataStack.addArrangedSubview(satTestTakersLabel)
        satDataStack.addArrangedSubview(satCriticalReadingLabel)
        satDataStack.addArrangedSubview(satMathScoreLabel)
        satDataStack.addArrangedSubview(satWritingScoreLabel)

        // Add stack views to contentView
        contentView.addSubview(nameOverviewStack)
        contentView.addSubview(satDataStack)

        // Set up constraints for the stack views:
        NSLayoutConstraint.activate([
            nameOverviewStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameOverviewStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameOverviewStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            satDataStack.topAnchor.constraint(equalTo: nameOverviewStack.bottomAnchor, constant: 20),
            satDataStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            satDataStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            satDataStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])

        // Set up gradient background
               let gradientLayer = CAGradientLayer()
               gradientLayer.frame = view.bounds
               gradientLayer.colors = [UIColor.lightBlue.cgColor, UIColor.darkBlue.cgColor] // Adjust these colors as needed
               gradientLayer.locations = [0.0, 1.0] // Start and end points of gradient
               view.layer.insertSublayer(gradientLayer, at: 0)

        updateUI()
    }

    private func updateUI() {
        schoolNameLabel.text = viewModel.schoolName
        overviewLabel.text = viewModel.schoolOverview
        satTestTakersLabel.text = viewModel.testTakersText
        satCriticalReadingLabel.text = viewModel.criticalReadingText
        satMathScoreLabel.text = viewModel.mathScoreText
        satWritingScoreLabel.text = viewModel.writingScoreText
    }

    // MARK: - UI Helpers
    private func createScrollView() -> UIScrollView {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }

    private func createContentView() -> UIView {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }

    private func createStackView() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }

    private func createLabel(textAlignment: NSTextAlignment = .left, fontSize: CGFloat = 17) -> UILabel {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = textAlignment
        lbl.font = .systemFont(ofSize: fontSize)
        lbl.numberOfLines = 0
        return lbl
    }
}

extension UIColor {
    static let lightBlue = UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1.0)
    static let darkBlue = UIColor(red: 0/255, green: 0/255, blue: 139/255, alpha: 1.0)
}


