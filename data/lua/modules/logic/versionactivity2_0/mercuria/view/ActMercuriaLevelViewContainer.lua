module("modules.logic.versionactivity2_0.mercuria.view.ActMercuriaLevelViewContainer", package.seeall)

slot0 = class("ActMercuriaLevelViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, ActMercuriaLevelView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0._navigateButtonsView
		}
	end
end

function slot0.onContainerInit(slot0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity2_0Enum.ActivityId.Mercuria)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity2_0Enum.ActivityId.Mercuria
	})
end

return slot0
