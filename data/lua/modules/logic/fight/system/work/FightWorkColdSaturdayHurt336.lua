module("modules.logic.fight.system.work.FightWorkColdSaturdayHurt336", package.seeall)

local var_0_0 = class("FightWorkColdSaturdayHurt336", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0.actEffectData.reserveStr
	local var_1_1 = arg_1_0.actEffectData.targetId
	local var_1_2 = arg_1_0.actEffectData.effectNum
	local var_1_3 = FightHelper.getEntity(var_1_0)

	if not var_1_3 then
		arg_1_0:onDone(true)

		return
	end

	if not FightHelper.getEntity(var_1_1) then
		arg_1_0:onDone(true)

		return
	end

	local var_1_4 = var_1_3:getMO().skin
	local var_1_5 = FightStepData.New(FightDef_pb.FightStep())

	var_1_5.isFakeStep = true
	var_1_5.fromId = var_1_0
	var_1_5.toId = var_1_1
	var_1_5.actType = FightEnum.ActType.SKILL

	table.insert(var_1_5.actEffect, arg_1_0.actEffectData)

	local var_1_6 = lua_fight_she_fa_ignite.configDict[var_1_4] or lua_fight_she_fa_ignite.configDict[0]
	local var_1_7 = {}

	for iter_1_0, iter_1_1 in pairs(var_1_6) do
		table.insert(var_1_7, iter_1_1)
	end

	table.sort(var_1_7, var_0_0.sortConfig)

	for iter_1_2, iter_1_3 in ipairs(var_1_7) do
		if var_1_2 <= iter_1_3.layer then
			var_1_6 = iter_1_3

			break
		end
	end

	local var_1_8 = var_1_6.timeline
	local var_1_9 = var_1_3.skill:registTimelineWork(var_1_8, var_1_5)

	arg_1_0:playWorkAndDone(var_1_9)
end

function var_0_0.sortConfig(arg_2_0, arg_2_1)
	return arg_2_0.layer < arg_2_1.layer
end

return var_0_0
