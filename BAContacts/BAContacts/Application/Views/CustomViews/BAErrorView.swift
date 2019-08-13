//
//  BAErrorView.swift
//  BAContacts
//
//  Created by Burak Akyalcin on 2.05.2019.
//  Copyright © 2019 Burak Akyalcin. All rights reserved.
//

import UIKit

enum BAErrorType {
    case success(message: String)
    case fail(message: String)
}

protocol BAErrorViewDelegate: class {
    func didTapCloseButton(_ view: BAErrorView)
}

class BAErrorView: UIView {
    
    @IBOutlet private var containerView: UIView!
    @IBOutlet private weak var errorView: UIView!
    @IBOutlet private weak var leftIndicatorView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var closeView: UIView!
    
    weak var delegate: BAErrorViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        instantiateView()
        setErrorView()
    }
    
    func instantiateView() {
        Bundle.main.loadNibNamed(BAErrorView.className, owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        closeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(close)))
    }
    
    func setErrorView() {
        errorView.layer.borderWidth = 1
        errorView.layer.borderColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
    }
    
    func setView(with type: BAErrorType) {
        switch type {
        case .success(let message):
            leftIndicatorView.backgroundColor = #colorLiteral(red: 0.1577661335, green: 0.7913749814, blue: 0.2574284673, alpha: 1)
            titleLabel.text = message
        case .fail(let message):
            leftIndicatorView.backgroundColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
            titleLabel.text = message
        }
    }
    
    @objc func close() {
        delegate?.didTapCloseButton(self)
    }
    
    
}
