//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Филипп Степанов on 18.10.2021.
//

import UIKit

class HabitViewController: UIViewController, UITextFieldDelegate {
    
    var habit: Habit?
    
    var name: UILabel = {
        var name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "НАЗВАНИЕ"
        name.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return name
    }()
    
    var nameTextField: UITextField = {
        var textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Бегать по утрам, спать по 8 часов и т.п."
        textField.textColor = UIColor(named: "CustomBlue")
        return textField
    }()
    
    var color: UILabel = {
        var color = UILabel()
        color.translatesAutoresizingMaskIntoConstraints = false
        color.text = "ЦВЕТ"
        color.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return color
    }()
    
    var colorPicker: UIButton = {
        var picker = UIButton()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = UIColor(named: "CustomOrange")
        picker.layer.cornerRadius = 25
        picker.clipsToBounds = true
        picker.addTarget(self, action: #selector(presentColorPicker), for: .touchUpInside)
        return picker
    }()
    
    var time: UILabel = {
        var time = UILabel()
        time.translatesAutoresizingMaskIntoConstraints = false
        time.text = "ВРЕМЯ"
        time.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return time
    }()
    
    var timeText: UILabel = {
        var text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "Каждый день в "
        return text
    }()
    
    var datePicker: UIDatePicker = {
        var date = UIDatePicker()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.preferredDatePickerStyle = .wheels
        date.datePickerMode = .time
        date.locale = Locale(identifier: "ru_RU")
        date.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        return date
    }()
    
    var selectedTime: UILabel = {
        var time = UILabel()
        time.translatesAutoresizingMaskIntoConstraints = false
        time.textColor = UIColor(named: "Fiolet")
        return time
    }()
    
    var deleteButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(remove), for: .touchUpInside)
        return button
    }()
    
    var t = false

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "CustomWhite")
        navigationItem.title = "Создать"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(createHabit))
        view.addSubview(name)
        view.addSubview(nameTextField)
        view.addSubview(color)
        view.addSubview(colorPicker)
        view.addSubview(time)
        view.addSubview(timeText)
        view.addSubview(datePicker)
        view.addSubview(selectedTime)
        view.addSubview(deleteButton)
        setConstraint()
        hideKeyboard()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.dismissKeyboard()
        return false
        }
    
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        self.colorPicker.backgroundColor = viewController.selectedColor
    }
    
}

// MARK: Реализация кнопок

extension HabitViewController {
    
    @objc private func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func presentColorPicker() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        colorPicker.title = "Выберите Цвет"
        present(colorPicker, animated: true, completion: nil)
    }
    
    @objc private func dateChanged() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        selectedTime.text = formatter.string(from: datePicker.date)
    }
    
    @objc private func createHabit() {
        if t {
            for (i,j) in HabitsStore.shared.habits.enumerated() where j.name == habit?.name {
                HabitsStore.shared.habits[i].name = nameTextField.text!
                HabitsStore.shared.habits[i].date = datePicker.date
                HabitsStore.shared.habits[i].color = colorPicker.backgroundColor!
            }
            self.dismissVC()
        } else {
            let newHabit = Habit(name: nameTextField.text!,
                                 date: datePicker.date,
                                 color: colorPicker.backgroundColor!)
            let store = HabitsStore.shared
            store.habits.append(newHabit)
            self.dismissVC()
        }
    }
    
    @objc private func remove() {
        guard let nameText = nameTextField.text else { return }
        let alert = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить \"\(nameText)\"?", preferredStyle: .alert)
        let actionNo = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(actionNo)
        let actionYes = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            for (i,j) in HabitsStore.shared.habits.enumerated() {
                if j.name == self.habit?.name {
                    HabitsStore.shared.habits.remove(at: i)
                    self.dismissVC()
                }
            }
        }
        alert.addAction(actionYes)
        self.present(alert, animated: true, completion: nil)
    }
        
}


// MARK: Расширение UIiewController для скрытия клавиатуры по нажатию вне поля TextField

extension HabitViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(HabitViewController.dismissKeyboard))

        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: Констрейнты

extension HabitViewController {
    private func setConstraint() {
        let constraint = [
            name.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            nameTextField.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 12),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            color.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            color.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            color.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            colorPicker.topAnchor.constraint(equalTo: color.bottomAnchor, constant: 12),
            colorPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            colorPicker.widthAnchor.constraint(equalToConstant: 50),
            colorPicker.heightAnchor.constraint(equalToConstant: 50),
            
            time.topAnchor.constraint(equalTo: colorPicker.bottomAnchor, constant: 20),
            time.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            time.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            timeText.topAnchor.constraint(equalTo: time.bottomAnchor, constant: 12),
            timeText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            datePicker.topAnchor.constraint(equalTo: timeText.bottomAnchor, constant: 20),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            selectedTime.topAnchor.constraint(equalTo: time.bottomAnchor, constant: 12),
            selectedTime.leadingAnchor.constraint(equalTo: timeText.trailingAnchor),
            selectedTime.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            deleteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraint)
    }
}
