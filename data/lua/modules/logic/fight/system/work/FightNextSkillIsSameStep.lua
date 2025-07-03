module("modules.logic.fight.system.work.FightNextSkillIsSameStep", package.seeall)

local var_0_0 = class("FightNextSkillIsSameStep", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.fightStepData = arg_1_1
	arg_1_0.preStepData = arg_1_2

	FightController.instance:registerCallback(FightEvent.CheckPlaySameSkill, arg_1_0._checkPlaySameSkill, arg_1_0)
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0._checkPlaySameSkill(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 ~= arg_3_0.preStepData then
		return
	end

	local var_3_0 = FightDataHelper.entityMgr:getById(arg_3_0.fightStepData.fromId)

	if not var_3_0 then
		return
	end

	if arg_3_0.fightStepData.fromId ~= arg_3_0.preStepData.fromId then
		return
	end

	local var_3_1 = FightDataHelper.entityMgr:getById(arg_3_0.fightStepData.fromId)
	local var_3_2 = FightDataHelper.entityMgr:getById(arg_3_0.preStepData.fromId)

	if var_3_1.side ~= var_3_2.side then
		return
	end

	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		if arg_3_0.fightStepData.actId ~= arg_3_0.preStepData.actId then
			local var_3_3 = SkillConfig.instance:getHeroAllSkillIdDict(var_3_1.modelId)
			local var_3_4 = -1
			local var_3_5

			for iter_3_0, iter_3_1 in pairs(var_3_3) do
				for iter_3_2, iter_3_3 in ipairs(iter_3_1) do
					if iter_3_3 == arg_3_0.preStepData.actId then
						var_3_4 = iter_3_0
					end

					if iter_3_3 == arg_3_0.fightStepData.actId then
						var_3_5 = iter_3_0
					end
				end
			end

			if var_3_4 ~= var_3_5 then
				return
			end
		end
	elseif arg_3_0.fightStepData.actId ~= arg_3_0.preStepData.actId then
		local var_3_6 = -1
		local var_3_7

		for iter_3_4, iter_3_5 in ipairs(var_3_0.skillGroup1) do
			if arg_3_0.preStepData.actId == iter_3_5 then
				var_3_6 = 1
			end

			if arg_3_0.fightStepData.actId == iter_3_5 then
				var_3_7 = 1
			end
		end

		for iter_3_6, iter_3_7 in ipairs(var_3_0.skillGroup2) do
			if arg_3_0.preStepData.actId == iter_3_7 then
				var_3_6 = 2
			end

			if arg_3_0.fightStepData.actId == iter_3_7 then
				var_3_7 = 2
			end
		end

		if var_3_6 ~= var_3_7 then
			return
		end
	end

	FightController.instance:unregisterCallback(FightEvent.CheckPlaySameSkill, arg_3_0._checkPlaySameSkill, arg_3_0)
	FightController.instance:dispatchEvent(FightEvent.BeforePlaySameSkill, arg_3_0.preStepData, arg_3_0.fightStepData)
end

function var_0_0.clearWork(arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.CheckPlaySameSkill, arg_4_0._checkPlaySameSkill, arg_4_0)
end

return var_0_0
