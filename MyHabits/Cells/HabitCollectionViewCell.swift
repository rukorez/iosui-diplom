//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Филипп Степанов on 24.10.2021.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    var cell: Habit? {
        didSet {
            habitName.text = cell?.name
            habitName.textColor = cell?.color
            habitDate.text = cell?.dateString
        }
    }
    
    var habitName: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    var habitDate: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
        return label
    }()
    
    var habitIndicator: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.text = "Счётчик: "
        label.textColor = .systemGray
        return label
    }()
    
    var doneButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = .clear
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        contentView.addSubview(habitName)
        contentView.addSubview(habitDate)
        contentView.addSubview(habitIndicator)
        contentView.addSubview(doneButton)
        doneButton.addTarget(self, action: #selector(done), for: .touchUpInside)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func done() {
        doneButton.backgroundColor = cell!.color
        doneButton.setImage(UIImage(systemName: "checkmark", withConfiguration: UIImage.SymbolConfiguration(weight: .bold)), for: .normal)
        doneButton.tintColor = .white
        if cell?.isAlreadyTakenToday == false {
            HabitsStore.shared.track(cell!)
        }
        HabitsViewController.collectionView.reloadData()
    }
    
    override func layoutSubviews() {
        if cell?.isAlreadyTakenToday == true {
            doneButton.backgroundColor = cell!.color
            doneButton.setImage(UIImage(systemName: "checkmark", withConfiguration: UIImage.SymbolConfiguration(weight: .bold)), for: .normal)
            doneButton.tintColor = .white
        }
        doneButton.layer.borderColor = cell?.color.cgColor
        doneButton.layer.cornerRadius = 20
        doneButton.layer.borderWidth = CGFloat(2.3)
    }
        
}

// MARK: Констрейнты

extension HabitCollectionViewCell {
    
    private func setConstraints() {
        let constr = [
            habitName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            habitName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            habitName.widthAnchor.constraint(equalToConstant: 150),
            
            habitDate.topAnchor.constraint(equalTo: habitName.bottomAnchor, constant: 5),
            habitDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            habitIndicator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            habitIndicator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            doneButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            doneButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            doneButton.heightAnchor.constraint(equalToConstant: 40),
            doneButton.widthAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(constr)
    }
    
}
