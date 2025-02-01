module("modules.logic.versionactivity1_3.act119.view.Activity1_3_119ViewContainer", package.seeall)

slot0 = class("Activity1_3_119ViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._view = Activity1_3_119View.New()

	table.insert(slot1, slot0._view)
	table.insert(slot1, TabViewGroup.New(1, "#go_BackBtns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	return {
		NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.VersionActivity_1_3_119)
	}
end

function slot0.onContainerInit(slot0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_3Enum.ActivityId.Act307)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_3Enum.ActivityId.Act307
	})
end

function slot0.playOpenTransition(slot0)
	slot1 = Activity119Model.instance:getData()
	slot3 = "normal"

	if slot1.lastSelectModel == 2 and DungeonModel.instance:hasPassLevel(Activity119Config.instance:getConfig(VersionActivity1_3Enum.ActivityId.Act307, slot1.lastSelectDay).normalCO.id) then
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
