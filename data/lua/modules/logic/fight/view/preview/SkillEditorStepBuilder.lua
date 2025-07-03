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
	end

	return var_3_0
end

local var_0_2 = {
	ConsumeBuffUpSkillDamageRate = true
}

function var_0_0._buildSkillEffectHealOrDmg(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
	local var_5_0 = FightEnum.EffectType.HEAL
	local var_5_1 = FightEnum.EffectType.DAMAGE
	local var_5_2 = FightEnum.EffectType.ORIGINDAMAGE
	local var_5_3 = FightEnum.EffectType.ADDITIONALDAMAGE

	for iter_5_0 = 1, FightEnum.MaxBehavior do
		local var_5_4 = arg_5_0["behavior" .. iter_5_0]
		local var_5_5 = arg_5_0["condition" .. iter_5_0]
		local var_5_6 = arg_5_0["conditionTarget" .. iter_5_0]
		local var_5_7 = var_0_0._checkBehaviorCondition(var_5_5, var_5_6, arg_5_2, arg_5_3)

		if not string.nilorempty(var_5_4) and var_5_7 then
			local var_5_8 = string.splitToNumber(var_5_4, "#")[1]
			local var_5_9 = var_5_8 and lua_skill_behavior.configDict[var_5_8]

			if var_5_9 then
				local var_5_10 = arg_5_0["behaviorTarget" .. iter_5_0]
				local var_5_11 = arg_5_0["conditionTarget" .. iter_5_0]
				local var_5_12 = var_5_10

				if var_5_10 == 0 then
					var_5_12 = arg_5_0.logicTarget
				elseif var_5_10 == 999 then
					var_5_12 = var_5_11 ~= 0 and var_5_11 or arg_5_0.logicTarget
				end

				if string.find(string.lower(var_5_9.type), "origindamage") then
					var_0_0._buildOneSkillEffectHealOrDmg(arg_5_0, iter_5_0, var_5_8, var_5_12, var_5_2, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
				elseif string.find(string.lower(var_5_9.type), "additionaldamage") then
					var_0_0._buildOneSkillEffectHealOrDmg(arg_5_0, iter_5_0, var_5_8, var_5_12, var_5_3, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
				elseif string.find(string.lower(var_5_9.type), "heal") then
					var_0_0._buildOneSkillEffectHealOrDmg(arg_5_0, iter_5_0, var_5_8, var_5_12, var_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
				elseif (string.find(string.lower(var_5_9.type), "damage") or string.find(string.lower(var_5_9.type), "lostlife")) and not var_0_2[var_5_9.type] then
					var_0_0._buildOneSkillEffectHealOrDmg(arg_5_0, iter_5_0, var_5_8, var_5_12, var_5_1, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
				end
			end
		end
	end
end

function var_0_0._buildOneSkillEffectHealOrDmg(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6, arg_6_7, arg_6_8, arg_6_9, arg_6_10)
	local var_6_0 = var_0_0._getBehaviorTargetIds(arg_6_5.actEffect, arg_6_0, arg_6_1, arg_6_6, arg_6_7, arg_6_8, arg_6_9, arg_6_10)
	local var_6_1, var_6_2 = var_0_0._getDmgTypeAndNum(arg_6_4)

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		var_0_0._buildActEffect(arg_6_5.actEffect, iter_6_1, var_6_1, var_6_2, arg_6_8).configEffect = arg_6_2
	end
end

var_0_0.customDamage = nil
var_0_0.defaultDamage = 1234
var_0_0.defaultCrit = 2468

function var_0_0._getDmgTypeAndNum(arg_7_0)
	local var_7_0 = arg_7_0
	local var_7_1 = SkillEditorSideView.isCrit
	local var_7_2 = 0

	if var_0_0.customDamage then
		var_7_2 = var_0_0.customDamage
	else
		var_7_2 = var_7_1 and var_0_0.defaultCrit or var_0_0.defaultDamage
	end

	if arg_7_0 == FightEnum.EffectType.ORIGINDAMAGE then
		var_7_0 = var_7_1 and FightEnum.EffectType.ORIGINCRIT or FightEnum.EffectType.ORIGINDAMAGE
	elseif arg_7_0 == FightEnum.EffectType.ADDITIONALDAMAGE then
		var_7_0 = var_7_1 and FightEnum.EffectType.ADDITIONALDAMAGECRIT or FightEnum.EffectType.ADDITIONALDAMAGE
	elseif arg_7_0 == FightEnum.EffectType.DAMAGE then
		var_7_0 = var_7_1 and FightEnum.EffectType.CRIT or FightEnum.EffectType.DAMAGE
	elseif arg_7_0 == FightEnum.EffectType.HEAL then
		var_7_0 = var_7_1 and FightEnum.EffectType.HEALCRIT or FightEnum.EffectType.HEAL
	end

	return var_7_0, var_7_2
end

local var_0_3 = {
	[FightEnum.EffectType.MISS] = true,
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.HEAL] = true,
	[FightEnum.EffectType.SHIELD] = true
}

function var_0_0._buildActEffect(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = FightActEffectData.New()

	var_8_0.targetId = arg_8_1
	var_8_0.effectType = arg_8_2
	var_8_0.effectNum = arg_8_3
	var_8_0.fromSide = arg_8_4

	if var_0_3[arg_8_2] then
		var_8_0.configEffect = FightEnum.DirectDamageType
	end

	table.insert(arg_8_0, var_8_0)

	local var_8_1 = FightDataHelper.entityMgr:getById(arg_8_1)

	if arg_8_2 == FightEnum.EffectType.DAMAGE and var_8_1.shieldValue > 0 then
		var_8_0.effectType = FightEnum.EffectType.SHIELD
		var_8_0.effectNum = Mathf.Clamp(var_8_1.shieldValue - arg_8_3, 0, var_8_1.shieldValue)
		var_8_0.configEffect = 0

		local var_8_2 = FightActEffectData.New()

		var_8_2.targetId = arg_8_1
		var_8_2.effectType = arg_8_2
		var_8_2.effectNum = arg_8_3 < var_8_1.shieldValue and 0 or arg_8_3 - var_8_1.shieldValue
		var_8_2.fromSide = arg_8_4

		if var_0_3[arg_8_2] then
			var_8_2.configEffect = FightEnum.DirectDamageType
		end

		table.insert(arg_8_0, var_8_2)

		if arg_8_3 >= var_8_1.shieldValue then
			local var_8_3 = FightActEffectData.New()

			var_8_3.targetId = arg_8_1
			var_8_3.effectType = FightEnum.EffectType.SHIELDDEL
			var_8_3.effectNum = 0
			var_8_3.fromSide = arg_8_4
			var_8_3.configEffect = 0

			table.insert(arg_8_0, var_8_3)

			local var_8_4 = var_8_1:getBuffDic()

			for iter_8_0, iter_8_1 in pairs(var_8_4) do
				local var_8_5 = lua_skill_buff.configDict[iter_8_1.buffId]

				if var_8_5 and not string.nilorempty(var_8_5.features) then
					local var_8_6 = GameUtil.splitString2(var_8_5.features, true)

					for iter_8_2, iter_8_3 in ipairs(var_8_6) do
						local var_8_7 = iter_8_3[1]
						local var_8_8 = var_8_7 and lua_buff_act.configDict[var_8_7]

						if (var_8_8 and var_8_8.type) == "Shield" then
							local var_8_9 = FightActEffectData.New()

							var_8_9.targetId = iter_8_1.entityId
							var_8_9.effectType = FightEnum.EffectType.BUFFDEL
							var_8_9.effectNum = 0
							var_8_9.buff = iter_8_1
							var_8_9.configEffect = 0

							table.insert(arg_8_0, var_8_9)

							break
						end
					end
				end
			end
		end
	end

	return var_8_0
end

local var_0_4 = {}

function var_0_0._buildBehaviorBuffs(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)
	var_0_4 = {}

	for iter_9_0 = 1, FightEnum.MaxBehavior do
		local var_9_0 = arg_9_0["behavior" .. iter_9_0]
		local var_9_1 = arg_9_0["condition" .. iter_9_0]
		local var_9_2 = arg_9_0["conditionTarget" .. iter_9_0]
		local var_9_3 = var_0_0._checkBehaviorCondition(var_9_1, var_9_2, arg_9_2, arg_9_3)

		if not string.nilorempty(var_9_0) and var_9_3 then
			local var_9_4 = string.splitToNumber(var_9_0, "#")

			if var_9_4[1] == 1 then
				local var_9_5 = var_9_4[2]
				local var_9_6 = var_9_4[3] or 1
				local var_9_7 = var_0_0._getBehaviorTargetIds(arg_9_1, arg_9_0, iter_9_0, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)

				var_0_0._buildOneBehaviorBuffs(arg_9_0, arg_9_1, var_9_5, var_9_6, var_9_7, arg_9_2, arg_9_3, arg_9_4)
			elseif var_9_4[1] == 20021 or var_9_4[1] == 20022 or var_9_4[1] == 20023 then
				local var_9_8 = lua_skill_buff.configDict[var_9_4[2]]

				if var_9_8 then
					local var_9_9 = string.split(var_9_8.features, "#")
					local var_9_10 = var_9_4[3] or 1

					for iter_9_1 = 1, var_9_10 do
						local var_9_11 = math.random(1, #var_9_9)
						local var_9_12 = table.remove(var_9_9, var_9_11)
						local var_9_13 = string.splitToNumber(var_9_12, ",")[1]
						local var_9_14 = var_0_0._getBehaviorTargetIds(arg_9_1, arg_9_0, iter_9_0, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)

						var_0_0._buildOneBehaviorBuffs(arg_9_0, arg_9_1, var_9_13, 1, var_9_14, arg_9_2, arg_9_3, arg_9_4)
					end
				else
					logError("buff config not exist: " .. var_9_4[2])
				end
			end
		end
	end
end

function var_0_0._buildOneBehaviorBuffs(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6, arg_10_7)
	for iter_10_0, iter_10_1 in ipairs(arg_10_4) do
		for iter_10_2 = 1, arg_10_3 do
			local var_10_0 = lua_skill_buff.configDict[arg_10_2]
			local var_10_1 = var_0_0._getExistBuffMO(iter_10_1, arg_10_2)
			local var_10_2 = FightBuffMO.New()
			local var_10_3 = {
				buffId = arg_10_2,
				duration = var_10_1 and var_10_1.duration + var_10_0.duringTime or var_10_0.duringTime,
				count = var_10_1 and var_10_1.count + var_10_0.effectCount or var_10_0.effectCount,
				uid = var_10_1 and var_10_1.uid or SkillEditorBuffSelectView.genBuffUid()
			}

			var_10_2:init(var_10_3, iter_10_1)

			var_10_2.entityId = iter_10_1

			local var_10_4 = FightActEffectData.New()

			var_10_4.targetId = iter_10_1
			var_10_4.effectType = var_10_1 and FightEnum.EffectType.BUFFUPDATE or FightEnum.EffectType.BUFFADD
			var_10_4.effectNum = 1
			var_10_4.fromSide = arg_10_7
			var_10_4.buff = var_10_2

			table.insert(var_0_4, var_10_2)
			table.insert(arg_10_1, var_10_4)
			var_0_0._buildBuffShield(var_10_2, arg_10_1, arg_10_5, arg_10_6, arg_10_7)
		end
	end
end

function var_0_0._getExistBuffMO(arg_11_0, arg_11_1)
	local var_11_0 = FightHelper.getEntity(arg_11_0)

	if not var_11_0 then
		return
	end

	local var_11_1 = lua_skill_buff.configDict[arg_11_1]
	local var_11_2 = var_11_1 and lua_skill_bufftype.configDict[var_11_1.typeId]
	local var_11_3 = var_11_2 and var_11_2.includeTypes
	local var_11_4 = var_11_3 and string.splitToNumber(var_11_3, "#")[1]

	if not var_11_4 then
		return
	end

	local var_11_5 = var_11_0:getMO():getBuffList()

	if var_11_4 == 2 or var_11_4 == 10 or var_11_4 == 11 or var_11_4 == 12 then
		for iter_11_0 = #var_0_4, 1, -1 do
			local var_11_6 = var_0_4[iter_11_0]

			if var_11_6.entityId == arg_11_0 and var_11_6.buffId == arg_11_1 then
				return var_11_6
			end
		end

		for iter_11_1, iter_11_2 in ipairs(var_11_5) do
			if iter_11_2.buffId == arg_11_1 then
				return iter_11_2
			end
		end
	end
end

function var_0_0._buildBuffShield(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = lua_skill_buff.configDict[arg_12_0.buffId]

	if var_12_0 and not string.nilorempty(var_12_0.features) then
		local var_12_1 = GameUtil.splitString2(var_12_0.features, true)

		for iter_12_0, iter_12_1 in ipairs(var_12_1) do
			local var_12_2 = iter_12_1[1]
			local var_12_3 = var_12_2 and lua_buff_act.configDict[var_12_2]

			if (var_12_3 and var_12_3.type) == "Shield" then
				local var_12_4 = (tonumber(iter_12_1[4]) or 1000) * 0.001
				local var_12_5 = FightActEffectData.New()

				var_12_5.targetId = arg_12_0.entityId
				var_12_5.effectType = FightEnum.EffectType.SHIELD

				local var_12_6 = FightHelper.getEntity(arg_12_3)

				var_12_5.effectNum = var_12_6 and math.ceil(var_12_4 * var_12_6:getMO().attrMO.hp) or 100
				var_12_5.fromSide = arg_12_4

				table.insert(arg_12_1, var_12_5)
			end
		end
	end
end

function var_0_0._checkRemoveBuffs(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6)
	var_0_0._checkRemoveBuff(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6)
	var_0_0._checkRemove3070Buff1(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	var_0_0._checkRemove3070Buff2(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
end

function var_0_0._checkRemoveBuff(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6)
	for iter_14_0 = 1, FightEnum.MaxBehavior do
		local var_14_0 = arg_14_0["behavior" .. iter_14_0]
		local var_14_1 = arg_14_0["condition" .. iter_14_0]
		local var_14_2 = arg_14_0["conditionTarget" .. iter_14_0]
		local var_14_3 = var_0_0._checkBehaviorCondition(var_14_1, var_14_2, arg_14_2, arg_14_3)

		if not string.nilorempty(var_14_0) and var_14_3 then
			local var_14_4 = string.splitToNumber(var_14_0, "#")[1]
			local var_14_5 = arg_14_0["behaviorTarget" .. iter_14_0]
			local var_14_6 = arg_14_0["conditionTarget" .. iter_14_0]
			local var_14_7 = var_0_0._getBehaviorTargetIds(arg_14_1, arg_14_0, iter_14_0, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6)
			local var_14_8 = var_14_4 and lua_skill_behavior.configDict[var_14_4]

			if var_14_8 and string.find(var_14_8.type, "Disperse") == 1 then
				for iter_14_1, iter_14_2 in ipairs(var_14_7) do
					local var_14_9 = FightDataHelper.entityMgr:getById(iter_14_2)

					for iter_14_3, iter_14_4 in pairs(var_14_9:getBuffDic()) do
						if lua_skill_buff.configDict[iter_14_4.buffId].isGoodBuff == 1 then
							local var_14_10 = FightActEffectData.New()

							var_14_10.targetId = var_14_9.id
							var_14_10.effectType = FightEnum.EffectType.BUFFDEL
							var_14_10.buff = iter_14_4

							table.insert(arg_14_1, 1, var_14_10)
						end
					end
				end
			end

			if var_14_8 and string.find(var_14_8.type, "Purify") == 1 then
				for iter_14_5, iter_14_6 in ipairs(var_14_7) do
					local var_14_11 = FightDataHelper.entityMgr:getById(iter_14_6)

					for iter_14_7, iter_14_8 in pairs(var_14_11:getBuffDic()) do
						if lua_skill_buff.configDict[iter_14_8.buffId].isGoodBuff == 2 then
							local var_14_12 = FightActEffectData.New()

							var_14_12.targetId = var_14_11.id
							var_14_12.effectType = FightEnum.EffectType.BUFFDEL
							var_14_12.buff = iter_14_8

							table.insert(arg_14_1, 1, var_14_12)
						end
					end
				end
			end
		end
	end
end

function var_0_0._checkRemove3070Buff1(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	if FightDataHelper.entityMgr:getById(arg_15_2).modelId ~= 3070 or FightCardDataHelper.isBigSkill(arg_15_0.id) then
		return
	end

	local var_15_0 = FightDataHelper.entityMgr:getById(arg_15_2)
	local var_15_1 = 0
	local var_15_2 = 0
	local var_15_3 = {}
	local var_15_4 = {}

	for iter_15_0, iter_15_1 in pairs(var_15_0:getBuffDic()) do
		local var_15_5 = lua_skill_buff.configDict[iter_15_1.buffId]

		if FightEntitySpecialEffect3070_Ball.buffTypeId2EffectPath[var_15_5.typeId] then
			var_15_1 = var_15_1 + 1

			table.insert(var_15_3, iter_15_1)
			table.insert(var_15_4, iter_15_1)
		end
	end

	for iter_15_2, iter_15_3 in ipairs(arg_15_1) do
		if iter_15_3.effectType == FightEnum.EffectType.BUFFADD then
			local var_15_6 = lua_skill_buff.configDict[iter_15_3.buff.buffId]

			if FightEntitySpecialEffect3070_Ball.buffTypeId2EffectPath[var_15_6.typeId] then
				var_15_2 = var_15_2 + 1

				table.insert(var_15_3, iter_15_3.buff)
			end
		end
	end

	if #var_15_4 > 0 then
		local var_15_7 = 4

		for iter_15_4, iter_15_5 in ipairs(var_15_3) do
			local var_15_8 = lua_skill_buff.configDict[iter_15_5.buffId]
			local var_15_9 = lua_skill_bufftype.configDict[var_15_8.typeId]
			local var_15_10 = string.splitToNumber(var_15_9.includeTypes, "#")[2]

			var_15_7 = var_15_10 < var_15_7 and var_15_10 or var_15_7
		end

		local var_15_11 = var_15_1 + var_15_2 - var_15_7

		var_15_11 = var_15_1 < var_15_11 and var_15_1 or var_15_11

		for iter_15_6 = 1, var_15_11 do
			local var_15_12 = FightActEffectData.New()

			var_15_12.targetId = arg_15_2
			var_15_12.effectType = FightEnum.EffectType.BUFFDEL
			var_15_12.buff = var_15_4[iter_15_6]

			table.insert(arg_15_1, 1, var_15_12)
		end
	end
end

function var_0_0._checkRemove3070Buff2(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	local var_16_0 = FightDataHelper.entityMgr:getById(arg_16_2)

	if var_16_0.modelId ~= 3070 or not FightCardDataHelper.isBigSkill(arg_16_0.id) then
		return
	end

	local var_16_1 = 0
	local var_16_2 = 0
	local var_16_3

	for iter_16_0, iter_16_1 in pairs(var_16_0:getBuffDic()) do
		local var_16_4 = lua_skill_buff.configDict[iter_16_1.buffId]

		if FightEntitySpecialEffect3070_Ball.buffTypeId2EffectPath[var_16_4.typeId] then
			local var_16_5 = FightActEffectData.New()

			var_16_5.targetId = arg_16_2
			var_16_5.effectType = FightEnum.EffectType.BUFFDEL
			var_16_5.buff = iter_16_1

			table.insert(arg_16_1, 1, var_16_5)
		end
	end
end

function var_0_0._checkBuildAddPowerStep(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	local var_17_0 = FightHelper.getEntity(arg_17_2)

	if not var_17_0:getMO():isCharacter() then
		return
	end

	local var_17_1 = SkillConfig.instance:getpassiveskillsCO(var_17_0:getMO().modelId)

	if not var_17_1 then
		return
	end

	for iter_17_0, iter_17_1 in ipairs(var_17_1) do
		local var_17_2 = iter_17_1 and lua_skill.configDict[iter_17_1.skillPassive]

		if var_17_2 then
			for iter_17_2 = 1, FightEnum.MaxBehavior do
				local var_17_3 = var_17_2["condition" .. iter_17_2]
				local var_17_4 = var_17_2["behavior" .. iter_17_2]
				local var_17_5 = var_17_2["conditionTarget" .. iter_17_2]
				local var_17_6 = var_17_2["behaviorTarget" .. iter_17_2]

				if not string.nilorempty(var_17_3) and not string.nilorempty(var_17_4) and var_17_5 == 103 and var_17_6 == 103 then
					local var_17_7 = string.splitToNumber(var_17_3, "#")
					local var_17_8 = string.splitToNumber(var_17_4, "#")
					local var_17_9 = var_17_7[1]
					local var_17_10 = var_17_8[1]
					local var_17_11 = var_17_9 and lua_skill_behavior_condition.configDict[var_17_9]
					local var_17_12 = var_17_10 and lua_skill_behavior.configDict[var_17_10]

					if var_17_12 and var_17_12.type == "ChangePower" then
						if var_17_11 and var_17_11.type == "ActiveUseSkill" then
							local var_17_13 = var_17_7[2] or 1

							if FightConfig.instance:getSkillLv(arg_17_0.id) == var_17_13 then
								local var_17_14 = var_17_8[2] or 1

								return var_0_0._buildOneAddPowerStep(var_17_2.id, arg_17_2, arg_17_3, var_17_14)
							end
						else
							return var_0_0._buildOneAddPowerStep(var_17_2.id, arg_17_2, arg_17_3, 1)
						end
					end
				end
			end
		end
	end
end

function var_0_0._buildOneAddPowerStep(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = FightStepData.New()

	var_18_0.editorPlaySkill = true
	var_18_0.actType = 1
	var_18_0.fromId = arg_18_1
	var_18_0.toId = arg_18_2
	var_18_0.actId = arg_18_0
	var_18_0.actEffect = {
		FightActEffectData.New()
	}
	var_18_0.actEffect[1].targetId = arg_18_1
	var_18_0.actEffect[1].effectType = FightEnum.EffectType.POWERCHANGE
	var_18_0.actEffect[1].effectNum = arg_18_3
	var_18_0.actEffect[1].configEffect = 1
	var_18_0.actEffect[1].buffActId = 0

	return var_18_0
end

function var_0_0._buildMagicCircle(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5, arg_19_6)
	for iter_19_0 = 1, FightEnum.MaxBehavior do
		local var_19_0 = arg_19_0["behavior" .. iter_19_0]
		local var_19_1 = arg_19_0["condition" .. iter_19_0]
		local var_19_2 = true

		if not string.nilorempty(var_19_1) then
			local var_19_3 = string.splitToNumber(var_19_1, "#")[1]
			local var_19_4 = var_19_3 and lua_skill_behavior_condition.configDict[var_19_3]

			var_19_2 = var_19_4 and var_19_4.type == "None"
		end

		if not string.nilorempty(var_19_0) and var_19_2 then
			local var_19_5 = string.splitToNumber(var_19_0, "#")
			local var_19_6 = tonumber(var_19_5[1])
			local var_19_7 = var_19_6 and lua_skill_behavior.configDict[var_19_6]

			if var_19_7 then
				if var_19_7.type == "AddMagicCircle" then
					local var_19_8 = FightModel.instance:getMagicCircleInfo()

					if var_19_8.magicCircleId then
						local var_19_9 = FightActEffectData.New()

						var_19_9.targetId = 0
						var_19_9.effectType = FightEnum.EffectType.MAGICCIRCLEDELETE
						var_19_9.reserveId = var_19_8.magicCircleId

						table.insert(arg_19_1, var_19_9)
					end

					local var_19_10 = lua_magic_circle.configDict[tonumber(var_19_5[2])]

					if var_19_10 then
						local var_19_11 = FightActEffectData.New()

						var_19_11.targetId = 0
						var_19_11.effectType = FightEnum.EffectType.MAGICCIRCLEADD
						var_19_11.magicCircle = {
							magicCircleId = var_19_10.id,
							round = var_19_10.round,
							createUid = arg_19_2
						}

						table.insert(arg_19_1, var_19_11)
					end
				elseif var_19_7.type == "ChangeSummonedLevel" then
					local var_19_12 = FightModel.instance:getMagicCircleInfo()

					if var_19_12.magicCircleId then
						local var_19_13 = FightActEffectData.New()

						var_19_13.targetId = 0
						var_19_13.effectType = FightEnum.EffectType.MAGICCIRCLEDELETE
						var_19_13.reserveId = var_19_12.magicCircleId

						table.insert(arg_19_1, var_19_13)
					end
				end
			end
		end
	end
end

function var_0_0._buildSummoned(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5, arg_20_6)
	local var_20_0 = {}
	local var_20_1 = {}

	for iter_20_0 = 1, FightEnum.MaxBehavior do
		local var_20_2 = arg_20_0["behavior" .. iter_20_0]
		local var_20_3 = arg_20_0["condition" .. iter_20_0]
		local var_20_4 = true

		if not string.nilorempty(var_20_3) then
			local var_20_5 = string.splitToNumber(var_20_3, "#")[1]
			local var_20_6 = var_20_5 and lua_skill_behavior_condition.configDict[var_20_5]

			var_20_4 = var_20_6 and var_20_6.type == "None"
		end

		if not string.nilorempty(var_20_2) and var_20_4 then
			local var_20_7 = string.splitToNumber(var_20_2, "#")
			local var_20_8 = arg_20_0["behaviorTarget" .. iter_20_0]
			local var_20_9 = arg_20_0["conditionTarget" .. iter_20_0]
			local var_20_10 = var_20_8

			if var_20_8 == 0 then
				local var_20_11 = arg_20_0.logicTarget
			elseif var_20_8 == 999 then
				local var_20_12

				var_20_12 = var_20_9 ~= 0 and var_20_9 or arg_20_0.logicTarget
			end

			local var_20_13 = tonumber(var_20_7[1])
			local var_20_14 = var_20_13 and lua_skill_behavior.configDict[var_20_13]

			if var_20_14 then
				local var_20_15 = arg_20_0["behaviorTarget" .. iter_20_0]
				local var_20_16 = arg_20_0["conditionTarget" .. iter_20_0]
				local var_20_17 = var_20_15

				if var_20_15 == 0 then
					var_20_17 = arg_20_0.logicTarget
				elseif var_20_15 == 999 then
					var_20_17 = var_20_16 ~= 0 and var_20_16 or arg_20_0.logicTarget
				end

				if var_20_14.type == "AddSummoned" then
					local var_20_18 = var_0_0._getTargetIds(var_20_17, arg_20_2, arg_20_3, arg_20_4, arg_20_5, arg_20_6)

					for iter_20_1, iter_20_2 in ipairs(var_20_18) do
						local var_20_19 = tonumber(var_20_7[2])
						local var_20_20 = tonumber(var_20_7[4]) or 1

						for iter_20_3 = 1, var_20_20 do
							local var_20_21 = FightConfig.instance:getSummonedConfig(var_20_19, 1).stanceId
							local var_20_22 = lua_fight_summoned_stance.configDict[var_20_21]
							local var_20_23 = 0

							for iter_20_4 = 1, 20 do
								local var_20_24 = var_20_22["pos" .. iter_20_4]

								var_20_23 = var_20_24 and #var_20_24 > 0 and var_20_23 + 1 or var_20_23
							end

							local var_20_25 = FightHelper.getEntity(iter_20_2)
							local var_20_26 = var_20_25 and var_20_25:getMO()
							local var_20_27 = var_20_26 and var_20_26.summonedInfo.dataDic or var_20_26:getSummonedInfo():getDataDic()

							if var_20_23 > tabletool.len(var_20_27) + tabletool.len(var_20_0) then
								local var_20_28 = {
									summonedId = var_20_19,
									level = tonumber(var_20_7[3]),
									uid = SkillEditorBuffSelectView.genBuffUid(),
									fromUid = arg_20_2
								}
								local var_20_29 = FightActEffectData.New()

								var_20_29.targetId = iter_20_2
								var_20_29.effectType = FightEnum.EffectType.SUMMONEDADD
								var_20_29.effectNum = 0
								var_20_29.configEffect = 0
								var_20_29.buffActId = 0
								var_20_29.reserveId = var_20_28.uid
								var_20_29.reserveStr = ""
								var_20_29.summoned = var_20_28

								table.insert(arg_20_1, var_20_29)

								var_20_1[var_20_28.uid] = var_20_28.level
								var_20_0[var_20_28.uid] = var_20_28

								var_0_0._buildSummonedDelete(var_20_28, arg_20_1, arg_20_2, iter_20_2, arg_20_4)
							end
						end
					end
				elseif var_20_14.type == "ChangeSummonedLevel" then
					local var_20_30 = var_0_0._getTargetIds(var_20_17, arg_20_2, arg_20_3, arg_20_4, arg_20_5, arg_20_6)

					for iter_20_5, iter_20_6 in ipairs(var_20_30) do
						local var_20_31 = tonumber(var_20_7[2])
						local var_20_32 = FightHelper.getEntity(iter_20_6)
						local var_20_33 = var_20_32 and var_20_32:getMO()
						local var_20_34 = var_20_33 and var_20_33.summonedInfo.dataDic or {}
						local var_20_35 = tabletool.copy(var_20_34)

						for iter_20_7, iter_20_8 in pairs(var_20_0) do
							var_20_35[iter_20_7] = iter_20_8
						end

						for iter_20_9, iter_20_10 in pairs(var_20_35) do
							if iter_20_10.summonedId == var_20_31 then
								local var_20_36 = {}
								local var_20_37 = var_20_1[iter_20_10.uid] or iter_20_10.level

								var_20_36.summonedId = var_20_31
								var_20_36.level = tonumber(var_20_7[3])
								var_20_36.uid = iter_20_10.uid
								var_20_36.fromUid = arg_20_2

								local var_20_38 = FightActEffectData.New()

								var_20_38.targetId = iter_20_6
								var_20_38.effectType = FightEnum.EffectType.SUMMONEDLEVELUP
								var_20_38.effectNum = var_20_36.level - var_20_37
								var_20_38.configEffect = 0
								var_20_38.buffActId = 0
								var_20_38.reserveId = var_20_36.uid
								var_20_38.reserveStr = ""
								var_20_38.summoned = var_20_36

								table.insert(arg_20_1, var_20_38)

								var_20_1[iter_20_10.uid] = var_20_36.level

								var_0_0._buildSummonedDelete(var_20_36, arg_20_1, arg_20_2, iter_20_6, arg_20_4)
							end
						end
					end
				end
			end
		end
	end
end

function var_0_0._buildSummonedDelete(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	local var_21_0 = FightConfig.instance:getSummonedConfig(arg_21_0.summonedId, arg_21_0.level)

	if var_21_0 and arg_21_0.level >= var_21_0.maxLevel then
		local var_21_1 = FightActEffectData.New()

		var_21_1.targetId = arg_21_3
		var_21_1.effectType = FightEnum.EffectType.SUMMONEDDELETE
		var_21_1.effectNum = 0
		var_21_1.configEffect = 0
		var_21_1.buffActId = 0
		var_21_1.reserveId = arg_21_0.uid
		var_21_1.reserveStr = ""

		table.insert(arg_21_1, var_21_1)
	end
end

function var_0_0._getTargetIds(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5)
	if FightEnum.LogicTargetClassify.Single[arg_22_0] then
		return {
			arg_22_2
		}
	elseif FightEnum.LogicTargetClassify.SingleAndRandom[arg_22_0] then
		return {
			arg_22_2,
			arg_22_5
		}
	elseif FightEnum.LogicTargetClassify.MySideAll[arg_22_0] then
		local var_22_0 = {}
		local var_22_1 = FightDataHelper.entityMgr:getNormalList(arg_22_3)

		for iter_22_0, iter_22_1 in ipairs(var_22_1) do
			table.insert(var_22_0, iter_22_1.id)

			return var_22_0
		end
	elseif FightEnum.LogicTargetClassify.Me[arg_22_0] then
		return {
			arg_22_1
		}
	end
end

local var_0_5 = 3065

function var_0_0._checkRegainPowerAfterAct(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5)
	local var_23_0
	local var_23_1 = FightHelper.getSideEntitys(arg_23_5, false)

	for iter_23_0, iter_23_1 in ipairs(var_23_1) do
		if iter_23_1:getMO() and iter_23_1:getMO().modelId == var_0_5 then
			var_23_0 = iter_23_1.id

			break
		end
	end

	if not var_23_0 then
		return
	end

	local var_23_2 = FightHelper.getEntity(arg_23_2):getMO():getBuffList()

	for iter_23_2, iter_23_3 in ipairs(var_23_2) do
		local var_23_3 = lua_skill_buff.configDict[iter_23_3.buffId]
		local var_23_4 = var_23_3 and var_23_3.features

		if not string.nilorempty(var_23_4) then
			local var_23_5 = GameUtil.splitString2(var_23_4, true)

			for iter_23_4, iter_23_5 in ipairs(var_23_5) do
				local var_23_6 = iter_23_5[1] and lua_buff_act.configDict[iter_23_5[1]]

				if var_23_6 and var_23_6.type == "RegainPowerAfterAct" then
					local var_23_7 = FightActEffectData.New()

					var_23_7.targetId = var_23_0
					var_23_7.effectType = FightEnum.EffectType.POWERCHANGE
					var_23_7.effectNum = iter_23_5[2] or 1
					var_23_7.configEffect = 1
					var_23_7.buffActId = 0

					table.insert(arg_23_1, var_23_7)
				end
			end
		end
	end
end

function var_0_0._checkBehaviorCondition(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if string.nilorempty(arg_24_0) then
		return true
	end

	local var_24_0 = string.splitToNumber(arg_24_0, "#")
	local var_24_1 = var_24_0[1]
	local var_24_2 = var_24_0[2]
	local var_24_3 = var_24_1 and lua_skill_behavior_condition.configDict[var_24_1]

	if not var_24_3 or var_24_3.type == "None" then
		return true
	end

	local var_24_4 = FightEnum.LogicTargetClassify.Me[arg_24_1] and arg_24_2 or arg_24_3
	local var_24_5 = FightHelper.getEntity(var_24_4)

	if var_24_3.type == "NoBuffId" and var_24_5 then
		for iter_24_0, iter_24_1 in pairs(var_24_5:getMO():getBuffDic()) do
			if iter_24_1.buffId == var_24_2 then
				return false
			end
		end

		return true
	end

	if var_24_3.type == "HasBuffId" and var_24_5 then
		for iter_24_2, iter_24_3 in pairs(var_24_5:getMO():getBuffDic()) do
			if iter_24_3.buffId == var_24_2 then
				return true
			end
		end

		return false
	end

	return true
end

function var_0_0._getBehaviorTargetIds(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5, arg_25_6, arg_25_7)
	local var_25_0 = arg_25_1.logicTarget
	local var_25_1 = arg_25_1["behaviorTarget" .. arg_25_2]
	local var_25_2 = arg_25_1["conditionTarget" .. arg_25_2]
	local var_25_3 = var_25_1

	if var_25_1 == 0 then
		var_25_3 = var_25_0
	elseif var_25_1 == 999 then
		var_25_3 = var_25_2 ~= 0 and var_25_2 or var_25_0
	end

	local function var_25_4(arg_26_0, arg_26_1)
		if not tabletool.indexOf(arg_26_0, arg_26_1) then
			table.insert(arg_26_0, arg_26_1)
		end
	end

	local var_25_5 = {}

	if var_25_3 == FightEnum.CondTargetHpMin then
		local var_25_6 = arg_25_3
		local var_25_7 = 1
		local var_25_8 = FightDataHelper.entityMgr:getNormalList(arg_25_5)

		for iter_25_0, iter_25_1 in ipairs(var_25_8) do
			local var_25_9 = iter_25_1.currentHp / iter_25_1.attrMO.hp

			if var_25_9 < var_25_7 then
				var_25_6 = iter_25_1.id
				var_25_7 = var_25_9
			end
		end

		var_25_4(var_25_5, var_25_6)
	elseif FightEnum.LogicTargetClassify.Special[var_25_3] then
		var_25_4(var_25_5, arg_25_4)
	elseif FightEnum.LogicTargetClassify.Single[var_25_3] then
		var_25_4(var_25_5, arg_25_4)
	elseif FightEnum.LogicTargetClassify.SingleAndRandom[var_25_3] then
		var_25_4(var_25_5, arg_25_4)

		if arg_25_7 then
			var_25_4(var_25_5, arg_25_7)
		else
			local var_25_10 = arg_25_1.targetLimit == FightEnum.TargetLimit.EnemySide
			local var_25_11 = FightHelper.getSideEntitys(var_25_10 and arg_25_6 or arg_25_5)

			for iter_25_2, iter_25_3 in ipairs(var_25_11) do
				if iter_25_3.id == arg_25_4 then
					table.remove(var_25_11, iter_25_2)

					break
				end
			end

			if #var_25_11 > 0 then
				local var_25_12 = var_25_11[math.random(#var_25_11)]

				arg_25_7 = var_25_12.id

				var_25_4(var_25_5, var_25_12.id)
			end
		end
	elseif FightEnum.LogicTargetClassify.EnemySideAll[var_25_3] then
		local var_25_13 = FightDataHelper.entityMgr:getNormalList(arg_25_6)

		for iter_25_4, iter_25_5 in ipairs(var_25_13) do
			var_25_4(var_25_5, iter_25_5.id)
		end
	elseif FightEnum.LogicTargetClassify.EnemySideindex[var_25_3] then
		local var_25_14 = var_25_3 - 225
		local var_25_15 = FightDataHelper.entityMgr:getNormalList(arg_25_6)

		table.sort(var_25_15, function(arg_27_0, arg_27_1)
			return arg_27_0.position < arg_27_1.position
		end)

		for iter_25_6, iter_25_7 in ipairs(var_25_15) do
			if iter_25_6 == var_25_14 then
				var_25_4(var_25_5, iter_25_7.id)
			end
		end
	elseif FightEnum.LogicTargetClassify.MySideAll[var_25_3] then
		local var_25_16 = FightDataHelper.entityMgr:getNormalList(arg_25_5)

		for iter_25_8, iter_25_9 in ipairs(var_25_16) do
			var_25_4(var_25_5, iter_25_9.id)
		end
	elseif FightEnum.LogicTargetClassify.Me[var_25_3] then
		var_25_4(var_25_5, arg_25_3)
	elseif FightEnum.LogicTargetClassify.SecondaryTarget[var_25_3] then
		if arg_25_1.logicTarget == 202 then
			local var_25_17 = FightDataHelper.entityMgr:getNormalList(arg_25_6)

			for iter_25_10, iter_25_11 in ipairs(var_25_17) do
				if iter_25_11.id ~= arg_25_4 then
					var_25_4(var_25_5, iter_25_11.id)
				end
			end
		end
	elseif FightEnum.LogicTargetClassify.StanceAndBefore[var_25_3] then
		local var_25_18 = FightDataHelper.entityMgr:getById(arg_25_3)
		local var_25_19 = FightDataHelper.entityMgr:getNormalList(arg_25_5)

		for iter_25_12, iter_25_13 in ipairs(var_25_19) do
			if iter_25_13.position <= var_25_18.position then
				var_25_4(var_25_5, iter_25_13.id)
			end
		end
	elseif FightEnum.LogicTargetClassify.StanceAndAfter[var_25_3] then
		local var_25_20 = FightDataHelper.entityMgr:getById(arg_25_3)
		local var_25_21 = FightDataHelper.entityMgr:getNormalList(arg_25_5)

		for iter_25_14, iter_25_15 in ipairs(var_25_21) do
			if iter_25_15.position >= var_25_20.position then
				var_25_4(var_25_5, iter_25_15.id)
			end
		end
	elseif FightEnum.LogicTargetClassify.Position[var_25_3] then
		local var_25_22 = FightHelper.getEnemySideEntitys(arg_25_3)

		for iter_25_16, iter_25_17 in ipairs(var_25_22) do
			local var_25_23 = iter_25_17:getMO()

			if var_25_23 and var_25_23.position == FightEnum.LogicTargetClassify.Position[var_25_3] then
				var_25_4(var_25_5, iter_25_17.id)
			end
		end
	end

	return var_25_5, arg_25_7
end

return var_0_0
