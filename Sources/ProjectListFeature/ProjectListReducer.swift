import ComposableArchitecture
import QuickNodeBalanceFeature
import PushLinkFeature
import PushNotificationFeature
import LensLinkFeature
import LensFollowerFeature
import LensFollowingFeature

public struct ProjectListReducer: ReducerProtocol {
  public init() {}

  public struct State: Equatable {
    public var balance = BalanceReducer.State()
    public var link = PushLinkReducer.State()
    public var notification = PushNotificationReducer.State()
    public var lensLink = LensLinkReducer.State()
    public var lensFollower = LensFollowerReducer.State()
    public var lensFollowing = LensFollowingReducer.State()
    
    @BindingState public var searchable = ""
    public init() {}
  }

  public enum Action: Equatable, BindableAction {
    case balance(BalanceReducer.Action)
    case link(PushLinkReducer.Action)
    case notification(PushNotificationReducer.Action)
    case lensLink(LensLinkReducer.Action)
    case lensFollower(LensFollowerReducer.Action)
    case lensFollowing(LensFollowingReducer.Action)

    case task
    case refreshable
    case binding(BindingAction<State>)
  }

  public var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Scope(state: \.balance, action: /Action.balance) {
      BalanceReducer()
    }
    Scope(state: \.link, action: /Action.link) {
      PushLinkReducer()
    }
    Scope(state: \.notification, action: /Action.notification) {
      PushNotificationReducer()
    }
    Scope(state: \.lensLink, action: /Action.lensLink) {
      LensLinkReducer()
    }
    Scope(state: \.lensFollower, action: /Action.lensFollower) {
      LensFollowerReducer()
    }
    Scope(state: \.lensFollowing, action: /Action.lensFollowing) {
      LensFollowingReducer()
    }
    Reduce { state, action in
      switch action {
      case .balance, .link, .notification, .lensLink, .lensFollower, .lensFollowing:
        return EffectTask.none

      case .task:
        return EffectTask.none

      case .refreshable:
        return EffectTask.none

      case .binding:
        return EffectTask.none
      }
    }
  }
}
