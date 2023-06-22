//
//  MainViewController.swift
//  CryptoCurrencyApp
//
//  Created by IT-EFW-65-03 on 21/6/2566 BE.
//  Copyright (c) 2566 BE ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import RxSwift
import RxCocoa

protocol MainDisplayLogic: AnyObject
{
    func displaySomething(viewModel: Main.CryptoCurrency.ViewModel)
}

class MainViewController: UIViewController, MainDisplayLogic
{
    private let bag = DisposeBag()
    
    var interactor: MainBusinessLogic?
    var router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)?
    
    let item = BehaviorSubject<[Display?]>(value: [])
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        startView()
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lb_usd: UILabel!
    @IBOutlet weak var lb_gbp: UILabel!
    @IBOutlet weak var lb_eur: UILabel!
    @IBOutlet weak var lb_rate: UILabel!
    @IBOutlet weak var lb_desc: UILabel!
    @IBOutlet weak var lb_value: UILabel!
    @IBOutlet weak var tf_value: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var view_usd: UIView!
    @IBOutlet weak var view_gbp: UIView!
    @IBOutlet weak var view_eur: UIView!
    @IBOutlet weak var lb_convert: UILabel!
    
    func startView()
    {
        setupView()
        bindTableView()
        interactor?.setup()
        interactor?.fetchData()
    }
    
    private func bindTableView() {
        tableView.rx.setDelegate(self).disposed(by: bag)
        
        item.bind(to: tableView.rx.items(cellIdentifier: "CurrencyCell", cellType: CurrencyCell.self)) { (row,item,cell) in
            cell.configureCell(item)
            //self.scrollToBottom()
        }.disposed(by: bag)
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            guard let sections = try? self.item.value() else { return }
            let indexPath = IndexPath(row: sections.count-1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func setupView() {
        _ = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { (timer) in
            self.interactor?.fetchData()
        }
        
        view_usd.tag = 1
        view_gbp.tag = 2
        view_eur.tag = 3
        
        let tap_view_usd = UITapGestureRecognizer(target: self, action: #selector(self.tapCurrency(_:)))
        self.view_usd.addGestureRecognizer(tap_view_usd)
        
        let tap_view_gbp = UITapGestureRecognizer(target: self, action: #selector(self.tapCurrency(_:)))
        self.view_gbp.addGestureRecognizer(tap_view_gbp)
        
        let tap_view_eur = UITapGestureRecognizer(target: self, action: #selector(self.tapCurrency(_:)))
        self.view_eur.addGestureRecognizer(tap_view_eur)
        
        view_usd.backgroundColor = .green
        
        self.tf_value.rx.controlEvent(.editingChanged).subscribe(onNext: { [unowned self] in
            if let text = self.tf_value.text {
                let digits = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

                let value: String = self.interactor?.exchangeValue(digits) ?? "-"
                
                self.lb_value.text = value
                self.tf_value.text = digits
            }
        }).disposed(by: bag)
        
        tf_value.rx.text.orEmpty
            .scan("") { (previous, new) -> String in
                let digits = new.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                let result = digits.range(of: "^[0-9]{10}$", options:.regularExpression)
                                
                if (result == nil) && digits.count >= 13 {
                    return previous ?? String(new.prefix(13))
                } else {
                    return new
                }
            }
            .subscribe(tf_value.rx.text)
            .disposed(by: bag)
        
        let tapParent = UITapGestureRecognizer(target: self, action: #selector(self.tapView(_:)))
        self.view.addGestureRecognizer(tapParent)
    }
    
    func displaySomething(viewModel: Main.CryptoCurrency.ViewModel)
    {
        lb_usd.text = viewModel.item?.bpi.usd.code
        lb_gbp.text = viewModel.item?.bpi.gbp.code
        lb_eur.text = viewModel.item?.bpi.eur.code
        
        lb_rate.text = String(format: "Rate : %@ %@", viewModel.currencyItem?.rate ?? "", viewModel.currencyItem?.symbol ?? "").convertSymbols()
        lb_desc.text = String(format: "Description : %@", viewModel.currencyItem?.description ?? "")
        lb_convert.text = String(format: "Convert : %@ to BTC", viewModel.currencyItem?.code ?? "")
        
        item.onNext(viewModel.displayList.reversed())
    }
    
    //MARK: - Action
    
    @objc func tapCurrency(_ sender: UITapGestureRecognizer? = nil) {
        self.tf_value.resignFirstResponder()
        self.tf_value.text = ""
        self.lb_value.text = "0"
        
        var currency = Currency.USD
        clearBG()
        switch sender?.view?.tag {
        case 1 :
            view_usd.backgroundColor = .green
            currency = .USD
            break
        case 2 :
            view_gbp.backgroundColor = .green
            currency = .GBP
            break
        case 3 :
            view_eur.backgroundColor = .green
            currency = .EUR
            break
        case .none:
            return
        case .some(_):
            return
        }
        
        self.interactor?.changeTab(currency)
    }
    
    @objc func tapView(_ sender: UITapGestureRecognizer? = nil) {
        self.tf_value.resignFirstResponder()
    }
    
    func clearBG() {
        view_usd.backgroundColor = .white
        view_gbp.backgroundColor = .white
        view_eur.backgroundColor = .white
    }
}


extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard (try? self.item.value()) != nil else { return }
        cell.contentView.backgroundColor = .white
        
        if indexPath.row == 0 {
            cell.contentView.backgroundColor = .green
        }
    }
}
