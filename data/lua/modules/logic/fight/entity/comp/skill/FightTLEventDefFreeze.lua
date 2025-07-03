module("modules.logic.fight.entity.comp.skill.FightTLEventDefFreeze", package.seeall)

local var_0_0 = class("FightTLEventDefFreeze", FightTimelineTrackItem)
local var_0_1 = {
	[FightEnum.EffectType.MISS] = true,
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.HEAL] = true,
	[FightEnum.EffectType.HEALCRIT] = true,
	[FightEnum.EffectType.BUFFADD] = true,
	[FightEnum.EffectType.BUFFUPDATE] = true,
	[FightEnum.EffectType.SHIELD] = true
}

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = arg_1_2 * FightModel.instance:getSpeed()

	arg_1_0._action = arg_1_3[1]

	local var_1_1 = tonumber(arg_1_3[2]) or 0

	arg_1_0._defenders = arg_1_0:_getDefenders(arg_1_1, arg_1_3[3])

	if not string.nilorempty(arg_1_0._action) then
		for iter_1_0, iter_1_1 in ipairs(arg_1_0._defenders) do
			iter_1_1.spine:play(arg_1_0._action, false, true)
		end
	end

	if var_1_1 < var_1_0 then
		if var_1_1 == 0 then
			arg_1_0:_startFreeze()
		else
			local var_1_2 = var_1_1 / FightModel.instance:getSpeed()

			TaskDispatcher.runDelay(arg_1_0._startFreeze, arg_1_0, var_1_2)
		end
	else
		logWarn("Skill Freeze param invalid, startTime >= duration")
	end
end

function var_0_0.onTrackEnd(arg_2_0)
	arg_2_0:_onDurationEnd()
end

function var_0_0._getDefenders(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = 2
	local var_3_1 = {}

	if not string.nilorempty(arg_3_2) then
		var_3_0 = tonumber(string.split(arg_3_2, "#")[1])
	end

	local var_3_2 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.actEffect) do
		if var_0_1[iter_3_1.effectType] then
			if var_3_0 == 1 then
				local var_3_3 = FightHelper.getEntity(arg_3_1.fromId)

				var_3_1[var_3_3.id] = var_3_3
			elseif var_3_0 == 2 then
				local var_3_4 = FightHelper.getEntity(arg_3_1.fromId):getSide()
				local var_3_5 = FightHelper.getEntity(iter_3_1.targetId)

				if var_3_4 ~= var_3_5:getSide() then
					var_3_1[var_3_5.id] = var_3_5
				end
			elseif var_3_0 == 3 then
				local var_3_6 = FightHelper.getEntity(arg_3_1.fromId)
				local var_3_7 = FightHelper.getSideEntitys(var_3_6:getSide())

				for iter_3_2, iter_3_3 in ipairs(var_3_7) do
					var_3_1[iter_3_3.id] = iter_3_3
				end
			elseif var_3_0 == 4 then
				local var_3_8 = FightHelper.getEntity(arg_3_1.toId)
				local var_3_9 = FightHelper.getSideEntitys(var_3_8:getSide())

				for iter_3_4, iter_3_5 in ipairs(var_3_9) do
					var_3_1[iter_3_5.id] = iter_3_5
				end
			elseif var_3_0 == 5 then
				local var_3_10 = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide)

				for iter_3_6, iter_3_7 in ipairs(var_3_10) do
					var_3_1[iter_3_7.id] = iter_3_7
				end

				local var_3_11 = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide)

				for iter_3_8, iter_3_9 in ipairs(var_3_11) do
					var_3_1[iter_3_9.id] = iter_3_9
				end
			elseif var_3_0 == 6 then
				local var_3_12 = FightHelper.getEntity(arg_3_1.toId)

				var_3_1[var_3_12.id] = var_3_12
			elseif var_3_0 == 7 then
				local var_3_13 = string.splitToNumber(arg_3_2, "#")

				for iter_3_10 = 2, #var_3_13 do
					local var_3_14 = FightHelper.getEntity(var_3_13[iter_3_10])

					var_3_1[var_3_14.id] = var_3_14
				end
			end
		end
	end

	for iter_3_11, iter_3_12 in pairs(var_3_1) do
		table.insert(var_3_2, iter_3_12)
	end

	return var_3_2
end

function var_0_0._startFreeze(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0._defenders) do
		iter_4_1.spine:setFreeze(true)
	end
end

function var_0_0._onDurationEnd(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0._defenders) do
		if iter_5_1.spine:getAnimState() == arg_5_0._action then
			iter_5_1:resetAnimState()
		end
	end

	arg_5_0:onDestructor()
end

function var_0_0.onDestructor(arg_6_0)
	if arg_6_0._defenders then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0._defenders) do
			iter_6_1.spine:setFreeze(false)
		end
	end

	arg_6_0._defenders = nil

	TaskDispatcher.cancelTask(arg_6_0._startFreeze, arg_6_0)
end

return var_0_0
