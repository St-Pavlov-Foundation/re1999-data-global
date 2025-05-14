module("modules.logic.task.view.TaskListCommonItem", package.seeall)

local var_0_0 = class("TaskListCommonItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.go = arg_1_1
	arg_1_0.go.name = "item" .. tostring(arg_1_3)
	arg_1_0._index = arg_1_3
	arg_1_0._mo = arg_1_4
	arg_1_0._taskType = arg_1_2
	arg_1_0._open = arg_1_5
	arg_1_0._itemAni = arg_1_1:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._gocommon = gohelper.findChild(arg_1_0.go, "#go_common")
	arg_1_0._imgBg = gohelper.findChildImage(arg_1_0._gocommon, "#simage_bg")
	arg_1_0._gonotget = gohelper.findChild(arg_1_0._gocommon, "#go_notget")
	arg_1_0._btnnotfinishbg = gohelper.findChildButtonWithAudio(arg_1_0._gocommon, "#go_notget/#btn_notfinishbg")
	arg_1_0._btnfinishbg = gohelper.findChildButton(arg_1_0._gocommon, "#go_notget/#btn_finishbg")
	arg_1_0._goallfinish = gohelper.findChild(arg_1_0._gocommon, "#go_notget/#go_allfinish")
	arg_1_0._godoing = gohelper.findChild(arg_1_0._gocommon, "#go_notget/#go_doing")
	arg_1_0._txttaskdes = gohelper.findChildText(arg_1_0._gocommon, "right/#txt_taskdes")
	arg_1_0._imgcompleteproc = gohelper.findChildImage(arg_1_0._gocommon, "right/completeproc/#image_full")
	arg_1_0._txttotal = gohelper.findChildText(arg_1_0._gocommon, "right/#txt_total")
	arg_1_0._txtcomplete = gohelper.findChildText(arg_1_0._gocommon, "right/#txt_total/#txt_complete")
	arg_1_0._txtcommonnum = gohelper.findChildText(arg_1_0._gocommon, "#txt_num")
	arg_1_0._simagegetmask = gohelper.findChildSingleImage(arg_1_0._gocommon, "#simage_getmask")
	arg_1_0._goget = gohelper.findChild(arg_1_0._gocommon, "#go_get")
	arg_1_0._gocollectionCanvasGroup = gohelper.findChild(arg_1_0._gocommon, "#go_get/collecticon"):GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0._goreddot = gohelper.findChild(arg_1_0._gocommon, "#go_reddot")
	arg_1_0._gocommonclick = gohelper.findChild(arg_1_0._gocommon, "click")
	arg_1_0._simagecommonclickmask = gohelper.findChildSingleImage(arg_1_0._gocommon, "click/getmask")
	arg_1_0._goreward = gohelper.findChild(arg_1_0.go, "#go_reward")
	arg_1_0._simagerewardbg = gohelper.findChildSingleImage(arg_1_0._goreward, "#simage_bg")
	arg_1_0._txtrewardnum = gohelper.findChildText(arg_1_0._goreward, "#txt_num")
	arg_1_0._btngetall = gohelper.findChildButton(arg_1_0._goreward, "#go_getall/#btn_getall")
	arg_1_0._gorewardclick = gohelper.findChild(arg_1_0._goreward, "click")
	arg_1_0._simagerewardclickmask = gohelper.findChildSingleImage(arg_1_0._goreward, "click/getmask")

	arg_1_0._simagegetmask:LoadImage(ResUrl.getTaskBg("dieheiyou_020"))
	arg_1_0._simagecommonclickmask:LoadImage(ResUrl.getTaskBg("dieheiyou_020"))
	arg_1_0._simagerewardclickmask:LoadImage(ResUrl.getTaskBg("dieheiyou_020"))
	arg_1_0._simagerewardbg:LoadImage(ResUrl.getTaskBg("bg_quanbulqd"))
	gohelper.setActive(arg_1_0._gocommonclick, false)
	gohelper.setActive(arg_1_0._gorewardclick, false)
	gohelper.setActive(arg_1_0._goreddot, false)

	arg_1_0._rewardItems = {}

	arg_1_0:addEvents()

	if not arg_1_0._mo then
		arg_1_0:_refreshRewardItem()
	else
		arg_1_0:_refreshCommonItem()
	end
end

function var_0_0.hasFinished(arg_2_0)
	if arg_2_0._mo then
		return arg_2_0._mo.finishCount >= arg_2_0._mo.config.maxFinishCount
	end

	return false
end

function var_0_0.isAllGetType(arg_3_0)
	return not arg_3_0._mo
end

function var_0_0.reset(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0._index = arg_4_2
	arg_4_0._mo = arg_4_3
	arg_4_0._taskType = arg_4_1
	arg_4_0._open = false

	gohelper.setActive(arg_4_0._gocommonclick, false)
	gohelper.setActive(arg_4_0._gorewardclick, false)

	arg_4_0.go.name = "item" .. tostring(arg_4_2)
	arg_4_0._rewardItems = {}

	if not arg_4_0._mo then
		arg_4_0:_refreshRewardItem()
	else
		arg_4_0:_refreshCommonItem()
	end
end

function var_0_0.addEvents(arg_5_0)
	arg_5_0._btnnotfinishbg:AddClickListener(arg_5_0._btnnotfinishbgOnClick, arg_5_0)
	arg_5_0._btnfinishbg:AddClickListener(arg_5_0._btnfinishbgOnClick, arg_5_0)
	arg_5_0._btngetall:AddClickListener(arg_5_0._btnGetAllOnClick, arg_5_0)
	ActivityController.instance:registerCallback(TaskEvent.GetTaskReward, arg_5_0._onGetReward, arg_5_0)
	ActivityController.instance:registerCallback(TaskEvent.GetAllTaskReward, arg_5_0._onGetAllReward, arg_5_0)
end

function var_0_0.removeEvents(arg_6_0)
	arg_6_0._btnnotfinishbg:RemoveClickListener()
	arg_6_0._btnfinishbg:RemoveClickListener()
	arg_6_0._btngetall:RemoveClickListener()
	ActivityController.instance:unregisterCallback(TaskEvent.GetTaskReward, arg_6_0._onGetReward, arg_6_0)
	ActivityController.instance:unregisterCallback(TaskEvent.GetAllTaskReward, arg_6_0._onGetAllReward, arg_6_0)
end

function var_0_0._onGetAllReward(arg_7_0, arg_7_1)
	if arg_7_0._taskType ~= arg_7_1 then
		return
	end

	if arg_7_0._mo and arg_7_0._mo.finishCount < arg_7_0._mo.config.maxFinishCount and arg_7_0._mo.hasFinished then
		gohelper.setActive(arg_7_0._gocommonclick, true)

		arg_7_0._itemAni.enabled = true

		arg_7_0._itemAni:Play(UIAnimationName.Close)
		TaskDispatcher.runDelay(arg_7_0._onPlayRewardFinished, arg_7_0, 0.46)
	end
end

function var_0_0._onGetReward(arg_8_0, arg_8_1)
	if arg_8_0._taskType ~= arg_8_1 then
		return
	end

	if not arg_8_0._mo and #TaskModel.instance:getAllRewardUnreceivedTasks(arg_8_0._taskType) < 3 then
		arg_8_0._itemAni.enabled = true

		arg_8_0._itemAni:Play(UIAnimationName.Close)
		TaskDispatcher.runDelay(arg_8_0._onPlayRewardFinished, arg_8_0, 0.76)
	end
end

function var_0_0._btnGetAllOnClick(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Task_UI_TaskItem_moveTop)
	gohelper.setActive(arg_9_0._gorewardclick, true)

	arg_9_0._itemAni.enabled = true

	arg_9_0._itemAni:Play(UIAnimationName.Close)
	UIBlockMgr.instance:startBlock("taskani")
	ActivityController.instance:dispatchEvent(TaskEvent.GetAllTaskReward, arg_9_0._taskType)
	TaskDispatcher.runDelay(arg_9_0._onPlayRewardClickFinished, arg_9_0, 0.76)
end

function var_0_0._onPlayRewardFinished(arg_10_0)
	gohelper.setAsLastSibling(arg_10_0.go)
end

function var_0_0._onPlayRewardClickFinished(arg_11_0)
	local var_11_0 = 0
	local var_11_1 = TaskModel.instance:getAllUnlockTasks(arg_11_0._taskType)

	for iter_11_0, iter_11_1 in pairs(var_11_1) do
		if iter_11_1.finishCount < iter_11_1.config.maxFinishCount and iter_11_1.hasFinished then
			var_11_0 = var_11_0 + iter_11_1.config.activity
		end
	end

	local var_11_2 = {
		num = var_11_0,
		taskType = arg_11_0._taskType
	}

	TaskController.instance:dispatchEvent(TaskEvent.RefreshActState, var_11_2)
	arg_11_0:_getFinished()
	TaskDispatcher.runDelay(arg_11_0._onPlayGetAllRewardFinished, arg_11_0, 0.6)
end

function var_0_0._onPlayGetAllRewardFinished(arg_12_0)
	UIBlockMgr.instance:endBlock("taskani")
	TaskRpc.instance:sendFinishAllTaskRequest(arg_12_0._taskType)
end

function var_0_0._btnnotfinishbgOnClick(arg_13_0)
	if arg_13_0._mo.config.jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)
		GameFacade.jump(arg_13_0._mo.config.jumpId)
	end
end

function var_0_0._btnfinishbgOnClick(arg_14_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Task_UI_TaskItem_moveTop)
	TaskModel.instance:clearNewTaskIds()
	gohelper.setActive(arg_14_0._gocommonclick, true)

	arg_14_0._itemAni.enabled = true

	arg_14_0._itemAni:Play(UIAnimationName.Close)
	UIBlockMgr.instance:startBlock("taskani")
	ActivityController.instance:dispatchEvent(TaskEvent.GetTaskReward, arg_14_0._taskType)
	TaskDispatcher.runDelay(arg_14_0._onPlayCommonClickFinished, arg_14_0, 0.46)
end

function var_0_0._onPlayCommonClickFinished(arg_15_0)
	local var_15_0 = 0

	if arg_15_0._taskType == TaskEnum.TaskType.Daily then
		var_15_0 = TaskConfig.instance:gettaskdailyCO(arg_15_0._mo.id).activity
	else
		var_15_0 = TaskConfig.instance:gettaskweeklyCO(arg_15_0._mo.id).activity
	end

	local var_15_1 = {
		num = var_15_0,
		taskType = arg_15_0._taskType
	}

	TaskController.instance:dispatchEvent(TaskEvent.RefreshActState, var_15_1)
	TaskDispatcher.runDelay(arg_15_0._getFinished, arg_15_0, 0.3)
	TaskDispatcher.runDelay(arg_15_0._onPlayActAniFinished, arg_15_0, 0.6)
end

function var_0_0._getFinished(arg_16_0)
	gohelper.setAsLastSibling(arg_16_0.go)
end

function var_0_0._onPlayActAniFinished(arg_17_0)
	UIBlockMgr.instance:endBlock("taskani")
	TaskRpc.instance:sendFinishTaskRequest(arg_17_0._mo.id)
end

function var_0_0._refreshCommonItem(arg_18_0)
	gohelper.setActive(arg_18_0._gocommon, true)
	gohelper.setActive(arg_18_0._goreward, false)

	arg_18_0._txtcommonnum.text = luaLang("multiple") .. arg_18_0._mo.config.activity
	arg_18_0._txttaskdes.text = string.format(arg_18_0._mo.config.desc, arg_18_0._mo.config.maxProgress)
	arg_18_0._txtcomplete.text = GameUtil.numberDisplay(arg_18_0._mo.progress)
	arg_18_0._txttotal.text = GameUtil.numberDisplay(arg_18_0._mo.config.maxProgress)
	arg_18_0._imgcompleteproc.fillAmount = arg_18_0._mo.progress / arg_18_0._mo.config.maxProgress

	if arg_18_0._mo.finishCount >= arg_18_0._mo.config.maxFinishCount then
		gohelper.setActive(arg_18_0._btnfinishbg.gameObject, false)
		gohelper.setActive(arg_18_0._btnnotfinishbg.gameObject, false)
		gohelper.setActive(arg_18_0._godoing.gameObject, false)
		gohelper.setActive(arg_18_0._goget, true)
		gohelper.setActive(arg_18_0._gonotget, false)
		gohelper.setActive(arg_18_0._simagegetmask.gameObject, true)
		gohelper.setActive(arg_18_0._goreddot, false)
		ZProj.UGUIHelper.SetColorAlpha(arg_18_0._imgBg, 0.8)
	elseif arg_18_0._mo.hasFinished then
		gohelper.setActive(arg_18_0._btnfinishbg.gameObject, true)
		gohelper.setActive(arg_18_0._btnnotfinishbg.gameObject, false)
		gohelper.setActive(arg_18_0._godoing.gameObject, false)
		gohelper.setActive(arg_18_0._goget, false)
		gohelper.setActive(arg_18_0._gonotget, true)
		gohelper.setActive(arg_18_0._simagegetmask.gameObject, false)
		ZProj.UGUIHelper.SetColorAlpha(arg_18_0._imgBg, 1)
	else
		gohelper.setActive(arg_18_0._btnfinishbg.gameObject, false)
		gohelper.setActive(arg_18_0._btnnotfinishbg.gameObject, arg_18_0._mo.config.jumpId ~= 0)
		gohelper.setActive(arg_18_0._godoing.gameObject, arg_18_0._mo.config.jumpId == 0)
		gohelper.setActive(arg_18_0._goget, false)
		gohelper.setActive(arg_18_0._gonotget, true)
		gohelper.setActive(arg_18_0._simagegetmask.gameObject, false)
		gohelper.setActive(arg_18_0._goreddot, false)
		ZProj.UGUIHelper.SetColorAlpha(arg_18_0._imgBg, 1)
	end

	if arg_18_0._open then
		arg_18_0._itemAni:Play(UIAnimationName.Open, 0, 0)
	else
		arg_18_0._itemAni:Play(UIAnimationName.Idle)
	end

	arg_18_0:showAllComplete()
end

function var_0_0.showAllComplete(arg_19_0)
	if not arg_19_0._mo then
		return
	end

	local var_19_0 = TaskModel.instance:isAllRewardGet(arg_19_0._taskType)

	arg_19_0._gocollectionCanvasGroup.alpha = var_19_0 and 0.6 or 1

	if arg_19_0._mo.finishCount >= arg_19_0._mo.config.maxFinishCount then
		gohelper.setActive(arg_19_0._goallfinish, var_19_0)
	elseif arg_19_0._mo.hasFinished then
		gohelper.setActive(arg_19_0._btnfinishbg.gameObject, not var_19_0)
		gohelper.setActive(arg_19_0._goallfinish, var_19_0)
	else
		gohelper.setActive(arg_19_0._goallfinish, var_19_0)
	end

	if var_19_0 then
		gohelper.setActive(arg_19_0._btnnotfinishbg.gameObject, false)
		gohelper.setActive(arg_19_0._simagegetmask.gameObject, true)
	end
end

function var_0_0._refreshRewardItem(arg_20_0)
	gohelper.setActive(arg_20_0._goreward, true)
	gohelper.setActive(arg_20_0._gocommon, false)

	local var_20_0 = TaskModel.instance:getAllUnlockTasks(arg_20_0._taskType)
	local var_20_1 = 0

	for iter_20_0, iter_20_1 in pairs(var_20_0) do
		if iter_20_1.finishCount < iter_20_1.config.maxFinishCount and iter_20_1.hasFinished then
			var_20_1 = var_20_1 + iter_20_1.config.activity
		end
	end

	arg_20_0._txtrewardnum.text = var_20_1

	if arg_20_0._open then
		arg_20_0._itemAni:Play(UIAnimationName.Open, 0, 0)
	else
		arg_20_0._itemAni:Play(UIAnimationName.Idle)
	end
end

function var_0_0.showIdle(arg_21_0)
	gohelper.setActive(arg_21_0.go, true)
	arg_21_0._itemAni:Play(UIAnimationName.Idle)
end

function var_0_0.destroy(arg_22_0)
	UIBlockMgr.instance:endBlock("taskani")
	arg_22_0:removeEvents()
	TaskDispatcher.cancelTask(arg_22_0._onPlayCommonClickFinished, arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._onPlayCommonFinished, arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._onPlayRewardClickFinished, arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._onPlayActAniFinished, arg_22_0)
	arg_22_0._simagegetmask:UnLoadImage()
	arg_22_0._simagerewardbg:UnLoadImage()
	arg_22_0._simagecommonclickmask:UnLoadImage()
	arg_22_0._simagerewardclickmask:UnLoadImage()

	if arg_22_0._tweenId then
		ZProj.TweenHelper.KillById(arg_22_0._tweenId)
	end

	if arg_22_0._posTweenId then
		ZProj.TweenHelper.KillById(arg_22_0._posTweenId)
	end

	TaskDispatcher.cancelTask(arg_22_0._showSelfItem, arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._itemEntered, arg_22_0)

	if arg_22_0._rewardItems then
		for iter_22_0, iter_22_1 in pairs(arg_22_0._rewardItems) do
			gohelper.destroy(iter_22_1.itemIcon.go)
			gohelper.destroy(iter_22_1.parentGo)
			iter_22_1.itemIcon:onDestroy()
		end

		arg_22_0._rewardItems = nil
	end

	gohelper.destroy(arg_22_0.go)
end

return var_0_0
