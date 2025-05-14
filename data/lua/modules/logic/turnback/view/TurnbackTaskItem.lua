module("modules.logic.turnback.view.TurnbackTaskItem", package.seeall)

local var_0_0 = class("TurnbackTaskItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._gocommon = gohelper.findChild(arg_1_1, "#go_common")
	arg_1_0._goline = gohelper.findChild(arg_1_1, "#go_common/#go_line")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_1, "#go_common/#simage_bg")
	arg_1_0._txttaskdes = gohelper.findChildText(arg_1_1, "#go_common/info/#txt_taskdes")
	arg_1_0._txtprocess = gohelper.findChildText(arg_1_1, "#go_common/info/#txt_process")
	arg_1_0._scrollreward = gohelper.findChild(arg_1_1, "#go_common/#scroll_reward"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_1_0._gorewardContent = gohelper.findChild(arg_1_1, "#go_common/#scroll_reward/Viewport/#go_rewardContent")
	arg_1_0._gonotget = gohelper.findChild(arg_1_1, "#go_common/#go_notget")
	arg_1_0._btngoto = gohelper.findChildButtonWithAudio(arg_1_1, "#go_common/#go_notget/#btn_goto")
	arg_1_0._btncanget = gohelper.findChildButtonWithAudio(arg_1_1, "#go_common/#go_notget/#btn_canget")
	arg_1_0._godoing = gohelper.findChild(arg_1_1, "#go_common/#go_notget/#go_doing")
	arg_1_0._goget = gohelper.findChild(arg_1_1, "#go_common/#go_get")
	arg_1_0._goreddot = gohelper.findChild(arg_1_1, "#go_common/#go_reddot")
	arg_1_0._animator = arg_1_0.go:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._rewardTab = {}
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btngoto:AddClickListener(arg_2_0._btngotoOnClick, arg_2_0)
	arg_2_0._btncanget:AddClickListener(arg_2_0._btncangetOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btngoto:RemoveClickListener()
	arg_3_0._btncanget:RemoveClickListener()
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	if arg_4_1 == nil then
		return
	end

	arg_4_0.mo = arg_4_1
	arg_4_0._scrollreward.parentGameObject = arg_4_0._view._csListScroll.gameObject

	local var_4_0 = arg_4_0.mo.progress < arg_4_0.mo.config.maxProgress and "<color=#d97373>%s/%s</color>" or "%s/%s"

	arg_4_0._txttaskdes.text = arg_4_0.mo.config.desc
	arg_4_0._txtprocess.text = string.format(var_4_0, arg_4_0.mo.progress, arg_4_0.mo.config.maxProgress)

	gohelper.setActive(arg_4_0._goline, arg_4_0._index ~= 1)

	local var_4_1 = arg_4_0.mo.progress
	local var_4_2 = arg_4_0.mo.config.maxProgress

	gohelper.setActive(arg_4_0._btngoto.gameObject, var_4_1 < var_4_2 and arg_4_0.mo.config.jumpId > 0)
	gohelper.setActive(arg_4_0._godoing.gameObject, var_4_1 < var_4_2 and arg_4_0.mo.config.jumpId == 0)
	gohelper.setActive(arg_4_0._btncanget.gameObject, var_4_2 <= var_4_1 and arg_4_0.mo.finishCount == 0)
	gohelper.setActive(arg_4_0._goreddot, false)
	gohelper.setActive(arg_4_0._goget, arg_4_0.mo.finishCount > 0)

	local var_4_3 = string.split(arg_4_0.mo.config.bonus, "|")

	for iter_4_0 = 1, #var_4_3 do
		local var_4_4 = arg_4_0._rewardTab[iter_4_0]

		if not var_4_4 then
			var_4_4 = IconMgr.instance:getCommonPropItemIcon(arg_4_0._gorewardContent)

			table.insert(arg_4_0._rewardTab, var_4_4)
		end

		local var_4_5 = string.split(var_4_3[iter_4_0], "#")

		var_4_4:setMOValue(var_4_5[1], var_4_5[2], var_4_5[3])
		var_4_4:setPropItemScale(0.6)
		var_4_4:setHideLvAndBreakFlag(true)
		var_4_4:hideEquipLvAndBreak(true)
		var_4_4:setCountFontSize(51)
		gohelper.setActive(var_4_4.go, true)
	end

	for iter_4_1 = #var_4_3 + 1, #arg_4_0._rewardTab do
		gohelper.setActive(arg_4_0._rewardTab[iter_4_1].go, false)
	end

	arg_4_0._scrollreward.horizontalNormalizedPosition = 0

	arg_4_0._animator:Play(UIAnimationName.Idle, 0, 0)
end

function var_0_0._btngotoOnClick(arg_5_0)
	local var_5_0 = arg_5_0.mo.config.jumpId

	if var_5_0 ~= 0 then
		GameFacade.jump(var_5_0)
	end
end

function var_0_0._btncangetOnClick(arg_6_0)
	if not TurnbackModel.instance:isInOpenTime() then
		return
	end

	UIBlockMgr.instance:startBlock("TurnbackTaskItemFinish")
	TaskDispatcher.runDelay(arg_6_0.finishTask, arg_6_0, TurnbackEnum.TaskMaskTime)
	TurnbackController.instance:dispatchEvent(TurnbackEvent.OnTaskRewardGetFinish, arg_6_0._index)
	arg_6_0._animator:Play(UIAnimationName.Finish, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_task_slide)
end

function var_0_0.finishTask(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.finishTask, arg_7_0)
	UIBlockMgr.instance:endBlock("TurnbackTaskItemFinish")
	TaskRpc.instance:sendFinishTaskRequest(arg_7_0.mo.id)
end

function var_0_0.onDestroy(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.finishTask, arg_8_0)
end

return var_0_0
