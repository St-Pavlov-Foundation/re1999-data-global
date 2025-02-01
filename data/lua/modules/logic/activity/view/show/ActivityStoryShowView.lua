module("modules.logic.activity.view.show.ActivityStoryShowView", package.seeall)

slot0 = class("ActivityStoryShowView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_icon")
	slot0._simagescrollbg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_scrollbg")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "title/time/#txt_time")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "title/#txt_desc")
	slot0._scrolltask = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_task")
	slot0._gotaskContent = gohelper.findChild(slot0.viewGO, "#scroll_task/Viewport/#go_taskContent")
	slot0._gotaskitem = gohelper.findChild(slot0.viewGO, "#scroll_task/Viewport/#go_taskContent/#go_taskitem")
	slot0._btnjump = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_jump")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnjump:AddClickListener(slot0._btnjumpOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnjump:RemoveClickListener()
end

slot0.unlimitDay = 42

function slot0._btnjumpOnClick(slot0)
	if slot0._taskConfigDataTab[1].jumpId ~= 0 then
		GameFacade.jump(slot1, slot0.jumpFinishCallBack, slot0)
	end
end

function slot0._editableInitView(slot0)
	slot0._simageimgchar = gohelper.findChildSingleImage(slot0.viewGO, "bg/character/img_character")

	slot0._simagebg:LoadImage(ResUrl.getActivityBg("full/img_begin_bg"))
	slot0._simageicon:LoadImage(ResUrl.getActivityBg("show/img_begin_lihui"))
	slot0._simagescrollbg:LoadImage(ResUrl.getActivityBg("show/img_begin_reward_bg"))
	slot0._simageimgchar:LoadImage(ResUrl.getActivityBg("show/img_begin_lihui"))
	gohelper.setActive(slot0._gotaskitem, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)

	slot0._actId = slot0.viewParam.actId
	slot0._taskConfigDataTab = slot0:getUserDataTb_()
	slot0._taskItemTab = slot0:getUserDataTb_()

	slot0:refreshData()
	slot0:refreshView()
end

function slot0.refreshData(slot0)
	slot3 = ActivityConfig.instance
	slot4 = slot3

	for slot4 = 1, GameUtil.getTabLen(slot3.getActivityShowTaskCount(slot4, slot0._actId)) do
		table.insert(slot0._taskConfigDataTab, ActivityConfig.instance:getActivityShowTaskList(slot0._actId, slot4))
	end
end

function slot0.refreshView(slot0)
	slot0._txtdesc.text = slot0._taskConfigDataTab[1].actDesc
	slot1, slot2 = ActivityModel.instance:getRemainTime(slot0._actId)
	slot0._txttime.text = uv0.unlimitDay < slot1 and luaLang("activityshow_unlimittime") or string.format(luaLang("activityshow_remaintime"), slot1, slot2)

	for slot6, slot7 in ipairs(slot0._taskConfigDataTab) do
		if not slot0._taskItemTab[slot6] then
			slot8 = slot0:getUserDataTb_()
			slot8.go = gohelper.clone(slot0._gotaskitem, slot0._gotaskContent, "task" .. slot6)
			slot8.item = ActivityStoryShowItem.New()

			slot8.item:init(slot8.go, slot6, slot7)
			table.insert(slot0._taskItemTab, slot8)
		end

		gohelper.setActive(slot8.go, true)
	end

	for slot6 = #slot0._taskConfigDataTab + 1, #slot0._taskItemTab do
		gohelper.setActive(slot0._taskItemTab[slot6].go, false)
	end
end

function slot0.jumpFinishCallBack(slot0)
	ViewMgr.instance:closeView(ViewName.ActivityWelfareView)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simageicon:UnLoadImage()
	slot0._simagescrollbg:UnLoadImage()
	slot0._simageimgchar:UnLoadImage()
end

return slot0
