module("modules.logic.meilanni.view.MeilanniTaskView", package.seeall)

slot0 = class("MeilanniTaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg1")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg2")
	slot0._simageb3 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_b3")
	slot0._scrollreward = gohelper.findChildScrollRect(slot0.viewGO, "right/#scroll_reward")
	slot0._gorewardcontent = gohelper.findChild(slot0.viewGO, "right/#scroll_reward/Viewport/#go_rewardcontent")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._simagebg1:LoadImage(ResUrl.getMeilanniIcon("full/bg_beijing"))
	slot0._simagebg2:LoadImage(ResUrl.getMeilanniIcon("bg_beijing3"))
	slot0._simageb3:LoadImage(ResUrl.getMeilanniIcon("bg_beijing4"))
end

function slot0.onOpen(slot0)
	MeilanniTaskListModel.instance:showTaskList()
	slot0:addEventCb(MeilanniController.instance, MeilanniEvent.bonusReply, slot0._bonusReply, slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Player_Interface_Open)
end

function slot0._bonusReply(slot0)
	MeilanniTaskListModel.instance:showTaskList()
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Player_Interface_Close)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg1:UnLoadImage()
	slot0._simagebg2:UnLoadImage()
	slot0._simageb3:UnLoadImage()
end

return slot0
