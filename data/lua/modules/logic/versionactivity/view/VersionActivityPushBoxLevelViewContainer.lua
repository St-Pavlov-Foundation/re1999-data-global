module("modules.logic.versionactivity.view.VersionActivityPushBoxLevelViewContainer", package.seeall)

slot0 = class("VersionActivityPushBoxLevelViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		TabViewGroup.New(1, "#go_btns"),
		VersionActivityPushBoxLevelView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0._navigateButtonView
		}
	end
end

function slot0.onContainerOpen(slot0)
	ActivityEnterMgr.instance:enterActivity(VersionActivityEnum.ActivityId.Act111)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivityEnum.ActivityId.Act111
	})
end

return slot0
