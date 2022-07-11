import PocketCastsServer
import UIKit

class ConfirmPaymentViewController: UIViewController {
    @IBOutlet var profileProgressView: ProfileProgressCircleView! {
        didSet {
            profileProgressView.isSubscribed = true
            profileProgressView.secondsTillExpiry = Constants.Limits.maxSubscriptionExpirySeconds
            profileProgressView.style = .primaryUi06
        }
    }
    
    @IBOutlet var emailLabel: ThemeableLabel!
    @IBOutlet var accountTypeLabel: ThemeableLabel! {
        didSet {
            accountTypeLabel.style = .primaryText02
        }
    }
    
    @IBOutlet var priceLabel: ThemeableLabel!
    @IBOutlet var renewLabel: ThemeableLabel! {
        didSet {
            renewLabel.style = .primaryText02
        }
    }
    
    @IBOutlet var buyButton: ThemeableRoundedButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var borderView: ThemeableSelectionView! {
        didSet {
            borderView.style = .primaryUi06
            borderView.isSelected = false
        }
    }
    
    @IBOutlet var paymentFailedImageView: ThemeableImageView! {
        didSet {
            paymentFailedImageView.imageNameFunc = AppTheme.paymentFailedImageName
        }
    }
    
    @IBOutlet var failedDetailLabel: ThemeableLabel! {
        didSet {
            failedDetailLabel.style = .primaryText02
        }
    }
    
    @IBOutlet var cancelledLabel: ThemeableLabel! {
        didSet {
            cancelledLabel.style = .support05
            cancelledLabel.isHidden = true
        }
    }
    
    @IBOutlet var tryAgainView: ThemeableView!
    var newSubscription: NewSubscription
    
    init(newSubscription: NewSubscription) {
        self.newSubscription = newSubscription
        super.init(nibName: "ConfirmPaymentViewController", bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.accountCreationComplete
        
        let closeButton = UIBarButtonItem(image: UIImage(named: "cancel"), style: .done, target: self, action: #selector(closeTapped(_:)))
        closeButton.accessibilityLabel = L10n.accessibilityCloseDialog
        navigationItem.leftBarButtonItem = closeButton
        
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        if let email = ServerSettings.syncingEmail() {
            emailLabel.text = email
        }
        
        let paymentFreq = IapHelper.shared.getPaymentFrequencyForIdentifier(identifier: newSubscription.iap_identifier)
        priceLabel.text = "\(IapHelper.shared.getPriceForIdentifier(identifier: newSubscription.iap_identifier))" + " / " + "\(paymentFreq)"
        renewLabel.text = Constants.IapProducts(rawValue: newSubscription.iap_identifier)?.renewalPrompt
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        
        tryAgainView.isHidden = true
        
        buyButton.setNeedsLayout()
        NotificationCenter.default.addObserver(self, selector: #selector(iapPurchaseCompleted), name: ServerNotifications.iapPurchaseCompleted, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(iapPurchaseDeferred), name: ServerNotifications.iapPurchaseDeferred, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(iapPurchaseFailed), name: ServerNotifications.iapPurchaseFailed, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(iapPurchaseCancelled), name: ServerNotifications.iapPurchaseCancelled, object: nil)
    }
    
    @IBAction func payTapped(_ sender: Any) {
        buyButton.titleLabel?.isHidden = true
        buyButton.isEnabled = false
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        tryAgainView.isHidden = true
        borderView.isHidden = false
        cancelledLabel.isHidden = true
        
        if !IapHelper.shared.buyProduct(identifier: newSubscription.iap_identifier) {
            iapPurchaseFailed()
        }
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func showAccountUpdated() {
        let upgradedVC = AccountUpdatedViewController()
        upgradedVC.titleText = newSubscription.isNewAccount ? L10n.accountCreated : L10n.accountUpgraded
        upgradedVC.detailText = L10n.accountWelcomePlus
        upgradedVC.imageName = newSubscription.isNewAccount ? AppTheme.accountCreatedImageName : AppTheme.plusCreatedImageName
        upgradedVC.hideNewsletter = !newSubscription.isNewAccount
        navigationController?.pushViewController(upgradedVC, animated: true)
    }
    
    // MARK: Purchase notification handlers
    
    @objc func iapPurchaseCompleted() {
        activityIndicator.stopAnimating()
        // save subscription data as there is a noticable delay getting subscription data back from our server
        SubscriptionHelper.setSubscriptionPaid(1)
        SubscriptionHelper.setSubscriptionPlatform(SubscriptionPlatform.iOS.rawValue)
        SubscriptionHelper.setSubscriptionAutoRenewing(true)
        let currentDate = Date()
        var dateComponent = DateComponents()
        
        if newSubscription.iap_identifier == Constants.IapProducts.monthly.rawValue {
            SubscriptionHelper.setSubscriptionFrequency(SubscriptionFrequency.monthly.rawValue)
            dateComponent.month = 1
            if let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate) {
                SubscriptionHelper.setSubscriptionExpiryDate(futureDate.timeIntervalSince1970)
            }
        }
        else if newSubscription.iap_identifier == Constants.IapProducts.yearly.rawValue {
            SubscriptionHelper.setSubscriptionFrequency(SubscriptionFrequency.yearly.rawValue)
            dateComponent.year = 1
            if let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate) {
                SubscriptionHelper.setSubscriptionExpiryDate(futureDate.timeIntervalSince1970)
            }
        }
        else {
            SubscriptionHelper.setSubscriptionFrequency(SubscriptionFrequency.none.rawValue)
        }
        
        NotificationCenter.default.post(name: ServerNotifications.subscriptionStatusChanged, object: nil)
        
        Settings.setLoginDetailsUpdated()
        showAccountUpdated()
    }
    
    @objc func iapPurchaseDeferred() {
        let upgradedVC = AccountUpdatedViewController()
        upgradedVC.titleText = L10n.accountCompletionNudge
        upgradedVC.imageName = AppTheme.paymentDeferredImageName
        upgradedVC.detailText = L10n.accountCompletionNudge
        navigationController?.pushViewController(upgradedVC, animated: true)
    }
    
    @objc func iapPurchaseFailed() {
        activityIndicator.stopAnimating()
        buyButton.titleLabel?.isHidden = false
        buyButton.setTitle(L10n.tryAgain, for: .normal)
        buyButton.isEnabled = true
        borderView.isHidden = true
        tryAgainView.isHidden = false
        title = ""
        let closeButton = UIBarButtonItem(image: UIImage(named: "cancel"), style: .done, target: self, action: #selector(closeTapped(_:)))
        closeButton.accessibilityLabel = L10n.accessibilityCloseDialog
        closeButton.tintColor = ThemeColor.primaryIcon01()
        navigationItem.leftBarButtonItem = closeButton
    }
    
    @objc func iapPurchaseCancelled() {
        activityIndicator.stopAnimating()
        buyButton.titleLabel?.isHidden = false
        buyButton.setTitle(L10n.confirm, for: .normal)
        buyButton.isEnabled = true
        cancelledLabel.isHidden = false
    }
    
    // MARK: - Orientation
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        AppTheme.defaultStatusBarStyle()
    }
}
