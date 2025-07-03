module("modules.logic.fight.entity.comp.skill.FightTLEventDefEffect", package.seeall)

local var_0_0 = class("FightTLEventDefEffect", FightTimelineTrackItem)
local var_0_1 = 8
local var_0_2 = 28
local var_0_3 = {
	[var_0_1] = {
		[FightEnum.EffectType.MISS] = true,
		[FightEnum.EffectType.DAMAGE] = true,
		[FightEnum.EffectType.CRIT] = true,
		[FightEnum.EffectType.SHIELD] = true
	},
	[var_0_2] = {
		[FightEnum.EffectType.HEAL] = true,
		[FightEnum.EffectType.HEALCRIT] = true
	}
}

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if arg_1_0.type == var_0_1 and not FightHelper.detectTimelinePlayEffectCondition(arg_1_1, arg_1_3[8]) then
		return
	end

	arg_1_0.fightStepData = arg_1_1

	local var_1_0 = arg_1_3[1]

	if string.nilorempty(var_1_0) then
		local var_1_1 = FightConfig.instance:getSkinSkillTimeline(nil, arg_1_1.actId)

		logError("受击特效名字为空，检查一下技能的timeline：" .. (var_1_1 or "nil"))

		return
	end

	if not string.nilorempty(arg_1_3[10]) then
		local var_1_2 = FightHelper.getEntity(arg_1_0.fightStepData.fromId):getMO()
		local var_1_3 = var_1_2 and var_1_2.skin

		if var_1_3 then
			local var_1_4 = string.split(arg_1_3[10], "|")

			for iter_1_0, iter_1_1 in ipairs(var_1_4) do
				local var_1_5 = string.split(iter_1_1, "#")

				if tonumber(var_1_5[1]) == var_1_3 then
					var_1_0 = var_1_5[2]

					break
				end
			end
		end
	end

	local var_1_6 = arg_1_3[2]
	local var_1_7 = arg_1_3[3]
	local var_1_8 = 0
	local var_1_9 = 0
	local var_1_10 = 0

	if arg_1_3[4] then
		local var_1_11 = string.split(arg_1_3[4], ",")

		var_1_8 = var_1_11[1] and tonumber(var_1_11[1]) or var_1_8
		var_1_9 = var_1_11[2] and tonumber(var_1_11[2]) or var_1_9
		var_1_10 = var_1_11[3] and tonumber(var_1_11[3]) or var_1_10
	end

	local var_1_12 = tonumber(arg_1_3[5]) or -1

	arg_1_0._act_on_index_entity = arg_1_3[6] and tonumber(arg_1_3[6])

	local var_1_13 = arg_1_3[7]
	local var_1_14 = arg_1_0.fightStepData.actEffect

	if arg_1_0._act_on_index_entity then
		var_1_14 = FightHelper.dealDirectActEffectData(arg_1_0.fightStepData.actEffect, arg_1_0._act_on_index_entity, var_0_3[arg_1_0.type])
	end

	local var_1_15 = var_0_3[arg_1_0.type]
	local var_1_16

	arg_1_0._monster_scale_dic = nil

	local var_1_17 = lua_skin_monster_scale.configDict[arg_1_1.actId]

	if var_1_17 then
		local var_1_18 = string.split(var_1_17.effectName, "#")

		for iter_1_2, iter_1_3 in ipairs(var_1_18) do
			if iter_1_3 == var_1_0 then
				var_1_16 = {}

				local var_1_19 = string.splitToNumber(var_1_17.monsterId, "#")

				for iter_1_4, iter_1_5 in ipairs(var_1_19) do
					var_1_16[iter_1_5] = var_1_17.scale
				end

				break
			end
		end
	end

	for iter_1_6, iter_1_7 in ipairs(var_1_14) do
		if var_1_15[iter_1_7.effectType] and (arg_1_0.type == var_0_2 or var_1_13 ~= tostring(iter_1_7.configEffect)) then
			local var_1_20 = FightHelper.getEntity(iter_1_7.targetId)

			if var_1_20 then
				local var_1_21 = true

				if arg_1_0.type == var_0_1 and not FightHelper.detectTimelinePlayEffectCondition(arg_1_1, arg_1_3[8], var_1_20) then
					var_1_21 = false
				end

				if iter_1_7.effectType == FightEnum.EffectType.SHIELD and not FightHelper.checkShieldHit(iter_1_7) then
					var_1_21 = false
				end

				if var_1_21 and (not arg_1_0._defenderEffectWrapDict or not arg_1_0._defenderEffectWrapDict[var_1_20]) then
					if var_1_16 and var_1_16[var_1_20:getMO().skin] then
						arg_1_0._monster_scale_dic = {}
						arg_1_0._monster_scale_dic[var_1_20.id] = var_1_16[var_1_20:getMO().skin]
					else
						local var_1_22 = arg_1_0:_createHitEffect(var_1_20, var_1_0, var_1_6, var_1_7, var_1_8, var_1_9, var_1_10)

						arg_1_0:_setRenderOrder(var_1_20.id, var_1_22, var_1_12)

						arg_1_0._defenderEffectWrapDict = arg_1_0._defenderEffectWrapDict or {}
						arg_1_0._defenderEffectWrapDict[var_1_20] = var_1_22
					end
				end
			else
				logNormal("play defender effect fail, entity not exist: " .. iter_1_7.targetId)
			end
		end
	end

	if arg_1_0._monster_scale_dic then
		local var_1_23 = false
		local var_1_24 = 1

		for iter_1_8, iter_1_9 in pairs(arg_1_0._monster_scale_dic) do
			local var_1_25 = FightHelper.getEntity(iter_1_8)

			var_1_25:setScale(iter_1_9)

			local var_1_26 = var_1_25:getMO()

			if var_1_26 then
				local var_1_27 = FightConfig.instance:getSkinCO(var_1_26.skin)

				if var_1_27 and var_1_27.canHide == 1 then
					var_1_23 = var_1_25
					var_1_24 = iter_1_9

					break
				end
			end
		end

		if var_1_23 then
			FightHelper.refreshCombinativeMonsterScaleAndPos(var_1_23, var_1_24)

			arg_1_0._revert_combinative_position = var_1_23
		end
	end

	if not string.nilorempty(arg_1_3[9]) then
		AudioMgr.instance:trigger(tonumber(arg_1_3[9]))
	end
end

function var_0_0.onTrackEnd(arg_2_0)
	arg_2_0:_removeEffect()
end

function var_0_0._createHitEffect(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7)
	local var_3_0 = FightHelper.getEntity(arg_3_0.fightStepData.fromId)
	local var_3_1

	if not string.nilorempty(arg_3_3) then
		var_3_1 = arg_3_1.effect:addHangEffect(arg_3_2, arg_3_3, var_3_0:getSide())

		var_3_1:setLocalPos(arg_3_5, arg_3_6, arg_3_7)
	else
		var_3_1 = arg_3_1.effect:addGlobalEffect(arg_3_2, var_3_0:getSide())

		local var_3_2
		local var_3_3
		local var_3_4

		if arg_3_4 == "0" then
			var_3_2, var_3_3, var_3_4 = FightHelper.getEntityWorldBottomPos(arg_3_1)
		elseif arg_3_4 == "1" then
			var_3_2, var_3_3, var_3_4 = FightHelper.getEntityWorldCenterPos(arg_3_1)
		elseif arg_3_4 == "2" then
			var_3_2, var_3_3, var_3_4 = FightHelper.getEntityWorldTopPos(arg_3_1)
		elseif arg_3_4 == "3" then
			var_3_2, var_3_3, var_3_4 = FightHelper.getProcessEntitySpinePos(arg_3_1)
		else
			local var_3_5 = not string.nilorempty(arg_3_4) and arg_3_1:getHangPoint(arg_3_4)

			if var_3_5 then
				local var_3_6 = var_3_5.transform.position

				var_3_2, var_3_3, var_3_4 = var_3_6.x, var_3_6.y, var_3_6.z
			else
				var_3_2, var_3_3, var_3_4 = FightHelper.getEntityWorldCenterPos(arg_3_1)
			end
		end

		local var_3_7 = arg_3_1:isMySide() and -arg_3_5 or arg_3_5

		var_3_1:setWorldPos(var_3_2 + var_3_7, var_3_3 + arg_3_6, var_3_4 + arg_3_7)
	end

	return var_3_1
end

function var_0_0._setRenderOrder(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_3 == -1 then
		FightRenderOrderMgr.instance:onAddEffectWrap(arg_4_1, arg_4_2)
	else
		FightRenderOrderMgr.instance:setEffectOrder(arg_4_2, arg_4_3)
	end
end

function var_0_0.onDestructor(arg_5_0)
	arg_5_0:_removeEffect()
end

function var_0_0._removeEffect(arg_6_0)
	if arg_6_0._defenderEffectWrapDict then
		for iter_6_0, iter_6_1 in pairs(arg_6_0._defenderEffectWrapDict) do
			FightRenderOrderMgr.instance:onRemoveEffectWrap(iter_6_0.id, iter_6_1)
			iter_6_0.effect:removeEffect(iter_6_1)
		end

		arg_6_0._defenderEffectWrapDict = nil
	end

	if arg_6_0._monster_scale_dic then
		for iter_6_2, iter_6_3 in pairs(arg_6_0._monster_scale_dic) do
			local var_6_0 = FightHelper.getEntity(iter_6_2)

			if var_6_0 then
				var_6_0:setScale(1)
			end
		end

		if arg_6_0._revert_combinative_position then
			FightHelper.refreshCombinativeMonsterScaleAndPos(arg_6_0._revert_combinative_position, 1)
		end
	end

	arg_6_0._revert_combinative_position = nil
	arg_6_0._monster_scale_dic = nil
end

return var_0_0
