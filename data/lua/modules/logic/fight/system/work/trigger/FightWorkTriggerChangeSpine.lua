module("modules.logic.fight.system.work.trigger.FightWorkTriggerChangeSpine", package.seeall)

local var_0_0 = class("FightWorkTriggerChangeSpine", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.fightStepData = arg_1_1
	arg_1_0.actEffectData = arg_1_2
end

function var_0_0.onStart(arg_2_0)
	arg_2_0._config = lua_trigger_action.configDict[arg_2_0.actEffectData.effectNum]
	arg_2_0._tarEntity = FightHelper.getEnemyEntityByMonsterId(tonumber(arg_2_0._config.param1))

	if arg_2_0._tarEntity and arg_2_0._tarEntity.spine then
		TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 20)

		arg_2_0._lastSpineObj = arg_2_0._tarEntity.spine:getSpineGO()

		arg_2_0._tarEntity:loadSpine(arg_2_0._onLoaded, arg_2_0, string.format("roles/%s.prefab", arg_2_0._config.param2))

		return
	end

	arg_2_0:_delayDone()
end

function var_0_0._onLoaded(arg_3_0)
	if arg_3_0._tarEntity then
		FightMsgMgr.sendMsg(FightMsgId.SpineLoadFinish, arg_3_0._tarEntity.spine)
		FightController.instance:dispatchEvent(FightEvent.OnSpineLoaded, arg_3_0._tarEntity.spine)
	end

	arg_3_0:_delayDone()
end

function var_0_0._delayDone(arg_4_0)
	if arg_4_0._tarEntity then
		arg_4_0._tarEntity:initHangPointDict()
	end

	local var_4_0 = arg_4_0._tarEntity.effect:getHangEffect()

	if var_4_0 then
		for iter_4_0, iter_4_1 in pairs(var_4_0) do
			local var_4_1 = iter_4_1.effectWrap
			local var_4_2 = iter_4_1.hangPoint
			local var_4_3, var_4_4, var_4_5 = transformhelper.getLocalPos(var_4_1.containerTr)
			local var_4_6 = arg_4_0._tarEntity:getHangPoint(var_4_2)

			gohelper.addChild(var_4_6, var_4_1.containerGO)
			transformhelper.setLocalPos(var_4_1.containerTr, var_4_3, var_4_4, var_4_5)
		end
	end

	gohelper.destroy(arg_4_0._lastSpineObj)
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._delayDone, arg_5_0)
end

return var_0_0
