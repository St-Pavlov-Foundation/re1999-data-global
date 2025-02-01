module("modules.logic.versionactivity1_3.armpipe.view.ArmMainViewContainer", package.seeall)

slot0 = class("ArmMainViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		ArmMainView.New(),
		TabViewGroup.New(1, "#go_BackBtns")
	}
end

function slot0.buildTabViews(slot0, slot1)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function slot0.onContainerInit(slot0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_3Enum.ActivityId.Act305)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_3Enum.ActivityId.Act305
	})
end

return slot0
