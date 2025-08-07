module("modules.logic.sp01.odyssey.view.OdysseyTaskItem", package.seeall)

local var_0_0 = class("OdysseyTaskItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._txttaskdes = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#txt_taskdes")
	arg_1_0._goscrollRewards = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	arg_1_0._btnnormal = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_notfinishbg")
	arg_1_0._btncanget = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_finishbg")
	arg_1_0._gohasget = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_allfinish")
	arg_1_0._gogetall = gohelper.findChild(arg_1_0.viewGO, "#go_getall")
	arg_1_0._btngetall = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_getall/#btn_getall")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnnormal:AddClickListener(arg_2_0._btnnormalOnClick, arg_2_0)
	arg_2_0._btncanget:AddClickListener(arg_2_0._btncangetOnClick, arg_2_0)
	arg_2_0._btngetall:AddClickListener(arg_2_0._btngetallOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnnormal:RemoveClickListener()
	arg_3_0._btncanget:RemoveClickListener()
	arg_3_0._btngetall:RemoveClickListener()
end

var_0_0.BlockKey = "OdysseyTaskItemRewardGetAnim"
var_0_0.TaskMaskTime = 0.65

function var_0_0._btnnormalOnClick(arg_4_0)
	if not arg_4_0.jumpId then
		return
	end

	if GameFacade.jump(arg_4_0.jumpId) then
		ViewMgr.instance:closeView(ViewName.OdysseyTaskView)
	end
end

function var_0_0._btncangetOnClick(arg_5_0)
	if not arg_5_0.taskId and not arg_5_0.mo.canGetAll then
		return
	end

	arg_5_0._animator:Play(UIAnimationName.Finish)
	UIBlockMgr.instance:startBlock(var_0_0.BlockKey)
	OdysseyController.instance:dispatchEvent(OdysseyEvent.OnTaskRewardGetFinish, arg_5_0._index)
	TaskDispatcher.runDelay(arg_5_0._onPlayActAniFinished, arg_5_0, var_0_0.TaskMaskTime)
end

function var_0_0._btngetallOnClick(arg_6_0)
	arg_6_0:_btncangetOnClick()
end

function var_0_0._onPlayActAniFinished(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._onPlayActAniFinished, arg_7_0)

	if arg_7_0.mo.canGetAll then
		local var_7_0 = OdysseyTaskModel.instance:getAllCanGetIdList()

		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Odyssey, 0, var_7_0, nil, nil, 0)
	else
		TaskRpc.instance:sendFinishTaskRequest(arg_7_0.taskId)
	end

	UIBlockMgr.instance:endBlock(var_0_0.BlockKey)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0.rewardItemTab = arg_8_0:getUserDataTb_()
	arg_8_0._animator = arg_8_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_8_0._scrollrewards = arg_8_0._goscrollRewards:GetComponent(gohelper.Type_LimitedScrollRect)
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	if arg_9_1 == nil then
		return
	end

	arg_9_0.mo = arg_9_1
	arg_9_0._scrollrewards.parentGameObject = arg_9_0._view._csListScroll.gameObject

	if arg_9_0.mo.canGetAll then
		gohelper.setActive(arg_9_0._gonormal, false)
		gohelper.setActive(arg_9_0._gogetall, true)
	else
		gohelper.setActive(arg_9_0._gonormal, true)
		gohelper.setActive(arg_9_0._gogetall, false)
		arg_9_0:refreshNormal()
	end
end

function var_0_0.checkPlayAnim(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.onDelayPlayOpen, arg_10_0)

	local var_10_0 = OdysseyTaskModel.instance:getDelayPlayTime(arg_10_0.mo)

	if var_10_0 == -1 then
		arg_10_0._animator:Play("idle", 0, 0)

		arg_10_0._animator.speed = 1
	else
		arg_10_0._animator:Play("open", 0, 0)

		arg_10_0._animator.speed = 0

		TaskDispatcher.runDelay(arg_10_0.onDelayPlayOpen, arg_10_0, var_10_0)
	end
end

function var_0_0.onDelayPlayOpen(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.onDelayPlayOpen, arg_11_0)
	arg_11_0._animator:Play("open", 0, 0)

	arg_11_0._animator.speed = 1
end

function var_0_0.refreshNormal(arg_12_0)
	arg_12_0.taskId = arg_12_0.mo.id
	arg_12_0.config = arg_12_0.mo.config
	arg_12_0.jumpId = arg_12_0.config.jumpId

	local var_12_0 = arg_12_0.config.desc

	arg_12_0._txttaskdes.text = var_12_0

	arg_12_0:refreshReward()
	arg_12_0:refreshState()
end

function var_0_0.refreshReward(arg_13_0)
	local var_13_0 = arg_13_0.mo.config
	local var_13_1 = GameUtil.splitString2(var_13_0.bonus, true)

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		local var_13_2 = arg_13_0.rewardItemTab[iter_13_0]

		if not var_13_2 then
			var_13_2 = {
				itemIcon = IconMgr.instance:getCommonPropItemIcon(arg_13_0._gorewards)
			}
			arg_13_0.rewardItemTab[iter_13_0] = var_13_2
		end

		var_13_2.itemIcon:setMOValue(iter_13_1[1], iter_13_1[2], iter_13_1[3])
		var_13_2.itemIcon:isShowCount(true)
		var_13_2.itemIcon:setCountFontSize(40)
		var_13_2.itemIcon:showStackableNum2()
		var_13_2.itemIcon:setHideLvAndBreakFlag(true)
		var_13_2.itemIcon:hideEquipLvAndBreak(true)
		gohelper.setActive(var_13_2.itemIcon.go, true)
	end

	for iter_13_2 = #var_13_1 + 1, #arg_13_0.rewardItemTab do
		local var_13_3 = arg_13_0.rewardItemTab[iter_13_2]

		if var_13_3 then
			gohelper.setActive(var_13_3.itemIcon.go, false)
		end
	end

	gohelper.setActive(arg_13_0._gorewards, false)
	TaskDispatcher.runDelay(arg_13_0.setRewardsShow, arg_13_0, 0.01)
end

function var_0_0.setRewardsShow(arg_14_0)
	gohelper.setActive(arg_14_0._gorewards, true)
end

function var_0_0.refreshState(arg_15_0)
	if OdysseyTaskModel.instance:isTaskHasGet(arg_15_0.mo) then
		gohelper.setActive(arg_15_0._gohasget, true)
		gohelper.setActive(arg_15_0._btnnormal.gameObject, false)
		gohelper.setActive(arg_15_0._btncanget.gameObject, false)
	elseif arg_15_0.mo.hasFinished then
		gohelper.setActive(arg_15_0._gohasget, false)
		gohelper.setActive(arg_15_0._btnnormal.gameObject, false)
		gohelper.setActive(arg_15_0._btncanget.gameObject, true)
	else
		gohelper.setActive(arg_15_0._gohasget, false)
		gohelper.setActive(arg_15_0._btnnormal.gameObject, arg_15_0.jumpId and arg_15_0.jumpId > 0)
		gohelper.setActive(arg_15_0._btncanget.gameObject, false)
	end
end

function var_0_0.getAnimator(arg_16_0)
	return arg_16_0._animator
end

function var_0_0.onDestroyView(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._onPlayActAniFinished, arg_17_0)

	if arg_17_0.rewardItemTab then
		for iter_17_0, iter_17_1 in pairs(arg_17_0.rewardItemTab) do
			if iter_17_1.itemIcon then
				iter_17_1.itemIcon:onDestroy()

				iter_17_1.itemIcon = nil
			end
		end

		arg_17_0.rewardItemTab = nil
	end

	TaskDispatcher.cancelTask(arg_17_0.setRewardsShow, arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._onPlayActAniFinished, arg_17_0)
end

return var_0_0
