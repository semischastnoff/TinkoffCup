import UIKit

public class TitleView: UIView {
    private var title: String?
    private var descriptionString: String?
    private var button: UIButton?
    private var icon: UIImage?
    
    private var containerView: UIView!
    private var headerLabel: UILabel!
    private var subHeaderLabel: UILabel!
    private var imageView: UIImageView!
    
    private var shadowLayer: CAShapeLayer!
    
    private var buttonWrapper: UIView!
    private var subHeaderWrapper: UIView!
    
    private var makeLayout: Bool!

    public override func layoutSubviews() {
        super.layoutSubviews()

        guard makeLayout else { return }
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 24).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor

            shadowLayer.shadowColor = UIColor.systemGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 5, height: 5)
            shadowLayer.shadowOpacity = 0.3
            shadowLayer.shadowRadius = 10

            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
    public init(title: String, description: String, icon: UIImage, button: UIButton? = nil, makeLayout: Bool = true) {
        self.title = title
        self.descriptionString = description
        self.button = button
        self.icon = icon
        self.makeLayout = makeLayout
        
        super.init(frame: .zero)
        
        setupUI()
    }
        
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupButton(button: button)
        setupIcon()
        setupHeaders()
    }
    
    private func setupButton(button: UIButton?) {
        buttonWrapper = UIView()
        buttonWrapper.translatesAutoresizingMaskIntoConstraints = false
        buttonWrapper.layer.cornerRadius = 10
        buttonWrapper.backgroundColor = .systemGray5
        
        addSubview(buttonWrapper)
        
        NSLayoutConstraint.activate([
            buttonWrapper.heightAnchor.constraint(equalToConstant: button != nil ? 20 : 0),
            buttonWrapper.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            buttonWrapper.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            buttonWrapper.widthAnchor.constraint(equalToConstant: button != nil ? 20 : 0)
        ])
        
        if let button = button {
            button.translatesAutoresizingMaskIntoConstraints = false
            
            buttonWrapper.addSubview(button)
            
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: buttonWrapper.topAnchor),
                button.leadingAnchor.constraint(equalTo: buttonWrapper.leadingAnchor),
                button.trailingAnchor.constraint(equalTo: buttonWrapper.trailingAnchor),
                button.bottomAnchor.constraint(equalTo: buttonWrapper.bottomAnchor),
            ])
        }
    }
    
    private func setupIcon() {
        imageView = UIImageView(image: icon)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFill
        imageView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
        ])
    }
    
    private func setupHeaders() {
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        setupSubHeader()
        setupHeader()
    }
    
    private func setupHeader() {
        headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.text = title
        headerLabel.font = .boldSystemFont(ofSize: 20)
    
        headerLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        containerView.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: subHeaderWrapper.topAnchor, constant: descriptionString != nil ? -24 : 0)
        ])
    }
    
    private func setupSubHeader() {
        subHeaderWrapper = UIView()
        subHeaderWrapper.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(subHeaderWrapper)
        
        NSLayoutConstraint.activate([
            subHeaderWrapper.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            subHeaderWrapper.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            subHeaderWrapper.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        
        subHeaderLabel = UILabel()
        subHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        subHeaderLabel.text = descriptionString
        subHeaderLabel.font = .systemFont(ofSize: 15, weight: .regular)
        subHeaderLabel.textColor = .systemGray
        
        containerView.addSubview(subHeaderLabel)
        
        NSLayoutConstraint.activate([
            subHeaderLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            subHeaderLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
}
