//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Филипп Степанов on 22.10.2021.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    var progress: UIProgressView = {
        var progress = UIProgressView(progressViewStyle: .default)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.progress = HabitsStore.shared.todayProgress
        progress.progressTintColor = UIColor(named: "Fiolet")
        progress.trackTintColor = .systemGray5
        progress.clipsToBounds = true
        progress.layer.cornerRadius = 4
        return progress
    }()
    
    var label: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Всё получится!"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    var todayProgress: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.text = "\(Int(HabitsStore.shared.todayProgress * 100))%"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        contentView.addSubview(progress)
        contentView.addSubview(label)
        contentView.addSubview(todayProgress)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateProgress() {
        progress.setProgress(HabitsStore.shared.todayProgress, animated: true)
        todayProgress.text = "\(Int(HabitsStore.shared.todayProgress * 100)) %"
    }
    
}

// MARK: Констрейнты

extension ProgressCollectionViewCell {
    
    private func setConstraints() {
        let constraints = [
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            todayProgress.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            todayProgress.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            progress.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            progress.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progress.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            progress.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -17)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
