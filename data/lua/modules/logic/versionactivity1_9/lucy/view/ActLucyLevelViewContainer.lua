module("modules.logic.versionactivity1_9.lucy.view.ActLucyLevelViewContainer", package.seeall)

slot0 = class("ActLucyLevelViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, ActLucyLevelView.New())
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
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_9Enum.ActivityId.Lucy)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_9Enum.ActivityId.Lucy
	})
end

return slot0
