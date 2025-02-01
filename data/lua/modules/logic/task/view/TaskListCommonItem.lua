module("modules.logic.task.view.TaskListCommonItem", package.seeall)

slot0 = class("TaskListCommonItem", LuaCompBase)

function slot0.init(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.go = slot1
	slot0.go.name = "item" .. tostring(slot3)
	slot0._index = slot3
	slot0._mo = slot4
	slot0._taskType = slot2
	slot0._open = slot5
	slot0._itemAni = slot1:GetComponent(typeof(UnityEngine.Animator))
	slot0._gocommon = gohelper.findChild(slot0.go, "#go_common")
	slot0._imgBg = gohelper.findChildImage(slot0._gocommon, "#simage_bg")
	slot0._gonotget = gohelper.findChild(slot0._gocommon, "#go_notget")
	slot0._btnnotfinishbg = gohelper.findChildButtonWithAudio(slot0._gocommon, "#go_notget/#btn_notfinishbg")
	slot0._btnfinishbg = gohelper.findChildButton(slot0._gocommon, "#go_notget/#btn_finishbg")
	slot0._goallfinish = gohelper.findChild(slot0._gocommon, "#go_notget/#go_allfinish")
	slot0._godoing = gohelper.findChild(slot0._gocommon, "#go_notget/#go_doing")
	slot0._txttaskdes = gohelper.findChildText(slot0._gocommon, "right/#txt_taskdes")
	slot0._imgcompleteproc = gohelper.findChildImage(slot0._gocommon, "right/completeproc/#image_full")
	slot0._txttotal = gohelper.findChildText(slot0._gocommon, "right/#txt_total")
	slot0._txtcomplete = gohelper.findChildText(slot0._gocommon, "right/#txt_total/#txt_complete")
	slot0._txtcommonnum = gohelper.findChildText(slot0._gocommon, "#txt_num")
	slot0._simagegetmask = gohelper.findChildSingleImage(slot0._gocommon, "#simage_getmask")
	slot0._goget = gohelper.findChild(slot0._gocommon, "#go_get")
	slot0._gocollectionCanvasGroup = gohelper.findChild(slot0._gocommon, "#go_get/collecticon"):GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._goreddot = gohelper.findChild(slot0._gocommon, "#go_reddot")
	slot0._gocommonclick = gohelper.findChild(slot0._gocommon, "click")
	slot0._simagecommonclickmask = gohelper.findChildSingleImage(slot0._gocommon, "click/getmask")
	slot0._goreward = gohelper.findChild(slot0.go, "#go_reward")
	slot0._simagerewardbg = gohelper.findChildSingleImage(slot0._goreward, "#simage_bg")
	slot0._txtrewardnum = gohelper.findChildText(slot0._goreward, "#txt_num")
	slot0._btngetall = gohelper.findChildButton(slot0._goreward, "#go_getall/#btn_getall")
	slot0._gorewardclick = gohelper.findChild(slot0._goreward, "click")
	slot0._simagerewardclickmask = gohelper.findChildSingleImage(slot0._goreward, "click/getmask")

	slot0._simagegetmask:LoadImage(ResUrl.getTaskBg("dieheiyou_020"))
	slot0._simagecommonclickmask:LoadImage(ResUrl.getTaskBg("dieheiyou_020"))
	slot0._simagerewardclickmask:LoadImage(ResUrl.getTaskBg("dieheiyou_020"))
	slot0._simagerewardbg:LoadImage(ResUrl.getTaskBg("bg_quanbulqd"))
	gohelper.setActive(slot0._gocommonclick, false)
	gohelper.setActive(slot0._gorewardclick, false)
	gohelper.setActive(slot0._goreddot, false)

	slot0._rewardItems = {}

	slot0:addEvents()

	if not slot0._mo then
		slot0:_refreshRewardItem()
	else
		slot0:_refreshCommonItem()
	end
end

function slot0.hasFinished(slot0)
	if slot0._mo then
		return slot0._mo.config.maxFinishCount <= slot0._mo.finishCount
	end

	return false
end

function slot0.isAllGetType(slot0)
	return not slot0._mo
end

function slot0.reset(slot0, slot1, slot2, slot3)
	slot0._index = slot2
	slot0._mo = slot3
	slot0._taskType = slot1
	slot0._open = false

	gohelper.setActive(slot0._gocommonclick, false)
	gohelper.setActive(slot0._gorewardclick, false)

	slot0.go.name = "item" .. tostring(slot2)
	slot0._rewardItems = {}

	if not slot0._mo then
		slot0:_refreshRewardItem()
	else
		slot0:_refreshCommonItem()
	end
end

function slot0.addEvents(slot0)
	slot0._btnnotfinishbg:AddClickListener(slot0._btnnotfinishbgOnClick, slot0)
	slot0._btnfinishbg:AddClickListener(slot0._btnfinishbgOnClick, slot0)
	slot0._btngetall:AddClickListener(slot0._btnGetAllOnClick, slot0)
	ActivityController.instance:registerCallback(TaskEvent.GetTaskReward, slot0._onGetReward, slot0)
	ActivityController.instance:registerCallback(TaskEvent.GetAllTaskReward, slot0._onGetAllReward, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnnotfinishbg:RemoveClickListener()
	slot0._btnfinishbg:RemoveClickListener()
	slot0._btngetall:RemoveClickListener()
	ActivityController.instance:unregisterCallback(TaskEvent.GetTaskReward, slot0._onGetReward, slot0)
	ActivityController.instance:unregisterCallback(TaskEvent.GetAllTaskReward, slot0._onGetAllReward, slot0)
end

function slot0._onGetAllReward(slot0, slot1)
	if slot0._taskType ~= slot1 then
		return
	end

	if slot0._mo and slot0._mo.finishCount < slot0._mo.config.maxFinishCount and slot0._mo.hasFinished then
		gohelper.setActive(slot0._gocommonclick, true)

		slot0._itemAni.enabled = true

		slot0._itemAni:Play(UIAnimationName.Close)
		TaskDispatcher.runDelay(slot0._onPlayRewardFinished, slot0, 0.46)
	end
end

function slot0._onGetReward(slot0, slot1)
	if slot0._taskType ~= slot1 then
		return
	end

	if not slot0._mo and #TaskModel.instance:getAllRewardUnreceivedTasks(slot0._taskType) < 3 then
		slot0._itemAni.enabled = true

		slot0._itemAni:Play(UIAnimationName.Close)
		TaskDispatcher.runDelay(slot0._onPlayRewardFinished, slot0, 0.76)
	end
end

function slot0._btnGetAllOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Task_UI_TaskItem_moveTop)
	gohelper.setActive(slot0._gorewardclick, true)

	slot0._itemAni.enabled = true

	slot0._itemAni:Play(UIAnimationName.Close)
	UIBlockMgr.instance:startBlock("taskani")
	ActivityController.instance:dispatchEvent(TaskEvent.GetAllTaskReward, slot0._taskType)
	TaskDispatcher.runDelay(slot0._onPlayRewardClickFinished, slot0, 0.76)
end

function slot0._onPlayRewardFinished(slot0)
	gohelper.setAsLastSibling(slot0.go)
end

function slot0._onPlayRewardClickFinished(slot0)
	for slot6, slot7 in pairs(TaskModel.instance:getAllUnlockTasks(slot0._taskType)) do
		if slot7.finishCount < slot7.config.maxFinishCount and slot7.hasFinished then
			slot1 = 0 + slot7.config.activity
		end
	end

	TaskController.instance:dispatchEvent(TaskEvent.RefreshActState, {
		num = slot1,
		taskType = slot0._taskType
	})
	slot0:_getFinished()
	TaskDispatcher.runDelay(slot0._onPlayGetAllRewardFinished, slot0, 0.6)
end

function slot0._onPlayGetAllRewardFinished(slot0)
	UIBlockMgr.instance:endBlock("taskani")
	TaskRpc.instance:sendFinishAllTaskRequest(slot0._taskType)
end

function slot0._btnnotfinishbgOnClick(slot0)
	if slot0._mo.config.jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)
		GameFacade.jump(slot0._mo.config.jumpId)
	end
end

function slot0._btnfinishbgOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Task_UI_TaskItem_moveTop)
	TaskModel.instance:clearNewTaskIds()
	gohelper.setActive(slot0._gocommonclick, true)

	slot0._itemAni.enabled = true

	slot0._itemAni:Play(UIAnimationName.Close)
	UIBlockMgr.instance:startBlock("taskani")
	ActivityController.instance:dispatchEvent(TaskEvent.GetTaskReward, slot0._taskType)
	TaskDispatcher.runDelay(slot0._onPlayCommonClickFinished, slot0, 0.46)
end

function slot0._onPlayCommonClickFinished(slot0)
	slot1 = 0

	TaskController.instance:dispatchEvent(TaskEvent.RefreshActState, {
		num = (slot0._taskType ~= TaskEnum.TaskType.Daily or TaskConfig.instance:gettaskdailyCO(slot0._mo.id).activity) and TaskConfig.instance:gettaskweeklyCO(slot0._mo.id).activity,
		taskType = slot0._taskType
	})
	TaskDispatcher.runDelay(slot0._getFinished, slot0, 0.3)
	TaskDispatcher.runDelay(slot0._onPlayActAniFinished, slot0, 0.6)
end

function slot0._getFinished(slot0)
	gohelper.setAsLastSibling(slot0.go)
end

function slot0._onPlayActAniFinished(slot0)
	UIBlockMgr.instance:endBlock("taskani")
	TaskRpc.instance:sendFinishTaskRequest(slot0._mo.id)
end

function slot0._refreshCommonItem(slot0)
	gohelper.setActive(slot0._gocommon, true)
	gohelper.setActive(slot0._goreward, false)

	slot0._txtcommonnum.text = luaLang("multiple") .. slot0._mo.config.activity
	slot0._txttaskdes.text = string.format(slot0._mo.config.desc, slot0._mo.config.maxProgress)
	slot0._txtcomplete.text = GameUtil.numberDisplay(slot0._mo.progress)
	slot0._txttotal.text = GameUtil.numberDisplay(slot0._mo.config.maxProgress)
	slot0._imgcompleteproc.fillAmount = slot0._mo.progress / slot0._mo.config.maxProgress

	if slot0._mo.config.maxFinishCount <= slot0._mo.finishCount then
		gohelper.setActive(slot0._btnfinishbg.gameObject, false)
		gohelper.setActive(slot0._btnnotfinishbg.gameObject, false)
		gohelper.setActive(slot0._godoing.gameObject, false)
		gohelper.setActive(slot0._goget, true)
		gohelper.setActive(slot0._gonotget, false)
		gohelper.setActive(slot0._simagegetmask.gameObject, true)
		gohelper.setActive(slot0._goreddot, false)
		ZProj.UGUIHelper.SetColorAlpha(slot0._imgBg, 0.8)
	elseif slot0._mo.hasFinished then
		gohelper.setActive(slot0._btnfinishbg.gameObject, true)
		gohelper.setActive(slot0._btnnotfinishbg.gameObject, false)
		gohelper.setActive(slot0._godoing.gameObject, false)
		gohelper.setActive(slot0._goget, false)
		gohelper.setActive(slot0._gonotget, true)
		gohelper.setActive(slot0._simagegetmask.gameObject, false)
		ZProj.UGUIHelper.SetColorAlpha(slot0._imgBg, 1)
	else
		gohelper.setActive(slot0._btnfinishbg.gameObject, false)
		gohelper.setActive(slot0._btnnotfinishbg.gameObject, slot0._mo.config.jumpId ~= 0)
		gohelper.setActive(slot0._godoing.gameObject, slot0._mo.config.jumpId == 0)
		gohelper.setActive(slot0._goget, false)
		gohelper.setActive(slot0._gonotget, true)
		gohelper.setActive(slot0._simagegetmask.gameObject, false)
		gohelper.setActive(slot0._goreddot, false)
		ZProj.UGUIHelper.SetColorAlpha(slot0._imgBg, 1)
	end

	if slot0._open then
		slot0._itemAni:Play(UIAnimationName.Open, 0, 0)
	else
		slot0._itemAni:Play(UIAnimationName.Idle)
	end

	slot0:showAllComplete()
end

function slot0.showAllComplete(slot0)
	if not slot0._mo then
		return
	end

	slot0._gocollectionCanvasGroup.alpha = TaskModel.instance:isAllRewardGet(slot0._taskType) and 0.6 or 1

	if slot0._mo.config.maxFinishCount <= slot0._mo.finishCount then
		gohelper.setActive(slot0._goallfinish, slot1)
	elseif slot0._mo.hasFinished then
		gohelper.setActive(slot0._btnfinishbg.gameObject, not slot1)
		gohelper.setActive(slot0._goallfinish, slot1)
	else
		gohelper.setActive(slot0._goallfinish, slot1)
	end

	if slot1 then
		gohelper.setActive(slot0._btnnotfinishbg.gameObject, false)
		gohelper.setActive(slot0._simagegetmask.gameObject, true)
	end
end

function slot0._refreshRewardItem(slot0)
	gohelper.setActive(slot0._goreward, true)
	gohelper.setActive(slot0._gocommon, false)

	for slot6, slot7 in pairs(TaskModel.instance:getAllUnlockTasks(slot0._taskType)) do
		if slot7.finishCount < slot7.config.maxFinishCount and slot7.hasFinished then
			slot2 = 0 + slot7.config.activity
		end
	end

	slot0._txtrewardnum.text = slot2

	if slot0._open then
		slot0._itemAni:Play(UIAnimationName.Open, 0, 0)
	else
		slot0._itemAni:Play(UIAnimationName.Idle)
	end
end

function slot0.showIdle(slot0)
	gohelper.setActive(slot0.go, true)
	slot0._itemAni:Play(UIAnimationName.Idle)
end

function slot0.destroy(slot0)
	UIBlockMgr.instance:endBlock("taskani")
	slot0:removeEvents()
	TaskDispatcher.cancelTask(slot0._onPlayCommonClickFinished, slot0)
	TaskDispatcher.cancelTask(slot0._onPlayCommonFinished, slot0)
	TaskDispatcher.cancelTask(slot0._onPlayRewardClickFinished, slot0)
	TaskDispatcher.cancelTask(slot0._onPlayActAniFinished, slot0)
	slot0._simagegetmask:UnLoadImage()
	slot0._simagerewardbg:UnLoadImage()
	slot0._simagecommonclickmask:UnLoadImage()
	slot0._simagerewardclickmask:UnLoadImage()

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)
	end

	if slot0._posTweenId then
		ZProj.TweenHelper.KillById(slot0._posTweenId)
	end

	TaskDispatcher.cancelTask(slot0._showSelfItem, slot0)
	TaskDispatcher.cancelTask(slot0._itemEntered, slot0)

	if slot0._rewardItems then
		for slot4, slot5 in pairs(slot0._rewardItems) do
			gohelper.destroy(slot5.itemIcon.go)
			gohelper.destroy(slot5.parentGo)
			slot5.itemIcon:onDestroy()
		end

		slot0._rewardItems = nil
	end

	gohelper.destroy(slot0.go)
end

return slot0
