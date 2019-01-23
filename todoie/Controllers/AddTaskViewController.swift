//
//  AddTaskViewController.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/23/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit
import JGProgressHUD

class AddTaskViewController: UIViewController {
    
    // constants
    fileprivate let addViewModel = AddTaskViewModel()
    
    fileprivate let trailingConstant: CGFloat = -30
    fileprivate let leadingConstant: CGFloat = 30
    fileprivate let pushDown: CGFloat = 20
    
    private weak var coordinatorDelegate: CoordinatorDelegate?
    
    // Views
    fileprivate let gradientLayer = CAGradientLayer()
    
    fileprivate let errorHUD: JGProgressHUD = {
        let j = JGProgressHUD(style: .dark)
        j.textLabel.text = "Error saving"
        return j
    }()
    
    fileprivate lazy var scrollView: UIScrollView = {
        let s = UIScrollView()
        s.delegate = self
        
        s.isUserInteractionEnabled = true
        
        s.isScrollEnabled = true
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    fileprivate lazy var containerView: UIView = {
        let v = UIView()
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    // Time and Date Views
    fileprivate lazy var calenderView: CalenderView = {
        let c = CalenderView()
        c.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showDatePicker)))
        c.isUserInteractionEnabled = true
        return c
    }()
    
    fileprivate lazy var priorityView = PriorityView(delegate: self)
    
    fileprivate lazy var remindMeView: RemindMeView = {
        let t = RemindMeView(delegate: self)
        return t
    }()
    
    // TextFields
    fileprivate let titleField: AddTaskTextField = {
        let t = AddTaskTextField(title: "Title")
        t.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
        return t
    }()
    
    fileprivate let descriptionField: AddTaskTextField = {
        let t = AddTaskTextField(title: "Descrption")
        t.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
        return t
    }()
    
    fileprivate lazy var timeView: TimeTextField = {
        let t = TimeTextField(title: "When", dateType: Date.timeFormat)
        t.isSelected = false
        t.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showTimePicker)))
        return t
    }()
    
    fileprivate lazy var alarmView: TimeTextField = {
        let t = TimeTextField(title: "Alarm", dateType: Date.alertFormat)
        t.isSelected = false
        t.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showAlarmPicker)))
        return t
    }()
    
    
    // Pickers
    fileprivate lazy var datePicker: TodoieDateTimePicker = {
        let d = TodoieDateTimePicker(dateMode: .date)
        d.addTarget(self, action: #selector(didChangeDate), for: .valueChanged)
        return d
    }()
    
    fileprivate lazy var timePicker: TodoieDateTimePicker = {
        let d = TodoieDateTimePicker(dateMode: .time)
        d.addTarget(self, action: #selector(didChangeTime), for: .valueChanged)
        return d
    }()
    
    fileprivate lazy var alarmPicker: TodoieDateTimePicker = {
        let d = TodoieDateTimePicker(dateMode: .dateAndTime)
        d.addTarget(self, action: #selector(didChangeAlarmDateAndTime), for: .valueChanged)
        return d
    }()
    
    fileprivate lazy var saveButton: UIButton = {
        let size: CGFloat = 60
        let b = UIButton(type: .system)
        b.imageView?.contentMode = .scaleAspectFill
        b.setImage(#imageLiteral(resourceName: "saveButton").withRenderingMode(.alwaysOriginal), for: .normal)
        b.backgroundColor = .white
        b.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.widthAnchor.constraint(equalToConstant: size).isActive = true
        b.heightAnchor.constraint(equalToConstant: size).isActive = true
        b.layer.cornerRadius = size * 0.5
        return b
    }()
    
    // Constraints
    lazy var datePickerHeightConstraint = datePicker.heightAnchor.constraint(equalToConstant: 0)
    lazy var timePickerHeightConstraint = timePicker.heightAnchor.constraint(equalToConstant: 0)
    lazy var alarmPickerHeightConstraint = alarmPicker.heightAnchor.constraint(equalToConstant: 0)
    
    lazy var remindMeStackView: UIStackView = {
        let s = UIStackView(arrangedSubviews: [alarmView, alarmPicker, priorityView])
        s.axis = .vertical
        s.isHidden = true
        s.isUserInteractionEnabled = true
        s.spacing = 4
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    init(delegate: CoordinatorDelegate) {
        coordinatorDelegate = delegate
        super.init(nibName: nil, bundle: nil)
        timeView.delegate = self
        alarmView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers()
        setupView()
        setupNotificationObservers()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeNotificationObservers()
    }
    
    func setupObservers() {
        addViewModel.uploaded.bind { (isUploading) in
            if isUploading == true {
                self.handleDismiss()
            } else {
                self.saveButton.isEnabled = false
            }
        }
        addViewModel.error.bind { (isError) in
            self.saveButton.isEnabled = isError ?? true
            self.errorHUD.show(in: self.view, animated: true)
            self.errorHUD.dismiss(afterDelay: 3, animated: true)
        }
    }
}

//MARK:- Navigation

extension AddTaskViewController {
    
    @objc func handleDismiss() {
        coordinatorDelegate?.dismissFromMainView(controller: self)
    }
    
}

//MARK:- Keyboard notifications

extension AddTaskViewController: UITextFieldDelegate {
    
    fileprivate func setupNotificationObservers() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleShowKeyboard),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleHideKeyboard),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    fileprivate func removeNotificationObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handleShowKeyboard(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        
        let tabbarHeight = tabBarController?.tabBar.frame.size.height ?? 0
        let toolbarHeight = navigationController?.toolbar.frame.size.height ?? 0
        let bottomInset = keyboardSize.height - tabbarHeight - toolbarHeight + 50
        scrollView.contentInset.bottom = bottomInset
        scrollView.scrollIndicatorInsets.bottom = bottomInset
    }
    
    @objc func handleHideKeyboard() {
        var contentInset = scrollView.contentInset
        contentInset.bottom = 0
        
        scrollView.contentInset = contentInset
    }
    
    @objc func handleTapDismiss() {
        view.endEditing(true)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}


// MARK:- Pickers

extension AddTaskViewController: PriorityViewDelegate {
    
    @objc func handleSave() {
        addViewModel.save()
    }
    
    func getPriority(priority: Priority) {
        addViewModel.priority = priority
    }
    
    @objc func handleTextChanged(_ sender: UITextField) {
        if titleField == sender {
            addViewModel.title = titleField.text
        } else if descriptionField == sender {
            addViewModel.descrption = descriptionField.text
        }
    }
    
    @objc func didChangeDate() {
        addViewModel.calender = datePicker.date
        calenderView.setDate(date: datePicker.date)
    }
    
    @objc func didChangeTime() {
        addViewModel.time = timePicker.date
        timeView.setupDate(format: Date.timeFormat, date: timePicker.date)
    }
    
    @objc func didChangeAlarmDateAndTime() {
        addViewModel.alert = alarmPicker.date
        alarmView.setupDate(format: Date.alertFormat, date: alarmPicker.date)
    }
    
    func shouldShowRemindMeView(isOn: Bool) {
        remindMeStackView.isHidden = !isOn
    }
    
}


// MARK:- Handling UI Changes

extension AddTaskViewController {
    @objc func showDatePicker() {
        handlePickers(picker: datePicker, constraint: datePickerHeightConstraint)
    }
    
    @objc func showAlarmPicker() {
        handlePickers(picker: alarmPicker, constraint: alarmPickerHeightConstraint)
    }
    
    @objc func showTimePicker() {
        handlePickers(picker: timePicker, constraint: timePickerHeightConstraint)
    }
    
    fileprivate func handlePickers(picker: TodoieDateTimePicker, constraint: NSLayoutConstraint) {
        let shouldShow = !picker.isHidden
        constraint.constant = !shouldShow ? 200 : 0
        picker.isHidden = shouldShow
    }
}

//MARK:- UI

extension AddTaskViewController: UIScrollViewDelegate, RemindMeViewDelegate {
    
    func setupView() {
        setupNavController()
        setupGradient()
        setupUI()
    }
    
    fileprivate func setupUI() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(containerView)
        containerView.addSubview(calenderView)
        containerView.addSubview(titleField)
        containerView.addSubview(descriptionField)
        containerView.addSubview(datePicker)
        containerView.addSubview(timePicker)
        containerView.addSubview(timeView)
        containerView.addSubview(remindMeView)
        containerView.addSubview(remindMeStackView)
        containerView.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            
            calenderView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            calenderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calenderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calenderView.heightAnchor.constraint(equalToConstant: 200),
            remindMeView.heightAnchor.constraint(equalToConstant: 40),
            
            
            datePickerHeightConstraint,
            timeView.heightAnchor.constraint(equalToConstant: 40),
            alarmView.heightAnchor.constraint(equalToConstant: 40),
            timePickerHeightConstraint,
            
            saveButton.bottomAnchor.constraint(equalTo: containerView.layoutMarginsGuide.bottomAnchor, constant: 16),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
        
        setupConstraints(mainView: datePicker, toView: calenderView)
        setupConstraints(mainView: titleField, toView: datePicker)
        setupConstraints(mainView: descriptionField, toView: titleField)
        setupConstraints(mainView: timeView, toView: descriptionField)
        setupConstraints(mainView: timePicker, toView: timeView)
        setupConstraints(mainView: remindMeView, toView: timePicker)
        setupConstraints(mainView: remindMeStackView, toView: remindMeView)
        priorityView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -100).isActive = true
    }
    
    fileprivate func setupConstraints(mainView: UIView, toView: UIView) {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: toView.bottomAnchor, constant: pushDown),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailingConstant),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingConstant),
            ])
    }
    
    fileprivate func setupGradient() {
        gradientLayer.colors = [UIColor.todoieLightSkyBlue.cgColor, #colorLiteral(red: 0.9139506221, green: 0.4455054402, blue: 0.5577657223, alpha: 1).cgColor]
        gradientLayer.locations = [0, 1]
        view.backgroundColor = .white
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }
    
    fileprivate func setupNavController() {
        navigationController?.navigationBar.barTintColor = .todoieLightSkyBlue
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "BackButton").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleDismiss))
    }
}
