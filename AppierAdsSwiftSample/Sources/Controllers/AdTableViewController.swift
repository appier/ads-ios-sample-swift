import UIKit

class AdTableViewController: UIViewController {
    private static let cellId = "AdTableCell"
    private static let headerHeight: CGFloat = 120

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var versionLabel: UILabel!

    var dataSource: [AdDataSource] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Self.cellId)
        tableView.delegate = self
        tableView.dataSource = self

        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = .zero
        }
    }
}

extension AdTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellId, for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.section].cells[indexPath.row].title
        return cell
    }
}

extension AdTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Self.headerHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let views = Bundle.main.loadNibNamed(String(describing: AdTableHeaderView.self), owner: nil, options: nil),
           let headerView = views.first as? AdTableHeaderView {
            headerView.titleLabel.text = dataSource[section].header.title
            headerView.illustrationImageView.image = dataSource[section].header.image

            return headerView
        }

        return .none
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var controller: UIViewController!
        let ctrCls = dataSource[indexPath.section].cells[indexPath.row].ctrCls
        if ctrCls.isSubclass(of: BaseNativeAdViewController.self) {
            controller = ctrCls.init(nibName: String(describing: BaseNativeAdViewController.self), bundle: nil)
        } else {
            controller = ctrCls.init()
        }
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(controller, animated: true)
    }
}
