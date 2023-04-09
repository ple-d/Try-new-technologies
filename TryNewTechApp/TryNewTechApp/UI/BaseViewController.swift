//
//  BaseViewController.swift
//  TryNewTechApp
//
//  Created by mac on 07.04.2023.
//

import Foundation
import RxSwift

class BaseViewController: UIViewController {
    
    var removedFromViewHierarchy: (() -> Void)?
    
    var disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do not set bg color, should be transparent somehere
        //view.backgroundColor = Colors.controlBg
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        let isRemoved = nil == self.presentingViewController && nil == self.parent
        if isRemoved {
            removedFromViewHierarchy?()
        }
    }
    
//    func show(error: Error) {
//        show(errorMessage: "\(error)")
//    }
//
//    func show(errorMessage: String) {
//        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        present(alert, animated: true, completion: nil)
//    }
}

extension BaseViewController: ViewControllerCompletable { }
