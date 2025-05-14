module("modules.logic.turnback.view.new.view.TurnbackNewTaskItem", package.seeall)

local var_0_0 = class("TurnbackNewTaskItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._simagenormalbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_normal/#simage_normalbg")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num")
	arg_1_0._txttotal = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	arg_1_0._txttaskdes = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#txt_taskdes")
	arg_1_0._scrollrewards = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_1_0._goRewardContent = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	arg_1_0._godaily = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_daily")
	arg_1_0._btnnotfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_notfinishbg")
	arg_1_0._btnfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_finishbg")
	arg_1_0._goallfinish = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_allfinish")
	arg_1_0.rewardItemList = {}
	arg_1_0.animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

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

function var_0_0._btnnotfinishbgOnClick(arg_4_0)
	local var_4_0 = arg_4_0.taskMo.config.jumpId

	if var_4_0 ~= 0 then
		GameFacade.jump(var_4_0)
	end
end

function var_0_0._btnfinishbgOnClick(arg_5_0)
	UIBlockMgr.instance:startBlock("TurnbackTaskItemFinish")
	TaskDispatcher.runDelay(arg_5_0.finishTask, arg_5_0, TurnbackEnum.TaskMaskTime)
	TurnbackController.instance:dispatchEvent(TurnbackEvent.OnTaskRewardGetFinish, arg_5_0._index)
	arg_5_0.animator:Play(UIAnimationName.Finish, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_task_slide)
end

function var_0_0.finishTask(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.finishTask, arg_6_0)
	UIBlockMgr.instance:endBlock("TurnbackTaskItemFinish")
	TaskRpc.instance:sendFinishTaskRequest(arg_6_0.taskMo.id)
end

function var_0_0._editableInitView(arg_7_0)
	return
end

function var_0_0._editableAddEvents(arg_8_0)
	return
end

function var_0_0._editableRemoveEvents(arg_9_0)
	return
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	arg_10_0.taskMo = arg_10_1
	arg_10_0._scrollrewards.parentGameObject = arg_10_0._view._csListScroll.gameObject

	gohelper.setActive(arg_10_0._gonormal, not arg_10_0.taskMo.getAll)

	arg_10_0.co = arg_10_0.taskMo.config
	arg_10_0._txttaskdes.text = arg_10_0.co.desc
	arg_10_0._txtnum.text = arg_10_0.taskMo.progress
	arg_10_0._txttotal.text = arg_10_0.co.maxProgress

	local var_10_0 = arg_10_0.taskMo.config.loopType == 1

	gohelper.setActive(arg_10_0._godaily, var_10_0)

	if arg_10_0.taskMo.finishCount > 0 then
		gohelper.setActive(arg_10_0._btnnotfinishbg.gameObject, false)
		gohelper.setActive(arg_10_0._btnfinishbg.gameObject, false)
		gohelper.setActive(arg_10_0._goallfinish, true)
	elseif arg_10_0.taskMo.hasFinished then
		gohelper.setActive(arg_10_0._btnfinishbg.gameObject, true)
		gohelper.setActive(arg_10_0._btnnotfinishbg.gameObject, false)
		gohelper.setActive(arg_10_0._goallfinish, false)
	else
		gohelper.setActive(arg_10_0._btnnotfinishbg.gameObject, true)
		gohelper.setActive(arg_10_0._goallfinish, false)
		gohelper.setActive(arg_10_0._btnfinishbg.gameObject, false)
	end

	arg_10_0:refreshRewardItems()
end

function var_0_0.refreshRewardItems(arg_11_0)
	local var_11_0 = arg_11_0.co.bonus

	if string.nilorempty(var_11_0) then
		gohelper.setActive(arg_11_0._scrollrewards.gameObject, false)

		return
	end

	gohelper.setActive(arg_11_0._scrollrewards.gameObject, true)

	local var_11_1 = GameUtil.splitString2(var_11_0, true, "|", "#")

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		local var_11_2 = iter_11_1[1]
		local var_11_3 = iter_11_1[2]
		local var_11_4 = iter_11_1[3]
		local var_11_5 = arg_11_0.rewardItemList[iter_11_0]

		if not var_11_5 then
			var_11_5 = IconMgr.instance:getCommonPropItemIcon(arg_11_0._goRewardContent)

			var_11_5:setMOValue(var_11_2, var_11_3, var_11_4, nil, true)
			table.insert(arg_11_0.rewardItemList, var_11_5)
		else
			var_11_5:setMOValue(var_11_2, var_11_3, var_11_4, nil, true)
		end

		var_11_5:setCountFontSize(40)
		var_11_5:showStackableNum2()
		var_11_5:isShowEffect(true)
		gohelper.setActive(var_11_5.go, true)
	end

	for iter_11_2 = #var_11_1 + 1, #arg_11_0.rewardItemList do
		gohelper.setActive(arg_11_0.rewardItemList[iter_11_2].go, false)
	end

	arg_11_0._scrollrewards.horizontalNormalizedPosition = 0

	arg_11_0.animator:Play(UIAnimationName.Idle, 0, 0)
end

function var_0_0.onSelect(arg_12_0, arg_12_1)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0.finishTask, arg_13_0)
end

return var_0_0
