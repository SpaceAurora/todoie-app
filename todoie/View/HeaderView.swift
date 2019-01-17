//
//  HeaderView.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/14/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit
import SDWebImage

class HeaderView: UIView {
    
    // vars
    private weak var delegate: HeaderViewProtocol?
    
    // UIComponents
    private var path: UIBezierPath!
    private let shapeLayer = CAShapeLayer()
    private let line: LineView = LineView()
    
    private let backgroundImage: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "b3"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var profileImage: ProfileImageButton = {
        let b = ProfileImageButton(type: .system)
        b.setupButton()
        b.setImage(#imageLiteral(resourceName: "UserDefault").withRenderingMode(.alwaysOriginal), for: .normal)
        b.addTarget(self, action: #selector(handleOpeningProfile), for: .touchUpInside)
        return b
    }()
    
    private let addButton: HeaderButtons = {
        let b = HeaderButtons(type: .system)
        b.setupButton()
        b.setImage(#imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), for: .normal)
        return b
    }()
    
    private let searchButton: HeaderButtons = {
        let b = HeaderButtons(type: .system)
        b.setupButton()
        b.setImage(#imageLiteral(resourceName: "search").withRenderingMode(.alwaysOriginal), for: .normal)
        return b
    }()
    
    private lazy var buttonStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [searchButton, addButton])
        s.axis = .horizontal
        s.spacing = 10
        s.distribution = .fillEqually
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    private let myTasksLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "My Tasks"
        l.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        l.textColor = .black
        l.minimumScaleFactor = 0.7
        l.adjustsFontSizeToFitWidth = true
        return l
    }()
    
    private let dateLabel: UILabel = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "\(dateFormatter.string(from: Date())) - Today"
        l.font = UIFont.systemFont(ofSize: 12, weight: .light)
        l.textColor = .lightGray
        l.minimumScaleFactor = 0.7
        l.adjustsFontSizeToFitWidth = true
        return l
    }()
    
    init(delegate: HeaderViewProtocol?) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK:- Handling communication with the View implementing the header view

extension HeaderView {
    
    func handleAdd() {
        delegate?.addTask()
    }
    
    func handleSearch() {
        delegate?.searchTask()
    }
    
    @objc func handleOpeningProfile() {
        delegate?.openProfile()
    }
    
}

// MARK:- UI setup

extension HeaderView {
    
    func setImage(withUrl url: String) {
        guard let imgUrl = URL(string: url) else { return }
        
        NetworkManager.shared.fetchProfileImage(url: imgUrl) { [unowned self] (image, error) in
            DispatchQueue.main.async {
                if let err = error {
                    print(err.localizedDescription)
                    return
                }
                if let img = image {
                    self.profileImage.setImage(img.withRenderingMode(.alwaysOriginal), for: .normal)
                }
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        setupPath()
        line.setupView(leadingAnchor: leadingAnchor)
    }
    
    // sets up the UI
    fileprivate func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundImage)
        layer.addSublayer(shapeLayer)
        addSubview(buttonStack)
        addSubview(line)
        addSubview(profileImage)
        addSubview(dateLabel)
        addSubview(myTasksLabel)
        
        NSLayoutConstraint.activate([
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            buttonStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            buttonStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            
            line.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            line.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.26),
            
            dateLabel.leadingAnchor.constraint(equalTo: line.trailingAnchor, constant: 8),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            dateLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            
            myTasksLabel.leadingAnchor.constraint(equalTo: line.trailingAnchor, constant: 8),
            myTasksLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -2),
            myTasksLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            myTasksLabel.heightAnchor.constraint(equalToConstant: 26),
            
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            profileImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0)
            ])
    }
    
    // sets up the path of the white cover
    fileprivate func setupPath() {
        let height: CGFloat = bounds.height / 1.4
        path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: bounds.height))
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.height - 30))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.close()
        
        shapeLayer.fillColor = UIColor.backgroundColor.cgColor
        shapeLayer.path = path.cgPath
    }
}

fileprivate class HeaderButtons: UIButton {
    
    private let padding: CGFloat = -16
    private let size: CGFloat = 44
    
    override var intrinsicContentSize: CGSize {
        return .init(width: size, height: size)
    }
    
    func setupButton() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .hotPink
        imageView?.contentMode = .scaleAspectFill
        imageEdgeInsets = UIEdgeInsets(top: -8, left: -8, bottom: -8, right: -8)
        layer.cornerRadius = 22
    }
}
