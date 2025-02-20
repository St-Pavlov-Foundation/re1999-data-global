module("modules.logic.versionactivity2_3.act174.view.Act174GameViewContainer", package.seeall)

slot0 = class("Act174GameViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0.mainView = Act174GameView.New()

	table.insert(slot1, slot0.mainView)
	table.insert(slot1, Act174GameShopView.New())
	table.insert(slot1, Act174GameWarehouseView.New())
	table.insert(slot1, Act174GameTeamView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		}, nil, slot0.OnClickClose, nil, , slot0)

		return {
			slot0.navigateView
		}
	end
end

function slot0.OnClickClose(slot0)
	Activity174Controller.instance:syncLocalTeam2Server(Activity174Model.instance:getCurActId())
end

function slot0.playCloseTransition(slot0)
	slot0.mainView.anim:Play(UIAnimationName.Close)
	TaskDispatcher.runDelay(slot0.onPlayCloseTransitionFinish, slot0, 0.2)
end

return slot0
