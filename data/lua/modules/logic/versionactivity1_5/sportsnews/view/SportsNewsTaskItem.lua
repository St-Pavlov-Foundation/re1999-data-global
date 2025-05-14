module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsTaskItem", package.seeall)

local var_0_0 = class("SportsNewsTaskItem", LuaCompBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagenormalbg = gohelper.findChildSingleImage(arg_1_0.go, "#simage_normalbg")
	arg_1_0._txtprogress = gohelper.findChildText(arg_1_0.go, "progress/#txt_num")
	arg_1_0._txtmaxprogress = gohelper.findChildText(arg_1_0.go, "progress/#txt_num/#txt_total")
	arg_1_0._scrolltaskdes = gohelper.findChildScrollRect(arg_1_0.go, "#scroll_taskdes")
	arg_1_0._txttaskdes = gohelper.findChildText(arg_1_0.go, "#scroll_taskdes/Viewport/#txt_taskdes")
	arg_1_0._scrollrewards = gohelper.findChildScrollRect(arg_1_0.go, "#scroll_rewards")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.go, "#scroll_rewards/Viewport/content/#go_rewards")
	arg_1_0._btnnotfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.go, "#btn_notfinishbg")
	arg_1_0._btnfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.go, "#btn_finishbg")
	arg_1_0._goallfinish = gohelper.findChild(arg_1_0.go, "#go_allfinish")
	arg_1_0._anim = arg_1_0.go:GetComponent(gohelper.Type_Animator)

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

function var_0_0.initData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0._index = arg_4_1
	arg_4_0.go = arg_4_2
	arg_4_0.view = arg_4_3

	arg_4_0:onInitView()
	arg_4_0:addEvents()
	gohelper.setActive(arg_4_0.go, false)
end

function var_0_0.onDestroy(arg_5_0)
	UIBlockMgr.instance:endBlock(var_0_0.BLOCK_KEY)
	arg_5_0:removeEvents()
	arg_5_0:onDestroyView()
end

function var_0_0.onClose(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.onFinishAnimCompleted, arg_6_0)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._click = gohelper.getClickWithAudio(arg_7_0.go)
	arg_7_0._iconList = {}
end

function var_0_0.onDestroyView(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0._iconList) do
		gohelper.setActive(iter_8_1.go, true)
		gohelper.destroy(iter_8_1.go)
	end

	arg_8_0._iconList = nil
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0._mo = arg_9_1

	arg_9_0:_playAnim(UIAnimationName.Idle, 0, 0)
	arg_9_0:refreshInfo()
	arg_9_0:refreshAllRewardIcons()
end

function var_0_0.refreshInfo(arg_10_0)
	local var_10_0 = arg_10_0._mo.config
	local var_10_1 = arg_10_0._mo.taskMO

	arg_10_0._txttaskdes.text = var_10_0.desc
	arg_10_0._txtprogress.text = tostring(arg_10_0._mo:getProgress())
	arg_10_0._txtmaxprogress.text = tostring(var_10_0.maxProgress)

	if arg_10_0._mo:isLock() then
		gohelper.setActive(arg_10_0._btnnotfinishbg.gameObject, true)
		gohelper.setActive(arg_10_0._btnfinishbg.gameObject, false)
		gohelper.setActive(arg_10_0._goallfinish, false)
	else
		arg_10_0:refreshButtonRunning()
	end

	arg_10_0._scrolltaskdes.horizontalNormalizedPosition = 0
end

function var_0_0.refreshButtonRunning(arg_11_0)
	if arg_11_0._mo:alreadyGotReward() then
		arg_11_0:refreshWhenFinished()
	else
		local var_11_0 = arg_11_0._mo:isFinished()

		gohelper.setActive(arg_11_0._btnnotfinishbg.gameObject, not var_11_0)
		gohelper.setActive(arg_11_0._btnfinishbg.gameObject, var_11_0)
		gohelper.setActive(arg_11_0._goallfinish, false)
	end
end

function var_0_0.refreshWhenFinished(arg_12_0)
	gohelper.setActive(arg_12_0._btnnotfinishbg.gameObject, false)
	gohelper.setActive(arg_12_0._btnfinishbg.gameObject, false)
	gohelper.setActive(arg_12_0._goallfinish, true)
end

function var_0_0.refreshAllRewardIcons(arg_13_0)
	arg_13_0:hideAllRewardIcon()

	local var_13_0 = string.split(arg_13_0._mo.config.bonus, "|")

	for iter_13_0 = 1, #var_13_0 do
		local var_13_1 = arg_13_0:getOrCreateIcon(iter_13_0)

		gohelper.setActive(var_13_1.go, true)

		local var_13_2 = string.splitToNumber(var_13_0[iter_13_0], "#")

		var_13_1.itemIcon:setMOValue(var_13_2[1], var_13_2[2], var_13_2[3], nil, true)
		var_13_1.itemIcon:isShowCount(var_13_2[1] ~= MaterialEnum.MaterialType.Hero)
		var_13_1.itemIcon:setCountFontSize(40)
		var_13_1.itemIcon:showStackableNum2()
		var_13_1.itemIcon:setHideLvAndBreakFlag(true)
		var_13_1.itemIcon:hideEquipLvAndBreak(true)

		if var_13_2[1] == 9 and var_13_1.itemIcon and var_13_1.itemIcon._equipIcon and var_13_1.itemIcon._equipIcon.viewGO then
			local var_13_3 = gohelper.findChildImage(var_13_1.itemIcon._equipIcon.viewGO, "bg")

			if var_13_3 then
				UISpriteSetMgr.instance:setCommonSprite(var_13_3, "bgequip3")
			end
		end
	end

	arg_13_0._scrollrewards.horizontalNormalizedPosition = 0
end

function var_0_0.getOrCreateIcon(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._iconList[arg_14_1]

	if not var_14_0 then
		var_14_0 = arg_14_0:getUserDataTb_()
		var_14_0.go = gohelper.cloneInPlace(arg_14_0._gorewarditem)

		gohelper.setActive(var_14_0.go, true)

		var_14_0.itemIcon = IconMgr.instance:getCommonPropItemIcon(var_14_0.go)
		arg_14_0._iconList[arg_14_1] = var_14_0
	end

	return var_14_0
end

function var_0_0.hideAllRewardIcon(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0._iconList) do
		gohelper.setActive(iter_15_1.go, false)
	end
end

function var_0_0._btnnotfinishbgOnClick(arg_16_0)
	local var_16_0 = ActivityWarmUpModel.instance:getOrderMo(arg_16_0._mo.config.orderid)

	if var_16_0 and var_16_0.cfg.jumpId ~= 0 then
		SportsNewsController.instance:jumpToFinishTask(var_16_0, arg_16_0.jumpCallback, arg_16_0)
	else
		local var_16_1 = arg_16_0._mo.config.openDay

		ActivityWarmUpController.instance:switchTab(var_16_1)
		ActivityWarmUpTaskController.instance:dispatchEvent(ActivityWarmUpEvent.TaskListNeedClose)
	end
end

function var_0_0.jumpCallback(arg_17_0)
	return
end

var_0_0.BLOCK_KEY = "ActivityWarmUpTaskItemBlock"

function var_0_0._btnfinishbgOnClick(arg_18_0)
	arg_18_0:refreshWhenFinished()
	arg_18_0:_playAnim(UIAnimationName.Finish, 0, 0)
	UIBlockMgr.instance:startBlock(var_0_0.BLOCK_KEY)
	TaskDispatcher.runDelay(arg_18_0.onFinishAnimCompleted, arg_18_0, 0.4)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_task_slide)
end

function var_0_0.onFinishAnimCompleted(arg_19_0)
	UIBlockMgr.instance:endBlock(var_0_0.BLOCK_KEY)
	gohelper.setActive(arg_19_0._goclick, true)
	TaskRpc.instance:sendFinishTaskRequest(arg_19_0._mo.id)
end

function var_0_0.getOrderCo(arg_20_0, arg_20_1)
	return (Activity106Config.instance:getActivityWarmUpOrderCo(VersionActivity1_5Enum.ActivityId.SportsNews, arg_20_1))
end

function var_0_0._playOpenInner(arg_21_0)
	gohelper.setActive(arg_21_0.go, true)
	arg_21_0:_playAnim(UIAnimationName.Open, 0, 0)
end

function var_0_0._playAnim(arg_22_0, arg_22_1, ...)
	if arg_22_0._anim then
		arg_22_0._anim:Play(arg_22_1, ...)
	end
end

return var_0_0
