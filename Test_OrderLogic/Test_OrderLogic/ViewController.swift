//
//  ViewController.swift
//  Test_OrderLogic
//
//  Created by 박다미 on 2023/11/15.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class MenuViewController: UIViewController {
    private let disposeBag = DisposeBag()
    let viewModel = MenuListViewModel()
    let idenetifier = "MenuItemTableViewCell"

    //MARK: - properties
    private lazy var tableView: UITableView = {
        let tbView = UITableView()
        return tbView
    }()
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var itemCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        return label
    }()
    private lazy var totalPrice : UILabel = {
        let label = UILabel()
        label.text = "10000"
        return label
    }()
    private lazy var onClear : UIButton = {
        let btn = UIButton()
        btn.setTitle("clear", for: .normal)
        return btn
    }()
    
    private lazy var onOrder : UIButton = {
        let btn = UIButton()
        btn.setTitle("주문하기", for: .normal)
        btn.backgroundColor = .blue
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpaddSubView()
        
        tableView.register(MenuItemTableViewCell.self, forCellReuseIdentifier: idenetifier)

        viewModel.menuObservable
            .bind(to: tableView.rx.items(cellIdentifier: idenetifier , cellType: MenuItemTableViewCell.self)){ index,item,cell in
                cell.title.text = item.name
                cell.price.text = "\(item.price)"
                cell.count.text = "\(item.count)"
                print(item.name)
            }
            .disposed(by: disposeBag)
        
        //개수
        viewModel.itemsCount
            .map { "\($0)" }
            .observe(on: MainScheduler.instance)
            .bind(to: itemCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        //총가격
        viewModel.totalPrice
            .map { "\($0)" }
        
            .observe(on: MainScheduler.instance)
            .bind(to: totalPrice.rx.text)
            .disposed(by: disposeBag)
    }
    
    //MARK: - addSubViews
    func setUpaddSubView(){
        view.addSubview(tableView)
        view.addSubview(bottomView)
        bottomView.addSubview(itemCountLabel)
        bottomView.addSubview(totalPrice)
        bottomView.addSubview(onClear)
        
        view.addSubview(onOrder)
        setUpConstraints()
    }
    
    //MARK: - Constraints
    func setUpConstraints(){
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
        bottomView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(100)
        }
        itemCountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        totalPrice.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        onClear.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        onOrder.snp.makeConstraints { make in
            make.top.equalTo(bottomView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        
        //버튼 클릭
        onClear.rx.tap
            .subscribe(onNext: { [weak self] in
                
                self?.viewModel.clearAllItemSelections()
                // 클리어 버튼을 눌렀을 때 수행할 동작
                print("동작")
                
            })
      
        onOrder.rx.tap
            .subscribe(onNext:{[weak self] in
                self?.viewModel.menuObservable.onNext([
                    Menu(id: 0, name: "튀김1", price: 100, count: Int.random(in: 0...10)),
                    Menu(id: 1, name: "튀김2", price: 100, count: Int.random(in: 0...10)),
                    Menu(id: 2, name: "튀김3", price: 100, count: Int.random(in: 0...10)),
                    Menu(id: 3, name: "튀김4", price: 100, count: Int.random(in: 0...10)),
                    Menu(id: 4, name: "튀김5", price: 100, count: Int.random(in: 0...10))
                ])
                print("동작")
                
                
            })
            .disposed(by: disposeBag)
    }
    
    
    
    
    
    
}

class MenuListViewModel{
    //메뉴
    lazy var menuObservable = BehaviorSubject<[Menu]>(value: [])
    
    //개수, 가격, 총가격(개수 * 가격)
    lazy var itemsCount = menuObservable.map{
        $0.map { $0.count }.reduce(0, +)
    }
    lazy var totalPrice = menuObservable.map{
        $0.map { $0.count * $0.price }.reduce(0, +)
    }
    /*
     func clearAllItemSelections(){
         _ = menuObservable
             .map { menus in
                 menus.map { m in
                     Menu(id: m.id, name: m.name, price: m.price, count: 0)
                 }
             }
             .take(1)
             .subscribe(onNext: {
                 self.menuObservable.onNext($0)
             })
     }
     */
    init(){
        let menus: [Menu] = [
            Menu(id: 0, name: "튀김1", price: 100, count: 0),
            Menu(id: 1, name: "튀김2", price: 100, count: 0),
            Menu(id: 2, name: "튀김3", price: 100, count: 0),
            Menu(id: 3, name: "튀김4", price: 100, count: 0),
            Menu(id: 4, name: "튀김5", price: 100, count: 0)
        ]
        menuObservable.onNext(menus)
    }
    func clearAllItemSelections(){
        _ = menuObservable
            .map{ menus in
                menus.map { m in
                    Menu(id: m.id, name: m.name, price: m.price, count: 0)
                }
            }.take(1)
            .subscribe(onNext:{
                self.menuObservable.onNext($0)
            })
    }
    
}
class MenuItemTableViewCell : UITableViewCell{
    
    private let disposeBag = DisposeBag()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = .black

        return label
    }()
        
    lazy var count: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    lazy var price: UILabel = {
        let label = UILabel()
        label.textColor = .black

        return label
    }()
    
    // 새로운 버튼들
    private lazy var increaseButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("+", for: .normal)
        btn.setTitleColor(.black, for: .normal)

        return btn
    }()
    
    private lazy var decreaseButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("-", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)

        
        contentView.addSubview(increaseButton)
        contentView.addSubview(decreaseButton)
        contentView.addSubview(title)
        contentView.addSubview(count)
        contentView.addSubview(price)
        
        increaseButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        decreaseButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(increaseButton.snp.trailing).offset(20)
            
        }
        title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(decreaseButton.snp.trailing).offset(20)
            
        }
        count.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(title.snp.trailing).offset(20)
            
        }
        price.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
        }
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

 var onChange :((Int) -> Void)?
    
    func configureCell() {
        increaseButton.rx.tap
            .subscribe(onNext: {[weak self] _ in
                self?.onChange?(+1)
            })
            .disposed(by: disposeBag)
        
        decreaseButton.rx.tap
            .subscribe(onNext: {[weak self] _ in
                self?.onChange?(-1)
            }).disposed(by: disposeBag)
    }
    
}

struct Menu {
    var id: Int
    var name: String
    var price: Int
    var count: Int
}
