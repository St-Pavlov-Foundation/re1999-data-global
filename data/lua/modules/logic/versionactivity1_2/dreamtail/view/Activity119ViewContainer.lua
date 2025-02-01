module("modules.logic.versionactivity1_2.dreamtail.view.Activity119ViewContainer", package.seeall)

slot0 = class("Activity119ViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Activity119View.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function slot0.buildTabViews(slot0, slot1)
	return {
		NavigateButtonsView.New({
			true,
			true,
			true
		}, 169)
	}
end

function slot0.onContainerInit(slot0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_2Enum.ActivityId.DreamTail)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_2Enum.ActivityId.DreamTail
	})
end

function slot0.playOpenTransition(slot0)
	slot1 = Activity119Model.instance:getData()
	slot3 = "nomal"

	if slot1.lastSelectModel == 2 and DungeonModel.instance:hasPassLevel(Activity119Config.instance:getConfig(VersionActivity1_2Enum.ActivityId.DreamTail, slot1.lastSelectDay).normalCO.id) then
		slot3 = "hard"
	end

	uv0.super.playOpenTransition(slot0, {
		anim = slot3
	})
end

function slot0.playCloseTransition(slot0)
	slot2 = "normalclose"

	if Activity119Model.instance:getData().lastSelectModel == 2 then
		slot2 = "hardclose"
	end

	uv0.super.playCloseTransition(slot0, {
		anim = slot2
	})
end

return slot0
