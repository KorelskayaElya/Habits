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
    private var stackView: UIStackView = {
        var stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
   //лейбл с текстом 1
    private var textLabel: UILabel = {
        var text = UILabel()
        text.font = UIFont(name: "SF Pro Text", size: 17)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.lineBreakMode = .byWordWrapping
        text.numberOfLines = 0
        text.textAlignment = .left
        text.contentMode = .scaleAspectFit
        text.text = "Привычка за 21 день"
        text.font = UIFont.boldSystemFont(ofSize: 20)
        return text
    }()
    //лейбл с текстом 2
    private var textLabel1: UILabel = {
        var text = UILabel()
        text.font = UIFont(name: "SF Pro Text", size: 17)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.lineBreakMode = .byWordWrapping
        text.numberOfLines = 0
        text.textAlignment = .left
        text.contentMode = .scaleAspectFit
        text.text = "Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:"
        return text
    }()
    // лейбл с текстом 3
    private var textLabel2: UILabel = {
        var text = UILabel()
        text.font = UIFont(name: "SF Pro Text", size: 17)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.lineBreakMode = .byWordWrapping
        text.numberOfLines = 0
        text.textAlignment = .left
        text.contentMode = .scaleAspectFit
        text.text = "1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага."
        return text
    }()
    // лейбл с тексом 4
    private var textLabel3: UILabel = {
        var text = UILabel()
        text.font = UIFont(name: "SF Pro Text", size: 17)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.lineBreakMode = .byWordWrapping
        text.numberOfLines = 0
        text.textAlignment = .left
        text.contentMode = .scaleAspectFit
        text.text = "2. Выдержать 2 дня в прежнем состоянии самоконтроля."
        return text
    }()
    // лейбл с текстом 5
    private var textLabel4: UILabel = {
        var text = UILabel()
        text.font = UIFont(name: "SF Pro Text", size: 17)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.lineBreakMode = .byWordWrapping
        text.numberOfLines = 0
        text.textAlignment = .left
        text.contentMode = .scaleAspectFit
        text.text = "3. Отметить в дневнике первую неделю изменений и подвести первые итоги - что оказалось тяжело, что - легче, с чем еще предстоит серьезно бороться."
        return text
    }()
    // лейбл с текстом 6
    private var textLabel5: UILabel = {
        var text = UILabel()
        text.font = UIFont(name: "SF Pro Text", size: 17)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.lineBreakMode = .byWordWrapping
        text.numberOfLines = 0
        text.textAlignment = .left
        text.contentMode = .scaleAspectFit
        text.text = "4. Поздравить себя с прохождением первого серьезного порога 21 день. За это время отказ от дурных наклонностей уже примет форму осознанног преодоления и человек  сможет больше работать в сторону принятия положительных качеств."
        return text
    }()
    // лейбл с текстом 7
    private var textLabel6: UILabel = {
        var text = UILabel()
        text.font = UIFont(name: "SF Pro Text", size: 17)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.lineBreakMode = .byWordWrapping
        text.numberOfLines = 0
        text.textAlignment = .left
        text.contentMode = .scaleAspectFit
        text.text = "5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой. "
        return text
    }()
    // лейбл с текстом 8
    private var textLabel7: UILabel = {
        var text = UILabel()
        text.font = UIFont(name: "SF Pro Text", size: 17)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.lineBreakMode = .byWordWrapping
        text.numberOfLines = 0
        text.textAlignment = .left
        text.contentMode = .scaleAspectFit
        text.text = "6. На 90-й день соблюдения техники все лишнее из «прошлой жизни»перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.  "
        return text
    }()
    // лейбл с текстом 9
    private var textLabel8: UILabel = {
        var text = UILabel()
        text.font = UIFont(name: "SF Pro Text", size: 17)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.lineBreakMode = .byWordWrapping
        text.numberOfLines = 0
        text.textAlignment = .left
        text.contentMode = .scaleAspectFit
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

//   override func viewWillDisappear(_ animated: Bool) {
//       super.viewWillDisappear(animated)
//       AppUtility.lockOrientation(.all)
//   }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Информация"
        view.backgroundColor = UIColor(named:"White")
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(self.lineView)
        self.scrollView.addSubview(self.stackView)
        self.stackView.addSubview(self.textLabel)
        self.stackView.addSubview(self.textLabel1)
        self.stackView.addSubview(self.textLabel2)
        self.stackView.addSubview(self.textLabel3)
        self.stackView.addSubview(self.textLabel4)
        self.stackView.addSubview(self.textLabel5)
        self.stackView.addSubview(self.textLabel6)
        self.stackView.addSubview(self.textLabel7)
        self.stackView.addSubview(self.textLabel8)
        self.infoConstraint()
    }
    private func infoConstraint() {
        NSLayoutConstraint.activate([
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
        
        stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
        stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 8),
        stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
        stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
        stackView.heightAnchor.constraint(equalToConstant: 1000),
        stackView.widthAnchor.constraint(equalToConstant: 400),
        
        textLabel.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
        textLabel.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),
        textLabel.topAnchor.constraint(equalTo: self.stackView.topAnchor, constant: 8),
        
        
        textLabel1.topAnchor.constraint(equalTo: self.textLabel.bottomAnchor,constant: 12),
        textLabel1.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),
        textLabel1.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
        
        textLabel2.topAnchor.constraint(equalTo: self.textLabel1.bottomAnchor,constant: 8),
        textLabel2.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
        textLabel2.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),
        
        textLabel3.topAnchor.constraint(equalTo: self.textLabel2.bottomAnchor,constant: 8),
        textLabel3.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
        textLabel3.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),
        
        textLabel4.topAnchor.constraint(equalTo: self.textLabel3.bottomAnchor,constant: 8),
        textLabel4.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
        textLabel4.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),

        textLabel5.topAnchor.constraint(equalTo: self.textLabel4.bottomAnchor,constant: 8),
        textLabel5.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
        textLabel5.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),

        textLabel6.topAnchor.constraint(equalTo: self.textLabel5.bottomAnchor,constant: 8),
        textLabel6.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
        textLabel6.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),

        textLabel7.topAnchor.constraint(equalTo: self.textLabel6.bottomAnchor,constant: 8),
        textLabel7.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
        textLabel7.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),

        textLabel8.topAnchor.constraint(equalTo: self.textLabel7.bottomAnchor,constant: 8),
        textLabel8.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
        textLabel8.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),

        ])
    }
    
}

