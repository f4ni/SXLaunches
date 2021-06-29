//
//  ViewController.swift
//  SXLaunches
//
//  Created by fârûqî on 26.06.2021.
//

import Kingfisher
import AlertsAndPickers

class ViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    fileprivate var tableCellId = "tableCellID"
 
    var launchesFiltered = Launches(){
        didSet{
            tableView.reloadData()
            tableView.endUpdates()
        }
    }
    var launches = Launches(){
        didSet{
        }
    }
 
    let years = ["ALL", "2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        navigationItem.title = "SXLaunches"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(openPicker))
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: tableCellId)
        
        fetchData()
    }
    
    func fetchData(){
        APIService.instance.fetchData(model: Launches.self) { result in
           switch result {
           case .success(let data):
               if let lnch = data as? Launches {

                   self.launches = lnch
                   self.launchesFiltered = lnch

               }
               
           case .failure(_):
               print("filure")
               break
           }
       }
    }
    
    lazy var yearPicker: UIAlertController = {
        let p = UIAlertController(title: "Year", message: "Pick a year to filter launches", preferredStyle: .alert)
        p.addPickerView(values: [self.years], initialSelection: .none) { vc, picker, index, values in
            DispatchQueue.main.async {
                print(index)
                if (index.row == 0){
                    self.launchesFiltered = self.launches
                }
                else {
                    self.launchesFiltered = self.launches.filter { $0.launchYear == self.years[index.row] }
                }
            }
        }
        p.addAction(image: nil, title: "Done", color: nil, style: .cancel, isEnabled: true) { action in
       
        }
        return p
    }()
    
    let picker: UIPickerView = {
        let v = UIPickerView()
        
        return v
    }()
    
    @objc func openPicker() {
    //    let picker
        yearPicker.show()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launchesFiltered.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellId, for: indexPath) as! TableViewCell
        let launch = launchesFiltered[indexPath.row]
        cell.launch = launch
        return cell
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return years.count
    }
   
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return years[row]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let launch = launchesFiltered[indexPath.row]
        
        let vc = DetailViewController()
        vc.launch = launch
        showDetailViewController(vc, sender: nil)
    }
}

