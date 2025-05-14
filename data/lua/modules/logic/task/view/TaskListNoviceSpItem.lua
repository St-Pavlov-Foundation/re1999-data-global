module("modules.logic.task.view.TaskListNoviceSpItem", package.seeall)

local var_0_0 = class("TaskListNoviceSpItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.go = arg_1_1
	arg_1_0._index = arg_1_2
	arg_1_0._mo = arg_1_3
	arg_1_0._txtprogress = gohelper.findChildText(arg_1_0.go, "#txt_progress")
	arg_1_0._txtmaxprogress = gohelper.findChildText(arg_1_0.go, "#txt_maxprogress")
	arg_1_0._txttaskdes = gohelper.findChildText(arg_1_0.go, "#txt_taskdes")
	arg_1_0._scrollreward = gohelper.findChild(arg_1_0.go, "scroll_reward"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.go, "scroll_reward/Viewport/#go_rewards")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.go, "scroll_reward/Viewport/#go_rewards/#go_rewarditem")
	arg_1_0._goblackmask = gohelper.findChild(arg_1_0.go, "#go_blackmask")
	arg_1_0._goget = gohelper.findChild(arg_1_0.go, "#go_get")
	arg_1_0._gonotget = gohelper.findChild(arg_1_0.go, "#go_notget")
	arg_1_0._btnnotfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.go, "#go_notget/#btn_notfinishbg")
	arg_1_0._btnfinishbg = gohelper.findChildButton(arg_1_0.go, "#go_notget/#btn_finishbg")
	arg_1_0._simagecovericon = gohelper.findChildImage(arg_1_0.go, "#simage_covericon")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.go, "#simage_bg")
	arg_1_0._goclick = gohelper.findChild(arg_1_0.go, "click")
	arg_1_0._simageclickmask = gohelper.findChildSingleImage(arg_1_0.go, "click/getmask")
	arg_1_0._itemAni = arg_1_0.go:GetComponent(typeof(UnityEngine.Animator))

	arg_1_0._simagebg:LoadImage(ResUrl.getTaskBg("bg_youdi"))
	UISpriteSetMgr.instance:setActivityNoviceTaskSprite(arg_1_0._simagecovericon, "fm_" .. arg_1_0._mo.config.chapter)
	arg_1_0._simageclickmask:LoadImage(ResUrl.getTaskBg("dieheiyou_020"))

	arg_1_0._rewardItems = {}

	arg_1_0:addEvents()
	arg_1_0:_refreshItem()

	if arg_1_4 then
		arg_1_0._itemAni:Play(UIAnimationName.Open)
	else
		arg_1_0._itemAni:Play(UIAnimationName.Idle)
	end

	arg_1_0._scrollreward.parentGameObject = arg_1_5
end

function var_0_0.getTaskMinType(arg_2_0)
	return TaskEnum.TaskMinType.Stationary
end

function var_0_0.hasFinished(arg_3_0)
	return arg_3_0._mo.finishCount >= arg_3_0._mo.config.maxFinishCount
end

function var_0_0.reset(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._index = arg_4_1
	arg_4_0._mo = arg_4_2

	arg_4_0:_refreshItem()
	arg_4_0._itemAni:Play(UIAnimationName.Idle)
end

function var_0_0.getTaskId(arg_5_0)
	return arg_5_0._mo.id
end

function var_0_0.addEvents(arg_6_0)
	arg_6_0._btnnotfinishbg:AddClickListener(arg_6_0._btnnotfinishbgOnClick, arg_6_0)
	arg_6_0._btnfinishbg:AddClickListener(arg_6_0._btnfinishbgOnClick, arg_6_0)
end

function var_0_0.removeEvents(arg_7_0)
	arg_7_0._btnnotfinishbg:RemoveClickListener()
	arg_7_0._btnfinishbg:RemoveClickListener()
end

function var_0_0._btnnotfinishbgOnClick(arg_8_0)
	local var_8_0 = arg_8_0._mo.config.jumpId

	if var_8_0 ~= 0 then
		TaskController.instance:dispatchEvent(TaskEvent.OnRefreshActItem)
		GameFacade.jump(var_8_0)
	end
end

function var_0_0._btnfinishbgOnClick(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Task_UI_TaskItem_moveTop)
	gohelper.setActive(arg_9_0._goclick, true)
	arg_9_0._itemAni:Play(UIAnimationName.Close)
	UIBlockMgr.instance:startBlock("taskani")

	local var_9_0 = TaskConfig.instance:gettaskNoviceConfig(arg_9_0._mo.id).activity
	local var_9_1 = {
		num = var_9_0,
		taskType = TaskEnum.TaskType.Novice
	}

	TaskController.instance:dispatchEvent(TaskEvent.RefreshActState, var_9_1)
	TaskDispatcher.runDelay(arg_9_0._onPlayActAniFinished, arg_9_0, 0.76)
end

function var_0_0._onPlayActAniFinished(arg_10_0)
	UIBlockMgr.instance:endBlock("taskani")
	TaskRpc.instance:sendFinishTaskRequest(arg_10_0._mo.id)
	arg_10_0:destroy()
end

function var_0_0._refreshItem(arg_11_0)
	arg_11_0._txtprogress.text = tostring(arg_11_0._mo.progress)
	arg_11_0._txtmaxprogress.text = tostring(arg_11_0._mo.config.maxProgress)
	arg_11_0._txttaskdes.text = arg_11_0._mo.config.desc

	for iter_11_0, iter_11_1 in pairs(arg_11_0._rewardItems) do
		gohelper.destroy(iter_11_1.itemIcon.go)
		gohelper.destroy(iter_11_1.parentGo)
		iter_11_1.itemIcon:onDestroy()
	end

	arg_11_0._rewardItems = {}

	local var_11_0 = string.split(arg_11_0._mo.config.bonus, "|")

	arg_11_0._gorewards:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = #var_11_0 > 2

	for iter_11_2 = 1, #var_11_0 do
		local var_11_1 = {
			parentGo = gohelper.cloneInPlace(arg_11_0._gorewarditem)
		}

		gohelper.setActive(var_11_1.parentGo, true)

		local var_11_2 = string.splitToNumber(var_11_0[iter_11_2], "#")

		var_11_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(var_11_1.parentGo)

		var_11_1.itemIcon:setMOValue(var_11_2[1], var_11_2[2], var_11_2[3], nil, true)
		var_11_1.itemIcon:isShowCount(var_11_2[1] ~= MaterialEnum.MaterialType.Hero)
		var_11_1.itemIcon:setCountFontSize(40)
		var_11_1.itemIcon:showStackableNum2()
		var_11_1.itemIcon:setHideLvAndBreakFlag(true)
		var_11_1.itemIcon:hideEquipLvAndBreak(true)
		table.insert(arg_11_0._rewardItems, var_11_1)
	end

	if arg_11_0._mo.finishCount >= arg_11_0._mo.config.maxFinishCount then
		gohelper.setActive(arg_11_0._btnfinishbg.gameObject, false)
		gohelper.setActive(arg_11_0._btnnotfinishbg.gameObject, false)
		gohelper.setActive(arg_11_0._goget, true)
		gohelper.setActive(arg_11_0._gonotget, false)
		gohelper.setActive(arg_11_0._goblackmask.gameObject, true)
	elseif arg_11_0._mo.hasFinished then
		gohelper.setActive(arg_11_0._btnfinishbg.gameObject, true)
		gohelper.setActive(arg_11_0._btnnotfinishbg.gameObject, false)
		gohelper.setActive(arg_11_0._goget, false)
		gohelper.setActive(arg_11_0._gonotget, true)
		gohelper.setActive(arg_11_0._goblackmask.gameObject, false)
	else
		gohelper.setActive(arg_11_0._btnfinishbg.gameObject, false)
		gohelper.setActive(arg_11_0._btnnotfinishbg.gameObject, arg_11_0._mo.config.jumpId ~= 0)
		gohelper.setActive(arg_11_0._goget, false)
		gohelper.setActive(arg_11_0._gonotget, true)
		gohelper.setActive(arg_11_0._goblackmask.gameObject, false)
	end
end

function var_0_0.destroy(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._onPlayClickFinished, arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._onPlayActAniFinished, arg_12_0)

	if arg_12_0.go then
		gohelper.destroy(arg_12_0.go)

		arg_12_0.go = nil
	end

	arg_12_0:removeEvents()
	arg_12_0._simagebg:UnLoadImage()
	arg_12_0._simageclickmask:UnLoadImage()

	for iter_12_0, iter_12_1 in pairs(arg_12_0._rewardItems) do
		gohelper.destroy(iter_12_1.itemIcon.go)
		gohelper.destroy(iter_12_1.parentGo)
		iter_12_1.itemIcon:onDestroy()
	end

	arg_12_0._rewardItems = nil
end

return var_0_0
