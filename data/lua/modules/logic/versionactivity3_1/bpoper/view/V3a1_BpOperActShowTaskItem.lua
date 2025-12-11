module("modules.logic.versionactivity3_1.bpoper.view.V3a1_BpOperActShowTaskItem", package.seeall)

local var_0_0 = class("V3a1_BpOperActShowTaskItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.go = arg_1_1
	arg_1_0._config = arg_1_2
	arg_1_0._index = arg_1_3
	arg_1_0._anim = arg_1_1:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._txttaskdes = gohelper.findChildText(arg_1_1, "#txt_taskdes")
	arg_1_0._txttotal = gohelper.findChildText(arg_1_1, "#txt_taskdes/#txt_total")
	arg_1_0._gobonus = gohelper.findChild(arg_1_1, "#go_bonus")
	arg_1_0._goitem = gohelper.findChild(arg_1_1, "#go_bonus/go_item")
	arg_1_0._gonotget = gohelper.findChild(arg_1_1, "#go_notget")
	arg_1_0._btnnotfinishbg = gohelper.findChildButtonWithAudio(arg_1_1, "#go_notget/#btn_notfinishbg")
	arg_1_0._btnfinishbg = gohelper.findChildButtonWithAudio(arg_1_1, "#go_notget/#btn_finishbg")
	arg_1_0._goallfinish = gohelper.findChild(arg_1_1, "#go_notget/#go_allfinish")
	arg_1_0._goicon = gohelper.findChild(arg_1_1, "#go_notget/#go_allfinish/icon")
	arg_1_0._goicon2 = gohelper.findChild(arg_1_1, "#go_notget/#go_allfinish/icon2")
	arg_1_0._goprogress = gohelper.findChild(arg_1_1, "#go_notget/#btn_progress")

	gohelper.setActive(arg_1_0.go, false)
	arg_1_0:addEvents()
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnnotfinishbg:AddClickListener(arg_2_0._btnnotfinishbgOnClick, arg_2_0)
	arg_2_0._btnfinishbg:AddClickListener(arg_2_0._btnfinishbgOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnnotfinishbg:RemoveClickListener()
	arg_3_0._btnfinishbg:RemoveClickListener()
end

function var_0_0.show(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 and arg_4_2 then
		gohelper.setActive(arg_4_0.go, false)
		TaskDispatcher.runDelay(function()
			gohelper.setActive(arg_4_0.go, true)
			arg_4_0._anim:Play("open", 0, 0)
		end, nil, 0.03 * arg_4_0._index)

		return
	end

	gohelper.setActive(arg_4_0.go, arg_4_1)
end

function var_0_0._btnnotfinishbgOnClick(arg_6_0)
	if arg_6_0._config.jumpId > 0 then
		GameFacade.jump(arg_6_0._config.jumpId)
	end
end

function var_0_0._btnfinishbgOnClick(arg_7_0)
	arg_7_0._anim:Play("get", 0, 0)
	TaskDispatcher.runDelay(arg_7_0._delayFinish, arg_7_0, 0.5)
end

function var_0_0._delayFinish(arg_8_0)
	TaskRpc.instance:sendFinishTaskRequest(arg_8_0._config.id)
end

function var_0_0.refresh(arg_9_0)
	arg_9_0._taskMO = TaskModel.instance:getTaskById(arg_9_0._config.id)
	arg_9_0._txttaskdes.text = arg_9_0._config.desc
	arg_9_0._txttotal.text = string.format("%s/%s", arg_9_0._taskMO.progress, arg_9_0._config.maxProgress)

	gohelper.setActive(arg_9_0._gonotget, true)

	local var_9_0 = BpModel.instance:isMaxLevel()
	local var_9_1 = not var_9_0 and not arg_9_0._taskMO.hasFinished and arg_9_0._taskMO.progress < arg_9_0._config.maxProgress and arg_9_0._config.jumpId == 0
	local var_9_2 = not var_9_0 and not arg_9_0._taskMO.hasFinished and arg_9_0._taskMO.progress < arg_9_0._config.maxProgress and arg_9_0._config.jumpId > 0
	local var_9_3 = not var_9_0 and arg_9_0._taskMO.hasFinished and arg_9_0._taskMO.finishCount == 0
	local var_9_4 = arg_9_0._taskMO.finishCount > 0 or var_9_0

	gohelper.setActive(arg_9_0._goprogress, var_9_1)
	gohelper.setActive(arg_9_0._btnnotfinishbg.gameObject, var_9_2)
	gohelper.setActive(arg_9_0._btnfinishbg.gameObject, var_9_3)
	gohelper.setActive(arg_9_0._goallfinish, var_9_4)

	local var_9_5 = arg_9_0._taskMO.finishCount > 0
	local var_9_6 = var_9_0 and arg_9_0._taskMO.finishCount == 0

	gohelper.setActive(arg_9_0._goicon, var_9_5)
	gohelper.setActive(arg_9_0._goicon2, var_9_6)

	if not arg_9_0._rewardItem then
		arg_9_0._rewardItem = IconMgr.instance:getCommonPropItemIcon(arg_9_0._goitem)
	end

	arg_9_0._rewardItem:setMOValue(1, BpEnum.ScoreItemId, arg_9_0._config.bonusScore, nil, true)
	arg_9_0._rewardItem:setCountFontSize(36)
	arg_9_0._rewardItem:setScale(0.54)
	arg_9_0._rewardItem:SetCountLocalY(42)
	arg_9_0._rewardItem:SetCountBgHeight(22)
	arg_9_0._rewardItem:showStackableNum2()
	arg_9_0._rewardItem:setHideLvAndBreakFlag(true)
	arg_9_0._rewardItem:hideEquipLvAndBreak(true)
end

function var_0_0.destroy(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._delayFinish, arg_10_0)
	arg_10_0:removeEvents()
end

return var_0_0
