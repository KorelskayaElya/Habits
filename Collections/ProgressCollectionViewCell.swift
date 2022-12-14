//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Эля Корельская on 14.11.2022.
//

import UIKit
// коллекция - первая ячейка  с прогрессом
class ProgressCollectionViewCell: UICollectionViewCell {
    // поле прогресса
    private lazy var progressView: UIProgressView = {
        let progress = UIProgressView()
        progress.progressViewStyle = .bar
        progress.setProgress(HabitsStore.shared.todayProgress, animated: true)
        progress.trackTintColor = UIColor.systemGray2
        progress.tintColor = UIColor(named:"Purple")
        progress.clipsToBounds = true
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.layer.cornerRadius = 3
        return progress
    }()
    // устанавливает анимацию бегунка и процент прогресса
    func setupProgress(with progress: HabitsStore) {
        self.progressView.setProgress(HabitsStore.shared.todayProgress, animated: true)
        self.textLabel1.text = "\(Int(HabitsStore.shared.todayProgress*100))%"
    }
    // надпись Все получится на ячейке
    private lazy var textLabel: UILabel = {
        let text = UILabel()
        text.text = "Всё получится!"
        text.font = UIFont(name: "SF Pro Text", size: 13)
        text.font = .systemFont(ofSize: 13, weight: .semibold)
        text.textColor = .systemGray
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    // надпись процента прогресса
    private lazy var textLabel1: UILabel = {
        let text = UILabel()
        text.text = "\(Int(HabitsStore.shared.todayProgress*100))%"
        text.font = UIFont(name: "SF Pro Text", size: 13)
        text.font = .systemFont(ofSize: 13, weight: .semibold)
        text.textColor = .systemGray
        text.textAlignment = .right
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        print(HabitsStore.shared.todayProgress, "прогресс")
        self.contentView.addSubview(self.progressView)
        self.contentView.addSubview(self.textLabel)
        self.contentView.addSubview(self.textLabel1)
        NSLayoutConstraint.activate([
            self.progressView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.progressView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            self.progressView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 40),
            self.progressView.heightAnchor.constraint(equalToConstant: 6),
            
            self.textLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.textLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.textLabel.widthAnchor.constraint(equalToConstant: 200),
            self.textLabel.heightAnchor.constraint(equalToConstant: 20),
            
            self.textLabel1.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
            self.textLabel1.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.textLabel1.widthAnchor.constraint(equalToConstant: 44),
            self.textLabel1.heightAnchor.constraint(equalToConstant: 20),
           ])
       }
    required init? (coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
