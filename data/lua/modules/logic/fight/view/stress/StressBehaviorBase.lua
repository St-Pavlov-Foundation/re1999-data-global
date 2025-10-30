module("modules.logic.fight.view.stress.StressBehaviorBase", package.seeall)

local var_0_0 = class("StressBehaviorBase", UserDataDispose)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0.instanceGo = arg_1_1
	arg_1_0.entity = arg_1_2
	arg_1_0.entityId = arg_1_0.entity.id
	arg_1_0.monsterId = arg_1_0.entity:getMO().modelId

	arg_1_0:initUI()
	arg_1_0:refreshUI()
	arg_1_0:addCustomEvent()
end

function var_0_0.initUI(arg_2_0)
	return
end

function var_0_0.refreshUI(arg_3_0)
	return
end

function var_0_0.addCustomEvent(arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.PowerChange, arg_4_0.onPowerChange, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.TriggerStressBehaviour, arg_4_0.triggerStressBehaviour, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.OnStageChange, arg_4_0.onStageChange, arg_4_0)
end

function var_0_0.onStageChange(arg_5_0)
	ViewMgr.instance:closeView(ViewName.StressTipView)
end

function var_0_0.onPowerChange(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	return
end

function var_0_0.triggerStressBehaviour(arg_7_0, arg_7_1, arg_7_2)
	return
end

function var_0_0.getCurStress(arg_8_0)
	local var_8_0 = arg_8_0.entity:getMO():getPowerInfo(FightEnum.PowerType.Stress)

	return var_8_0 and var_8_0.num or 0
end

function FightNameUIStressMgr.log(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.entity:getMO()

	logError(string.format("[%s] : %s", var_9_0:getEntityName(), arg_9_1))
end

function var_0_0.beforeDestroy(arg_10_0)
	arg_10_0:__onDispose()
end

return var_0_0
