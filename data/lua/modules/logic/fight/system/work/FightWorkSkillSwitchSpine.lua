﻿module("modules.logic.fight.system.work.FightWorkSkillSwitchSpine", package.seeall)

local var_0_0 = class("FightWorkSkillSwitchSpine", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._fightStepMO = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 0.5)

	local var_2_0 = FightHelper.getEntity(arg_2_0._fightStepMO.fromId)
	local var_2_1 = var_2_0 and var_2_0:getMO()

	if not var_2_1 then
		arg_2_0:onDone(true)

		return
	end

	if FightEntityDataHelper.isPlayerUid(var_2_1.id) then
		arg_2_0:onDone(true)

		return
	end

	local var_2_2 = arg_2_0._fightStepMO.supportHeroId

	if not var_2_2 then
		arg_2_0:onDone(true)

		return
	end

	if var_2_2 ~= 0 and var_2_2 ~= var_2_1.modelId then
		TaskDispatcher.cancelTask(arg_2_0._delayDone, arg_2_0)
		TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 10)

		arg_2_0._flow = FlowSequence.New()

		local var_2_3 = FightHelper.processSkinByStepMO(arg_2_0._fightStepMO)
		local var_2_4 = FightConfig.instance:getSkinCO(var_2_3)
		local var_2_5 = var_2_4 and var_2_0:getSpineUrl(var_2_4)

		if not var_2_5 then
			logError("释放支援角色技能,但是找不到替换spine的url, heroId:" .. var_2_1.modelId)
			arg_2_0:onDone(true)

			return
		end

		if var_2_0.spine and var_2_0.spine.releaseSpecialSpine then
			var_2_0.spine:releaseSpecialSpine()

			var_2_0.spine.LOCK_SPECIALSPINE = true
		end

		arg_2_0.context.Custom_OriginSkin = var_2_1.skin
		var_2_1.skin = var_2_3

		arg_2_0._flow:addWork(FightWorkChangeEntitySpine.New(var_2_0, var_2_5))
		arg_2_0._flow:registerDoneListener(arg_2_0._onFlowDone, arg_2_0)
		arg_2_0._flow:start()

		return
	end

	arg_2_0:onDone(true)
end

function var_0_0._onFlowDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0._delayDone(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._delayDone, arg_5_0)

	if arg_5_0._flow then
		arg_5_0._flow:unregisterDoneListener(arg_5_0._onFlowDone, arg_5_0)
		arg_5_0._flow:stop()

		arg_5_0._flow = nil
	end
end

return var_0_0
