//
//  LaunchViewController.swift
//  MyHabits
//
//  Created by Филипп Степанов on 13.10.2021.
//

import UIKit

class LaunchViewController: UIViewController {

    var logo: UIImageView = {
        var logo = UIImageView()
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.image = UIImage(named: "Icon")
        logo.layer.cornerRadius = 25
        logo.clipsToBounds = true
        return logo
    }()
    
    var label: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "MyHabits"
        label.textColor = UIColor(named: "Fiolet")
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(logo)
        view.addSubview(label)
        setConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if #available(iOS 13.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                view.backgroundColor = .black
            } else {
                view.backgroundColor = .white
            }
        }
    }

}

// MARK: Констрейнты

extension LaunchViewController {
    private func setConstraints() {
        let const = [
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logo.widthAnchor.constraint(equalToConstant: 130),
            logo.heightAnchor.constraint(equalToConstant: 130),
            
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(const)
    }
}
