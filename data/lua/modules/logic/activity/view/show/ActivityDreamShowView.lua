module("modules.logic.activity.view.show.ActivityDreamShowView", package.seeall)

slot0 = class("ActivityDreamShowView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_icon")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "title/time/#txt_time")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "title/#txt_desc")
	slot0._txttask = gohelper.findChildText(slot0.viewGO, "reward/rewardItem/#txt_task")
	slot0._gorewardTask = gohelper.findChild(slot0.viewGO, "reward/rewardItem/rewarditem")
	slot0._simagerewardicon = gohelper.findChildSingleImage(slot0.viewGO, "reward/rewardItem/rewarditem/#simage_rewardicon")
	slot0._gocanget = gohelper.findChild(slot0.viewGO, "reward/rewardItem/rewarditem/#go_canget")
	slot0._btnrewardicon = gohelper.findChildButtonWithAudio(slot0.viewGO, "reward/rewardItem/rewarditem/#btn_rewardIcon")
	slot0._gofinished = gohelper.findChild(slot0.viewGO, "reward/rewardItem/rewarditem/#go_finished")
	slot0._scrollreward = gohelper.findChildScrollRect(slot0.viewGO, "reward/rewardPreview/#scroll_reward")
	slot0._gorewardContent = gohelper.findChild(slot0.viewGO, "reward/rewardPreview/#scroll_reward/Viewport/#go_rewardContent")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "reward/rewardPreview/#scroll_reward/Viewport/#go_rewardContent/#go_rewarditem")
	slot0._btnjump = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_jump")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnrewardicon:AddClickListener(slot0._btncangetOnClick, slot0)
	slot0._btnjump:AddClickListener(slot0._btnjumpOnClick, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SetTaskList, slot0.refreshTask, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0.refreshTask, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0.onViewOpenedFinish, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnrewardicon:RemoveClickListener()
	slot0._btnjump:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.onViewOpenedFinish, slot0)
end

slot0.ShowCount = 1
slot0.taskConfigId = 160002
slot0.unlimitDay = 42

function slot0._btncangetOnClick(slot0)
	if slot0._taskMo.hasFinished then
		TaskRpc.instance:sendFinishTaskRequest(slot0._taskMo.id)
	else
		MaterialTipController.instance:showMaterialInfo(tonumber(slot0._rewardCo[1]), tonumber(slot0._rewardCo[2]))
	end
end

function slot0._btnjumpOnClick(slot0)
	if slot0._config.jumpId ~= 0 then
		if JumpController.instance:isJumpOpen(slot1) and JumpController.instance:canJumpNew(JumpConfig.instance:getJumpConfig(slot1).param) then
			GameFacade.jump(slot1, nil, slot0)
		else
			GameFacade.showToast(ToastEnum.DreamShow)
		end
	end
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getActivityBg("full/img_dream_bg"))
	slot0._simageicon:LoadImage(ResUrl.getActivityBg("show/img_dream_lihui"))

	slot0._rewardItems = slot0:getUserDataTb_()

	gohelper.setActive(slot0._gorewarditem, false)
	gohelper.setActive(slot0._gorewardTask, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)

	slot0._actId = slot0.viewParam.actId

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityShow
	})
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0._config = ActivityConfig.instance:getActivityShowTaskList(slot0._actId, 1)
	slot0._txtdesc.text = slot0._config.actDesc
	slot1, slot2 = ActivityModel.instance:getRemainTime(slot0._actId)
	slot0._txttime.text = uv0.unlimitDay < slot1 and luaLang("activityshow_unlimittime") or string.format(luaLang("activityshow_remaintime"), slot1, slot2)

	for slot7 = 1, #string.split(slot0._config.showBonus, "|") do
		if not slot0._rewardItems[slot7] then
			slot8 = slot0:getUserDataTb_()
			slot8.go = gohelper.clone(slot0._gorewarditem, slot0._gorewardContent, "rewarditem" .. slot7)
			slot8.item = IconMgr.instance:getCommonPropItemIcon(slot8.go)

			table.insert(slot0._rewardItems, slot8)
		end

		gohelper.setActive(slot0._rewardItems[slot7].go, true)

		slot9 = string.splitToNumber(slot3[slot7], "#")

		slot0._rewardItems[slot7].item:setMOValue(slot9[1], slot9[2], slot9[3])
		slot0._rewardItems[slot7].item:isShowCount(slot9[4] == uv0.ShowCount)
		slot0._rewardItems[slot7].item:setCountFontSize(56)
		slot0._rewardItems[slot7].item:setHideLvAndBreakFlag(true)
		slot0._rewardItems[slot7].item:hideEquipLvAndBreak(true)
	end

	for slot7 = #slot3 + 1, #slot0._rewardItems do
		gohelper.setActive(slot0._rewardItems[slot7].go, false)
	end

	slot0:refreshTask()
end

function slot0.refreshTask(slot0)
	gohelper.setActive(slot0._gorewardTask, true)

	slot1 = TaskConfig.instance:getTaskActivityShowConfig(uv0.taskConfigId)
	slot0._txttask.text = slot1.desc
	slot0._rewardCo = string.splitToNumber(slot1.bonus, "#")
	slot2, slot3 = ItemModel.instance:getItemConfigAndIcon(slot0._rewardCo[1], slot0._rewardCo[2], true)

	slot0._simagerewardicon:LoadImage(slot3)

	slot0._taskMo = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityShow, slot1.activityId)[1]

	if slot0._taskMo.config.maxFinishCount <= slot0._taskMo.finishCount then
		gohelper.setActive(slot0._gofinished, true)
		gohelper.setActive(slot0._gocanget, false)
		SLFramework.UGUI.GuiHelper.SetColor(slot0._simagerewardicon.gameObject:GetComponent(gohelper.Type_Image), "#666666")
	elseif slot0._taskMo.hasFinished then
		gohelper.setActive(slot0._gofinished, false)
		gohelper.setActive(slot0._gocanget, true)
		SLFramework.UGUI.GuiHelper.SetColor(slot0._simagerewardicon.gameObject:GetComponent(gohelper.Type_Image), "#FFFFFF")
	else
		gohelper.setActive(slot0._gofinished, false)
		gohelper.setActive(slot0._gocanget, false)
		SLFramework.UGUI.GuiHelper.SetColor(slot0._simagerewardicon.gameObject:GetComponent(gohelper.Type_Image), "#FFFFFF")
	end
end

function slot0.onViewOpenedFinish(slot0, slot1)
	if slot1 == ViewName.DungeonView then
		ViewMgr.instance:closeView(ViewName.ActivityBeginnerView, true)
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._closeAllView, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simageicon:UnLoadImage()
end

return slot0
