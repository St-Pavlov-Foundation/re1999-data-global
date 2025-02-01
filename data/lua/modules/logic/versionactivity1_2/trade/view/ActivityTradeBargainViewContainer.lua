module("modules.logic.versionactivity1_2.trade.view.ActivityTradeBargainViewContainer", package.seeall)

slot0 = class("ActivityTradeBargainViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, ActivityTradeBargainView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))
	table.insert(slot1, TabViewGroup.New(2, "#go_content"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.VersionActivity_1_2_Trade)

		slot0._navigateButtonView:setCloseCheck(slot0._closeCheckFunc, slot0)

		return {
			slot0._navigateButtonView
		}
	elseif slot1 == 2 then
		return {
			ActivityTradeBargainQuoteView.New(),
			ActivityTradeBargainRewardView.New()
		}
	end
end

function slot0.onContainerInit(slot0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_2Enum.ActivityId.Trade)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_2Enum.ActivityId.Trade
	})
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
end

function slot0.setActId(slot0, slot1)
	slot0.actId = slot1
end

function slot0.getActId(slot0)
	return slot0.actId
end

return slot0
