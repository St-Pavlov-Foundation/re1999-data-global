module("modules.logic.fight.view.FightNewProgressView5", package.seeall)

local var_0_0 = class("FightNewProgressView5", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.imgBgProgress = gohelper.findChildImage(arg_1_0.viewGO, "container/imgPre")
	arg_1_0.imgProgress = gohelper.findChildImage(arg_1_0.viewGO, "container/imgHp")
	arg_1_0.animator = gohelper.findChildComponent(arg_1_0.viewGO, "container", typeof(UnityEngine.Animator))
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registMsg(FightMsgId.NewProgressValueChange, arg_2_0.onNewProgressValueChange)
	arg_2_0:com_registFightEvent(FightEvent.StageChanged, arg_2_0.onStageChanged)

	arg_2_0.tweenComp = arg_2_0:addComponent(FightTweenComponent)
end

function var_0_0.onConstructor(arg_3_0, arg_3_1)
	arg_3_0.data = arg_3_1
	arg_3_0.id = arg_3_0.data.id
end

function var_0_0.onStageChanged(arg_4_0, arg_4_1)
	arg_4_0.tweenComp:KillTweenByObj(arg_4_0.imgProgress)

	arg_4_0.imgProgress.fillAmount = arg_4_0.data.value / arg_4_0.data.max

	if arg_4_1 == FightStageMgr.StageType.Operate then
		arg_4_0.imgProgress.fillAmount = (arg_4_0.data.value - arg_4_0.preDecrease) / arg_4_0.data.max
	elseif arg_4_1 == FightStageMgr.StageType.Play then
		-- block empty
	end
end

function var_0_0.onOpen(arg_5_0)
	local var_5_0 = OdysseyConfig.instance:getConstConfig(22)

	arg_5_0.preDecrease = tonumber(var_5_0.value) or 0

	local var_5_1 = arg_5_0.data.value / arg_5_0.data.max

	arg_5_0.imgProgress.fillAmount = var_5_1
	arg_5_0.imgBgProgress.fillAmount = var_5_1
end

function var_0_0.onNewProgressValueChange(arg_6_0, arg_6_1)
	if arg_6_1 ~= arg_6_0.id then
		return
	end

	local var_6_0 = arg_6_0.data.value / arg_6_0.data.max
	local var_6_1 = arg_6_0:com_registFlowParallel()
	local var_6_2 = 0.2

	var_6_1:registWork(FightTweenWork, {
		type = "DOFillAmount",
		img = arg_6_0.imgProgress,
		to = var_6_0,
		t = var_6_2
	})

	local var_6_3 = var_6_1:registWork(FightWorkFlowSequence)

	var_6_3:registWork(FightWorkDelayTimer, 0.2)
	var_6_3:registWork(FightTweenWork, {
		type = "DOFillAmount",
		img = arg_6_0.imgBgProgress,
		to = var_6_0,
		t = var_6_2
	})
	FightMsgMgr.replyMsg(FightMsgId.NewProgressValueChange, var_6_1)
	arg_6_0.animator:Play("open", 0, 0)
end

return var_0_0
