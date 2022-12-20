//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Эля Корельская on 29.10.2022.
//

import UIKit
//контроллер с общей информацией о привычках
class InfoViewController: UIViewController {

    //стек для текста
    private var contantView: UIView = {
        var stack = UIView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
   //лейбл с текстом 1
    private var textLabel: UILabel = {
        var text = UILabel()
        text.font = UIFont(name: "SF Pro Text", size: 17)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        text.text = "Привычка за 21 день"
        text.font = UIFont.boldSystemFont(ofSize: 20)
        return text
    }()
    //лейбл с текстом 2
    private var textLabel1: UILabel = {
        var text = UILabel()
        text.font = UIFont(name: "SF Pro Text", size: 17)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        text.text = "Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:"
        return text
    }()
    // лейбл с текстом 3
    private var textLabel2: UILabel = {
        var text = UILabel()
        text.font = UIFont(name: "SF Pro Text", size: 17)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        text.text = "1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага."
        return text
    }()
    // лейбл с тексом 4
    private var textLabel3: UILabel = {
        var text = UILabel()
        text.font = UIFont(name: "SF Pro Text", size: 17)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        text.text = "2. Выдержать 2 дня в прежнем состоянии самоконтроля."
        return text
    }()
    // лейбл с текстом 5
    private var textLabel4: UILabel = {
        var text = UILabel()
        text.font = UIFont(name: "SF Pro Text", size: 17)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        text.text = "3. Отметить в дневнике первую неделю изменений и подвести первые итоги - что оказалось тяжело, что - легче, с чем еще предстоит серьезно бороться."
        return text
    }()
    // лейбл с текстом 6
    private var textLabel5: UILabel = {
        var text = UILabel()
        text.font = UIFont(name: "SF Pro Text", size: 17)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        text.text = "4. Поздравить себя с прохождением первого серьезного порога 21 день. За это время отказ от дурных наклонностей уже примет форму осознанног преодоления и человек  сможет больше работать в сторону принятия положительных качеств."
        return text
    }()
    // лейбл с текстом 7
    private var textLabel6: UILabel = {
        var text = UILabel()
        text.font = UIFont(name: "SF Pro Text", size: 17)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        text.text = "5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой. "
        return text
    }()
    // лейбл с текстом 8
    private var textLabel7: UILabel = {
        var text = UILabel()
        text.font = UIFont(name: "SF Pro Text", size: 17)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        text.text = "6. На 90-й день соблюдения техники все лишнее из «прошлой жизни»перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.  "
        return text
    }()
    // лейбл с текстом 9
    private var textLabel8: UILabel = {
        var text = UILabel()
        text.font = UIFont(name: "SF Pro Text", size: 17)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        text.text = "Источник: psychbook.ru  "
        return text
    }()
    // скролл текста
    private var scrollView: UIScrollView = {
        var scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    // линия разделяет навигационный бар и вью
    private var lineView: UIView =  {
        var line = UIView(frame: CGRect(x:0, y: 0, width: 1014, height:1))
        line.backgroundColor = UIColor.systemGray2
        return line
    }()
    override func viewWillAppear(_ animated: Bool) {
    AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Информация"
        view.backgroundColor = UIColor(named:"White")
        view.addSubview(scrollView)
        scrollView.addSubview(self.lineView)
        scrollView.addSubview(self.contantView)
        contantView.addSubview(self.textLabel)
        contantView.addSubview(self.textLabel1)
        contantView.addSubview(self.textLabel2)
        contantView.addSubview(self.textLabel3)
        contantView.addSubview(self.textLabel4)
        contantView.addSubview(self.textLabel5)
        contantView.addSubview(self.textLabel6)
        contantView.addSubview(self.textLabel7)
        contantView.addSubview(self.textLabel8)
        infoConstraint()
    }
    func infoConstraint() {
        NSLayoutConstraint.activate([
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        
        
        contantView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        contantView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
        contantView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
        contantView.topAnchor.constraint(equalTo: scrollView.topAnchor),
        contantView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
        
        textLabel.leadingAnchor.constraint(equalTo: contantView.leadingAnchor, constant: 10),
        textLabel.trailingAnchor.constraint(equalTo: contantView.trailingAnchor, constant: -10),
        textLabel.topAnchor.constraint(equalTo: contantView.topAnchor, constant: 22),
        
        
        textLabel1.topAnchor.constraint(equalTo: textLabel.bottomAnchor,constant: 15),
        textLabel1.trailingAnchor.constraint(equalTo: contantView.trailingAnchor, constant: -10),
        textLabel1.leadingAnchor.constraint(equalTo: contantView.leadingAnchor, constant: 10),
        
        textLabel2.topAnchor.constraint(equalTo: textLabel1.bottomAnchor,constant: 15),
        textLabel2.leadingAnchor.constraint(equalTo: contantView.leadingAnchor, constant: 10),
        textLabel2.trailingAnchor.constraint(equalTo: contantView.trailingAnchor, constant: -10),
        
        textLabel3.topAnchor.constraint(equalTo: textLabel2.bottomAnchor,constant: 15),
        textLabel3.leadingAnchor.constraint(equalTo: contantView.leadingAnchor, constant: 10),
        textLabel3.trailingAnchor.constraint(equalTo: contantView.trailingAnchor, constant: -10),
        
        textLabel4.topAnchor.constraint(equalTo: textLabel3.bottomAnchor,constant: 15),
        textLabel4.leadingAnchor.constraint(equalTo: contantView.leadingAnchor, constant: 10),
        textLabel4.trailingAnchor.constraint(equalTo: contantView.trailingAnchor, constant: -10),

        textLabel5.topAnchor.constraint(equalTo: textLabel4.bottomAnchor,constant: 15),
        textLabel5.leadingAnchor.constraint(equalTo: contantView.leadingAnchor, constant: 10),
        textLabel5.trailingAnchor.constraint(equalTo: contantView.trailingAnchor, constant: -10),

        textLabel6.topAnchor.constraint(equalTo: textLabel5.bottomAnchor,constant: 15),
        textLabel6.leadingAnchor.constraint(equalTo: contantView.leadingAnchor, constant: 10),
        textLabel6.trailingAnchor.constraint(equalTo: contantView.trailingAnchor, constant: -10),

        textLabel7.topAnchor.constraint(equalTo: textLabel6.bottomAnchor,constant: 15),
        textLabel7.leadingAnchor.constraint(equalTo: contantView.leadingAnchor, constant: 10),
        textLabel7.trailingAnchor.constraint(equalTo: contantView.trailingAnchor, constant: -10),

        textLabel8.topAnchor.constraint(equalTo: textLabel7.bottomAnchor,constant: 10),
        textLabel8.leadingAnchor.constraint(equalTo: contantView.leadingAnchor, constant: 10),
        textLabel8.trailingAnchor.constraint(equalTo: contantView.trailingAnchor, constant: -10),
        textLabel8.bottomAnchor.constraint(equalTo: contantView.bottomAnchor, constant: -15)

        ])
    }
    
}

