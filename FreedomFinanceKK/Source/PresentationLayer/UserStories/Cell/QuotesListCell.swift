//
//  QuotesListCell.swift
//  FreedomFinanceKK
//
//  Created by Кожевников Константин on 21.04.2024.
//

import SnapKit
import UIKit

final class QuotesListCell: UITableViewCell {

    // MARK: - Public Property

    static var identifier: String { Self.description() }

    var viewModel: QuotesListCellViewModel = .initial {
        didSet {
            updateViewModel(oldValue, viewModel)
        }
    }

    // MARK: - UI

    private lazy var  quoteImageAndTextView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = Constants.stackViewSpacing
        return view
    }()

    private lazy var  quoteImageView: LoadableImageView = {
        let imageView = LoadableImageView()
        imageView.image = UIImage(systemName: "dollarsign.arrow.circlepath")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var shortNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.titleFontSize)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()

    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize:  Constants.subtitleFontSize)
        label.textAlignment = .left
        label.textColor = .systemGray2
        return label
    }()

    private lazy var priceContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = Constants.containerViewCornerRadius
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var percentChangeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize:  Constants.titleFontSize)
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()

    private lazy var priceChangeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize:  Constants.subtitleFontSize)
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()

    private lazy var chevronImageView: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "chevron.right"))
        view.tintColor = .systemGray
        return view
    }()

    override func prepareForReuse() {
        super.prepareForReuse()
        quoteImageView.image = nil
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QuotesListCell {
    func updateViewModel(_ oldValue: QuotesListCellViewModel, _ newValue: QuotesListCellViewModel) {
        shortNameLabel.text = newValue.ticker
        fullNameLabel.text = "\(newValue.exchange) | \(newValue.securityName)"
        percentChangeLabel.text = String(format: "%.3f%%", newValue.percentChange)
        checkDifferenceForPercentChangeLabel(newValue.percentChange)
        priceChangeLabel.text = "\(newValue.lastTradePrice) (\(newValue.priceChange ?? .zero))"
        quoteImageView.url = newValue.imageURL
        quoteImageView.isHidden = newValue.imageURL == nil
        updateContainerConstraints()
    }

    private func updateContainerConstraints() {
        percentChangeLabel.sizeToFit()
        priceContainerView.snp.updateConstraints {
            $0.width.equalTo(percentChangeLabel.frame.width + Constants.containerWidthAdditionalSpaceSize)
        }
    }
}

// MARK: - Constraints

private extension QuotesListCell {
    func setupLayout() {
        configureBackgroundImageViewConstraints()
        configureCoinImageViewConstraints()
        configureShortNameLabelConstraints()
        configureFullNameLabelConstraints()
        configureChevronImageViewConstraints()
        configurePriceLabelConstraints()
        configurePercentLabelConstraints()
    }

    func configureBackgroundImageViewConstraints() {
        contentView.addSubview(quoteImageAndTextView)
        quoteImageAndTextView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(Constants.imageLeadingOffset)
        }
    }

    func configureCoinImageViewConstraints() {
        quoteImageAndTextView.addArrangedSubview(quoteImageView)
        quoteImageView.snp.makeConstraints { $0.width.height.equalTo(Constants.imageViewSize) }
    }

    func configureShortNameLabelConstraints() {
        quoteImageAndTextView.addArrangedSubview(shortNameLabel)
    }

    func configureFullNameLabelConstraints() {
        contentView.addSubview(fullNameLabel)
        fullNameLabel.snp.makeConstraints {
            $0.top.equalTo(shortNameLabel.snp.bottom)
            $0.leading.equalToSuperview().offset(Constants.imageLeadingOffset)
            $0.height.equalTo(Constants.fullNameHeight)
        }
    }

    func configurePriceLabelConstraints() {
        contentView.addSubview(priceContainerView)
        priceContainerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.containerViewTopInset)
            $0.trailing.equalTo(chevronImageView.snp.leading).offset(-Constants.containerViewTrailingOffset)
            $0.height.equalTo(Constants.shortNameHeight)
            $0.width.equalTo(Constants.containerViewInitialWidth)
        }

        priceContainerView.addSubview(percentChangeLabel)
        percentChangeLabel.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview().inset(Constants.percentChangeLabelEdgesInset)
        }
    }

    func configureChevronImageViewConstraints() {
        contentView.addSubview(chevronImageView)
        chevronImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Constants.chevronImageViewTrailingInset)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(Constants.chevronImageViewWidth)
            $0.height.equalTo(Constants.chevronImageViewHeight)
        }
    }

    func configurePercentLabelConstraints() {
        contentView.addSubview(priceChangeLabel)
        priceChangeLabel.snp.makeConstraints {
            $0.top.equalTo(shortNameLabel.snp.bottom).offset(Constants.priceChangeLabelTopOffset)
            $0.leading.equalTo(shortNameLabel.snp.trailing)
            $0.trailing.equalTo(chevronImageView.snp.leading).offset(-Constants.priceChangeLabelTrailingOffset)
            $0.height.equalTo(Constants.fullNameHeight)
        }
    }
}

// MARK: - Constants

private extension QuotesListCell {
    enum Constants {
        static let containerViewCornerRadius: CGFloat = 8
        static let containerViewTopInset: CGFloat = 2
        static let containerViewInitialWidth: CGFloat = 40
        static let containerViewTrailingOffset: CGFloat = 8
        static let stackViewSpacing: CGFloat = 6
        static let percentChangeLabelEdgesInset: CGFloat = 4
        static let chevronImageViewTrailingInset: CGFloat = 8
        static let chevronImageViewWidth: CGFloat = 8
        static let chevronImageViewHeight: CGFloat = 12
        static let priceChangeLabelTopOffset: CGFloat = 4
        static let priceChangeLabelTrailingOffset: CGFloat = 8
        static let currencyImageSize = 16
        static let containerWidthAdditionalSpaceSize: CGFloat = 8
        static let imageViewSize = 24
        static let titleFontSize: CGFloat = 16
        static let subtitleFontSize: CGFloat = 12
        static let topBottomInset = 5
        static let imageLeadingOffset = 20
        static let pricePercentTrailingOffset = 20
        static let nameOffset = 5
        static let shortNameWidth = 76
        static let shortNameHeight = 25
        static let fullNameHeight = 15
        static let fullnameWidth = 100
    }
}

// MARK: - Utils

private extension QuotesListCell {
    func getRequiredColor(_ change: Double) -> UIColor {
        let color: UIColor
        switch change {
        case let value where value < .zero:
            color = .red
        case let value where value > .zero:
            color = .systemGreen
        default:
            color = .clear
        }
        return color
    }

    private func checkDifferenceForPercentChangeLabel(_ percent: Double) {
        let color: UIColor
        let formattedPercent: String

        switch percent {
        case let value where value < .zero:
            color = .red
            formattedPercent = String(format: "%.3f%%", percent)
        case let value where value > .zero:
            color = .systemGreen
            formattedPercent = String(format: "+%.3f%%", percent)
        default:
            color = .black
            formattedPercent = String(format: "%.3f%%", percent)
        }

        percentChangeLabel.text = formattedPercent
        percentChangeLabel.textColor = color
    }
}
