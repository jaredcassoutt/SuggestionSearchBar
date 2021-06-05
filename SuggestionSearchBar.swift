import UIKit

class SuggestionSearchBar: UISearchBar, UISearchBarDelegate {
    
    var suggestionTableView = UITableView(frame: .zero)
    let allPossibilities: [String]!
    var possibilities = [String]()
    var clickAction: ()->Void
    
    init(del: UISearchBarDelegate, suggestionsListContainer: UIStackView, dropDownPossibilities: [String], clickAction: @escaping ()->Void) {
        self.clickAction = clickAction
        self.allPossibilities = dropDownPossibilities
        super.init(frame: .zero)
        isUserInteractionEnabled = true
        delegate = del
        searchTextField.addTarget(self, action: #selector(searchBar(_:)), for: .editingChanged)
        searchTextField.addTarget(self, action: #selector(searchBarCancelButtonClicked(_:)), for: .editingDidEnd)
        sizeToFit()
        addTableView(in: suggestionsListContainer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addTableView(in container: UIStackView) {
        let cellHeight = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "").frame.height
        suggestionTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        suggestionTableView.backgroundColor = UIColor.clear
        suggestionTableView.tableFooterView = UIView()
        container.layer.zPosition=1001
        
        container.addArrangedSubview(suggestionTableView)
        suggestionTableView.layer.zPosition=1001
        suggestionTableView.delegate = self
        suggestionTableView.dataSource = self
        suggestionTableView.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            suggestionTableView.heightAnchor.constraint(equalToConstant: cellHeight*6),
        ])
        hideSuggestions()
    }
    
    func showSuggestions() {
        let sv = suggestionTableView.superview
        sv?.clipsToBounds = false
        suggestionTableView.isHidden = false
    }
    
    func hideSuggestions() {
        suggestionTableView.isHidden = true
    }
    
    @objc func searchBar(_ searchBar: UISearchBar) {
        print(searchBar.text?.uppercased() ?? "")
        showSuggestions()
        possibilities = allPossibilities.filter {$0.contains(searchBar.text?.uppercased() ?? "")}
        print(possibilities.count)
        suggestionTableView.reloadData()
        if searchBar.text == "" || possibilities.count == 0 {
            hideSuggestions()
        }
    }
    
    @objc func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideSuggestions()
    }
}

extension SuggestionSearchBar: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return possibilities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = suggestionTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 0.75)
        if traitCollection.userInterfaceStyle == .light {
            cell.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)
        }
        cell.textLabel?.text = possibilities[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //add method that fills in and searches based on the text in that indexpath.row
        print("selected")
        Constants.DataPassing.cellClicked = indexPath.row
        clickAction()
    }
    
}
