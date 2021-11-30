//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Филипп Степанов on 14.10.2021.
//

import UIKit

class HabitsViewController: UIViewController {
    
    static var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.contentInsetAdjustmentBehavior = .always
        return collection
    }()
        
    var progressID = "progressID"
    var habitCell = "habitCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        navigationItem.title = "Сегодня"
                    
        view.addSubview(HabitsViewController.collectionView)
        HabitsViewController.collectionView.delegate = self
        HabitsViewController.collectionView.dataSource = self
        HabitsViewController.collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: progressID)
        HabitsViewController.collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: habitCell)
        setconstraints()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        HabitsViewController.collectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if #available(iOS 13.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                view.backgroundColor = .systemBackground
                navigationController?.navigationBar.backgroundColor = .secondarySystemBackground
                tabBarController?.tabBar.barTintColor = .secondarySystemBackground
                HabitsViewController.collectionView.reloadData()
            } else {
                view.backgroundColor = UIColor(named: "customWhite")
                HabitsViewController.collectionView.reloadData()
            }
        }
    }

            
    @objc func add() {
        let habitVC = HabitViewController()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        habitVC.selectedTime.text = formatter.string(from: habitVC.datePicker.date)
        habitVC.deleteButton.alpha = 0
        let habitNC = UINavigationController(rootViewController: habitVC)
        habitNC.modalPresentationStyle = .fullScreen
        if #available(iOS 13.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                habitVC.view.backgroundColor = .systemBackground
                habitNC.navigationBar.backgroundColor = .secondarySystemBackground
            } else if traitCollection.userInterfaceStyle == .light {
                habitVC.view.backgroundColor = UIColor(named: "customWhite")
            }
        }
        present(habitNC, animated: true, completion: nil)
    }
    
}

// MARK: Настройка UICollectionView

extension HabitsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 { return 1 }
        else { return HabitsStore.shared.habits.count }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: progressID, for: indexPath) as! ProgressCollectionViewCell
            cell.layer.cornerRadius = 10
            if #available(iOS 13.0, *) {
                if traitCollection.userInterfaceStyle == .dark {
                    cell.backgroundColor = .tertiarySystemBackground
                    cell.progress.progressTintColor = UIColor(named: "Fiolet")
                } else if traitCollection.userInterfaceStyle == .light {
                    cell.backgroundColor = . white
                }
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: habitCell, for: indexPath) as! HabitCollectionViewCell
            cell.cell = HabitsStore.shared.habits[indexPath.row]
            cell.layer.cornerRadius = 10
            cell.habitIndicator.text = "Счетчик: \(HabitsStore.shared.habits[indexPath.row].trackDates.count)"
            cell.backgroundColor = .tertiarySystemBackground
            return cell
        }
    }
    
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 { return CGSize(width: 0, height: 0) }
        else { return CGSize(width: 0, height: -20) }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            let detailsVC = HabitDetailsViewController()
            detailsVC.habit = HabitsStore.shared.habits[indexPath.row]
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 22, left: 12, bottom: 22, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.bounds.width - 24, height: 65)
        } else {
            return CGSize(width: collectionView.bounds.width - 24, height: 110)
        }
    }
    
}

// MARK: Констрейнты

extension HabitsViewController {
    
    private func setconstraints() {
        let constraints = [
            HabitsViewController.collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            HabitsViewController.collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            HabitsViewController.collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            HabitsViewController.collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
