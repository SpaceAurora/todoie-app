//
//  Coordinator.swift
//  todoie
//
//  Created by Mustafa Khalil on 1/21/19.
//  Copyright © 2019 Aurora. All rights reserved.
//

import UIKit
import Firebase

private enum ControllerType {
    case login, home
}

private let firsTimeOpeningApp = "firstTimeOpeningTheApp"

class Coordinator: CoordinatorDelegate {
    
    private var viewController: UIViewController
    private var loginHandler: AuthStateDidChangeListenerHandle?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func start() {
        loginHandler = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil {
                self.showController(.login)
            } else {
                self.showController(.home)
            }
        }
    }
    
}
//MARK:- LoginView Controller delegate

extension Coordinator {
    
    func showWelcomingViewController(controller: UIViewController) {
        if UserDefaults.standard.bool(forKey: firsTimeOpeningApp) == false {
            let welcomingScreenVC = WelcomingViewController(delegate: self)
            DispatchQueue.main.async {
                controller.present(welcomingScreenVC, animated: true) {
                    UserDefaults.standard.set(true, forKey: firsTimeOpeningApp)
                }
            }
        }
    }
}

//MARK:- HomeView controller delegate

extension Coordinator {
    func showAddTasksViewController(controller: UIViewController) {
        let navController = UINavigationController(rootViewController: AddTaskViewController(delegate: self))
        controller.present(navController, animated: true)
    }
    
    func showSearchViewController(controller: UIViewController) {
        //TODO:- implement
    }
    
    func showProfileViewController(controller: UIViewController) {
        //TODO:- implement
    }
    
}

//MARK:- Dismiss any presenet(_:_) controller

extension Coordinator {
    func dismissFromMainView(controller: UIViewController) {
        controller.dismiss(animated: true)
    }
}

//MARK:- AUTH AND ROOT CONTROLLER SETUP

extension Coordinator {
    
    private func showController(_ controller: ControllerType) {
        if let _ = viewController.children.last as? LoginViewController, Auth.auth().currentUser != nil {
            handleAnimation()
            return
        }
        if let _ = viewController.children.last as? LoginViewController, Auth.auth().currentUser == nil {
            return
        }
        
        if let _ = viewController.children.last as? HomeViewController, Auth.auth().currentUser != nil {
            return
        }
        
        switch controller {
        case .login:
            show(controller: LoginViewController(delegate: self))
        case .home:
            show(controller: HomeViewController(delegate: self))
        }
    }
    
    private func show(controller: UIViewController) {
        viewController.addChild(controller)
        viewController.view.addSubview(controller.view!)
    }
    
    private func handleAnimation() {
        guard let loginVC = viewController.children.last else { return }
        let homeVC = HomeViewController(delegate: self)
        let loginView = loginVC.view!
        let homeView = homeVC.view!
        viewController.view.insertSubview(homeView, belowSubview: loginView)
        
        animate(animation: {
            loginView.alpha = 0
        }) { (done) in
            self.finishUpAnimation(done, newVC: homeVC, oldVC: loginVC)
        }
    }
    
    private func animate(animation: @escaping () -> Void, completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: animation, completion: completion)
    }
    
    private func finishUpAnimation(_ done: Bool, newVC: UIViewController, oldVC: UIViewController) {
        if done {
            oldVC.removeFromParent()
            oldVC.view.removeFromSuperview()
            viewController.addChild(newVC)
        }
    }
    
}
