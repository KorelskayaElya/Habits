//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Эля Корельская on 14.11.2022.
//

import UIKit
//protocol ProgressCollectionDelegate: AnyObject {
//    func addProgress(_ progress: HabitsStore)
//}
class ProgressCollectionViewCell: UICollectionViewCell {
    private lazy var progressView: UIProgressView = {
        let progress = UIProgressView()
        progress.progressViewStyle = .bar
        //менять
        //delegate?.addProgress(HabitsStore.shared.todayProgress)
        progress.setProgress(HabitsStore.shared.todayProgress, animated: true)
        progress.trackTintColor = UIColor.systemGray2
        progress.tintColor = UIColor(named:"Purple")
        progress.clipsToBounds = true
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.layer.cornerRadius = 3
        return progress
    }()
    
    private lazy var textLabel: UILabel = {
        let text = UILabel()
        text.text = "Всё получится!"
        text.font = UIFont(name: "SF Pro Display", size: 10)
        text.textColor = .systemGray
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    private lazy var textLabel1: UILabel = {
        let text = UILabel()
        text.text = "\(Int(HabitsStore.shared.todayProgress))%"
        text.font = UIFont(name: "SF Pro Display", size: 10)
        text.textColor = .systemGray
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
            self.progressView.widthAnchor.constraint(equalToConstant: 100),
            self.progressView.heightAnchor.constraint(equalToConstant: 6),
            
            self.textLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.textLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.textLabel.widthAnchor.constraint(equalToConstant: 200),
            self.textLabel.heightAnchor.constraint(equalToConstant: 20),
            
            self.textLabel1.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            self.textLabel1.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.textLabel1.widthAnchor.constraint(equalToConstant: 40),
            self.textLabel1.heightAnchor.constraint(equalToConstant: 20),
           ])
       }
    required init? (coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
