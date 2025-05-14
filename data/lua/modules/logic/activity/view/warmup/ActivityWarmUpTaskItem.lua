module("modules.logic.activity.view.warmup.ActivityWarmUpTaskItem", package.seeall)

local var_0_0 = class("ActivityWarmUpTaskItem", LuaCompBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txttaskdes = gohelper.findChildText(arg_1_0.viewGO, "#txt_taskdes")
	arg_1_0._txtprogress = gohelper.findChildText(arg_1_0.viewGO, "#txt_progress")
	arg_1_0._txtmaxprogress = gohelper.findChildText(arg_1_0.viewGO, "#txt_maxprogress")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "scroll_reward/Viewport/#go_rewards/#go_rewarditem")
	arg_1_0._goget = gohelper.findChild(arg_1_0.viewGO, "#go_get")
	arg_1_0._gonotget = gohelper.findChild(arg_1_0.viewGO, "#go_notget")
	arg_1_0._goblackmask = gohelper.findChild(arg_1_0.viewGO, "#go_blackmask")
	arg_1_0._btnnotfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_notget/#btn_notfinishbg")
	arg_1_0._btnfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_notget/#btn_finishbg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnnotfinishbg:AddClickListener(arg_2_0._btnnotfinishbgOnClick, arg_2_0)
	arg_2_0._btnfinishbg:AddClickListener(arg_2_0._btnfinishbgOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnnotfinishbg:RemoveClickListener()
	arg_3_0._btnfinishbg:RemoveClickListener()
end

function var_0_0.initData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._index = arg_4_1
	arg_4_0.viewGO = arg_4_2

	arg_4_0:onInitView()
	arg_4_0:addEvents()
	gohelper.setActive(arg_4_0.viewGO, false)
	arg_4_0._animSelf:Play(UIAnimationName.Open, 0, 0)
end

function var_0_0.onDestroy(arg_5_0)
	UIBlockMgr.instance:endBlock(var_0_0.BLOCK_KEY)
	TaskDispatcher.cancelTask(arg_5_0.onFinishAnimCompleted, arg_5_0)
	arg_5_0:removeEvents()
	arg_5_0:onDestroyView()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._click = gohelper.getClickWithAudio(arg_6_0.viewGO)
	arg_6_0._animator = arg_6_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_6_0._simagebg:LoadImage(ResUrl.getActivityWarmUpBg("bg_rwdi"))

	arg_6_0._animSelf = arg_6_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_6_0._animSelf.enabled = true
	arg_6_0._iconList = {}
end

function var_0_0.onDestroyView(arg_7_0)
	arg_7_0._simagebg:UnLoadImage()

	for iter_7_0, iter_7_1 in pairs(arg_7_0._iconList) do
		gohelper.setActive(iter_7_1.go, true)
		gohelper.destroy(iter_7_1.go)
	end

	arg_7_0._iconList = nil
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1

	arg_8_0:refreshInfo()
	arg_8_0:refreshAllRewardIcons()
end

function var_0_0.refreshInfo(arg_9_0)
	local var_9_0 = arg_9_0._mo.config
	local var_9_1 = arg_9_0._mo.taskMO

	arg_9_0._txttaskdes.text = var_9_0.desc
	arg_9_0._txtprogress.text = tostring(arg_9_0._mo:getProgress())
	arg_9_0._txtmaxprogress.text = tostring(var_9_0.maxProgress)

	if arg_9_0._mo:isLock() then
		gohelper.setActive(arg_9_0._goblackmask, true)
		gohelper.setActive(arg_9_0._goget, false)
		gohelper.setActive(arg_9_0._gonotget, true)
		gohelper.setActive(arg_9_0._btnnotfinishbg.gameObject, true)
		gohelper.setActive(arg_9_0._btnfinishbg.gameObject, false)
	else
		arg_9_0:refreshButtonRunning()
	end
end

function var_0_0.refreshButtonRunning(arg_10_0)
	if arg_10_0._mo:alreadyGotReward() then
		arg_10_0:refreshWhenFinished()
	else
		gohelper.setActive(arg_10_0._goblackmask, false)

		if arg_10_0._mo:isFinished() then
			gohelper.setActive(arg_10_0._goget, false)
			gohelper.setActive(arg_10_0._gonotget, true)
			gohelper.setActive(arg_10_0._btnnotfinishbg.gameObject, false)
			gohelper.setActive(arg_10_0._btnfinishbg.gameObject, true)
		else
			gohelper.setActive(arg_10_0._goget, false)
			gohelper.setActive(arg_10_0._gonotget, true)
			gohelper.setActive(arg_10_0._btnnotfinishbg.gameObject, true)
			gohelper.setActive(arg_10_0._btnfinishbg.gameObject, false)
		end
	end
end

function var_0_0.refreshWhenFinished(arg_11_0)
	gohelper.setActive(arg_11_0._goblackmask, true)
	gohelper.setActive(arg_11_0._goget, true)
	gohelper.setActive(arg_11_0._gonotget, false)
end

function var_0_0.refreshAllRewardIcons(arg_12_0)
	arg_12_0:hideAllRewardIcon()

	local var_12_0 = string.split(arg_12_0._mo.config.bonus, "|")

	for iter_12_0 = 1, #var_12_0 do
		local var_12_1 = arg_12_0:getOrCreateIcon(iter_12_0)

		gohelper.setActive(var_12_1.go, true)

		local var_12_2 = string.splitToNumber(var_12_0[iter_12_0], "#")

		var_12_1.itemIcon:setMOValue(var_12_2[1], var_12_2[2], var_12_2[3], nil, true)
		var_12_1.itemIcon:isShowCount(var_12_2[1] ~= MaterialEnum.MaterialType.Hero)
		var_12_1.itemIcon:setCountFontSize(40)
		var_12_1.itemIcon:showStackableNum2()
		var_12_1.itemIcon:setHideLvAndBreakFlag(true)
		var_12_1.itemIcon:hideEquipLvAndBreak(true)
	end
end

function var_0_0.getOrCreateIcon(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._iconList[arg_13_1]

	if not var_13_0 then
		var_13_0 = arg_13_0:getUserDataTb_()
		var_13_0.go = gohelper.cloneInPlace(arg_13_0._gorewarditem)

		gohelper.setActive(var_13_0.go, true)

		var_13_0.itemIcon = IconMgr.instance:getCommonPropItemIcon(var_13_0.go)
		arg_13_0._iconList[arg_13_1] = var_13_0
	end

	return var_13_0
end

function var_0_0.hideAllRewardIcon(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0._iconList) do
		gohelper.setActive(iter_14_1.go, false)
	end
end

function var_0_0._btnnotfinishbgOnClick(arg_15_0)
	local var_15_0 = arg_15_0._mo.config.openDay

	ActivityWarmUpController.instance:switchTab(var_15_0)
	ActivityWarmUpTaskController.instance:dispatchEvent(ActivityWarmUpEvent.TaskListNeedClose)
end

var_0_0.BLOCK_KEY = "ActivityWarmUpTaskItemBlock"

function var_0_0._btnfinishbgOnClick(arg_16_0)
	arg_16_0:refreshWhenFinished()
	arg_16_0._animSelf:Play("finish", 0, 0)
	UIBlockMgr.instance:startBlock(var_0_0.BLOCK_KEY)
	TaskDispatcher.runDelay(arg_16_0.onFinishAnimCompleted, arg_16_0, 0.4)
end

function var_0_0.onFinishAnimCompleted(arg_17_0)
	UIBlockMgr.instance:endBlock(var_0_0.BLOCK_KEY)
	AudioMgr.instance:trigger(AudioEnum.UI.Task_UI_TaskItem_moveTop)
	gohelper.setActive(arg_17_0._goclick, true)
	TaskRpc.instance:sendFinishTaskRequest(arg_17_0._mo.id)
end

return var_0_0
