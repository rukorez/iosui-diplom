//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Филипп Степанов on 14.10.2021.
//

import UIKit

class InfoViewController: UIViewController {

    var scrollView = UIScrollView()
    var contentView = UIView()
    
    var textHeader: UILabel = {
        var text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "Привычка за 21 день"
        text.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return text
    }()
    
    var textInfo: UILabel = {
        var text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        text.text = "Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:\n\n1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.\n\n2. Выдержать 2 дня в прежнем состоянии самоконтроля.\n\n3. Отметить в дневнике первую неделю изменений и подвести первые итоги - что оказалось тяжело, что - легче, с чем еще предстоит серьезно бороться.\n\n4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.\n\n5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.\n\n6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.\n\nИсточник: psychbook.ru"
        text.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "CustomWhite")
        self.title = "Информация"
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(textHeader)
        contentView.addSubview(textInfo)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        setConstraints()
    }

}

// MARK: Констрейнты

extension InfoViewController {
    private func setConstraints() {
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            
            textHeader.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            textHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            textHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            textInfo.topAnchor.constraint(equalTo: textHeader.bottomAnchor, constant: 12),
            textInfo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            textInfo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            textInfo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
