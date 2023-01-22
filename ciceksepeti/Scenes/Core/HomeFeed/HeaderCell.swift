//
//  HeaderCell.swift
//  ciceksepeti
//
//  Created by Emir Alkal on 23.01.2023.
//

import SnapKit
import UIKit

final class HeaderCell: UICollectionViewCell {
  static let identifier = "HeaderCell"

  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.backgroundColor = .orange
    imageView.layer.cornerRadius = imageView.frame.size.width / 2
    return imageView
  }()

  private let detailLabel: UILabel = {
    let label = UILabel()
    label.text = "Custom label"
    label.numberOfLines = 2
    label.font = .systemFont(ofSize: 11, weight: .light)
    label.textAlignment = .center
    return label
  }()

  override func prepareForReuse() {
    super.prepareForReuse()
    detailLabel.text = nil
    imageView.image = nil
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(imageView)
    addSubview(detailLabel)
    layout()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    imageView.layer.cornerRadius = imageView.frame.size.width / 2
  }

  func configure(with model: HeaderCellModel) {
    detailLabel.text = model.description
    imageView.image = UIImage(named: model.imageName)?.withRenderingMode(.alwaysOriginal)
  }

  private func layout() {
    imageView.snp.makeConstraints { make in
      make.leading.top.equalToSuperview().offset(4)
      make.trailing.equalToSuperview().offset(-4)
      make.height.equalTo(imageView.snp.width)
    }
    detailLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(4)
      make.trailing.equalToSuperview().offset(-4)
      make.top.equalTo(imageView.snp.bottom).offset(4)
    }
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
