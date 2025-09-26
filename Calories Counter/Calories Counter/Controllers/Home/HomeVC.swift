import UIKit
import MKColorPicker
import MKMagneticProgress


class DateCell: UICollectionViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var seletedView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        seletedView.layer.cornerRadius = 20   // rounded background
        seletedView.clipsToBounds = true
        
        // ✅ ensure seletedView stays behind labels
        contentView.sendSubviewToBack(seletedView)
    }
    
    func configure(with model: DayModel) {
        dayLabel.text = model.day
        dateLabel.text = "\(model.date)"
        
        if model.isSelected {
            seletedView.backgroundColor = UIColor(hex: "#FFE98B")
            dayLabel.textColor = .black
            dateLabel.backgroundColor = .black
            dateLabel.textColor = .white
        } else {
            seletedView.backgroundColor = .clear
            dayLabel.textColor = .darkGray
            dateLabel.backgroundColor = .white   // still circle
            dateLabel.textColor = .black
        }
    }

}

class HomeVC: UIViewController {
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var consumeView: UIView!
    @IBOutlet weak var magProgress: MKMagneticProgress!
    @IBOutlet weak var kcalLabel: UILabel!
    @IBOutlet weak var maxGoalLbl: UILabel!

    @IBOutlet weak var breakfastView: UIView!
    @IBOutlet weak var lunchView: UIView!
    @IBOutlet weak var snacksView: UIView!
    @IBOutlet weak var dinnerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewAll: UIView!
    
    private let viewModel = HomeViewModel()
    private let remainingLabel = UILabel()
    private let goalLabel = UILabel()
    
    var consumedCalories: CGFloat = 1254
    var goalCalories: CGFloat = 2500
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupBindings()
        viewModel.generateDays(for: Date())
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dateViewTapped(_:)))
        dateView.addGestureRecognizer(tap)
        dateView.isUserInteractionEnabled = true
        loadProgressViewData()
        profileNav()
        UserDefaults.standard.set("breakfast", forKey: DefaultKeys.shared.mealType)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        HelperFun.shared.makeCircular(views: [profileView])
        dateView.layer.cornerRadius = 20.0
        consumeView.layer.cornerRadius = 15.0
        [breakfastView, lunchView, snacksView, dinnerView].viewsCornerRadius(15)
        HelperFun.shared.selectView(from: [self.breakfastView, self.lunchView, self.snacksView, self.dinnerView], selectedView: self.breakfastView, selectedHexColor: "#FFFCEE", cornerRadius: 15.0)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    @IBAction func camBtn(_ sender: UIButton) {
        print("cam click")
        let vc = storyboard?.instantiateViewController(withIdentifier: "CamVC") as! CamVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    
    func loadProgressViewData(){
        // Progress setup
        magProgress.lineWidth = 20
        magProgress.progressShapeColor = UIColor.systemYellow
        magProgress.backgroundShapeColor = UIColor.systemYellow.withAlphaComponent(0.2)
        magProgress.percentLabelFormat = ""  // hide built-in % text
        
        // Add labels
        setupLabels()
        updateUI()
    }
    
    private func setupLabels() {
       
        // Remaining text
        remainingLabel.text = "Remaining"
        remainingLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        remainingLabel.textColor = .gray
        remainingLabel.textAlignment = .center
        view.addSubview(remainingLabel)
        
        // Goal
        goalLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        goalLabel.textColor = .darkGray
        goalLabel.textAlignment = .center
        view.addSubview(goalLabel)
    }
    
    private func updateUI() {
        // progress ratio
        let progress = consumedCalories / goalCalories
        magProgress.setProgress(progress: progress, animated: true)
        
        // set text
        kcalLabel.text = "\(Int(consumedCalories)) kcal"
        maxGoalLbl.text = "Goal: \(Int(goalCalories)) kcal"
    }
    
    private func setupBindings() {
        viewModel.onDaysUpdated = { [weak self] in
            self?.collectionView.reloadData()
            
            if let todayIndex = self?.viewModel.days.firstIndex(where: { $0.isToday }) {
                let indexPath = IndexPath(item: todayIndex, section: 0)
                DispatchQueue.main.async {
                    self?.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
                }
            }
        }
        
        viewModel.onMonthUpdated = { [weak self] monthName in
            self?.monthLabel.text = monthName
        }
    }
    
    @objc func dateViewTapped(_ sender: UITapGestureRecognizer) {
        let months = viewModel.getMonthsList()
        let alert = UIAlertController(title: "Select Month", message: nil, preferredStyle: .actionSheet)
        
        for (index, month) in months.enumerated() {
            alert.addAction(UIAlertAction(title: month, style: .default, handler: { _ in
                self.viewModel.updateMonth(to: index)
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    func profileNav() {
        [profileView, viewAll, breakfastView, lunchView, snacksView, dinnerView].addTapGesture { index, tappedView in
            switch index {
            case 0:
                print("👉 Next View tapped")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false)
            case 1:
                print("view all")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyMealsVC") as! MyMealsVC
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false)
                
            case 2:
                print("breakfast")
                UserDefaults.standard.set("breakfast", forKey: DefaultKeys.shared.mealType)
                HelperFun.shared.selectView(from: [self.breakfastView, self.lunchView, self.snacksView, self.dinnerView], selectedView: self.breakfastView, selectedHexColor: "#FFFCEE", cornerRadius: 15.0)
            case 3:
                print("lunch")
                UserDefaults.standard.set("lunch", forKey: DefaultKeys.shared.mealType)
                HelperFun.shared.selectView(from: [self.breakfastView, self.lunchView, self.snacksView, self.dinnerView], selectedView: self.lunchView, selectedHexColor: "#FFFCEE", cornerRadius: 15.0)
            case 4:
                print("snacks")
                UserDefaults.standard.set("snacks", forKey: DefaultKeys.shared.mealType)
                HelperFun.shared.selectView(from: [self.breakfastView, self.lunchView, self.snacksView, self.dinnerView], selectedView: self.snacksView, selectedHexColor: "#FFFCEE", cornerRadius: 15.0)
            case 5:
                print("Dinners")
                UserDefaults.standard.set("Dinners", forKey: DefaultKeys.shared.mealType)
                HelperFun.shared.selectView(from: [self.breakfastView, self.lunchView, self.snacksView, self.dinnerView], selectedView: self.dinnerView, selectedHexColor: "#FFFCEE", cornerRadius: 15.0)
                
            default:
                print("Unknown View tapped")
            }
            
            UserDefaults.standard.synchronize()
        }
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath) as! DateCell
        cell.dateLabel.clipsToBounds = true
        cell.dateLabel.layer.cornerRadius = cell.dateLabel.frame.size.width / 2
        let model = viewModel.days[indexPath.item]
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectDay(at: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 70)
    }
}

