//
//  Utils.swift
//  Weather
//
//  Created by Nik on 20.12.2020.
//

import UIKit

class Utils {
    static func system(_ name: String, pointSize: CGFloat, weight: UIImage.SymbolWeight) -> UIImage? {
        let config = UIImage.SymbolConfiguration(pointSize: pointSize, weight: weight)
        return UIImage(systemName: name, withConfiguration: config)
    }
    
    static func systemButton(_ systemImage: String) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let image = system(systemImage, pointSize: 16, weight: .bold)

        button.setImage(image, for: .normal)

        button.backgroundColor = #colorLiteral(red:0.9372549019, green: 0.9372549019, blue: 0.9568627450, alpha: 1)
        button.layer.cornerRadius = button.frame.width / 2
        button.applyNavBarConstraints()

        return button
    }
}

extension UIView {
    func applyNavBarConstraints( _ title: String? = nil) {
        let widthConstraint = self.widthAnchor.constraint(equalToConstant: title == nil ? 30 : 100)
        let heightConstraint = self.heightAnchor.constraint(equalToConstant: 30)
        heightConstraint.isActive = true
        widthConstraint.isActive = true
    }
}

extension UIButton {
    func startAnimatingPressActions() {
        addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }

    @objc private func animateDown(sender: UIButton) {
        animate(sender, transform: CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95))
    }

    @objc private func animateUp(sender: UIButton) {
        animate(sender, transform: .identity)
    }

    private func animate(_ button: UIButton, transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut],
                       animations: {
                        button.transform = transform
            }, completion: nil)
    }

    func setImage(image: UIImage?, inFrame frame: CGRect?, forState state: UIControl.State) {
        self.setImage(image, for: state)

        if let frame = frame {
            self.imageEdgeInsets = UIEdgeInsets(
                top: frame.minY - self.frame.minY,
                left: frame.minX - self.frame.minX,
                bottom: self.frame.maxY - frame.maxY,
                right: self.frame.maxX - frame.maxX
            )
        }
    }
}

extension UINavigationItem {
    func setTitle(_ titleText: String, _ subTitleText: String) {
        let title = UILabel()
        title.text = titleText
        title.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        title.sizeToFit()
        
        let subTitle = UILabel()
        subTitle.text = subTitleText
        subTitle.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        subTitle.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        subTitle.textAlignment = .center
        subTitle.sizeToFit()

        let stackView = UIStackView(arrangedSubviews: [title, subTitle])
        stackView.distribution = .equalCentering
        stackView.axis = .vertical
        stackView.alignment = .center
        
        let width = max(title.frame.size.width, subTitle.frame.size.width)
        stackView.frame = CGRect(x: 0, y: 0, width: width, height: 35)
        
        title.sizeToFit()
        subTitle.sizeToFit()
        
        self.titleView = stackView
    }
}
