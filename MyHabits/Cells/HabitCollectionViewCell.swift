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
            guard let habit = cell else { return }
            habitName.text = habit.name
            habitName.textColor = habit.color
            habitDate.text = habit.dateString
            doneButton.layer.borderColor = habit.color.cgColor
            doneButton.tintColor = habit.color
            doneButton.setBackgroundImage(.checkmark, for: .normal)
        }
    }
    
    lazy var habitName: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var habitDate: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
        return label
    }()
    
    lazy var habitIndicator: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.text = "Счётчик: "
        label.textColor = .systemGray
        return label
    }()
    
    lazy var doneButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 2.3
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(done), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        contentView.addSubview(habitName)
        contentView.addSubview(habitDate)
        contentView.addSubview(habitIndicator)
        contentView.addSubview(doneButton)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func done() {
        if cell?.isAlreadyTakenToday == false {
            doneButton.setBackgroundImage(.checkmark, for: .normal)
            doneButton.tintColor = cell?.color
            doneButton.backgroundColor = cell?.color
            HabitsStore.shared.track(cell!)
        }
    }
    
    func habitTracked() {
        if cell?.isAlreadyTakenToday == true {
            doneButton.backgroundColor = cell!.color
            doneButton.tintColor = cell?.color
        } else {
            doneButton.backgroundColor = .white
            doneButton.tintColor = .clear
        }
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
            doneButton.heightAnchor.constraint(equalToConstant: 50),
            doneButton.widthAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(constr)
    }
    
}
