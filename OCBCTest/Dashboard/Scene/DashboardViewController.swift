//
//  DashboardViewController.swift
//  OCBCTest
//
//  Created by Rajesh on 26/3/22.
//

import UIKit
enum TableViewSection: Int {
    case balance, Transaction
}
class DashboardViewController: UIViewController, DashboardPresenterToViewProtocol {
    @IBOutlet weak var myTableView : UITableView?
    @IBOutlet weak var logOut : UIButton?
    var userName: String?
    lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.color = .white
        view.startAnimating()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var dashboardRequestModel: DashboardRequest?
    var presenter: DashboardPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        getBalance()
    }
    @objc func onLogOutButtonTap() {
        self.navigationController?.popToRootViewController(animated: false)
    }
    func setUpUI() {
        dashboardRequestModel = DashboardRequest(token: "")
        myTableView?.dataSource = self        
        let nib = UINib(nibName: "DashboardTableViewCell", bundle: nil)
        myTableView?.register(nib, forCellReuseIdentifier: "DashboardTableViewCell")        
        myTableView?.register(UINib(nibName: "TransactionTableViewCell", bundle: nil), forCellReuseIdentifier: "TransactionTableViewCell")
        logOut?.addTarget(self, action: #selector(onLogOutButtonTap), for: .touchUpInside)
        indicatorView.center = self.view.center
        self.view.addSubview(indicatorView)
        self.view.bringSubviewToFront(indicatorView)
    }
    init() {
        super.init(nibName: String(describing: DashboardViewController.self),
                   bundle: Bundle(for: DashboardViewController.self))
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    @objc func getBalance() {
        indicatorView.startAnimating()
        print("Dashboard Button Click")
        guard let model = self.dashboardRequestModel else { return }
        presenter?.getBalance(request: model)
        presenter?.getTransaction(request: model)
    }
    func reloadData() {
        DispatchQueue.main.async {
            self.indicatorView.stopAnimating()
            self.myTableView?.reloadData()
        }
    }
    func stopAnimating() {
        DispatchQueue.main.async {
            self.indicatorView.stopAnimating()
        }
    }
}

extension DashboardViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = TableViewSection(rawValue: section)
        switch section {
        case .balance:
            return 1
        case .Transaction:
            return presenter?.transactionModel?.data.count ?? 0
        case .none:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = TableViewSection(rawValue: indexPath.section)
        switch section {
        case .balance:
            guard let balanceViewCell = tableView.dequeueReusableCell(withIdentifier: "DashboardTableViewCell") as? DashboardTableViewCell else {
                fatalError("Can not create tableview cell")
            }
            if let model = presenter?.balanceModel {
                balanceViewCell.accountNumber.text = model.accountNo
                balanceViewCell.balance.text = "SGD " + String(describing: model.balance)
                balanceViewCell.name.text = userName ?? ""
            }
            return balanceViewCell
        case .Transaction:
            guard let transactionViewCell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell") as? TransactionTableViewCell else {
                fatalError("Can not create tableview cell")
            }
            if let model = presenter?.transactionModel?.data[indexPath.row] {
                if indexPath.row == 0 {
                    transactionViewCell.dateLabel.text = dateFormtor(date: model.transactionDate ?? "")
                } else {
                    transactionViewCell.dateLabel.isHidden = true
                }
                transactionViewCell.accountNumber.text = model.sender?.accountNo
                transactionViewCell.balance.text = String(describing: model.amount)
            }
            return transactionViewCell
        case .none:
            break
        }
               
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = TableViewSection(rawValue: section)
        switch section {
        case .balance:
            break
        case .Transaction:
            return "Your Transaction History"
        case .none:
            break
        }
        return nil
    }
}

extension DashboardViewController {
    func dateFormtor(date: String) -> String? {
        let dateFormator = DateFormatter()
        dateFormator.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let dateFromStr = dateFormator.date(from: date) else {return nil}
        dateFormator.dateFormat = "dd MMM yyyy"        
        return dateFormator.string(from: dateFromStr)
    }
}
