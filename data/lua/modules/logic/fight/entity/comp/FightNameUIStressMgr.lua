module("modules.logic.fight.entity.comp.FightNameUIStressMgr", package.seeall)

local var_0_0 = class("FightNameUIStressMgr", UserDataDispose)

var_0_0.PrefabPath = "ui/viewres/fight/fightstressitem.prefab"
var_0_0.BehaviourAnimDuration = 1
var_0_0.Behaviour2AudioId = {
	[FightEnum.StressBehaviour.Meltdown] = 20211405,
	[FightEnum.StressBehaviour.Resolute] = 20211404
}

function var_0_0.initMgr(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0.goStress = arg_1_1
	arg_1_0.entity = arg_1_2
	arg_1_0.entityId = arg_1_0.entity.id

	arg_1_0:loadPrefab()
end

function var_0_0.loadPrefab(arg_2_0)
	arg_2_0.loader = PrefabInstantiate.Create(arg_2_0.goStress)

	arg_2_0.loader:startLoad(var_0_0.PrefabPath, arg_2_0.onLoadFinish, arg_2_0)
end

function var_0_0.onLoadFinish(arg_3_0)
	arg_3_0.instanceGo = arg_3_0.loader:getInstGO()

	arg_3_0:initUI()
	arg_3_0:refreshUI()
	arg_3_0:addCustomEvent()
end

function var_0_0.initUI(arg_4_0)
	arg_4_0.stressText = gohelper.findChildText(arg_4_0.instanceGo, "#txt_stress")
	arg_4_0.goBlue = gohelper.findChild(arg_4_0.instanceGo, "blue")
	arg_4_0.goRed = gohelper.findChild(arg_4_0.instanceGo, "red")
	arg_4_0.goBroken = gohelper.findChild(arg_4_0.instanceGo, "broken")
	arg_4_0.goStaunch = gohelper.findChild(arg_4_0.instanceGo, "staunch")
	arg_4_0.click = gohelper.findChildClickWithDefaultAudio(arg_4_0.instanceGo, "#go_clickarea")

	arg_4_0.click:AddClickListener(arg_4_0.onClickStress, arg_4_0)

	arg_4_0.statusDict = {}
	arg_4_0.statusDict[FightEnum.Status.Positive] = arg_4_0:createStatusItem(arg_4_0.goBlue)
	arg_4_0.statusDict[FightEnum.Status.Negative] = arg_4_0:createStatusItem(arg_4_0.goRed)
	arg_4_0.animGoDict = arg_4_0:getUserDataTb_()
	arg_4_0.animGoDict[FightEnum.StressBehaviour.Meltdown] = arg_4_0.goBroken
	arg_4_0.animGoDict[FightEnum.StressBehaviour.Resolute] = arg_4_0.goStaunch
end

function var_0_0.createStatusItem(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getUserDataTb_()

	var_5_0.go = arg_5_1
	var_5_0.txtStress = gohelper.findChildText(var_5_0.go, "add/#txt_stress")
	var_5_0.animator = var_5_0.go:GetComponent(gohelper.Type_Animator)

	return var_5_0
end

function var_0_0.onClickStress(arg_6_0)
	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	local var_6_0 = arg_6_0.entity:getMO()

	if var_6_0.side == FightEnum.EntitySide.MySide then
		StressTipController.instance:openHeroStressTip(var_6_0:getCO())
	else
		StressTipController.instance:openMonsterStressTip(var_6_0:getCO())
	end
end

function var_0_0.updateStatus(arg_7_0)
	arg_7_0:resetGo()

	local var_7_0 = arg_7_0:getCurStress()

	arg_7_0.status = FightHelper.getStressStatus(var_7_0)

	local var_7_1 = arg_7_0.status and arg_7_0.statusDict[arg_7_0.status]

	if var_7_1 then
		gohelper.setActive(var_7_1.go, true)
	end
end

function var_0_0.refreshUI(arg_8_0)
	local var_8_0 = arg_8_0:getCurStress()

	arg_8_0.stressText.text = var_8_0

	arg_8_0:updateStatus()
end

function var_0_0.addCustomEvent(arg_9_0)
	arg_9_0:addEventCb(FightController.instance, FightEvent.PowerChange, arg_9_0.onPowerChange, arg_9_0)
	arg_9_0:addEventCb(FightController.instance, FightEvent.TriggerStressBehaviour, arg_9_0.triggerStressBehaviour, arg_9_0)
	arg_9_0:addEventCb(FightController.instance, FightEvent.OnStageChange, arg_9_0.onStageChange, arg_9_0)
end

function var_0_0.resetGo(arg_10_0)
	gohelper.setActive(arg_10_0.goBlue, false)
	gohelper.setActive(arg_10_0.goRed, false)
	gohelper.setActive(arg_10_0.goBroken, false)
	gohelper.setActive(arg_10_0.goStaunch, false)
end

function var_0_0.onStageChange(arg_11_0)
	ViewMgr.instance:closeView(ViewName.StressTipView)
end

function var_0_0.onPowerChange(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if arg_12_0.playBehaviouring then
		return
	end

	if arg_12_0.entityId ~= arg_12_1 then
		return
	end

	if FightEnum.PowerType.Stress ~= arg_12_2 then
		return
	end

	if arg_12_3 == arg_12_4 then
		return
	end

	arg_12_0:refreshUI()
	arg_12_0:playStressValueChangeAnim()
end

function var_0_0.playStressValueChangeAnim(arg_13_0)
	if arg_13_0.playBehaviouring then
		return
	end

	if not arg_13_0.status then
		return
	end

	local var_13_0 = arg_13_0.statusDict[arg_13_0.status]

	if var_13_0 then
		var_13_0.animator:Play("up", 0, 0)

		var_13_0.txtStress.text = arg_13_0:getCurStress()
	else
		arg_13_0:log(string.format("压力值item为nil。cur status : %s, cur stress : %s", arg_13_0.status, arg_13_0:getCurStress()))
	end
end

function var_0_0.triggerStressBehaviour(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0.entityId ~= arg_14_1 then
		return
	end

	if FightEnum.StressBehaviour.Resolute ~= arg_14_2 and FightEnum.StressBehaviour.Meltdown ~= arg_14_2 then
		return
	end

	arg_14_0:resetGo()

	local var_14_0 = arg_14_0.animGoDict[arg_14_2]
	local var_14_1 = arg_14_0.Behaviour2AudioId[arg_14_2]

	if not var_14_0 then
		arg_14_0:log(string.format("没找到对应行为动画节点，behaviour is : %s", arg_14_2))

		var_14_0 = arg_14_0.animGoDict[FightEnum.StressBehaviour.Meltdown]
		var_14_1 = arg_14_0.Behaviour2AudioId[FightEnum.StressBehaviour.Meltdown]
	end

	arg_14_0.playBehaviouring = true

	gohelper.setActive(var_14_0, true)
	FightAudioMgr.instance:playAudio(var_14_1)
	TaskDispatcher.runDelay(arg_14_0.onBehaviourDone, arg_14_0, var_0_0.BehaviourAnimDuration)
end

function var_0_0.onBehaviourDone(arg_15_0)
	arg_15_0.playBehaviouring = false

	arg_15_0:refreshUI()
	arg_15_0:playStressValueChangeAnim()
end

function var_0_0.getCurStress(arg_16_0)
	local var_16_0 = arg_16_0.entity:getMO():getPowerInfo(FightEnum.PowerType.Stress)

	return var_16_0 and var_16_0.num or 0
end

function var_0_0.log(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.entity:getMO()

	logError(string.format("[%s] : %s", var_17_0:getEntityName(), arg_17_1))
end

function var_0_0.beforeDestroy(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0.onBehaviourDone, arg_18_0)
	arg_18_0.click:RemoveClickListener()

	arg_18_0.click = nil

	arg_18_0.loader:dispose()

	arg_18_0.loader = nil

	arg_18_0:__onDispose()
end

return var_0_0
