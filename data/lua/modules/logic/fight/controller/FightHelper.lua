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

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.actEffectMOs) do
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

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.actEffectMOs) do
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

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.actEffectMOs) do
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

function var_0_0.processRoundStep(arg_31_0)
	local var_31_0 = {}

	for iter_31_0, iter_31_1 in ipairs(arg_31_0) do
		var_0_0.addRoundStep(var_31_0, iter_31_1)
	end

	return var_31_0
end

function var_0_0.addRoundStep(arg_32_0, arg_32_1)
	table.insert(arg_32_0, arg_32_1)
	var_0_0.detectStepEffect(arg_32_0, arg_32_1.actEffect)
end

function var_0_0.detectStepEffect(arg_33_0, arg_33_1)
	if arg_33_1 and #arg_33_1 > 0 then
		local var_33_0 = 1

		while arg_33_1[var_33_0] do
			local var_33_1 = arg_33_1[var_33_0]

			if var_33_1.effectType == FightEnum.EffectType.FIGHTSTEP then
				local var_33_2 = var_33_1.fightStep

				if var_33_2.actType == FightEnum.ActType.SKILL then
					if var_0_0.needAddRoundStep(var_33_2) then
						var_0_0.addRoundStep(arg_33_0, var_33_1.fightStep)
					else
						var_0_0.detectStepEffect(arg_33_0, var_33_2.actEffect)
					end
				elseif var_33_2.actType == FightEnum.ActType.CHANGEHERO then
					var_0_0.addRoundStep(arg_33_0, var_33_1.fightStep)
				elseif var_33_2.actType == FightEnum.ActType.CHANGEWAVE then
					var_0_0.addRoundStep(arg_33_0, var_33_1.fightStep)
				else
					var_0_0.detectStepEffect(arg_33_0, var_33_2.actEffect)
				end
			end

			var_33_0 = var_33_0 + 1
		end
	end
end

function var_0_0.needAddRoundStep(arg_34_0)
	if arg_34_0 then
		if var_0_0.isTimelineStep(arg_34_0) then
			return true
		elseif arg_34_0.actType == FightEnum.ActType.CHANGEHERO then
			return true
		elseif arg_34_0.actType == FightEnum.ActType.CHANGEWAVE then
			return true
		end
	end
end

function var_0_0.buildInfoMOs(arg_35_0, arg_35_1)
	local var_35_0 = {}

	for iter_35_0, iter_35_1 in ipairs(arg_35_0) do
		local var_35_1 = arg_35_1.New()

		var_35_1:init(iter_35_1)
		table.insert(var_35_0, var_35_1)
	end

	return var_35_0
end

function var_0_0.logForPCSkillEditor(arg_36_0)
	if not SkillEditorMgr.instance.inEditMode or SLFramework.FrameworkSettings.IsEditor then
		logNormal(arg_36_0)
	end
end

function var_0_0.getEffectLabel(arg_37_0, arg_37_1)
	if gohelper.isNil(arg_37_0) then
		return
	end

	local var_37_0 = arg_37_0:GetComponentsInChildren(typeof(ZProj.EffectLabel))

	if not var_37_0 or var_37_0.Length <= 0 then
		return
	end

	local var_37_1 = {}

	for iter_37_0 = 0, var_37_0.Length - 1 do
		local var_37_2 = var_37_0[iter_37_0]

		if not arg_37_1 or var_37_2.label == arg_37_1 then
			table.insert(var_37_1, var_37_2)
		end
	end

	return var_37_1
end

function var_0_0.shouUIPoisoningEffect(arg_38_0)
	if FightConfig.instance:hasBuffFeature(arg_38_0, FightEnum.BuffType_Dot) then
		local var_38_0 = lua_skill_buff.configDict[arg_38_0]

		if var_38_0 and lua_fight_buff_use_poison_ui_effect.configDict[var_38_0.typeId] then
			return true
		end
	end

	return false
end

function var_0_0.dealDirectActEffectData(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = var_0_0.filterActEffect(arg_39_0, arg_39_2)
	local var_39_1 = #var_39_0
	local var_39_2 = {}

	if var_39_0[arg_39_1] then
		var_39_2 = var_39_0[arg_39_1]
	elseif var_39_1 > 0 then
		var_39_2 = var_39_0[var_39_1]
	end

	return var_39_2
end

function var_0_0.filterActEffect(arg_40_0, arg_40_1)
	local var_40_0 = {}
	local var_40_1 = {}
	local var_40_2 = {}

	for iter_40_0, iter_40_1 in ipairs(arg_40_0) do
		local var_40_3 = iter_40_1
		local var_40_4 = false

		if var_40_3.effectType == FightEnum.EffectType.SHIELD and not var_0_0.checkShieldHit(var_40_3) then
			var_40_4 = true
		end

		if not var_40_4 and arg_40_1[iter_40_1.effectType] then
			if not var_40_1[iter_40_1.targetId] then
				var_40_1[iter_40_1.targetId] = {}

				table.insert(var_40_2, iter_40_1.targetId)
			end

			table.insert(var_40_1[iter_40_1.targetId], iter_40_1)
		end
	end

	for iter_40_2, iter_40_3 in ipairs(var_40_2) do
		var_40_0[iter_40_2] = var_40_1[iter_40_3]
	end

	return var_40_0
end

function var_0_0.detectAttributeCounter()
	local var_41_0 = FightModel.instance:getFightParam()
	local var_41_1, var_41_2 = var_0_0.getAttributeCounter(var_41_0.monsterGroupIds, GameSceneMgr.instance:isSpScene())

	return var_41_1, var_41_2
end

function var_0_0.getAttributeCounter(arg_42_0, arg_42_1)
	local var_42_0
	local var_42_1 = {}

	for iter_42_0, iter_42_1 in ipairs(arg_42_0) do
		if not string.nilorempty(lua_monster_group.configDict[iter_42_1].bossId) then
			local var_42_2 = lua_monster_group.configDict[iter_42_1].bossId
		end

		local var_42_3 = FightStrUtil.instance:getSplitToNumberCache(lua_monster_group.configDict[iter_42_1].monster, "#")

		for iter_42_2, iter_42_3 in ipairs(var_42_3) do
			if not lua_monster.configDict[iter_42_3] then
				logError("怪物表找不到id:" .. iter_42_3)
			end

			local var_42_4 = lua_monster.configDict[iter_42_3].career

			if var_42_4 ~= 5 and var_42_4 ~= 6 then
				var_42_1[var_42_4] = (var_42_1[var_42_4] or 0) + 1

				if var_0_0.isBossId(lua_monster_group.configDict[iter_42_1].bossId, iter_42_3) then
					var_42_1[var_42_4] = (var_42_1[var_42_4] or 0) + 1
				end
			end
		end
	end

	local var_42_5 = {}
	local var_42_6 = {}

	if arg_42_1 then
		return var_42_5, var_42_6
	end

	if #var_42_5 == 0 then
		local var_42_7 = 0
		local var_42_8 = 0
		local var_42_9 = {}
		local var_42_10 = {}

		for iter_42_4, iter_42_5 in pairs(var_42_1) do
			if iter_42_5 >= 2 then
				var_42_7 = var_42_7 + 1

				table.insert(var_42_10, iter_42_4)
			else
				var_42_8 = var_42_8 + 1

				table.insert(var_42_9, iter_42_4)
			end
		end

		if var_42_7 == 1 then
			table.insert(var_42_5, FightConfig.instance:restrainedBy(var_42_10[1]))
			table.insert(var_42_6, FightConfig.instance:restrained(var_42_10[1]))
		elseif var_42_7 == 2 then
			if var_0_0.checkHadRestrain(var_42_10[1], var_42_10[2]) then
				table.insert(var_42_5, FightConfig.instance:restrainedBy(var_42_10[1]))
				table.insert(var_42_5, FightConfig.instance:restrainedBy(var_42_10[2]))
				table.insert(var_42_6, FightConfig.instance:restrained(var_42_10[1]))
				table.insert(var_42_6, FightConfig.instance:restrained(var_42_10[2]))
			end
		elseif var_42_7 == 0 then
			if var_42_8 == 1 then
				table.insert(var_42_5, FightConfig.instance:restrainedBy(var_42_9[1]))
				table.insert(var_42_6, FightConfig.instance:restrained(var_42_9[1]))
			elseif var_42_8 == 2 and var_0_0.checkHadRestrain(var_42_9[1], var_42_9[2]) then
				table.insert(var_42_5, FightConfig.instance:restrainedBy(var_42_9[1]))
				table.insert(var_42_5, FightConfig.instance:restrainedBy(var_42_9[2]))
				table.insert(var_42_6, FightConfig.instance:restrained(var_42_9[1]))
				table.insert(var_42_6, FightConfig.instance:restrained(var_42_9[2]))
			end
		end
	end

	for iter_42_6 = #var_42_6, 1, -1 do
		if tabletool.indexOf(var_42_5, var_42_6[1]) then
			table.remove(var_42_6, iter_42_6)
		end
	end

	return var_42_5, var_42_6
end

function var_0_0.checkHadRestrain(arg_43_0, arg_43_1)
	return FightConfig.instance:getRestrain(arg_43_0, arg_43_1) > 1000 or FightConfig.instance:getRestrain(arg_43_1, arg_43_0) > 1000
end

function var_0_0.setMonsterGuideFocusState(arg_44_0)
	local var_44_0 = FightWorkSkillOrBuffFocusMonster.getPlayerPrefKey(arg_44_0)

	PlayerPrefsHelper.setNumber(var_44_0, 1)

	if not string.nilorempty(arg_44_0.completeWithGroup) then
		local var_44_1 = FightStrUtil.instance:getSplitCache(arg_44_0.completeWithGroup, "|")

		for iter_44_0, iter_44_1 in ipairs(var_44_1) do
			local var_44_2 = FightStrUtil.instance:getSplitToNumberCache(iter_44_1, "#")
			local var_44_3 = FightConfig.instance:getMonsterGuideFocusConfig(var_44_2[1], var_44_2[2], var_44_2[3], var_44_2[4])

			if var_44_3 then
				local var_44_4 = FightWorkSkillOrBuffFocusMonster.getPlayerPrefKey(var_44_3)

				PlayerPrefsHelper.setNumber(var_44_4, 1)
			else
				logError("怪物指引图表找不到id：", var_44_2[1], var_44_2[2], var_44_2[3], var_44_2[4])
			end
		end
	end
end

function var_0_0.detectTimelinePlayEffectCondition(arg_45_0, arg_45_1, arg_45_2)
	if string.nilorempty(arg_45_1) or arg_45_1 == "0" then
		return true
	end

	if arg_45_1 == "1" then
		local var_45_0 = false

		for iter_45_0, iter_45_1 in pairs(arg_45_0.actEffectMOs) do
			if iter_45_1.effectType == FightEnum.EffectType.DEAD then
				var_45_0 = true
			end
		end

		return var_45_0
	end

	local var_45_1 = FightStrUtil.instance:getSplitToNumberCache(arg_45_1, "#")

	if var_45_1[1] == 2 then
		for iter_45_2, iter_45_3 in ipairs(arg_45_0.actEffectMOs) do
			if iter_45_3.effectType == FightEnum.EffectType.MISS or iter_45_3.effectType == FightEnum.EffectType.DAMAGE or iter_45_3.effectType == FightEnum.EffectType.CRIT or iter_45_3.effectType == FightEnum.EffectType.SHIELD then
				local var_45_2 = var_0_0.getEntity(iter_45_3.targetId)

				for iter_45_4 = 2, #var_45_1 do
					if arg_45_2 then
						if arg_45_2 == var_45_2 and var_0_0.detectEntityIncludeBuffType(var_45_2, var_45_1[iter_45_4]) then
							return true
						end
					elseif var_0_0.detectEntityIncludeBuffType(var_45_2, var_45_1[iter_45_4]) then
						return true
					end
				end
			end
		end
	end

	if var_45_1[1] == 3 then
		local var_45_3 = var_0_0.getEntity(arg_45_0.fromId)

		if var_45_3 then
			for iter_45_5 = 2, #var_45_1 do
				if var_0_0.detectEntityIncludeBuffType(var_45_3, var_45_1[iter_45_5]) then
					return true
				end
			end
		end
	end

	if var_45_1[1] == 4 then
		for iter_45_6, iter_45_7 in ipairs(arg_45_0.actEffectMOs) do
			if iter_45_7.effectType == FightEnum.EffectType.MISS or iter_45_7.effectType == FightEnum.EffectType.DAMAGE or iter_45_7.effectType == FightEnum.EffectType.CRIT or iter_45_7.effectType == FightEnum.EffectType.SHIELD then
				local var_45_4 = var_0_0.getEntity(iter_45_7.targetId)

				for iter_45_8 = 2, #var_45_1 do
					if arg_45_2 then
						if arg_45_2 == var_45_4 and arg_45_2.buff and arg_45_2.buff:haveBuffId(var_45_1[iter_45_8]) then
							return true
						end
					elseif var_45_4.buff and var_45_4.buff:haveBuffId(var_45_1[iter_45_8]) then
						return true
					end
				end
			end
		end
	end

	if var_45_1[1] == 5 then
		local var_45_5 = var_0_0.getEntity(arg_45_0.fromId)

		if var_45_5 and var_45_5.buff then
			for iter_45_9 = 2, #var_45_1 do
				if var_45_5.buff:haveBuffId(var_45_1[iter_45_9]) then
					return true
				end
			end
		end
	end

	if var_45_1[1] == 6 then
		for iter_45_10, iter_45_11 in ipairs(arg_45_0.actEffectMOs) do
			if iter_45_11.effectType == FightEnum.EffectType.MISS or iter_45_11.effectType == FightEnum.EffectType.DAMAGE or iter_45_11.effectType == FightEnum.EffectType.CRIT or iter_45_11.effectType == FightEnum.EffectType.SHIELD then
				local var_45_6 = var_0_0.getEntity(iter_45_11.targetId)

				for iter_45_12 = 2, #var_45_1 do
					if arg_45_2 then
						if arg_45_2 == var_45_6 then
							local var_45_7 = arg_45_2:getMO()

							if var_45_7 and var_45_7.skin == var_45_1[iter_45_12] then
								return true
							end
						end
					else
						local var_45_8 = var_45_6:getMO()

						if var_45_8 and var_45_8.skin == var_45_1[iter_45_12] then
							return true
						end
					end
				end
			end
		end
	end

	if var_45_1[1] == 7 then
		for iter_45_13, iter_45_14 in ipairs(arg_45_0.actEffectMOs) do
			if iter_45_14.targetId == arg_45_0.fromId and iter_45_14.configEffect == var_45_1[2] then
				if iter_45_14.configEffect == 30011 then
					if iter_45_14.effectNum ~= 0 then
						return true
					end
				else
					return true
				end
			end
		end
	end

	if var_45_1[1] == 8 then
		for iter_45_15, iter_45_16 in ipairs(arg_45_0.actEffectMOs) do
			if iter_45_16.targetId ~= arg_45_0.fromId and iter_45_16.configEffect == var_45_1[2] then
				if iter_45_16.configEffect == 30011 then
					if iter_45_16.effectNum ~= 0 then
						return true
					end
				else
					return true
				end
			end
		end
	end

	if var_45_1[1] == 9 then
		local var_45_9 = var_0_0.getEntity(arg_45_0.fromId)

		if var_45_9 and var_45_9.buff then
			for iter_45_17 = 2, #var_45_1 do
				if var_45_9.buff:haveBuffId(var_45_1[iter_45_17]) then
					return false
				end
			end

			return true
		end
	elseif var_45_1[1] == 10 then
		local var_45_10 = arg_45_0.playerOperationCountForPlayEffectTimeline

		if var_45_10 and var_45_1[2] == var_45_10 then
			return true
		end
	elseif var_45_1[1] == 11 then
		local var_45_11 = var_45_1[2]
		local var_45_12 = var_45_1[3]
		local var_45_13 = FightDataHelper.entityMgr:getById(arg_45_0.fromId)

		if var_45_13 then
			local var_45_14 = var_45_13:getPowerInfo(FightEnum.PowerType.Power)

			if var_45_14 then
				if var_45_11 == 1 then
					return var_45_12 < var_45_14.num
				elseif var_45_11 == 2 then
					return var_45_12 > var_45_14.num
				elseif var_45_11 == 3 then
					return var_45_14.num == var_45_12
				elseif var_45_11 == 4 then
					return var_45_12 <= var_45_14.num
				elseif var_45_11 == 5 then
					return var_45_12 >= var_45_14.num
				end
			end
		end
	end

	return false
end

function var_0_0.detectEntityIncludeBuffType(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = arg_46_0 and arg_46_0:getMO()

	arg_46_2 = arg_46_2 or var_46_0 and var_46_0:getBuffList() or {}

	for iter_46_0, iter_46_1 in ipairs(arg_46_2) do
		local var_46_1 = lua_skill_buff.configDict[iter_46_1.buffId]

		if arg_46_1 == lua_skill_bufftype.configDict[var_46_1.typeId].type then
			return true
		end
	end
end

function var_0_0.hideDefenderBuffEffect(arg_47_0, arg_47_1)
	local var_47_0 = lua_skin_monster_hide_buff_effect.configDict[arg_47_0.actId]
	local var_47_1 = {}

	if var_47_0 then
		local var_47_2 = {}
		local var_47_3

		if var_47_0.effectName == "all" then
			var_47_3 = true
		end

		local var_47_4 = FightStrUtil.instance:getSplitCache(var_47_0.effectName, "#")
		local var_47_5 = var_0_0.getDefenders(arg_47_0, true)
		local var_47_6 = {}

		for iter_47_0, iter_47_1 in ipairs(var_47_5) do
			if not var_47_6[iter_47_1.id] then
				var_47_6[iter_47_1.id] = true

				if var_0_0.isAssembledMonster(iter_47_1) then
					local var_47_7 = var_0_0.getSideEntitys(iter_47_1:getSide())

					for iter_47_2, iter_47_3 in ipairs(var_47_7) do
						if var_0_0.isAssembledMonster(iter_47_3) and not var_47_6[iter_47_3.id] then
							var_47_6[iter_47_3.id] = true

							table.insert(var_47_5, iter_47_3)
						end
					end
				end
			end
		end

		for iter_47_4, iter_47_5 in ipairs(var_47_5) do
			if var_47_3 then
				local var_47_8 = iter_47_5.skinSpineEffect

				if var_47_8 then
					var_47_1[iter_47_5.id] = iter_47_5.id

					if var_47_8._effectWrapDict then
						for iter_47_6, iter_47_7 in pairs(var_47_8._effectWrapDict) do
							table.insert(var_47_2, iter_47_7)
						end
					end
				end
			end

			local var_47_9 = iter_47_5.buff and iter_47_5.buff._buffEffectDict

			if var_47_9 then
				for iter_47_8, iter_47_9 in pairs(var_47_9) do
					if var_47_3 then
						var_47_1[iter_47_5.id] = iter_47_5.id

						table.insert(var_47_2, iter_47_9)
					else
						for iter_47_10, iter_47_11 in ipairs(var_47_4) do
							if var_0_0.getEffectUrlWithLod(iter_47_11) == iter_47_9.path then
								var_47_1[iter_47_5.id] = iter_47_5.id

								table.insert(var_47_2, iter_47_9)
							end
						end
					end
				end
			end
		end

		local var_47_10 = FightStrUtil.instance:getSplitCache(var_47_0.exceptEffect, "#")
		local var_47_11 = {}

		for iter_47_12, iter_47_13 in ipairs(var_47_10) do
			var_47_11[var_0_0.getEffectUrlWithLod(iter_47_13)] = true
		end

		for iter_47_14, iter_47_15 in ipairs(var_47_2) do
			local var_47_12 = var_47_2[iter_47_14]

			if not var_47_11[var_47_12.path] then
				var_47_12:setActive(false, arg_47_1)
			end
		end
	end

	return var_47_1
end

function var_0_0.revertDefenderBuffEffect(arg_48_0, arg_48_1)
	for iter_48_0, iter_48_1 in ipairs(arg_48_0) do
		local var_48_0 = var_0_0.getEntity(iter_48_1)

		if var_48_0 then
			if var_48_0.buff then
				var_48_0.buff:showBuffEffects(arg_48_1)
			end

			if var_48_0.skinSpineEffect then
				var_48_0.skinSpineEffect:showEffects(arg_48_1)
			end
		end
	end
end

function var_0_0.getEffectAbPath(arg_49_0)
	if GameResMgr.IsFromEditorDir or string.find(arg_49_0, "/buff/") then
		return arg_49_0
	else
		return SLFramework.FileHelper.GetUnityPath(System.IO.Path.GetDirectoryName(arg_49_0))
	end
end

function var_0_0.getRolesTimelinePath(arg_50_0)
	if GameResMgr.IsFromEditorDir then
		return ResUrl.getSkillTimeline(arg_50_0)
	else
		return ResUrl.getRolesTimeline()
	end
end

function var_0_0.getCameraAniPath(arg_51_0)
	if GameResMgr.IsFromEditorDir then
		return ResUrl.getCameraAnim(arg_51_0)
	else
		return ResUrl.getCameraAnimABUrl()
	end
end

function var_0_0.getEntityAniPath(arg_52_0)
	if GameResMgr.IsFromEditorDir then
		return ResUrl.getEntityAnim(arg_52_0)
	else
		return ResUrl.getEntityAnimABUrl()
	end
end

function var_0_0.refreshCombinativeMonsterScaleAndPos(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_0:getMO()

	if not var_53_0 then
		return
	end

	local var_53_1 = FightConfig.instance:getSkinCO(var_53_0.skin)

	if var_53_1 and var_53_1.canHide == 1 then
		-- block empty
	else
		return
	end

	local var_53_2 = var_0_0.getSideEntitys(arg_53_0:getSide())
	local var_53_3

	for iter_53_0, iter_53_1 in ipairs(var_53_2) do
		iter_53_1:setScale(arg_53_1)

		local var_53_4 = iter_53_1:getMO()

		if var_53_4 then
			local var_53_5 = FightConfig.instance:getSkinCO(var_53_4.skin)

			if var_53_5 and var_53_5.mainBody == 1 then
				var_53_3 = iter_53_1
			end
		end
	end

	if var_53_3 then
		local var_53_6, var_53_7, var_53_8 = var_0_0.getEntityStandPos(var_53_3:getMO())
		local var_53_9, var_53_10, var_53_11 = transformhelper.getPos(var_53_3.go.transform)

		for iter_53_2, iter_53_3 in ipairs(var_53_2) do
			if iter_53_3 ~= var_53_3 then
				local var_53_12, var_53_13, var_53_14 = var_0_0.getEntityStandPos(iter_53_3:getMO())
				local var_53_15 = var_53_12 - var_53_6
				local var_53_16 = var_53_13 - var_53_7
				local var_53_17 = var_53_14 - var_53_8

				transformhelper.setPos(iter_53_3.go.transform, var_53_15 * arg_53_1 + var_53_9, var_53_16 * arg_53_1 + var_53_10, var_53_17 * arg_53_1 + var_53_11)
			end
		end
	end
end

function var_0_0.getEntityDefaultIdleAniName(arg_54_0)
	local var_54_0 = arg_54_0:getMO()

	if var_54_0 and var_54_0.modelId == 3025 then
		local var_54_1 = var_0_0.getSideEntitys(arg_54_0:getSide(), true)

		for iter_54_0, iter_54_1 in ipairs(var_54_1) do
			if iter_54_1:getMO().modelId == 3028 then
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

function var_0_0.preloadXingTiSpecialUrl(arg_55_0)
	if var_0_0.isShowTogether(FightEnum.EntitySide.MySide, {
		3025,
		3028
	}) then
		for iter_55_0, iter_55_1 in ipairs(arg_55_0) do
			if iter_55_1 == 3025 then
				return 2
			end
		end

		return 1
	end
end

function var_0_0.detectXingTiSpecialUrl(arg_56_0)
	if arg_56_0:isMySide() then
		local var_56_0 = arg_56_0:getSide()

		return var_0_0.isShowTogether(var_56_0, {
			3025,
			3028
		})
	end
end

function var_0_0.isShowTogether(arg_57_0, arg_57_1)
	local var_57_0 = FightDataHelper.entityMgr:getSideList(arg_57_0)
	local var_57_1 = 0

	for iter_57_0, iter_57_1 in ipairs(var_57_0) do
		if tabletool.indexOf(arg_57_1, iter_57_1.modelId) then
			var_57_1 = var_57_1 + 1
		end
	end

	if var_57_1 == #arg_57_1 then
		return true
	end
end

function var_0_0.getPredeductionExpoint(arg_58_0)
	local var_58_0 = 0

	if FightModel.instance:getCurStage() == FightEnum.Stage.Card then
		local var_58_1 = var_0_0.getEntity(arg_58_0)

		if var_58_1 then
			local var_58_2 = var_58_1:getMO()
			local var_58_3 = FightCardModel.instance:getCardOps()

			for iter_58_0, iter_58_1 in ipairs(var_58_3) do
				if arg_58_0 == iter_58_1.belongToEntityId and iter_58_1:isPlayCard() and var_58_2:isUniqueSkill(iter_58_1.skillId) then
					var_58_0 = var_58_0 + var_58_2:getUniqueSkillPoint()
				end
			end
		end
	end

	return var_58_0
end

function var_0_0.setBossSkillSpeed(arg_59_0)
	local var_59_0 = var_0_0.getEntity(arg_59_0)
	local var_59_1 = var_59_0 and var_59_0:getMO()

	if var_59_1 then
		local var_59_2 = lua_monster_skin.configDict[var_59_1.skin]

		if var_59_2 and var_59_2.bossSkillSpeed == 1 then
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

function var_0_0.setTimelineExclusiveSpeed(arg_61_0)
	local var_61_0 = lua_fight_timeline_speed.configDict[arg_61_0]

	if var_61_0 then
		local var_61_1 = FightModel.instance:getUserSpeed()
		local var_61_2 = FightStrUtil.instance:getSplitToNumberCache(var_61_0.speed, "#")

		FightModel.instance.useExclusiveSpeed = var_61_2[var_61_1]

		FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	end
end

function var_0_0.cancelExclusiveSpeed()
	if FightModel.instance.useExclusiveSpeed then
		FightModel.instance.useExclusiveSpeed = false

		FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	end
end

function var_0_0.needPlayTransitionAni(arg_63_0, arg_63_1)
	local var_63_0 = arg_63_0 and arg_63_0:getMO()

	if var_63_0 then
		local var_63_1 = var_63_0.skin
		local var_63_2 = lua_fight_transition_act.configDict[var_63_1]

		if var_63_2 then
			local var_63_3 = arg_63_0.spine:getAnimState()

			if var_63_2[var_63_3] and var_63_2[var_63_3][arg_63_1] then
				return true, var_63_2[var_63_3][arg_63_1].transitionAct
			end
		end
	end
end

function var_0_0._stepBuffDealStackedBuff(arg_64_0, arg_64_1, arg_64_2, arg_64_3)
	local var_64_0 = false

	if arg_64_3 then
		local var_64_1 = arg_64_3._actEffectMO

		if var_64_1 and not FightSkillBuffMgr.instance:hasPlayBuff(var_64_1) then
			local var_64_2 = lua_skill_buff.configDict[var_64_1.buff.buffId]

			if var_64_2 and var_64_2.id == arg_64_2.id and var_64_1.effectType == FightEnum.EffectType.BUFFADD then
				var_64_0 = true
			end
		end
	end

	table.insert(arg_64_1, FunctionWork.New(function()
		local var_65_0 = var_0_0.getEntity(arg_64_0)

		if var_65_0 then
			var_65_0.buff.lockFloat = var_64_0
		end
	end))
	table.insert(arg_64_1, WorkWaitSeconds.New(0.01))
end

function var_0_0.hideAllEntity()
	local var_66_0 = var_0_0.getAllEntitys()

	for iter_66_0, iter_66_1 in ipairs(var_66_0) do
		iter_66_1:setActive(false, true)
		iter_66_1:setVisibleByPos(false)
		iter_66_1:setAlpha(0, 0)
	end
end

function var_0_0.isBossId(arg_67_0, arg_67_1)
	local var_67_0 = FightStrUtil.instance:getSplitToNumberCache(arg_67_0, "#")

	for iter_67_0, iter_67_1 in ipairs(var_67_0) do
		if arg_67_1 == iter_67_1 then
			return true
		end
	end
end

function var_0_0.getCurBossId()
	local var_68_0 = FightModel.instance:getCurMonsterGroupId()
	local var_68_1 = var_68_0 and lua_monster_group.configDict[var_68_0]

	return var_68_1 and not string.nilorempty(var_68_1.bossId) and var_68_1.bossId or nil
end

function var_0_0.setEffectEntitySide(arg_69_0)
	local var_69_0 = arg_69_0.targetId

	if var_69_0 == FightEntityScene.MySideId then
		arg_69_0.entityMO.side = FightEnum.EntitySide.MySide

		return
	elseif var_69_0 == FightEntityScene.EnemySideId then
		arg_69_0.entityMO.side = FightEnum.EntitySide.EnemySide

		return
	end

	local var_69_1 = FightDataHelper.entityMgr:getById(var_69_0)

	if var_69_1 and arg_69_0.entityMO then
		arg_69_0.entityMO.side = var_69_1.side
	end
end

function var_0_0.preloadZongMaoShaLiMianJu(arg_70_0, arg_70_1)
	local var_70_0 = var_0_0.getZongMaoShaLiMianJuPath(arg_70_0)

	if var_70_0 then
		table.insert(arg_70_1, var_70_0)
	end
end

function var_0_0.setZongMaoShaLiMianJuSpineUrl(arg_71_0, arg_71_1)
	local var_71_0 = var_0_0.getZongMaoShaLiMianJuPath(arg_71_0)

	if var_71_0 then
		arg_71_1[var_71_0] = true
	end
end

function var_0_0.getZongMaoShaLiMianJuPath(arg_72_0)
	local var_72_0 = lua_skin.configDict[arg_72_0]

	if var_72_0 and var_72_0.characterId == 3072 then
		local var_72_1 = string.format("roles/v1a3_%d_zongmaoshali_m/%d_zongmaoshali_m_fight.prefab", arg_72_0, arg_72_0)

		if var_72_0.id == 307203 then
			var_72_1 = "roles/v2a2_307203_zmsl_m/307203_zmsl_m_fight.prefab"
		end

		return var_72_1
	end
end

function var_0_0.getEnemyEntityByMonsterId(arg_73_0)
	local var_73_0 = var_0_0.getSideEntitys(FightEnum.EntitySide.EnemySide)

	for iter_73_0, iter_73_1 in ipairs(var_73_0) do
		local var_73_1 = iter_73_1:getMO()

		if var_73_1 and var_73_1.modelId == arg_73_0 then
			return iter_73_1
		end
	end
end

function var_0_0.sortAssembledMonster(arg_74_0)
	local var_74_0 = arg_74_0:getByIndex(1)

	if var_74_0 and lua_fight_assembled_monster.configDict[var_74_0.skin] then
		arg_74_0:sort(var_0_0.sortAssembledMonsterFunc)
	end
end

function var_0_0.sortAssembledMonsterFunc(arg_75_0, arg_75_1)
	local var_75_0 = arg_75_0 and lua_fight_assembled_monster.configDict[arg_75_0.skin]
	local var_75_1 = arg_75_1 and lua_fight_assembled_monster.configDict[arg_75_1.skin]

	if var_75_0 and not var_75_1 then
		return true
	elseif not var_75_0 and var_75_1 then
		return false
	elseif var_75_0 and var_75_1 then
		return var_75_0.part < var_75_1.part
	else
		return tonumber(arg_75_0.id) > tonumber(arg_75_1.id)
	end
end

function var_0_0.sortBuffReplaceSpineActConfig(arg_76_0, arg_76_1)
	return arg_76_0.priority > arg_76_1.priority
end

function var_0_0.processEntityActionName(arg_77_0, arg_77_1, arg_77_2)
	if not arg_77_1 then
		return
	end

	local var_77_0 = arg_77_0:getMO()

	if var_77_0 then
		local var_77_1 = lua_fight_buff_replace_spine_act.configDict[var_77_0.skin]

		if var_77_1 then
			local var_77_2 = {}

			for iter_77_0, iter_77_1 in pairs(var_77_1) do
				for iter_77_2, iter_77_3 in pairs(iter_77_1) do
					table.insert(var_77_2, iter_77_3)
				end
			end

			table.sort(var_77_2, var_0_0.sortBuffReplaceSpineActConfig)

			local var_77_3 = arg_77_0.buff

			if var_77_3 then
				for iter_77_4, iter_77_5 in ipairs(var_77_2) do
					if var_77_3:haveBuffId(iter_77_5.buffId) then
						local var_77_4 = 0

						for iter_77_6, iter_77_7 in ipairs(iter_77_5.combination) do
							if var_77_3:haveBuffId(iter_77_7) then
								var_77_4 = var_77_4 + 1
							end
						end

						if var_77_4 == #iter_77_5.combination and arg_77_0.spine and arg_77_0.spine:hasAnimation(arg_77_1 .. iter_77_5.suffix) then
							arg_77_1 = arg_77_1 .. iter_77_5.suffix

							break
						end
					end
				end
			end
		end
	end

	if arg_77_1 and var_77_0 then
		local var_77_5 = lua_fight_skin_special_behaviour.configDict[var_77_0.skin]

		if var_77_5 then
			local var_77_6 = arg_77_0.buff

			if var_77_6 then
				local var_77_7 = arg_77_1

				if string.find(var_77_7, "hit") then
					var_77_7 = "hit"
				end

				if not string.nilorempty(var_77_5[var_77_7]) then
					local var_77_8 = GameUtil.splitString2(var_77_5[var_77_7])

					for iter_77_8, iter_77_9 in ipairs(var_77_8) do
						local var_77_9 = tonumber(iter_77_9[1])

						if var_77_6:haveBuffId(var_77_9) then
							arg_77_1 = iter_77_9[2]
						end
					end
				end
			end
		end
	end

	if var_0_0.isAssembledMonster(arg_77_0) and arg_77_1 == "hit" then
		local var_77_10 = arg_77_0:getPartIndex()

		if arg_77_2 then
			for iter_77_10, iter_77_11 in ipairs(arg_77_2.actEffectMOs) do
				if FightTLEventDefHit.directCharacterHitEffectType[iter_77_11.effectType] and iter_77_11.targetId ~= arg_77_0.id then
					local var_77_11 = var_0_0.getEntity(iter_77_11.targetId)

					if isTypeOf(var_77_11, FightEntityAssembledMonsterMain) or isTypeOf(var_77_11, FightEntityAssembledMonsterSub) then
						return arg_77_1
					end
				end
			end
		end

		arg_77_1 = string.format("%s_part_%d", arg_77_1, var_77_10)
	end

	return arg_77_1
end

function var_0_0.getProcessEntityStancePos(arg_78_0)
	local var_78_0, var_78_1, var_78_2 = var_0_0.getEntityStandPos(arg_78_0)
	local var_78_3 = var_0_0.getEntity(arg_78_0.id)

	if var_78_3 and var_0_0.isAssembledMonster(var_78_3) then
		local var_78_4 = lua_fight_assembled_monster.configDict[arg_78_0.skin].virtualStance

		return var_78_0 + var_78_4[1], var_78_1 + var_78_4[2], var_78_2 + var_78_4[3]
	end

	return var_78_0, var_78_1, var_78_2
end

function var_0_0.isAssembledMonster(arg_79_0)
	if isTypeOf(arg_79_0, FightEntityAssembledMonsterMain) or isTypeOf(arg_79_0, FightEntityAssembledMonsterSub) then
		return true
	end
end

function var_0_0.getProcessEntitySpinePos(arg_80_0)
	local var_80_0, var_80_1, var_80_2 = transformhelper.getPos(arg_80_0.go.transform)

	if var_0_0.isAssembledMonster(arg_80_0) then
		local var_80_3 = arg_80_0:getMO()
		local var_80_4 = lua_fight_assembled_monster.configDict[var_80_3.skin]

		var_80_0 = var_80_0 + var_80_4.virtualStance[1]
		var_80_1 = var_80_1 + var_80_4.virtualStance[2]
		var_80_2 = var_80_2 + var_80_4.virtualStance[3]
	end

	return var_80_0, var_80_1, var_80_2
end

function var_0_0.getProcessEntitySpineLocalPos(arg_81_0)
	local var_81_0 = 0
	local var_81_1 = 0
	local var_81_2 = 0

	if var_0_0.isAssembledMonster(arg_81_0) then
		local var_81_3 = arg_81_0:getMO()
		local var_81_4 = lua_fight_assembled_monster.configDict[var_81_3.skin]

		var_81_0 = var_81_0 + var_81_4.virtualStance[1]
		var_81_1 = var_81_1 + var_81_4.virtualStance[2]
		var_81_2 = var_81_2 + var_81_4.virtualStance[3]
	end

	return var_81_0, var_81_1, var_81_2
end

local var_0_4 = {}

function var_0_0.getAssembledEffectPosOfSpineHangPointRoot(arg_82_0, arg_82_1)
	if var_0_4[arg_82_1] then
		return 0, 0, 0
	end

	return var_0_0.getProcessEntitySpineLocalPos(arg_82_0)
end

function var_0_0.processBuffEffectPath(arg_83_0, arg_83_1, arg_83_2, arg_83_3, arg_83_4)
	local var_83_0 = lua_fight_effect_buff_skin.configDict[arg_83_2]

	if var_83_0 then
		local var_83_1 = arg_83_1:getSide()

		if var_83_0[1] then
			var_83_1 = FightEnum.EntitySide.MySide == var_83_1 and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide
			var_83_0 = var_83_0[1]
		else
			var_83_0 = var_83_0[2]
		end

		local var_83_2 = var_0_0.getSideEntitys(var_83_1, true)

		for iter_83_0, iter_83_1 in ipairs(var_83_2) do
			local var_83_3 = iter_83_1:getMO()

			if var_83_3 then
				local var_83_4 = var_83_3.skin

				if var_83_0[var_83_4] and not string.nilorempty(var_83_0[var_83_4][arg_83_3]) then
					local var_83_5 = var_83_0[var_83_4].audio

					return var_83_0[var_83_4][arg_83_3], var_83_5 ~= 0 and var_83_5 or arg_83_4, var_83_0[var_83_4]
				end
			end
		end
	end

	return arg_83_0, arg_83_4
end

function var_0_0.filterBuffEffectBySkin(arg_84_0, arg_84_1, arg_84_2, arg_84_3)
	local var_84_0 = lua_fight_buff_effect_to_skin.configDict[arg_84_0]

	if not var_84_0 then
		return arg_84_2, arg_84_3
	end

	local var_84_1 = arg_84_1 and arg_84_1:getMO()
	local var_84_2 = var_84_1 and var_84_1.skin

	if not var_84_2 then
		return "", 0
	end

	local var_84_3 = FightStrUtil.instance:getSplitToNumberCache(var_84_0.skinIdList, "|")

	if tabletool.indexOf(var_84_3, var_84_2) then
		return arg_84_2, arg_84_3
	end

	return "", 0
end

function var_0_0.getBuffListForReplaceTimeline(arg_85_0, arg_85_1, arg_85_2)
	local var_85_0 = var_0_0.getEntitysCloneBuff(arg_85_1)

	if arg_85_0 and arg_85_0.simulate == 1 then
		var_85_0 = var_0_0.simulateFightStepMO(arg_85_2, var_85_0)
	end

	local var_85_1 = {}

	for iter_85_0, iter_85_1 in pairs(var_85_0) do
		tabletool.addValues(var_85_1, iter_85_1)
	end

	return var_85_1
end

function var_0_0.getTimelineListByName(arg_86_0, arg_86_1)
	local var_86_0 = arg_86_0
	local var_86_1 = {}
	local var_86_2 = lua_fight_replace_timeline.configDict[arg_86_0]

	if var_86_2 then
		for iter_86_0, iter_86_1 in pairs(var_86_2) do
			local var_86_3 = FightStrUtil.instance:getSplitCache(iter_86_1.condition, "#")

			if var_86_3[1] == "5" then
				local var_86_4 = {}

				for iter_86_2 = 2, #var_86_3 do
					var_86_4[tonumber(var_86_3[iter_86_2])] = true
				end

				if var_86_4[arg_86_1] then
					var_86_0 = iter_86_1.timeline
				end
			else
				table.insert(var_86_1, iter_86_1.timeline)
			end
		end
	end

	table.insert(var_86_1, var_86_0)

	return var_86_1
end

local var_0_5 = {}

function var_0_0.detectReplaceTimeline(arg_87_0, arg_87_1)
	local var_87_0 = lua_fight_replace_timeline.configDict[arg_87_0]

	if var_87_0 then
		local var_87_1 = {}

		for iter_87_0, iter_87_1 in pairs(var_87_0) do
			table.insert(var_87_1, iter_87_1)
		end

		table.sort(var_87_1, var_0_0.sortReplaceTimelineConfig)

		for iter_87_2, iter_87_3 in ipairs(var_87_1) do
			local var_87_2 = {}

			if iter_87_3.target == 1 then
				var_87_2[arg_87_1.fromId] = FightDataHelper.entityMgr:getById(arg_87_1.fromId)
			elseif iter_87_3.target == 2 then
				var_87_2[arg_87_1.toId] = FightDataHelper.entityMgr:getById(arg_87_1.toId)
			elseif iter_87_3.target == 3 or iter_87_3.target == 4 then
				local var_87_3
				local var_87_4 = arg_87_1.fromId

				if var_87_4 == FightEntityScene.MySideId then
					var_87_3 = FightEnum.EntitySide.MySide
				elseif var_87_4 == FightEntityScene.EnemySideId then
					var_87_3 = FightEnum.EntitySide.EnemySide
				else
					local var_87_5 = FightDataHelper.entityMgr:getById(arg_87_1.fromId)

					if var_87_5 then
						var_87_3 = var_87_5.side
					else
						var_87_3 = FightEnum.EntitySide.MySide
					end
				end

				local var_87_6 = FightDataHelper.entityMgr:getSideList(var_87_3, nil, iter_87_3.target == 4)

				for iter_87_4, iter_87_5 in ipairs(var_87_6) do
					var_87_2[iter_87_5.id] = iter_87_5
				end
			end

			local var_87_7 = FightStrUtil.instance:getSplitCache(iter_87_3.condition, "#")
			local var_87_8 = var_87_7[1]

			if var_87_8 == "1" then
				local var_87_9 = var_0_0.getBuffListForReplaceTimeline(iter_87_3, var_87_2, arg_87_1)
				local var_87_10 = tonumber(var_87_7[2])
				local var_87_11 = tonumber(var_87_7[3])

				for iter_87_6, iter_87_7 in ipairs(var_87_9) do
					if iter_87_7.buffId == var_87_10 and var_87_11 <= iter_87_7.count then
						return iter_87_3.timeline
					end
				end
			elseif var_87_8 == "2" then
				for iter_87_8, iter_87_9 in pairs(arg_87_1.actEffectMOs) do
					if iter_87_9.effectType == FightEnum.EffectType.DEAD then
						return iter_87_3.timeline
					end
				end
			elseif var_87_8 == "3" then
				local var_87_12 = var_0_0.getBuffListForReplaceTimeline(iter_87_3, var_87_2, arg_87_1)

				for iter_87_10 = 2, #var_87_7 do
					if var_0_0.detectEntityIncludeBuffType(nil, tonumber(var_87_7[iter_87_10]), var_87_12) then
						return iter_87_3.timeline
					end
				end
			elseif var_87_8 == "4" then
				local var_87_13 = {}

				for iter_87_11 = 2, #var_87_7 do
					var_87_13[tonumber(var_87_7[iter_87_11])] = true
				end

				local var_87_14 = var_0_0.getBuffListForReplaceTimeline(iter_87_3, var_87_2, arg_87_1)

				for iter_87_12, iter_87_13 in ipairs(var_87_14) do
					if var_87_13[iter_87_13.buffId] then
						return iter_87_3.timeline
					end
				end
			elseif var_87_8 == "5" then
				local var_87_15 = {}

				for iter_87_14 = 2, #var_87_7 do
					var_87_15[tonumber(var_87_7[iter_87_14])] = true
				end

				for iter_87_15, iter_87_16 in pairs(var_87_2) do
					local var_87_16 = iter_87_16.skin

					if iter_87_3.target == 1 then
						var_87_16 = var_0_0.processSkinByStepMO(arg_87_1, iter_87_16)
					end

					if iter_87_16 and var_87_15[var_87_16] then
						return iter_87_3.timeline
					end
				end
			elseif var_87_8 == "6" then
				local var_87_17 = {}

				for iter_87_17 = 2, #var_87_7 do
					var_87_17[tonumber(var_87_7[iter_87_17])] = true
				end

				for iter_87_18, iter_87_19 in ipairs(arg_87_1.actEffectMOs) do
					if var_87_2[iter_87_19.targetId] and var_87_17[iter_87_19.configEffect] then
						return iter_87_3.timeline
					end
				end
			elseif var_87_8 == "7" then
				local var_87_18 = {}

				for iter_87_20 = 2, #var_87_7 do
					var_87_18[tonumber(var_87_7[iter_87_20])] = true
				end

				local var_87_19 = var_0_0.getBuffListForReplaceTimeline(iter_87_3, var_87_2, arg_87_1)

				for iter_87_21, iter_87_22 in ipairs(var_87_19) do
					if var_87_18[iter_87_22.buffId] then
						return arg_87_0
					end
				end

				return iter_87_3.timeline
			elseif var_87_8 == "8" then
				local var_87_20 = tonumber(var_87_7[2])
				local var_87_21 = tonumber(var_87_7[3])
				local var_87_22 = var_0_0.getEntitysCloneBuff(var_87_2)

				if iter_87_3.simulate == 1 then
					local var_87_23 = var_0_0.getBuffListForReplaceTimeline(nil, var_87_2, arg_87_1)

					for iter_87_23, iter_87_24 in ipairs(var_87_23) do
						if iter_87_24.buffId == var_87_20 and var_87_21 <= iter_87_24.count then
							return iter_87_3.timeline
						end
					end

					if var_0_0.simulateFightStepMO(arg_87_1, var_87_22, var_0_0.detectBuffCountEnough, {
						buffId = var_87_20,
						count = var_87_21
					}) == true then
						return iter_87_3.timeline
					end
				else
					local var_87_24 = var_0_0.getBuffListForReplaceTimeline(iter_87_3, var_87_2, arg_87_1)

					for iter_87_25, iter_87_26 in ipairs(var_87_24) do
						if iter_87_26.buffId == var_87_20 and var_87_21 <= iter_87_26.count then
							return iter_87_3.timeline
						end
					end
				end
			elseif var_87_8 == "9" then
				local var_87_25 = {}

				for iter_87_27, iter_87_28 in ipairs(var_87_1) do
					local var_87_26 = tonumber(string.split(iter_87_28.condition, "#")[2])

					for iter_87_29, iter_87_30 in pairs(var_87_2) do
						local var_87_27 = iter_87_30.skin

						if iter_87_3.target == 1 then
							var_87_27 = var_0_0.processSkinByStepMO(arg_87_1, iter_87_30)
						end

						if var_87_27 == var_87_26 then
							table.insert(var_87_25, iter_87_28)
						end
					end
				end

				local var_87_28 = #var_87_25

				if var_87_28 > 1 then
					local var_87_29 = var_0_5[arg_87_0]

					while true do
						local var_87_30 = math.random(1, var_87_28)

						if var_87_30 ~= var_87_29 then
							var_0_5[arg_87_0] = var_87_30

							return var_87_25[var_87_30].timeline
						end
					end
				elseif var_87_28 > 0 then
					return var_87_25[1].timeline
				end
			elseif var_87_8 == "10" then
				local var_87_31 = tonumber(var_87_7[2])

				if var_87_31 == 1 then
					if arg_87_1.fromId == arg_87_1.toId then
						return iter_87_3.timeline
					end
				elseif var_87_31 == 2 and arg_87_1.fromId ~= arg_87_1.toId then
					return iter_87_3.timeline
				end
			elseif var_87_8 == "11" then
				local var_87_32 = {}
				local var_87_33 = tonumber(var_87_7[2])

				for iter_87_31 = 3, #var_87_7 do
					var_87_32[tonumber(var_87_7[iter_87_31])] = true
				end

				for iter_87_32, iter_87_33 in pairs(var_87_2) do
					local var_87_34 = iter_87_33.skin

					if iter_87_3.target == 1 then
						var_87_34 = var_0_0.processSkinByStepMO(arg_87_1, iter_87_33)
					end

					if var_87_33 == var_87_34 then
						local var_87_35 = var_0_0.getBuffListForReplaceTimeline(iter_87_3, var_87_2, arg_87_1)

						for iter_87_34, iter_87_35 in ipairs(var_87_35) do
							if var_87_32[iter_87_35.buffId] then
								return iter_87_3.timeline
							end
						end
					end
				end
			elseif var_87_8 == "12" then
				local var_87_36 = {}

				for iter_87_36 = 2, #var_87_7 - 1 do
					var_87_36[tonumber(var_87_7[iter_87_36])] = true
				end

				for iter_87_37, iter_87_38 in pairs(var_87_2) do
					local var_87_37 = iter_87_38.skin

					if iter_87_3.target == 1 then
						var_87_37 = var_0_0.processSkinByStepMO(arg_87_1, iter_87_38)
					end

					if iter_87_38 and var_87_36[var_87_37] then
						local var_87_38 = var_87_7[#var_87_7]

						if var_87_38 == "1" then
							if arg_87_1.fromId == arg_87_1.toId then
								return iter_87_3.timeline
							end
						elseif var_87_38 == "2" then
							local var_87_39 = FightDataHelper.entityMgr:getById(arg_87_1.fromId)
							local var_87_40 = FightDataHelper.entityMgr:getById(arg_87_1.toId)

							if var_87_39 and var_87_40 and var_87_39.id ~= var_87_40.id and var_87_39.side == var_87_40.side then
								return iter_87_3.timeline
							end
						elseif var_87_38 == "3" then
							local var_87_41 = FightDataHelper.entityMgr:getById(arg_87_1.fromId)
							local var_87_42 = FightDataHelper.entityMgr:getById(arg_87_1.toId)

							if var_87_41 and var_87_42 and var_87_41.side ~= var_87_42.side then
								return iter_87_3.timeline
							end
						end
					end
				end
			end
		end
	end

	return arg_87_0
end

function var_0_0.detectBuffCountEnough(arg_88_0, arg_88_1)
	local var_88_0 = arg_88_1.buffId
	local var_88_1 = arg_88_1.count

	for iter_88_0, iter_88_1 in ipairs(arg_88_0) do
		if var_88_0 == iter_88_1.buffId and var_88_1 <= iter_88_1.count then
			return true
		end
	end
end

function var_0_0.simulateFightStepMO(arg_89_0, arg_89_1, arg_89_2, arg_89_3)
	for iter_89_0, iter_89_1 in ipairs(arg_89_0.actEffectMOs) do
		local var_89_0 = iter_89_1.targetId
		local var_89_1 = var_0_0.getEntity(var_89_0)
		local var_89_2 = var_89_1 and var_89_1:getMO()
		local var_89_3 = arg_89_1 and arg_89_1[var_89_0]

		if var_89_2 and var_89_3 then
			if iter_89_1.effectType == FightEnum.EffectType.BUFFADD then
				if not var_89_2:getBuffMO(iter_89_1.buff.uid) then
					local var_89_4 = FightBuffMO.New()

					var_89_4:init(iter_89_1.buff, iter_89_1.targetId)
					table.insert(var_89_3, var_89_4)
				end

				if arg_89_2 and arg_89_2(var_89_3, arg_89_3) then
					return true
				end
			elseif iter_89_1.effectType == FightEnum.EffectType.BUFFDEL or iter_89_1.effectType == FightEnum.EffectType.BUFFDELNOEFFECT then
				for iter_89_2, iter_89_3 in ipairs(var_89_3) do
					if iter_89_3.uid == iter_89_1.buff.uid then
						table.remove(var_89_3, iter_89_2)

						break
					end
				end

				if arg_89_2 and arg_89_2(var_89_3, arg_89_3) then
					return true
				end
			elseif iter_89_1.effectType == FightEnum.EffectType.BUFFUPDATE then
				for iter_89_4, iter_89_5 in ipairs(var_89_3) do
					if iter_89_5.uid == iter_89_1.buff.uid then
						iter_89_5:init(iter_89_1.buff, var_89_0)
					end
				end

				if arg_89_2 and arg_89_2(var_89_3, arg_89_3) then
					return true
				end
			end
		end
	end

	return arg_89_1
end

function var_0_0.getEntitysCloneBuff(arg_90_0)
	local var_90_0 = {}

	for iter_90_0, iter_90_1 in pairs(arg_90_0) do
		local var_90_1 = {}
		local var_90_2 = iter_90_1:getBuffList()

		for iter_90_2, iter_90_3 in ipairs(var_90_2) do
			local var_90_3 = iter_90_3:clone()

			table.insert(var_90_1, var_90_3)
		end

		var_90_0[iter_90_1.id] = var_90_1
	end

	return var_90_0
end

function var_0_0.sortReplaceTimelineConfig(arg_91_0, arg_91_1)
	return arg_91_0.priority < arg_91_1.priority
end

function var_0_0.getMagicSide(arg_92_0)
	local var_92_0 = FightDataHelper.entityMgr:getById(arg_92_0)

	if var_92_0 then
		return var_92_0.side
	elseif arg_92_0 == FightEntityScene.MySideId then
		return FightEnum.EntitySide.MySide
	elseif arg_92_0 == FightEntityScene.EnemySideId then
		return FightEnum.EntitySide.EnemySide
	end

	return FightEnum.EntitySide.MySide
end

function var_0_0.isBossRushChannelSkill(arg_93_0)
	local var_93_0 = lua_skill.configDict[arg_93_0]

	if var_93_0 then
		local var_93_1 = var_93_0.skillEffect
		local var_93_2 = lua_skill_effect.configDict[var_93_1]

		if var_93_2 then
			for iter_93_0 = 1, FightEnum.MaxBehavior do
				local var_93_3 = var_93_2["behavior" .. iter_93_0]

				if not string.nilorempty(var_93_3) then
					local var_93_4 = FightStrUtil.instance:getSplitCache(var_93_3, "#")

					if var_93_4[1] == "1" then
						local var_93_5 = tonumber(var_93_4[2])
						local var_93_6 = lua_skill_buff.configDict[var_93_5]

						if var_93_6 then
							local var_93_7 = FightStrUtil.instance:getSplitCache(var_93_6.features, "#")

							if var_93_7[1] == "742" then
								return true, tonumber(var_93_7[2]), tonumber(var_93_7[5])
							end
						end
					end
				end
			end
		end
	end
end

function var_0_0.processEntitySkin(arg_94_0, arg_94_1)
	local var_94_0 = HeroModel.instance:getById(arg_94_1)

	if var_94_0 and var_94_0.skin > 0 then
		return var_94_0.skin
	end

	return arg_94_0
end

function var_0_0.isPlayerCardSkill(arg_95_0)
	if not arg_95_0.cardIndex then
		return
	end

	if arg_95_0.cardIndex == 0 then
		return
	end

	local var_95_0 = arg_95_0.fromId

	if var_95_0 == FightEntityScene.MySideId then
		return true
	end

	local var_95_1 = FightDataHelper.entityMgr:getById(var_95_0)

	if not var_95_1 then
		return
	end

	return var_95_1.teamType == FightEnum.TeamType.MySide
end

function var_0_0.isEnemyCardSkill(arg_96_0)
	if not arg_96_0.cardIndex then
		return
	end

	if arg_96_0.cardIndex == 0 then
		return
	end

	local var_96_0 = arg_96_0.fromId

	if var_96_0 == FightEntityScene.EnemySideId then
		return true
	end

	local var_96_1 = FightDataHelper.entityMgr:getById(var_96_0)

	if not var_96_1 then
		return
	end

	return var_96_1.teamType == FightEnum.TeamType.EnemySide
end

function var_0_0.buildMonsterA2B(arg_97_0, arg_97_1, arg_97_2, arg_97_3)
	local var_97_0 = lua_fight_boss_evolution_client.configDict[arg_97_1.skin]

	arg_97_2:addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.BeforeMonsterA2B, arg_97_1.modelId))

	if var_97_0 then
		arg_97_2:addWork(Work2FightWork.New(FightWorkPlayTimeline, arg_97_0, var_97_0.timeline))

		if var_97_0.nextSkinId ~= 0 then
			arg_97_2:registWork(FightWorkFunction, var_0_0.setBossEvolution, var_0_0, arg_97_0, var_97_0)
		else
			arg_97_2:registWork(FightWorkFunction, var_0_0.removeEntity, arg_97_0.id)
		end
	end

	if arg_97_3 then
		arg_97_2:addWork(arg_97_3)
	end

	arg_97_2:addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.AfterMonsterA2B, arg_97_1.modelId))
end

function var_0_0.removeEntity(arg_98_0)
	local var_98_0 = GameSceneMgr.instance:getCurScene().entityMgr
	local var_98_1 = var_0_0.getEntity(arg_98_0)

	if var_98_1 then
		var_98_0:removeUnit(var_98_1:getTag(), var_98_1.id)
	end
end

function var_0_0.setBossEvolution(arg_99_0, arg_99_1, arg_99_2)
	FightController.instance:dispatchEvent(FightEvent.SetBossEvolution, arg_99_1, arg_99_2.nextSkinId)
	FightMsgMgr.sendMsg(FightMsgId.SetBossEvolution, arg_99_1, arg_99_2.nextSkinId)

	local var_99_0 = GameSceneMgr.instance:getCurScene().entityMgr

	if var_0_0.getEntity(arg_99_1.id) == arg_99_1 then
		var_99_0:removeUnitData(arg_99_1:getTag(), arg_99_1.id)
	end
end

function var_0_0.buildDeadPerformanceWork(arg_100_0, arg_100_1)
	local var_100_0 = FlowSequence.New()

	for iter_100_0 = 1, FightEnum.DeadPerformanceMaxNum do
		local var_100_1 = arg_100_0["actType" .. iter_100_0]
		local var_100_2 = arg_100_0["actParam" .. iter_100_0]

		if var_100_1 == 0 then
			break
		end

		if var_100_1 == 1 then
			var_100_0:addWork(FightWorkPlayTimeline.New(arg_100_1, var_100_2))
		elseif var_100_1 == 2 then
			var_100_0:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.DeadPerformanceNoCondition, tonumber(var_100_2)))
		end
	end

	return var_100_0
end

function var_0_0.compareData(arg_101_0, arg_101_1, arg_101_2)
	local var_101_0 = type(arg_101_0)

	if var_101_0 == "function" then
		return true
	elseif var_101_0 == "table" then
		for iter_101_0, iter_101_1 in pairs(arg_101_0) do
			local var_101_1 = false

			if type(iter_101_0) == "table" then
				var_101_1 = true
			end

			if arg_101_2 and arg_101_2[iter_101_0] then
				var_101_1 = true
			end

			if not arg_101_1 then
				return false
			end

			if type(arg_101_1) ~= "table" then
				return false
			end

			if not var_101_1 and not var_0_0.compareData(iter_101_1, arg_101_1[iter_101_0], arg_101_2) then
				return false, iter_101_0, iter_101_1, arg_101_1[iter_101_0]
			end
		end

		return true
	else
		return arg_101_0 == arg_101_1
	end
end

local var_0_6 = 0

function var_0_0.logStr(arg_102_0, arg_102_1)
	local var_102_0 = ""

	var_0_6 = 0

	if type(arg_102_0) == "table" then
		var_102_0 = var_102_0 .. var_0_0.logTable(arg_102_0, arg_102_1)
	else
		var_102_0 = var_102_0 .. tostring(arg_102_0)
	end

	return var_102_0
end

function var_0_0.logTable(arg_103_0, arg_103_1)
	local var_103_0 = "" .. "{\n"

	var_0_6 = var_0_6 + 1

	local var_103_1 = tabletool.len(arg_103_0)
	local var_103_2 = 0

	for iter_103_0, iter_103_1 in pairs(arg_103_0) do
		local var_103_3 = false

		if arg_103_1 and arg_103_1[iter_103_0] then
			var_103_3 = true
		end

		if not var_103_3 then
			for iter_103_2 = 1, var_0_6 do
				var_103_0 = var_103_0 .. "\t"
			end

			var_103_0 = var_103_0 .. iter_103_0 .. " = "

			if type(iter_103_1) == "table" then
				var_103_0 = var_103_0 .. var_0_0.logTable(iter_103_1, arg_103_1)
			else
				var_103_0 = var_103_0 .. tostring(iter_103_1)
			end

			var_103_2 = var_103_2 + 1

			if var_103_2 < var_103_1 then
				var_103_0 = var_103_0 .. ","
			end

			var_103_0 = var_103_0 .. "\n"
		end
	end

	var_0_6 = var_0_6 - 1

	for iter_103_3 = 1, var_0_6 do
		var_103_0 = var_103_0 .. "\t"
	end

	return var_103_0 .. "}"
end

function var_0_0.deepCopySimpleWithMeta(arg_104_0, arg_104_1)
	if type(arg_104_0) ~= "table" then
		return arg_104_0
	else
		local var_104_0 = {}

		for iter_104_0, iter_104_1 in pairs(arg_104_0) do
			local var_104_1 = false

			if arg_104_1 and arg_104_1[iter_104_0] then
				var_104_1 = true
			end

			if not var_104_1 then
				var_104_0[iter_104_0] = var_0_0.deepCopySimpleWithMeta(iter_104_1, arg_104_1)
			end
		end

		local var_104_2 = getmetatable(arg_104_0)

		if var_104_2 then
			setmetatable(var_104_0, var_104_2)
		end

		return var_104_0
	end
end

function var_0_0.getPassiveSkill(arg_105_0, arg_105_1)
	local var_105_0 = FightDataHelper.entityMgr:getById(arg_105_0)

	if not var_105_0 then
		return arg_105_1
	end

	local var_105_1 = var_105_0.upgradedOptions

	for iter_105_0, iter_105_1 in pairs(var_105_1) do
		local var_105_2 = lua_hero_upgrade_options.configDict[iter_105_1]

		if var_105_2 and not string.nilorempty(var_105_2.replacePassiveSkill) then
			local var_105_3 = GameUtil.splitString2(var_105_2.replacePassiveSkill, true)

			for iter_105_2, iter_105_3 in ipairs(var_105_3) do
				if arg_105_1 == iter_105_3[1] and var_105_0:isPassiveSkill(iter_105_3[2]) then
					return iter_105_3[2]
				end
			end
		end
	end

	return arg_105_1
end

function var_0_0.isSupportCard(arg_106_0)
	if arg_106_0.cardType == FightEnum.CardType.SUPPORT_NORMAL or arg_106_0.cardType == FightEnum.CardType.SUPPORT_EX then
		return true
	end
end

function var_0_0.curIsRougeFight()
	local var_107_0 = FightModel.instance:getFightParam()

	if not var_107_0 then
		return false
	end

	local var_107_1 = var_107_0.chapterId
	local var_107_2 = DungeonConfig.instance:getChapterCO(var_107_1)

	return var_107_2 and var_107_2.type == DungeonEnum.ChapterType.Rouge
end

function var_0_0.processSkinByStepMO(arg_108_0, arg_108_1)
	arg_108_1 = arg_108_1 or FightDataHelper.entityMgr:getById(arg_108_0.fromId)

	local var_108_0 = arg_108_0.supportHeroId

	if var_108_0 ~= 0 and arg_108_1 and arg_108_1.modelId ~= var_108_0 then
		if var_0_0.curIsRougeFight() then
			local var_108_1 = RougeModel.instance:getTeamInfo()
			local var_108_2 = var_108_1 and var_108_1:getAssistHeroMo(var_108_0)

			if var_108_2 then
				return var_108_2.skin
			end
		end

		local var_108_3 = HeroModel.instance:getByHeroId(var_108_0)

		if var_108_3 and var_108_3.skin > 0 then
			return var_108_3.skin
		else
			local var_108_4 = lua_character.configDict[var_108_0]

			if var_108_4 then
				return var_108_4.skinId
			end
		end
	end

	return arg_108_1 and arg_108_1.skin or 0
end

function var_0_0.processSkinId(arg_109_0, arg_109_1)
	if (arg_109_1.cardType == FightEnum.CardType.SUPPORT_NORMAL or arg_109_1.cardType == FightEnum.CardType.SUPPORT_EX) and arg_109_1.heroId ~= arg_109_0.modelId then
		local var_109_0 = HeroModel.instance:getByHeroId(arg_109_1.heroId)

		if var_109_0 and var_109_0.skin > 0 then
			return var_109_0.skin
		else
			local var_109_1 = lua_character.configDict[arg_109_1.heroId]

			if var_109_1 then
				return var_109_1.skinId
			end
		end
	end

	return arg_109_0.skin
end

function var_0_0.processNextSkillId(arg_110_0)
	local var_110_0 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if var_110_0 and var_110_0.type == DungeonEnum.EpisodeType.Rouge then
		local var_110_1 = FightModel.instance:getRougeExData(FightEnum.ExIndexForRouge.SupportHeroSkill)

		if var_110_1 then
			local var_110_2 = cjson.decode(var_110_1)

			for iter_110_0, iter_110_1 in pairs(var_110_2) do
				if iter_110_1.skill1 then
					for iter_110_2, iter_110_3 in ipairs(iter_110_1.skill1) do
						local var_110_3 = iter_110_1.skill1[iter_110_2 + 1]

						if iter_110_3 == arg_110_0 and var_110_3 then
							return var_110_3
						end
					end
				end

				if iter_110_1.skill2 then
					for iter_110_4, iter_110_5 in ipairs(iter_110_1.skill2) do
						local var_110_4 = iter_110_1.skill2[iter_110_4 + 1]

						if iter_110_5 == arg_110_0 and var_110_4 then
							return var_110_4
						end
					end
				end
			end
		end
	end
end

function var_0_0.isTimelineStep(arg_111_0)
	if arg_111_0 and arg_111_0.actType == FightEnum.ActType.SKILL then
		local var_111_0 = FightDataHelper.entityMgr:getById(arg_111_0.fromId)
		local var_111_1 = var_111_0 and var_111_0.skin
		local var_111_2 = FightConfig.instance:getSkinSkillTimeline(var_111_1, arg_111_0.actId)

		if not string.nilorempty(var_111_2) then
			return true
		end
	end
end

function var_0_0.getClickEntity(arg_112_0, arg_112_1, arg_112_2)
	table.sort(arg_112_0, var_0_0.sortEntityList)

	for iter_112_0, iter_112_1 in ipairs(arg_112_0) do
		local var_112_0 = iter_112_1:getMO()

		if var_112_0 then
			local var_112_1
			local var_112_2
			local var_112_3
			local var_112_4
			local var_112_5
			local var_112_6
			local var_112_7
			local var_112_8
			local var_112_9 = var_0_0.getEntity(var_112_0.id)

			if isTypeOf(var_112_9, FightEntityAssembledMonsterMain) or isTypeOf(var_112_9, FightEntityAssembledMonsterSub) then
				local var_112_10 = lua_fight_assembled_monster.configDict[var_112_0.skin]
				local var_112_11, var_112_12, var_112_13 = transformhelper.getPos(iter_112_1.go.transform)
				local var_112_14 = var_112_11 + var_112_10.virtualSpinePos[1]
				local var_112_15 = var_112_12 + var_112_10.virtualSpinePos[2]
				local var_112_16 = var_112_13 + var_112_10.virtualSpinePos[3]

				var_112_7, var_112_8 = recthelper.worldPosToAnchorPosXYZ(var_112_14, var_112_15, var_112_16, arg_112_1)

				local var_112_17 = var_112_10.virtualSpineSize[1] * 0.5
				local var_112_18 = var_112_10.virtualSpineSize[2] * 0.5
				local var_112_19 = var_112_14 - var_112_17
				local var_112_20 = var_112_15 - var_112_18
				local var_112_21 = var_112_16
				local var_112_22 = var_112_14 + var_112_17
				local var_112_23 = var_112_15 + var_112_18
				local var_112_24 = var_112_16
				local var_112_25, var_112_26, var_112_27 = recthelper.worldPosToAnchorPosXYZ(var_112_19, var_112_20, var_112_21, arg_112_1)
				local var_112_28, var_112_29, var_112_30 = recthelper.worldPosToAnchorPosXYZ(var_112_22, var_112_23, var_112_24, arg_112_1)
				local var_112_31 = (var_112_28 - var_112_25) / 2

				var_112_2 = var_112_7 - var_112_31
				var_112_3 = var_112_7 + var_112_31

				local var_112_32 = (var_112_29 - var_112_26) / 2

				var_112_5 = var_112_8 - var_112_32
				var_112_6 = var_112_8 + var_112_32
			else
				local var_112_33, var_112_34, var_112_35, var_112_36 = var_0_0.calcRect(iter_112_1, arg_112_1)
				local var_112_37 = iter_112_1:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle)

				if var_112_37 then
					local var_112_38, var_112_39, var_112_40 = transformhelper.getPos(var_112_37.transform)

					var_112_7, var_112_8 = recthelper.worldPosToAnchorPosXYZ(var_112_38, var_112_39, var_112_40, arg_112_1)
				else
					var_112_7 = (var_112_33 + var_112_35) / 2
					var_112_8 = (var_112_34 + var_112_36) / 2
				end

				local var_112_41 = math.abs(var_112_33 - var_112_35)
				local var_112_42 = math.abs(var_112_34 - var_112_36)
				local var_112_43 = lua_monster_skin.configDict[var_112_0.skin]
				local var_112_44 = var_112_43 and var_112_43.clickBoxUnlimit == 1
				local var_112_45 = var_112_44 and 800 or 200
				local var_112_46 = var_112_44 and 800 or 500
				local var_112_47 = Mathf.Clamp(var_112_41, 150, var_112_45)
				local var_112_48 = Mathf.Clamp(var_112_42, 150, var_112_46)
				local var_112_49 = var_112_47 / 2

				var_112_2 = var_112_7 - var_112_49
				var_112_3 = var_112_7 + var_112_49

				local var_112_50 = var_112_48 / 2

				var_112_5 = var_112_8 - var_112_50
				var_112_6 = var_112_8 + var_112_50
			end

			local var_112_51, var_112_52 = recthelper.screenPosToAnchorPos2(arg_112_2, arg_112_1)

			if var_112_2 <= var_112_51 and var_112_51 <= var_112_3 and var_112_5 <= var_112_52 and var_112_52 <= var_112_6 then
				return iter_112_1.id, var_112_7, var_112_8
			end
		end
	end
end

function var_0_0.calcRect(arg_113_0, arg_113_1)
	if not arg_113_0 then
		return 10000, 10000, 10000, 10000
	end

	local var_113_0 = arg_113_0:getHangPoint(ModuleEnum.SpineHangPoint.BodyStatic)

	if not var_113_0 then
		return 10000, 10000, 10000, 10000
	end

	local var_113_1, var_113_2, var_113_3 = transformhelper.getPos(var_113_0.transform)
	local var_113_4, var_113_5 = var_0_0.getEntityBoxSizeOffsetV2(arg_113_0)
	local var_113_6 = arg_113_0:isMySide() and 1 or -1
	local var_113_7, var_113_8 = recthelper.worldPosToAnchorPosXYZ(var_113_1 - var_113_4.x * 0.5, var_113_2 - var_113_4.y * 0.5 * var_113_6, var_113_3, arg_113_1)
	local var_113_9, var_113_10 = recthelper.worldPosToAnchorPosXYZ(var_113_1 + var_113_4.x * 0.5, var_113_2 + var_113_4.y * 0.5 * var_113_6, var_113_3, arg_113_1)

	return var_113_7, var_113_8, var_113_9, var_113_10
end

function var_0_0.sortEntityList(arg_114_0, arg_114_1)
	local var_114_0 = arg_114_0:getMO()
	local var_114_1 = arg_114_1:getMO()
	local var_114_2 = isTypeOf(arg_114_0, FightEntityAssembledMonsterMain) or isTypeOf(arg_114_0, FightEntityAssembledMonsterSub)
	local var_114_3 = isTypeOf(arg_114_1, FightEntityAssembledMonsterMain) or isTypeOf(arg_114_1, FightEntityAssembledMonsterSub)

	if var_114_2 and var_114_3 then
		local var_114_4 = lua_fight_assembled_monster.configDict[var_114_0.skin]
		local var_114_5 = lua_fight_assembled_monster.configDict[var_114_1.skin]

		return var_114_4.clickIndex > var_114_5.clickIndex
	elseif var_114_2 and not var_114_3 then
		return true
	elseif not var_114_2 and var_114_3 then
		return false
	else
		local var_114_6, var_114_7, var_114_8 = var_0_0.getEntityStandPos(var_114_0)
		local var_114_9, var_114_10, var_114_11 = var_0_0.getEntityStandPos(var_114_1)

		if var_114_8 ~= var_114_11 then
			return var_114_8 < var_114_11
		else
			return tonumber(var_114_0.id) > tonumber(var_114_1.id)
		end
	end
end

function var_0_0.sortNextRoundGetCardConfig(arg_115_0, arg_115_1)
	return arg_115_0.priority > arg_115_1.priority
end

function var_0_0.sortNextRoundGetCard(arg_116_0, arg_116_1)
	return arg_116_0.index < arg_116_1.index
end

function var_0_0.getNextRoundGetCardList()
	local var_117_0 = {}
	local var_117_1 = {}
	local var_117_2 = FightCardModel.instance:getCardOps()

	for iter_117_0, iter_117_1 in ipairs(var_117_2) do
		if iter_117_1:isPlayCard() then
			local var_117_3 = iter_117_1.skillId
			local var_117_4 = lua_fight_next_round_get_card.configDict[var_117_3]

			if var_117_4 then
				local var_117_5 = {}

				for iter_117_2, iter_117_3 in pairs(var_117_4) do
					table.insert(var_117_5, iter_117_3)
				end

				table.sort(var_117_5, var_0_0.sortNextRoundGetCardConfig)

				for iter_117_4, iter_117_5 in ipairs(var_117_5) do
					local var_117_6 = iter_117_5.condition

					if var_0_0.checkNextRoundCardCondition(iter_117_1, var_117_6) then
						if iter_117_5.exclusion ~= 0 then
							var_117_0[iter_117_5.exclusion] = var_117_0[iter_117_5.exclusion] or {}
							var_117_0[iter_117_5.exclusion].index = iter_117_0
							var_117_0[iter_117_5.exclusion].skillId = iter_117_5.skillId
							var_117_0[iter_117_5.exclusion].entityId = iter_117_1.belongToEntityId
							var_117_0[iter_117_5.exclusion].tempCard = iter_117_5.tempCard

							break
						end

						local var_117_7 = {
							index = iter_117_0,
							skillId = iter_117_5.skillId,
							entityId = iter_117_1.belongToEntityId,
							tempCard = iter_117_5.tempCard
						}

						table.insert(var_117_1, var_117_7)

						break
					end
				end
			end
		end
	end

	for iter_117_6, iter_117_7 in pairs(var_117_0) do
		table.insert(var_117_1, iter_117_7)
	end

	table.sort(var_117_1, var_0_0.sortNextRoundGetCard)

	local var_117_8 = {}

	for iter_117_8, iter_117_9 in ipairs(var_117_1) do
		local var_117_9 = string.splitToNumber(iter_117_9.skillId, "#")

		for iter_117_10, iter_117_11 in ipairs(var_117_9) do
			local var_117_10 = FightCardInfoMO.New()

			var_117_10:init({
				uid = iter_117_9.entityId,
				skillId = iter_117_11,
				tempCard = iter_117_9.tempCard
			})
			table.insert(var_117_8, var_117_10)
		end
	end

	return var_117_8
end

function var_0_0.checkNextRoundCardCondition(arg_118_0, arg_118_1)
	if string.nilorempty(arg_118_1) then
		return true
	end

	local var_118_0 = string.split(arg_118_1, "&")

	if #var_118_0 > 1 then
		local var_118_1 = 0

		for iter_118_0, iter_118_1 in ipairs(var_118_0) do
			if var_0_0.checkNextRoundCardSingleCondition(arg_118_0, iter_118_1) then
				var_118_1 = var_118_1 + 1
			end
		end

		return var_118_1 == #var_118_0
	else
		return var_0_0.checkNextRoundCardSingleCondition(arg_118_0, var_118_0[1])
	end
end

function var_0_0.checkNextRoundCardSingleCondition(arg_119_0, arg_119_1)
	local var_119_0 = arg_119_0.belongToEntityId
	local var_119_1 = var_0_0.getEntity(var_119_0)
	local var_119_2 = var_119_1 and var_119_1:getMO()
	local var_119_3 = string.split(arg_119_1, "#")

	if var_119_3[1] == "1" then
		if var_119_3[2] and var_119_2 then
			local var_119_4, var_119_5 = HeroConfig.instance:getShowLevel(var_119_2.level)

			if var_119_5 - 1 >= tonumber(var_119_3[2]) then
				return true
			end
		end
	elseif var_119_3[1] == "2" and var_119_3[2] and var_119_2 then
		return var_119_2.exSkillLevel == tonumber(var_119_3[2])
	end
end

function var_0_0.checkShieldHit(arg_120_0)
	if arg_120_0.effectNum1 == FightEnum.EffectType.SHAREHURT then
		return false
	end

	return true
end

var_0_0.SkillEditorHp = 2000

function var_0_0.buildMySideFightEntityMOList(arg_121_0)
	local var_121_0 = FightEnum.EntitySide.MySide
	local var_121_1 = {}
	local var_121_2 = {}

	for iter_121_0 = 1, SkillEditorMgr.instance.stance_count_limit do
		local var_121_3 = HeroModel.instance:getById(arg_121_0.mySideUids[iter_121_0])

		if var_121_3 then
			var_121_1[iter_121_0] = var_121_3.heroId
			var_121_2[iter_121_0] = var_121_3.skin
		end
	end

	local var_121_4 = {}
	local var_121_5 = {}

	for iter_121_1, iter_121_2 in ipairs(arg_121_0.mySideSubUids) do
		local var_121_6 = HeroModel.instance:getById(iter_121_2)

		if var_121_6 then
			table.insert(var_121_4, var_121_6.heroId)
			table.insert(var_121_5, var_121_6.skin)
		end
	end

	return var_0_0.buildHeroEntityMOList(var_121_0, var_121_1, var_121_2, var_121_4, var_121_5)
end

function var_0_0.getEmptyFightEntityMO(arg_122_0, arg_122_1, arg_122_2, arg_122_3)
	if not arg_122_1 or arg_122_1 == 0 then
		return
	end

	local var_122_0 = lua_character.configDict[arg_122_1]
	local var_122_1 = FightEntityMO.New()

	var_122_1.id = tostring(arg_122_0)
	var_122_1.uid = var_122_1.id
	var_122_1.modelId = arg_122_1 or 0
	var_122_1.entityType = 1
	var_122_1.exPoint = 0
	var_122_1.side = FightEnum.EntitySide.MySide
	var_122_1.currentHp = 0
	var_122_1.attrMO = var_0_0._buildAttr(var_122_0)
	var_122_1.skillIds = var_0_0._buildHeroSkills(var_122_0)
	var_122_1.shieldValue = 0
	var_122_1.level = arg_122_2 or 1
	var_122_1.skin = arg_122_3 or var_122_0.skinId

	if not string.nilorempty(var_122_0.powerMax) then
		local var_122_2 = FightStrUtil.instance:getSplitToNumberCache(var_122_0.powerMax, "#")
		local var_122_3 = {
			{
				num = 0,
				powerId = var_122_2[1],
				max = var_122_2[2]
			}
		}

		var_122_1:setPowerInfos(var_122_3)
	end

	return var_122_1
end

function var_0_0.buildHeroEntityMOList(arg_123_0, arg_123_1, arg_123_2, arg_123_3, arg_123_4)
	local function var_123_0(arg_124_0, arg_124_1)
		local var_124_0 = FightEntityMO.New()

		var_124_0.id = tostring(var_0_1)
		var_124_0.uid = var_124_0.id
		var_124_0.modelId = arg_124_0 or 0
		var_124_0.entityType = 1
		var_124_0.exPoint = 0
		var_124_0.side = arg_123_0
		var_124_0.currentHp = var_0_0.SkillEditorHp
		var_124_0.attrMO = var_0_0._buildAttr(arg_124_1)
		var_124_0.skillIds = var_0_0._buildHeroSkills(arg_124_1)
		var_124_0.shieldValue = 0
		var_124_0.level = 1
		var_124_0.storedExPoint = 0

		if not string.nilorempty(arg_124_1.powerMax) then
			local var_124_1 = FightStrUtil.instance:getSplitToNumberCache(arg_124_1.powerMax, "#")
			local var_124_2 = {
				{
					num = 0,
					powerId = var_124_1[1],
					max = var_124_1[2]
				}
			}

			var_124_0:setPowerInfos(var_124_2)
		end

		var_0_1 = var_0_1 + 1

		return var_124_0
	end

	local var_123_1 = {}
	local var_123_2 = {}
	local var_123_3 = arg_123_1 and #arg_123_1 or SkillEditorMgr.instance.stance_count_limit

	for iter_123_0 = 1, var_123_3 do
		local var_123_4 = arg_123_1[iter_123_0]

		if var_123_4 and var_123_4 ~= 0 then
			local var_123_5 = lua_character.configDict[var_123_4]

			if var_123_5 then
				local var_123_6 = var_123_0(var_123_4, var_123_5)

				var_123_6.position = iter_123_0
				var_123_6.skin = arg_123_2 and arg_123_2[iter_123_0] or var_123_5.skinId

				table.insert(var_123_1, var_123_6)
			else
				local var_123_7 = arg_123_0 == FightEnum.EntitySide.MySide and "我方" or "敌方"

				logError(string.format("%s%d号站位的角色配置已被删除，角色id=%d", var_123_7, iter_123_0, var_123_4))
			end
		end
	end

	if arg_123_3 then
		for iter_123_1, iter_123_2 in ipairs(arg_123_3) do
			local var_123_8 = lua_character.configDict[iter_123_2]

			if var_123_8 then
				local var_123_9 = var_123_0(iter_123_2, var_123_8)

				var_123_9.position = -1
				var_123_9.skin = arg_123_4 and arg_123_4[iter_123_1] or var_123_8.skinId

				table.insert(var_123_2, var_123_9)
			else
				local var_123_10 = arg_123_0 == FightEnum.EntitySide.MySide and "我方" or "敌方"

				logError(var_123_10 .. "替补角色的配置已被删除，角色id=" .. iter_123_2)
			end
		end
	end

	return var_123_1, var_123_2
end

function var_0_0.buildEnemySideFightEntityMOList(arg_125_0, arg_125_1)
	local var_125_0 = FightEnum.EntitySide.EnemySide
	local var_125_1 = arg_125_0.monsterGroupIds[arg_125_1]
	local var_125_2 = lua_monster_group.configDict[var_125_1]
	local var_125_3 = FightStrUtil.instance:getSplitToNumberCache(var_125_2.monster, "#")
	local var_125_4 = var_125_2.subMonsters

	return var_0_0.buildMonsterEntityMOList(var_125_0, var_125_3, var_125_4)
end

function var_0_0.buildMonsterEntityMOList(arg_126_0, arg_126_1, arg_126_2)
	local var_126_0 = {}
	local var_126_1 = {}

	for iter_126_0 = 1, SkillEditorMgr.instance.enemy_stance_count_limit do
		local var_126_2 = arg_126_1[iter_126_0]

		if var_126_2 and var_126_2 ~= 0 then
			local var_126_3 = lua_monster.configDict[var_126_2]

			if var_126_3 then
				local var_126_4 = FightEntityMO.New()

				var_126_4.id = tostring(var_0_2)
				var_126_4.uid = var_126_4.id
				var_126_4.modelId = var_126_2
				var_126_4.position = iter_126_0
				var_126_4.entityType = 2
				var_126_4.exPoint = 0
				var_126_4.skin = var_126_3.skinId
				var_126_4.side = arg_126_0
				var_126_4.currentHp = var_0_0.SkillEditorHp
				var_126_4.attrMO = var_0_0._buildAttr(var_126_3)
				var_126_4.skillIds = var_0_0._buildMonsterSkills(var_126_3)
				var_126_4.shieldValue = 0
				var_126_4.level = 1
				var_126_4.storedExPoint = 0
				var_0_2 = var_0_2 - 1

				table.insert(var_126_0, var_126_4)
			else
				local var_126_5 = arg_126_0 == FightEnum.EntitySide.MySide and "我方" or "敌方"

				logError(string.format("%s%d号站位的怪物配置已被删除，怪物id=%d", var_126_5, iter_126_0, var_126_2))
			end
		end
	end

	if arg_126_2 then
		for iter_126_1, iter_126_2 in ipairs(arg_126_2) do
			local var_126_6 = lua_monster.configDict[iter_126_2]

			if var_126_6 then
				local var_126_7 = FightEntityMO.New()

				var_126_7.id = tostring(var_0_2)
				var_126_7.uid = var_126_7.id
				var_126_7.modelId = iter_126_2
				var_126_7.position = 5
				var_126_7.entityType = 2
				var_126_7.exPoint = 0
				var_126_7.skin = var_126_6.skinId
				var_126_7.side = arg_126_0
				var_126_7.currentHp = var_0_0.SkillEditorHp
				var_126_7.attrMO = var_0_0._buildAttr(var_126_6)
				var_126_7.skillIds = var_0_0._buildMonsterSkills(var_126_6)
				var_126_7.shieldValue = 0
				var_126_7.level = 1
				var_0_2 = var_0_2 - 1

				table.insert(var_126_1, var_126_7)
			else
				local var_126_8 = arg_126_0 == FightEnum.EntitySide.MySide and "我方" or "敌方"

				logError(var_126_8 .. "替补怪物的配置已被删除，怪物id=" .. iter_126_2)
			end
		end
	end

	return var_126_0, var_126_1
end

function var_0_0.buildSkills(arg_127_0)
	local var_127_0 = lua_character.configDict[arg_127_0]

	if var_127_0 then
		return var_0_0._buildHeroSkills(var_127_0)
	end

	local var_127_1 = lua_monster.configDict[arg_127_0]

	if var_127_1 then
		return var_0_0._buildMonsterSkills(var_127_1)
	end
end

function var_0_0._buildHeroSkills(arg_128_0)
	local var_128_0 = {}
	local var_128_1 = lua_character.configDict[arg_128_0.id]

	if var_128_1 then
		local var_128_2 = GameUtil.splitString2(var_128_1.skill, true)

		for iter_128_0, iter_128_1 in pairs(var_128_2) do
			for iter_128_2 = 2, #iter_128_1 do
				if iter_128_1[iter_128_2] ~= 0 then
					table.insert(var_128_0, iter_128_1[iter_128_2])
				else
					logError(arg_128_0.id .. " 角色技能id=0，检查下角色表-角色")
				end
			end
		end
	end

	if var_128_1.exSkill ~= 0 then
		table.insert(var_128_0, var_128_1.exSkill)
	end

	local var_128_3 = lua_skill_ex_level.configDict[arg_128_0.id]

	if var_128_3 then
		for iter_128_3, iter_128_4 in pairs(var_128_3) do
			if iter_128_4.skillEx ~= 0 then
				table.insert(var_128_0, iter_128_4.skillEx)
			end
		end
	end

	local var_128_4 = lua_skill_passive_level.configDict[arg_128_0.id]

	if var_128_4 then
		for iter_128_5, iter_128_6 in pairs(var_128_4) do
			if iter_128_6.skillPassive ~= 0 then
				table.insert(var_128_0, iter_128_6.skillPassive)
			else
				logError(arg_128_0.id .. " 角色被动技能id=0，检查下角色养成表-被动升级")
			end
		end
	end

	return var_128_0
end

function var_0_0._buildMonsterSkills(arg_129_0)
	local var_129_0 = {}

	if not string.nilorempty(arg_129_0.activeSkill) then
		local var_129_1 = FightStrUtil.instance:getSplitString2Cache(arg_129_0.activeSkill, true, "|", "#")

		for iter_129_0, iter_129_1 in ipairs(var_129_1) do
			for iter_129_2, iter_129_3 in ipairs(iter_129_1) do
				if lua_skill.configDict[iter_129_3] then
					table.insert(var_129_0, iter_129_3)
				end
			end
		end
	end

	if arg_129_0.uniqueSkill and #arg_129_0.uniqueSkill > 0 then
		for iter_129_4, iter_129_5 in ipairs(arg_129_0.uniqueSkill) do
			table.insert(var_129_0, iter_129_5)
		end
	end

	tabletool.addValues(var_129_0, FightConfig.instance:getPassiveSkills(arg_129_0.id))

	return var_129_0
end

function var_0_0._buildAttr(arg_130_0)
	local var_130_0 = HeroAttributeMO.New()

	var_130_0.hp = var_0_0.SkillEditorHp
	var_130_0.attack = 100
	var_130_0.defense = 100
	var_130_0.crit = 100
	var_130_0.crit_damage = 100
	var_130_0.multiHpNum = 0
	var_130_0.multiHpIdx = 0

	return var_130_0
end

function var_0_0.buildTestCard()
	local var_131_0 = {
		cardGroup = {
			300201,
			300301,
			300401,
			300501,
			300401,
			300301,
			300201,
			300501
		}
	}

	var_131_0.actPoint = 4
	var_131_0.moveNum = 20

	FightCardModel.instance:updateCard(var_131_0)
end

function var_0_0.getEpisodeRecommendLevel(arg_132_0, arg_132_1)
	local var_132_0 = DungeonConfig.instance:getEpisodeBattleId(arg_132_0)

	if not var_132_0 then
		return 0
	end

	return var_0_0.getBattleRecommendLevel(var_132_0, arg_132_1)
end

function var_0_0.getBattleRecommendLevel(arg_133_0, arg_133_1)
	local var_133_0 = arg_133_1 and "levelEasy" or "level"
	local var_133_1 = lua_battle.configDict[arg_133_0]

	if not var_133_1 then
		return 0
	end

	local var_133_2 = {}
	local var_133_3 = {}
	local var_133_4
	local var_133_5

	for iter_133_0, iter_133_1 in ipairs(FightStrUtil.instance:getSplitToNumberCache(var_133_1.monsterGroupIds, "#")) do
		local var_133_6 = lua_monster_group.configDict[iter_133_1].bossId
		local var_133_7 = FightStrUtil.instance:getSplitToNumberCache(lua_monster_group.configDict[iter_133_1].monster, "#")

		for iter_133_2, iter_133_3 in ipairs(var_133_7) do
			if var_0_0.isBossId(var_133_6, iter_133_3) then
				table.insert(var_133_3, iter_133_3)
			else
				table.insert(var_133_2, iter_133_3)
			end
		end
	end

	if #var_133_3 > 0 then
		return lua_monster.configDict[var_133_3[1]][var_133_0]
	elseif #var_133_2 > 0 then
		local var_133_8 = 0

		for iter_133_4, iter_133_5 in ipairs(var_133_2) do
			var_133_8 = var_133_8 + lua_monster.configDict[iter_133_5][var_133_0]
		end

		return math.ceil(var_133_8 / #var_133_2)
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

function var_0_0.buildDefaultSceneAndLevel(arg_135_0, arg_135_1)
	local var_135_0 = {}
	local var_135_1 = {}
	local var_135_2 = lua_battle.configDict[arg_135_1].sceneIds
	local var_135_3 = string.splitToNumber(var_135_2, "#")

	for iter_135_0, iter_135_1 in ipairs(var_135_3) do
		local var_135_4 = SceneConfig.instance:getSceneLevelCOs(iter_135_1)[1].id

		table.insert(var_135_0, iter_135_1)
		table.insert(var_135_1, var_135_4)
	end

	return var_135_0, var_135_1
end

function var_0_0.buildCachotSceneAndLevel(arg_136_0, arg_136_1)
	local var_136_0 = 0
	local var_136_1 = V1a6_CachotRoomModel.instance:getNowBattleEventMo()

	if var_136_1 and lua_rogue_event_fight.configDict[var_136_1:getEventCo().eventId].isChangeScene ~= 1 then
		var_136_0 = V1a6_CachotModel.instance:getRogueInfo().layer
	end

	if var_136_0 > 0 then
		local var_136_2 = V1a6_CachotEventConfig.instance:getSceneIdByLayer(var_136_0)

		if var_136_2 then
			local var_136_3 = {}
			local var_136_4 = {}

			table.insert(var_136_3, var_136_2.sceneId)
			table.insert(var_136_4, var_136_2.levelId)

			return var_136_3, var_136_4
		else
			logError("肉鸽战斗场景配置不存在" .. var_136_0)

			return var_0_0.buildDefaultSceneAndLevel(arg_136_0, arg_136_1)
		end
	else
		return var_0_0.buildDefaultSceneAndLevel(arg_136_0, arg_136_1)
	end
end

function var_0_0.buildRougeSceneAndLevel(arg_137_0, arg_137_1)
	local var_137_0 = RougeMapModel.instance:getCurEvent()
	local var_137_1 = var_137_0 and var_137_0.type
	local var_137_2 = RougeMapHelper.isFightEvent(var_137_1) and lua_rouge_fight_event.configDict[var_137_0.id]

	if var_137_2 and var_137_2.isChangeScene == 1 then
		local var_137_3 = RougeMapModel.instance:getLayerCo()
		local var_137_4 = var_137_3 and var_137_3.sceneId
		local var_137_5 = var_137_3 and var_137_3.levelId

		if var_137_4 ~= 0 and var_137_5 ~= 0 then
			return {
				var_137_4
			}, {
				var_137_5
			}
		end

		logError(string.format("layerId : %s, config Incorrect, sceneId : %s, levelId : %s", var_137_3 and var_137_3.id, var_137_4, var_137_5))

		return var_0_0.buildDefaultSceneAndLevel(arg_137_0, arg_137_1)
	else
		return var_0_0.buildDefaultSceneAndLevel(arg_137_0, arg_137_1)
	end
end

function var_0_0.buildSceneAndLevel(arg_138_0, arg_138_1)
	var_0_0.initBuildSceneAndLevelHandle()

	local var_138_0 = lua_episode.configDict[arg_138_0]
	local var_138_1 = var_138_0 and var_0_0.buildSceneAndLevelHandleDict[var_138_0.type]

	var_138_1 = var_138_1 or var_0_0.buildDefaultSceneAndLevel

	return var_138_1(arg_138_0, arg_138_1)
end

function var_0_0.getStressStatus(arg_139_0)
	if not arg_139_0 then
		logError("stress is nil")

		return FightEnum.Status.Positive
	end

	for iter_139_0 = 1, 2 do
		if arg_139_0 <= FightEnum.StressThreshold[iter_139_0] then
			return iter_139_0
		end
	end

	return nil
end

function var_0_0.getResistanceKeyById(arg_140_0)
	if not var_0_0.resistanceId2KeyDict then
		var_0_0.resistanceId2KeyDict = {}

		for iter_140_0, iter_140_1 in pairs(FightEnum.Resistance) do
			var_0_0.resistanceId2KeyDict[iter_140_1] = iter_140_0
		end
	end

	return var_0_0.resistanceId2KeyDict[arg_140_0]
end

function var_0_0.canAddPoint(arg_141_0)
	if not arg_141_0 then
		return false
	end

	if arg_141_0:hasBuffFeature(FightEnum.BuffType_TransferAddExPoint) then
		return false
	end

	if arg_141_0:hasBuffFeature(FightEnum.ExPointCantAdd) then
		return false
	end

	return true
end

function var_0_0.getEntityName(arg_142_0)
	local var_142_0 = arg_142_0 and arg_142_0:getMO()
	local var_142_1 = var_142_0 and var_142_0:getEntityName()

	return tostring(var_142_1)
end

function var_0_0.getEntityById(arg_143_0)
	local var_143_0 = var_0_0.getEntity(arg_143_0)

	return var_0_0.getEntityName(var_143_0)
end

function var_0_0.isSameCardMo(arg_144_0, arg_144_1)
	if arg_144_0 == arg_144_1 then
		return true
	end

	if not arg_144_0 or not arg_144_1 then
		return false
	end

	return arg_144_0.custom_enemyCardIndex == arg_144_1.custom_enemyCardIndex
end

function var_0_0.getAssitHeroInfoByUid(arg_145_0, arg_145_1)
	local var_145_0 = FightDataHelper.entityMgr:getById(arg_145_0)

	if var_145_0 and var_145_0:isCharacter() then
		local var_145_1 = HeroConfig.instance:getHeroCO(var_145_0.modelId)

		return {
			skin = var_145_0.skin,
			level = var_145_0.level,
			config = var_145_1
		}
	end
end

function var_0_0.canSelectEnemyEntity(arg_146_0)
	if not arg_146_0 then
		return false
	end

	local var_146_0 = FightDataHelper.entityMgr:getById(arg_146_0)

	if not var_146_0 then
		return false
	end

	if var_146_0.side == FightEnum.EntitySide.MySide then
		return false
	end

	if var_146_0:hasBuffFeature(FightEnum.BuffType_CantSelect) then
		return false
	end

	if var_146_0:hasBuffFeature(FightEnum.BuffType_CantSelectEx) then
		return false
	end

	return true
end

function var_0_0.clearNoUseEffect()
	local var_147_0 = FightEffectPool.releaseUnuseEffect()

	for iter_147_0, iter_147_1 in pairs(var_147_0) do
		FightPreloadController.instance:releaseAsset(iter_147_0)
	end

	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC)
end

function var_0_0.isASFDSkill(arg_148_0)
	return arg_148_0 == FightASFDConfig.instance.skillId
end

function var_0_0.isPreDeleteSkill(arg_149_0)
	local var_149_0 = arg_149_0 and lua_skill.configDict[arg_149_0]

	return var_149_0 and var_149_0.icon == FightEnum.CardIconId.PreDelete
end

function var_0_0.getASFDMgr()
	local var_150_0 = GameSceneMgr.instance:getCurScene()
	local var_150_1 = var_150_0 and var_150_0.mgr

	return var_150_1 and var_150_1:getASFDMgr()
end

function var_0_0.getEntityCareer(arg_151_0)
	local var_151_0 = arg_151_0 and FightDataHelper.entityMgr:getById(arg_151_0)

	return var_151_0 and var_151_0:getCareer() or 0
end

function var_0_0.isRestrain(arg_152_0, arg_152_1)
	local var_152_0 = var_0_0.getEntityCareer(arg_152_0)
	local var_152_1 = var_0_0.getEntityCareer(arg_152_1)

	return (FightConfig.instance:getRestrain(var_152_0, var_152_1) or 1000) > 1000
end

var_0_0.tempEntityMoList = {}

function var_0_0.hasSkinId(arg_153_0)
	local var_153_0 = var_0_0.tempEntityMoList

	tabletool.clear(var_153_0)

	local var_153_1 = FightDataHelper.entityMgr:getMyNormalList(var_153_0)

	for iter_153_0, iter_153_1 in ipairs(var_153_1) do
		if iter_153_1.originSkin == arg_153_0 then
			return true
		end
	end

	return false
end

return var_0_0
