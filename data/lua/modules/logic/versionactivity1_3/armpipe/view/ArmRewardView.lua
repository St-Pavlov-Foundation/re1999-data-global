module("modules.logic.versionactivity1_3.armpipe.view.ArmRewardView", package.seeall)

slot0 = class("ArmRewardView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Close")
	slot0._simageclosebtn = gohelper.findChildSingleImage(slot0.viewGO, "#btn_Close")
	slot0._simagePanelBG = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_PanelBG")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "Root/Title/#txt_Title")
	slot0._scrollTaskList = gohelper.findChildScrollRect(slot0.viewGO, "Root/#scroll_TaskList")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
end

function slot0._btnCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._simageclosebtn:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_igfullmask"))
	slot0._simagePanelBG:LoadImage(ResUrl.getV1a3ArmSinglebg("v1a3_arm_reward_pop_bg"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(Activity124Controller.instance, ArmPuzzlePipeEvent.RefreshMapData, slot0.refreshUI, slot0)
	slot0:addEventCb(Activity124Controller.instance, ArmPuzzlePipeEvent.RefreshReceiveReward, slot0.refreshUI, slot0)
	slot0:refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageclosebtn:UnLoadImage()
	slot0._simagePanelBG:UnLoadImage()
end

function slot0.refreshUI(slot0)
	Activity124RewardListModel.instance:init(VersionActivity1_3Enum.ActivityId.Act305)
end

return slot0
