//
//  HabitDetailsTableViewCell.swift
//  MyHabits
//
//  Created by Филипп Степанов on 07.11.2021.
//

import UIKit

class HabitDetailsTableViewCell: UITableViewCell {
    
    
    var date: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(date)
        date.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        date.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        date.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12).isActive = true
        date.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
