module("modules.logic.task.view.TaskListCommonLevelItem", package.seeall)

local var_0_0 = class("TaskListCommonLevelItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.go = arg_1_1
	arg_1_0._tag = gohelper.findChildText(arg_1_1, "tag")
	arg_1_0._goflagcontent = gohelper.findChild(arg_1_1, "flagitem")
	arg_1_0._goflag = gohelper.findChild(arg_1_1, "flagitem/#go_flag")
	arg_1_0._scrollreward = gohelper.findChild(arg_1_1, "rewarditem"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_1_0._gorewardcontent = gohelper.findChild(arg_1_1, "rewarditem/viewport/content")
	arg_1_0._gomaskbg = gohelper.findChild(arg_1_1, "go_maskbg")
	arg_1_0._gomask = gohelper.findChild(arg_1_1, "go_maskbg/maskcontainer")
	arg_1_0._itemAni = arg_1_1:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._itemAni.enabled = false
	arg_1_0._maskAni = arg_1_0._gomaskbg:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._maskAni.enabled = false
	arg_1_0._maskCanvasGroup = arg_1_0._gomaskbg:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0._getAct = 0
	arg_1_0._gocanvasgroup = arg_1_1:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0._scrollreward.parentGameObject = arg_1_2

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_1_0._onCheckPlayRewardGet, arg_1_0)
end

function var_0_0._onPlayActState(arg_2_0, arg_2_1)
	if arg_2_1.taskType == TaskEnum.TaskType.Novice or arg_2_1.num < 1 then
		return
	end

	if arg_2_0._taskType ~= arg_2_1.taskType then
		return
	end

	TaskDispatcher.cancelTask(arg_2_0._flagPlayUpdate, arg_2_0)

	local var_2_0 = arg_2_0:_getAddNum(arg_2_1.num)

	if var_2_0 < 1 then
		return
	end

	arg_2_0._totalAct = arg_2_0._getAct + var_2_0

	if var_2_0 > 0 then
		arg_2_0._flagupdateCount = 0

		TaskDispatcher.runRepeat(arg_2_0._flagPlayUpdate, arg_2_0, 0.06, var_2_0)
	end
end

function var_0_0._getAddNum(arg_3_0, arg_3_1)
	local var_3_0 = TaskModel.instance:getTaskActivityMO(arg_3_0._taskType)

	if arg_3_0._index <= var_3_0.defineId then
		return 0
	end

	local var_3_1 = 0
	local var_3_2 = 0
	local var_3_3 = 0

	for iter_3_0 = var_3_0.defineId + 1, arg_3_0._index do
		var_3_3 = var_3_3 + TaskConfig.instance:gettaskactivitybonusCO(arg_3_0._taskType, iter_3_0).needActivity
	end

	local var_3_4 = TaskConfig.instance:gettaskactivitybonusCO(arg_3_0._taskType, arg_3_0._index).needActivity

	if var_3_0.value - var_3_0.gainValue + arg_3_1 - var_3_3 >= 0 then
		if arg_3_0._index == var_3_0.defineId + 1 then
			var_3_1 = var_3_4 - (var_3_0.value - var_3_0.gainValue)
		else
			var_3_1 = var_3_4
		end
	elseif arg_3_0._index == var_3_0.defineId + 1 then
		var_3_1 = arg_3_1
	else
		var_3_1 = arg_3_1 + (var_3_0.value - var_3_0.gainValue) - (var_3_3 - var_3_4)
	end

	return var_3_1
end

function var_0_0._flagPlayUpdate(arg_4_0)
	arg_4_0._flagupdateCount = arg_4_0._flagupdateCount + 1

	if arg_4_0._flagupdateCount + arg_4_0._getAct > #arg_4_0._flags then
		TaskDispatcher.cancelTask(arg_4_0._flagPlayUpdate, arg_4_0)

		return
	end

	gohelper.setActive(arg_4_0._flags[arg_4_0._flagupdateCount + arg_4_0._getAct].go, true)
	arg_4_0._flags[arg_4_0._flagupdateCount + arg_4_0._getAct].ani:Play("play")

	if arg_4_0._flagupdateCount + arg_4_0._getAct >= arg_4_0._totalAct then
		for iter_4_0 = arg_4_0._getAct, arg_4_0._totalAct - 1 do
			UISpriteSetMgr.instance:setCommonSprite(arg_4_0._flags[iter_4_0 + 1].img, "logo_huoyuedu")
		end

		arg_4_0._getAct = arg_4_0._totalAct

		if TaskConfig.instance:gettaskactivitybonusCO(arg_4_0._taskType, arg_4_0._index).needActivity <= arg_4_0._getAct then
			arg_4_0._needOpen = true
		end

		TaskDispatcher.cancelTask(arg_4_0._flagPlayUpdate, arg_4_0)
	end
end

function var_0_0._onCheckPlayRewardGet(arg_5_0, arg_5_1)
	if arg_5_1 == ViewName.CommonPropView and arg_5_0._needOpen and arg_5_0._maskCanvasGroup then
		arg_5_0._maskCanvasGroup.alpha = 1
		arg_5_0._maskAni.enabled = true

		arg_5_0._maskAni:Play(UIAnimationName.Open)

		arg_5_0._needOpen = false
	end
end

function var_0_0.setItem(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0._index = arg_6_1
	arg_6_0._mo = arg_6_2
	arg_6_0._taskType = arg_6_3

	TaskController.instance:registerCallback(TaskEvent.RefreshActState, arg_6_0._onPlayActState, arg_6_0)

	local var_6_0 = TaskModel.instance:getTaskActivityMO(arg_6_0._taskType)
	local var_6_1 = 0
	local var_6_2 = TaskConfig.instance:getTaskActivityBonusConfig(arg_6_0._taskType)

	for iter_6_0 = 1, #var_6_2 do
		var_6_1 = var_6_1 + var_6_2[iter_6_0].needActivity
	end

	if arg_6_0._index <= var_6_0.defineId and var_6_1 > var_6_0.value then
		arg_6_0._maskCanvasGroup.alpha = 1
		arg_6_0._maskAni.enabled = true

		if arg_6_4 then
			arg_6_0._maskAni:Play(UIAnimationName.Open)
		else
			arg_6_0._maskAni:Play(UIAnimationName.Idle)
		end
	else
		arg_6_0._maskCanvasGroup.alpha = 0
		arg_6_0._itemAni.enabled = true
		arg_6_0._gocanvasgroup.alpha = 1
	end

	arg_6_0._tag.text = string.format("%02d", arg_6_0._index)

	if arg_6_4 then
		arg_6_0._gocanvasgroup.alpha = 0
		arg_6_0._itemAni.enabled = false

		local var_6_3 = TaskModel.instance:getMaxStage(arg_6_0._taskType)
		local var_6_4 = TaskModel.instance:getTaskActivityMO(arg_6_0._taskType).defineId + 1
		local var_6_5 = var_6_3 - var_6_4 >= 5 and var_6_4 - 1 or var_6_3 - 5

		TaskDispatcher.runDelay(arg_6_0._playStartAni, arg_6_0, 0.04 * (arg_6_0._index - var_6_5 + 1))
	else
		arg_6_0._gocanvasgroup.alpha = 1
		arg_6_0._itemAni.enabled = true

		arg_6_0._itemAni:Play(UIAnimationName.Idle)
		arg_6_0:_setFlagItem()
		arg_6_0:_setRewardItem()
	end
end

function var_0_0.showAllComplete(arg_7_0)
	arg_7_0._maskCanvasGroup.alpha = 1

	arg_7_0._maskAni:Play(UIAnimationName.Idle)
	gohelper.setActive(arg_7_0._gomask, false)
end

function var_0_0._playStartAni(arg_8_0)
	arg_8_0._gocanvasgroup.alpha = 1
	arg_8_0._itemAni.enabled = true

	arg_8_0._itemAni:Play(UIAnimationName.Open)
	arg_8_0:_setFlagItem(true)
	arg_8_0:_setRewardItem()
end

function var_0_0._setFlagItem(arg_9_0, arg_9_1)
	if arg_9_0._flags then
		for iter_9_0, iter_9_1 in pairs(arg_9_0._flags) do
			gohelper.destroy(iter_9_1.go)
		end
	end

	arg_9_0._getAct = 0
	arg_9_0._flags = arg_9_0:getUserDataTb_()

	local var_9_0 = TaskConfig.instance:gettaskactivitybonusCO(arg_9_0._taskType, arg_9_0._index).needActivity
	local var_9_1 = TaskModel.instance:getTaskActivityMO(arg_9_0._taskType)

	if arg_9_0._index <= var_9_1.defineId then
		arg_9_0._getAct = var_9_0
	elseif arg_9_0._index == var_9_1.defineId + 1 then
		arg_9_0._getAct = var_9_1.value - var_9_1.gainValue
	end

	for iter_9_2 = 1, var_9_0 do
		local var_9_2 = gohelper.cloneInPlace(arg_9_0._goflag.gameObject)

		gohelper.setActive(var_9_2, not arg_9_1)

		local var_9_3 = {
			go = var_9_2
		}

		var_9_3.idle = gohelper.findChild(var_9_3.go, "idle")

		gohelper.setActive(var_9_3.idle, true)

		var_9_3.img = gohelper.findChildImage(var_9_3.go, "idle")

		local var_9_4 = iter_9_2 <= arg_9_0._getAct and "logo_huoyuedu" or "logo_huoyuedu_dis"

		UISpriteSetMgr.instance:setCommonSprite(var_9_3.img, var_9_4)

		var_9_3.play = gohelper.findChild(var_9_3.go, "play")

		gohelper.setActive(var_9_3.play, false)

		var_9_3.ani = var_9_3.go:GetComponent(typeof(UnityEngine.Animator))

		var_9_3.ani:Play(UIAnimationName.Idle)
		table.insert(arg_9_0._flags, var_9_3)
	end

	arg_9_0._flagopenCount = 0

	if arg_9_1 then
		TaskDispatcher.cancelTask(arg_9_0._flagOpenUpdate, arg_9_0)
		TaskDispatcher.runRepeat(arg_9_0._flagOpenUpdate, arg_9_0, 0.03, var_9_0)
	end
end

function var_0_0._flagOpenUpdate(arg_10_0)
	arg_10_0._flagopenCount = arg_10_0._flagopenCount + 1

	gohelper.setActive(arg_10_0._flags[arg_10_0._flagopenCount].go, true)
	arg_10_0._flags[arg_10_0._flagopenCount].ani:Play(UIAnimationName.Open)
end

function var_0_0._setRewardItem(arg_11_0)
	if arg_11_0._rewardItems then
		for iter_11_0, iter_11_1 in pairs(arg_11_0._rewardItems) do
			gohelper.destroy(iter_11_1.go)
			iter_11_1:onDestroy()
		end
	end

	arg_11_0._rewardItems = arg_11_0:getUserDataTb_()

	local var_11_0 = string.split(TaskConfig.instance:gettaskactivitybonusCO(arg_11_0._taskType, arg_11_0._index).bonus, "|")

	for iter_11_2 = 1, #var_11_0 do
		arg_11_0._rewardItems[iter_11_2] = IconMgr.instance:getCommonPropItemIcon(arg_11_0._gorewardcontent)

		local var_11_1 = string.splitToNumber(var_11_0[iter_11_2], "#")

		arg_11_0._rewardItems[iter_11_2]:setMOValue(var_11_1[1], var_11_1[2], var_11_1[3], nil, true)
		transformhelper.setLocalScale(arg_11_0._rewardItems[iter_11_2].go.transform, 0.6, 0.6, 1)
		arg_11_0._rewardItems[iter_11_2]:setCountFontSize(50)
		arg_11_0._rewardItems[iter_11_2]:showStackableNum2()
		arg_11_0._rewardItems[iter_11_2]:isShowEffect(true)
		arg_11_0._rewardItems[iter_11_2]:setHideLvAndBreakFlag(true)
		arg_11_0._rewardItems[iter_11_2]:hideEquipLvAndBreak(true)
		gohelper.setActive(arg_11_0._rewardItems[iter_11_2].go, true)
	end
end

function var_0_0.destroy(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._playStartAni, arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._flagOpenUpdate, arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._flagPlayUpdate, arg_12_0)
	TaskController.instance:unregisterCallback(TaskEvent.RefreshActState, arg_12_0._onPlayActState, arg_12_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_12_0._onCheckPlayRewardGet, arg_12_0)

	if arg_12_0._rewardItems then
		for iter_12_0, iter_12_1 in pairs(arg_12_0._rewardItems) do
			gohelper.destroy(iter_12_1.go)
			iter_12_1:onDestroy()
		end

		arg_12_0._rewardItems = nil
	end

	if arg_12_0._flags then
		for iter_12_2, iter_12_3 in pairs(arg_12_0._flags) do
			gohelper.destroy(iter_12_3.go)
		end

		arg_12_0._flags = nil
	end
end

return var_0_0
