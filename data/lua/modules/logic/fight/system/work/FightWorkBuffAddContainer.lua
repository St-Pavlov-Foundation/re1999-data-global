module("modules.logic.fight.system.work.FightWorkBuffAddContainer", package.seeall)

local var_0_0 = class("FightWorkBuffAddContainer", FightStepEffectFlow)
local var_0_1 = {
	[FightEnum.EffectType.BUFFADD] = true
}
local var_0_2 = 0.15
local var_0_3 = 0.05

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0:getAdjacentSameEffectList(var_0_1, true)
	local var_1_1 = arg_1_0:com_registWorkDoneFlowParallel()
	local var_1_2 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		local var_1_3 = iter_1_1.actEffectData
		local var_1_4 = var_1_3.buff

		if var_1_4 then
			local var_1_5 = lua_skill_buff.configDict[var_1_4.buffId]
			local var_1_6 = lua_skill_bufftype.configDict[var_1_5.typeId]

			if var_1_5 and var_1_6 then
				local var_1_7 = var_1_2[var_1_3.targetId]

				if not var_1_7 then
					var_1_7 = {}
					var_1_2[var_1_3.targetId] = var_1_7
				end

				table.insert(var_1_7, iter_1_1)
			end
		end
	end

	local var_1_8 = {}

	for iter_1_2, iter_1_3 in pairs(var_1_2) do
		for iter_1_4, iter_1_5 in ipairs(iter_1_3) do
			local var_1_9 = iter_1_5.fightStepData
			local var_1_10 = iter_1_5.actEffectData
			local var_1_11 = var_1_10.buff.buffId
			local var_1_12 = lua_skill_buff.configDict[var_1_11]
			local var_1_13 = lua_skill_bufftype.configDict[var_1_12.typeId]
			local var_1_14 = var_1_8[var_1_10.targetId]

			if not var_1_14 then
				var_1_14 = var_1_1:registWork(FightWorkFlowSequence)
				var_1_8[var_1_10.targetId] = var_1_14
			end

			if var_1_12.isNoShow == 1 then
				var_1_14:registWork(FightWorkStepBuff, var_1_9, var_1_10)
			elseif var_1_13.skipDelay == 1 then
				var_1_14:registWork(FightWorkStepBuff, var_1_9, var_1_10)
			elseif lua_fight_stacked_buff_combine.configDict[var_1_12.id] then
				local var_1_15 = iter_1_3[iter_1_4 + 1]

				if var_1_15 and var_1_15.buff and var_1_15.buff.buffId == var_1_11 then
					var_1_14:registWork(FightWorkFunction, arg_1_0._lockEntityBuffFloat, arg_1_0, {
						true,
						entityId = var_1_10.targetId
					})
				else
					var_1_14:registWork(FightWorkFunction, arg_1_0._lockEntityBuffFloat, arg_1_0, {
						false,
						entityId = var_1_10.targetId
					})
				end

				var_1_14:registWork(FightWorkStepBuff, var_1_9, var_1_10)
			elseif var_1_12.effect ~= "0" and not string.nilorempty(var_1_12.effect) then
				var_1_14:registWork(FightWorkStepBuff, var_1_9, var_1_10)
				var_1_14:registWork(FightWorkDelayTimer, var_0_2 / FightModel.instance:getSpeed())
			else
				var_1_14:registWork(FightWorkStepBuff, var_1_9, var_1_10)
				var_1_14:registWork(FightWorkDelayTimer, var_0_3 / FightModel.instance:getSpeed())
			end
		end
	end

	var_1_1:start()
end

function var_0_0._lockEntityBuffFloat(arg_2_0, arg_2_1)
	local var_2_0 = FightHelper.getEntity(arg_2_1.entityId)

	if var_2_0 and var_2_0.buff then
		var_2_0.buff.lockFloat = arg_2_1.state
	end
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0
