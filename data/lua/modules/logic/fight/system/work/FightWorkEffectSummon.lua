module("modules.logic.fight.system.work.FightWorkEffectSummon", package.seeall)

local var_0_0 = class("FightWorkEffectSummon", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	arg_1_0._entityMO = FightDataHelper.entityMgr:getById(arg_1_0.actEffectData.entity.id)

	if arg_1_0._entityMO then
		if FightDataHelper.entityMgr:isDeadUid(arg_1_0._entityMO.uid) then
			arg_1_0:onDone(true)

			return
		end

		arg_1_0:com_registTimer(arg_1_0._delayDone, 10)
		FightController.instance:registerCallback(FightEvent.OnSpineLoaded, arg_1_0._onSpineLoaded, arg_1_0)

		local var_1_0 = GameSceneMgr.instance:getCurScene().entityMgr

		arg_1_0._entityId = arg_1_0._entityMO.id

		local var_1_1 = var_1_0:buildSpine(arg_1_0._entityMO)

		if isTypeOf(var_1_1, FightEntityAssembledMonsterSub) then
			arg_1_0:onDone(true)

			return
		end
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._onSpineLoaded(arg_2_0, arg_2_1)
	if arg_2_0._entityId == arg_2_1.unitSpawn.id then
		arg_2_0._entity = FightHelper.getEntity(arg_2_0._entityId)
		arg_2_0._audioId = 410000038

		if arg_2_0._entityMO.side == FightEnum.EntitySide.MySide then
			arg_2_0._flow = FlowParallel.New()

			arg_2_0._flow:addWork(FightWorkStartBornNormal.New(arg_2_0._entity, false))
		else
			arg_2_0._flow = FlowParallel.New()

			local var_2_0 = "buff/buff_zhaohuan"
			local var_2_1 = 0.6
			local var_2_2 = ModuleEnum.SpineHangPoint.mountbody
			local var_2_3 = lua_fight_summon_show.configDict[arg_2_0._entityMO.skin]

			if var_2_3 then
				if not string.nilorempty(var_2_3.actionName) then
					var_2_0 = nil

					arg_2_0._flow:addWork(FightWorkEntityPlayAct.New(arg_2_0._entity, var_2_3.actionName))
				end

				if var_2_3.audioId ~= 0 then
					arg_2_0._audioId = var_2_3.audioId
				end

				if not string.nilorempty(var_2_3.effect) then
					var_2_0 = var_2_3.effect
					var_2_1 = var_2_3.effectTime and var_2_3.effectTime ~= 0 and var_2_3.effectTime / 1000 or var_2_1
				end

				if not string.nilorempty(var_2_3.effectHangPoint) then
					var_2_2 = var_2_3.effectHangPoint
				end

				if var_2_3.ingoreEffect == 1 then
					var_2_0 = nil
				end
			end

			if var_2_0 then
				local var_2_4 = var_2_1 / FightModel.instance:getSpeed()

				arg_2_0._flow:addWork(FightWorkStartBornExtendForEffect.New(arg_2_0._entity, false, var_2_0, var_2_2, var_2_4))
			end
		end

		arg_2_0:com_registTimer(arg_2_0._delayDone, 60)
		arg_2_0._flow:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.AfterSummon, arg_2_0._entityMO.modelId))
		arg_2_0._flow:registerDoneListener(arg_2_0._onSummonBornDone, arg_2_0)
		arg_2_0._flow:start()
		AudioMgr.instance:trigger(arg_2_0._audioId)
		FightController.instance:dispatchEvent(FightEvent.OnSummon, arg_2_0._entity)
	end
end

function var_0_0._playAudio(arg_3_0, arg_3_1)
	AudioMgr.instance:trigger(arg_3_1)
end

function var_0_0._onSummonBornDone(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0._delayDone(arg_5_0)
	logError("召唤效果超时")
	arg_5_0:onDone(true)
end

function var_0_0.clearWork(arg_6_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_6_0._onSpineLoaded, arg_6_0)

	if arg_6_0._flow then
		arg_6_0._flow:unregisterDoneListener(arg_6_0._onAniFlowDone, arg_6_0)
		arg_6_0._flow:stop()

		arg_6_0._flow = nil
	end
end

return var_0_0
