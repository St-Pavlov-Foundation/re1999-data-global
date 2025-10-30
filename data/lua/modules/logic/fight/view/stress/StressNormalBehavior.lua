module("modules.logic.fight.view.stress.StressNormalBehavior", package.seeall)

local var_0_0 = class("StressNormalBehavior", StressBehaviorBase)

var_0_0.BehaviourAnimDuration = 1
var_0_0.Behaviour2AudioId = {
	[FightEnum.StressBehaviour.Meltdown] = 20211405,
	[FightEnum.StressBehaviour.Resolute] = 20211404
}

function var_0_0.initUI(arg_1_0)
	arg_1_0.stressText = gohelper.findChildText(arg_1_0.instanceGo, "#txt_stress")
	arg_1_0.goBlue = gohelper.findChild(arg_1_0.instanceGo, "blue")
	arg_1_0.goRed = gohelper.findChild(arg_1_0.instanceGo, "red")
	arg_1_0.goBroken = gohelper.findChild(arg_1_0.instanceGo, "broken")
	arg_1_0.goStaunch = gohelper.findChild(arg_1_0.instanceGo, "staunch")
	arg_1_0.click = gohelper.findChildClickWithDefaultAudio(arg_1_0.instanceGo, "#go_clickarea")

	arg_1_0.click:AddClickListener(arg_1_0.onClickStress, arg_1_0)

	arg_1_0.statusDict = {}
	arg_1_0.statusDict[FightEnum.Status.Positive] = arg_1_0:createStatusItem(arg_1_0.goBlue)
	arg_1_0.statusDict[FightEnum.Status.Negative] = arg_1_0:createStatusItem(arg_1_0.goRed)
	arg_1_0.animGoDict = arg_1_0:getUserDataTb_()
	arg_1_0.animGoDict[FightEnum.StressBehaviour.Meltdown] = arg_1_0.goBroken
	arg_1_0.animGoDict[FightEnum.StressBehaviour.Resolute] = arg_1_0.goStaunch
end

function var_0_0.createStatusItem(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:getUserDataTb_()

	var_2_0.go = arg_2_1
	var_2_0.txtStress = gohelper.findChildText(var_2_0.go, "add/#txt_stress")
	var_2_0.animator = var_2_0.go:GetComponent(gohelper.Type_Animator)

	return var_2_0
end

function var_0_0.onClickStress(arg_3_0)
	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	local var_3_0 = arg_3_0.entity:getMO()

	if var_3_0.side == FightEnum.EntitySide.MySide then
		StressTipController.instance:openHeroStressTip(var_3_0:getCO())
	else
		StressTipController.instance:openMonsterStressTip(var_3_0:getCO())
	end
end

function var_0_0.refreshUI(arg_4_0)
	local var_4_0 = arg_4_0:getCurStress()

	arg_4_0.stressText.text = var_4_0

	arg_4_0:updateStatus()
end

function var_0_0.updateStatus(arg_5_0)
	arg_5_0:resetGo()

	local var_5_0 = arg_5_0:getCurStress()
	local var_5_1 = FightEnum.MonsterId2StressThresholdDict[arg_5_0.monsterId]

	arg_5_0.status = FightHelper.getStressStatus(var_5_0, var_5_1)

	local var_5_2 = arg_5_0.status and arg_5_0.statusDict[arg_5_0.status]

	if var_5_2 then
		gohelper.setActive(var_5_2.go, true)
	end
end

function var_0_0.resetGo(arg_6_0)
	gohelper.setActive(arg_6_0.goBlue, false)
	gohelper.setActive(arg_6_0.goRed, false)
	gohelper.setActive(arg_6_0.goBroken, false)
	gohelper.setActive(arg_6_0.goStaunch, false)
end

function var_0_0.onPowerChange(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_0.playBehaviouring then
		return
	end

	if arg_7_0.entityId ~= arg_7_1 then
		return
	end

	if FightEnum.PowerType.Stress ~= arg_7_2 then
		return
	end

	if arg_7_3 == arg_7_4 then
		return
	end

	arg_7_0:refreshUI()
	arg_7_0:playStressValueChangeAnim()
end

function var_0_0.playStressValueChangeAnim(arg_8_0)
	if arg_8_0.playBehaviouring then
		return
	end

	if not arg_8_0.status then
		return
	end

	local var_8_0 = arg_8_0.statusDict[arg_8_0.status]

	if var_8_0 then
		var_8_0.animator:Play("up", 0, 0)

		var_8_0.txtStress.text = arg_8_0:getCurStress()
	else
		arg_8_0:log(string.format("压力值item为nil。cur status : %s, cur stress : %s", arg_8_0.status, arg_8_0:getCurStress()))
	end
end

function var_0_0.triggerStressBehaviour(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0.entityId ~= arg_9_1 then
		return
	end

	if FightEnum.StressBehaviour.Resolute ~= arg_9_2 and FightEnum.StressBehaviour.Meltdown ~= arg_9_2 then
		return
	end

	arg_9_0:resetGo()

	local var_9_0 = arg_9_0.animGoDict[arg_9_2]
	local var_9_1 = arg_9_0.Behaviour2AudioId[arg_9_2]

	if not var_9_0 then
		arg_9_0:log(string.format("没找到对应行为动画节点，behaviour is : %s", arg_9_2))

		var_9_0 = arg_9_0.animGoDict[FightEnum.StressBehaviour.Meltdown]
		var_9_1 = arg_9_0.Behaviour2AudioId[FightEnum.StressBehaviour.Meltdown]
	end

	arg_9_0.playBehaviouring = true

	gohelper.setActive(var_9_0, true)
	FightAudioMgr.instance:playAudio(var_9_1)
	TaskDispatcher.runDelay(arg_9_0.onBehaviourDone, arg_9_0, var_0_0.BehaviourAnimDuration)
end

function var_0_0.onBehaviourDone(arg_10_0)
	arg_10_0.playBehaviouring = false

	arg_10_0:refreshUI()
	arg_10_0:playStressValueChangeAnim()
end

function var_0_0.beforeDestroy(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.onBehaviourDone, arg_11_0)
	arg_11_0.click:RemoveClickListener()

	arg_11_0.click = nil

	arg_11_0:__onDispose()
end

return var_0_0
