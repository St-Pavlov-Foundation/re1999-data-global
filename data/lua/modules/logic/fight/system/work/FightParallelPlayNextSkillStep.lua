module("modules.logic.fight.system.work.FightParallelPlayNextSkillStep", package.seeall)

local var_0_0 = class("FightParallelPlayNextSkillStep", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.stepMO = arg_1_1
	arg_1_0.prevStepMO = arg_1_2
	arg_1_0.fightStepMOs = arg_1_3

	FightController.instance:registerCallback(FightEvent.ParallelPlayNextSkillCheck, arg_1_0._parallelPlayNextSkillCheck, arg_1_0)
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0._parallelPlayNextSkillCheck(arg_3_0, arg_3_1)
	if arg_3_1 ~= arg_3_0.prevStepMO then
		return
	end

	local var_3_0 = FightDataHelper.entityMgr:getById(arg_3_0.prevStepMO.fromId)

	if not var_3_0 then
		return
	end

	if FightCardModel.instance:isUniqueSkill(var_3_0.fromId, arg_3_0.prevStepMO.actId) then
		return
	end

	if not FightDataHelper.entityMgr:getById(arg_3_0.stepMO.fromId) then
		return
	end

	if FightCardModel.instance:isUniqueSkill(arg_3_0.stepMO.fromId, arg_3_0.stepMO.actId) then
		return
	end

	if FightSkillMgr.instance:isEntityPlayingTimeline(arg_3_0.stepMO.fromId) then
		return
	end

	if arg_3_0.stepMO.fromId == arg_3_0.prevStepMO.fromId then
		return
	end

	local var_3_1 = FightDataHelper.entityMgr:getById(arg_3_0.stepMO.fromId)
	local var_3_2 = FightDataHelper.entityMgr:getById(arg_3_0.prevStepMO.fromId)

	if var_3_1.side ~= var_3_2.side then
		return
	end

	if arg_3_0.fightStepMOs then
		for iter_3_0 = (tabletool.indexOf(arg_3_0.fightStepMOs, arg_3_1) or #arg_3_0.fightStepMOs) + 1, #arg_3_0.fightStepMOs do
			local var_3_3 = arg_3_0.fightStepMOs[iter_3_0]

			if var_3_3.actType == FightEnum.ActType.EFFECT then
				for iter_3_1, iter_3_2 in ipairs(var_3_3.actEffectMOs) do
					local var_3_4 = iter_3_2.effectType == FightEnum.EffectType.DEAD
					local var_3_5 = arg_3_1.fromId == iter_3_2.targetId

					if var_3_4 and var_3_5 then
						return
					end
				end
			end
		end
	end

	FightController.instance:unregisterCallback(FightEvent.ParallelPlayNextSkillCheck, arg_3_0._parallelPlayNextSkillCheck, arg_3_0)

	arg_3_0.stepMO.isParallelStep = true

	FightController.instance:dispatchEvent(FightEvent.ParallelPlayNextSkillDoneThis, arg_3_1)
end

function var_0_0.clearWork(arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.ParallelPlayNextSkillCheck, arg_4_0._parallelPlayNextSkillCheck, arg_4_0)
end

return var_0_0
