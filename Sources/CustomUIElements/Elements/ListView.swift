import UIKit

public enum Axis {
    case vertical
    case horizontal
}

public class ListView: UIView {
    private var headerTitle: String?
    private var elements: [UIView]?
    private var button: UIButton?
    private var axis: Axis?
    
    
    private var containerView: UIView!
    private var headerLabel: UILabel!
    private var subHeaderLabel: UILabel!
    private var imageView: UIImageView!
    
    private var shadowLayer: CAShapeLayer!
    
    private var buttonWrapper: UIView!
    
    private var listView: UITableView!

    public override func layoutSubviews() {
        super.layoutSubviews()

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
    
    public init(elements: [UIView], axis: Axis, headerTitle: String, button: UIButton? = nil) {
        self.headerTitle = headerTitle
        self.elements = elements
        self.axis = axis
        self.button = button
        
        super.init(frame: .zero)
        
        setupUI()
    }
        
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupButton(button: button)
        setupHeaders()
        setupList()
    }
    
    private func setupList() {
        listView = UITableView()
        listView.translatesAutoresizingMaskIntoConstraints = false
        
        listView.dataSource = self
        listView.register(TitleCell.self, forCellReuseIdentifier: "MyCell")
        
        addSubview(listView)
        
        NSLayoutConstraint.activate([
            listView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20),
            listView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            listView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            listView.bottomAnchor.constraint(equalTo: buttonWrapper.topAnchor, constant: -20),
        ])
    }
    
    private func setupButton(button: UIButton?) {
        buttonWrapper = UIView()
        buttonWrapper.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(buttonWrapper)
        
        NSLayoutConstraint.activate([
            buttonWrapper.heightAnchor.constraint(equalToConstant: button != nil ? 60 : 0),
            buttonWrapper.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            buttonWrapper.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            buttonWrapper.bottomAnchor.constraint(equalTo: bottomAnchor, constant: button != nil ? -20 : 0),
        ])
        
        if let button = button {
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.cornerRadius = 10
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .systemGray6
            
            buttonWrapper.addSubview(button)
            
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: buttonWrapper.topAnchor),
                button.leadingAnchor.constraint(equalTo: buttonWrapper.leadingAnchor),
                button.trailingAnchor.constraint(equalTo: buttonWrapper.trailingAnchor),
                button.bottomAnchor.constraint(equalTo: buttonWrapper.bottomAnchor),
            ])
        }
    }
    
    private func setupHeaders() {
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        setupHeader()
        setupHeaderButton()
    }
    
    private func setupHeader() {
        headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.text = headerTitle
        headerLabel.font = .boldSystemFont(ofSize: 20)
    
        headerLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        containerView.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
//            headerLabel.trailingAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
    
    private func setupHeaderButton() {
        let button = UIButton()
        button.setTitle("Button", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: containerView.topAnchor),
            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
//            button.leadingAnchor.constraint(equalTo: headerLabel.trailingAnchor)
        ])
    }
}

extension ListView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(elements?.count ?? 0)
        return elements?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath) as! TitleCell
        
        cell.view = elements?[indexPath.row] ?? TitleView(title: "", description: "", icon: UIImage())
        
        return cell
    }
}
