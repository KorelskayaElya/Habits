//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Эля Корельская on 14.11.2022.
//

import UIKit
/// коллекция - 0 ячейка  с прогрессом
class ProgressCollectionViewCell: UICollectionViewCell {
    // MARK: - UI
    /// поле прогресса
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
    /// надпись Все получится на ячейке
    private lazy var textLabel: UILabel = {
        let text = UILabel()
        text.text = "Всё получится!"
        text.font = UIFont(name: "SF Pro Text", size: 13)
        text.font = .systemFont(ofSize: 13, weight: .semibold)
        text.textColor = .systemGray
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    /// надпись процента прогресса
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
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        print(HabitsStore.shared.todayProgress, "прогресс")
        contentView.addSubview(progressView)
        contentView.addSubview(textLabel)
        contentView.addSubview(textLabel1)
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            progressView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            progressView.heightAnchor.constraint(equalToConstant: 6),
            
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            textLabel.widthAnchor.constraint(equalToConstant: 200),
            textLabel.heightAnchor.constraint(equalToConstant: 20),
            
            textLabel1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            textLabel1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            textLabel1.widthAnchor.constraint(equalToConstant: 44),
            textLabel1.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    required init? (coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Method
    /// устанавливает анимацию бегунка и процент прогресса
    func setupProgress(with progress: HabitsStore) {
        progressView.setProgress(HabitsStore.shared.todayProgress, animated: true)
        textLabel1.text = "\(Int(HabitsStore.shared.todayProgress*100))%"
    }

}
