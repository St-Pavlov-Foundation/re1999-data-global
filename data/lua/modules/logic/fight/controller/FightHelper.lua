module("modules.logic.fight.controller.FightHelper", package.seeall)

local var_0_0 = _M
local var_0_1 = 1000001
local var_0_2 = -1000001
local var_0_3 = Vector2.zero

function var_0_0.getEntityStanceId(arg_1_0, arg_1_1)
	local var_1_0 = FightEnum.MySideDefaultStanceId

	if arg_1_0 and arg_1_0.side == FightEnum.EntitySide.MySide then
		local var_1_1 = FightModel.instance:getFightParam()
		local var_1_2 = var_1_1 and var_1_1.battleId
		local var_1_3 = var_1_2 and lua_battle.configDict[var_1_2]

		if var_1_3 and not string.nilorempty(var_1_3.myStance) then
			var_1_0 = tonumber(var_1_3.myStance)

			if not var_1_0 then
				local var_1_4 = FightStrUtil.instance:getSplitToNumberCache(var_1_3.myStance, "#")

				if #var_1_4 > 0 then
					arg_1_1 = arg_1_1 or FightModel.instance:getCurWaveId()
					var_1_0 = var_1_4[arg_1_1 <= #var_1_4 and arg_1_1 or #var_1_4]
				else
					logError("站位配置有误，战斗id = " .. var_1_1.battleId)
				end
			end
		end

		if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
			var_1_0 = SkillEditorMgr.instance.stance_id
		end
	else
		local var_1_5 = FightModel.instance:getCurMonsterGroupId()
		local var_1_6 = lua_monster_group.configDict[var_1_5]

		var_1_0 = var_1_6 and var_1_6.stanceId or FightEnum.EnemySideDefaultStanceId

		if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
			var_1_0 = SkillEditorMgr.instance.enemy_stance_id
		end
	end

	return var_1_0
end

function var_0_0.getEntityStandPos(arg_2_0, arg_2_1)
	if arg_2_0:isAssistBoss() then
		return var_0_0.getAssistBossStandPos(arg_2_0, arg_2_1)
	end

	if FightEntityDataHelper.isPlayerUid(arg_2_0.uid) then
		return 0, 0, 0, 1
	end

	local var_2_0 = var_0_0.getEntityStanceId(arg_2_0, arg_2_1)
	local var_2_1 = lua_stance.configDict[var_2_0]

	if not var_2_1 then
		if arg_2_0.side == FightEnum.EntitySide.MySide then
			local var_2_2 = FightModel.instance:getFightParam()
			local var_2_3 = var_2_2 and var_2_2.battleId

			logError("我方用了不存在的站位，战斗id=" .. (var_2_3 or "nil") .. "， 站位id=" .. var_2_0)
		else
			local var_2_4 = FightModel.instance:getCurMonsterGroupId()

			logError("敌方用了不存在的站位，怪物组=" .. (var_2_4 or "nil") .. "， 站位id=" .. var_2_0)
		end
	end

	local var_2_5 = FightDataHelper.entityMgr:isSub(arg_2_0.uid)
	local var_2_6

	if var_2_5 then
		var_2_6 = var_2_1.subPos1
	else
		var_2_6 = var_2_1["pos" .. arg_2_0.position]
	end

	if not var_2_6 or not var_2_6[1] or not var_2_6[2] or not var_2_6[3] then
		if isDebugBuild then
			logError("stance pos nil: stance_" .. (var_2_0 or "nil") .. " posIndex_" .. (arg_2_0.position or "nil"))
		end

		return 0, 0, 0, 1
	end

	local var_2_7 = var_2_6[4] or 1

	return var_2_6[1], var_2_6[2], var_2_6[3], var_2_7
end

function var_0_0.getAssistBossStandPos(arg_3_0, arg_3_1)
	arg_3_1 = arg_3_1 or FightModel.instance:getCurWaveId()

	local var_3_0 = FightModel.instance:getFightParam()
	local var_3_1 = arg_3_0.skin
	local var_3_2 = var_3_0:getScene(arg_3_1)
	local var_3_3 = lua_assist_boss_stance.configDict[var_3_1]
	local var_3_4 = var_3_3 and var_3_3[var_3_2]

	var_3_4 = var_3_4 or var_3_3 and var_3_3[0]

	if not var_3_4 then
		logError(string.format("协助boss站位表未配置 皮肤id：%s, 场景id : %s", var_3_1, var_3_2))

		return 9.4, 0, -2.75, 0.9
	end

	local var_3_5 = var_3_4.position

	return var_3_5[1], var_3_5[2], var_3_5[3], var_3_4.scale
end

function var_0_0.getSpineLookDir(arg_4_0)
	return arg_4_0 == FightEnum.EntitySide.MySide and SpineLookDir.Left or SpineLookDir.Right
end

function var_0_0.getEntitySpineLookDir(arg_5_0)
	if arg_5_0 then
		local var_5_0 = arg_5_0.side
		local var_5_1 = FightConfig.instance:getSkinCO(arg_5_0.skin)

		if var_5_1 and var_5_1.flipX and var_5_1.flipX == 1 then
			return var_5_0 == FightEnum.EntitySide.MySide and SpineLookDir.Right or SpineLookDir.Left
		else
			return var_5_0 == FightEnum.EntitySide.MySide and SpineLookDir.Left or SpineLookDir.Right
		end
	end
end

function var_0_0.getEffectLookDir(arg_6_0)
	return arg_6_0 == FightEnum.EntitySide.MySide and FightEnum.EffectLookDir.Left or FightEnum.EffectLookDir.Right
end

function var_0_0.getEffectLookDirQuaternion(arg_7_0)
	if arg_7_0 == FightEnum.EntitySide.MySide then
		return FightEnum.RotationQuaternion.Zero
	else
		return FightEnum.RotationQuaternion.Ohae
	end
end

function var_0_0.getEntity(arg_8_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		return GameSceneMgr.instance:getCurScene().entityMgr:getEntity(arg_8_0)
	end
end

function var_0_0.getDefenders(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.actEffect) do
		local var_9_1 = false

		if arg_9_2 and arg_9_2[iter_9_1.effectType] then
			var_9_1 = true
		end

		if iter_9_1.effectType == FightEnum.EffectType.SHIELD and not var_0_0.checkShieldHit(iter_9_1) then
			var_9_1 = true
		end

		if not var_9_1 then
			local var_9_2 = var_0_0.getEntity(iter_9_1.targetId)

			if var_9_2 then
				table.insert(var_9_0, var_9_2)
			else
				logNormal("get defender fail, entity not exist: " .. iter_9_1.targetId)
			end
		end
	end

	if arg_9_1 then
		local var_9_3 = var_0_0.getEntity(arg_9_0.toId)

		if not tabletool.indexOf(var_9_0, var_9_3) then
			table.insert(var_9_0, var_9_3)
		end
	end

	return var_9_0
end

function var_0_0.getPreloadAssetItem(arg_10_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		return FightPreloadController.instance:getFightAssetItem(arg_10_0)
	end
end

function var_0_0.getEnemySideEntitys(arg_11_0, arg_11_1)
	local var_11_0 = var_0_0.getEntity(arg_11_0)

	if var_11_0 then
		local var_11_1 = var_11_0:getSide()

		if var_11_1 == FightEnum.EntitySide.EnemySide then
			return var_0_0.getSideEntitys(FightEnum.EntitySide.MySide, arg_11_1)
		elseif var_11_1 == FightEnum.EntitySide.MySide then
			return var_0_0.getSideEntitys(FightEnum.EntitySide.EnemySide, arg_11_1)
		end
	end

	return {}
end

function var_0_0.getSideEntitys(arg_12_0, arg_12_1)
	local var_12_0 = {}
	local var_12_1 = GameSceneMgr.instance:getCurScene().entityMgr
	local var_12_2 = arg_12_0 == FightEnum.EntitySide.MySide and SceneTag.UnitPlayer or SceneTag.UnitMonster
	local var_12_3 = var_12_1:getTagUnitDict(var_12_2)

	if var_12_3 then
		for iter_12_0, iter_12_1 in pairs(var_12_3) do
			if not FightDataHelper.entityMgr:isAssistBoss(iter_12_1.id) and (arg_12_1 or not FightDataHelper.entityMgr:isSub(iter_12_1.id)) then
				table.insert(var_12_0, iter_12_1)
			end
		end
	end

	return var_12_0
end

function var_0_0.getSubEntity(arg_13_0)
	local var_13_0 = GameSceneMgr.instance:getCurScene().entityMgr
	local var_13_1 = arg_13_0 == FightEnum.EntitySide.MySide and SceneTag.UnitPlayer or SceneTag.UnitMonster
	local var_13_2 = var_13_0:getTagUnitDict(var_13_1)

	if var_13_2 then
		for iter_13_0, iter_13_1 in pairs(var_13_2) do
			if not iter_13_1.isDead and FightDataHelper.entityMgr:isSub(iter_13_1.id) then
				return iter_13_1
			end
		end
	end
end

function var_0_0.getAllEntitys()
	local var_14_0 = {}

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		local var_14_1 = GameSceneMgr.instance:getCurScene().entityMgr
		local var_14_2 = var_14_1:getTagUnitDict(SceneTag.UnitPlayer)
		local var_14_3 = var_14_1:getTagUnitDict(SceneTag.UnitMonster)

		if var_14_2 then
			for iter_14_0, iter_14_1 in pairs(var_14_2) do
				table.insert(var_14_0, iter_14_1)
			end
		end

		if var_14_3 then
			for iter_14_2, iter_14_3 in pairs(var_14_3) do
				table.insert(var_14_0, iter_14_3)
			end
		end
	end

	return var_14_0
end

function var_0_0.isAllEntityDead(arg_15_0)
	local var_15_0 = true
	local var_15_1

	if arg_15_0 then
		var_15_1 = var_0_0.getSideEntitys(arg_15_0, true)
	else
		var_15_1 = var_0_0.getAllEntitys()
	end

	for iter_15_0, iter_15_1 in ipairs(var_15_1) do
		if not iter_15_1.isDead then
			var_15_0 = false
		end
	end

	return var_15_0
end

function var_0_0.getAllEntitysContainUnitNpc()
	local var_16_0 = {}

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		local var_16_1 = GameSceneMgr.instance:getCurScene().entityMgr
		local var_16_2 = var_16_1:getTagUnitDict(SceneTag.UnitPlayer)
		local var_16_3 = var_16_1:getTagUnitDict(SceneTag.UnitMonster)
		local var_16_4 = var_16_1:getTagUnitDict(SceneTag.UnitNpc)

		LuaUtil.mergeTable(var_16_0, var_16_2, var_16_3, var_16_4)
	end

	return var_16_0
end

function var_0_0.validEntityEffectType(arg_17_0)
	if arg_17_0 == FightEnum.EffectType.EXPOINTCHANGE then
		return false
	end

	if arg_17_0 == FightEnum.EffectType.INDICATORCHANGE then
		return false
	end

	if arg_17_0 == FightEnum.EffectType.POWERCHANGE then
		return false
	end

	return true
end

function var_0_0.getRelativeEntityIdDict(arg_18_0, arg_18_1)
	local var_18_0 = {}

	if arg_18_0.fromId then
		var_18_0[arg_18_0.fromId] = true
	end

	if arg_18_0.toId then
		var_18_0[arg_18_0.toId] = true
	end

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.actEffect) do
		local var_18_1 = false

		if arg_18_1 and arg_18_1[iter_18_1.effectType] then
			var_18_1 = true
		end

		if iter_18_1.effectType == FightEnum.EffectType.SHIELD and not var_0_0.checkShieldHit(iter_18_1) then
			var_18_1 = true
		end

		if not var_18_1 and iter_18_1.effectType ~= FightEnum.EffectType.EXPOINTCHANGE and iter_18_1.targetId then
			var_18_0[iter_18_1.targetId] = true
		end
	end

	return var_18_0
end

function var_0_0.getSkillTargetEntitys(arg_19_0, arg_19_1)
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.actEffect) do
		local var_19_1 = false

		if arg_19_1 and arg_19_1[iter_19_1.effectType] then
			var_19_1 = true
		end

		if iter_19_1.effectType == FightEnum.EffectType.SHIELD and not var_0_0.checkShieldHit(iter_19_1) then
			var_19_1 = true
		end

		if not var_19_1 and iter_19_1.effectType ~= FightEnum.EffectType.EXPOINTCHANGE then
			local var_19_2 = var_0_0.getEntity(iter_19_1.targetId)

			if var_19_2 and not tabletool.indexOf(var_19_0, var_19_2) then
				table.insert(var_19_0, var_19_2)
			end
		end
	end

	return var_19_0
end

function var_0_0.getTargetLimits(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0 == FightEnum.EntitySide.MySide and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide
	local var_20_1 = var_0_0.getSideEntitys(arg_20_0, false)
	local var_20_2 = var_0_0.getSideEntitys(var_20_0, false)
	local var_20_3 = lua_skill.configDict[arg_20_1]
	local var_20_4 = {}

	if not var_20_3 then
		for iter_20_0, iter_20_1 in ipairs(var_20_2) do
			table.insert(var_20_4, iter_20_1.id)
		end

		logError("no target limits, skillId_" .. arg_20_1)
	elseif var_20_3.targetLimit == FightEnum.TargetLimit.None then
		-- block empty
	elseif var_20_3.targetLimit == FightEnum.TargetLimit.EnemySide then
		for iter_20_2, iter_20_3 in ipairs(var_20_2) do
			table.insert(var_20_4, iter_20_3.id)
		end
	elseif var_20_3.targetLimit == FightEnum.TargetLimit.MySide then
		for iter_20_4, iter_20_5 in ipairs(var_20_1) do
			table.insert(var_20_4, iter_20_5.id)
		end
	else
		for iter_20_6, iter_20_7 in ipairs(var_20_2) do
			table.insert(var_20_4, iter_20_7.id)
		end

		logError("target limit type not implement:" .. var_20_3.targetLimit .. " skillId = " .. arg_20_1)
	end

	if var_20_3.logicTarget == 3 then
		local var_20_5 = arg_20_2

		if var_20_5 then
			for iter_20_8 = #var_20_4, 1, -1 do
				if var_20_4[iter_20_8] == var_20_5 then
					table.remove(var_20_4, iter_20_8)
				end
			end
		end
	elseif var_20_3.logicTarget == 1 then
		for iter_20_9 = 1, FightEnum.MaxBehavior do
			local var_20_6 = var_20_3["behavior" .. iter_20_9]

			if FightStrUtil.instance:getSplitCache(var_20_6, "#")[1] == "60032" then
				for iter_20_10 = #var_20_4, 1, -1 do
					local var_20_7 = FightDataHelper.entityMgr:getById(var_20_4[iter_20_10])

					if var_20_7 and (#var_20_7.skillGroup1 == 0 or #var_20_7.skillGroup2 == 0) then
						table.remove(var_20_4, iter_20_10)
					end
				end
			end
		end
	end

	return var_20_4
end

function var_0_0.getEntityWorldTopPos(arg_21_0)
	local var_21_0, var_21_1 = var_0_0.getEntityBoxSizeOffsetV2(arg_21_0)
	local var_21_2, var_21_3, var_21_4 = var_0_0.getProcessEntitySpinePos(arg_21_0)

	return var_21_2 + var_21_1.x, var_21_3 + var_21_1.y + var_21_0.y / 2, var_21_4
end

function var_0_0.getEntityWorldCenterPos(arg_22_0)
	local var_22_0, var_22_1 = var_0_0.getEntityBoxSizeOffsetV2(arg_22_0)
	local var_22_2, var_22_3, var_22_4 = var_0_0.getProcessEntitySpinePos(arg_22_0)

	return var_22_2 + var_22_1.x, var_22_3 + var_22_1.y, var_22_4
end

function var_0_0.getEntityHangPointPos(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:getHangPoint(arg_23_1).transform.position

	return var_23_0.x, var_23_0.y, var_23_0.z
end

function var_0_0.getEntityWorldBottomPos(arg_24_0)
	local var_24_0, var_24_1 = var_0_0.getEntityBoxSizeOffsetV2(arg_24_0)
	local var_24_2, var_24_3, var_24_4 = var_0_0.getProcessEntitySpinePos(arg_24_0)

	return var_24_2 + var_24_1.x, var_24_3 + var_24_1.y - var_24_0.y / 2, var_24_4
end

function var_0_0.getEntityLocalTopPos(arg_25_0)
	local var_25_0, var_25_1 = var_0_0.getEntityBoxSizeOffsetV2(arg_25_0)

	return var_25_1.x, var_25_1.y + var_25_0.y / 2, 0
end

function var_0_0.getEntityLocalCenterPos(arg_26_0)
	local var_26_0, var_26_1 = var_0_0.getEntityBoxSizeOffsetV2(arg_26_0)

	return var_26_1.x, var_26_1.y, 0
end

function var_0_0.getEntityLocalBottomPos(arg_27_0)
	local var_27_0, var_27_1 = var_0_0.getEntityBoxSizeOffsetV2(arg_27_0)

	return var_27_1.x, var_27_1.y - var_27_0.y / 2, 0
end

function var_0_0.getEntityBoxSizeOffsetV2(arg_28_0)
	if var_0_0.isAssembledMonster(arg_28_0) then
		local var_28_0 = arg_28_0:getMO()
		local var_28_1 = lua_fight_assembled_monster.configDict[var_28_0.skin]

		return {
			x = var_28_1.virtualSpineSize[1],
			y = var_28_1.virtualSpineSize[2]
		}, var_0_3
	end

	local var_28_2 = arg_28_0.spine and arg_28_0.spine:getSpineGO()

	if var_28_2 then
		local var_28_3 = var_28_2:GetComponent("BoxCollider2D")

		if var_28_3 then
			local var_28_4, var_28_5, var_28_6 = transformhelper.getLocalScale(arg_28_0.go.transform)
			local var_28_7 = var_28_3.size
			local var_28_8 = var_28_3.offset

			var_28_8.x = var_28_8.x * var_28_4
			var_28_8.y = var_28_8.y * var_28_5

			if arg_28_0.spine:getLookDir() == SpineLookDir.Right then
				var_28_8.x = -var_28_8.x
			end

			var_28_7.x = var_28_7.x * var_28_4
			var_28_7.y = var_28_7.y * var_28_5

			return var_28_7, var_28_8
		end
	end

	return var_0_3, var_0_3
end

function var_0_0.getModelSize(arg_29_0)
	local var_29_0, var_29_1 = var_0_0.getEntityBoxSizeOffsetV2(arg_29_0)
	local var_29_2 = var_29_0.x + var_29_0.y

	if var_29_2 > 14 then
		return 4
	elseif var_29_2 > 7 then
		return 3
	elseif var_29_2 > 3 then
		return 2
	else
		return 1
	end
end

function var_0_0.getEffectUrlWithLod(arg_30_0)
	return ResUrl.getEffect(arg_30_0)
end

function var_0_0.tempNewStepProto(arg_31_0)
	local var_31_0 = {}

	setmetatable(var_31_0, {
		__index = arg_31_0
	})

	local var_31_1 = {}

	var_31_0.actEffect = var_31_1

	for iter_31_0, iter_31_1 in ipairs(arg_31_0.actEffect) do
		local var_31_2 = {}

		setmetatable(var_31_2, {
			__index = iter_31_1
		})
		table.insert(var_31_1, var_31_2)

		if iter_31_1.effectType == FightEnum.EffectType.FIGHTSTEP then
			var_31_2.fightStep = var_0_0.tempNewStepProto(iter_31_1.fightStep)
		end
	end

	return var_31_0
end

function var_0_0.tempProcessStepListProto(arg_32_0)
	local var_32_0 = {}

	for iter_32_0, iter_32_1 in ipairs(arg_32_0) do
		local var_32_1 = var_0_0.tempNewStepProto(iter_32_1)

		table.insert(var_32_0, var_32_1)
	end

	return var_32_0
end

local var_0_4 = 0
local var_0_5 = 0

function var_0_0.processRoundStep(arg_33_0)
	arg_33_0 = var_0_0.tempProcessStepListProto(arg_33_0)
	var_0_4 = 0
	var_0_5 = 0

	local var_33_0 = {}

	for iter_33_0, iter_33_1 in ipairs(arg_33_0) do
		var_0_0.addRoundStep(var_33_0, iter_33_1)
	end

	return var_33_0
end

function var_0_0.addRoundStep(arg_34_0, arg_34_1)
	table.insert(arg_34_0, arg_34_1)
	var_0_0.detectStepEffect(arg_34_0, arg_34_1.actEffect)
end

function var_0_0.detectStepEffect(arg_35_0, arg_35_1)
	if arg_35_1 and #arg_35_1 > 0 then
		local var_35_0 = 1

		while arg_35_1[var_35_0] do
			local var_35_1 = arg_35_1[var_35_0]

			if var_35_1.effectType == FightEnum.EffectType.SPLITSTART then
				var_0_4 = var_0_4 + 1
			elseif var_35_1.effectType == FightEnum.EffectType.SPLITEND then
				var_0_4 = var_0_4 - 1
			end

			if var_35_1.effectType == FightEnum.EffectType.FIGHTSTEP then
				if var_0_4 > 0 then
					table.remove(arg_35_1, var_35_0)

					var_35_0 = var_35_0 - 1
					var_0_5 = var_0_5 + 1

					var_0_0.addRoundStep(arg_35_0, var_35_1.fightStep)

					var_0_5 = var_0_5 - 1
				else
					local var_35_2 = var_35_1.fightStep

					if var_35_2.fakeTimeline then
						var_0_0.addRoundStep(arg_35_0, var_35_1.fightStep)
					elseif var_35_2.actType == FightEnum.ActType.SKILL then
						if var_0_0.needAddRoundStep(var_35_2) then
							var_0_0.addRoundStep(arg_35_0, var_35_1.fightStep)
						else
							var_0_0.detectStepEffect(arg_35_0, var_35_2.actEffect)
						end
					elseif var_35_2.actType == FightEnum.ActType.CHANGEHERO then
						var_0_0.addRoundStep(arg_35_0, var_35_1.fightStep)
					elseif var_35_2.actType == FightEnum.ActType.CHANGEWAVE then
						var_0_0.addRoundStep(arg_35_0, var_35_1.fightStep)
					else
						var_0_0.detectStepEffect(arg_35_0, var_35_2.actEffect)
					end
				end
			elseif var_0_4 > 0 and var_0_5 == 0 then
				table.remove(arg_35_1, var_35_0)

				var_35_0 = var_35_0 - 1

				local var_35_3 = {
					actType = FightEnum.ActType.EFFECT
				}

				var_35_3.fromId = "0"
				var_35_3.toId = "0"
				var_35_3.actId = 0
				var_35_3.actEffect = {
					var_35_1
				}
				var_35_3.cardIndex = 0
				var_35_3.supportHeroId = 0
				var_35_3.fakeTimeline = false

				table.insert(arg_35_0, var_35_3)
			end

			var_35_0 = var_35_0 + 1
		end
	end
end

function var_0_0.needAddRoundStep(arg_36_0)
	if arg_36_0 then
		if var_0_0.isTimelineStep(arg_36_0) then
			return true
		elseif arg_36_0.actType == FightEnum.ActType.CHANGEHERO then
			return true
		elseif arg_36_0.actType == FightEnum.ActType.CHANGEWAVE then
			return true
		end
	end
end

function var_0_0.buildInfoMOs(arg_37_0, arg_37_1)
	local var_37_0 = {}

	for iter_37_0, iter_37_1 in ipairs(arg_37_0) do
		local var_37_1 = arg_37_1.New()

		var_37_1:init(iter_37_1)
		table.insert(var_37_0, var_37_1)
	end

	return var_37_0
end

function var_0_0.logForPCSkillEditor(arg_38_0)
	if not SkillEditorMgr.instance.inEditMode or SLFramework.FrameworkSettings.IsEditor then
		logNormal(arg_38_0)
	end
end

function var_0_0.getEffectLabel(arg_39_0, arg_39_1)
	if gohelper.isNil(arg_39_0) then
		return
	end

	local var_39_0 = arg_39_0:GetComponentsInChildren(typeof(ZProj.EffectLabel))

	if not var_39_0 or var_39_0.Length <= 0 then
		return
	end

	local var_39_1 = {}

	for iter_39_0 = 0, var_39_0.Length - 1 do
		local var_39_2 = var_39_0[iter_39_0]

		if not arg_39_1 or var_39_2.label == arg_39_1 then
			table.insert(var_39_1, var_39_2)
		end
	end

	return var_39_1
end

function var_0_0.shouUIPoisoningEffect(arg_40_0)
	if FightConfig.instance:hasBuffFeature(arg_40_0, FightEnum.BuffType_Dot) then
		local var_40_0 = lua_skill_buff.configDict[arg_40_0]

		if var_40_0 and lua_fight_buff_use_poison_ui_effect.configDict[var_40_0.typeId] then
			return true
		end
	end

	return false
end

function var_0_0.dealDirectActEffectData(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = var_0_0.filterActEffect(arg_41_0, arg_41_2)
	local var_41_1 = #var_41_0
	local var_41_2 = {}

	if var_41_0[arg_41_1] then
		var_41_2 = var_41_0[arg_41_1]
	elseif var_41_1 > 0 then
		var_41_2 = var_41_0[var_41_1]
	end

	return var_41_2
end

function var_0_0.filterActEffect(arg_42_0, arg_42_1)
	local var_42_0 = {}
	local var_42_1 = {}
	local var_42_2 = {}

	for iter_42_0, iter_42_1 in ipairs(arg_42_0) do
		local var_42_3 = iter_42_1
		local var_42_4 = false

		if var_42_3.effectType == FightEnum.EffectType.SHIELD and not var_0_0.checkShieldHit(var_42_3) then
			var_42_4 = true
		end

		if not var_42_4 and arg_42_1[iter_42_1.effectType] then
			if not var_42_1[iter_42_1.targetId] then
				var_42_1[iter_42_1.targetId] = {}

				table.insert(var_42_2, iter_42_1.targetId)
			end

			table.insert(var_42_1[iter_42_1.targetId], iter_42_1)
		end
	end

	for iter_42_2, iter_42_3 in ipairs(var_42_2) do
		var_42_0[iter_42_2] = var_42_1[iter_42_3]
	end

	return var_42_0
end

function var_0_0.detectAttributeCounter()
	local var_43_0 = FightModel.instance:getFightParam()
	local var_43_1, var_43_2 = var_0_0.getAttributeCounter(var_43_0.monsterGroupIds, GameSceneMgr.instance:isSpScene())

	return var_43_1, var_43_2
end

function var_0_0.getAttributeCounter(arg_44_0, arg_44_1)
	local var_44_0
	local var_44_1 = {}

	for iter_44_0, iter_44_1 in ipairs(arg_44_0) do
		if not string.nilorempty(lua_monster_group.configDict[iter_44_1].bossId) then
			local var_44_2 = lua_monster_group.configDict[iter_44_1].bossId
		end

		local var_44_3 = FightStrUtil.instance:getSplitToNumberCache(lua_monster_group.configDict[iter_44_1].monster, "#")

		for iter_44_2, iter_44_3 in ipairs(var_44_3) do
			if not lua_monster.configDict[iter_44_3] then
				logError("怪物表找不到id:" .. iter_44_3)
			end

			local var_44_4 = lua_monster.configDict[iter_44_3].career

			if var_44_4 ~= 5 and var_44_4 ~= 6 then
				var_44_1[var_44_4] = (var_44_1[var_44_4] or 0) + 1

				if var_0_0.isBossId(lua_monster_group.configDict[iter_44_1].bossId, iter_44_3) then
					var_44_1[var_44_4] = (var_44_1[var_44_4] or 0) + 1
				end
			end
		end
	end

	local var_44_5 = {}
	local var_44_6 = {}

	if arg_44_1 then
		return var_44_5, var_44_6
	end

	if #var_44_5 == 0 then
		local var_44_7 = 0
		local var_44_8 = 0
		local var_44_9 = {}
		local var_44_10 = {}

		for iter_44_4, iter_44_5 in pairs(var_44_1) do
			if iter_44_5 >= 2 then
				var_44_7 = var_44_7 + 1

				table.insert(var_44_10, iter_44_4)
			else
				var_44_8 = var_44_8 + 1

				table.insert(var_44_9, iter_44_4)
			end
		end

		if var_44_7 == 1 then
			table.insert(var_44_5, FightConfig.instance:restrainedBy(var_44_10[1]))
			table.insert(var_44_6, FightConfig.instance:restrained(var_44_10[1]))
		elseif var_44_7 == 2 then
			if var_0_0.checkHadRestrain(var_44_10[1], var_44_10[2]) then
				table.insert(var_44_5, FightConfig.instance:restrainedBy(var_44_10[1]))
				table.insert(var_44_5, FightConfig.instance:restrainedBy(var_44_10[2]))
				table.insert(var_44_6, FightConfig.instance:restrained(var_44_10[1]))
				table.insert(var_44_6, FightConfig.instance:restrained(var_44_10[2]))
			end
		elseif var_44_7 == 0 then
			if var_44_8 == 1 then
				table.insert(var_44_5, FightConfig.instance:restrainedBy(var_44_9[1]))
				table.insert(var_44_6, FightConfig.instance:restrained(var_44_9[1]))
			elseif var_44_8 == 2 and var_0_0.checkHadRestrain(var_44_9[1], var_44_9[2]) then
				table.insert(var_44_5, FightConfig.instance:restrainedBy(var_44_9[1]))
				table.insert(var_44_5, FightConfig.instance:restrainedBy(var_44_9[2]))
				table.insert(var_44_6, FightConfig.instance:restrained(var_44_9[1]))
				table.insert(var_44_6, FightConfig.instance:restrained(var_44_9[2]))
			end
		end
	end

	for iter_44_6 = #var_44_6, 1, -1 do
		if tabletool.indexOf(var_44_5, var_44_6[1]) then
			table.remove(var_44_6, iter_44_6)
		end
	end

	return var_44_5, var_44_6
end

function var_0_0.checkHadRestrain(arg_45_0, arg_45_1)
	return FightConfig.instance:getRestrain(arg_45_0, arg_45_1) > 1000 or FightConfig.instance:getRestrain(arg_45_1, arg_45_0) > 1000
end

function var_0_0.setMonsterGuideFocusState(arg_46_0)
	local var_46_0 = FightWorkSkillOrBuffFocusMonster.getPlayerPrefKey(arg_46_0)

	PlayerPrefsHelper.setNumber(var_46_0, 1)

	if not string.nilorempty(arg_46_0.completeWithGroup) then
		local var_46_1 = FightStrUtil.instance:getSplitCache(arg_46_0.completeWithGroup, "|")

		for iter_46_0, iter_46_1 in ipairs(var_46_1) do
			local var_46_2 = FightStrUtil.instance:getSplitToNumberCache(iter_46_1, "#")
			local var_46_3 = FightConfig.instance:getMonsterGuideFocusConfig(var_46_2[1], var_46_2[2], var_46_2[3], var_46_2[4])

			if var_46_3 then
				local var_46_4 = FightWorkSkillOrBuffFocusMonster.getPlayerPrefKey(var_46_3)

				PlayerPrefsHelper.setNumber(var_46_4, 1)
			else
				logError("怪物指引图表找不到id：", var_46_2[1], var_46_2[2], var_46_2[3], var_46_2[4])
			end
		end
	end
end

function var_0_0.detectTimelinePlayEffectCondition(arg_47_0, arg_47_1, arg_47_2)
	if string.nilorempty(arg_47_1) or arg_47_1 == "0" then
		return true
	end

	if arg_47_1 == "1" then
		local var_47_0 = false

		for iter_47_0, iter_47_1 in pairs(arg_47_0.actEffect) do
			if iter_47_1.effectType == FightEnum.EffectType.DEAD then
				var_47_0 = true
			end
		end

		return var_47_0
	end

	local var_47_1 = FightStrUtil.instance:getSplitToNumberCache(arg_47_1, "#")
	local var_47_2 = var_47_1[1]

	if var_47_2 == 2 then
		for iter_47_2, iter_47_3 in ipairs(arg_47_0.actEffect) do
			if iter_47_3.effectType == FightEnum.EffectType.MISS or iter_47_3.effectType == FightEnum.EffectType.DAMAGE or iter_47_3.effectType == FightEnum.EffectType.CRIT or iter_47_3.effectType == FightEnum.EffectType.SHIELD then
				local var_47_3 = var_0_0.getEntity(iter_47_3.targetId)

				for iter_47_4 = 2, #var_47_1 do
					if arg_47_2 then
						if arg_47_2 == var_47_3 and var_0_0.detectEntityIncludeBuffType(var_47_3, var_47_1[iter_47_4]) then
							return true
						end
					elseif var_0_0.detectEntityIncludeBuffType(var_47_3, var_47_1[iter_47_4]) then
						return true
					end
				end
			end
		end
	end

	if var_47_2 == 3 then
		local var_47_4 = var_0_0.getEntity(arg_47_0.fromId)

		if var_47_4 then
			for iter_47_5 = 2, #var_47_1 do
				if var_0_0.detectEntityIncludeBuffType(var_47_4, var_47_1[iter_47_5]) then
					return true
				end
			end
		end
	end

	if var_47_2 == 4 then
		for iter_47_6, iter_47_7 in ipairs(arg_47_0.actEffect) do
			if iter_47_7.effectType == FightEnum.EffectType.MISS or iter_47_7.effectType == FightEnum.EffectType.DAMAGE or iter_47_7.effectType == FightEnum.EffectType.CRIT or iter_47_7.effectType == FightEnum.EffectType.SHIELD then
				local var_47_5 = var_0_0.getEntity(iter_47_7.targetId)

				for iter_47_8 = 2, #var_47_1 do
					if arg_47_2 then
						if arg_47_2 == var_47_5 and arg_47_2.buff and arg_47_2.buff:haveBuffId(var_47_1[iter_47_8]) then
							return true
						end
					elseif var_47_5.buff and var_47_5.buff:haveBuffId(var_47_1[iter_47_8]) then
						return true
					end
				end
			end
		end
	end

	if var_47_2 == 5 then
		local var_47_6 = var_0_0.getEntity(arg_47_0.fromId)

		if var_47_6 and var_47_6.buff then
			for iter_47_9 = 2, #var_47_1 do
				if var_47_6.buff:haveBuffId(var_47_1[iter_47_9]) then
					return true
				end
			end
		end
	end

	if var_47_2 == 6 then
		for iter_47_10, iter_47_11 in ipairs(arg_47_0.actEffect) do
			if iter_47_11.effectType == FightEnum.EffectType.MISS or iter_47_11.effectType == FightEnum.EffectType.DAMAGE or iter_47_11.effectType == FightEnum.EffectType.CRIT or iter_47_11.effectType == FightEnum.EffectType.SHIELD then
				local var_47_7 = var_0_0.getEntity(iter_47_11.targetId)

				for iter_47_12 = 2, #var_47_1 do
					if arg_47_2 then
						if arg_47_2 == var_47_7 then
							local var_47_8 = arg_47_2:getMO()

							if var_47_8 and var_47_8.skin == var_47_1[iter_47_12] then
								return true
							end
						end
					else
						local var_47_9 = var_47_7:getMO()

						if var_47_9 and var_47_9.skin == var_47_1[iter_47_12] then
							return true
						end
					end
				end
			end
		end
	end

	if var_47_2 == 7 then
		for iter_47_13, iter_47_14 in ipairs(arg_47_0.actEffect) do
			if iter_47_14.targetId == arg_47_0.fromId and iter_47_14.configEffect == var_47_1[2] then
				if iter_47_14.configEffect == 30011 then
					if iter_47_14.effectNum ~= 0 then
						return true
					end
				else
					return true
				end
			end
		end
	end

	if var_47_2 == 8 then
		for iter_47_15, iter_47_16 in ipairs(arg_47_0.actEffect) do
			if iter_47_16.targetId ~= arg_47_0.fromId and iter_47_16.configEffect == var_47_1[2] then
				if iter_47_16.configEffect == 30011 then
					if iter_47_16.effectNum ~= 0 then
						return true
					end
				else
					return true
				end
			end
		end
	end

	if var_47_2 == 9 then
		local var_47_10 = var_0_0.getEntity(arg_47_0.fromId)

		if var_47_10 and var_47_10.buff then
			for iter_47_17 = 2, #var_47_1 do
				if var_47_10.buff:haveBuffId(var_47_1[iter_47_17]) then
					return false
				end
			end

			return true
		end
	elseif var_47_2 == 10 then
		local var_47_11 = arg_47_0.playerOperationCountForPlayEffectTimeline

		if var_47_11 and var_47_1[2] == var_47_11 then
			return true
		end
	elseif var_47_2 == 11 then
		local var_47_12 = var_47_1[2]
		local var_47_13 = var_47_1[3]
		local var_47_14 = FightDataHelper.entityMgr:getById(arg_47_0.fromId)

		if var_47_14 then
			local var_47_15 = var_47_14:getPowerInfo(FightEnum.PowerType.Power)

			if var_47_15 then
				if var_47_12 == 1 then
					return var_47_13 < var_47_15.num
				elseif var_47_12 == 2 then
					return var_47_13 > var_47_15.num
				elseif var_47_12 == 3 then
					return var_47_15.num == var_47_13
				elseif var_47_12 == 4 then
					return var_47_13 <= var_47_15.num
				elseif var_47_12 == 5 then
					return var_47_13 >= var_47_15.num
				end
			end
		end
	end

	return false
end

function var_0_0.detectEntityIncludeBuffType(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = arg_48_0 and arg_48_0:getMO()

	arg_48_2 = arg_48_2 or var_48_0 and var_48_0:getBuffList() or {}

	for iter_48_0, iter_48_1 in ipairs(arg_48_2) do
		local var_48_1 = lua_skill_buff.configDict[iter_48_1.buffId]

		if arg_48_1 == lua_skill_bufftype.configDict[var_48_1.typeId].type then
			return true
		end
	end
end

function var_0_0.hideDefenderBuffEffect(arg_49_0, arg_49_1)
	local var_49_0 = lua_skin_monster_hide_buff_effect.configDict[arg_49_0.actId]
	local var_49_1 = {}

	if var_49_0 then
		local var_49_2 = {}
		local var_49_3

		if var_49_0.effectName == "all" then
			var_49_3 = true
		end

		local var_49_4 = FightStrUtil.instance:getSplitCache(var_49_0.effectName, "#")
		local var_49_5 = var_0_0.getDefenders(arg_49_0, true)
		local var_49_6 = {}

		for iter_49_0, iter_49_1 in ipairs(var_49_5) do
			if not var_49_6[iter_49_1.id] then
				var_49_6[iter_49_1.id] = true

				if var_0_0.isAssembledMonster(iter_49_1) then
					local var_49_7 = var_0_0.getSideEntitys(iter_49_1:getSide())

					for iter_49_2, iter_49_3 in ipairs(var_49_7) do
						if var_0_0.isAssembledMonster(iter_49_3) and not var_49_6[iter_49_3.id] then
							var_49_6[iter_49_3.id] = true

							table.insert(var_49_5, iter_49_3)
						end
					end
				end
			end
		end

		for iter_49_4, iter_49_5 in ipairs(var_49_5) do
			if var_49_3 then
				local var_49_8 = iter_49_5.skinSpineEffect

				if var_49_8 then
					var_49_1[iter_49_5.id] = iter_49_5.id

					if var_49_8._effectWrapDict then
						for iter_49_6, iter_49_7 in pairs(var_49_8._effectWrapDict) do
							table.insert(var_49_2, iter_49_7)
						end
					end
				end
			end

			local var_49_9 = iter_49_5.buff and iter_49_5.buff._buffEffectDict

			if var_49_9 then
				for iter_49_8, iter_49_9 in pairs(var_49_9) do
					if var_49_3 then
						var_49_1[iter_49_5.id] = iter_49_5.id

						table.insert(var_49_2, iter_49_9)
					else
						for iter_49_10, iter_49_11 in ipairs(var_49_4) do
							if var_0_0.getEffectUrlWithLod(iter_49_11) == iter_49_9.path then
								var_49_1[iter_49_5.id] = iter_49_5.id

								table.insert(var_49_2, iter_49_9)
							end
						end
					end
				end
			end

			local var_49_10 = iter_49_5.buff and iter_49_5.buff._loopBuffEffectWrapDict

			if var_49_10 then
				for iter_49_12, iter_49_13 in pairs(var_49_10) do
					if var_49_3 then
						var_49_1[iter_49_5.id] = iter_49_5.id

						table.insert(var_49_2, iter_49_13)
					else
						for iter_49_14, iter_49_15 in ipairs(var_49_4) do
							if var_0_0.getEffectUrlWithLod(iter_49_15) == iter_49_13.path then
								var_49_1[iter_49_5.id] = iter_49_5.id

								table.insert(var_49_2, iter_49_13)
							end
						end
					end
				end
			end
		end

		local var_49_11 = FightStrUtil.instance:getSplitCache(var_49_0.exceptEffect, "#")
		local var_49_12 = {}

		for iter_49_16, iter_49_17 in ipairs(var_49_11) do
			var_49_12[var_0_0.getEffectUrlWithLod(iter_49_17)] = true
		end

		for iter_49_18, iter_49_19 in ipairs(var_49_2) do
			local var_49_13 = var_49_2[iter_49_18]

			if not var_49_12[var_49_13.path] then
				var_49_13:setActive(false, arg_49_1)
			end
		end
	end

	return var_49_1
end

function var_0_0.revertDefenderBuffEffect(arg_50_0, arg_50_1)
	for iter_50_0, iter_50_1 in ipairs(arg_50_0) do
		local var_50_0 = var_0_0.getEntity(iter_50_1)

		if var_50_0 then
			if var_50_0.buff then
				var_50_0.buff:showBuffEffects(arg_50_1)
			end

			if var_50_0.skinSpineEffect then
				var_50_0.skinSpineEffect:showEffects(arg_50_1)
			end
		end
	end
end

function var_0_0.getEffectAbPath(arg_51_0)
	if GameResMgr.IsFromEditorDir or string.find(arg_51_0, "/buff/") then
		return arg_51_0
	else
		if isDebugBuild and string.find(arg_51_0, "always") then
			logError(arg_51_0)
		end

		return SLFramework.FileHelper.GetUnityPath(System.IO.Path.GetDirectoryName(arg_51_0))
	end
end

function var_0_0.getRolesTimelinePath(arg_52_0)
	if GameResMgr.IsFromEditorDir then
		return ResUrl.getSkillTimeline(arg_52_0)
	else
		return ResUrl.getRolesTimeline()
	end
end

function var_0_0.getCameraAniPath(arg_53_0)
	if GameResMgr.IsFromEditorDir then
		return ResUrl.getCameraAnim(arg_53_0)
	else
		return ResUrl.getCameraAnimABUrl()
	end
end

function var_0_0.getEntityAniPath(arg_54_0)
	if GameResMgr.IsFromEditorDir then
		return ResUrl.getEntityAnim(arg_54_0)
	else
		return ResUrl.getEntityAnimABUrl()
	end
end

function var_0_0.refreshCombinativeMonsterScaleAndPos(arg_55_0, arg_55_1)
	local var_55_0 = arg_55_0:getMO()

	if not var_55_0 then
		return
	end

	local var_55_1 = FightConfig.instance:getSkinCO(var_55_0.skin)

	if var_55_1 and var_55_1.canHide == 1 then
		-- block empty
	else
		return
	end

	local var_55_2 = var_0_0.getSideEntitys(arg_55_0:getSide())
	local var_55_3

	for iter_55_0, iter_55_1 in ipairs(var_55_2) do
		iter_55_1:setScale(arg_55_1)

		local var_55_4 = iter_55_1:getMO()

		if var_55_4 then
			local var_55_5 = FightConfig.instance:getSkinCO(var_55_4.skin)

			if var_55_5 and var_55_5.mainBody == 1 then
				var_55_3 = iter_55_1
			end
		end
	end

	if var_55_3 then
		local var_55_6, var_55_7, var_55_8 = var_0_0.getEntityStandPos(var_55_3:getMO())
		local var_55_9, var_55_10, var_55_11 = transformhelper.getPos(var_55_3.go.transform)

		for iter_55_2, iter_55_3 in ipairs(var_55_2) do
			if iter_55_3 ~= var_55_3 then
				local var_55_12, var_55_13, var_55_14 = var_0_0.getEntityStandPos(iter_55_3:getMO())
				local var_55_15 = var_55_12 - var_55_6
				local var_55_16 = var_55_13 - var_55_7
				local var_55_17 = var_55_14 - var_55_8

				transformhelper.setPos(iter_55_3.go.transform, var_55_15 * arg_55_1 + var_55_9, var_55_16 * arg_55_1 + var_55_10, var_55_17 * arg_55_1 + var_55_11)
			end
		end
	end
end

function var_0_0.getEntityDefaultIdleAniName(arg_56_0)
	local var_56_0 = arg_56_0:getMO()

	if var_56_0 and var_56_0.modelId == 3025 then
		local var_56_1 = var_0_0.getSideEntitys(arg_56_0:getSide(), true)

		for iter_56_0, iter_56_1 in ipairs(var_56_1) do
			if iter_56_1:getMO().modelId == 3028 then
				return SpineAnimState.idle_special
			end
		end
	end

	return SpineAnimState.idle1
end

var_0_0.XingTiSpineUrl2Special = {
	["roles/500502_xingti2hao/500502_xingti2hao_fight.prefab"] = "roles/500502_xingti2hao_special/500502_xingti2hao_special_fight.prefab",
	["roles/500503_xingti2hao/500503_xingti2hao_fight.prefab"] = "roles/500503_xingti2hao_special/500503_xingti2hao_special_fight.prefab",
	["roles/500501_xingti2hao/500501_xingti2hao_fight.prefab"] = "roles/500501_xingti2hao_special/500501_xingti2hao_special_fight.prefab"
}

function var_0_0.preloadXingTiSpecialUrl(arg_57_0)
	if var_0_0.isShowTogether(FightEnum.EntitySide.MySide, {
		3025,
		3028
	}) then
		for iter_57_0, iter_57_1 in ipairs(arg_57_0) do
			if iter_57_1 == 3025 then
				return 2
			end
		end

		return 1
	end
end

function var_0_0.detectXingTiSpecialUrl(arg_58_0)
	if arg_58_0:isMySide() then
		local var_58_0 = arg_58_0:getSide()

		return var_0_0.isShowTogether(var_58_0, {
			3025,
			3028
		})
	end
end

function var_0_0.isShowTogether(arg_59_0, arg_59_1)
	local var_59_0 = FightDataHelper.entityMgr:getSideList(arg_59_0)
	local var_59_1 = 0

	for iter_59_0, iter_59_1 in ipairs(var_59_0) do
		if tabletool.indexOf(arg_59_1, iter_59_1.modelId) then
			var_59_1 = var_59_1 + 1
		end
	end

	if var_59_1 == #arg_59_1 then
		return true
	end
end

function var_0_0.getPredeductionExpoint(arg_60_0)
	local var_60_0 = 0

	if FightModel.instance:getCurStage() == FightEnum.Stage.Card then
		local var_60_1 = var_0_0.getEntity(arg_60_0)

		if var_60_1 then
			local var_60_2 = var_60_1:getMO()
			local var_60_3 = FightDataHelper.operationDataMgr:getOpList()

			for iter_60_0, iter_60_1 in ipairs(var_60_3) do
				if arg_60_0 == iter_60_1.belongToEntityId and iter_60_1:isPlayCard() and FightCardDataHelper.isBigSkill(iter_60_1.skillId) and not FightCardDataHelper.isSkill3(iter_60_1.cardInfoMO) then
					var_60_0 = var_60_0 + var_60_2:getUniqueSkillPoint()
				end
			end
		end
	end

	return var_60_0
end

function var_0_0.setBossSkillSpeed(arg_61_0)
	local var_61_0 = var_0_0.getEntity(arg_61_0)
	local var_61_1 = var_61_0 and var_61_0:getMO()

	if var_61_1 then
		local var_61_2 = lua_monster_skin.configDict[var_61_1.skin]

		if var_61_2 and var_61_2.bossSkillSpeed == 1 then
			FightModel.instance.useBossSkillSpeed = true

			FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
		end
	end
end

function var_0_0.cancelBossSkillSpeed()
	if FightModel.instance.useBossSkillSpeed then
		FightModel.instance.useBossSkillSpeed = false

		FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	end
end

function var_0_0.setTimelineExclusiveSpeed(arg_63_0)
	local var_63_0 = lua_fight_timeline_speed.configDict[arg_63_0]

	if var_63_0 then
		local var_63_1 = FightModel.instance:getUserSpeed()
		local var_63_2 = FightStrUtil.instance:getSplitToNumberCache(var_63_0.speed, "#")

		FightModel.instance.useExclusiveSpeed = var_63_2[var_63_1]

		FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	end
end

function var_0_0.cancelExclusiveSpeed()
	if FightModel.instance.useExclusiveSpeed then
		FightModel.instance.useExclusiveSpeed = false

		FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	end
end

function var_0_0.needPlayTransitionAni(arg_65_0, arg_65_1)
	local var_65_0 = arg_65_0 and arg_65_0:getMO()

	if var_65_0 then
		local var_65_1 = var_65_0.skin
		local var_65_2 = lua_fight_transition_act.configDict[var_65_1]

		if var_65_2 then
			local var_65_3 = arg_65_0.spine:getAnimState()

			if var_65_2[var_65_3] and var_65_2[var_65_3][arg_65_1] then
				return true, var_65_2[var_65_3][arg_65_1].transitionAct
			end
		end
	end
end

function var_0_0._stepBuffDealStackedBuff(arg_66_0, arg_66_1, arg_66_2, arg_66_3)
	local var_66_0 = false

	if arg_66_3 then
		local var_66_1 = arg_66_3.actEffectData

		if var_66_1 and not FightSkillBuffMgr.instance:hasPlayBuff(var_66_1) then
			local var_66_2 = lua_skill_buff.configDict[var_66_1.buff.buffId]

			if var_66_2 and var_66_2.id == arg_66_2.id and var_66_1.effectType == FightEnum.EffectType.BUFFADD then
				var_66_0 = true
			end
		end
	end

	table.insert(arg_66_1, FunctionWork.New(function()
		local var_67_0 = var_0_0.getEntity(arg_66_0)

		if var_67_0 then
			var_67_0.buff.lockFloat = var_66_0
		end
	end))
	table.insert(arg_66_1, WorkWaitSeconds.New(0.01))
end

function var_0_0.hideAllEntity()
	local var_68_0 = var_0_0.getAllEntitys()

	for iter_68_0, iter_68_1 in ipairs(var_68_0) do
		iter_68_1:setActive(false, true)
		iter_68_1:setVisibleByPos(false)
		iter_68_1:setAlpha(0, 0)
	end
end

function var_0_0.isBossId(arg_69_0, arg_69_1)
	local var_69_0 = FightStrUtil.instance:getSplitToNumberCache(arg_69_0, "#")

	for iter_69_0, iter_69_1 in ipairs(var_69_0) do
		if arg_69_1 == iter_69_1 then
			return true
		end
	end
end

function var_0_0.getCurBossId()
	local var_70_0 = FightModel.instance:getCurMonsterGroupId()
	local var_70_1 = var_70_0 and lua_monster_group.configDict[var_70_0]

	return var_70_1 and not string.nilorempty(var_70_1.bossId) and var_70_1.bossId or nil
end

function var_0_0.setEffectEntitySide(arg_71_0, arg_71_1)
	if FightModel.instance:getVersion() >= 1 then
		return
	end

	local var_71_0 = arg_71_0.targetId

	if var_71_0 == FightEntityScene.MySideId then
		arg_71_1.side = FightEnum.EntitySide.MySide

		return
	elseif var_71_0 == FightEntityScene.EnemySideId then
		arg_71_1.side = FightEnum.EntitySide.EnemySide

		return
	end

	local var_71_1 = FightDataHelper.entityMgr:getById(var_71_0)

	if var_71_1 then
		arg_71_1.side = var_71_1.side
	end
end

function var_0_0.preloadZongMaoShaLiMianJu(arg_72_0, arg_72_1)
	local var_72_0 = var_0_0.getZongMaoShaLiMianJuPath(arg_72_0)

	if var_72_0 then
		table.insert(arg_72_1, var_72_0)
	end
end

function var_0_0.setZongMaoShaLiMianJuSpineUrl(arg_73_0, arg_73_1)
	local var_73_0 = var_0_0.getZongMaoShaLiMianJuPath(arg_73_0)

	if var_73_0 then
		arg_73_1[var_73_0] = true
	end
end

function var_0_0.getZongMaoShaLiMianJuPath(arg_74_0)
	local var_74_0 = lua_skin.configDict[arg_74_0]

	if var_74_0 and var_74_0.characterId == 3072 then
		local var_74_1 = string.format("roles/v1a3_%d_zongmaoshali_m/%d_zongmaoshali_m_fight.prefab", arg_74_0, arg_74_0)

		if var_74_0.id == 307203 then
			var_74_1 = "roles/v2a2_307203_zmsl_m/307203_zmsl_m_fight.prefab"
		end

		return var_74_1
	end
end

function var_0_0.getEnemyEntityByMonsterId(arg_75_0)
	local var_75_0 = var_0_0.getSideEntitys(FightEnum.EntitySide.EnemySide)

	for iter_75_0, iter_75_1 in ipairs(var_75_0) do
		local var_75_1 = iter_75_1:getMO()

		if var_75_1 and var_75_1.modelId == arg_75_0 then
			return iter_75_1
		end
	end
end

function var_0_0.sortAssembledMonster(arg_76_0)
	local var_76_0 = arg_76_0:getByIndex(1)

	if var_76_0 and lua_fight_assembled_monster.configDict[var_76_0.skin] then
		arg_76_0:sort(var_0_0.sortAssembledMonsterFunc)
	end
end

function var_0_0.sortAssembledMonsterFunc(arg_77_0, arg_77_1)
	local var_77_0 = arg_77_0 and lua_fight_assembled_monster.configDict[arg_77_0.skin]
	local var_77_1 = arg_77_1 and lua_fight_assembled_monster.configDict[arg_77_1.skin]

	if var_77_0 and not var_77_1 then
		return true
	elseif not var_77_0 and var_77_1 then
		return false
	elseif var_77_0 and var_77_1 then
		return var_77_0.part < var_77_1.part
	else
		return tonumber(arg_77_0.id) > tonumber(arg_77_1.id)
	end
end

function var_0_0.sortBuffReplaceSpineActConfig(arg_78_0, arg_78_1)
	return arg_78_0.priority > arg_78_1.priority
end

function var_0_0.processEntityActionName(arg_79_0, arg_79_1, arg_79_2)
	if not arg_79_1 then
		return
	end

	local var_79_0 = arg_79_0:getMO()

	if var_79_0 then
		local var_79_1 = lua_fight_buff_replace_spine_act.configDict[var_79_0.skin]

		if var_79_1 then
			local var_79_2 = {}

			for iter_79_0, iter_79_1 in pairs(var_79_1) do
				for iter_79_2, iter_79_3 in pairs(iter_79_1) do
					table.insert(var_79_2, iter_79_3)
				end
			end

			table.sort(var_79_2, var_0_0.sortBuffReplaceSpineActConfig)

			local var_79_3 = arg_79_0.buff

			if var_79_3 then
				for iter_79_4, iter_79_5 in ipairs(var_79_2) do
					if var_79_3:haveBuffId(iter_79_5.buffId) then
						local var_79_4 = 0

						for iter_79_6, iter_79_7 in ipairs(iter_79_5.combination) do
							if var_79_3:haveBuffId(iter_79_7) then
								var_79_4 = var_79_4 + 1
							end
						end

						if var_79_4 == #iter_79_5.combination and arg_79_0.spine and arg_79_0.spine:hasAnimation(arg_79_1 .. iter_79_5.suffix) then
							arg_79_1 = arg_79_1 .. iter_79_5.suffix

							break
						end
					end
				end
			end
		end
	end

	if arg_79_1 and var_79_0 then
		local var_79_5 = lua_fight_skin_special_behaviour.configDict[var_79_0.skin]

		if var_79_5 then
			local var_79_6 = arg_79_0.buff

			if var_79_6 then
				local var_79_7 = arg_79_1

				if string.find(var_79_7, "hit") then
					var_79_7 = "hit"
				end

				if not string.nilorempty(var_79_5[var_79_7]) then
					local var_79_8 = GameUtil.splitString2(var_79_5[var_79_7])

					for iter_79_8, iter_79_9 in ipairs(var_79_8) do
						local var_79_9 = tonumber(iter_79_9[1])

						if var_79_6:haveBuffId(var_79_9) then
							arg_79_1 = iter_79_9[2]
						end
					end
				end
			end
		end
	end

	if var_0_0.isAssembledMonster(arg_79_0) and arg_79_1 == "hit" then
		local var_79_10 = arg_79_0:getPartIndex()

		if arg_79_2 then
			for iter_79_10, iter_79_11 in ipairs(arg_79_2.actEffect) do
				if FightTLEventDefHit.directCharacterHitEffectType[iter_79_11.effectType] and iter_79_11.targetId ~= arg_79_0.id then
					local var_79_11 = var_0_0.getEntity(iter_79_11.targetId)

					if isTypeOf(var_79_11, FightEntityAssembledMonsterMain) or isTypeOf(var_79_11, FightEntityAssembledMonsterSub) then
						return arg_79_1
					end
				end
			end
		end

		arg_79_1 = string.format("%s_part_%d", arg_79_1, var_79_10)
	end

	return arg_79_1
end

function var_0_0.getProcessEntityStancePos(arg_80_0)
	local var_80_0, var_80_1, var_80_2 = var_0_0.getEntityStandPos(arg_80_0)
	local var_80_3 = var_0_0.getEntity(arg_80_0.id)

	if var_80_3 and var_0_0.isAssembledMonster(var_80_3) then
		local var_80_4 = lua_fight_assembled_monster.configDict[arg_80_0.skin].virtualStance

		return var_80_0 + var_80_4[1], var_80_1 + var_80_4[2], var_80_2 + var_80_4[3]
	end

	return var_80_0, var_80_1, var_80_2
end

function var_0_0.isAssembledMonster(arg_81_0)
	if isTypeOf(arg_81_0, FightEntityAssembledMonsterMain) or isTypeOf(arg_81_0, FightEntityAssembledMonsterSub) then
		return true
	end
end

function var_0_0.getProcessEntitySpinePos(arg_82_0)
	local var_82_0, var_82_1, var_82_2 = transformhelper.getPos(arg_82_0.go.transform)

	if var_0_0.isAssembledMonster(arg_82_0) then
		local var_82_3 = arg_82_0:getMO()
		local var_82_4 = lua_fight_assembled_monster.configDict[var_82_3.skin]

		var_82_0 = var_82_0 + var_82_4.virtualStance[1]
		var_82_1 = var_82_1 + var_82_4.virtualStance[2]
		var_82_2 = var_82_2 + var_82_4.virtualStance[3]
	end

	return var_82_0, var_82_1, var_82_2
end

function var_0_0.getProcessEntitySpineLocalPos(arg_83_0)
	local var_83_0 = 0
	local var_83_1 = 0
	local var_83_2 = 0

	if var_0_0.isAssembledMonster(arg_83_0) then
		local var_83_3 = arg_83_0:getMO()
		local var_83_4 = lua_fight_assembled_monster.configDict[var_83_3.skin]

		var_83_0 = var_83_0 + var_83_4.virtualStance[1]
		var_83_1 = var_83_1 + var_83_4.virtualStance[2]
		var_83_2 = var_83_2 + var_83_4.virtualStance[3]
	end

	return var_83_0, var_83_1, var_83_2
end

local var_0_6 = {}

function var_0_0.getAssembledEffectPosOfSpineHangPointRoot(arg_84_0, arg_84_1)
	if var_0_6[arg_84_1] then
		return 0, 0, 0
	end

	return var_0_0.getProcessEntitySpineLocalPos(arg_84_0)
end

function var_0_0.processBuffEffectPath(arg_85_0, arg_85_1, arg_85_2, arg_85_3, arg_85_4)
	local var_85_0 = lua_fight_effect_buff_skin.configDict[arg_85_2]

	if var_85_0 then
		local var_85_1 = arg_85_1:getSide()

		if var_85_0[1] then
			var_85_1 = FightEnum.EntitySide.MySide == var_85_1 and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide
			var_85_0 = var_85_0[1]
		else
			var_85_0 = var_85_0[2]
		end

		local var_85_2 = var_0_0.getSideEntitys(var_85_1, true)

		for iter_85_0, iter_85_1 in ipairs(var_85_2) do
			local var_85_3 = iter_85_1:getMO()

			if var_85_3 then
				local var_85_4 = var_85_3.skin

				if var_85_0[var_85_4] and not string.nilorempty(var_85_0[var_85_4][arg_85_3]) then
					local var_85_5 = var_85_0[var_85_4].audio

					return var_85_0[var_85_4][arg_85_3], var_85_5 ~= 0 and var_85_5 or arg_85_4, var_85_0[var_85_4]
				end
			end
		end
	end

	return arg_85_0, arg_85_4
end

function var_0_0.filterBuffEffectBySkin(arg_86_0, arg_86_1, arg_86_2, arg_86_3)
	local var_86_0 = lua_fight_buff_effect_to_skin.configDict[arg_86_0]

	if not var_86_0 then
		return arg_86_2, arg_86_3
	end

	local var_86_1 = arg_86_1 and arg_86_1:getMO()
	local var_86_2 = var_86_1 and var_86_1.skin

	if not var_86_2 then
		return "", 0
	end

	local var_86_3 = FightStrUtil.instance:getSplitToNumberCache(var_86_0.skinIdList, "|")

	if tabletool.indexOf(var_86_3, var_86_2) then
		return arg_86_2, arg_86_3
	end

	return "", 0
end

function var_0_0.getBuffListForReplaceTimeline(arg_87_0, arg_87_1, arg_87_2)
	local var_87_0 = var_0_0.getEntitysCloneBuff(arg_87_1)

	if arg_87_0 and arg_87_0.simulate == 1 then
		var_87_0 = var_0_0.simulateFightStepData(arg_87_2, var_87_0)
	end

	local var_87_1 = {}

	for iter_87_0, iter_87_1 in pairs(var_87_0) do
		tabletool.addValues(var_87_1, iter_87_1)
	end

	return var_87_1
end

function var_0_0.getTimelineListByName(arg_88_0, arg_88_1)
	local var_88_0 = arg_88_0
	local var_88_1 = {}
	local var_88_2 = lua_fight_replace_timeline.configDict[arg_88_0]

	if var_88_2 then
		for iter_88_0, iter_88_1 in pairs(var_88_2) do
			local var_88_3 = FightStrUtil.instance:getSplitCache(iter_88_1.condition, "#")

			if var_88_3[1] == "5" then
				local var_88_4 = {}

				for iter_88_2 = 2, #var_88_3 do
					var_88_4[tonumber(var_88_3[iter_88_2])] = true
				end

				if var_88_4[arg_88_1] then
					var_88_0 = iter_88_1.timeline
				end
			else
				table.insert(var_88_1, iter_88_1.timeline)
			end
		end
	end

	table.insert(var_88_1, var_88_0)

	return var_88_1
end

local var_0_7 = {}

function var_0_0.detectReplaceTimeline(arg_89_0, arg_89_1)
	local var_89_0 = lua_fight_replace_timeline.configDict[arg_89_0]

	if var_89_0 then
		local var_89_1 = {}

		for iter_89_0, iter_89_1 in pairs(var_89_0) do
			table.insert(var_89_1, iter_89_1)
		end

		table.sort(var_89_1, var_0_0.sortReplaceTimelineConfig)

		for iter_89_2, iter_89_3 in ipairs(var_89_1) do
			local var_89_2 = {}

			if iter_89_3.target == 1 then
				var_89_2[arg_89_1.fromId] = FightDataHelper.entityMgr:getById(arg_89_1.fromId)
			elseif iter_89_3.target == 2 then
				var_89_2[arg_89_1.toId] = FightDataHelper.entityMgr:getById(arg_89_1.toId)
			elseif iter_89_3.target == 3 or iter_89_3.target == 4 then
				local var_89_3
				local var_89_4 = arg_89_1.fromId

				if var_89_4 == FightEntityScene.MySideId then
					var_89_3 = FightEnum.EntitySide.MySide
				elseif var_89_4 == FightEntityScene.EnemySideId then
					var_89_3 = FightEnum.EntitySide.EnemySide
				else
					local var_89_5 = FightDataHelper.entityMgr:getById(arg_89_1.fromId)

					if var_89_5 then
						var_89_3 = var_89_5.side
					else
						var_89_3 = FightEnum.EntitySide.MySide
					end
				end

				local var_89_6 = FightDataHelper.entityMgr:getSideList(var_89_3, nil, iter_89_3.target == 4)

				for iter_89_4, iter_89_5 in ipairs(var_89_6) do
					var_89_2[iter_89_5.id] = iter_89_5
				end
			end

			local var_89_7 = FightStrUtil.instance:getSplitCache(iter_89_3.condition, "#")
			local var_89_8 = var_89_7[1]

			if var_89_8 == "1" then
				local var_89_9 = var_0_0.getBuffListForReplaceTimeline(iter_89_3, var_89_2, arg_89_1)
				local var_89_10 = tonumber(var_89_7[2])
				local var_89_11 = tonumber(var_89_7[3])

				for iter_89_6, iter_89_7 in ipairs(var_89_9) do
					if iter_89_7.buffId == var_89_10 and var_89_11 <= iter_89_7.count then
						return iter_89_3.timeline
					end
				end
			elseif var_89_8 == "2" then
				for iter_89_8, iter_89_9 in pairs(arg_89_1.actEffect) do
					if iter_89_9.effectType == FightEnum.EffectType.DEAD then
						return iter_89_3.timeline
					end
				end
			elseif var_89_8 == "3" then
				local var_89_12 = var_0_0.getBuffListForReplaceTimeline(iter_89_3, var_89_2, arg_89_1)

				for iter_89_10 = 2, #var_89_7 do
					if var_0_0.detectEntityIncludeBuffType(nil, tonumber(var_89_7[iter_89_10]), var_89_12) then
						return iter_89_3.timeline
					end
				end
			elseif var_89_8 == "4" then
				local var_89_13 = {}

				for iter_89_11 = 2, #var_89_7 do
					var_89_13[tonumber(var_89_7[iter_89_11])] = true
				end

				local var_89_14 = var_0_0.getBuffListForReplaceTimeline(iter_89_3, var_89_2, arg_89_1)

				for iter_89_12, iter_89_13 in ipairs(var_89_14) do
					if var_89_13[iter_89_13.buffId] then
						return iter_89_3.timeline
					end
				end
			elseif var_89_8 == "5" then
				local var_89_15 = {}

				for iter_89_14 = 2, #var_89_7 do
					var_89_15[tonumber(var_89_7[iter_89_14])] = true
				end

				for iter_89_15, iter_89_16 in pairs(var_89_2) do
					local var_89_16 = iter_89_16.skin

					if iter_89_3.target == 1 then
						var_89_16 = var_0_0.processSkinByStepData(arg_89_1, iter_89_16)
					end

					if iter_89_16 and var_89_15[var_89_16] then
						return iter_89_3.timeline
					end
				end
			elseif var_89_8 == "6" then
				local var_89_17 = {}

				for iter_89_17 = 2, #var_89_7 do
					var_89_17[tonumber(var_89_7[iter_89_17])] = true
				end

				for iter_89_18, iter_89_19 in ipairs(arg_89_1.actEffect) do
					if var_89_2[iter_89_19.targetId] and var_89_17[iter_89_19.configEffect] then
						return iter_89_3.timeline
					end
				end
			elseif var_89_8 == "7" then
				local var_89_18 = {}

				for iter_89_20 = 2, #var_89_7 do
					var_89_18[tonumber(var_89_7[iter_89_20])] = true
				end

				local var_89_19 = var_0_0.getBuffListForReplaceTimeline(iter_89_3, var_89_2, arg_89_1)

				for iter_89_21, iter_89_22 in ipairs(var_89_19) do
					if var_89_18[iter_89_22.buffId] then
						return arg_89_0
					end
				end

				return iter_89_3.timeline
			elseif var_89_8 == "8" then
				local var_89_20 = tonumber(var_89_7[2])
				local var_89_21 = tonumber(var_89_7[3])
				local var_89_22 = var_0_0.getEntitysCloneBuff(var_89_2)

				if iter_89_3.simulate == 1 then
					local var_89_23 = var_0_0.getBuffListForReplaceTimeline(nil, var_89_2, arg_89_1)

					for iter_89_23, iter_89_24 in ipairs(var_89_23) do
						if iter_89_24.buffId == var_89_20 and var_89_21 <= iter_89_24.count then
							return iter_89_3.timeline
						end
					end

					if var_0_0.simulateFightStepData(arg_89_1, var_89_22, var_0_0.detectBuffCountEnough, {
						buffId = var_89_20,
						count = var_89_21
					}) == true then
						return iter_89_3.timeline
					end
				else
					local var_89_24 = var_0_0.getBuffListForReplaceTimeline(iter_89_3, var_89_2, arg_89_1)

					for iter_89_25, iter_89_26 in ipairs(var_89_24) do
						if iter_89_26.buffId == var_89_20 and var_89_21 <= iter_89_26.count then
							return iter_89_3.timeline
						end
					end
				end
			elseif var_89_8 == "9" then
				local var_89_25 = {}

				for iter_89_27, iter_89_28 in ipairs(var_89_1) do
					local var_89_26 = tonumber(string.split(iter_89_28.condition, "#")[2])

					for iter_89_29, iter_89_30 in pairs(var_89_2) do
						local var_89_27 = iter_89_30.skin

						if iter_89_3.target == 1 then
							var_89_27 = var_0_0.processSkinByStepData(arg_89_1, iter_89_30)
						end

						if var_89_27 == var_89_26 then
							table.insert(var_89_25, iter_89_28)
						end
					end
				end

				local var_89_28 = #var_89_25

				if var_89_28 > 1 then
					local var_89_29 = var_0_7[arg_89_0]

					while true do
						local var_89_30 = math.random(1, var_89_28)

						if var_89_30 ~= var_89_29 then
							var_0_7[arg_89_0] = var_89_30

							return var_89_25[var_89_30].timeline
						end
					end
				elseif var_89_28 > 0 then
					return var_89_25[1].timeline
				end
			elseif var_89_8 == "10" then
				local var_89_31 = tonumber(var_89_7[2])

				if var_89_31 == 1 then
					if arg_89_1.fromId == arg_89_1.toId then
						return iter_89_3.timeline
					end
				elseif var_89_31 == 2 and arg_89_1.fromId ~= arg_89_1.toId then
					return iter_89_3.timeline
				end
			elseif var_89_8 == "11" then
				local var_89_32 = {}
				local var_89_33 = tonumber(var_89_7[2])

				for iter_89_31 = 3, #var_89_7 do
					var_89_32[tonumber(var_89_7[iter_89_31])] = true
				end

				for iter_89_32, iter_89_33 in pairs(var_89_2) do
					local var_89_34 = iter_89_33.skin

					if iter_89_3.target == 1 then
						var_89_34 = var_0_0.processSkinByStepData(arg_89_1, iter_89_33)
					end

					if var_89_33 == var_89_34 then
						local var_89_35 = var_0_0.getBuffListForReplaceTimeline(iter_89_3, var_89_2, arg_89_1)

						for iter_89_34, iter_89_35 in ipairs(var_89_35) do
							if var_89_32[iter_89_35.buffId] then
								return iter_89_3.timeline
							end
						end
					end
				end
			elseif var_89_8 == "12" then
				local var_89_36 = {}

				for iter_89_36 = 2, #var_89_7 - 1 do
					var_89_36[tonumber(var_89_7[iter_89_36])] = true
				end

				for iter_89_37, iter_89_38 in pairs(var_89_2) do
					local var_89_37 = iter_89_38.skin

					if iter_89_3.target == 1 then
						var_89_37 = var_0_0.processSkinByStepData(arg_89_1, iter_89_38)
					end

					if iter_89_38 and var_89_36[var_89_37] then
						local var_89_38 = var_89_7[#var_89_7]

						if var_89_38 == "1" then
							if arg_89_1.fromId == arg_89_1.toId then
								return iter_89_3.timeline
							end
						elseif var_89_38 == "2" then
							local var_89_39 = FightDataHelper.entityMgr:getById(arg_89_1.fromId)
							local var_89_40 = FightDataHelper.entityMgr:getById(arg_89_1.toId)

							if var_89_39 and var_89_40 and var_89_39.id ~= var_89_40.id and var_89_39.side == var_89_40.side then
								return iter_89_3.timeline
							end
						elseif var_89_38 == "3" then
							local var_89_41 = FightDataHelper.entityMgr:getById(arg_89_1.fromId)
							local var_89_42 = FightDataHelper.entityMgr:getById(arg_89_1.toId)

							if var_89_41 and var_89_42 and var_89_41.side ~= var_89_42.side then
								return iter_89_3.timeline
							end
						end
					end
				end
			end
		end
	end

	return arg_89_0
end

function var_0_0.detectBuffCountEnough(arg_90_0, arg_90_1)
	local var_90_0 = arg_90_1.buffId
	local var_90_1 = arg_90_1.count

	for iter_90_0, iter_90_1 in ipairs(arg_90_0) do
		if var_90_0 == iter_90_1.buffId and var_90_1 <= iter_90_1.count then
			return true
		end
	end
end

function var_0_0.simulateFightStepData(arg_91_0, arg_91_1, arg_91_2, arg_91_3)
	for iter_91_0, iter_91_1 in ipairs(arg_91_0.actEffect) do
		local var_91_0 = iter_91_1.targetId
		local var_91_1 = var_0_0.getEntity(var_91_0)
		local var_91_2 = var_91_1 and var_91_1:getMO()
		local var_91_3 = arg_91_1 and arg_91_1[var_91_0]

		if var_91_2 and var_91_3 then
			if iter_91_1.effectType == FightEnum.EffectType.BUFFADD then
				if not var_91_2:getBuffMO(iter_91_1.buff.uid) then
					local var_91_4 = FightBuffMO.New()

					var_91_4:init(iter_91_1.buff, iter_91_1.targetId)
					table.insert(var_91_3, var_91_4)
				end

				if arg_91_2 and arg_91_2(var_91_3, arg_91_3) then
					return true
				end
			elseif iter_91_1.effectType == FightEnum.EffectType.BUFFDEL or iter_91_1.effectType == FightEnum.EffectType.BUFFDELNOEFFECT then
				for iter_91_2, iter_91_3 in ipairs(var_91_3) do
					if iter_91_3.uid == iter_91_1.buff.uid then
						table.remove(var_91_3, iter_91_2)

						break
					end
				end

				if arg_91_2 and arg_91_2(var_91_3, arg_91_3) then
					return true
				end
			elseif iter_91_1.effectType == FightEnum.EffectType.BUFFUPDATE then
				for iter_91_4, iter_91_5 in ipairs(var_91_3) do
					if iter_91_5.uid == iter_91_1.buff.uid then
						iter_91_5:init(iter_91_1.buff, var_91_0)
					end
				end

				if arg_91_2 and arg_91_2(var_91_3, arg_91_3) then
					return true
				end
			end
		end
	end

	return arg_91_1
end

function var_0_0.getEntitysCloneBuff(arg_92_0)
	local var_92_0 = {}

	for iter_92_0, iter_92_1 in pairs(arg_92_0) do
		local var_92_1 = {}
		local var_92_2 = iter_92_1:getBuffList()

		for iter_92_2, iter_92_3 in ipairs(var_92_2) do
			local var_92_3 = iter_92_3:clone()

			table.insert(var_92_1, var_92_3)
		end

		var_92_0[iter_92_1.id] = var_92_1
	end

	return var_92_0
end

function var_0_0.sortReplaceTimelineConfig(arg_93_0, arg_93_1)
	return arg_93_0.priority < arg_93_1.priority
end

function var_0_0.getMagicSide(arg_94_0)
	local var_94_0 = FightDataHelper.entityMgr:getById(arg_94_0)

	if var_94_0 then
		return var_94_0.side
	elseif arg_94_0 == FightEntityScene.MySideId then
		return FightEnum.EntitySide.MySide
	elseif arg_94_0 == FightEntityScene.EnemySideId then
		return FightEnum.EntitySide.EnemySide
	end

	return FightEnum.EntitySide.MySide
end

function var_0_0.isBossRushChannelSkill(arg_95_0)
	local var_95_0 = lua_skill.configDict[arg_95_0]

	if var_95_0 then
		local var_95_1 = var_95_0.skillEffect
		local var_95_2 = lua_skill_effect.configDict[var_95_1]

		if var_95_2 then
			for iter_95_0 = 1, FightEnum.MaxBehavior do
				local var_95_3 = var_95_2["behavior" .. iter_95_0]

				if not string.nilorempty(var_95_3) then
					local var_95_4 = FightStrUtil.instance:getSplitCache(var_95_3, "#")

					if var_95_4[1] == "1" then
						local var_95_5 = tonumber(var_95_4[2])
						local var_95_6 = lua_skill_buff.configDict[var_95_5]

						if var_95_6 then
							local var_95_7 = FightStrUtil.instance:getSplitCache(var_95_6.features, "#")

							if var_95_7[1] == "742" then
								return true, tonumber(var_95_7[2]), tonumber(var_95_7[5])
							end
						end
					end
				end
			end
		end
	end
end

function var_0_0.processEntitySkin(arg_96_0, arg_96_1)
	local var_96_0 = HeroModel.instance:getById(arg_96_1)

	if var_96_0 and var_96_0.skin > 0 then
		return var_96_0.skin
	end

	return arg_96_0
end

function var_0_0.isPlayerCardSkill(arg_97_0)
	if not arg_97_0.cardIndex then
		return
	end

	if arg_97_0.cardIndex == 0 then
		return
	end

	local var_97_0 = arg_97_0.fromId

	if var_97_0 == FightEntityScene.MySideId then
		return true
	end

	local var_97_1 = FightDataHelper.entityMgr:getById(var_97_0)

	if not var_97_1 then
		return
	end

	return var_97_1.teamType == FightEnum.TeamType.MySide
end

function var_0_0.isEnemyCardSkill(arg_98_0)
	if not arg_98_0.cardIndex then
		return
	end

	if arg_98_0.cardIndex == 0 then
		return
	end

	local var_98_0 = arg_98_0.fromId

	if var_98_0 == FightEntityScene.EnemySideId then
		return true
	end

	local var_98_1 = FightDataHelper.entityMgr:getById(var_98_0)

	if not var_98_1 then
		return
	end

	return var_98_1.teamType == FightEnum.TeamType.EnemySide
end

function var_0_0.buildMonsterA2B(arg_99_0, arg_99_1, arg_99_2, arg_99_3)
	local var_99_0 = lua_fight_boss_evolution_client.configDict[arg_99_1.skin]

	arg_99_2:addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.BeforeMonsterA2B, arg_99_1.modelId))

	if var_99_0 then
		arg_99_2:addWork(Work2FightWork.New(FightWorkPlayTimeline, arg_99_0, var_99_0.timeline))

		if var_99_0.nextSkinId ~= 0 then
			arg_99_2:registWork(FightWorkFunction, var_0_0.setBossEvolution, var_0_0, arg_99_0, var_99_0)
		else
			arg_99_2:registWork(FightWorkFunction, var_0_0.removeEntity, arg_99_0.id)
		end
	end

	if arg_99_3 then
		arg_99_2:addWork(arg_99_3)
	end

	arg_99_2:addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.AfterMonsterA2B, arg_99_1.modelId))
end

function var_0_0.removeEntity(arg_100_0)
	local var_100_0 = GameSceneMgr.instance:getCurScene().entityMgr
	local var_100_1 = var_0_0.getEntity(arg_100_0)

	if var_100_1 then
		var_100_0:removeUnit(var_100_1:getTag(), var_100_1.id)
	end
end

function var_0_0.setBossEvolution(arg_101_0, arg_101_1, arg_101_2)
	FightController.instance:dispatchEvent(FightEvent.SetBossEvolution, arg_101_1, arg_101_2.nextSkinId)
	FightMsgMgr.sendMsg(FightMsgId.SetBossEvolution, arg_101_1, arg_101_2.nextSkinId)

	local var_101_0 = GameSceneMgr.instance:getCurScene().entityMgr

	if var_0_0.getEntity(arg_101_1.id) == arg_101_1 then
		var_101_0:removeUnitData(arg_101_1:getTag(), arg_101_1.id)
	end
end

function var_0_0.buildDeadPerformanceWork(arg_102_0, arg_102_1)
	local var_102_0 = FlowSequence.New()

	for iter_102_0 = 1, FightEnum.DeadPerformanceMaxNum do
		local var_102_1 = arg_102_0["actType" .. iter_102_0]
		local var_102_2 = arg_102_0["actParam" .. iter_102_0]

		if var_102_1 == 0 then
			break
		end

		if var_102_1 == 1 then
			var_102_0:addWork(FightWorkPlayTimeline.New(arg_102_1, var_102_2))
		elseif var_102_1 == 2 then
			var_102_0:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.DeadPerformanceNoCondition, tonumber(var_102_2)))
		end
	end

	return var_102_0
end

function var_0_0.compareData(arg_103_0, arg_103_1, arg_103_2)
	local var_103_0 = type(arg_103_0)

	if var_103_0 == "function" then
		return true
	elseif var_103_0 == "table" then
		for iter_103_0, iter_103_1 in pairs(arg_103_0) do
			local var_103_1 = false

			if type(iter_103_0) == "table" then
				var_103_1 = true
			end

			if arg_103_2 and arg_103_2[iter_103_0] then
				var_103_1 = true
			end

			if not arg_103_1 then
				return false
			end

			if type(arg_103_1) ~= "table" then
				return false
			end

			if not var_103_1 and not var_0_0.compareData(iter_103_1, arg_103_1[iter_103_0], arg_103_2) then
				return false, iter_103_0, iter_103_1, arg_103_1[iter_103_0]
			end
		end

		return true
	else
		return arg_103_0 == arg_103_1
	end
end

local var_0_8 = 0

function var_0_0.logStr(arg_104_0, arg_104_1)
	local var_104_0 = ""

	var_0_8 = 0

	if type(arg_104_0) == "table" then
		var_104_0 = var_104_0 .. var_0_0.logTable(arg_104_0, arg_104_1)
	else
		var_104_0 = var_104_0 .. tostring(arg_104_0)
	end

	return var_104_0
end

function var_0_0.logTable(arg_105_0, arg_105_1)
	local var_105_0 = "" .. "{\n"

	var_0_8 = var_0_8 + 1

	local var_105_1 = tabletool.len(arg_105_0)
	local var_105_2 = 0

	for iter_105_0, iter_105_1 in pairs(arg_105_0) do
		local var_105_3 = false

		if arg_105_1 and arg_105_1[iter_105_0] then
			var_105_3 = true
		end

		if not var_105_3 then
			for iter_105_2 = 1, var_0_8 do
				var_105_0 = var_105_0 .. "\t"
			end

			var_105_0 = var_105_0 .. iter_105_0 .. " = "

			if type(iter_105_1) == "table" then
				var_105_0 = var_105_0 .. var_0_0.logTable(iter_105_1, arg_105_1)
			else
				var_105_0 = var_105_0 .. tostring(iter_105_1)
			end

			var_105_2 = var_105_2 + 1

			if var_105_2 < var_105_1 then
				var_105_0 = var_105_0 .. ","
			end

			var_105_0 = var_105_0 .. "\n"
		end
	end

	var_0_8 = var_0_8 - 1

	for iter_105_3 = 1, var_0_8 do
		var_105_0 = var_105_0 .. "\t"
	end

	return var_105_0 .. "}"
end

function var_0_0.deepCopySimpleWithMeta(arg_106_0, arg_106_1)
	if type(arg_106_0) ~= "table" then
		return arg_106_0
	else
		local var_106_0 = {}

		for iter_106_0, iter_106_1 in pairs(arg_106_0) do
			local var_106_1 = false

			if arg_106_1 and arg_106_1[iter_106_0] then
				var_106_1 = true
			end

			if not var_106_1 then
				var_106_0[iter_106_0] = var_0_0.deepCopySimpleWithMeta(iter_106_1, arg_106_1)
			end
		end

		local var_106_2 = getmetatable(arg_106_0)

		if var_106_2 then
			setmetatable(var_106_0, var_106_2)
		end

		return var_106_0
	end
end

function var_0_0.getPassiveSkill(arg_107_0, arg_107_1)
	local var_107_0 = FightDataHelper.entityMgr:getById(arg_107_0)

	if not var_107_0 then
		return arg_107_1
	end

	local var_107_1 = var_107_0.upgradedOptions

	for iter_107_0, iter_107_1 in pairs(var_107_1) do
		local var_107_2 = lua_hero_upgrade_options.configDict[iter_107_1]

		if var_107_2 and not string.nilorempty(var_107_2.replacePassiveSkill) then
			local var_107_3 = GameUtil.splitString2(var_107_2.replacePassiveSkill, true)

			for iter_107_2, iter_107_3 in ipairs(var_107_3) do
				if arg_107_1 == iter_107_3[1] and var_107_0:isPassiveSkill(iter_107_3[2]) then
					return iter_107_3[2]
				end
			end
		end
	end

	return arg_107_1
end

function var_0_0.isSupportCard(arg_108_0)
	if arg_108_0.cardType == FightEnum.CardType.SUPPORT_NORMAL or arg_108_0.cardType == FightEnum.CardType.SUPPORT_EX then
		return true
	end
end

function var_0_0.curIsRougeFight()
	local var_109_0 = FightModel.instance:getFightParam()

	if not var_109_0 then
		return false
	end

	local var_109_1 = var_109_0.chapterId
	local var_109_2 = DungeonConfig.instance:getChapterCO(var_109_1)

	return var_109_2 and var_109_2.type == DungeonEnum.ChapterType.Rouge
end

function var_0_0.processSkinByStepData(arg_110_0, arg_110_1)
	arg_110_1 = arg_110_1 or FightDataHelper.entityMgr:getById(arg_110_0.fromId)

	local var_110_0 = arg_110_0.supportHeroId

	if var_110_0 ~= 0 and arg_110_1 and arg_110_1.modelId ~= var_110_0 then
		if var_0_0.curIsRougeFight() then
			local var_110_1 = RougeModel.instance:getTeamInfo()
			local var_110_2 = var_110_1 and var_110_1:getAssistHeroMo(var_110_0)

			if var_110_2 then
				return var_110_2.skin
			end
		end

		local var_110_3 = HeroModel.instance:getByHeroId(var_110_0)

		if var_110_3 and var_110_3.skin > 0 then
			return var_110_3.skin
		else
			local var_110_4 = lua_character.configDict[var_110_0]

			if var_110_4 then
				return var_110_4.skinId
			end
		end
	end

	return arg_110_1 and arg_110_1.skin or 0
end

function var_0_0.processSkinId(arg_111_0, arg_111_1)
	if (arg_111_1.cardType == FightEnum.CardType.SUPPORT_NORMAL or arg_111_1.cardType == FightEnum.CardType.SUPPORT_EX) and arg_111_1.heroId ~= arg_111_0.modelId then
		local var_111_0 = HeroModel.instance:getByHeroId(arg_111_1.heroId)

		if var_111_0 and var_111_0.skin > 0 then
			return var_111_0.skin
		else
			local var_111_1 = lua_character.configDict[arg_111_1.heroId]

			if var_111_1 then
				return var_111_1.skinId
			end
		end
	end

	return arg_111_0.skin
end

function var_0_0.processNextSkillId(arg_112_0)
	local var_112_0 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if var_112_0 and var_112_0.type == DungeonEnum.EpisodeType.Rouge then
		local var_112_1 = FightModel.instance:getRougeExData(FightEnum.ExIndexForRouge.SupportHeroSkill)

		if var_112_1 then
			local var_112_2 = cjson.decode(var_112_1)

			for iter_112_0, iter_112_1 in pairs(var_112_2) do
				if iter_112_1.skill1 then
					for iter_112_2, iter_112_3 in ipairs(iter_112_1.skill1) do
						local var_112_3 = iter_112_1.skill1[iter_112_2 + 1]

						if iter_112_3 == arg_112_0 and var_112_3 then
							return var_112_3
						end
					end
				end

				if iter_112_1.skill2 then
					for iter_112_4, iter_112_5 in ipairs(iter_112_1.skill2) do
						local var_112_4 = iter_112_1.skill2[iter_112_4 + 1]

						if iter_112_5 == arg_112_0 and var_112_4 then
							return var_112_4
						end
					end
				end
			end
		end
	end
end

function var_0_0.isTimelineStep(arg_113_0)
	if arg_113_0 and arg_113_0.actType == FightEnum.ActType.SKILL then
		local var_113_0 = FightDataHelper.entityMgr:getById(arg_113_0.fromId)
		local var_113_1 = var_113_0 and var_113_0.skin
		local var_113_2 = FightConfig.instance:getSkinSkillTimeline(var_113_1, arg_113_0.actId)

		if not string.nilorempty(var_113_2) then
			return true
		end
	end
end

function var_0_0.getClickEntity(arg_114_0, arg_114_1, arg_114_2)
	table.sort(arg_114_0, var_0_0.sortEntityList)

	for iter_114_0, iter_114_1 in ipairs(arg_114_0) do
		local var_114_0 = iter_114_1:getMO()

		if var_114_0 then
			local var_114_1
			local var_114_2
			local var_114_3
			local var_114_4
			local var_114_5
			local var_114_6
			local var_114_7
			local var_114_8
			local var_114_9 = var_0_0.getEntity(var_114_0.id)

			if isTypeOf(var_114_9, FightEntityAssembledMonsterMain) or isTypeOf(var_114_9, FightEntityAssembledMonsterSub) then
				local var_114_10 = lua_fight_assembled_monster.configDict[var_114_0.skin]
				local var_114_11, var_114_12, var_114_13 = transformhelper.getPos(iter_114_1.go.transform)
				local var_114_14 = var_114_11 + var_114_10.virtualSpinePos[1]
				local var_114_15 = var_114_12 + var_114_10.virtualSpinePos[2]
				local var_114_16 = var_114_13 + var_114_10.virtualSpinePos[3]

				var_114_7, var_114_8 = recthelper.worldPosToAnchorPosXYZ(var_114_14, var_114_15, var_114_16, arg_114_1)

				local var_114_17 = var_114_10.virtualSpineSize[1] * 0.5
				local var_114_18 = var_114_10.virtualSpineSize[2] * 0.5
				local var_114_19 = var_114_14 - var_114_17
				local var_114_20 = var_114_15 - var_114_18
				local var_114_21 = var_114_16
				local var_114_22 = var_114_14 + var_114_17
				local var_114_23 = var_114_15 + var_114_18
				local var_114_24 = var_114_16
				local var_114_25, var_114_26, var_114_27 = recthelper.worldPosToAnchorPosXYZ(var_114_19, var_114_20, var_114_21, arg_114_1)
				local var_114_28, var_114_29, var_114_30 = recthelper.worldPosToAnchorPosXYZ(var_114_22, var_114_23, var_114_24, arg_114_1)
				local var_114_31 = (var_114_28 - var_114_25) / 2

				var_114_2 = var_114_7 - var_114_31
				var_114_3 = var_114_7 + var_114_31

				local var_114_32 = (var_114_29 - var_114_26) / 2

				var_114_5 = var_114_8 - var_114_32
				var_114_6 = var_114_8 + var_114_32
			else
				local var_114_33, var_114_34, var_114_35, var_114_36 = var_0_0.calcRect(iter_114_1, arg_114_1)
				local var_114_37 = iter_114_1:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle)

				if var_114_37 then
					local var_114_38, var_114_39, var_114_40 = transformhelper.getPos(var_114_37.transform)

					var_114_7, var_114_8 = recthelper.worldPosToAnchorPosXYZ(var_114_38, var_114_39, var_114_40, arg_114_1)
				else
					var_114_7 = (var_114_33 + var_114_35) / 2
					var_114_8 = (var_114_34 + var_114_36) / 2
				end

				local var_114_41 = math.abs(var_114_33 - var_114_35)
				local var_114_42 = math.abs(var_114_34 - var_114_36)
				local var_114_43 = lua_monster_skin.configDict[var_114_0.skin]
				local var_114_44 = var_114_43 and var_114_43.clickBoxUnlimit == 1
				local var_114_45 = var_114_44 and 800 or 200
				local var_114_46 = var_114_44 and 800 or 500
				local var_114_47 = Mathf.Clamp(var_114_41, 150, var_114_45)
				local var_114_48 = Mathf.Clamp(var_114_42, 150, var_114_46)
				local var_114_49 = var_114_47 / 2

				var_114_2 = var_114_7 - var_114_49
				var_114_3 = var_114_7 + var_114_49

				local var_114_50 = var_114_48 / 2

				var_114_5 = var_114_8 - var_114_50
				var_114_6 = var_114_8 + var_114_50
			end

			local var_114_51, var_114_52 = recthelper.screenPosToAnchorPos2(arg_114_2, arg_114_1)

			if var_114_2 <= var_114_51 and var_114_51 <= var_114_3 and var_114_5 <= var_114_52 and var_114_52 <= var_114_6 then
				return iter_114_1.id, var_114_7, var_114_8
			end
		end
	end
end

function var_0_0.calcRect(arg_115_0, arg_115_1)
	if not arg_115_0 then
		return 10000, 10000, 10000, 10000
	end

	local var_115_0 = arg_115_0:getHangPoint(ModuleEnum.SpineHangPoint.BodyStatic)

	if not var_115_0 then
		return 10000, 10000, 10000, 10000
	end

	local var_115_1, var_115_2, var_115_3 = transformhelper.getPos(var_115_0.transform)
	local var_115_4, var_115_5 = var_0_0.getEntityBoxSizeOffsetV2(arg_115_0)
	local var_115_6 = arg_115_0:isMySide() and 1 or -1
	local var_115_7, var_115_8 = recthelper.worldPosToAnchorPosXYZ(var_115_1 - var_115_4.x * 0.5, var_115_2 - var_115_4.y * 0.5 * var_115_6, var_115_3, arg_115_1)
	local var_115_9, var_115_10 = recthelper.worldPosToAnchorPosXYZ(var_115_1 + var_115_4.x * 0.5, var_115_2 + var_115_4.y * 0.5 * var_115_6, var_115_3, arg_115_1)

	return var_115_7, var_115_8, var_115_9, var_115_10
end

function var_0_0.sortEntityList(arg_116_0, arg_116_1)
	local var_116_0 = arg_116_0:getMO()
	local var_116_1 = arg_116_1:getMO()
	local var_116_2 = isTypeOf(arg_116_0, FightEntityAssembledMonsterMain) or isTypeOf(arg_116_0, FightEntityAssembledMonsterSub)
	local var_116_3 = isTypeOf(arg_116_1, FightEntityAssembledMonsterMain) or isTypeOf(arg_116_1, FightEntityAssembledMonsterSub)

	if var_116_2 and var_116_3 then
		local var_116_4 = lua_fight_assembled_monster.configDict[var_116_0.skin]
		local var_116_5 = lua_fight_assembled_monster.configDict[var_116_1.skin]

		return var_116_4.clickIndex > var_116_5.clickIndex
	elseif var_116_2 and not var_116_3 then
		return true
	elseif not var_116_2 and var_116_3 then
		return false
	else
		local var_116_6, var_116_7, var_116_8 = var_0_0.getEntityStandPos(var_116_0)
		local var_116_9, var_116_10, var_116_11 = var_0_0.getEntityStandPos(var_116_1)

		if var_116_8 ~= var_116_11 then
			return var_116_8 < var_116_11
		else
			return tonumber(var_116_0.id) > tonumber(var_116_1.id)
		end
	end
end

function var_0_0.sortNextRoundGetCardConfig(arg_117_0, arg_117_1)
	return arg_117_0.priority > arg_117_1.priority
end

function var_0_0.sortNextRoundGetCard(arg_118_0, arg_118_1)
	return arg_118_0.index < arg_118_1.index
end

function var_0_0.getNextRoundGetCardList()
	local var_119_0 = {}
	local var_119_1 = {}
	local var_119_2 = FightDataHelper.operationDataMgr:getOpList()

	for iter_119_0, iter_119_1 in ipairs(var_119_2) do
		if iter_119_1:isPlayCard() then
			local var_119_3 = iter_119_1.skillId
			local var_119_4 = lua_fight_next_round_get_card.configDict[var_119_3]

			if var_119_4 then
				local var_119_5 = {}

				for iter_119_2, iter_119_3 in pairs(var_119_4) do
					table.insert(var_119_5, iter_119_3)
				end

				table.sort(var_119_5, var_0_0.sortNextRoundGetCardConfig)

				for iter_119_4, iter_119_5 in ipairs(var_119_5) do
					local var_119_6 = iter_119_5.condition

					if var_0_0.checkNextRoundCardCondition(iter_119_1, var_119_6) then
						if iter_119_5.exclusion ~= 0 then
							var_119_0[iter_119_5.exclusion] = var_119_0[iter_119_5.exclusion] or {}
							var_119_0[iter_119_5.exclusion].index = iter_119_0
							var_119_0[iter_119_5.exclusion].skillId = iter_119_5.skillId
							var_119_0[iter_119_5.exclusion].entityId = iter_119_1.belongToEntityId
							var_119_0[iter_119_5.exclusion].tempCard = iter_119_5.tempCard

							break
						end

						local var_119_7 = {
							index = iter_119_0,
							skillId = iter_119_5.skillId,
							entityId = iter_119_1.belongToEntityId,
							tempCard = iter_119_5.tempCard
						}

						table.insert(var_119_1, var_119_7)

						break
					end
				end
			end
		end
	end

	for iter_119_6, iter_119_7 in pairs(var_119_0) do
		table.insert(var_119_1, iter_119_7)
	end

	table.sort(var_119_1, var_0_0.sortNextRoundGetCard)

	local var_119_8 = {}

	for iter_119_8, iter_119_9 in ipairs(var_119_1) do
		local var_119_9 = string.splitToNumber(iter_119_9.skillId, "#")

		for iter_119_10, iter_119_11 in ipairs(var_119_9) do
			local var_119_10 = {
				uid = iter_119_9.entityId,
				skillId = iter_119_11,
				tempCard = iter_119_9.tempCard
			}
			local var_119_11 = FightCardInfoData.New(var_119_10)

			table.insert(var_119_8, var_119_11)
		end
	end

	return var_119_8
end

function var_0_0.checkNextRoundCardCondition(arg_120_0, arg_120_1)
	if string.nilorempty(arg_120_1) then
		return true
	end

	local var_120_0 = string.split(arg_120_1, "&")

	if #var_120_0 > 1 then
		local var_120_1 = 0

		for iter_120_0, iter_120_1 in ipairs(var_120_0) do
			if var_0_0.checkNextRoundCardSingleCondition(arg_120_0, iter_120_1) then
				var_120_1 = var_120_1 + 1
			end
		end

		return var_120_1 == #var_120_0
	else
		return var_0_0.checkNextRoundCardSingleCondition(arg_120_0, var_120_0[1])
	end
end

function var_0_0.checkNextRoundCardSingleCondition(arg_121_0, arg_121_1)
	local var_121_0 = arg_121_0.belongToEntityId
	local var_121_1 = var_0_0.getEntity(var_121_0)
	local var_121_2 = var_121_1 and var_121_1:getMO()
	local var_121_3 = string.split(arg_121_1, "#")

	if var_121_3[1] == "1" then
		if var_121_3[2] and var_121_2 then
			local var_121_4, var_121_5 = HeroConfig.instance:getShowLevel(var_121_2.level)

			if var_121_5 - 1 >= tonumber(var_121_3[2]) then
				return true
			end
		end
	elseif var_121_3[1] == "2" and var_121_3[2] and var_121_2 then
		return var_121_2.exSkillLevel == tonumber(var_121_3[2])
	end
end

function var_0_0.checkShieldHit(arg_122_0)
	if arg_122_0.effectNum1 == FightEnum.EffectType.SHAREHURT then
		return false
	end

	return true
end

var_0_0.SkillEditorHp = 2000

function var_0_0.buildMySideFightEntityMOList(arg_123_0)
	local var_123_0 = FightEnum.EntitySide.MySide
	local var_123_1 = {}
	local var_123_2 = {}

	for iter_123_0 = 1, SkillEditorMgr.instance.stance_count_limit do
		local var_123_3 = HeroModel.instance:getById(arg_123_0.mySideUids[iter_123_0])

		if var_123_3 then
			var_123_1[iter_123_0] = var_123_3.heroId
			var_123_2[iter_123_0] = var_123_3.skin
		end
	end

	local var_123_4 = {}
	local var_123_5 = {}

	for iter_123_1, iter_123_2 in ipairs(arg_123_0.mySideSubUids) do
		local var_123_6 = HeroModel.instance:getById(iter_123_2)

		if var_123_6 then
			table.insert(var_123_4, var_123_6.heroId)
			table.insert(var_123_5, var_123_6.skin)
		end
	end

	return var_0_0.buildHeroEntityMOList(var_123_0, var_123_1, var_123_2, var_123_4, var_123_5)
end

function var_0_0.getEmptyFightEntityMO(arg_124_0, arg_124_1, arg_124_2, arg_124_3)
	if not arg_124_1 or arg_124_1 == 0 then
		return
	end

	local var_124_0 = lua_character.configDict[arg_124_1]
	local var_124_1 = FightEntityMO.New()

	var_124_1.id = tostring(arg_124_0)
	var_124_1.uid = var_124_1.id
	var_124_1.modelId = arg_124_1 or 0
	var_124_1.entityType = 1
	var_124_1.exPoint = 0
	var_124_1.side = FightEnum.EntitySide.MySide
	var_124_1.currentHp = 0
	var_124_1.attrMO = var_0_0._buildAttr(var_124_0)
	var_124_1.skillIds = var_0_0._buildHeroSkills(var_124_0)
	var_124_1.shieldValue = 0
	var_124_1.level = arg_124_2 or 1
	var_124_1.skin = arg_124_3 or var_124_0.skinId

	if not string.nilorempty(var_124_0.powerMax) then
		local var_124_2 = FightStrUtil.instance:getSplitToNumberCache(var_124_0.powerMax, "#")
		local var_124_3 = {
			{
				num = 0,
				powerId = var_124_2[1],
				max = var_124_2[2]
			}
		}

		var_124_1:setPowerInfos(var_124_3)
	end

	return var_124_1
end

function var_0_0.buildHeroEntityMOList(arg_125_0, arg_125_1, arg_125_2, arg_125_3, arg_125_4)
	local function var_125_0(arg_126_0, arg_126_1)
		local var_126_0 = FightEntityMO.New()

		var_126_0.id = tostring(var_0_1)
		var_126_0.uid = var_126_0.id
		var_126_0.modelId = arg_126_0 or 0
		var_126_0.entityType = 1
		var_126_0.exPoint = 0
		var_126_0.side = arg_125_0
		var_126_0.currentHp = var_0_0.SkillEditorHp
		var_126_0.attrMO = var_0_0._buildAttr(arg_126_1)
		var_126_0.skillIds = var_0_0._buildHeroSkills(arg_126_1)
		var_126_0.shieldValue = 0
		var_126_0.level = 1
		var_126_0.storedExPoint = 0

		if not string.nilorempty(arg_126_1.powerMax) then
			local var_126_1 = FightStrUtil.instance:getSplitToNumberCache(arg_126_1.powerMax, "#")
			local var_126_2 = {
				{
					num = 0,
					powerId = var_126_1[1],
					max = var_126_1[2]
				}
			}

			var_126_0:setPowerInfos(var_126_2)
		end

		var_0_1 = var_0_1 + 1

		return var_126_0
	end

	local var_125_1 = {}
	local var_125_2 = {}
	local var_125_3 = arg_125_1 and #arg_125_1 or SkillEditorMgr.instance.stance_count_limit

	for iter_125_0 = 1, var_125_3 do
		local var_125_4 = arg_125_1[iter_125_0]

		if var_125_4 and var_125_4 ~= 0 then
			local var_125_5 = lua_character.configDict[var_125_4]

			if var_125_5 then
				local var_125_6 = var_125_0(var_125_4, var_125_5)

				var_125_6.position = iter_125_0
				var_125_6.skin = arg_125_2 and arg_125_2[iter_125_0] or var_125_5.skinId

				table.insert(var_125_1, var_125_6)
			else
				local var_125_7 = arg_125_0 == FightEnum.EntitySide.MySide and "我方" or "敌方"

				logError(string.format("%s%d号站位的角色配置已被删除，角色id=%d", var_125_7, iter_125_0, var_125_4))
			end
		end
	end

	if arg_125_3 then
		for iter_125_1, iter_125_2 in ipairs(arg_125_3) do
			local var_125_8 = lua_character.configDict[iter_125_2]

			if var_125_8 then
				local var_125_9 = var_125_0(iter_125_2, var_125_8)

				var_125_9.position = -1
				var_125_9.skin = arg_125_4 and arg_125_4[iter_125_1] or var_125_8.skinId

				table.insert(var_125_2, var_125_9)
			else
				local var_125_10 = arg_125_0 == FightEnum.EntitySide.MySide and "我方" or "敌方"

				logError(var_125_10 .. "替补角色的配置已被删除，角色id=" .. iter_125_2)
			end
		end
	end

	return var_125_1, var_125_2
end

function var_0_0.buildEnemySideFightEntityMOList(arg_127_0, arg_127_1)
	local var_127_0 = FightEnum.EntitySide.EnemySide
	local var_127_1 = arg_127_0.monsterGroupIds[arg_127_1]
	local var_127_2 = lua_monster_group.configDict[var_127_1]
	local var_127_3 = FightStrUtil.instance:getSplitToNumberCache(var_127_2.monster, "#")
	local var_127_4 = var_127_2.subMonsters

	return var_0_0.buildMonsterEntityMOList(var_127_0, var_127_3, var_127_4)
end

function var_0_0.buildMonsterEntityMOList(arg_128_0, arg_128_1, arg_128_2)
	local var_128_0 = {}
	local var_128_1 = {}

	for iter_128_0 = 1, SkillEditorMgr.instance.enemy_stance_count_limit do
		local var_128_2 = arg_128_1[iter_128_0]

		if var_128_2 and var_128_2 ~= 0 then
			local var_128_3 = lua_monster.configDict[var_128_2]

			if var_128_3 then
				local var_128_4 = FightEntityMO.New()

				var_128_4.id = tostring(var_0_2)
				var_128_4.uid = var_128_4.id
				var_128_4.modelId = var_128_2
				var_128_4.position = iter_128_0
				var_128_4.entityType = 2
				var_128_4.exPoint = 0
				var_128_4.skin = var_128_3.skinId
				var_128_4.side = arg_128_0
				var_128_4.currentHp = var_0_0.SkillEditorHp
				var_128_4.attrMO = var_0_0._buildAttr(var_128_3)
				var_128_4.skillIds = var_0_0._buildMonsterSkills(var_128_3)
				var_128_4.shieldValue = 0
				var_128_4.level = 1
				var_128_4.storedExPoint = 0
				var_0_2 = var_0_2 - 1

				table.insert(var_128_0, var_128_4)
			else
				local var_128_5 = arg_128_0 == FightEnum.EntitySide.MySide and "我方" or "敌方"

				logError(string.format("%s%d号站位的怪物配置已被删除，怪物id=%d", var_128_5, iter_128_0, var_128_2))
			end
		end
	end

	if arg_128_2 then
		for iter_128_1, iter_128_2 in ipairs(arg_128_2) do
			local var_128_6 = lua_monster.configDict[iter_128_2]

			if var_128_6 then
				local var_128_7 = FightEntityMO.New()

				var_128_7.id = tostring(var_0_2)
				var_128_7.uid = var_128_7.id
				var_128_7.modelId = iter_128_2
				var_128_7.position = 5
				var_128_7.entityType = 2
				var_128_7.exPoint = 0
				var_128_7.skin = var_128_6.skinId
				var_128_7.side = arg_128_0
				var_128_7.currentHp = var_0_0.SkillEditorHp
				var_128_7.attrMO = var_0_0._buildAttr(var_128_6)
				var_128_7.skillIds = var_0_0._buildMonsterSkills(var_128_6)
				var_128_7.shieldValue = 0
				var_128_7.level = 1
				var_0_2 = var_0_2 - 1

				table.insert(var_128_1, var_128_7)
			else
				local var_128_8 = arg_128_0 == FightEnum.EntitySide.MySide and "我方" or "敌方"

				logError(var_128_8 .. "替补怪物的配置已被删除，怪物id=" .. iter_128_2)
			end
		end
	end

	return var_128_0, var_128_1
end

function var_0_0.buildSkills(arg_129_0)
	local var_129_0 = lua_character.configDict[arg_129_0]

	if var_129_0 then
		return var_0_0._buildHeroSkills(var_129_0)
	end

	local var_129_1 = lua_monster.configDict[arg_129_0]

	if var_129_1 then
		return var_0_0._buildMonsterSkills(var_129_1)
	end
end

function var_0_0._buildHeroSkills(arg_130_0)
	local var_130_0 = {}
	local var_130_1 = lua_character.configDict[arg_130_0.id]

	if var_130_1 then
		local var_130_2 = GameUtil.splitString2(var_130_1.skill, true)

		for iter_130_0, iter_130_1 in pairs(var_130_2) do
			for iter_130_2 = 2, #iter_130_1 do
				if iter_130_1[iter_130_2] ~= 0 then
					table.insert(var_130_0, iter_130_1[iter_130_2])
				else
					logError(arg_130_0.id .. " 角色技能id=0，检查下角色表-角色")
				end
			end
		end
	end

	if var_130_1.exSkill ~= 0 then
		table.insert(var_130_0, var_130_1.exSkill)
	end

	local var_130_3 = lua_skill_ex_level.configDict[arg_130_0.id]

	if var_130_3 then
		for iter_130_3, iter_130_4 in pairs(var_130_3) do
			if iter_130_4.skillEx ~= 0 then
				table.insert(var_130_0, iter_130_4.skillEx)
			end
		end
	end

	local var_130_4 = lua_skill_passive_level.configDict[arg_130_0.id]

	if var_130_4 then
		for iter_130_5, iter_130_6 in pairs(var_130_4) do
			if iter_130_6.skillPassive ~= 0 then
				table.insert(var_130_0, iter_130_6.skillPassive)
			else
				logError(arg_130_0.id .. " 角色被动技能id=0，检查下角色养成表-被动升级")
			end
		end
	end

	return var_130_0
end

function var_0_0._buildMonsterSkills(arg_131_0)
	local var_131_0 = {}

	if not string.nilorempty(arg_131_0.activeSkill) then
		local var_131_1 = FightStrUtil.instance:getSplitString2Cache(arg_131_0.activeSkill, true, "|", "#")

		for iter_131_0, iter_131_1 in ipairs(var_131_1) do
			for iter_131_2, iter_131_3 in ipairs(iter_131_1) do
				if lua_skill.configDict[iter_131_3] then
					table.insert(var_131_0, iter_131_3)
				end
			end
		end
	end

	if arg_131_0.uniqueSkill and #arg_131_0.uniqueSkill > 0 then
		for iter_131_4, iter_131_5 in ipairs(arg_131_0.uniqueSkill) do
			table.insert(var_131_0, iter_131_5)
		end
	end

	tabletool.addValues(var_131_0, FightConfig.instance:getPassiveSkills(arg_131_0.id))

	return var_131_0
end

function var_0_0._buildAttr(arg_132_0)
	local var_132_0 = HeroAttributeMO.New()

	var_132_0.hp = var_0_0.SkillEditorHp
	var_132_0.attack = 100
	var_132_0.defense = 100
	var_132_0.crit = 100
	var_132_0.crit_damage = 100
	var_132_0.multiHpNum = 0
	var_132_0.multiHpIdx = 0

	return var_132_0
end

function var_0_0.getEpisodeRecommendLevel(arg_133_0, arg_133_1)
	local var_133_0 = DungeonConfig.instance:getEpisodeBattleId(arg_133_0)

	if not var_133_0 then
		return 0
	end

	return var_0_0.getBattleRecommendLevel(var_133_0, arg_133_1)
end

function var_0_0.getBattleRecommendLevel(arg_134_0, arg_134_1)
	local var_134_0 = arg_134_1 and "levelEasy" or "level"
	local var_134_1 = lua_battle.configDict[arg_134_0]

	if not var_134_1 then
		return 0
	end

	local var_134_2 = {}
	local var_134_3 = {}
	local var_134_4
	local var_134_5

	for iter_134_0, iter_134_1 in ipairs(FightStrUtil.instance:getSplitToNumberCache(var_134_1.monsterGroupIds, "#")) do
		local var_134_6 = lua_monster_group.configDict[iter_134_1].bossId
		local var_134_7 = FightStrUtil.instance:getSplitToNumberCache(lua_monster_group.configDict[iter_134_1].monster, "#")

		for iter_134_2, iter_134_3 in ipairs(var_134_7) do
			if var_0_0.isBossId(var_134_6, iter_134_3) then
				table.insert(var_134_3, iter_134_3)
			else
				table.insert(var_134_2, iter_134_3)
			end
		end
	end

	if #var_134_3 > 0 then
		return lua_monster.configDict[var_134_3[1]][var_134_0]
	elseif #var_134_2 > 0 then
		local var_134_8 = 0

		for iter_134_4, iter_134_5 in ipairs(var_134_2) do
			var_134_8 = var_134_8 + lua_monster.configDict[iter_134_5][var_134_0]
		end

		return math.ceil(var_134_8 / #var_134_2)
	else
		return 0
	end
end

function var_0_0.initBuildSceneAndLevelHandle()
	if var_0_0.buildSceneAndLevelHandleDict then
		return
	end

	var_0_0.buildSceneAndLevelHandleDict = {
		[DungeonEnum.EpisodeType.Cachot] = var_0_0.buildCachotSceneAndLevel,
		[DungeonEnum.EpisodeType.Rouge] = var_0_0.buildRougeSceneAndLevel
	}
end

function var_0_0.buildDefaultSceneAndLevel(arg_136_0, arg_136_1)
	local var_136_0 = {}
	local var_136_1 = {}
	local var_136_2 = lua_battle.configDict[arg_136_1].sceneIds
	local var_136_3 = string.splitToNumber(var_136_2, "#")

	for iter_136_0, iter_136_1 in ipairs(var_136_3) do
		local var_136_4 = SceneConfig.instance:getSceneLevelCOs(iter_136_1)[1].id

		table.insert(var_136_0, iter_136_1)
		table.insert(var_136_1, var_136_4)
	end

	return var_136_0, var_136_1
end

function var_0_0.buildCachotSceneAndLevel(arg_137_0, arg_137_1)
	local var_137_0 = 0
	local var_137_1 = V1a6_CachotRoomModel.instance:getNowBattleEventMo()

	if var_137_1 and lua_rogue_event_fight.configDict[var_137_1:getEventCo().eventId].isChangeScene ~= 1 then
		var_137_0 = V1a6_CachotModel.instance:getRogueInfo().layer
	end

	if var_137_0 > 0 then
		local var_137_2 = V1a6_CachotEventConfig.instance:getSceneIdByLayer(var_137_0)

		if var_137_2 then
			local var_137_3 = {}
			local var_137_4 = {}

			table.insert(var_137_3, var_137_2.sceneId)
			table.insert(var_137_4, var_137_2.levelId)

			return var_137_3, var_137_4
		else
			logError("肉鸽战斗场景配置不存在" .. var_137_0)

			return var_0_0.buildDefaultSceneAndLevel(arg_137_0, arg_137_1)
		end
	else
		return var_0_0.buildDefaultSceneAndLevel(arg_137_0, arg_137_1)
	end
end

function var_0_0.buildRougeSceneAndLevel(arg_138_0, arg_138_1)
	local var_138_0 = RougeMapModel.instance:getCurEvent()
	local var_138_1 = var_138_0 and var_138_0.type
	local var_138_2 = RougeMapHelper.isFightEvent(var_138_1) and lua_rouge_fight_event.configDict[var_138_0.id]

	if var_138_2 and var_138_2.isChangeScene == 1 then
		local var_138_3 = RougeMapModel.instance:getLayerCo()
		local var_138_4 = var_138_3 and var_138_3.sceneId
		local var_138_5 = var_138_3 and var_138_3.levelId

		if var_138_4 ~= 0 and var_138_5 ~= 0 then
			return {
				var_138_4
			}, {
				var_138_5
			}
		end

		logError(string.format("layerId : %s, config Incorrect, sceneId : %s, levelId : %s", var_138_3 and var_138_3.id, var_138_4, var_138_5))

		return var_0_0.buildDefaultSceneAndLevel(arg_138_0, arg_138_1)
	else
		return var_0_0.buildDefaultSceneAndLevel(arg_138_0, arg_138_1)
	end
end

function var_0_0.buildSceneAndLevel(arg_139_0, arg_139_1)
	var_0_0.initBuildSceneAndLevelHandle()

	local var_139_0 = lua_episode.configDict[arg_139_0]
	local var_139_1 = var_139_0 and var_0_0.buildSceneAndLevelHandleDict[var_139_0.type]

	var_139_1 = var_139_1 or var_0_0.buildDefaultSceneAndLevel

	return var_139_1(arg_139_0, arg_139_1)
end

function var_0_0.getStressStatus(arg_140_0)
	if not arg_140_0 then
		logError("stress is nil")

		return FightEnum.Status.Positive
	end

	for iter_140_0 = 1, 2 do
		if arg_140_0 <= FightEnum.StressThreshold[iter_140_0] then
			return iter_140_0
		end
	end

	return nil
end

function var_0_0.getResistanceKeyById(arg_141_0)
	if not var_0_0.resistanceId2KeyDict then
		var_0_0.resistanceId2KeyDict = {}

		for iter_141_0, iter_141_1 in pairs(FightEnum.Resistance) do
			var_0_0.resistanceId2KeyDict[iter_141_1] = iter_141_0
		end
	end

	return var_0_0.resistanceId2KeyDict[arg_141_0]
end

function var_0_0.canAddPoint(arg_142_0)
	if not arg_142_0 then
		return false
	end

	if arg_142_0:hasBuffFeature(FightEnum.BuffType_TransferAddExPoint) then
		return false
	end

	if arg_142_0:hasBuffFeature(FightEnum.ExPointCantAdd) then
		return false
	end

	return true
end

function var_0_0.getEntityName(arg_143_0)
	local var_143_0 = arg_143_0 and arg_143_0:getMO()
	local var_143_1 = var_143_0 and var_143_0:getEntityName()

	return tostring(var_143_1)
end

function var_0_0.getEntityById(arg_144_0)
	local var_144_0 = var_0_0.getEntity(arg_144_0)

	return var_0_0.getEntityName(var_144_0)
end

function var_0_0.isSameCardMo(arg_145_0, arg_145_1)
	if arg_145_0 == arg_145_1 then
		return true
	end

	if not arg_145_0 or not arg_145_1 then
		return false
	end

	return arg_145_0.clientData.custom_enemyCardIndex == arg_145_1.clientData.custom_enemyCardIndex
end

function var_0_0.getAssitHeroInfoByUid(arg_146_0, arg_146_1)
	local var_146_0 = FightDataHelper.entityMgr:getById(arg_146_0)

	if var_146_0 and var_146_0:isCharacter() then
		local var_146_1 = HeroConfig.instance:getHeroCO(var_146_0.modelId)

		return {
			skin = var_146_0.skin,
			level = var_146_0.level,
			config = var_146_1
		}
	end
end

function var_0_0.canSelectEnemyEntity(arg_147_0)
	if not arg_147_0 then
		return false
	end

	local var_147_0 = FightDataHelper.entityMgr:getById(arg_147_0)

	if not var_147_0 then
		return false
	end

	if var_147_0.side == FightEnum.EntitySide.MySide then
		return false
	end

	if var_147_0:hasBuffFeature(FightEnum.BuffType_CantSelect) then
		return false
	end

	if var_147_0:hasBuffFeature(FightEnum.BuffType_CantSelectEx) then
		return false
	end

	return true
end

function var_0_0.clearNoUseEffect()
	local var_148_0 = FightEffectPool.releaseUnuseEffect()

	for iter_148_0, iter_148_1 in pairs(var_148_0) do
		FightPreloadController.instance:releaseAsset(iter_148_0)
	end

	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC)
end

function var_0_0.isASFDSkill(arg_149_0)
	return arg_149_0 == FightASFDConfig.instance.skillId
end

function var_0_0.isPreDeleteSkill(arg_150_0)
	local var_150_0 = arg_150_0 and lua_skill.configDict[arg_150_0]

	return var_150_0 and var_150_0.icon == FightEnum.CardIconId.PreDelete
end

function var_0_0.getASFDMgr()
	local var_151_0 = GameSceneMgr.instance:getCurScene()
	local var_151_1 = var_151_0 and var_151_0.mgr

	return var_151_1 and var_151_1:getASFDMgr()
end

function var_0_0.getEntityCareer(arg_152_0)
	local var_152_0 = arg_152_0 and FightDataHelper.entityMgr:getById(arg_152_0)

	return var_152_0 and var_152_0:getCareer() or 0
end

function var_0_0.isRestrain(arg_153_0, arg_153_1)
	local var_153_0 = var_0_0.getEntityCareer(arg_153_0)
	local var_153_1 = var_0_0.getEntityCareer(arg_153_1)

	return (FightConfig.instance:getRestrain(var_153_0, var_153_1) or 1000) > 1000
end

var_0_0.tempEntityMoList = {}

function var_0_0.hasSkinId(arg_154_0)
	local var_154_0 = var_0_0.tempEntityMoList

	tabletool.clear(var_154_0)

	local var_154_1 = FightDataHelper.entityMgr:getMyNormalList(var_154_0)

	for iter_154_0, iter_154_1 in ipairs(var_154_1) do
		if iter_154_1.originSkin == arg_154_0 then
			return true
		end
	end

	return false
end

function var_0_0.getBloodPoolSkillId()
	return tonumber(lua_fight_xcjl_const.configDict[4].value)
end

function var_0_0.isBloodPoolSkill(arg_156_0)
	return arg_156_0 == var_0_0.getBloodPoolSkillId()
end

return var_0_0
