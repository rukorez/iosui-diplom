//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Филипп Степанов on 04.11.2021.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    var habit: Habit!
    
    var tableCell = "tableCell"
    
    var tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = habit.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .done, target: self, action: #selector(edit))
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HabitDetailsTableViewCell.self, forCellReuseIdentifier: tableCell)
        setConstraints()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    @objc func edit() {
        let vc = HabitViewController()
        vc.habit = habit
        vc.nameTextField.text = habit.name
        vc.colorPicker.backgroundColor = habit.color
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        vc.selectedTime.text = formatter.string(from: habit.date)
        vc.datePicker.date = habit.date
        vc.t = true
        let nc = UINavigationController(rootViewController: vc)
        nc.modalPresentationStyle = .fullScreen
        if #available(iOS 13.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                vc.view.backgroundColor = .systemBackground
                nc.navigationBar.backgroundColor = .secondarySystemBackground
            } else if traitCollection.userInterfaceStyle == .light {
                vc.view.backgroundColor = UIColor(named: "customWhite")
            }
        }
        present(nc, animated: true, completion: nil)
    }
    
}

// MARK: Настройка UITableView

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCell, for: indexPath) as! HabitDetailsTableViewCell
        let dateForm = DateFormatter()
        dateForm.locale = Locale(identifier: "ru_RU")
        dateForm.dateStyle = .long
        let dates = HabitsStore.shared.dates.sorted(by: { $1 < $0 })
        cell.date.text = dateForm.string(from: dates[indexPath.row])
        if HabitsStore.shared.habit(habit, isTrackedIn: dates[indexPath.row]) == true {
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Активность"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

// MARK: Констрейнты

extension HabitDetailsViewController {
    
    private func setConstraints() {
        let constr = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constr)
    }
    
}
