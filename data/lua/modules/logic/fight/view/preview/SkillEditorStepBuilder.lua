module("modules.logic.fight.view.preview.SkillEditorStepBuilder", package.seeall)

local var_0_0 = class("SkillEditorStepBuilder")
local var_0_1 = false

function var_0_0.buildFightStepDataList(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = FightHelper.getEntity(arg_1_1):getSide()
	local var_1_1 = var_1_0 == FightEnum.EntitySide.MySide and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide
	local var_1_2 = FightStepData.New()

	var_1_2.editorPlaySkill = true
	var_1_2.actType = 1
	var_1_2.fromId = arg_1_1
	var_1_2.toId = arg_1_2
	var_1_2.actId = arg_1_0
	var_1_2.actEffect = {}

	local var_1_3 = lua_skill.configDict[arg_1_0]

	if var_0_1 then
		var_0_0._logBehavior(var_1_3)
	end

	local var_1_4

	if var_1_3.damageRate > 0 then
		var_1_4 = var_0_0._buildDamage(var_1_3, var_1_2, arg_1_1, arg_1_2, var_1_0, var_1_1)
	end

	var_0_0._buildSkillEffectHealOrDmg(var_1_3, var_1_2, arg_1_1, arg_1_2, var_1_0, var_1_1, var_1_4)
	var_0_0._buildBehaviorBuffs(var_1_3, var_1_2.actEffect, arg_1_1, arg_1_2, var_1_0, var_1_1, var_1_4)
	var_0_0._checkRemoveBuffs(var_1_3, var_1_2.actEffect, arg_1_1, arg_1_2, var_1_0, var_1_1, var_1_4)
	var_0_0._buildSummoned(var_1_3, var_1_2.actEffect, arg_1_1, arg_1_2, var_1_0, var_1_1, var_1_4)
	var_0_0._buildMagicCircle(var_1_3, var_1_2.actEffect, arg_1_1, arg_1_2, var_1_0, var_1_1, var_1_4)
	var_0_0._checkRegainPowerAfterAct(var_1_3, var_1_2.actEffect, arg_1_1, arg_1_2, var_1_0, var_1_1)

	local var_1_5 = {
		var_1_2
	}
	local var_1_6 = var_0_0._checkBuildAddPowerStep(var_1_3, var_1_2.actEffect, arg_1_1, arg_1_2, var_1_0, var_1_1)

	if var_1_6 then
		table.insert(var_1_5, var_1_6)
	end

	return var_1_5
end

function var_0_0._logBehavior(arg_2_0)
	for iter_2_0 = 1, FightEnum.MaxBehavior do
		local var_2_0 = arg_2_0["behavior" .. iter_2_0]
		local var_2_1 = arg_2_0["conditionTarget" .. iter_2_0]
		local var_2_2 = arg_2_0["behaviorTarget" .. iter_2_0]

		if not string.nilorempty(var_2_0) then
			local var_2_3 = arg_2_0["condition" .. iter_2_0]
			local var_2_4 = ""
			local var_2_5 = ""

			if not string.nilorempty(var_2_0) then
				local var_2_6 = string.splitToNumber(var_2_0, "#")[1]
				local var_2_7 = var_2_6 and lua_skill_behavior.configDict[var_2_6]
				local var_2_8 = var_2_7 and var_2_7.type or ""

				var_2_4 = "behavior: " .. var_2_0 .. " " .. var_2_8
			end

			if not string.nilorempty(var_2_3) then
				local var_2_9 = string.splitToNumber(var_2_3, "#")[1]
				local var_2_10 = var_2_9 and lua_skill_behavior_condition.configDict[var_2_9]
				local var_2_11 = var_2_10 and var_2_10.type or ""

				var_2_5 = "condition: " .. var_2_3 .. " " .. var_2_11
			end

			logError("\n" .. var_2_4 .. "    " .. var_2_5 .. "    condTarget_" .. var_2_1 .. "    behaTarget_" .. var_2_2)
		end
	end
end

function var_0_0._buildDamage(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0
	local var_3_1 = FightEnum.EffectType

	if FightEnum.LogicTargetClassify.Special[arg_3_0.logicTarget] then
		logError(arg_3_0.id .. " 未能正确构建技能步骤，技能对象未实现：" .. arg_3_0.logicTarget)
	elseif FightEnum.LogicTargetClassify.Single[arg_3_0.logicTarget] then
		local var_3_2, var_3_3 = var_0_0._getDmgTypeAndNum(var_3_1.DAMAGE)

		var_0_0._buildActEffect(arg_3_1.actEffect, arg_3_3, var_3_2, var_3_3, arg_3_4)
	elseif FightEnum.LogicTargetClassify.SingleAndRandom[arg_3_0.logicTarget] then
		local var_3_4 = arg_3_0.targetLimit == FightEnum.TargetLimit.EnemySide
		local var_3_5, var_3_6 = var_0_0._getDmgTypeAndNum(var_3_1.DAMAGE)

		var_0_0._buildActEffect(arg_3_1.actEffect, arg_3_3, var_3_5, var_3_6, arg_3_4)

		local var_3_7 = FightHelper.getSideEntitys(var_3_4 and arg_3_5 or arg_3_4)

		for iter_3_0, iter_3_1 in ipairs(var_3_7) do
			if iter_3_1.id == arg_3_3 then
				table.remove(var_3_7, iter_3_0)

				break
			end
		end

		if #var_3_7 > 0 then
			local var_3_8 = var_3_7[math.random(#var_3_7)]
			local var_3_9, var_3_10 = var_0_0._getDmgTypeAndNum(var_3_1.DAMAGE)

			var_0_0._buildActEffect(arg_3_1.actEffect, var_3_8.id, var_3_9, var_3_10, arg_3_4)

			var_3_0 = var_3_8.id
		end
	elseif FightEnum.LogicTargetClassify.EnemySideAll[arg_3_0.logicTarget] then
		local var_3_11 = FightDataHelper.entityMgr:getNormalList(arg_3_5)

		for iter_3_2, iter_3_3 in ipairs(var_3_11) do
			local var_3_12, var_3_13 = var_0_0._getDmgTypeAndNum(var_3_1.DAMAGE)

			var_0_0._buildActEffect(arg_3_1.actEffect, iter_3_3.id, var_3_12, var_3_13, arg_3_4)
		end
	elseif FightEnum.LogicTargetClassify.EnemySideindex[arg_3_0.logicTarget] then
		local var_3_14 = arg_3_0.logicTarget - 225
		local var_3_15 = FightDataHelper.entityMgr:getNormalList(arg_3_5)

		table.sort(var_3_15, function(arg_4_0, arg_4_1)
			return arg_4_0.position < arg_4_1.position
		end)

		for iter_3_4, iter_3_5 in ipairs(var_3_15) do
			if iter_3_4 == var_3_14 then
				local var_3_16, var_3_17 = var_0_0._getDmgTypeAndNum(var_3_1.DAMAGE)

				var_0_0._buildActEffect(arg_3_1.actEffect, iter_3_5.id, var_3_16, var_3_17, arg_3_4)
			end
		end
	elseif FightEnum.LogicTargetClassify.MySideAll[arg_3_0.logicTarget] then
		local var_3_18 = FightDataHelper.entityMgr:getNormalList(arg_3_4)

		for iter_3_6, iter_3_7 in ipairs(var_3_18) do
			local var_3_19, var_3_20 = var_0_0._getDmgTypeAndNum(var_3_1.DAMAGE)

			var_0_0._buildActEffect(arg_3_1.actEffect, iter_3_7.id, var_3_19, var_3_20, arg_3_4)
		end
	elseif FightEnum.LogicTargetClassify.Me[arg_3_0.logicTarget] then
		local var_3_21, var_3_22 = var_0_0._getDmgTypeAndNum(var_3_1.DAMAGE)

		var_0_0._buildActEffect(arg_3_1.actEffect, arg_3_2, var_3_21, var_3_22, arg_3_4)
	elseif FightEnum.LogicTargetClassify.EnemyMostHp[arg_3_0.logicTarget] then
		local var_3_23 = FightDataHelper.entityMgr:getNormalList(arg_3_5)
		local var_3_24
		local var_3_25 = 0

		for iter_3_8, iter_3_9 in ipairs(var_3_23) do
			if var_3_25 < iter_3_9.currentHp then
				var_3_25 = iter_3_9.currentHp
				var_3_24 = iter_3_9
			end
		end

		if var_3_24 then
			local var_3_26

			var_3_26 = arg_3_0.targetLimit == FightEnum.TargetLimit.EnemySide

			local var_3_27, var_3_28 = var_0_0._getDmgTypeAndNum(var_3_1.DAMAGE)

			var_0_0._buildActEffect(arg_3_1.actEffect, var_3_24.id, var_3_27, var_3_28, arg_3_4)
		end
	elseif FightEnum.LogicTargetClassify.EnemyWith101Buff[arg_3_0.logicTarget] then
		local var_3_29 = FightDataHelper.entityMgr:getNormalList(arg_3_5)

		for iter_3_10, iter_3_11 in ipairs(var_3_29) do
			local var_3_30 = iter_3_11:getBuffList()
			local var_3_31 = false

			for iter_3_12, iter_3_13 in ipairs(var_3_30) do
				local var_3_32 = lua_skill_buff.configDict[iter_3_13.buffId]

				if var_3_32 and not string.nilorempty(var_3_32.features) then
					local var_3_33 = GameUtil.splitString2(var_3_32.features, true)

					for iter_3_14, iter_3_15 in ipairs(var_3_33) do
						local var_3_34 = iter_3_15[1]
						local var_3_35 = var_3_34 and lua_buff_act.configDict[var_3_34]

						if (var_3_35 and var_3_35.type) == "MonsterLabel" and iter_3_15[2] == 101 then
							var_3_31 = true

							break
						end
					end
				end

				if var_3_31 then
					break
				end
			end

			if var_3_31 then
				local var_3_36, var_3_37 = var_0_0._getDmgTypeAndNum(var_3_1.DAMAGE)

				var_0_0._buildActEffect(arg_3_1.actEffect, iter_3_11.id, var_3_36, var_3_37, arg_3_4)
			end
		end
	elseif FightEnum.LogicTargetClassify.EnemyWith795Feature[arg_3_0.logicTarget] then
		local var_3_38 = FightDataHelper.entityMgr:getNormalList(arg_3_5)
		local var_3_39 = {}

		for iter_3_16, iter_3_17 in ipairs(var_3_38) do
			if iter_3_17:hasBuffFeature(FightEnum.BuffFeature.None) then
				table.insert(var_3_39, iter_3_17)
			end
		end

		if #var_3_39 > 0 then
			local var_3_40 = math.random(1, #var_3_39)
			local var_3_41, var_3_42 = var_0_0._getDmgTypeAndNum(var_3_1.DAMAGE)

			var_0_0._buildActEffect(arg_3_1.actEffect, var_3_39[var_3_40].id, var_3_41, var_3_42, arg_3_4)
		else
			local var_3_43 = math.random(1, #var_3_38)
			local var_3_44, var_3_45 = var_0_0._getDmgTypeAndNum(var_3_1.DAMAGE)

			var_0_0._buildActEffect(arg_3_1.actEffect, var_3_38[var_3_43].id, var_3_44, var_3_45, arg_3_4)
		end
	elseif arg_3_0.logicTarget == 245 then
		local var_3_46 = FightDataHelper.entityMgr:getNormalList(arg_3_5)

		for iter_3_18, iter_3_19 in ipairs(var_3_46) do
			for iter_3_20, iter_3_21 in pairs(iter_3_19.buffDic) do
				local var_3_47 = lua_skill_buff.configDict[iter_3_21.buffId]

				if var_3_47 and var_3_47.typeId == 31320113 then
					local var_3_48, var_3_49 = var_0_0._getDmgTypeAndNum(var_3_1.DAMAGE)

					var_0_0._buildActEffect(arg_3_1.actEffect, iter_3_19.id, var_3_48, var_3_49, arg_3_4)

					return iter_3_19.id
				end
			end
		end

		for iter_3_22, iter_3_23 in ipairs(var_3_46) do
			if FightHelper.checkIsBossByMonsterId(iter_3_23.modelId) then
				local var_3_50, var_3_51 = var_0_0._getDmgTypeAndNum(var_3_1.DAMAGE)

				var_0_0._buildActEffect(arg_3_1.actEffect, iter_3_23.id, var_3_50, var_3_51, arg_3_4)

				return iter_3_23.id
			end
		end

		table.sort(var_3_46, function(arg_5_0, arg_5_1)
			return arg_5_0.currentHp < arg_5_1.currentHp
		end)

		local var_3_52, var_3_53 = var_0_0._getDmgTypeAndNum(var_3_1.DAMAGE)

		var_0_0._buildActEffect(arg_3_1.actEffect, var_3_46[1].id, var_3_52, var_3_53, arg_3_4)

		return var_3_46[1].id
	end

	return var_3_0
end

local var_0_2 = {
	ConsumeBuffUpSkillDamageRate = true
}

function var_0_0._buildSkillEffectHealOrDmg(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
	local var_6_0 = FightEnum.EffectType.HEAL
	local var_6_1 = FightEnum.EffectType.DAMAGE
	local var_6_2 = FightEnum.EffectType.ORIGINDAMAGE
	local var_6_3 = FightEnum.EffectType.ADDITIONALDAMAGE

	for iter_6_0 = 1, FightEnum.MaxBehavior do
		local var_6_4 = arg_6_0["behavior" .. iter_6_0]
		local var_6_5 = arg_6_0["condition" .. iter_6_0]
		local var_6_6 = arg_6_0["conditionTarget" .. iter_6_0]
		local var_6_7 = var_0_0._checkBehaviorCondition(var_6_5, var_6_6, arg_6_2, arg_6_3)

		if not string.nilorempty(var_6_4) and var_6_7 then
			local var_6_8 = string.splitToNumber(var_6_4, "#")[1]
			local var_6_9 = var_6_8 and lua_skill_behavior.configDict[var_6_8]

			if var_6_9 then
				local var_6_10 = arg_6_0["behaviorTarget" .. iter_6_0]
				local var_6_11 = arg_6_0["conditionTarget" .. iter_6_0]
				local var_6_12 = var_6_10

				if var_6_10 == 0 then
					var_6_12 = arg_6_0.logicTarget
				elseif var_6_10 == 999 then
					var_6_12 = var_6_11 ~= 0 and var_6_11 or arg_6_0.logicTarget
				end

				if string.find(string.lower(var_6_9.type), "origindamage") then
					var_0_0._buildOneSkillEffectHealOrDmg(arg_6_0, iter_6_0, var_6_8, var_6_12, var_6_2, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
				elseif string.find(string.lower(var_6_9.type), "additionaldamage") then
					var_0_0._buildOneSkillEffectHealOrDmg(arg_6_0, iter_6_0, var_6_8, var_6_12, var_6_3, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
				elseif string.find(string.lower(var_6_9.type), "heal") then
					var_0_0._buildOneSkillEffectHealOrDmg(arg_6_0, iter_6_0, var_6_8, var_6_12, var_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
				elseif (string.find(string.lower(var_6_9.type), "damage") or string.find(string.lower(var_6_9.type), "lostlife")) and not var_0_2[var_6_9.type] then
					var_0_0._buildOneSkillEffectHealOrDmg(arg_6_0, iter_6_0, var_6_8, var_6_12, var_6_1, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
				end
			end
		end
	end
end

function var_0_0._buildOneSkillEffectHealOrDmg(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6, arg_7_7, arg_7_8, arg_7_9, arg_7_10)
	local var_7_0 = var_0_0._getBehaviorTargetIds(arg_7_5.actEffect, arg_7_0, arg_7_1, arg_7_6, arg_7_7, arg_7_8, arg_7_9, arg_7_10)
	local var_7_1, var_7_2 = var_0_0._getDmgTypeAndNum(arg_7_4)

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		var_0_0._buildActEffect(arg_7_5.actEffect, iter_7_1, var_7_1, var_7_2, arg_7_8).configEffect = arg_7_2
	end
end

var_0_0.customDamage = nil
var_0_0.defaultDamage = 1234
var_0_0.defaultCrit = 2468

function var_0_0._getDmgTypeAndNum(arg_8_0)
	local var_8_0 = arg_8_0
	local var_8_1 = SkillEditorSideView.isCrit
	local var_8_2 = 0

	if var_0_0.customDamage then
		var_8_2 = var_0_0.customDamage
	else
		var_8_2 = var_8_1 and var_0_0.defaultCrit or var_0_0.defaultDamage
	end

	if arg_8_0 == FightEnum.EffectType.ORIGINDAMAGE then
		var_8_0 = var_8_1 and FightEnum.EffectType.ORIGINCRIT or FightEnum.EffectType.ORIGINDAMAGE
	elseif arg_8_0 == FightEnum.EffectType.ADDITIONALDAMAGE then
		var_8_0 = var_8_1 and FightEnum.EffectType.ADDITIONALDAMAGECRIT or FightEnum.EffectType.ADDITIONALDAMAGE
	elseif arg_8_0 == FightEnum.EffectType.DAMAGE then
		var_8_0 = var_8_1 and FightEnum.EffectType.CRIT or FightEnum.EffectType.DAMAGE
	elseif arg_8_0 == FightEnum.EffectType.HEAL then
		var_8_0 = var_8_1 and FightEnum.EffectType.HEALCRIT or FightEnum.EffectType.HEAL
	end

	return var_8_0, var_8_2
end

local var_0_3 = {
	[FightEnum.EffectType.MISS] = true,
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.HEAL] = true,
	[FightEnum.EffectType.SHIELD] = true
}

function var_0_0._buildActEffect(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = FightActEffectData.New()

	var_9_0.targetId = arg_9_1
	var_9_0.effectType = arg_9_2
	var_9_0.effectNum = arg_9_3
	var_9_0.fromSide = arg_9_4

	if var_0_3[arg_9_2] then
		var_9_0.configEffect = FightEnum.DirectDamageType
	end

	table.insert(arg_9_0, var_9_0)

	local var_9_1 = FightDataHelper.entityMgr:getById(arg_9_1)

	if arg_9_2 == FightEnum.EffectType.DAMAGE and var_9_1.shieldValue > 0 then
		var_9_0.effectType = FightEnum.EffectType.SHIELD
		var_9_0.effectNum = Mathf.Clamp(var_9_1.shieldValue - arg_9_3, 0, var_9_1.shieldValue)
		var_9_0.configEffect = 0

		local var_9_2 = FightActEffectData.New()

		var_9_2.targetId = arg_9_1
		var_9_2.effectType = arg_9_2
		var_9_2.effectNum = arg_9_3 < var_9_1.shieldValue and 0 or arg_9_3 - var_9_1.shieldValue
		var_9_2.fromSide = arg_9_4

		if var_0_3[arg_9_2] then
			var_9_2.configEffect = FightEnum.DirectDamageType
		end

		table.insert(arg_9_0, var_9_2)

		if arg_9_3 >= var_9_1.shieldValue then
			local var_9_3 = FightActEffectData.New()

			var_9_3.targetId = arg_9_1
			var_9_3.effectType = FightEnum.EffectType.SHIELDDEL
			var_9_3.effectNum = 0
			var_9_3.fromSide = arg_9_4
			var_9_3.configEffect = 0

			table.insert(arg_9_0, var_9_3)

			local var_9_4 = var_9_1:getBuffDic()

			for iter_9_0, iter_9_1 in pairs(var_9_4) do
				local var_9_5 = lua_skill_buff.configDict[iter_9_1.buffId]

				if var_9_5 and not string.nilorempty(var_9_5.features) then
					local var_9_6 = GameUtil.splitString2(var_9_5.features, true)

					for iter_9_2, iter_9_3 in ipairs(var_9_6) do
						local var_9_7 = iter_9_3[1]
						local var_9_8 = var_9_7 and lua_buff_act.configDict[var_9_7]

						if (var_9_8 and var_9_8.type) == "Shield" then
							local var_9_9 = FightActEffectData.New()

							var_9_9.targetId = iter_9_1.entityId
							var_9_9.effectType = FightEnum.EffectType.BUFFDEL
							var_9_9.effectNum = 0
							var_9_9.buff = iter_9_1
							var_9_9.configEffect = 0

							table.insert(arg_9_0, var_9_9)

							break
						end
					end
				end
			end
		end
	end

	return var_9_0
end

local var_0_4 = {}

function var_0_0._buildBehaviorBuffs(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6)
	var_0_4 = {}

	for iter_10_0 = 1, FightEnum.MaxBehavior do
		local var_10_0 = arg_10_0["behavior" .. iter_10_0]
		local var_10_1 = arg_10_0["condition" .. iter_10_0]
		local var_10_2 = arg_10_0["conditionTarget" .. iter_10_0]
		local var_10_3 = var_0_0._checkBehaviorCondition(var_10_1, var_10_2, arg_10_2, arg_10_3)

		if not string.nilorempty(var_10_0) and var_10_3 then
			local var_10_4 = string.splitToNumber(var_10_0, "#")

			if var_10_4[1] == 1 then
				local var_10_5 = var_10_4[2]
				local var_10_6 = var_10_4[3] or 1
				local var_10_7 = var_0_0._getBehaviorTargetIds(arg_10_1, arg_10_0, iter_10_0, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6)

				var_0_0._buildOneBehaviorBuffs(arg_10_0, arg_10_1, var_10_5, var_10_6, var_10_7, arg_10_2, arg_10_3, arg_10_4)
			elseif var_10_4[1] == 20021 or var_10_4[1] == 20022 or var_10_4[1] == 20023 then
				local var_10_8 = lua_skill_buff.configDict[var_10_4[2]]

				if var_10_8 then
					local var_10_9 = string.split(var_10_8.features, "#")
					local var_10_10 = var_10_4[3] or 1

					for iter_10_1 = 1, var_10_10 do
						local var_10_11 = math.random(1, #var_10_9)
						local var_10_12 = table.remove(var_10_9, var_10_11)
						local var_10_13 = string.splitToNumber(var_10_12, ",")[1]
						local var_10_14 = var_0_0._getBehaviorTargetIds(arg_10_1, arg_10_0, iter_10_0, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6)

						var_0_0._buildOneBehaviorBuffs(arg_10_0, arg_10_1, var_10_13, 1, var_10_14, arg_10_2, arg_10_3, arg_10_4)
					end
				else
					logError("buff config not exist: " .. var_10_4[2])
				end
			end
		end
	end
end

function var_0_0._buildOneBehaviorBuffs(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7)
	for iter_11_0, iter_11_1 in ipairs(arg_11_4) do
		for iter_11_2 = 1, arg_11_3 do
			local var_11_0 = lua_skill_buff.configDict[arg_11_2]
			local var_11_1 = var_0_0._getExistBuffMO(iter_11_1, arg_11_2)
			local var_11_2 = FightDef_pb.BuffInfo()

			var_11_2.buffId = arg_11_2
			var_11_2.duration = var_11_1 and var_11_1.duration + var_11_0.duringTime or var_11_0.duringTime
			var_11_2.count = var_11_1 and var_11_1.count + var_11_0.effectCount or var_11_0.effectCount
			var_11_2.uid = var_11_1 and var_11_1.uid or SkillEditorBuffSelectView.genBuffUid()

			local var_11_3 = FightBuffInfoData.New(var_11_2, iter_11_1)
			local var_11_4 = FightActEffectData.New()

			var_11_4.targetId = iter_11_1
			var_11_4.effectType = var_11_1 and FightEnum.EffectType.BUFFUPDATE or FightEnum.EffectType.BUFFADD
			var_11_4.effectNum = 1
			var_11_4.fromSide = arg_11_7
			var_11_4.buff = var_11_3

			table.insert(var_0_4, var_11_3)
			table.insert(arg_11_1, var_11_4)
			var_0_0._buildBuffShield(var_11_3, arg_11_1, arg_11_5, arg_11_6, arg_11_7)
		end
	end
end

function var_0_0._getExistBuffMO(arg_12_0, arg_12_1)
	local var_12_0 = FightHelper.getEntity(arg_12_0)

	if not var_12_0 then
		return
	end

	local var_12_1 = lua_skill_buff.configDict[arg_12_1]
	local var_12_2 = var_12_1 and lua_skill_bufftype.configDict[var_12_1.typeId]
	local var_12_3 = var_12_2 and var_12_2.includeTypes
	local var_12_4 = var_12_3 and string.splitToNumber(var_12_3, "#")[1]

	if not var_12_4 then
		return
	end

	local var_12_5 = var_12_0:getMO():getBuffList()

	if var_12_4 == 2 or var_12_4 == 10 or var_12_4 == 11 or var_12_4 == 12 then
		for iter_12_0 = #var_0_4, 1, -1 do
			local var_12_6 = var_0_4[iter_12_0]

			if var_12_6.entityId == arg_12_0 and var_12_6.buffId == arg_12_1 then
				return var_12_6
			end
		end

		for iter_12_1, iter_12_2 in ipairs(var_12_5) do
			if iter_12_2.buffId == arg_12_1 then
				return iter_12_2
			end
		end
	end
end

function var_0_0._buildBuffShield(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = lua_skill_buff.configDict[arg_13_0.buffId]

	if var_13_0 and not string.nilorempty(var_13_0.features) then
		local var_13_1 = GameUtil.splitString2(var_13_0.features, true)

		for iter_13_0, iter_13_1 in ipairs(var_13_1) do
			local var_13_2 = iter_13_1[1]
			local var_13_3 = var_13_2 and lua_buff_act.configDict[var_13_2]

			if (var_13_3 and var_13_3.type) == "Shield" then
				local var_13_4 = (tonumber(iter_13_1[4]) or 1000) * 0.001
				local var_13_5 = FightActEffectData.New()

				var_13_5.targetId = arg_13_0.entityId
				var_13_5.effectType = FightEnum.EffectType.SHIELD

				local var_13_6 = FightHelper.getEntity(arg_13_3)

				var_13_5.effectNum = var_13_6 and math.ceil(var_13_4 * var_13_6:getMO().attrMO.hp) or 100
				var_13_5.fromSide = arg_13_4

				table.insert(arg_13_1, var_13_5)
			end
		end
	end
end

function var_0_0._checkRemoveBuffs(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6)
	var_0_0._checkRemoveBuff(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6)
	var_0_0._checkRemove3070Buff1(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	var_0_0._checkRemove3070Buff2(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
end

function var_0_0._checkRemoveBuff(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6)
	for iter_15_0 = 1, FightEnum.MaxBehavior do
		local var_15_0 = arg_15_0["behavior" .. iter_15_0]
		local var_15_1 = arg_15_0["condition" .. iter_15_0]
		local var_15_2 = arg_15_0["conditionTarget" .. iter_15_0]
		local var_15_3 = var_0_0._checkBehaviorCondition(var_15_1, var_15_2, arg_15_2, arg_15_3)

		if not string.nilorempty(var_15_0) and var_15_3 then
			local var_15_4 = string.splitToNumber(var_15_0, "#")[1]
			local var_15_5 = arg_15_0["behaviorTarget" .. iter_15_0]
			local var_15_6 = arg_15_0["conditionTarget" .. iter_15_0]
			local var_15_7 = var_0_0._getBehaviorTargetIds(arg_15_1, arg_15_0, iter_15_0, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6)
			local var_15_8 = var_15_4 and lua_skill_behavior.configDict[var_15_4]

			if var_15_8 and string.find(var_15_8.type, "Disperse") == 1 then
				for iter_15_1, iter_15_2 in ipairs(var_15_7) do
					local var_15_9 = FightDataHelper.entityMgr:getById(iter_15_2)

					for iter_15_3, iter_15_4 in pairs(var_15_9:getBuffDic()) do
						if lua_skill_buff.configDict[iter_15_4.buffId].isGoodBuff == 1 then
							local var_15_10 = FightActEffectData.New()

							var_15_10.targetId = var_15_9.id
							var_15_10.effectType = FightEnum.EffectType.BUFFDEL
							var_15_10.buff = iter_15_4

							table.insert(arg_15_1, 1, var_15_10)
						end
					end
				end
			end

			if var_15_8 and string.find(var_15_8.type, "Purify") == 1 then
				for iter_15_5, iter_15_6 in ipairs(var_15_7) do
					local var_15_11 = FightDataHelper.entityMgr:getById(iter_15_6)

					for iter_15_7, iter_15_8 in pairs(var_15_11:getBuffDic()) do
						if lua_skill_buff.configDict[iter_15_8.buffId].isGoodBuff == 2 then
							local var_15_12 = FightActEffectData.New()

							var_15_12.targetId = var_15_11.id
							var_15_12.effectType = FightEnum.EffectType.BUFFDEL
							var_15_12.buff = iter_15_8

							table.insert(arg_15_1, 1, var_15_12)
						end
					end
				end
			end
		end
	end
end

function var_0_0._checkRemove3070Buff1(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	if FightDataHelper.entityMgr:getById(arg_16_2).modelId ~= 3070 or FightCardDataHelper.isBigSkill(arg_16_0.id) then
		return
	end

	local var_16_0 = FightDataHelper.entityMgr:getById(arg_16_2)
	local var_16_1 = 0
	local var_16_2 = 0
	local var_16_3 = {}
	local var_16_4 = {}

	for iter_16_0, iter_16_1 in pairs(var_16_0:getBuffDic()) do
		local var_16_5 = lua_skill_buff.configDict[iter_16_1.buffId]

		if FightEntitySpecialEffect3070_Ball.buffTypeId2EffectPath[var_16_5.typeId] then
			var_16_1 = var_16_1 + 1

			table.insert(var_16_3, iter_16_1)
			table.insert(var_16_4, iter_16_1)
		end
	end

	for iter_16_2, iter_16_3 in ipairs(arg_16_1) do
		if iter_16_3.effectType == FightEnum.EffectType.BUFFADD then
			local var_16_6 = lua_skill_buff.configDict[iter_16_3.buff.buffId]

			if FightEntitySpecialEffect3070_Ball.buffTypeId2EffectPath[var_16_6.typeId] then
				var_16_2 = var_16_2 + 1

				table.insert(var_16_3, iter_16_3.buff)
			end
		end
	end

	if #var_16_4 > 0 then
		local var_16_7 = 4

		for iter_16_4, iter_16_5 in ipairs(var_16_3) do
			local var_16_8 = lua_skill_buff.configDict[iter_16_5.buffId]
			local var_16_9 = lua_skill_bufftype.configDict[var_16_8.typeId]
			local var_16_10 = string.splitToNumber(var_16_9.includeTypes, "#")[2]

			var_16_7 = var_16_10 < var_16_7 and var_16_10 or var_16_7
		end

		local var_16_11 = var_16_1 + var_16_2 - var_16_7

		var_16_11 = var_16_1 < var_16_11 and var_16_1 or var_16_11

		for iter_16_6 = 1, var_16_11 do
			local var_16_12 = FightActEffectData.New()

			var_16_12.targetId = arg_16_2
			var_16_12.effectType = FightEnum.EffectType.BUFFDEL
			var_16_12.buff = var_16_4[iter_16_6]

			table.insert(arg_16_1, 1, var_16_12)
		end
	end
end

function var_0_0._checkRemove3070Buff2(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	local var_17_0 = FightDataHelper.entityMgr:getById(arg_17_2)

	if var_17_0.modelId ~= 3070 or not FightCardDataHelper.isBigSkill(arg_17_0.id) then
		return
	end

	local var_17_1 = 0
	local var_17_2 = 0
	local var_17_3

	for iter_17_0, iter_17_1 in pairs(var_17_0:getBuffDic()) do
		local var_17_4 = lua_skill_buff.configDict[iter_17_1.buffId]

		if FightEntitySpecialEffect3070_Ball.buffTypeId2EffectPath[var_17_4.typeId] then
			local var_17_5 = FightActEffectData.New()

			var_17_5.targetId = arg_17_2
			var_17_5.effectType = FightEnum.EffectType.BUFFDEL
			var_17_5.buff = iter_17_1

			table.insert(arg_17_1, 1, var_17_5)
		end
	end
end

function var_0_0._checkBuildAddPowerStep(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	local var_18_0 = FightHelper.getEntity(arg_18_2)

	if not var_18_0:getMO():isCharacter() then
		return
	end

	local var_18_1 = SkillConfig.instance:getpassiveskillsCO(var_18_0:getMO().modelId)

	if not var_18_1 then
		return
	end

	for iter_18_0, iter_18_1 in ipairs(var_18_1) do
		local var_18_2 = iter_18_1 and lua_skill.configDict[iter_18_1.skillPassive]

		if var_18_2 then
			for iter_18_2 = 1, FightEnum.MaxBehavior do
				local var_18_3 = var_18_2["condition" .. iter_18_2]
				local var_18_4 = var_18_2["behavior" .. iter_18_2]
				local var_18_5 = var_18_2["conditionTarget" .. iter_18_2]
				local var_18_6 = var_18_2["behaviorTarget" .. iter_18_2]

				if not string.nilorempty(var_18_3) and not string.nilorempty(var_18_4) and var_18_5 == 103 and var_18_6 == 103 then
					local var_18_7 = string.splitToNumber(var_18_3, "#")
					local var_18_8 = string.splitToNumber(var_18_4, "#")
					local var_18_9 = var_18_7[1]
					local var_18_10 = var_18_8[1]
					local var_18_11 = var_18_9 and lua_skill_behavior_condition.configDict[var_18_9]
					local var_18_12 = var_18_10 and lua_skill_behavior.configDict[var_18_10]

					if var_18_12 and var_18_12.type == "ChangePower" then
						if var_18_11 and var_18_11.type == "ActiveUseSkill" then
							local var_18_13 = var_18_7[2] or 1

							if FightConfig.instance:getSkillLv(arg_18_0.id) == var_18_13 then
								local var_18_14 = var_18_8[2] or 1

								return var_0_0._buildOneAddPowerStep(var_18_2.id, arg_18_2, arg_18_3, var_18_14)
							end
						else
							return var_0_0._buildOneAddPowerStep(var_18_2.id, arg_18_2, arg_18_3, 1)
						end
					end
				end
			end
		end
	end
end

function var_0_0._buildOneAddPowerStep(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = FightStepData.New()

	var_19_0.editorPlaySkill = true
	var_19_0.actType = 1
	var_19_0.fromId = arg_19_1
	var_19_0.toId = arg_19_2
	var_19_0.actId = arg_19_0
	var_19_0.actEffect = {
		FightActEffectData.New()
	}
	var_19_0.actEffect[1].targetId = arg_19_1
	var_19_0.actEffect[1].effectType = FightEnum.EffectType.POWERCHANGE
	var_19_0.actEffect[1].effectNum = arg_19_3
	var_19_0.actEffect[1].configEffect = 1
	var_19_0.actEffect[1].buffActId = 0

	return var_19_0
end

function var_0_0._buildMagicCircle(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5, arg_20_6)
	for iter_20_0 = 1, FightEnum.MaxBehavior do
		local var_20_0 = arg_20_0["behavior" .. iter_20_0]
		local var_20_1 = arg_20_0["condition" .. iter_20_0]
		local var_20_2 = true

		if not string.nilorempty(var_20_1) then
			local var_20_3 = string.splitToNumber(var_20_1, "#")[1]
			local var_20_4 = var_20_3 and lua_skill_behavior_condition.configDict[var_20_3]

			var_20_2 = var_20_4 and var_20_4.type == "None"
		end

		if not string.nilorempty(var_20_0) and var_20_2 then
			local var_20_5 = string.splitToNumber(var_20_0, "#")
			local var_20_6 = tonumber(var_20_5[1])
			local var_20_7 = var_20_6 and lua_skill_behavior.configDict[var_20_6]

			if var_20_7 then
				if var_20_7.type == "AddMagicCircle" then
					local var_20_8 = FightModel.instance:getMagicCircleInfo()

					if var_20_8.magicCircleId then
						local var_20_9 = FightActEffectData.New()

						var_20_9.targetId = 0
						var_20_9.effectType = FightEnum.EffectType.MAGICCIRCLEDELETE
						var_20_9.reserveId = var_20_8.magicCircleId

						table.insert(arg_20_1, var_20_9)
					end

					local var_20_10 = lua_magic_circle.configDict[tonumber(var_20_5[2])]

					if var_20_10 then
						local var_20_11 = FightActEffectData.New()

						var_20_11.targetId = 0
						var_20_11.effectType = FightEnum.EffectType.MAGICCIRCLEADD
						var_20_11.magicCircle = {
							magicCircleId = var_20_10.id,
							round = var_20_10.round,
							createUid = arg_20_2
						}

						table.insert(arg_20_1, var_20_11)
					end
				elseif var_20_7.type == "ChangeSummonedLevel" then
					local var_20_12 = FightModel.instance:getMagicCircleInfo()

					if var_20_12.magicCircleId then
						local var_20_13 = FightActEffectData.New()

						var_20_13.targetId = 0
						var_20_13.effectType = FightEnum.EffectType.MAGICCIRCLEDELETE
						var_20_13.reserveId = var_20_12.magicCircleId

						table.insert(arg_20_1, var_20_13)
					end
				end
			end
		end
	end
end

function var_0_0._buildSummoned(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5, arg_21_6)
	local var_21_0 = {}
	local var_21_1 = {}

	for iter_21_0 = 1, FightEnum.MaxBehavior do
		local var_21_2 = arg_21_0["behavior" .. iter_21_0]
		local var_21_3 = arg_21_0["condition" .. iter_21_0]
		local var_21_4 = true

		if not string.nilorempty(var_21_3) then
			local var_21_5 = string.splitToNumber(var_21_3, "#")[1]
			local var_21_6 = var_21_5 and lua_skill_behavior_condition.configDict[var_21_5]

			var_21_4 = var_21_6 and var_21_6.type == "None"
		end

		if not string.nilorempty(var_21_2) and var_21_4 then
			local var_21_7 = string.splitToNumber(var_21_2, "#")
			local var_21_8 = arg_21_0["behaviorTarget" .. iter_21_0]
			local var_21_9 = arg_21_0["conditionTarget" .. iter_21_0]
			local var_21_10 = var_21_8

			if var_21_8 == 0 then
				local var_21_11 = arg_21_0.logicTarget
			elseif var_21_8 == 999 then
				local var_21_12

				var_21_12 = var_21_9 ~= 0 and var_21_9 or arg_21_0.logicTarget
			end

			local var_21_13 = tonumber(var_21_7[1])
			local var_21_14 = var_21_13 and lua_skill_behavior.configDict[var_21_13]

			if var_21_14 then
				local var_21_15 = arg_21_0["behaviorTarget" .. iter_21_0]
				local var_21_16 = arg_21_0["conditionTarget" .. iter_21_0]
				local var_21_17 = var_21_15

				if var_21_15 == 0 then
					var_21_17 = arg_21_0.logicTarget
				elseif var_21_15 == 999 then
					var_21_17 = var_21_16 ~= 0 and var_21_16 or arg_21_0.logicTarget
				end

				if var_21_14.type == "AddSummoned" then
					local var_21_18 = var_0_0._getTargetIds(var_21_17, arg_21_2, arg_21_3, arg_21_4, arg_21_5, arg_21_6)

					for iter_21_1, iter_21_2 in ipairs(var_21_18) do
						local var_21_19 = tonumber(var_21_7[2])
						local var_21_20 = tonumber(var_21_7[4]) or 1

						for iter_21_3 = 1, var_21_20 do
							local var_21_21 = FightConfig.instance:getSummonedConfig(var_21_19, 1).stanceId
							local var_21_22 = lua_fight_summoned_stance.configDict[var_21_21]
							local var_21_23 = 0

							for iter_21_4 = 1, 20 do
								local var_21_24 = var_21_22["pos" .. iter_21_4]

								var_21_23 = var_21_24 and #var_21_24 > 0 and var_21_23 + 1 or var_21_23
							end

							local var_21_25 = FightHelper.getEntity(iter_21_2)
							local var_21_26 = var_21_25 and var_21_25:getMO()
							local var_21_27 = var_21_26 and var_21_26.summonedInfo.dataDic or var_21_26:getSummonedInfo():getDataDic()

							if var_21_23 > tabletool.len(var_21_27) + tabletool.len(var_21_0) then
								local var_21_28 = {
									summonedId = var_21_19,
									level = tonumber(var_21_7[3]),
									uid = SkillEditorBuffSelectView.genBuffUid(),
									fromUid = arg_21_2
								}
								local var_21_29 = FightActEffectData.New()

								var_21_29.targetId = iter_21_2
								var_21_29.effectType = FightEnum.EffectType.SUMMONEDADD
								var_21_29.effectNum = 0
								var_21_29.configEffect = 0
								var_21_29.buffActId = 0
								var_21_29.reserveId = var_21_28.uid
								var_21_29.reserveStr = ""
								var_21_29.summoned = var_21_28

								table.insert(arg_21_1, var_21_29)

								var_21_1[var_21_28.uid] = var_21_28.level
								var_21_0[var_21_28.uid] = var_21_28

								var_0_0._buildSummonedDelete(var_21_28, arg_21_1, arg_21_2, iter_21_2, arg_21_4)
							end
						end
					end
				elseif var_21_14.type == "ChangeSummonedLevel" then
					local var_21_30 = var_0_0._getTargetIds(var_21_17, arg_21_2, arg_21_3, arg_21_4, arg_21_5, arg_21_6)

					for iter_21_5, iter_21_6 in ipairs(var_21_30) do
						local var_21_31 = tonumber(var_21_7[2])
						local var_21_32 = FightHelper.getEntity(iter_21_6)
						local var_21_33 = var_21_32 and var_21_32:getMO()
						local var_21_34 = var_21_33 and var_21_33.summonedInfo.dataDic or {}
						local var_21_35 = tabletool.copy(var_21_34)

						for iter_21_7, iter_21_8 in pairs(var_21_0) do
							var_21_35[iter_21_7] = iter_21_8
						end

						for iter_21_9, iter_21_10 in pairs(var_21_35) do
							if iter_21_10.summonedId == var_21_31 then
								local var_21_36 = {}
								local var_21_37 = var_21_1[iter_21_10.uid] or iter_21_10.level

								var_21_36.summonedId = var_21_31
								var_21_36.level = tonumber(var_21_7[3])
								var_21_36.uid = iter_21_10.uid
								var_21_36.fromUid = arg_21_2

								local var_21_38 = FightActEffectData.New()

								var_21_38.targetId = iter_21_6
								var_21_38.effectType = FightEnum.EffectType.SUMMONEDLEVELUP
								var_21_38.effectNum = var_21_36.level - var_21_37
								var_21_38.configEffect = 0
								var_21_38.buffActId = 0
								var_21_38.reserveId = var_21_36.uid
								var_21_38.reserveStr = ""
								var_21_38.summoned = var_21_36

								table.insert(arg_21_1, var_21_38)

								var_21_1[iter_21_10.uid] = var_21_36.level

								var_0_0._buildSummonedDelete(var_21_36, arg_21_1, arg_21_2, iter_21_6, arg_21_4)
							end
						end
					end
				end
			end
		end
	end
end

function var_0_0._buildSummonedDelete(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	local var_22_0 = FightConfig.instance:getSummonedConfig(arg_22_0.summonedId, arg_22_0.level)

	if var_22_0 and arg_22_0.level >= var_22_0.maxLevel then
		local var_22_1 = FightActEffectData.New()

		var_22_1.targetId = arg_22_3
		var_22_1.effectType = FightEnum.EffectType.SUMMONEDDELETE
		var_22_1.effectNum = 0
		var_22_1.configEffect = 0
		var_22_1.buffActId = 0
		var_22_1.reserveId = arg_22_0.uid
		var_22_1.reserveStr = ""

		table.insert(arg_22_1, var_22_1)
	end
end

function var_0_0._getTargetIds(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5)
	if FightEnum.LogicTargetClassify.Single[arg_23_0] then
		return {
			arg_23_2
		}
	elseif FightEnum.LogicTargetClassify.SingleAndRandom[arg_23_0] then
		return {
			arg_23_2,
			arg_23_5
		}
	elseif FightEnum.LogicTargetClassify.MySideAll[arg_23_0] then
		local var_23_0 = {}
		local var_23_1 = FightDataHelper.entityMgr:getNormalList(arg_23_3)

		for iter_23_0, iter_23_1 in ipairs(var_23_1) do
			table.insert(var_23_0, iter_23_1.id)

			return var_23_0
		end
	elseif FightEnum.LogicTargetClassify.Me[arg_23_0] then
		return {
			arg_23_1
		}
	end
end

local var_0_5 = 3065

function var_0_0._checkRegainPowerAfterAct(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5)
	local var_24_0
	local var_24_1 = FightHelper.getSideEntitys(arg_24_5, false)

	for iter_24_0, iter_24_1 in ipairs(var_24_1) do
		if iter_24_1:getMO() and iter_24_1:getMO().modelId == var_0_5 then
			var_24_0 = iter_24_1.id

			break
		end
	end

	if not var_24_0 then
		return
	end

	local var_24_2 = FightHelper.getEntity(arg_24_2):getMO():getBuffList()

	for iter_24_2, iter_24_3 in ipairs(var_24_2) do
		local var_24_3 = lua_skill_buff.configDict[iter_24_3.buffId]
		local var_24_4 = var_24_3 and var_24_3.features

		if not string.nilorempty(var_24_4) then
			local var_24_5 = GameUtil.splitString2(var_24_4, true)

			for iter_24_4, iter_24_5 in ipairs(var_24_5) do
				local var_24_6 = iter_24_5[1] and lua_buff_act.configDict[iter_24_5[1]]

				if var_24_6 and var_24_6.type == "RegainPowerAfterAct" then
					local var_24_7 = FightActEffectData.New()

					var_24_7.targetId = var_24_0
					var_24_7.effectType = FightEnum.EffectType.POWERCHANGE
					var_24_7.effectNum = iter_24_5[2] or 1
					var_24_7.configEffect = 1
					var_24_7.buffActId = 0

					table.insert(arg_24_1, var_24_7)
				end
			end
		end
	end
end

function var_0_0._checkBehaviorCondition(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if string.nilorempty(arg_25_0) then
		return true
	end

	local var_25_0 = string.splitToNumber(arg_25_0, "#")
	local var_25_1 = var_25_0[1]
	local var_25_2 = var_25_0[2]
	local var_25_3 = var_25_1 and lua_skill_behavior_condition.configDict[var_25_1]

	if not var_25_3 or var_25_3.type == "None" then
		return true
	end

	local var_25_4 = FightEnum.LogicTargetClassify.Me[arg_25_1] and arg_25_2 or arg_25_3
	local var_25_5 = FightHelper.getEntity(var_25_4)

	if var_25_3.type == "NoBuffId" and var_25_5 then
		for iter_25_0, iter_25_1 in pairs(var_25_5:getMO():getBuffDic()) do
			if iter_25_1.buffId == var_25_2 then
				return false
			end
		end

		return true
	end

	if var_25_3.type == "HasBuffId" and var_25_5 then
		for iter_25_2, iter_25_3 in pairs(var_25_5:getMO():getBuffDic()) do
			if iter_25_3.buffId == var_25_2 then
				return true
			end
		end

		return false
	end

	return true
end

function var_0_0._getBehaviorTargetIds(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5, arg_26_6, arg_26_7)
	local var_26_0 = arg_26_1.logicTarget
	local var_26_1 = arg_26_1["behaviorTarget" .. arg_26_2]
	local var_26_2 = arg_26_1["conditionTarget" .. arg_26_2]
	local var_26_3 = var_26_1

	if var_26_1 == 0 then
		var_26_3 = var_26_0
	elseif var_26_1 == 999 then
		var_26_3 = var_26_2 ~= 0 and var_26_2 or var_26_0
	end

	local function var_26_4(arg_27_0, arg_27_1)
		if not tabletool.indexOf(arg_27_0, arg_27_1) then
			table.insert(arg_27_0, arg_27_1)
		end
	end

	local var_26_5 = {}

	if var_26_3 == FightEnum.CondTargetHpMin then
		local var_26_6 = arg_26_3
		local var_26_7 = 1
		local var_26_8 = FightDataHelper.entityMgr:getNormalList(arg_26_5)

		for iter_26_0, iter_26_1 in ipairs(var_26_8) do
			local var_26_9 = iter_26_1.currentHp / iter_26_1.attrMO.hp

			if var_26_9 < var_26_7 then
				var_26_6 = iter_26_1.id
				var_26_7 = var_26_9
			end
		end

		var_26_4(var_26_5, var_26_6)
	elseif FightEnum.LogicTargetClassify.Special[var_26_3] then
		var_26_4(var_26_5, arg_26_4)
	elseif FightEnum.LogicTargetClassify.Single[var_26_3] then
		var_26_4(var_26_5, arg_26_4)
	elseif FightEnum.LogicTargetClassify.SingleAndRandom[var_26_3] then
		var_26_4(var_26_5, arg_26_4)

		if arg_26_7 then
			var_26_4(var_26_5, arg_26_7)
		else
			local var_26_10 = arg_26_1.targetLimit == FightEnum.TargetLimit.EnemySide
			local var_26_11 = FightHelper.getSideEntitys(var_26_10 and arg_26_6 or arg_26_5)

			for iter_26_2, iter_26_3 in ipairs(var_26_11) do
				if iter_26_3.id == arg_26_4 then
					table.remove(var_26_11, iter_26_2)

					break
				end
			end

			if #var_26_11 > 0 then
				local var_26_12 = var_26_11[math.random(#var_26_11)]

				arg_26_7 = var_26_12.id

				var_26_4(var_26_5, var_26_12.id)
			end
		end
	elseif FightEnum.LogicTargetClassify.EnemySideAll[var_26_3] then
		local var_26_13 = FightDataHelper.entityMgr:getNormalList(arg_26_6)

		for iter_26_4, iter_26_5 in ipairs(var_26_13) do
			var_26_4(var_26_5, iter_26_5.id)
		end
	elseif FightEnum.LogicTargetClassify.EnemySideindex[var_26_3] then
		local var_26_14 = var_26_3 - 225
		local var_26_15 = FightDataHelper.entityMgr:getNormalList(arg_26_6)

		table.sort(var_26_15, function(arg_28_0, arg_28_1)
			return arg_28_0.position < arg_28_1.position
		end)

		for iter_26_6, iter_26_7 in ipairs(var_26_15) do
			if iter_26_6 == var_26_14 then
				var_26_4(var_26_5, iter_26_7.id)
			end
		end
	elseif FightEnum.LogicTargetClassify.MySideAll[var_26_3] then
		local var_26_16 = FightDataHelper.entityMgr:getNormalList(arg_26_5)

		for iter_26_8, iter_26_9 in ipairs(var_26_16) do
			var_26_4(var_26_5, iter_26_9.id)
		end
	elseif FightEnum.LogicTargetClassify.Me[var_26_3] then
		var_26_4(var_26_5, arg_26_3)
	elseif FightEnum.LogicTargetClassify.SecondaryTarget[var_26_3] then
		if arg_26_1.logicTarget == 202 then
			local var_26_17 = FightDataHelper.entityMgr:getNormalList(arg_26_6)

			for iter_26_10, iter_26_11 in ipairs(var_26_17) do
				if iter_26_11.id ~= arg_26_4 then
					var_26_4(var_26_5, iter_26_11.id)
				end
			end
		end
	elseif FightEnum.LogicTargetClassify.StanceAndBefore[var_26_3] then
		local var_26_18 = FightDataHelper.entityMgr:getById(arg_26_3)
		local var_26_19 = FightDataHelper.entityMgr:getNormalList(arg_26_5)

		for iter_26_12, iter_26_13 in ipairs(var_26_19) do
			if iter_26_13.position <= var_26_18.position then
				var_26_4(var_26_5, iter_26_13.id)
			end
		end
	elseif FightEnum.LogicTargetClassify.StanceAndAfter[var_26_3] then
		local var_26_20 = FightDataHelper.entityMgr:getById(arg_26_3)
		local var_26_21 = FightDataHelper.entityMgr:getNormalList(arg_26_5)

		for iter_26_14, iter_26_15 in ipairs(var_26_21) do
			if iter_26_15.position >= var_26_20.position then
				var_26_4(var_26_5, iter_26_15.id)
			end
		end
	elseif FightEnum.LogicTargetClassify.Position[var_26_3] then
		local var_26_22 = FightHelper.getEnemySideEntitys(arg_26_3)

		for iter_26_16, iter_26_17 in ipairs(var_26_22) do
			local var_26_23 = iter_26_17:getMO()

			if var_26_23 and var_26_23.position == FightEnum.LogicTargetClassify.Position[var_26_3] then
				var_26_4(var_26_5, iter_26_17.id)
			end
		end
	end

	return var_26_5, arg_26_7
end

return var_0_0
