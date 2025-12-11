module("modules.logic.necrologiststory.view.NecrologistStoryTaskItem", package.seeall)

local var_0_0 = class("NecrologistStoryTaskItem", ListScrollCellExtend)

var_0_0.BlockKey = "NecrologistStoryTaskItemAni"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goNormal = gohelper.findChild(arg_1_0.viewGO, "#goNormal")
	arg_1_0._goTotal = gohelper.findChild(arg_1_0.viewGO, "#goTotal")
	arg_1_0._ani = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_1_0:initNormal()
	arg_1_0:initTotal()
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnGoto:AddClickListener(arg_2_0.onClickGoto, arg_2_0)
	arg_2_0._btnReceive:AddClickListener(arg_2_0.onClickReceive, arg_2_0)
	arg_2_0._btnGetTotal:AddClickListener(arg_2_0.onClickGetTotal, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnGoto:RemoveClickListener()
	arg_3_0._btnReceive:RemoveClickListener()
	arg_3_0._btnGetTotal:RemoveClickListener()
end

function var_0_0.initNormal(arg_4_0)
	arg_4_0._txtCurCount = gohelper.findChildTextMesh(arg_4_0._goNormal, "#txt_curcount")
	arg_4_0._txtMaxCount = gohelper.findChildTextMesh(arg_4_0._goNormal, "#txt_curcount/#txt_maxcount")
	arg_4_0._txtDesc = gohelper.findChildTextMesh(arg_4_0._goNormal, "#txt_desc")
	arg_4_0._scrollreward = gohelper.findChild(arg_4_0._goNormal, "#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_4_0._gocontent = gohelper.findChild(arg_4_0._goNormal, "#scroll_rewards/Viewport/Content")
	arg_4_0._goRewardTemplate = gohelper.findChild(arg_4_0._gocontent, "#go_rewarditem")

	gohelper.setActive(arg_4_0._goRewardTemplate, false)

	arg_4_0._goMask = gohelper.findChild(arg_4_0._goNormal, "#go_blackmask")
	arg_4_0._goFinish = gohelper.findChild(arg_4_0._goNormal, "#go_finish")
	arg_4_0._goGoto = gohelper.findChild(arg_4_0._goNormal, "#btn_goto")
	arg_4_0._btnGoto = gohelper.findChildButtonWithAudio(arg_4_0._goNormal, "#btn_goto")
	arg_4_0._goReceive = gohelper.findChild(arg_4_0._goNormal, "#btn_receive")
	arg_4_0._btnReceive = gohelper.findChildButtonWithAudio(arg_4_0._goNormal, "#btn_receive")
	arg_4_0._goUnfinish = gohelper.findChild(arg_4_0._goNormal, "#go_unfinish")
	arg_4_0.goTime = gohelper.findChild(arg_4_0._goNormal, "#go_time")
	arg_4_0.txtTime = gohelper.findChildTextMesh(arg_4_0.goTime, "bg/txt")
end

function var_0_0.initInternal(arg_5_0, ...)
	var_0_0.super.initInternal(arg_5_0, ...)

	arg_5_0._scrollreward.parentGameObject = arg_5_0._view._csListScroll.gameObject
end

function var_0_0.initTotal(arg_6_0)
	arg_6_0._btnGetTotal = gohelper.findChildButtonWithAudio(arg_6_0._goTotal, "#btn_getall")
end

function var_0_0.getAnimator(arg_7_0)
	return arg_7_0._ani
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0.taskMo = arg_8_1

	TaskDispatcher.cancelTask(arg_8_0._frameRefreshTime, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._onPlayActAniFinished, arg_8_0)

	if arg_8_1.isTotalGet then
		arg_8_0.storyId = arg_8_1.storyId

		gohelper.setActive(arg_8_0._goNormal, false)
		gohelper.setActive(arg_8_0._goTotal, true)
	else
		gohelper.setActive(arg_8_0._goNormal, true)
		gohelper.setActive(arg_8_0._goTotal, false)
		arg_8_0:refreshNormal(arg_8_1)
	end
end

function var_0_0.hide(arg_9_0)
	gohelper.setActive(arg_9_0._viewGO, false)
end

function var_0_0.refreshNormal(arg_10_0, arg_10_1)
	arg_10_0.taskId = arg_10_1.id
	arg_10_0.jumpId = arg_10_1.config.jumpId

	gohelper.setActive(arg_10_0._viewGO, true)
	arg_10_0:refreshReward(arg_10_1)
	arg_10_0:refreshDesc(arg_10_1)
	arg_10_0:refreshProgress(arg_10_1)
	arg_10_0:refreshState(arg_10_1)
	arg_10_0:refreshTime()
end

function var_0_0.refreshReward(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.config
	local var_11_1 = DungeonConfig.instance:getRewardItems(tonumber(var_11_0.bonus))
	local var_11_2 = {}

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		local var_11_3 = {
			isIcon = true,
			materilType = iter_11_1[1],
			materilId = iter_11_1[2],
			quantity = iter_11_1[3]
		}

		table.insert(var_11_2, var_11_3)
	end

	if not arg_11_0._rewardItems then
		arg_11_0._rewardItems = {}
	end

	local var_11_4 = #var_11_2

	for iter_11_2 = 1, math.max(#arg_11_0._rewardItems, var_11_4) do
		local var_11_5 = var_11_2[iter_11_2]
		local var_11_6 = arg_11_0._rewardItems[iter_11_2] or arg_11_0:createRewardItem(iter_11_2)

		arg_11_0:refreshRewardItem(var_11_6, var_11_5)
	end

	if arg_11_0.dataCount and arg_11_0.dataCount ~= var_11_4 then
		recthelper.setAnchorX(arg_11_0._gocontent.transform, 0)
	end

	arg_11_0.dataCount = var_11_4
end

function var_0_0.createRewardItem(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getUserDataTb_()
	local var_12_1 = gohelper.clone(arg_12_0._goRewardTemplate, arg_12_0._gocontent, "reward_" .. tostring(arg_12_1))

	var_12_0.go = var_12_1
	var_12_0.itemParent = gohelper.findChild(var_12_1, "go_prop")
	var_12_0.cardParent = gohelper.findChild(var_12_1, "go_card")
	arg_12_0._rewardItems[arg_12_1] = var_12_0

	return var_12_0
end

function var_0_0.refreshRewardItem(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_2 then
		gohelper.setActive(arg_13_1.go, false)

		return
	end

	gohelper.setActive(arg_13_1.go, true)
	gohelper.setActive(arg_13_1.cardParent, false)
	gohelper.setActive(arg_13_1.itemParent, true)

	if not arg_13_1.itemIcon then
		arg_13_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(arg_13_1.itemParent)
	end

	arg_13_1.itemIcon:onUpdateMO(arg_13_2)
	arg_13_1.itemIcon:isShowCount(true)
	arg_13_1.itemIcon:setCountFontSize(40)
	arg_13_1.itemIcon:showStackableNum2()
	arg_13_1.itemIcon:setHideLvAndBreakFlag(true)
	arg_13_1.itemIcon:hideEquipLvAndBreak(true)
end

function var_0_0.refreshDesc(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.config

	arg_14_0._txtDesc.text = var_14_0.desc
end

function var_0_0.refreshProgress(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.progress
	local var_15_1 = arg_15_1.config.maxProgress

	arg_15_0._txtCurCount.text = var_15_0
	arg_15_0._txtMaxCount.text = var_15_1
end

function var_0_0.refreshState(arg_16_0, arg_16_1)
	if arg_16_1:isClaimed() then
		gohelper.setActive(arg_16_0._goMask, true)
		gohelper.setActive(arg_16_0._goFinish, true)
		gohelper.setActive(arg_16_0._goGoto, false)
		gohelper.setActive(arg_16_0._goReceive, false)
		gohelper.setActive(arg_16_0._goUnfinish, false)
	elseif arg_16_1.hasFinished then
		gohelper.setActive(arg_16_0._goMask, false)
		gohelper.setActive(arg_16_0._goFinish, false)
		gohelper.setActive(arg_16_0._goGoto, false)
		gohelper.setActive(arg_16_0._goReceive, true)
		gohelper.setActive(arg_16_0._goUnfinish, false)
	else
		gohelper.setActive(arg_16_0._goMask, false)
		gohelper.setActive(arg_16_0._goFinish, false)
		gohelper.setActive(arg_16_0._goReceive, false)

		if arg_16_0.jumpId and arg_16_0.jumpId > 0 then
			local var_16_0 = arg_16_1.config

			gohelper.setActive(arg_16_0._goGoto, true)
			gohelper.setActive(arg_16_0._goUnfinish, false)
		else
			gohelper.setActive(arg_16_0._goGoto, false)
			gohelper.setActive(arg_16_0._goUnfinish, true)
		end
	end
end

function var_0_0.onClickGoto(arg_17_0)
	if not arg_17_0.jumpId then
		return
	end

	if GameFacade.jump(arg_17_0.jumpId) then
		ViewMgr.instance:closeView(ViewName.NecrologistStoryTaskView)
	end
end

function var_0_0.onClickReceive(arg_18_0)
	if not arg_18_0.taskId then
		return
	end

	gohelper.setActive(arg_18_0._goMask, true)
	arg_18_0._ani:Play(UIAnimationName.Finish)
	UIBlockMgr.instance:startBlock(var_0_0.BlockKey)
	TaskDispatcher.runDelay(arg_18_0._onPlayActAniFinished, arg_18_0, 0.76)
end

function var_0_0.onClickGetTotal(arg_19_0)
	NecrologistStoryTaskListModel.instance:sendFinishAllTaskRequest(arg_19_0.storyId)
end

function var_0_0._onPlayActAniFinished(arg_20_0)
	UIBlockMgr.instance:endBlock(var_0_0.BlockKey)
	TaskRpc.instance:sendFinishTaskRequest(arg_20_0.taskId)
	arg_20_0:hide()
end

function var_0_0.refreshTime(arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._frameRefreshTime, arg_21_0)

	local var_21_0 = not arg_21_0.taskMo:isClaimed() and arg_21_0.taskMo.config.activityId ~= 0

	gohelper.setActive(arg_21_0.goTime, var_21_0)

	if not var_21_0 then
		return
	end

	TaskDispatcher.runDelay(arg_21_0._frameRefreshTime, arg_21_0, 1)
	arg_21_0:_frameRefreshTime()
end

function var_0_0._frameRefreshTime(arg_22_0)
	if not arg_22_0.taskMo then
		return
	end

	local var_22_0 = arg_22_0.taskMo.config.activityId
	local var_22_1 = ActivityModel.instance:getActMO(var_22_0)

	if not var_22_1 then
		return
	end

	local var_22_2 = var_22_1:getRealEndTimeStamp() - ServerTime.now()

	if var_22_2 > 0 then
		local var_22_3, var_22_4 = TimeUtil.getFormatTime1(var_22_2, true)

		arg_22_0.txtTime.text = var_22_3
	else
		TaskDispatcher.cancelTask(arg_22_0._frameRefreshTime, arg_22_0)
		gohelper.setActive(arg_22_0.goTime, false)
	end
end

function var_0_0.onDestroy(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._frameRefreshTime, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._onPlayActAniFinished, arg_23_0)
end

return var_0_0
