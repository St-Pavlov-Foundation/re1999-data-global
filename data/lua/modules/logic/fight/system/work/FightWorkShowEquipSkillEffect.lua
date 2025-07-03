module("modules.logic.fight.system.work.FightWorkShowEquipSkillEffect", package.seeall)

local var_0_0 = class("FightWorkShowEquipSkillEffect", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.fightStepData = arg_1_1

	local var_1_0 = FightDataHelper.roundMgr:getRoundData()
	local var_1_1 = var_1_0 and var_1_0.fightStep
	local var_1_2

	if arg_1_0.fightStepData.custom_stepIndex then
		var_1_2 = arg_1_0.fightStepData.custom_stepIndex + 1
	end

	arg_1_0._nextStepData = var_1_1 and var_1_1[var_1_2]
end

function var_0_0.onStart(arg_2_0)
	TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 0.5)

	if arg_2_0.fightStepData.actType == FightEnum.ActType.SKILL and not FightReplayModel.instance:isReplay() then
		local var_2_0 = EquipConfig.instance:isEquipSkill(arg_2_0.fightStepData.actId)

		if var_2_0 then
			if arg_2_0.fightStepData.actEffect and #arg_2_0.fightStepData.actEffect == 1 then
				local var_2_1 = arg_2_0.fightStepData.actEffect[1]

				if var_2_1.effectType == FightEnum.EffectType.BUFFADD and var_2_1.buff then
					local var_2_2 = lua_skill_buff.configDict[var_2_1.buff.buffId]

					if var_2_2 and string.nilorempty(var_2_2.features) then
						arg_2_0:onDone(true)

						return
					end
				end
			end

			FightController.instance:dispatchEvent(FightEvent.OnFloatEquipEffect, arg_2_0.fightStepData.fromId, var_2_0)

			if arg_2_0._nextStepData and arg_2_0._nextStepData.fromId == arg_2_0.fightStepData.fromId and FightCardDataHelper.isActiveSkill(arg_2_0._nextStepData.fromId, arg_2_0._nextStepData.actId) then
				TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 0.5 / FightModel.instance:getUISpeed())

				return
			end
		end
	end

	arg_2_0:onDone(true)
end

function var_0_0._delayDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayDone, arg_4_0)
end

return var_0_0
