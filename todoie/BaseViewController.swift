//
//  BaseViewController.swift
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

class BaseViewController: UIViewController {
    
    var viewController: UIViewController!
    var loginHandler: AuthStateDidChangeListenerHandle?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        routingThroughUserState()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(loginHandler!)
    }
    
    private func routingThroughUserState() {
        loginHandler = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil {
                self.showController(.login)
            } else {
                self.showController(.home)
            }
        }
    }
    
    
    private func showController(_ controller: ControllerType) {
        if let _ = viewController as? LoginViewController, Auth.auth().currentUser != nil {
            handleAnimation()
            return
        }
        if let _ = viewController as? LoginViewController, Auth.auth().currentUser == nil {
            return
        }
        
        switch controller {
        case .login:
            show(controller: LoginViewController())
        case .home:
            show(controller: HomeViewController())
        }
    }
    
    private func show(controller: UIViewController) {
        viewController = controller
        let viewVC = viewController.view!
        addChild(viewController)
        view.addSubview(viewVC)
        setupConstraints(currentView: viewVC)
    }
    
    private func handleAnimation() {
        guard let vc = viewController else { return }
        let homeVC = HomeViewController()
        let loginView = vc.view!
        let homeView = homeVC.view!
        
        addChild(homeVC)
        view.insertSubview(homeView, belowSubview: loginView)
        setupConstraints(currentView: homeView)
        
        animate(animation: {
            loginView.alpha = 0
        }) { (done) in
            self.finishUpAnimation(done, newVC: homeVC)
        }
    }
    
    private func animate(animation: @escaping () -> Void, completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: animation, completion: completion)
    }
    
    private func finishUpAnimation(_ done: Bool, newVC: UIViewController) {
        if done {
            viewController?.removeFromParent()
            viewController?.view.removeFromSuperview()
            viewController = newVC
        }
    }
    
    private func setupConstraints(currentView: UIView) {
        NSLayoutConstraint.activate([
            currentView.topAnchor.constraint(equalTo: view.topAnchor),
            currentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            currentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            currentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
    }
    
}
