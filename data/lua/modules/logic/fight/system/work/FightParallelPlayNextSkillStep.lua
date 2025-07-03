module("modules.logic.fight.system.work.FightParallelPlayNextSkillStep", package.seeall)

local var_0_0 = class("FightParallelPlayNextSkillStep", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.fightStepData = arg_1_1
	arg_1_0.preStepData = arg_1_2
	arg_1_0.fightStepDataList = arg_1_3

	FightController.instance:registerCallback(FightEvent.ParallelPlayNextSkillCheck, arg_1_0._parallelPlayNextSkillCheck, arg_1_0)
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0._parallelPlayNextSkillCheck(arg_3_0, arg_3_1)
	if arg_3_1 ~= arg_3_0.preStepData then
		return
	end

	if not FightDataHelper.entityMgr:getById(arg_3_0.preStepData.fromId) then
		return
	end

	if FightCardDataHelper.isBigSkill(arg_3_0.preStepData.actId) then
		return
	end

	if not FightDataHelper.entityMgr:getById(arg_3_0.fightStepData.fromId) then
		return
	end

	if FightCardDataHelper.isBigSkill(arg_3_0.fightStepData.actId) then
		return
	end

	if FightSkillMgr.instance:isEntityPlayingTimeline(arg_3_0.fightStepData.fromId) then
		return
	end

	if arg_3_0.fightStepData.fromId == arg_3_0.preStepData.fromId then
		return
	end

	local var_3_0 = FightDataHelper.entityMgr:getById(arg_3_0.fightStepData.fromId)
	local var_3_1 = FightDataHelper.entityMgr:getById(arg_3_0.preStepData.fromId)

	if var_3_0.side ~= var_3_1.side then
		return
	end

	if arg_3_0.fightStepDataList then
		for iter_3_0 = (tabletool.indexOf(arg_3_0.fightStepDataList, arg_3_1) or #arg_3_0.fightStepDataList) + 1, #arg_3_0.fightStepDataList do
			local var_3_2 = arg_3_0.fightStepDataList[iter_3_0]

			if var_3_2.actType == FightEnum.ActType.EFFECT then
				for iter_3_1, iter_3_2 in ipairs(var_3_2.actEffect) do
					local var_3_3 = iter_3_2.effectType == FightEnum.EffectType.DEAD
					local var_3_4 = arg_3_1.fromId == iter_3_2.targetId

					if var_3_3 and var_3_4 then
						return
					end
				end
			end
		end
	end

	FightController.instance:unregisterCallback(FightEvent.ParallelPlayNextSkillCheck, arg_3_0._parallelPlayNextSkillCheck, arg_3_0)

	arg_3_0.fightStepData.isParallelStep = true

	FightController.instance:dispatchEvent(FightEvent.ParallelPlayNextSkillDoneThis, arg_3_1)
end

function var_0_0.clearWork(arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.ParallelPlayNextSkillCheck, arg_4_0._parallelPlayNextSkillCheck, arg_4_0)
end

return var_0_0
