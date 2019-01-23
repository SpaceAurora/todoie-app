//
//  WelcomingViewController.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/20/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit

class WelcomingViewController: UIViewController {
    
    // ViewModel
    private let welcomingVM = WelcomingViewModel()
    private weak var coordinatorDelegate: CoordinatorDelegate?
    
    private let cellID = "welcoming-cells"
    private var dataArray: [PageViewModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.register(PageCell.self, forCellWithReuseIdentifier: cellID)
        return cv
    }()
    
    private lazy var pagingControl: UIPageControl = {
        let p = UIPageControl()
        p.translatesAutoresizingMaskIntoConstraints = false
        p.currentPage = 0
        p.pageIndicatorTintColor = .lightGray
        p.currentPageIndicatorTintColor = .blueTodoieColor
        return p
    }()
    
    private let nextButton = createButtons(title: "Next")
    private let skipButton = createButtons(title: "Skip")
    
    init(delegate: CoordinatorDelegate) {
        coordinatorDelegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButtons()
        setupObservers()
        welcomingVM.generatePages()
    }
    
    func setupObservers() {
        welcomingVM.currentPage.bind { [unowned self] (current) in
            // handles the change too the pageControl indicator
            self.pagingControl.currentPage = current ?? 0
        }
        welcomingVM.dataArray.bind { [unowned self] (pagesVM) in
            // sets the PagesViewModel array to the dataArray in the Controller
            self.dataArray = pagesVM ?? []
            self.pagingControl.numberOfPages = self.dataArray.count
        }
        welcomingVM.currentIndexPath.bind { [unowned self] (indexPath) in
            // Scrolls the collectionView in case the next button was pressed
            self.collectionView.scrollToItem(at: indexPath ?? IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        }
        welcomingVM.nextButtonText.bind { [unowned self] (args) in
            // Handles the way the nextButton reacts
            guard let (text, changeFunctionality) = args else { return }
            self.shouldChangeNextButtonFunctionality(text: text, change: changeFunctionality)
        }
    }
}

extension WelcomingViewController {
    
    // Next Button main function that handles the way the pages scrolls
    @objc func handleNext() {
        welcomingVM.handleNext(page: pagingControl.currentPage)
    }
    // Skip and Next Button function that handles the dismissal of the ViewController
    @objc func handleSkip() {
        coordinatorDelegate?.dismissFromMainView(controller: self)
    }
    
    // Handles the way the Next button reacts
    func shouldChangeNextButtonFunctionality(text: String, change: Bool) {
        nextButton.removeTarget(self, action: nil, for: .touchUpInside)
        nextButton.setTitle(text, for: .normal)
        if change {
            nextButton.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        } else {
            nextButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        }
    }
}

extension WelcomingViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PageCell
        cell.page = dataArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        // gets the next cell's frame to set the pageControl number
        welcomingVM.handleSwipeChange(withValue: Int(targetContentOffset.pointee.x / view.frame.width))
    }
}


extension WelcomingViewController {
    
    func setupUI() {
        
        view.backgroundColor = .white
        
        let buttonStack = UIStackView(arrangedSubviews: [skipButton, pagingControl, nextButton])
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.axis = .horizontal
        buttonStack.distribution = .equalCentering
        view.addSubview(buttonStack)
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: buttonStack.topAnchor),
            
            buttonStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            buttonStack.heightAnchor.constraint(equalToConstant: 44),
            
            nextButton.widthAnchor.constraint(equalToConstant: 50),
            skipButton.widthAnchor.constraint(equalToConstant: 50),
            ])
    }
    
    func setupButtons() {
        nextButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
    }
    
    static func createButtons(title: String) -> UIButton {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle(title, for: .normal)
        b.setTitleColor(.black, for: .normal)
        return b
    }
    
}
