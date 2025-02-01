module("modules.logic.bossrush.view.V1a4_BossRushMainViewContainer", package.seeall)

slot0 = class("V1a4_BossRushMainViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = HelpShowView.New()

	slot1:setHelpId(HelpEnum.HelpId.BossRushViewHelp)
	slot1:setDelayTime(0.5)

	return {
		V1a4_BossRushMainView.New(),
		TabViewGroup.New(1, "top_left"),
		slot1
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		}, 14601, slot0._closeCallback, nil, , slot0)

		return {
			slot0._navigateButtonView
		}
	end
end

function slot0.onContainerInit(slot0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_7Enum.ActivityId.BossRush)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_7Enum.ActivityId.BossRush
	})
end

return slot0
