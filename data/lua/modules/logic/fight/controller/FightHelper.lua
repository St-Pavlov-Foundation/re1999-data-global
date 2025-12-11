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
	if arg_2_0:isVorpalith() then
		return 0, 0, 0, 1
	end

	if arg_2_0:isAssistBoss() then
		return var_0_0.getAssistBossStandPos(arg_2_0, arg_2_1)
	end

	if arg_2_0:isAct191Boss() then
		local var_2_0 = arg_2_0:getCO()

		if var_2_0 and var_2_0.offset then
			local var_2_1 = string.split(var_2_0.offset, "#")
			local var_2_2 = tonumber(var_2_1[1]) or 0

			if arg_2_0:isEnemySide() then
				var_2_2 = -var_2_2
			end

			return var_2_2, tonumber(var_2_1[2]) or 0, tonumber(var_2_1[3]) or 0, 1
		end
	end

	if FightEntityDataHelper.isPlayerUid(arg_2_0.uid) then
		return 0, 0, 0, 1
	end

	local var_2_3 = var_0_0.getEntityStanceId(arg_2_0, arg_2_1)
	local var_2_4 = lua_stance.configDict[var_2_3]

	if not var_2_4 then
		if arg_2_0.side == FightEnum.EntitySide.MySide then
			local var_2_5 = FightModel.instance:getFightParam()
			local var_2_6 = var_2_5 and var_2_5.battleId

			logError("我方用了不存在的站位，战斗id=" .. (var_2_6 or "nil") .. "， 站位id=" .. var_2_3)
		else
			local var_2_7 = FightModel.instance:getCurMonsterGroupId()

			logError("敌方用了不存在的站位，怪物组=" .. (var_2_7 or "nil") .. "， 站位id=" .. var_2_3)
		end
	end

	local var_2_8 = FightDataHelper.entityMgr:isSub(arg_2_0.uid)
	local var_2_9

	if var_2_8 then
		var_2_9 = var_2_4.subPos1
	else
		var_2_9 = var_2_4["pos" .. arg_2_0.position]
	end

	if not var_2_9 or not var_2_9[1] or not var_2_9[2] or not var_2_9[3] then
		if isDebugBuild then
			logError("stance pos nil: stance_" .. (var_2_3 or "nil") .. " posIndex_" .. (arg_2_0.position or "nil"))
		end

		return 0, 0, 0, 1
	end

	local var_2_10 = var_2_9[1]
	local var_2_11 = var_2_9[4] or 1
	local var_2_12 = arg_2_0.skin
	local var_2_13 = lua_fight_skin_scale_by_z.configDict[var_2_12]

	if var_2_13 and not var_2_8 then
		local var_2_14 = {}

		for iter_2_0, iter_2_1 in pairs(var_2_13) do
			table.insert(var_2_14, iter_2_1)
		end

		table.sort(var_2_14, var_0_0.sortScaleBySkinPosZConfig)

		for iter_2_2, iter_2_3 in ipairs(var_2_14) do
			if var_2_9[3] <= iter_2_3.posZ then
				var_2_11 = iter_2_3.scale

				local var_2_15 = iter_2_3.posXOffset or 0

				if arg_2_0:isEnemySide() then
					var_2_15 = -var_2_15
				end

				var_2_10 = var_2_10 + var_2_15

				break
			end
		end
	end

	local var_2_16 = FightDataHelper.entityExMgr:getById(arg_2_0.id).scaleOffsetDic

	if var_2_16 then
		for iter_2_4, iter_2_5 in pairs(var_2_16) do
			var_2_11 = var_2_11 * iter_2_5
		end
	end

	return var_2_10, var_2_9[2], var_2_9[3], var_2_11
end

function var_0_0.sortScaleBySkinPosZConfig(arg_3_0, arg_3_1)
	return arg_3_0.priority < arg_3_1.priority
end

function var_0_0.getAssistBossStandPos(arg_4_0, arg_4_1)
	arg_4_1 = arg_4_1 or FightModel.instance:getCurWaveId()

	local var_4_0 = FightModel.instance:getFightParam()
	local var_4_1 = arg_4_0.skin
	local var_4_2 = var_4_0:getScene(arg_4_1)
	local var_4_3 = lua_assist_boss_stance.configDict[var_4_1]
	local var_4_4 = var_4_3 and var_4_3[var_4_2]

	var_4_4 = var_4_4 or var_4_3 and var_4_3[0]

	if not var_4_4 then
		logError(string.format("协助boss站位表未配置 皮肤id：%s, 场景id : %s", var_4_1, var_4_2))

		return 9.4, 0, -2.75, 0.9
	end

	local var_4_5 = var_4_4.position

	return var_4_5[1], var_4_5[2], var_4_5[3], var_4_4.scale
end

function var_0_0.getSpineLookDir(arg_5_0)
	return arg_5_0 == FightEnum.EntitySide.MySide and SpineLookDir.Left or SpineLookDir.Right
end

function var_0_0.getEntitySpineLookDir(arg_6_0)
	if arg_6_0 then
		local var_6_0 = arg_6_0.side
		local var_6_1 = FightConfig.instance:getSkinCO(arg_6_0.skin)

		if var_6_1 and var_6_1.flipX and var_6_1.flipX == 1 then
			return var_6_0 == FightEnum.EntitySide.MySide and SpineLookDir.Right or SpineLookDir.Left
		else
			return var_6_0 == FightEnum.EntitySide.MySide and SpineLookDir.Left or SpineLookDir.Right
		end
	end
end

function var_0_0.getEffectLookDir(arg_7_0)
	return arg_7_0 == FightEnum.EntitySide.MySide and FightEnum.EffectLookDir.Left or FightEnum.EffectLookDir.Right
end

function var_0_0.getEffectLookDirQuaternion(arg_8_0)
	if arg_8_0 == FightEnum.EntitySide.MySide then
		return FightEnum.RotationQuaternion.Zero
	else
		return FightEnum.RotationQuaternion.Ohae
	end
end

function var_0_0.getEntity(arg_9_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		return GameSceneMgr.instance:getCurScene().entityMgr:getEntity(arg_9_0)
	end
end

function var_0_0.getDefenders(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.actEffect) do
		local var_10_1 = false

		if arg_10_2 and arg_10_2[iter_10_1.effectType] then
			var_10_1 = true
		end

		if iter_10_1.effectType == FightEnum.EffectType.SHIELD and not var_0_0.checkShieldHit(iter_10_1) then
			var_10_1 = true
		end

		if not var_10_1 then
			local var_10_2 = var_0_0.getEntity(iter_10_1.targetId)

			if var_10_2 then
				table.insert(var_10_0, var_10_2)
			else
				logNormal("get defender fail, entity not exist: " .. iter_10_1.targetId)
			end
		end
	end

	if arg_10_1 then
		local var_10_3 = var_0_0.getEntity(arg_10_0.toId)

		if not tabletool.indexOf(var_10_0, var_10_3) then
			table.insert(var_10_0, var_10_3)
		end
	end

	return var_10_0
end

function var_0_0.getPreloadAssetItem(arg_11_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		return FightPreloadController.instance:getFightAssetItem(arg_11_0)
	end
end

function var_0_0.getEnemySideEntitys(arg_12_0, arg_12_1)
	local var_12_0 = var_0_0.getEntity(arg_12_0)

	if var_12_0 then
		local var_12_1 = var_12_0:getSide()

		if var_12_1 == FightEnum.EntitySide.EnemySide then
			return var_0_0.getSideEntitys(FightEnum.EntitySide.MySide, arg_12_1)
		elseif var_12_1 == FightEnum.EntitySide.MySide then
			return var_0_0.getSideEntitys(FightEnum.EntitySide.EnemySide, arg_12_1)
		end
	end

	return {}
end

function var_0_0.getSideEntitys(arg_13_0, arg_13_1)
	local var_13_0 = {}
	local var_13_1 = GameSceneMgr.instance:getCurScene().entityMgr
	local var_13_2 = arg_13_0 == FightEnum.EntitySide.MySide and SceneTag.UnitPlayer or SceneTag.UnitMonster
	local var_13_3 = var_13_1:getTagUnitDict(var_13_2)

	if var_13_3 then
		for iter_13_0, iter_13_1 in pairs(var_13_3) do
			if not FightDataHelper.entityMgr:isAssistBoss(iter_13_1.id) and not FightDataHelper.entityMgr:isAct191Boss(iter_13_1.id) and (arg_13_1 or not FightDataHelper.entityMgr:isSub(iter_13_1.id)) then
				table.insert(var_13_0, iter_13_1)
			end
		end
	end

	return var_13_0
end

function var_0_0.getAllSideEntitys(arg_14_0)
	local var_14_0 = {}
	local var_14_1 = GameSceneMgr.instance:getCurScene().entityMgr
	local var_14_2 = arg_14_0 == FightEnum.EntitySide.MySide and SceneTag.UnitPlayer or SceneTag.UnitMonster
	local var_14_3 = var_14_1:getTagUnitDict(var_14_2)

	if var_14_3 then
		for iter_14_0, iter_14_1 in pairs(var_14_3) do
			table.insert(var_14_0, iter_14_1)
		end
	end

	return var_14_0
end

function var_0_0.getSubEntity(arg_15_0)
	local var_15_0 = GameSceneMgr.instance:getCurScene().entityMgr
	local var_15_1 = arg_15_0 == FightEnum.EntitySide.MySide and SceneTag.UnitPlayer or SceneTag.UnitMonster
	local var_15_2 = var_15_0:getTagUnitDict(var_15_1)

	if var_15_2 then
		for iter_15_0, iter_15_1 in pairs(var_15_2) do
			if not iter_15_1.isDead and FightDataHelper.entityMgr:isSub(iter_15_1.id) then
				return iter_15_1
			end
		end
	end
end

function var_0_0.getAllEntitys()
	local var_16_0 = {}

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		local var_16_1 = GameSceneMgr.instance:getCurScene().entityMgr
		local var_16_2 = var_16_1:getTagUnitDict(SceneTag.UnitPlayer)
		local var_16_3 = var_16_1:getTagUnitDict(SceneTag.UnitMonster)

		if var_16_2 then
			for iter_16_0, iter_16_1 in pairs(var_16_2) do
				table.insert(var_16_0, iter_16_1)
			end
		end

		if var_16_3 then
			for iter_16_2, iter_16_3 in pairs(var_16_3) do
				table.insert(var_16_0, iter_16_3)
			end
		end
	end

	return var_16_0
end

function var_0_0.isAllEntityDead(arg_17_0)
	local var_17_0 = true
	local var_17_1

	if arg_17_0 then
		var_17_1 = var_0_0.getSideEntitys(arg_17_0, true)
	else
		var_17_1 = var_0_0.getAllEntitys()
	end

	for iter_17_0, iter_17_1 in ipairs(var_17_1) do
		if not iter_17_1.isDead then
			var_17_0 = false
		end
	end

	return var_17_0
end

function var_0_0.getAllEntitysContainUnitNpc()
	local var_18_0 = {}

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		local var_18_1 = GameSceneMgr.instance:getCurScene().entityMgr
		local var_18_2 = var_18_1:getTagUnitDict(SceneTag.UnitPlayer)
		local var_18_3 = var_18_1:getTagUnitDict(SceneTag.UnitMonster)
		local var_18_4 = var_18_1:getTagUnitDict(SceneTag.UnitNpc)

		LuaUtil.mergeTable(var_18_0, var_18_2, var_18_3, var_18_4)
	end

	return var_18_0
end

function var_0_0.validEntityEffectType(arg_19_0)
	if arg_19_0 == FightEnum.EffectType.EXPOINTCHANGE then
		return false
	end

	if arg_19_0 == FightEnum.EffectType.INDICATORCHANGE then
		return false
	end

	if arg_19_0 == FightEnum.EffectType.POWERCHANGE then
		return false
	end

	return true
end

function var_0_0.getRelativeEntityIdDict(arg_20_0, arg_20_1)
	local var_20_0 = {}

	if arg_20_0.fromId then
		var_20_0[arg_20_0.fromId] = true
	end

	if arg_20_0.toId then
		var_20_0[arg_20_0.toId] = true
	end

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.actEffect) do
		local var_20_1 = false

		if arg_20_1 and arg_20_1[iter_20_1.effectType] then
			var_20_1 = true
		end

		if iter_20_1.effectType == FightEnum.EffectType.SHIELD and not var_0_0.checkShieldHit(iter_20_1) then
			var_20_1 = true
		end

		if not var_20_1 and iter_20_1.effectType ~= FightEnum.EffectType.EXPOINTCHANGE and iter_20_1.targetId then
			var_20_0[iter_20_1.targetId] = true
		end
	end

	return var_20_0
end

function var_0_0.getSkillTargetEntitys(arg_21_0, arg_21_1)
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.actEffect) do
		local var_21_1 = false

		if arg_21_1 and arg_21_1[iter_21_1.effectType] then
			var_21_1 = true
		end

		if iter_21_1.effectType == FightEnum.EffectType.SHIELD and not var_0_0.checkShieldHit(iter_21_1) then
			var_21_1 = true
		end

		if not var_21_1 and iter_21_1.effectType ~= FightEnum.EffectType.EXPOINTCHANGE then
			local var_21_2 = var_0_0.getEntity(iter_21_1.targetId)

			if var_21_2 and not tabletool.indexOf(var_21_0, var_21_2) then
				table.insert(var_21_0, var_21_2)
			end
		end
	end

	return var_21_0
end

function var_0_0.getTargetLimits(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0 == FightEnum.EntitySide.MySide and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide
	local var_22_1 = var_0_0.getSideEntitys(arg_22_0, false)
	local var_22_2 = var_0_0.getSideEntitys(var_22_0, false)
	local var_22_3 = lua_skill.configDict[arg_22_1]
	local var_22_4 = {}

	if not var_22_3 then
		for iter_22_0, iter_22_1 in ipairs(var_22_2) do
			table.insert(var_22_4, iter_22_1.id)
		end

		logError("no target limits, skillId_" .. arg_22_1)
	elseif var_22_3.targetLimit == FightEnum.TargetLimit.None then
		-- block empty
	elseif var_22_3.targetLimit == FightEnum.TargetLimit.EnemySide then
		for iter_22_2, iter_22_3 in ipairs(var_22_2) do
			table.insert(var_22_4, iter_22_3.id)
		end
	elseif var_22_3.targetLimit == FightEnum.TargetLimit.MySide then
		for iter_22_4, iter_22_5 in ipairs(var_22_1) do
			table.insert(var_22_4, iter_22_5.id)
		end
	else
		for iter_22_6, iter_22_7 in ipairs(var_22_2) do
			table.insert(var_22_4, iter_22_7.id)
		end

		logError("target limit type not implement:" .. var_22_3.targetLimit .. " skillId = " .. arg_22_1)
	end

	if var_22_3.logicTarget == 3 then
		local var_22_5 = arg_22_2

		if var_22_5 then
			for iter_22_8 = #var_22_4, 1, -1 do
				if var_22_4[iter_22_8] == var_22_5 then
					table.remove(var_22_4, iter_22_8)
				end
			end
		end
	elseif var_22_3.logicTarget == 1 then
		for iter_22_9 = 1, FightEnum.MaxBehavior do
			local var_22_6 = var_22_3["behavior" .. iter_22_9]

			if FightStrUtil.instance:getSplitCache(var_22_6, "#")[1] == "60032" then
				for iter_22_10 = #var_22_4, 1, -1 do
					local var_22_7 = FightDataHelper.entityMgr:getById(var_22_4[iter_22_10])

					if var_22_7 and (#var_22_7.skillGroup1 == 0 or #var_22_7.skillGroup2 == 0) then
						table.remove(var_22_4, iter_22_10)
					end
				end
			end
		end
	end

	return var_22_4
end

function var_0_0.getEntityWorldTopPos(arg_23_0)
	local var_23_0, var_23_1 = var_0_0.getEntityBoxSizeOffsetV2(arg_23_0)
	local var_23_2, var_23_3, var_23_4 = var_0_0.getProcessEntitySpinePos(arg_23_0)

	return var_23_2 + var_23_1.x, var_23_3 + var_23_1.y + var_23_0.y / 2, var_23_4
end

function var_0_0.getEntityWorldCenterPos(arg_24_0)
	local var_24_0, var_24_1 = var_0_0.getEntityBoxSizeOffsetV2(arg_24_0)
	local var_24_2, var_24_3, var_24_4 = var_0_0.getProcessEntitySpinePos(arg_24_0)

	return var_24_2 + var_24_1.x, var_24_3 + var_24_1.y, var_24_4
end

function var_0_0.getEntityHangPointPos(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:getHangPoint(arg_25_1).transform.position

	return var_25_0.x, var_25_0.y, var_25_0.z
end

function var_0_0.getEntityWorldBottomPos(arg_26_0)
	local var_26_0, var_26_1 = var_0_0.getEntityBoxSizeOffsetV2(arg_26_0)
	local var_26_2, var_26_3, var_26_4 = var_0_0.getProcessEntitySpinePos(arg_26_0)

	return var_26_2 + var_26_1.x, var_26_3 + var_26_1.y - var_26_0.y / 2, var_26_4
end

function var_0_0.getEntityLocalTopPos(arg_27_0)
	local var_27_0, var_27_1 = var_0_0.getEntityBoxSizeOffsetV2(arg_27_0)

	return var_27_1.x, var_27_1.y + var_27_0.y / 2, 0
end

function var_0_0.getEntityLocalCenterPos(arg_28_0)
	local var_28_0, var_28_1 = var_0_0.getEntityBoxSizeOffsetV2(arg_28_0)

	return var_28_1.x, var_28_1.y, 0
end

function var_0_0.getEntityLocalBottomPos(arg_29_0)
	local var_29_0, var_29_1 = var_0_0.getEntityBoxSizeOffsetV2(arg_29_0)

	return var_29_1.x, var_29_1.y - var_29_0.y / 2, 0
end

function var_0_0.getEntityBoxSizeOffsetV2(arg_30_0)
	if var_0_0.isAssembledMonster(arg_30_0) then
		local var_30_0 = arg_30_0:getMO()
		local var_30_1 = lua_fight_assembled_monster.configDict[var_30_0.skin]

		return {
			x = var_30_1.virtualSpineSize[1],
			y = var_30_1.virtualSpineSize[2]
		}, var_0_3
	end

	local var_30_2 = arg_30_0.spine and arg_30_0.spine:getSpineGO()

	if var_30_2 then
		local var_30_3 = var_30_2:GetComponent("BoxCollider2D")

		if var_30_3 then
			local var_30_4, var_30_5, var_30_6 = transformhelper.getLocalScale(arg_30_0.go.transform)
			local var_30_7 = var_30_3.size
			local var_30_8 = var_30_3.offset

			var_30_8.x = var_30_8.x * var_30_4
			var_30_8.y = var_30_8.y * var_30_5

			if arg_30_0.spine:getLookDir() == SpineLookDir.Right then
				var_30_8.x = -var_30_8.x
			end

			var_30_7.x = var_30_7.x * var_30_4
			var_30_7.y = var_30_7.y * var_30_5

			return var_30_7, var_30_8
		end
	end

	return var_0_3, var_0_3
end

function var_0_0.getModelSize(arg_31_0)
	local var_31_0, var_31_1 = var_0_0.getEntityBoxSizeOffsetV2(arg_31_0)
	local var_31_2 = var_31_0.x + var_31_0.y

	if var_31_2 > 14 then
		return 4
	elseif var_31_2 > 7 then
		return 3
	elseif var_31_2 > 3 then
		return 2
	else
		return 1
	end
end

function var_0_0.getEffectUrlWithLod(arg_32_0)
	return ResUrl.getEffect(arg_32_0)
end

function var_0_0.tempNewStepProto(arg_33_0)
	local var_33_0 = {}

	setmetatable(var_33_0, {
		__index = arg_33_0
	})

	local var_33_1 = {}

	var_33_0.actEffect = var_33_1

	for iter_33_0, iter_33_1 in ipairs(arg_33_0.actEffect) do
		local var_33_2 = {}

		setmetatable(var_33_2, {
			__index = iter_33_1
		})
		table.insert(var_33_1, var_33_2)

		if iter_33_1.effectType == FightEnum.EffectType.FIGHTSTEP then
			var_33_2.fightStep = var_0_0.tempNewStepProto(iter_33_1.fightStep)
		end
	end

	return var_33_0
end

function var_0_0.tempProcessStepListProto(arg_34_0)
	local var_34_0 = {}

	for iter_34_0, iter_34_1 in ipairs(arg_34_0) do
		local var_34_1 = var_0_0.tempNewStepProto(iter_34_1)

		table.insert(var_34_0, var_34_1)
	end

	return var_34_0
end

local var_0_4 = 0
local var_0_5 = 0

function var_0_0.processRoundStep(arg_35_0)
	arg_35_0 = var_0_0.tempProcessStepListProto(arg_35_0)
	var_0_4 = 0
	var_0_5 = 0

	local var_35_0 = {}

	for iter_35_0, iter_35_1 in ipairs(arg_35_0) do
		var_0_0.addRoundStep(var_35_0, iter_35_1)
	end

	return var_35_0
end

function var_0_0.addRoundStep(arg_36_0, arg_36_1)
	table.insert(arg_36_0, arg_36_1)
	var_0_0.detectStepEffect(arg_36_0, arg_36_1.actEffect)
end

function var_0_0.detectStepEffect(arg_37_0, arg_37_1)
	if arg_37_1 and #arg_37_1 > 0 then
		local var_37_0 = 1

		while arg_37_1[var_37_0] do
			local var_37_1 = arg_37_1[var_37_0]

			if var_37_1.effectType == FightEnum.EffectType.SPLITSTART then
				var_0_4 = var_0_4 + 1
			elseif var_37_1.effectType == FightEnum.EffectType.SPLITEND then
				var_0_4 = var_0_4 - 1
			end

			if var_37_1.effectType == FightEnum.EffectType.FIGHTSTEP then
				if var_0_4 > 0 then
					table.remove(arg_37_1, var_37_0)

					var_37_0 = var_37_0 - 1
					var_0_5 = var_0_5 + 1

					var_0_0.addRoundStep(arg_37_0, var_37_1.fightStep)

					var_0_5 = var_0_5 - 1
				else
					local var_37_2 = var_37_1.fightStep

					if var_37_2.fakeTimeline then
						var_0_0.addRoundStep(arg_37_0, var_37_1.fightStep)
					elseif var_37_2.actType == FightEnum.ActType.SKILL then
						if var_0_0.needAddRoundStep(var_37_2) then
							var_0_0.addRoundStep(arg_37_0, var_37_1.fightStep)
						else
							var_0_0.detectStepEffect(arg_37_0, var_37_2.actEffect)
						end
					elseif var_37_2.actType == FightEnum.ActType.CHANGEHERO then
						var_0_0.addRoundStep(arg_37_0, var_37_1.fightStep)
					elseif var_37_2.actType == FightEnum.ActType.CHANGEWAVE then
						var_0_0.addRoundStep(arg_37_0, var_37_1.fightStep)
					else
						var_0_0.detectStepEffect(arg_37_0, var_37_2.actEffect)
					end
				end
			elseif var_0_4 > 0 and var_0_5 == 0 then
				table.remove(arg_37_1, var_37_0)

				var_37_0 = var_37_0 - 1

				local var_37_3 = {
					actType = FightEnum.ActType.EFFECT
				}

				var_37_3.fromId = "0"
				var_37_3.toId = "0"
				var_37_3.actId = 0
				var_37_3.actEffect = {
					var_37_1
				}
				var_37_3.cardIndex = 0
				var_37_3.supportHeroId = 0
				var_37_3.fakeTimeline = false

				table.insert(arg_37_0, var_37_3)
			end

			var_37_0 = var_37_0 + 1
		end
	end
end

function var_0_0.needAddRoundStep(arg_38_0)
	if arg_38_0 then
		if var_0_0.isTimelineStep(arg_38_0) then
			return true
		elseif arg_38_0.actType == FightEnum.ActType.CHANGEHERO then
			return true
		elseif arg_38_0.actType == FightEnum.ActType.CHANGEWAVE then
			return true
		end
	end
end

function var_0_0.buildInfoMOs(arg_39_0, arg_39_1)
	local var_39_0 = {}

	for iter_39_0, iter_39_1 in ipairs(arg_39_0) do
		local var_39_1 = arg_39_1.New()

		var_39_1:init(iter_39_1)
		table.insert(var_39_0, var_39_1)
	end

	return var_39_0
end

function var_0_0.logForPCSkillEditor(arg_40_0)
	if not SkillEditorMgr.instance.inEditMode or SLFramework.FrameworkSettings.IsEditor then
		logNormal(arg_40_0)
	end
end

function var_0_0.getEffectLabel(arg_41_0, arg_41_1)
	if gohelper.isNil(arg_41_0) then
		return
	end

	local var_41_0 = arg_41_0:GetComponentsInChildren(typeof(ZProj.EffectLabel))

	if not var_41_0 or var_41_0.Length <= 0 then
		return
	end

	local var_41_1 = {}

	for iter_41_0 = 0, var_41_0.Length - 1 do
		local var_41_2 = var_41_0[iter_41_0]

		if not arg_41_1 or var_41_2.label == arg_41_1 then
			table.insert(var_41_1, var_41_2)
		end
	end

	return var_41_1
end

function var_0_0.shouUIPoisoningEffect(arg_42_0)
	if FightConfig.instance:hasBuffFeature(arg_42_0, FightEnum.BuffType_Dot) then
		local var_42_0 = lua_skill_buff.configDict[arg_42_0]

		if var_42_0 and lua_fight_buff_use_poison_ui_effect.configDict[var_42_0.typeId] then
			return true
		end
	end

	return false
end

function var_0_0.dealDirectActEffectData(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = var_0_0.filterActEffect(arg_43_0, arg_43_2)
	local var_43_1 = #var_43_0
	local var_43_2 = {}

	if var_43_0[arg_43_1] then
		var_43_2 = var_43_0[arg_43_1]
	elseif var_43_1 > 0 then
		var_43_2 = var_43_0[var_43_1]
	end

	return var_43_2
end

function var_0_0.filterActEffect(arg_44_0, arg_44_1)
	local var_44_0 = {}
	local var_44_1 = {}
	local var_44_2 = {}

	for iter_44_0, iter_44_1 in ipairs(arg_44_0) do
		local var_44_3 = iter_44_1
		local var_44_4 = false

		if var_44_3.effectType == FightEnum.EffectType.SHIELD and not var_0_0.checkShieldHit(var_44_3) then
			var_44_4 = true
		end

		if not var_44_4 and arg_44_1[iter_44_1.effectType] then
			if not var_44_1[iter_44_1.targetId] then
				var_44_1[iter_44_1.targetId] = {}

				table.insert(var_44_2, iter_44_1.targetId)
			end

			table.insert(var_44_1[iter_44_1.targetId], iter_44_1)
		end
	end

	for iter_44_2, iter_44_3 in ipairs(var_44_2) do
		var_44_0[iter_44_2] = var_44_1[iter_44_3]
	end

	return var_44_0
end

function var_0_0.detectAttributeCounter()
	local var_45_0 = FightModel.instance:getFightParam()
	local var_45_1, var_45_2 = var_0_0.getAttributeCounter(var_45_0.monsterGroupIds, GameSceneMgr.instance:isSpScene())

	return var_45_1, var_45_2
end

function var_0_0.getAttributeCounter(arg_46_0, arg_46_1)
	local var_46_0
	local var_46_1 = {}

	if var_0_0.checkIsTowerDeepEpisode() then
		local var_46_2 = TowerPermanentDeepModel.instance:getCurDeepMonsterId()
		local var_46_3 = lua_monster.configDict[var_46_2].career

		if var_46_3 ~= 5 and var_46_3 ~= 6 then
			var_46_1[var_46_3] = (var_46_1[var_46_3] or 0) + 1
		end
	else
		for iter_46_0, iter_46_1 in ipairs(arg_46_0) do
			if not string.nilorempty(lua_monster_group.configDict[iter_46_1].bossId) then
				local var_46_4 = lua_monster_group.configDict[iter_46_1].bossId
			end

			local var_46_5 = FightStrUtil.instance:getSplitToNumberCache(lua_monster_group.configDict[iter_46_1].monster, "#")

			for iter_46_2, iter_46_3 in ipairs(var_46_5) do
				if not lua_monster.configDict[iter_46_3] then
					logError("怪物表找不到id:" .. iter_46_3)
				end

				local var_46_6 = lua_monster.configDict[iter_46_3].career

				if var_46_6 ~= 5 and var_46_6 ~= 6 then
					var_46_1[var_46_6] = (var_46_1[var_46_6] or 0) + 1

					if var_0_0.isBossId(lua_monster_group.configDict[iter_46_1].bossId, iter_46_3) then
						var_46_1[var_46_6] = (var_46_1[var_46_6] or 0) + 1
					end
				end
			end
		end
	end

	local var_46_7 = {}
	local var_46_8 = {}

	if arg_46_1 then
		return var_46_7, var_46_8
	end

	if #var_46_7 == 0 then
		local var_46_9 = 0
		local var_46_10 = 0
		local var_46_11 = {}
		local var_46_12 = {}

		for iter_46_4, iter_46_5 in pairs(var_46_1) do
			if iter_46_5 >= 2 then
				var_46_9 = var_46_9 + 1

				table.insert(var_46_12, iter_46_4)
			else
				var_46_10 = var_46_10 + 1

				table.insert(var_46_11, iter_46_4)
			end
		end

		if var_46_9 == 1 then
			table.insert(var_46_7, FightConfig.instance:restrainedBy(var_46_12[1]))
			table.insert(var_46_8, FightConfig.instance:restrained(var_46_12[1]))
		elseif var_46_9 == 2 then
			if var_0_0.checkHadRestrain(var_46_12[1], var_46_12[2]) then
				table.insert(var_46_7, FightConfig.instance:restrainedBy(var_46_12[1]))
				table.insert(var_46_7, FightConfig.instance:restrainedBy(var_46_12[2]))
				table.insert(var_46_8, FightConfig.instance:restrained(var_46_12[1]))
				table.insert(var_46_8, FightConfig.instance:restrained(var_46_12[2]))
			end
		elseif var_46_9 == 0 then
			if var_46_10 == 1 then
				table.insert(var_46_7, FightConfig.instance:restrainedBy(var_46_11[1]))
				table.insert(var_46_8, FightConfig.instance:restrained(var_46_11[1]))
			elseif var_46_10 == 2 and var_0_0.checkHadRestrain(var_46_11[1], var_46_11[2]) then
				table.insert(var_46_7, FightConfig.instance:restrainedBy(var_46_11[1]))
				table.insert(var_46_7, FightConfig.instance:restrainedBy(var_46_11[2]))
				table.insert(var_46_8, FightConfig.instance:restrained(var_46_11[1]))
				table.insert(var_46_8, FightConfig.instance:restrained(var_46_11[2]))
			end
		end
	end

	for iter_46_6 = #var_46_8, 1, -1 do
		if tabletool.indexOf(var_46_7, var_46_8[1]) then
			table.remove(var_46_8, iter_46_6)
		end
	end

	return var_46_7, var_46_8
end

function var_0_0.checkHadRestrain(arg_47_0, arg_47_1)
	return FightConfig.instance:getRestrain(arg_47_0, arg_47_1) > 1000 or FightConfig.instance:getRestrain(arg_47_1, arg_47_0) > 1000
end

function var_0_0.checkIsTowerDeepEpisode()
	local var_48_0 = FightModel.instance:getFightParam()

	if not var_48_0 or not var_48_0.episodeId then
		return false
	end

	return (TowerPermanentDeepModel.instance:checkIsDeepEpisode(var_48_0.episodeId))
end

function var_0_0.setMonsterGuideFocusState(arg_49_0)
	local var_49_0 = FightWorkSkillOrBuffFocusMonster.getPlayerPrefKey(arg_49_0)

	PlayerPrefsHelper.setNumber(var_49_0, 1)

	if not string.nilorempty(arg_49_0.completeWithGroup) then
		local var_49_1 = FightStrUtil.instance:getSplitCache(arg_49_0.completeWithGroup, "|")

		for iter_49_0, iter_49_1 in ipairs(var_49_1) do
			local var_49_2 = FightStrUtil.instance:getSplitToNumberCache(iter_49_1, "#")
			local var_49_3 = FightConfig.instance:getMonsterGuideFocusConfig(var_49_2[1], var_49_2[2], var_49_2[3], var_49_2[4])

			if var_49_3 then
				local var_49_4 = FightWorkSkillOrBuffFocusMonster.getPlayerPrefKey(var_49_3)

				PlayerPrefsHelper.setNumber(var_49_4, 1)
			else
				logError("怪物指引图表找不到id：", var_49_2[1], var_49_2[2], var_49_2[3], var_49_2[4])
			end
		end
	end
end

function var_0_0.detectTimelinePlayEffectCondition(arg_50_0, arg_50_1, arg_50_2)
	if string.nilorempty(arg_50_1) or arg_50_1 == "0" then
		return true
	end

	if arg_50_1 == "1" then
		local var_50_0 = false

		for iter_50_0, iter_50_1 in pairs(arg_50_0.actEffect) do
			if iter_50_1.effectType == FightEnum.EffectType.DEAD then
				var_50_0 = true
			end
		end

		return var_50_0
	end

	local var_50_1 = FightStrUtil.instance:getSplitToNumberCache(arg_50_1, "#")
	local var_50_2 = var_50_1[1]

	if var_50_2 == 2 then
		for iter_50_2, iter_50_3 in ipairs(arg_50_0.actEffect) do
			if iter_50_3.effectType == FightEnum.EffectType.MISS or iter_50_3.effectType == FightEnum.EffectType.DAMAGE or iter_50_3.effectType == FightEnum.EffectType.CRIT or iter_50_3.effectType == FightEnum.EffectType.SHIELD then
				local var_50_3 = var_0_0.getEntity(iter_50_3.targetId)

				for iter_50_4 = 2, #var_50_1 do
					if arg_50_2 then
						if arg_50_2 == var_50_3 and var_0_0.detectEntityIncludeBuffType(var_50_3, var_50_1[iter_50_4]) then
							return true
						end
					elseif var_0_0.detectEntityIncludeBuffType(var_50_3, var_50_1[iter_50_4]) then
						return true
					end
				end
			end
		end
	end

	if var_50_2 == 3 then
		local var_50_4 = var_0_0.getEntity(arg_50_0.fromId)

		if var_50_4 then
			for iter_50_5 = 2, #var_50_1 do
				if var_0_0.detectEntityIncludeBuffType(var_50_4, var_50_1[iter_50_5]) then
					return true
				end
			end
		end
	end

	if var_50_2 == 4 then
		for iter_50_6, iter_50_7 in ipairs(arg_50_0.actEffect) do
			if iter_50_7.effectType == FightEnum.EffectType.MISS or iter_50_7.effectType == FightEnum.EffectType.DAMAGE or iter_50_7.effectType == FightEnum.EffectType.CRIT or iter_50_7.effectType == FightEnum.EffectType.SHIELD then
				local var_50_5 = var_0_0.getEntity(iter_50_7.targetId)

				for iter_50_8 = 2, #var_50_1 do
					if arg_50_2 then
						if arg_50_2 == var_50_5 and arg_50_2.buff and arg_50_2.buff:haveBuffId(var_50_1[iter_50_8]) then
							return true
						end
					elseif var_50_5.buff and var_50_5.buff:haveBuffId(var_50_1[iter_50_8]) then
						return true
					end
				end
			end
		end
	end

	if var_50_2 == 5 then
		local var_50_6 = var_0_0.getEntity(arg_50_0.fromId)

		if var_50_6 and var_50_6.buff then
			for iter_50_9 = 2, #var_50_1 do
				if var_50_6.buff:haveBuffId(var_50_1[iter_50_9]) then
					return true
				end
			end
		end
	end

	if var_50_2 == 6 then
		for iter_50_10, iter_50_11 in ipairs(arg_50_0.actEffect) do
			if iter_50_11.effectType == FightEnum.EffectType.MISS or iter_50_11.effectType == FightEnum.EffectType.DAMAGE or iter_50_11.effectType == FightEnum.EffectType.CRIT or iter_50_11.effectType == FightEnum.EffectType.SHIELD then
				local var_50_7 = var_0_0.getEntity(iter_50_11.targetId)

				for iter_50_12 = 2, #var_50_1 do
					if arg_50_2 then
						if arg_50_2 == var_50_7 then
							local var_50_8 = arg_50_2:getMO()

							if var_50_8 and var_50_8.skin == var_50_1[iter_50_12] then
								return true
							end
						end
					else
						local var_50_9 = var_50_7:getMO()

						if var_50_9 and var_50_9.skin == var_50_1[iter_50_12] then
							return true
						end
					end
				end
			end
		end
	end

	if var_50_2 == 7 then
		for iter_50_13, iter_50_14 in ipairs(arg_50_0.actEffect) do
			if iter_50_14.targetId == arg_50_0.fromId and iter_50_14.configEffect == var_50_1[2] then
				if iter_50_14.configEffect == 30011 then
					if iter_50_14.effectNum ~= 0 then
						return true
					end
				else
					return true
				end
			end
		end
	end

	if var_50_2 == 8 then
		for iter_50_15, iter_50_16 in ipairs(arg_50_0.actEffect) do
			if iter_50_16.targetId ~= arg_50_0.fromId and iter_50_16.configEffect == var_50_1[2] then
				if iter_50_16.configEffect == 30011 then
					if iter_50_16.effectNum ~= 0 then
						return true
					end
				else
					return true
				end
			end
		end
	end

	if var_50_2 == 9 then
		local var_50_10 = var_0_0.getEntity(arg_50_0.fromId)

		if var_50_10 and var_50_10.buff then
			for iter_50_17 = 2, #var_50_1 do
				if var_50_10.buff:haveBuffId(var_50_1[iter_50_17]) then
					return false
				end
			end

			return true
		end
	elseif var_50_2 == 10 then
		local var_50_11 = arg_50_0.playerOperationCountForPlayEffectTimeline

		if var_50_11 and var_50_1[2] == var_50_11 then
			return true
		end
	elseif var_50_2 == 11 then
		local var_50_12 = var_50_1[2]
		local var_50_13 = var_50_1[3]
		local var_50_14 = FightDataHelper.entityMgr:getById(arg_50_0.fromId)

		if var_50_14 then
			local var_50_15 = var_50_14:getPowerInfo(FightEnum.PowerType.Power)

			if var_50_15 then
				if var_50_12 == 1 then
					return var_50_13 < var_50_15.num
				elseif var_50_12 == 2 then
					return var_50_13 > var_50_15.num
				elseif var_50_12 == 3 then
					return var_50_15.num == var_50_13
				elseif var_50_12 == 4 then
					return var_50_13 <= var_50_15.num
				elseif var_50_12 == 5 then
					return var_50_13 >= var_50_15.num
				end
			end
		end
	elseif var_50_2 == 12 then
		return arg_50_0.playerOperationCountForPlayEffectTimeline == arg_50_0.maxPlayerOperationCountForPlayEffectTimeline
	end

	return false
end

function var_0_0.detectEntityIncludeBuffType(arg_51_0, arg_51_1, arg_51_2)
	local var_51_0 = arg_51_0 and arg_51_0:getMO()

	arg_51_2 = arg_51_2 or var_51_0 and var_51_0:getBuffList() or {}

	for iter_51_0, iter_51_1 in ipairs(arg_51_2) do
		local var_51_1 = lua_skill_buff.configDict[iter_51_1.buffId]

		if arg_51_1 == lua_skill_bufftype.configDict[var_51_1.typeId].type then
			return true
		end
	end
end

function var_0_0.hideDefenderBuffEffect(arg_52_0, arg_52_1)
	local var_52_0 = lua_skin_monster_hide_buff_effect.configDict[arg_52_0.actId]
	local var_52_1 = {}

	if var_52_0 then
		local var_52_2 = {}
		local var_52_3

		if var_52_0.effectName == "all" then
			var_52_3 = true
		end

		local var_52_4 = FightStrUtil.instance:getSplitCache(var_52_0.effectName, "#")
		local var_52_5 = var_0_0.getDefenders(arg_52_0, true)
		local var_52_6 = {}

		for iter_52_0, iter_52_1 in ipairs(var_52_5) do
			if not var_52_6[iter_52_1.id] then
				var_52_6[iter_52_1.id] = true

				if var_0_0.isAssembledMonster(iter_52_1) then
					local var_52_7 = var_0_0.getSideEntitys(iter_52_1:getSide())

					for iter_52_2, iter_52_3 in ipairs(var_52_7) do
						if var_0_0.isAssembledMonster(iter_52_3) and not var_52_6[iter_52_3.id] then
							var_52_6[iter_52_3.id] = true

							table.insert(var_52_5, iter_52_3)
						end
					end
				end
			end
		end

		for iter_52_4, iter_52_5 in ipairs(var_52_5) do
			if var_52_3 then
				local var_52_8 = iter_52_5.skinSpineEffect

				if var_52_8 then
					var_52_1[iter_52_5.id] = iter_52_5.id

					if var_52_8._effectWrapDict then
						for iter_52_6, iter_52_7 in pairs(var_52_8._effectWrapDict) do
							table.insert(var_52_2, iter_52_7)
						end
					end
				end
			end

			local var_52_9 = iter_52_5.buff and iter_52_5.buff._buffEffectDict

			if var_52_9 then
				for iter_52_8, iter_52_9 in pairs(var_52_9) do
					if var_52_3 then
						var_52_1[iter_52_5.id] = iter_52_5.id

						table.insert(var_52_2, iter_52_9)
					else
						for iter_52_10, iter_52_11 in ipairs(var_52_4) do
							if var_0_0.getEffectUrlWithLod(iter_52_11) == iter_52_9.path then
								var_52_1[iter_52_5.id] = iter_52_5.id

								table.insert(var_52_2, iter_52_9)
							end
						end
					end
				end
			end

			local var_52_10 = iter_52_5.buff and iter_52_5.buff._loopBuffEffectWrapDict

			if var_52_10 then
				for iter_52_12, iter_52_13 in pairs(var_52_10) do
					if var_52_3 then
						var_52_1[iter_52_5.id] = iter_52_5.id

						table.insert(var_52_2, iter_52_13)
					else
						for iter_52_14, iter_52_15 in ipairs(var_52_4) do
							if var_0_0.getEffectUrlWithLod(iter_52_15) == iter_52_13.path then
								var_52_1[iter_52_5.id] = iter_52_5.id

								table.insert(var_52_2, iter_52_13)
							end
						end
					end
				end
			end
		end

		local var_52_11 = FightStrUtil.instance:getSplitCache(var_52_0.exceptEffect, "#")
		local var_52_12 = {}

		for iter_52_16, iter_52_17 in ipairs(var_52_11) do
			var_52_12[var_0_0.getEffectUrlWithLod(iter_52_17)] = true
		end

		for iter_52_18, iter_52_19 in ipairs(var_52_2) do
			local var_52_13 = var_52_2[iter_52_18]

			if not var_52_12[var_52_13.path] then
				var_52_13:setActive(false, arg_52_1)
			end
		end
	end

	return var_52_1
end

function var_0_0.revertDefenderBuffEffect(arg_53_0, arg_53_1)
	for iter_53_0, iter_53_1 in ipairs(arg_53_0) do
		local var_53_0 = var_0_0.getEntity(iter_53_1)

		if var_53_0 then
			if var_53_0.buff then
				var_53_0.buff:showBuffEffects(arg_53_1)
			end

			if var_53_0.skinSpineEffect then
				var_53_0.skinSpineEffect:showEffects(arg_53_1)
			end
		end
	end
end

function var_0_0.getEffectAbPath(arg_54_0)
	if GameResMgr.IsFromEditorDir or string.find(arg_54_0, "/buff/") or string.find(arg_54_0, "/always/") then
		return arg_54_0
	else
		if isDebugBuild and string.find(arg_54_0, "always") then
			logError(arg_54_0)
		end

		return SLFramework.FileHelper.GetUnityPath(System.IO.Path.GetDirectoryName(arg_54_0))
	end
end

function var_0_0.getRolesTimelinePath(arg_55_0)
	if GameResMgr.IsFromEditorDir then
		return ResUrl.getSkillTimeline(arg_55_0)
	else
		return ResUrl.getRolesTimeline()
	end
end

function var_0_0.getCameraAniPath(arg_56_0)
	if GameResMgr.IsFromEditorDir then
		return ResUrl.getCameraAnim(arg_56_0)
	else
		return ResUrl.getCameraAnimABUrl()
	end
end

function var_0_0.getEntityAniPath(arg_57_0)
	if GameResMgr.IsFromEditorDir then
		return ResUrl.getEntityAnim(arg_57_0)
	else
		return ResUrl.getEntityAnimABUrl()
	end
end

function var_0_0.refreshCombinativeMonsterScaleAndPos(arg_58_0, arg_58_1)
	local var_58_0 = arg_58_0:getMO()

	if not var_58_0 then
		return
	end

	local var_58_1 = FightConfig.instance:getSkinCO(var_58_0.skin)

	if var_58_1 and var_58_1.canHide == 1 then
		-- block empty
	else
		return
	end

	local var_58_2 = var_0_0.getSideEntitys(arg_58_0:getSide())
	local var_58_3

	for iter_58_0, iter_58_1 in ipairs(var_58_2) do
		iter_58_1:setScale(arg_58_1)

		local var_58_4 = iter_58_1:getMO()

		if var_58_4 then
			local var_58_5 = FightConfig.instance:getSkinCO(var_58_4.skin)

			if var_58_5 and var_58_5.mainBody == 1 then
				var_58_3 = iter_58_1
			end
		end
	end

	if var_58_3 then
		local var_58_6, var_58_7, var_58_8 = var_0_0.getEntityStandPos(var_58_3:getMO())
		local var_58_9, var_58_10, var_58_11 = transformhelper.getPos(var_58_3.go.transform)

		for iter_58_2, iter_58_3 in ipairs(var_58_2) do
			if iter_58_3 ~= var_58_3 then
				local var_58_12, var_58_13, var_58_14 = var_0_0.getEntityStandPos(iter_58_3:getMO())
				local var_58_15 = var_58_12 - var_58_6
				local var_58_16 = var_58_13 - var_58_7
				local var_58_17 = var_58_14 - var_58_8

				transformhelper.setPos(iter_58_3.go.transform, var_58_15 * arg_58_1 + var_58_9, var_58_16 * arg_58_1 + var_58_10, var_58_17 * arg_58_1 + var_58_11)
			end
		end
	end
end

function var_0_0.getEntityDefaultIdleAniName(arg_59_0)
	local var_59_0 = arg_59_0:getMO()

	if var_59_0 and var_59_0.modelId == 3025 then
		local var_59_1 = var_0_0.getSideEntitys(arg_59_0:getSide(), true)

		for iter_59_0, iter_59_1 in ipairs(var_59_1) do
			if iter_59_1:getMO().modelId == 3028 then
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

function var_0_0.preloadXingTiSpecialUrl(arg_60_0)
	if var_0_0.isShowTogether(FightEnum.EntitySide.MySide, {
		3025,
		3028
	}) then
		for iter_60_0, iter_60_1 in ipairs(arg_60_0) do
			if iter_60_1 == 3025 then
				return 2
			end
		end

		return 1
	end
end

function var_0_0.detectXingTiSpecialUrl(arg_61_0)
	if arg_61_0:isMySide() then
		local var_61_0 = arg_61_0:getSide()

		return var_0_0.isShowTogether(var_61_0, {
			3025,
			3028
		})
	end
end

function var_0_0.isShowTogether(arg_62_0, arg_62_1)
	local var_62_0 = FightDataHelper.entityMgr:getSideList(arg_62_0)
	local var_62_1 = 0

	for iter_62_0, iter_62_1 in ipairs(var_62_0) do
		if tabletool.indexOf(arg_62_1, iter_62_1.modelId) then
			var_62_1 = var_62_1 + 1
		end
	end

	if var_62_1 == #arg_62_1 then
		return true
	end
end

function var_0_0.getPredeductionExpoint(arg_63_0)
	local var_63_0 = 0

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate then
		local var_63_1 = var_0_0.getEntity(arg_63_0)

		if var_63_1 then
			local var_63_2 = var_63_1:getMO()
			local var_63_3 = FightDataHelper.operationDataMgr:getOpList()

			for iter_63_0, iter_63_1 in ipairs(var_63_3) do
				if arg_63_0 == iter_63_1.belongToEntityId and iter_63_1:isPlayCard() and FightCardDataHelper.isBigSkill(iter_63_1.skillId) and not FightCardDataHelper.isSkill3(iter_63_1.cardInfoMO) then
					local var_63_4 = true
					local var_63_5 = lua_skill.configDict[iter_63_1.skillId]

					if var_63_5 and var_63_5.needExPoint == 1 then
						var_63_4 = false
					end

					if var_63_4 then
						var_63_0 = var_63_0 + var_63_2:getUniqueSkillPoint()
					end
				end
			end
		end
	end

	return var_63_0
end

function var_0_0.setBossSkillSpeed(arg_64_0)
	local var_64_0 = var_0_0.getEntity(arg_64_0)
	local var_64_1 = var_64_0 and var_64_0:getMO()

	if var_64_1 then
		local var_64_2 = lua_monster_skin.configDict[var_64_1.skin]

		if var_64_2 and var_64_2.bossSkillSpeed == 1 then
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

function var_0_0.setTimelineExclusiveSpeed(arg_66_0)
	local var_66_0 = lua_fight_timeline_speed.configDict[arg_66_0]

	if var_66_0 then
		local var_66_1 = FightModel.instance:getUserSpeed()
		local var_66_2 = FightStrUtil.instance:getSplitToNumberCache(var_66_0.speed, "#")

		FightModel.instance.useExclusiveSpeed = var_66_2[var_66_1]

		FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	end
end

function var_0_0.cancelExclusiveSpeed()
	if FightModel.instance.useExclusiveSpeed then
		FightModel.instance.useExclusiveSpeed = false

		FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	end
end

function var_0_0.needPlayTransitionAni(arg_68_0, arg_68_1)
	local var_68_0 = arg_68_0 and arg_68_0:getMO()

	if var_68_0 then
		local var_68_1 = var_68_0.skin
		local var_68_2 = lua_fight_transition_act.configDict[var_68_1]

		if var_68_2 then
			local var_68_3 = arg_68_0.spine:getAnimState()

			if var_68_2[var_68_3] and var_68_2[var_68_3][arg_68_1] then
				return true, var_68_2[var_68_3][arg_68_1].transitionAct
			end
		end
	end
end

function var_0_0._stepBuffDealStackedBuff(arg_69_0, arg_69_1, arg_69_2, arg_69_3)
	local var_69_0 = false

	if arg_69_3 then
		local var_69_1 = arg_69_3.actEffectData

		if var_69_1 and not FightSkillBuffMgr.instance:hasPlayBuff(var_69_1) then
			local var_69_2 = lua_skill_buff.configDict[var_69_1.buff.buffId]

			if var_69_2 and var_69_2.id == arg_69_2.id and var_69_1.effectType == FightEnum.EffectType.BUFFADD then
				var_69_0 = true
			end
		end
	end

	table.insert(arg_69_1, FunctionWork.New(function()
		local var_70_0 = var_0_0.getEntity(arg_69_0)

		if var_70_0 then
			var_70_0.buff.lockFloat = var_69_0
		end
	end))
	table.insert(arg_69_1, WorkWaitSeconds.New(0.01))
end

function var_0_0.hideAllEntity()
	local var_71_0 = var_0_0.getAllEntitys()

	for iter_71_0, iter_71_1 in ipairs(var_71_0) do
		iter_71_1:setActive(false, true)
		iter_71_1:setVisibleByPos(false)
		iter_71_1:setAlpha(0, 0)
	end
end

function var_0_0.isBossId(arg_72_0, arg_72_1)
	local var_72_0 = FightStrUtil.instance:getSplitToNumberCache(arg_72_0, "#")

	for iter_72_0, iter_72_1 in ipairs(var_72_0) do
		if arg_72_1 == iter_72_1 then
			return true
		end
	end
end

function var_0_0.getCurBossId()
	local var_73_0 = FightModel.instance:getCurMonsterGroupId()
	local var_73_1 = var_73_0 and lua_monster_group.configDict[var_73_0]

	return var_73_1 and not string.nilorempty(var_73_1.bossId) and var_73_1.bossId or nil
end

function var_0_0.checkIsBossByMonsterId(arg_74_0)
	local var_74_0 = var_0_0.getCurBossId()

	if not var_74_0 then
		return false
	end

	return var_0_0.isBossId(var_74_0, arg_74_0)
end

function var_0_0.setEffectEntitySide(arg_75_0, arg_75_1)
	if FightModel.instance:getVersion() >= 1 then
		return
	end

	local var_75_0 = arg_75_0.targetId

	if var_75_0 == FightEntityScene.MySideId then
		arg_75_1.side = FightEnum.EntitySide.MySide

		return
	elseif var_75_0 == FightEntityScene.EnemySideId then
		arg_75_1.side = FightEnum.EntitySide.EnemySide

		return
	end

	local var_75_1 = FightDataHelper.entityMgr:getById(var_75_0)

	if var_75_1 then
		arg_75_1.side = var_75_1.side
	end
end

function var_0_0.preloadZongMaoShaLiMianJu(arg_76_0, arg_76_1)
	local var_76_0 = var_0_0.getZongMaoShaLiMianJuPath(arg_76_0)

	if var_76_0 then
		table.insert(arg_76_1, var_76_0)
	end
end

function var_0_0.setZongMaoShaLiMianJuSpineUrl(arg_77_0, arg_77_1)
	local var_77_0 = var_0_0.getZongMaoShaLiMianJuPath(arg_77_0)

	if var_77_0 then
		arg_77_1[var_77_0] = true
	end
end

function var_0_0.getZongMaoShaLiMianJuPath(arg_78_0)
	local var_78_0 = lua_skin.configDict[arg_78_0]

	if var_78_0 and var_78_0.characterId == 3072 then
		local var_78_1 = string.format("roles/v1a3_%d_zongmaoshali_m/%d_zongmaoshali_m_fight.prefab", arg_78_0, arg_78_0)

		if var_78_0.id == 307203 then
			var_78_1 = "roles/v2a2_307203_zmsl_m/307203_zmsl_m_fight.prefab"
		end

		return var_78_1
	end
end

function var_0_0.getEnemyEntityByMonsterId(arg_79_0)
	local var_79_0 = var_0_0.getSideEntitys(FightEnum.EntitySide.EnemySide)

	for iter_79_0, iter_79_1 in ipairs(var_79_0) do
		local var_79_1 = iter_79_1:getMO()

		if var_79_1 and var_79_1.modelId == arg_79_0 then
			return iter_79_1
		end
	end
end

function var_0_0.sortAssembledMonster(arg_80_0)
	local var_80_0 = arg_80_0:getByIndex(1)

	if var_80_0 and lua_fight_assembled_monster.configDict[var_80_0.skin] then
		arg_80_0:sort(var_0_0.sortAssembledMonsterFunc)
	end
end

function var_0_0.sortAssembledMonsterFunc(arg_81_0, arg_81_1)
	local var_81_0 = arg_81_0 and lua_fight_assembled_monster.configDict[arg_81_0.skin]
	local var_81_1 = arg_81_1 and lua_fight_assembled_monster.configDict[arg_81_1.skin]

	if var_81_0 and not var_81_1 then
		return true
	elseif not var_81_0 and var_81_1 then
		return false
	elseif var_81_0 and var_81_1 then
		return var_81_0.part < var_81_1.part
	else
		return tonumber(arg_81_0.id) > tonumber(arg_81_1.id)
	end
end

function var_0_0.sortBuffReplaceSpineActConfig(arg_82_0, arg_82_1)
	return arg_82_0.priority > arg_82_1.priority
end

function var_0_0.processEntityActionName(arg_83_0, arg_83_1, arg_83_2)
	if not arg_83_1 then
		return
	end

	local var_83_0 = arg_83_0:getMO()

	if var_83_0 then
		local var_83_1 = lua_fight_buff_replace_spine_act.configDict[var_83_0.skin]

		if var_83_1 then
			local var_83_2 = {}

			for iter_83_0, iter_83_1 in pairs(var_83_1) do
				for iter_83_2, iter_83_3 in pairs(iter_83_1) do
					table.insert(var_83_2, iter_83_3)
				end
			end

			table.sort(var_83_2, var_0_0.sortBuffReplaceSpineActConfig)

			local var_83_3 = arg_83_0.buff

			if var_83_3 then
				for iter_83_4, iter_83_5 in ipairs(var_83_2) do
					if var_83_3:haveBuffId(iter_83_5.buffId) then
						local var_83_4 = 0

						for iter_83_6, iter_83_7 in ipairs(iter_83_5.combination) do
							if var_83_3:haveBuffId(iter_83_7) then
								var_83_4 = var_83_4 + 1
							end
						end

						if var_83_4 == #iter_83_5.combination and arg_83_0.spine and arg_83_0.spine:hasAnimation(arg_83_1 .. iter_83_5.suffix) then
							arg_83_1 = arg_83_1 .. iter_83_5.suffix

							break
						end
					end
				end
			end
		end
	end

	if arg_83_1 and var_83_0 then
		local var_83_5 = lua_fight_skin_special_behaviour.configDict[var_83_0.skin]

		if var_83_5 then
			local var_83_6 = arg_83_0.buff

			if var_83_6 then
				local var_83_7 = arg_83_1

				if string.find(var_83_7, "hit") then
					var_83_7 = "hit"
				end

				if not string.nilorempty(var_83_5[var_83_7]) then
					local var_83_8 = GameUtil.splitString2(var_83_5[var_83_7])

					for iter_83_8, iter_83_9 in ipairs(var_83_8) do
						local var_83_9 = tonumber(iter_83_9[1])

						if var_83_6:haveBuffId(var_83_9) then
							arg_83_1 = iter_83_9[2]
						end
					end
				end
			end
		end
	end

	if var_0_0.isAssembledMonster(arg_83_0) and arg_83_1 == "hit" then
		local var_83_10 = arg_83_0:getPartIndex()

		if arg_83_2 then
			for iter_83_10, iter_83_11 in ipairs(arg_83_2.actEffect) do
				if FightTLEventDefHit.directCharacterHitEffectType[iter_83_11.effectType] and iter_83_11.targetId ~= arg_83_0.id then
					local var_83_11 = var_0_0.getEntity(iter_83_11.targetId)

					if isTypeOf(var_83_11, FightEntityAssembledMonsterMain) or isTypeOf(var_83_11, FightEntityAssembledMonsterSub) then
						return arg_83_1
					end
				end
			end
		end

		arg_83_1 = string.format("%s_part_%d", arg_83_1, var_83_10)
	end

	return arg_83_1
end

function var_0_0.getProcessEntityStancePos(arg_84_0)
	local var_84_0, var_84_1, var_84_2 = var_0_0.getEntityStandPos(arg_84_0)
	local var_84_3 = var_0_0.getEntity(arg_84_0.id)

	if var_84_3 and var_0_0.isAssembledMonster(var_84_3) then
		local var_84_4 = lua_fight_assembled_monster.configDict[arg_84_0.skin].virtualStance

		return var_84_0 + var_84_4[1], var_84_1 + var_84_4[2], var_84_2 + var_84_4[3]
	end

	return var_84_0, var_84_1, var_84_2
end

function var_0_0.isAssembledMonster(arg_85_0)
	if isTypeOf(arg_85_0, FightEntityAssembledMonsterMain) or isTypeOf(arg_85_0, FightEntityAssembledMonsterSub) then
		return true
	end
end

function var_0_0.isPata500mMonster(arg_86_0)
	local var_86_0 = arg_86_0 and arg_86_0:getMO()

	if not var_86_0 then
		return false
	end

	return lua_fight_sp_500m_model.configDict[var_86_0.modelId] ~= nil
end

function var_0_0.getProcessEntitySpinePos(arg_87_0)
	local var_87_0, var_87_1, var_87_2 = transformhelper.getPos(arg_87_0.go.transform)

	if var_0_0.isAssembledMonster(arg_87_0) then
		local var_87_3 = arg_87_0:getMO()
		local var_87_4 = lua_fight_assembled_monster.configDict[var_87_3.skin]

		var_87_0 = var_87_0 + var_87_4.virtualStance[1]
		var_87_1 = var_87_1 + var_87_4.virtualStance[2]
		var_87_2 = var_87_2 + var_87_4.virtualStance[3]
	elseif var_0_0.isPata500mMonster(arg_87_0) then
		local var_87_5, var_87_6, var_87_7 = arg_87_0.spine:getCenterSpineOffset()

		var_87_0 = var_87_0 + var_87_5
		var_87_1 = var_87_1 + var_87_6
		var_87_2 = var_87_2 + var_87_7
	end

	return var_87_0, var_87_1, var_87_2
end

function var_0_0.getProcessEntitySpineLocalPos(arg_88_0)
	local var_88_0 = 0
	local var_88_1 = 0
	local var_88_2 = 0

	if var_0_0.isAssembledMonster(arg_88_0) then
		local var_88_3 = arg_88_0:getMO()
		local var_88_4 = lua_fight_assembled_monster.configDict[var_88_3.skin]

		var_88_0 = var_88_0 + var_88_4.virtualStance[1]
		var_88_1 = var_88_1 + var_88_4.virtualStance[2]
		var_88_2 = var_88_2 + var_88_4.virtualStance[3]
	end

	return var_88_0, var_88_1, var_88_2
end

local var_0_6 = {}

function var_0_0.getAssembledEffectPosOfSpineHangPointRoot(arg_89_0, arg_89_1)
	if var_0_6[arg_89_1] then
		return 0, 0, 0
	end

	return var_0_0.getProcessEntitySpineLocalPos(arg_89_0)
end

function var_0_0.processBuffEffectPath(arg_90_0, arg_90_1, arg_90_2, arg_90_3, arg_90_4)
	local var_90_0 = lua_fight_effect_buff_skin.configDict[arg_90_2]

	if var_90_0 then
		local var_90_1 = {
			delEffect = "delAudio",
			effectPath = "audio",
			triggerEffect = "triggerAudio"
		}
		local var_90_2 = arg_90_1:getSide()

		if var_90_0[1] then
			var_90_2 = FightEnum.EntitySide.MySide == var_90_2 and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide
			var_90_0 = var_90_0[1]
		else
			var_90_0 = var_90_0[2]
		end

		local var_90_3 = var_0_0.getSideEntitys(var_90_2, true)

		for iter_90_0, iter_90_1 in ipairs(var_90_3) do
			local var_90_4 = iter_90_1:getMO()

			if var_90_4 then
				local var_90_5 = var_90_4.skin

				if var_90_0[var_90_5] and not string.nilorempty(var_90_0[var_90_5][arg_90_3]) then
					local var_90_6 = var_90_0[var_90_5][var_90_1[arg_90_3]]

					return var_90_0[var_90_5][arg_90_3], var_90_6 ~= 0 and var_90_6 or arg_90_4, var_90_0[var_90_5]
				end
			end
		end
	end

	return arg_90_0, arg_90_4
end

function var_0_0.filterBuffEffectBySkin(arg_91_0, arg_91_1, arg_91_2, arg_91_3)
	local var_91_0 = lua_fight_buff_effect_to_skin.configDict[arg_91_0]

	if not var_91_0 then
		return arg_91_2, arg_91_3
	end

	local var_91_1 = arg_91_1 and arg_91_1:getMO()
	local var_91_2 = var_91_1 and var_91_1.skin

	if not var_91_2 then
		return "", 0
	end

	local var_91_3 = FightStrUtil.instance:getSplitToNumberCache(var_91_0.skinIdList, "|")

	if tabletool.indexOf(var_91_3, var_91_2) then
		return arg_91_2, arg_91_3
	end

	return "", 0
end

function var_0_0.getBuffListForReplaceTimeline(arg_92_0, arg_92_1, arg_92_2)
	local var_92_0 = var_0_0.getEntitysCloneBuff(arg_92_1)

	if arg_92_0 and arg_92_0.simulate == 1 then
		var_92_0 = var_0_0.simulateFightStepData(arg_92_2, var_92_0)
	end

	local var_92_1 = {}

	for iter_92_0, iter_92_1 in pairs(var_92_0) do
		tabletool.addValues(var_92_1, iter_92_1)
	end

	return var_92_1
end

function var_0_0.getTimelineListByName(arg_93_0, arg_93_1)
	local var_93_0 = arg_93_0
	local var_93_1 = {}
	local var_93_2 = lua_fight_replace_timeline.configDict[arg_93_0]

	if var_93_2 then
		for iter_93_0, iter_93_1 in pairs(var_93_2) do
			local var_93_3 = FightStrUtil.instance:getSplitCache(iter_93_1.condition, "#")

			if var_93_3[1] == "5" then
				local var_93_4 = {}

				for iter_93_2 = 2, #var_93_3 do
					var_93_4[tonumber(var_93_3[iter_93_2])] = true
				end

				if var_93_4[arg_93_1] then
					var_93_0 = iter_93_1.timeline
				end
			else
				table.insert(var_93_1, iter_93_1.timeline)
			end
		end
	end

	table.insert(var_93_1, var_93_0)

	return var_93_1
end

local var_0_7 = {}

function var_0_0.detectReplaceTimeline(arg_94_0, arg_94_1)
	local var_94_0 = lua_fight_replace_timeline.configDict[arg_94_0]

	if var_94_0 then
		local var_94_1 = {}

		for iter_94_0, iter_94_1 in pairs(var_94_0) do
			table.insert(var_94_1, iter_94_1)
		end

		table.sort(var_94_1, var_0_0.sortReplaceTimelineConfig)

		for iter_94_2, iter_94_3 in ipairs(var_94_1) do
			local var_94_2 = {}

			if iter_94_3.target == 1 then
				var_94_2[arg_94_1.fromId] = FightDataHelper.entityMgr:getById(arg_94_1.fromId)
			elseif iter_94_3.target == 2 then
				var_94_2[arg_94_1.toId] = FightDataHelper.entityMgr:getById(arg_94_1.toId)
			elseif iter_94_3.target == 3 or iter_94_3.target == 4 then
				local var_94_3
				local var_94_4 = arg_94_1.fromId

				if var_94_4 == FightEntityScene.MySideId then
					var_94_3 = FightEnum.EntitySide.MySide
				elseif var_94_4 == FightEntityScene.EnemySideId then
					var_94_3 = FightEnum.EntitySide.EnemySide
				else
					local var_94_5 = FightDataHelper.entityMgr:getById(arg_94_1.fromId)

					if var_94_5 then
						var_94_3 = var_94_5.side
					else
						var_94_3 = FightEnum.EntitySide.MySide
					end
				end

				local var_94_6 = FightDataHelper.entityMgr:getSideList(var_94_3, nil, iter_94_3.target == 4)

				for iter_94_4, iter_94_5 in ipairs(var_94_6) do
					var_94_2[iter_94_5.id] = iter_94_5
				end
			end

			local var_94_7 = FightStrUtil.instance:getSplitCache(iter_94_3.condition, "#")
			local var_94_8 = var_94_7[1]

			if var_94_8 == "1" then
				local var_94_9 = var_0_0.getBuffListForReplaceTimeline(iter_94_3, var_94_2, arg_94_1)
				local var_94_10 = tonumber(var_94_7[2])
				local var_94_11 = tonumber(var_94_7[3])

				for iter_94_6, iter_94_7 in ipairs(var_94_9) do
					if iter_94_7.buffId == var_94_10 and var_94_11 <= iter_94_7.count then
						return iter_94_3.timeline
					end
				end
			elseif var_94_8 == "2" then
				for iter_94_8, iter_94_9 in pairs(arg_94_1.actEffect) do
					if iter_94_9.effectType == FightEnum.EffectType.DEAD then
						return iter_94_3.timeline
					end
				end
			elseif var_94_8 == "3" then
				local var_94_12 = var_0_0.getBuffListForReplaceTimeline(iter_94_3, var_94_2, arg_94_1)

				for iter_94_10 = 2, #var_94_7 do
					if var_0_0.detectEntityIncludeBuffType(nil, tonumber(var_94_7[iter_94_10]), var_94_12) then
						return iter_94_3.timeline
					end
				end
			elseif var_94_8 == "4" then
				local var_94_13 = {}

				for iter_94_11 = 2, #var_94_7 do
					var_94_13[tonumber(var_94_7[iter_94_11])] = true
				end

				local var_94_14 = var_0_0.getBuffListForReplaceTimeline(iter_94_3, var_94_2, arg_94_1)

				for iter_94_12, iter_94_13 in ipairs(var_94_14) do
					if var_94_13[iter_94_13.buffId] then
						return iter_94_3.timeline
					end
				end
			elseif var_94_8 == "5" then
				local var_94_15 = {}

				for iter_94_14 = 2, #var_94_7 do
					var_94_15[tonumber(var_94_7[iter_94_14])] = true
				end

				for iter_94_15, iter_94_16 in pairs(var_94_2) do
					local var_94_16 = iter_94_16.skin

					if iter_94_3.target == 1 then
						var_94_16 = var_0_0.processSkinByStepData(arg_94_1, iter_94_16)
					end

					if iter_94_16 and var_94_15[var_94_16] then
						return iter_94_3.timeline
					end
				end
			elseif var_94_8 == "6" then
				local var_94_17 = {}

				for iter_94_17 = 2, #var_94_7 do
					var_94_17[tonumber(var_94_7[iter_94_17])] = true
				end

				for iter_94_18, iter_94_19 in ipairs(arg_94_1.actEffect) do
					if var_94_2[iter_94_19.targetId] and var_94_17[iter_94_19.configEffect] then
						return iter_94_3.timeline
					end
				end
			elseif var_94_8 == "7" then
				local var_94_18 = {}

				for iter_94_20 = 2, #var_94_7 do
					var_94_18[tonumber(var_94_7[iter_94_20])] = true
				end

				local var_94_19 = var_0_0.getBuffListForReplaceTimeline(iter_94_3, var_94_2, arg_94_1)

				for iter_94_21, iter_94_22 in ipairs(var_94_19) do
					if var_94_18[iter_94_22.buffId] then
						return arg_94_0
					end
				end

				return iter_94_3.timeline
			elseif var_94_8 == "8" then
				local var_94_20 = tonumber(var_94_7[2])
				local var_94_21 = tonumber(var_94_7[3])
				local var_94_22 = var_0_0.getEntitysCloneBuff(var_94_2)

				if iter_94_3.simulate == 1 then
					local var_94_23 = var_0_0.getBuffListForReplaceTimeline(nil, var_94_2, arg_94_1)

					for iter_94_23, iter_94_24 in ipairs(var_94_23) do
						if iter_94_24.buffId == var_94_20 and var_94_21 <= iter_94_24.count then
							return iter_94_3.timeline
						end
					end

					if var_0_0.simulateFightStepData(arg_94_1, var_94_22, var_0_0.detectBuffCountEnough, {
						buffId = var_94_20,
						count = var_94_21
					}) == true then
						return iter_94_3.timeline
					end
				else
					local var_94_24 = var_0_0.getBuffListForReplaceTimeline(iter_94_3, var_94_2, arg_94_1)

					for iter_94_25, iter_94_26 in ipairs(var_94_24) do
						if iter_94_26.buffId == var_94_20 and var_94_21 <= iter_94_26.count then
							return iter_94_3.timeline
						end
					end
				end
			elseif var_94_8 == "9" then
				local var_94_25 = {}

				for iter_94_27, iter_94_28 in ipairs(var_94_1) do
					local var_94_26 = tonumber(string.split(iter_94_28.condition, "#")[2])

					for iter_94_29, iter_94_30 in pairs(var_94_2) do
						local var_94_27 = iter_94_30.skin

						if iter_94_3.target == 1 then
							var_94_27 = var_0_0.processSkinByStepData(arg_94_1, iter_94_30)
						end

						if var_94_27 == var_94_26 then
							table.insert(var_94_25, iter_94_28)
						end
					end
				end

				local var_94_28 = #var_94_25

				if var_94_28 > 1 then
					local var_94_29 = var_0_7[arg_94_0]

					while true do
						local var_94_30 = math.random(1, var_94_28)

						if var_94_30 ~= var_94_29 then
							var_0_7[arg_94_0] = var_94_30

							return var_94_25[var_94_30].timeline
						end
					end
				elseif var_94_28 > 0 then
					return var_94_25[1].timeline
				end
			elseif var_94_8 == "10" then
				local var_94_31 = tonumber(var_94_7[2])

				if var_94_31 == 1 then
					if arg_94_1.fromId == arg_94_1.toId then
						return iter_94_3.timeline
					end
				elseif var_94_31 == 2 and arg_94_1.fromId ~= arg_94_1.toId then
					return iter_94_3.timeline
				end
			elseif var_94_8 == "11" then
				local var_94_32 = {}
				local var_94_33 = tonumber(var_94_7[2])

				for iter_94_31 = 3, #var_94_7 do
					var_94_32[tonumber(var_94_7[iter_94_31])] = true
				end

				for iter_94_32, iter_94_33 in pairs(var_94_2) do
					local var_94_34 = iter_94_33.skin

					if iter_94_3.target == 1 then
						var_94_34 = var_0_0.processSkinByStepData(arg_94_1, iter_94_33)
					end

					if var_94_33 == var_94_34 then
						local var_94_35 = var_0_0.getBuffListForReplaceTimeline(iter_94_3, var_94_2, arg_94_1)

						for iter_94_34, iter_94_35 in ipairs(var_94_35) do
							if var_94_32[iter_94_35.buffId] then
								return iter_94_3.timeline
							end
						end
					end
				end
			elseif var_94_8 == "12" then
				local var_94_36 = {}

				for iter_94_36 = 2, #var_94_7 - 1 do
					var_94_36[tonumber(var_94_7[iter_94_36])] = true
				end

				for iter_94_37, iter_94_38 in pairs(var_94_2) do
					local var_94_37 = iter_94_38.skin

					if iter_94_3.target == 1 then
						var_94_37 = var_0_0.processSkinByStepData(arg_94_1, iter_94_38)
					end

					if iter_94_38 and var_94_36[var_94_37] then
						local var_94_38 = var_94_7[#var_94_7]

						if var_94_38 == "1" then
							if arg_94_1.fromId == arg_94_1.toId then
								return iter_94_3.timeline
							end
						elseif var_94_38 == "2" then
							local var_94_39 = FightDataHelper.entityMgr:getById(arg_94_1.fromId)
							local var_94_40 = FightDataHelper.entityMgr:getById(arg_94_1.toId)

							if var_94_39 and var_94_40 and var_94_39.id ~= var_94_40.id and var_94_39.side == var_94_40.side then
								return iter_94_3.timeline
							end
						elseif var_94_38 == "3" then
							local var_94_41 = FightDataHelper.entityMgr:getById(arg_94_1.fromId)
							local var_94_42 = FightDataHelper.entityMgr:getById(arg_94_1.toId)

							if var_94_41 and var_94_42 and var_94_41.side ~= var_94_42.side then
								return iter_94_3.timeline
							end
						end
					end
				end
			end
		end
	end

	return arg_94_0
end

function var_0_0.detectBuffCountEnough(arg_95_0, arg_95_1)
	local var_95_0 = arg_95_1.buffId
	local var_95_1 = arg_95_1.count

	for iter_95_0, iter_95_1 in ipairs(arg_95_0) do
		if var_95_0 == iter_95_1.buffId and var_95_1 <= iter_95_1.count then
			return true
		end
	end
end

function var_0_0.simulateFightStepData(arg_96_0, arg_96_1, arg_96_2, arg_96_3)
	for iter_96_0, iter_96_1 in ipairs(arg_96_0.actEffect) do
		local var_96_0 = iter_96_1.targetId
		local var_96_1 = var_0_0.getEntity(var_96_0)
		local var_96_2 = var_96_1 and var_96_1:getMO()
		local var_96_3 = arg_96_1 and arg_96_1[var_96_0]

		if var_96_2 and var_96_3 then
			if iter_96_1.effectType == FightEnum.EffectType.BUFFADD then
				if not var_96_2:getBuffMO(iter_96_1.buff.uid) then
					local var_96_4 = FightBuffInfoData.New(iter_96_1.buff, iter_96_1.targetId)

					table.insert(var_96_3, var_96_4)
				end

				if arg_96_2 and arg_96_2(var_96_3, arg_96_3) then
					return true
				end
			elseif iter_96_1.effectType == FightEnum.EffectType.BUFFDEL or iter_96_1.effectType == FightEnum.EffectType.BUFFDELNOEFFECT then
				for iter_96_2, iter_96_3 in ipairs(var_96_3) do
					if iter_96_3.uid == iter_96_1.buff.uid then
						table.remove(var_96_3, iter_96_2)

						break
					end
				end

				if arg_96_2 and arg_96_2(var_96_3, arg_96_3) then
					return true
				end
			elseif iter_96_1.effectType == FightEnum.EffectType.BUFFUPDATE then
				for iter_96_4, iter_96_5 in ipairs(var_96_3) do
					if iter_96_5.uid == iter_96_1.buff.uid then
						FightDataUtil.coverData(iter_96_1.buff, iter_96_5)
					end
				end

				if arg_96_2 and arg_96_2(var_96_3, arg_96_3) then
					return true
				end
			end
		end
	end

	return arg_96_1
end

function var_0_0.getEntitysCloneBuff(arg_97_0)
	local var_97_0 = {}

	for iter_97_0, iter_97_1 in pairs(arg_97_0) do
		local var_97_1 = {}
		local var_97_2 = iter_97_1:getBuffList()

		for iter_97_2, iter_97_3 in ipairs(var_97_2) do
			local var_97_3 = iter_97_3:clone()

			table.insert(var_97_1, var_97_3)
		end

		var_97_0[iter_97_1.id] = var_97_1
	end

	return var_97_0
end

function var_0_0.sortReplaceTimelineConfig(arg_98_0, arg_98_1)
	return arg_98_0.priority < arg_98_1.priority
end

function var_0_0.getMagicSide(arg_99_0)
	local var_99_0 = FightDataHelper.entityMgr:getById(arg_99_0)

	if var_99_0 then
		return var_99_0.side
	elseif arg_99_0 == FightEntityScene.MySideId then
		return FightEnum.EntitySide.MySide
	elseif arg_99_0 == FightEntityScene.EnemySideId then
		return FightEnum.EntitySide.EnemySide
	end

	return FightEnum.EntitySide.MySide
end

function var_0_0.isBossRushChannelSkill(arg_100_0)
	local var_100_0 = lua_skill.configDict[arg_100_0]

	if var_100_0 then
		local var_100_1 = var_100_0.skillEffect
		local var_100_2 = lua_skill_effect.configDict[var_100_1]

		if var_100_2 then
			for iter_100_0 = 1, FightEnum.MaxBehavior do
				local var_100_3 = var_100_2["behavior" .. iter_100_0]

				if not string.nilorempty(var_100_3) then
					local var_100_4 = FightStrUtil.instance:getSplitCache(var_100_3, "#")

					if var_100_4[1] == "1" then
						local var_100_5 = tonumber(var_100_4[2])
						local var_100_6 = lua_skill_buff.configDict[var_100_5]

						if var_100_6 then
							local var_100_7 = FightStrUtil.instance:getSplitCache(var_100_6.features, "#")

							if var_100_7[1] == "742" then
								return true, tonumber(var_100_7[2]), tonumber(var_100_7[5])
							end
						end
					end
				end
			end
		end
	end
end

function var_0_0.processEntitySkin(arg_101_0, arg_101_1)
	local var_101_0 = HeroModel.instance:getById(arg_101_1)

	if var_101_0 and var_101_0.skin > 0 then
		return var_101_0.skin
	end

	return arg_101_0
end

function var_0_0.isPlayerCardSkill(arg_102_0)
	if not arg_102_0.cardIndex then
		return
	end

	if arg_102_0.cardIndex == 0 then
		return
	end

	local var_102_0 = arg_102_0.fromId

	if var_102_0 == FightEntityScene.MySideId then
		return true
	end

	local var_102_1 = FightDataHelper.entityMgr:getById(var_102_0)

	if not var_102_1 then
		return
	end

	return var_102_1.teamType == FightEnum.TeamType.MySide
end

function var_0_0.isEnemyCardSkill(arg_103_0)
	if not arg_103_0.cardIndex then
		return
	end

	if arg_103_0.cardIndex == 0 then
		return
	end

	local var_103_0 = arg_103_0.fromId

	if var_103_0 == FightEntityScene.EnemySideId then
		return true
	end

	local var_103_1 = FightDataHelper.entityMgr:getById(var_103_0)

	if not var_103_1 then
		return
	end

	return var_103_1.teamType == FightEnum.TeamType.EnemySide
end

function var_0_0.buildMonsterA2B(arg_104_0, arg_104_1, arg_104_2, arg_104_3)
	local var_104_0 = lua_fight_boss_evolution_client.configDict[arg_104_1.skin]

	arg_104_2:addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.BeforeMonsterA2B, arg_104_1.modelId))

	if var_104_0 then
		arg_104_2:addWork(Work2FightWork.New(FightWorkPlayTimeline, arg_104_0, var_104_0.timeline))

		if var_104_0.nextSkinId ~= 0 then
			arg_104_2:registWork(FightWorkFunction, var_0_0.setBossEvolution, var_0_0, arg_104_0, var_104_0)
		else
			arg_104_2:registWork(FightWorkFunction, var_0_0.removeEntity, arg_104_0.id)
		end
	end

	if arg_104_3 then
		arg_104_2:addWork(arg_104_3)
	end

	arg_104_2:addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.AfterMonsterA2B, arg_104_1.modelId))
end

function var_0_0.removeEntity(arg_105_0)
	local var_105_0 = GameSceneMgr.instance:getCurScene().entityMgr
	local var_105_1 = var_0_0.getEntity(arg_105_0)

	if var_105_1 then
		var_105_0:removeUnit(var_105_1:getTag(), var_105_1.id)
	end
end

function var_0_0.setBossEvolution(arg_106_0, arg_106_1, arg_106_2)
	FightController.instance:dispatchEvent(FightEvent.SetBossEvolution, arg_106_1, arg_106_2.nextSkinId)
	FightMsgMgr.sendMsg(FightMsgId.SetBossEvolution, arg_106_1, arg_106_2.nextSkinId)

	local var_106_0 = GameSceneMgr.instance:getCurScene().entityMgr

	if var_0_0.getEntity(arg_106_1.id) == arg_106_1 then
		var_106_0:removeUnitData(arg_106_1:getTag(), arg_106_1.id)
	end
end

function var_0_0.buildDeadPerformanceWork(arg_107_0, arg_107_1)
	local var_107_0 = FlowSequence.New()

	for iter_107_0 = 1, FightEnum.DeadPerformanceMaxNum do
		local var_107_1 = arg_107_0["actType" .. iter_107_0]
		local var_107_2 = arg_107_0["actParam" .. iter_107_0]

		if var_107_1 == 0 then
			break
		end

		if var_107_1 == 1 then
			var_107_0:addWork(FightWorkPlayTimeline.New(arg_107_1, var_107_2))
		elseif var_107_1 == 2 then
			var_107_0:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.DeadPerformanceNoCondition, tonumber(var_107_2)))
		end
	end

	return var_107_0
end

function var_0_0.compareData(arg_108_0, arg_108_1, arg_108_2)
	local var_108_0 = type(arg_108_0)

	if var_108_0 == "function" then
		return true
	elseif var_108_0 == "table" then
		for iter_108_0, iter_108_1 in pairs(arg_108_0) do
			local var_108_1 = false

			if type(iter_108_0) == "table" then
				var_108_1 = true
			end

			if arg_108_2 and arg_108_2[iter_108_0] then
				var_108_1 = true
			end

			if not arg_108_1 then
				return false
			end

			if type(arg_108_1) ~= "table" then
				return false
			end

			if not var_108_1 and not var_0_0.compareData(iter_108_1, arg_108_1[iter_108_0], arg_108_2) then
				return false, iter_108_0, iter_108_1, arg_108_1[iter_108_0]
			end
		end

		return true
	else
		return arg_108_0 == arg_108_1
	end
end

local var_0_8 = 0

function var_0_0.logStr(arg_109_0, arg_109_1)
	local var_109_0 = ""

	var_0_8 = 0

	if type(arg_109_0) == "table" then
		var_109_0 = var_109_0 .. var_0_0.logTable(arg_109_0, arg_109_1)
	else
		var_109_0 = var_109_0 .. tostring(arg_109_0)
	end

	return var_109_0
end

function var_0_0.logTable(arg_110_0, arg_110_1)
	local var_110_0 = "" .. "{\n"

	var_0_8 = var_0_8 + 1

	local var_110_1 = tabletool.len(arg_110_0)
	local var_110_2 = 0

	for iter_110_0, iter_110_1 in pairs(arg_110_0) do
		local var_110_3 = false

		if arg_110_1 and arg_110_1[iter_110_0] then
			var_110_3 = true
		end

		if not var_110_3 then
			for iter_110_2 = 1, var_0_8 do
				var_110_0 = var_110_0 .. "\t"
			end

			var_110_0 = var_110_0 .. iter_110_0 .. " = "

			if type(iter_110_1) == "table" then
				var_110_0 = var_110_0 .. var_0_0.logTable(iter_110_1, arg_110_1)
			else
				var_110_0 = var_110_0 .. tostring(iter_110_1)
			end

			var_110_2 = var_110_2 + 1

			if var_110_2 < var_110_1 then
				var_110_0 = var_110_0 .. ","
			end

			var_110_0 = var_110_0 .. "\n"
		end
	end

	var_0_8 = var_0_8 - 1

	for iter_110_3 = 1, var_0_8 do
		var_110_0 = var_110_0 .. "\t"
	end

	return var_110_0 .. "}"
end

function var_0_0.deepCopySimpleWithMeta(arg_111_0, arg_111_1)
	if type(arg_111_0) ~= "table" then
		return arg_111_0
	else
		local var_111_0 = {}

		for iter_111_0, iter_111_1 in pairs(arg_111_0) do
			local var_111_1 = false

			if arg_111_1 and arg_111_1[iter_111_0] then
				var_111_1 = true
			end

			if not var_111_1 then
				var_111_0[iter_111_0] = var_0_0.deepCopySimpleWithMeta(iter_111_1, arg_111_1)
			end
		end

		local var_111_2 = getmetatable(arg_111_0)

		if var_111_2 then
			setmetatable(var_111_0, var_111_2)
		end

		return var_111_0
	end
end

function var_0_0.getPassiveSkill(arg_112_0, arg_112_1)
	local var_112_0 = FightDataHelper.entityMgr:getById(arg_112_0)

	if not var_112_0 then
		return arg_112_1
	end

	local var_112_1 = var_112_0.upgradedOptions

	if var_112_1 then
		for iter_112_0, iter_112_1 in pairs(var_112_1) do
			local var_112_2 = lua_hero_upgrade_options.configDict[iter_112_1]

			if var_112_2 and not string.nilorempty(var_112_2.replacePassiveSkill) then
				local var_112_3 = GameUtil.splitString2(var_112_2.replacePassiveSkill, true)

				for iter_112_2, iter_112_3 in ipairs(var_112_3) do
					if arg_112_1 == iter_112_3[1] and var_112_0:isPassiveSkill(iter_112_3[2]) then
						return iter_112_3[2]
					end
				end
			end
		end
	end

	return arg_112_1
end

function var_0_0.isSupportCard(arg_113_0)
	if arg_113_0.cardType == FightEnum.CardType.SUPPORT_NORMAL or arg_113_0.cardType == FightEnum.CardType.SUPPORT_EX then
		return true
	end
end

function var_0_0.curIsRougeFight()
	local var_114_0 = FightModel.instance:getFightParam()

	if not var_114_0 then
		return false
	end

	local var_114_1 = var_114_0.chapterId
	local var_114_2 = DungeonConfig.instance:getChapterCO(var_114_1)

	return var_114_2 and var_114_2.type == DungeonEnum.ChapterType.Rouge
end

function var_0_0.processSkinByStepData(arg_115_0, arg_115_1)
	arg_115_1 = arg_115_1 or FightDataHelper.entityMgr:getById(arg_115_0.fromId)

	local var_115_0 = arg_115_0.supportHeroId

	if var_115_0 ~= 0 and arg_115_1 and arg_115_1.modelId ~= var_115_0 then
		if var_0_0.curIsRougeFight() then
			local var_115_1 = RougeModel.instance:getTeamInfo()
			local var_115_2 = var_115_1 and var_115_1:getAssistHeroMo(var_115_0)

			if var_115_2 then
				return var_115_2.skin
			end
		end

		local var_115_3 = HeroModel.instance:getByHeroId(var_115_0)

		if var_115_3 and var_115_3.skin > 0 then
			return var_115_3.skin
		else
			local var_115_4 = lua_character.configDict[var_115_0]

			if var_115_4 then
				return var_115_4.skinId
			end
		end
	end

	return arg_115_1 and arg_115_1.skin or 0
end

function var_0_0.processSkinId(arg_116_0, arg_116_1)
	if (arg_116_1.cardType == FightEnum.CardType.SUPPORT_NORMAL or arg_116_1.cardType == FightEnum.CardType.SUPPORT_EX) and arg_116_1.heroId ~= arg_116_0.modelId then
		local var_116_0 = HeroModel.instance:getByHeroId(arg_116_1.heroId)

		if var_116_0 and var_116_0.skin > 0 then
			return var_116_0.skin
		else
			local var_116_1 = lua_character.configDict[arg_116_1.heroId]

			if var_116_1 then
				return var_116_1.skinId
			end
		end
	end

	return arg_116_0.skin
end

function var_0_0.processNextSkillId(arg_117_0)
	local var_117_0 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if var_117_0 and var_117_0.type == DungeonEnum.EpisodeType.Rouge then
		local var_117_1 = FightModel.instance:getRougeExData(FightEnum.ExIndexForRouge.SupportHeroSkill)

		if var_117_1 then
			local var_117_2 = cjson.decode(var_117_1)

			for iter_117_0, iter_117_1 in pairs(var_117_2) do
				if iter_117_1.skill1 then
					for iter_117_2, iter_117_3 in ipairs(iter_117_1.skill1) do
						local var_117_3 = iter_117_1.skill1[iter_117_2 + 1]

						if iter_117_3 == arg_117_0 and var_117_3 then
							return var_117_3
						end
					end
				end

				if iter_117_1.skill2 then
					for iter_117_4, iter_117_5 in ipairs(iter_117_1.skill2) do
						local var_117_4 = iter_117_1.skill2[iter_117_4 + 1]

						if iter_117_5 == arg_117_0 and var_117_4 then
							return var_117_4
						end
					end
				end
			end
		end
	end
end

function var_0_0.isTimelineStep(arg_118_0)
	if arg_118_0 and arg_118_0.actType == FightEnum.ActType.SKILL then
		local var_118_0 = FightDataHelper.entityMgr:getById(arg_118_0.fromId)
		local var_118_1 = var_118_0 and var_118_0.skin
		local var_118_2 = FightConfig.instance:getSkinSkillTimeline(var_118_1, arg_118_0.actId)

		if not string.nilorempty(var_118_2) then
			return true
		end
	end
end

function var_0_0.getClickEntity(arg_119_0, arg_119_1, arg_119_2)
	table.sort(arg_119_0, var_0_0.sortEntityList)

	for iter_119_0, iter_119_1 in ipairs(arg_119_0) do
		local var_119_0 = iter_119_1:getMO()

		if var_119_0 then
			local var_119_1
			local var_119_2
			local var_119_3
			local var_119_4
			local var_119_5
			local var_119_6
			local var_119_7
			local var_119_8
			local var_119_9 = var_0_0.getEntity(var_119_0.id)

			if isTypeOf(var_119_9, FightEntityAssembledMonsterMain) or isTypeOf(var_119_9, FightEntityAssembledMonsterSub) then
				local var_119_10 = lua_fight_assembled_monster.configDict[var_119_0.skin]
				local var_119_11, var_119_12, var_119_13 = transformhelper.getPos(iter_119_1.go.transform)
				local var_119_14 = var_119_11 + var_119_10.virtualSpinePos[1]
				local var_119_15 = var_119_12 + var_119_10.virtualSpinePos[2]
				local var_119_16 = var_119_13 + var_119_10.virtualSpinePos[3]

				var_119_7, var_119_8 = recthelper.worldPosToAnchorPosXYZ(var_119_14, var_119_15, var_119_16, arg_119_1)

				local var_119_17 = var_119_10.virtualSpineSize[1] * 0.5
				local var_119_18 = var_119_10.virtualSpineSize[2] * 0.5
				local var_119_19 = var_119_14 - var_119_17
				local var_119_20 = var_119_15 - var_119_18
				local var_119_21 = var_119_16
				local var_119_22 = var_119_14 + var_119_17
				local var_119_23 = var_119_15 + var_119_18
				local var_119_24 = var_119_16
				local var_119_25, var_119_26, var_119_27 = recthelper.worldPosToAnchorPosXYZ(var_119_19, var_119_20, var_119_21, arg_119_1)
				local var_119_28, var_119_29, var_119_30 = recthelper.worldPosToAnchorPosXYZ(var_119_22, var_119_23, var_119_24, arg_119_1)
				local var_119_31 = (var_119_28 - var_119_25) / 2

				var_119_2 = var_119_7 - var_119_31
				var_119_3 = var_119_7 + var_119_31

				local var_119_32 = (var_119_29 - var_119_26) / 2

				var_119_5 = var_119_8 - var_119_32
				var_119_6 = var_119_8 + var_119_32
			else
				local var_119_33, var_119_34, var_119_35, var_119_36 = var_0_0.calcRect(iter_119_1, arg_119_1)
				local var_119_37 = iter_119_1:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle)

				if var_119_37 then
					local var_119_38, var_119_39, var_119_40 = transformhelper.getPos(var_119_37.transform)

					var_119_7, var_119_8 = recthelper.worldPosToAnchorPosXYZ(var_119_38, var_119_39, var_119_40, arg_119_1)
				else
					var_119_7 = (var_119_33 + var_119_35) / 2
					var_119_8 = (var_119_34 + var_119_36) / 2
				end

				local var_119_41 = math.abs(var_119_33 - var_119_35)
				local var_119_42 = math.abs(var_119_34 - var_119_36)
				local var_119_43 = lua_monster_skin.configDict[var_119_0.skin]
				local var_119_44 = var_119_43 and var_119_43.clickBoxUnlimit == 1
				local var_119_45 = var_119_44 and 800 or 200
				local var_119_46 = var_119_44 and 800 or 500
				local var_119_47 = Mathf.Clamp(var_119_41, 150, var_119_45)
				local var_119_48 = Mathf.Clamp(var_119_42, 150, var_119_46)
				local var_119_49 = var_119_47 / 2

				var_119_2 = var_119_7 - var_119_49
				var_119_3 = var_119_7 + var_119_49

				local var_119_50 = var_119_48 / 2

				var_119_5 = var_119_8 - var_119_50
				var_119_6 = var_119_8 + var_119_50
			end

			local var_119_51, var_119_52 = recthelper.screenPosToAnchorPos2(arg_119_2, arg_119_1)

			if var_119_2 <= var_119_51 and var_119_51 <= var_119_3 and var_119_5 <= var_119_52 and var_119_52 <= var_119_6 then
				return iter_119_1.id, var_119_7, var_119_8
			end
		end
	end
end

var_0_0.TempSize = {
	x = 0,
	y = 0
}

function var_0_0.calcRect(arg_120_0, arg_120_1)
	if not arg_120_0 then
		return 10000, 10000, 10000, 10000
	end

	local var_120_0 = arg_120_0:getHangPoint(ModuleEnum.SpineHangPoint.BodyStatic)

	if not var_120_0 then
		return 10000, 10000, 10000, 10000
	end

	local var_120_1, var_120_2, var_120_3 = transformhelper.getPos(var_120_0.transform)
	local var_120_4 = arg_120_0:getMO()
	local var_120_5 = var_120_4 and var_120_4.skin
	local var_120_6 = var_120_5 and lua_monster_skin_custom_click_box.configDict[var_120_5]
	local var_120_7

	if var_120_6 then
		var_120_7 = FightStrUtil.instance:getSplitToNumberCache(var_120_6.box, "#")
		var_0_0.TempSize.x = var_120_7[1]
		var_0_0.TempSize.y = var_120_7[2]
		var_120_7 = var_0_0.TempSize
	else
		var_120_7 = var_0_0.getEntityBoxSizeOffsetV2(arg_120_0)
	end

	local var_120_8 = arg_120_0:isMySide() and 1 or -1
	local var_120_9, var_120_10 = recthelper.worldPosToAnchorPosXYZ(var_120_1 - var_120_7.x * 0.5, var_120_2 - var_120_7.y * 0.5 * var_120_8, var_120_3, arg_120_1)
	local var_120_11, var_120_12 = recthelper.worldPosToAnchorPosXYZ(var_120_1 + var_120_7.x * 0.5, var_120_2 + var_120_7.y * 0.5 * var_120_8, var_120_3, arg_120_1)

	return var_120_9, var_120_10, var_120_11, var_120_12
end

function var_0_0.sortEntityList(arg_121_0, arg_121_1)
	local var_121_0 = arg_121_0:getMO()
	local var_121_1 = arg_121_1:getMO()
	local var_121_2 = isTypeOf(arg_121_0, FightEntityAssembledMonsterMain) or isTypeOf(arg_121_0, FightEntityAssembledMonsterSub)
	local var_121_3 = isTypeOf(arg_121_1, FightEntityAssembledMonsterMain) or isTypeOf(arg_121_1, FightEntityAssembledMonsterSub)

	if var_121_2 and var_121_3 then
		local var_121_4 = lua_fight_assembled_monster.configDict[var_121_0.skin]
		local var_121_5 = lua_fight_assembled_monster.configDict[var_121_1.skin]

		return var_121_4.clickIndex > var_121_5.clickIndex
	elseif var_121_2 and not var_121_3 then
		return true
	elseif not var_121_2 and var_121_3 then
		return false
	else
		local var_121_6, var_121_7, var_121_8 = var_0_0.getEntityStandPos(var_121_0)
		local var_121_9, var_121_10, var_121_11 = var_0_0.getEntityStandPos(var_121_1)

		if var_121_8 ~= var_121_11 then
			return var_121_8 < var_121_11
		else
			return tonumber(var_121_0.id) > tonumber(var_121_1.id)
		end
	end
end

function var_0_0.sortNextRoundGetCardConfig(arg_122_0, arg_122_1)
	return arg_122_0.priority > arg_122_1.priority
end

function var_0_0.sortNextRoundGetCard(arg_123_0, arg_123_1)
	return arg_123_0.index < arg_123_1.index
end

function var_0_0.getNextRoundGetCardList()
	local var_124_0 = {}
	local var_124_1 = {}
	local var_124_2 = FightDataHelper.operationDataMgr:getOpList()

	for iter_124_0, iter_124_1 in ipairs(var_124_2) do
		if iter_124_1:isPlayCard() then
			local var_124_3 = iter_124_1.skillId
			local var_124_4 = lua_fight_next_round_get_card.configDict[var_124_3]

			if var_124_4 then
				local var_124_5 = {}

				for iter_124_2, iter_124_3 in pairs(var_124_4) do
					table.insert(var_124_5, iter_124_3)
				end

				table.sort(var_124_5, var_0_0.sortNextRoundGetCardConfig)

				for iter_124_4, iter_124_5 in ipairs(var_124_5) do
					local var_124_6 = iter_124_5.condition

					if var_0_0.checkNextRoundCardCondition(iter_124_1, var_124_6) then
						if iter_124_5.exclusion ~= 0 then
							var_124_0[iter_124_5.exclusion] = var_124_0[iter_124_5.exclusion] or {}
							var_124_0[iter_124_5.exclusion].index = iter_124_0
							var_124_0[iter_124_5.exclusion].skillId = iter_124_5.skillId
							var_124_0[iter_124_5.exclusion].entityId = iter_124_1.belongToEntityId
							var_124_0[iter_124_5.exclusion].tempCard = iter_124_5.tempCard

							break
						end

						local var_124_7 = {
							index = iter_124_0,
							skillId = iter_124_5.skillId,
							entityId = iter_124_1.belongToEntityId,
							tempCard = iter_124_5.tempCard
						}

						table.insert(var_124_1, var_124_7)

						break
					end
				end
			end
		end
	end

	for iter_124_6, iter_124_7 in pairs(var_124_0) do
		table.insert(var_124_1, iter_124_7)
	end

	table.sort(var_124_1, var_0_0.sortNextRoundGetCard)

	local var_124_8 = {}

	for iter_124_8, iter_124_9 in ipairs(var_124_1) do
		local var_124_9 = string.splitToNumber(iter_124_9.skillId, "#")

		for iter_124_10, iter_124_11 in ipairs(var_124_9) do
			local var_124_10 = {
				uid = iter_124_9.entityId,
				skillId = iter_124_11,
				tempCard = iter_124_9.tempCard
			}
			local var_124_11 = FightCardInfoData.New(var_124_10)

			table.insert(var_124_8, var_124_11)
		end
	end

	return var_124_8
end

function var_0_0.checkNextRoundCardCondition(arg_125_0, arg_125_1)
	if string.nilorempty(arg_125_1) then
		return true
	end

	local var_125_0 = string.split(arg_125_1, "&")

	if #var_125_0 > 1 then
		local var_125_1 = 0

		for iter_125_0, iter_125_1 in ipairs(var_125_0) do
			if var_0_0.checkNextRoundCardSingleCondition(arg_125_0, iter_125_1) then
				var_125_1 = var_125_1 + 1
			end
		end

		return var_125_1 == #var_125_0
	else
		return var_0_0.checkNextRoundCardSingleCondition(arg_125_0, var_125_0[1])
	end
end

function var_0_0.checkNextRoundCardSingleCondition(arg_126_0, arg_126_1)
	local var_126_0 = arg_126_0.belongToEntityId
	local var_126_1 = var_0_0.getEntity(var_126_0)
	local var_126_2 = var_126_1 and var_126_1:getMO()
	local var_126_3 = string.split(arg_126_1, "#")

	if var_126_3[1] == "1" then
		if var_126_3[2] and var_126_2 then
			local var_126_4, var_126_5 = HeroConfig.instance:getShowLevel(var_126_2.level)

			if var_126_5 - 1 >= tonumber(var_126_3[2]) then
				return true
			end
		end
	elseif var_126_3[1] == "2" and var_126_3[2] and var_126_2 then
		return var_126_2.exSkillLevel == tonumber(var_126_3[2])
	end
end

function var_0_0.checkShieldHit(arg_127_0)
	if arg_127_0.effectNum1 == FightEnum.EffectType.SHAREHURT then
		return false
	end

	return true
end

var_0_0.SkillEditorHp = 2000

function var_0_0.buildMySideFightEntityMOList(arg_128_0)
	local var_128_0 = FightEnum.EntitySide.MySide
	local var_128_1 = {}
	local var_128_2 = {}

	for iter_128_0 = 1, SkillEditorMgr.instance.stance_count_limit do
		local var_128_3 = HeroModel.instance:getById(arg_128_0.mySideUids[iter_128_0])

		if var_128_3 then
			var_128_1[iter_128_0] = var_128_3.heroId
			var_128_2[iter_128_0] = var_128_3.skin
		end
	end

	local var_128_4 = {}
	local var_128_5 = {}

	for iter_128_1, iter_128_2 in ipairs(arg_128_0.mySideSubUids) do
		local var_128_6 = HeroModel.instance:getById(iter_128_2)

		if var_128_6 then
			table.insert(var_128_4, var_128_6.heroId)
			table.insert(var_128_5, var_128_6.skin)
		end
	end

	return var_0_0.buildHeroEntityMOList(var_128_0, var_128_1, var_128_2, var_128_4, var_128_5)
end

function var_0_0.getEmptyFightEntityMO(arg_129_0, arg_129_1, arg_129_2, arg_129_3)
	if not arg_129_1 or arg_129_1 == 0 then
		return
	end

	local var_129_0 = lua_character.configDict[arg_129_1]
	local var_129_1 = FightEntityMO.New()

	var_129_1.id = tostring(arg_129_0)
	var_129_1.uid = var_129_1.id
	var_129_1.modelId = arg_129_1 or 0
	var_129_1.entityType = 1
	var_129_1.exPoint = 0
	var_129_1.side = FightEnum.EntitySide.MySide
	var_129_1.currentHp = 0
	var_129_1.attrMO = var_0_0._buildAttr(var_129_0)
	var_129_1.skillIds = var_0_0._buildHeroSkills(var_129_0)
	var_129_1.shieldValue = 0
	var_129_1.level = arg_129_2 or 1
	var_129_1.skin = arg_129_3 or var_129_0.skinId
	var_129_1.originSkin = arg_129_3 or var_129_0.skinId

	if not string.nilorempty(var_129_0.powerMax) then
		local var_129_2 = FightStrUtil.instance:getSplitToNumberCache(var_129_0.powerMax, "#")
		local var_129_3 = {
			{
				num = 0,
				powerId = var_129_2[1],
				max = var_129_2[2]
			}
		}

		var_129_1:setPowerInfos(var_129_3)
	end

	return var_129_1
end

function var_0_0.buildHeroEntityMOList(arg_130_0, arg_130_1, arg_130_2, arg_130_3, arg_130_4)
	local function var_130_0(arg_131_0, arg_131_1, arg_131_2)
		local var_131_0 = FightEntityMO.New()

		var_131_0.id = tostring(var_0_1)
		var_131_0.uid = var_131_0.id
		var_131_0.modelId = arg_131_0 or 0
		var_131_0.entityType = 1
		var_131_0.exPoint = 0
		var_131_0.side = arg_130_0
		var_131_0.currentHp = var_0_0.SkillEditorHp
		var_131_0.attrMO = var_0_0._buildAttr(arg_131_1)

		local var_131_1 = arg_131_1.uniqueSkill_point

		var_131_0.exPointType = string.splitToNumber(var_131_1, "#")[1] or 0

		if arg_131_2 == 312002 then
			var_131_0.skillIds = var_0_0._buildHeroSkills(arg_131_1, 2)
		else
			var_131_0.skillIds = var_0_0._buildHeroSkills(arg_131_1)
		end

		var_131_0.shieldValue = 0
		var_131_0.level = 1
		var_131_0.storedExPoint = 0

		if not string.nilorempty(arg_131_1.powerMax) then
			local var_131_2 = FightStrUtil.instance:getSplitToNumberCache(arg_131_1.powerMax, "#")
			local var_131_3 = {
				{
					num = 0,
					powerId = var_131_2[1],
					max = var_131_2[2]
				}
			}

			var_131_0:setPowerInfos(var_131_3)
		end

		var_0_1 = var_0_1 + 1

		return var_131_0
	end

	local var_130_1 = {}
	local var_130_2 = {}
	local var_130_3 = arg_130_1 and #arg_130_1 or SkillEditorMgr.instance.stance_count_limit

	for iter_130_0 = 1, var_130_3 do
		local var_130_4 = arg_130_1[iter_130_0]

		if var_130_4 and var_130_4 ~= 0 then
			local var_130_5 = lua_character.configDict[var_130_4]

			if var_130_5 then
				local var_130_6 = arg_130_2 and arg_130_2[iter_130_0] or var_130_5.skinId
				local var_130_7 = var_130_0(var_130_4, var_130_5, var_130_6)

				var_130_7.position = iter_130_0
				var_130_7.skin = var_130_6
				var_130_7.originSkin = var_130_6

				table.insert(var_130_1, var_130_7)
			else
				local var_130_8 = arg_130_0 == FightEnum.EntitySide.MySide and "我方" or "敌方"

				logError(string.format("%s%d号站位的角色配置已被删除，角色id=%d", var_130_8, iter_130_0, var_130_4))
			end
		end
	end

	if arg_130_3 then
		for iter_130_1, iter_130_2 in ipairs(arg_130_3) do
			local var_130_9 = lua_character.configDict[iter_130_2]

			if var_130_9 then
				local var_130_10 = var_130_0(iter_130_2, var_130_9)

				var_130_10.position = -1
				var_130_10.skin = arg_130_4 and arg_130_4[iter_130_1] or var_130_9.skinId
				var_130_10.originSkin = arg_130_4 and arg_130_4[iter_130_1] or var_130_9.skinId

				table.insert(var_130_2, var_130_10)
			else
				local var_130_11 = arg_130_0 == FightEnum.EntitySide.MySide and "我方" or "敌方"

				logError(var_130_11 .. "替补角色的配置已被删除，角色id=" .. iter_130_2)
			end
		end
	end

	return var_130_1, var_130_2
end

function var_0_0.buildEnemySideFightEntityMOList(arg_132_0, arg_132_1)
	local var_132_0 = FightEnum.EntitySide.EnemySide
	local var_132_1 = arg_132_0.monsterGroupIds[arg_132_1]
	local var_132_2 = lua_monster_group.configDict[var_132_1]
	local var_132_3 = FightStrUtil.instance:getSplitToNumberCache(var_132_2.monster, "#")
	local var_132_4 = var_132_2.subMonsters

	return var_0_0.buildMonsterEntityMOList(var_132_0, var_132_3, var_132_4)
end

function var_0_0.buildMonsterEntityMOList(arg_133_0, arg_133_1, arg_133_2)
	local var_133_0 = {}
	local var_133_1 = {}

	for iter_133_0 = 1, SkillEditorMgr.instance.enemy_stance_count_limit do
		local var_133_2 = arg_133_1[iter_133_0]

		if var_133_2 and var_133_2 ~= 0 then
			local var_133_3 = lua_monster.configDict[var_133_2]

			if var_133_3 then
				local var_133_4 = FightEntityMO.New()

				var_133_4.id = tostring(var_0_2)
				var_133_4.uid = var_133_4.id
				var_133_4.modelId = var_133_2
				var_133_4.position = iter_133_0
				var_133_4.entityType = 2
				var_133_4.exPoint = 0
				var_133_4.skin = var_133_3.skinId
				var_133_4.originSkin = var_133_3.skinId
				var_133_4.side = arg_133_0
				var_133_4.currentHp = var_0_0.SkillEditorHp
				var_133_4.attrMO = var_0_0._buildAttr(var_133_3)
				var_133_4.skillIds = var_0_0._buildMonsterSkills(var_133_3)
				var_133_4.shieldValue = 0
				var_133_4.level = 1
				var_133_4.storedExPoint = 0
				var_133_4.exPointType = 0
				var_0_2 = var_0_2 - 1

				table.insert(var_133_0, var_133_4)
			else
				local var_133_5 = arg_133_0 == FightEnum.EntitySide.MySide and "我方" or "敌方"

				logError(string.format("%s%d号站位的怪物配置已被删除，怪物id=%d", var_133_5, iter_133_0, var_133_2))
			end
		end
	end

	if arg_133_2 then
		for iter_133_1, iter_133_2 in ipairs(arg_133_2) do
			local var_133_6 = lua_monster.configDict[iter_133_2]

			if var_133_6 then
				local var_133_7 = FightEntityMO.New()

				var_133_7.id = tostring(var_0_2)
				var_133_7.uid = var_133_7.id
				var_133_7.modelId = iter_133_2
				var_133_7.position = 5
				var_133_7.entityType = 2
				var_133_7.exPoint = 0
				var_133_7.skin = var_133_6.skinId
				var_133_7.originSkin = var_133_6.skinId
				var_133_7.side = arg_133_0
				var_133_7.currentHp = var_0_0.SkillEditorHp
				var_133_7.attrMO = var_0_0._buildAttr(var_133_6)
				var_133_7.skillIds = var_0_0._buildMonsterSkills(var_133_6)
				var_133_7.shieldValue = 0
				var_133_7.level = 1
				var_0_2 = var_0_2 - 1

				table.insert(var_133_1, var_133_7)
			else
				local var_133_8 = arg_133_0 == FightEnum.EntitySide.MySide and "我方" or "敌方"

				logError(var_133_8 .. "替补怪物的配置已被删除，怪物id=" .. iter_133_2)
			end
		end
	end

	return var_133_0, var_133_1
end

function var_0_0.buildSkills(arg_134_0)
	local var_134_0 = lua_character.configDict[arg_134_0]

	if var_134_0 then
		return var_0_0._buildHeroSkills(var_134_0)
	end

	local var_134_1 = lua_monster.configDict[arg_134_0]

	if var_134_1 then
		return var_0_0._buildMonsterSkills(var_134_1)
	end
end

function var_0_0._buildHeroSkills(arg_135_0, arg_135_1)
	local var_135_0 = {}
	local var_135_1 = lua_character.configDict[arg_135_0.id]
	local var_135_2

	if arg_135_1 and arg_135_1 >= 2 then
		var_135_2 = lua_character_rank_replace.configDict[arg_135_0.id]
	end

	if var_135_1 then
		local var_135_3 = GameUtil.splitString2(var_135_1.skill, true)

		if var_135_2 then
			var_135_3 = GameUtil.splitString2(var_135_2.skill, true)
		end

		for iter_135_0, iter_135_1 in pairs(var_135_3) do
			for iter_135_2 = 2, #iter_135_1 do
				if iter_135_1[iter_135_2] ~= 0 then
					table.insert(var_135_0, iter_135_1[iter_135_2])
				else
					logError(arg_135_0.id .. " 角色技能id=0，检查下角色表-角色")
				end
			end
		end
	end

	if var_135_2 then
		if var_135_2.exSkill ~= 0 then
			table.insert(var_135_0, var_135_2.exSkill)
		end
	elseif var_135_1.exSkill ~= 0 then
		table.insert(var_135_0, var_135_1.exSkill)
	end

	local var_135_4 = lua_skill_ex_level.configDict[arg_135_0.id]

	if var_135_4 then
		for iter_135_3, iter_135_4 in pairs(var_135_4) do
			if iter_135_4.skillEx ~= 0 then
				table.insert(var_135_0, iter_135_4.skillEx)
			end
		end
	end

	local var_135_5 = lua_skill_passive_level.configDict[arg_135_0.id]

	if var_135_5 then
		for iter_135_5, iter_135_6 in pairs(var_135_5) do
			if iter_135_6.skillPassive ~= 0 then
				table.insert(var_135_0, iter_135_6.skillPassive)
			else
				logError(arg_135_0.id .. " 角色被动技能id=0，检查下角色养成表-被动升级")
			end
		end
	end

	return var_135_0
end

function var_0_0._buildMonsterSkills(arg_136_0)
	local var_136_0 = {}

	if not string.nilorempty(arg_136_0.activeSkill) then
		local var_136_1 = FightStrUtil.instance:getSplitString2Cache(arg_136_0.activeSkill, true, "|", "#")

		for iter_136_0, iter_136_1 in ipairs(var_136_1) do
			for iter_136_2, iter_136_3 in ipairs(iter_136_1) do
				if lua_skill.configDict[iter_136_3] then
					table.insert(var_136_0, iter_136_3)
				end
			end
		end
	end

	if arg_136_0.uniqueSkill and #arg_136_0.uniqueSkill > 0 then
		for iter_136_4, iter_136_5 in ipairs(arg_136_0.uniqueSkill) do
			table.insert(var_136_0, iter_136_5)
		end
	end

	tabletool.addValues(var_136_0, FightConfig.instance:getPassiveSkills(arg_136_0.id))

	return var_136_0
end

function var_0_0._buildAttr(arg_137_0)
	local var_137_0 = HeroAttributeMO.New()

	var_137_0.hp = var_0_0.SkillEditorHp
	var_137_0.attack = 100
	var_137_0.defense = 100
	var_137_0.crit = 100
	var_137_0.crit_damage = 100
	var_137_0.multiHpNum = 0
	var_137_0.multiHpIdx = 0

	return var_137_0
end

function var_0_0.getEpisodeRecommendLevel(arg_138_0, arg_138_1)
	local var_138_0 = DungeonConfig.instance:getEpisodeBattleId(arg_138_0)

	if not var_138_0 then
		return 0
	end

	return var_0_0.getBattleRecommendLevel(var_138_0, arg_138_1)
end

function var_0_0.getBattleRecommendLevel(arg_139_0, arg_139_1)
	local var_139_0 = arg_139_1 and "levelEasy" or "level"
	local var_139_1 = lua_battle.configDict[arg_139_0]

	if not var_139_1 then
		return 0
	end

	local var_139_2 = {}
	local var_139_3 = {}
	local var_139_4
	local var_139_5

	for iter_139_0, iter_139_1 in ipairs(FightStrUtil.instance:getSplitToNumberCache(var_139_1.monsterGroupIds, "#")) do
		local var_139_6 = lua_monster_group.configDict[iter_139_1].bossId
		local var_139_7 = FightStrUtil.instance:getSplitToNumberCache(lua_monster_group.configDict[iter_139_1].monster, "#")

		for iter_139_2, iter_139_3 in ipairs(var_139_7) do
			if var_0_0.isBossId(var_139_6, iter_139_3) then
				table.insert(var_139_3, iter_139_3)
			else
				table.insert(var_139_2, iter_139_3)
			end
		end
	end

	if #var_139_3 > 0 then
		return lua_monster.configDict[var_139_3[1]][var_139_0]
	elseif #var_139_2 > 0 then
		local var_139_8 = 0

		for iter_139_4, iter_139_5 in ipairs(var_139_2) do
			var_139_8 = var_139_8 + lua_monster.configDict[iter_139_5][var_139_0]
		end

		return math.ceil(var_139_8 / #var_139_2)
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
		[DungeonEnum.EpisodeType.Rouge] = var_0_0.buildRougeSceneAndLevel,
		[DungeonEnum.EpisodeType.Survival] = var_0_0.buildSurvivalSceneAndLevel
	}
end

function var_0_0.buildDefaultSceneAndLevel(arg_141_0, arg_141_1)
	local var_141_0 = {}
	local var_141_1 = {}
	local var_141_2 = lua_battle.configDict[arg_141_1].sceneIds
	local var_141_3 = string.splitToNumber(var_141_2, "#")

	for iter_141_0, iter_141_1 in ipairs(var_141_3) do
		local var_141_4 = SceneConfig.instance:getSceneLevelCOs(iter_141_1)[1].id

		table.insert(var_141_0, iter_141_1)
		table.insert(var_141_1, var_141_4)
	end

	return var_141_0, var_141_1
end

function var_0_0.buildCachotSceneAndLevel(arg_142_0, arg_142_1)
	local var_142_0 = 0
	local var_142_1 = V1a6_CachotRoomModel.instance:getNowBattleEventMo()

	if var_142_1 and lua_rogue_event_fight.configDict[var_142_1:getEventCo().eventId].isChangeScene ~= 1 then
		var_142_0 = V1a6_CachotModel.instance:getRogueInfo().layer
	end

	if var_142_0 > 0 then
		local var_142_2 = V1a6_CachotEventConfig.instance:getSceneIdByLayer(var_142_0)

		if var_142_2 then
			local var_142_3 = {}
			local var_142_4 = {}

			table.insert(var_142_3, var_142_2.sceneId)
			table.insert(var_142_4, var_142_2.levelId)

			return var_142_3, var_142_4
		else
			logError("肉鸽战斗场景配置不存在" .. var_142_0)

			return var_0_0.buildDefaultSceneAndLevel(arg_142_0, arg_142_1)
		end
	else
		return var_0_0.buildDefaultSceneAndLevel(arg_142_0, arg_142_1)
	end
end

function var_0_0.buildSurvivalSceneAndLevel(...)
	local var_143_0 = SurvivalMapModel.instance:getSceneMo()

	if var_143_0 then
		local var_143_1 = lua_survival_map_group_mapping.configDict[var_143_0.mapId].id
		local var_143_2 = lua_survival_map_group.configDict[var_143_1]
		local var_143_3 = {}
		local var_143_4 = {}

		table.insert(var_143_3, var_143_2.useScene)
		table.insert(var_143_4, var_143_2.useScene)

		return var_143_3, var_143_4
	end

	return var_0_0.buildDefaultSceneAndLevel(...)
end

function var_0_0.buildRougeSceneAndLevel(arg_144_0, arg_144_1)
	local var_144_0 = RougeMapModel.instance:getCurEvent()
	local var_144_1 = var_144_0 and var_144_0.type
	local var_144_2 = RougeMapHelper.isFightEvent(var_144_1) and lua_rouge_fight_event.configDict[var_144_0.id]

	if var_144_2 and var_144_2.isChangeScene == 1 then
		local var_144_3 = RougeMapModel.instance:getLayerCo()
		local var_144_4 = var_144_3 and var_144_3.sceneId
		local var_144_5 = var_144_3 and var_144_3.levelId

		if var_144_4 ~= 0 and var_144_5 ~= 0 then
			return {
				var_144_4
			}, {
				var_144_5
			}
		end

		logError(string.format("layerId : %s, config Incorrect, sceneId : %s, levelId : %s", var_144_3 and var_144_3.id, var_144_4, var_144_5))

		return var_0_0.buildDefaultSceneAndLevel(arg_144_0, arg_144_1)
	else
		return var_0_0.buildDefaultSceneAndLevel(arg_144_0, arg_144_1)
	end
end

function var_0_0.buildSceneAndLevel(arg_145_0, arg_145_1)
	var_0_0.initBuildSceneAndLevelHandle()

	local var_145_0 = lua_episode.configDict[arg_145_0]
	local var_145_1 = var_145_0 and var_0_0.buildSceneAndLevelHandleDict[var_145_0.type]

	var_145_1 = var_145_1 or var_0_0.buildDefaultSceneAndLevel

	return var_145_1(arg_145_0, arg_145_1)
end

function var_0_0.getStressStatus(arg_146_0, arg_146_1)
	arg_146_1 = arg_146_1 or FightEnum.StressThreshold

	if not arg_146_0 then
		logError("stress is nil")

		return FightEnum.Status.Positive
	end

	for iter_146_0 = 1, 2 do
		if arg_146_0 <= arg_146_1[iter_146_0] then
			return iter_146_0
		end
	end

	return nil
end

function var_0_0.getResistanceKeyById(arg_147_0)
	if not var_0_0.resistanceId2KeyDict then
		var_0_0.resistanceId2KeyDict = {}

		for iter_147_0, iter_147_1 in pairs(FightEnum.Resistance) do
			var_0_0.resistanceId2KeyDict[iter_147_1] = iter_147_0
		end
	end

	return var_0_0.resistanceId2KeyDict[arg_147_0]
end

function var_0_0.canAddPoint(arg_148_0)
	if not arg_148_0 then
		return false
	end

	if arg_148_0:hasBuffFeature(FightEnum.BuffType_TransferAddExPoint) then
		return false
	end

	if arg_148_0:hasBuffFeature(FightEnum.ExPointCantAdd) then
		return false
	end

	return true
end

function var_0_0.getEntityName(arg_149_0)
	local var_149_0 = arg_149_0 and arg_149_0:getMO()
	local var_149_1 = var_149_0 and var_149_0:getEntityName()

	return tostring(var_149_1)
end

function var_0_0.getEntityById(arg_150_0)
	local var_150_0 = var_0_0.getEntity(arg_150_0)

	return var_0_0.getEntityName(var_150_0)
end

function var_0_0.isSameCardMo(arg_151_0, arg_151_1)
	if arg_151_0 == arg_151_1 then
		return true
	end

	if not arg_151_0 or not arg_151_1 then
		return false
	end

	return arg_151_0.clientData.custom_enemyCardIndex == arg_151_1.clientData.custom_enemyCardIndex
end

function var_0_0.getAssitHeroInfoByUid(arg_152_0, arg_152_1)
	local var_152_0 = FightDataHelper.entityMgr:getById(arg_152_0)

	if var_152_0 and var_152_0:isCharacter() then
		local var_152_1 = HeroConfig.instance:getHeroCO(var_152_0.modelId)

		return {
			skin = var_152_0.skin,
			level = var_152_0.level,
			config = var_152_1
		}
	end
end

function var_0_0.canSelectEnemyEntity(arg_153_0)
	if not arg_153_0 then
		return false
	end

	local var_153_0 = FightDataHelper.entityMgr:getById(arg_153_0)

	if not var_153_0 then
		return false
	end

	if var_153_0.side == FightEnum.EntitySide.MySide then
		return false
	end

	if var_153_0:hasBuffFeature(FightEnum.BuffType_CantSelect) then
		return false
	end

	if var_153_0:hasBuffFeature(FightEnum.BuffType_CantSelectEx) then
		return false
	end

	return true
end

function var_0_0.clearNoUseEffect()
	local var_154_0 = FightEffectPool.releaseUnuseEffect()

	for iter_154_0, iter_154_1 in pairs(var_154_0) do
		FightPreloadController.instance:releaseAsset(iter_154_0)
	end

	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC)
end

function var_0_0.isASFDSkill(arg_155_0)
	return arg_155_0 == FightASFDConfig.instance.skillId
end

function var_0_0.isXiTiSpecialSkill(arg_156_0)
	return arg_156_0 == FightASFDConfig.instance.xiTiSpecialSkillId
end

function var_0_0.isPreDeleteSkill(arg_157_0)
	local var_157_0 = arg_157_0 and lua_skill.configDict[arg_157_0]

	return var_157_0 and var_157_0.icon == FightEnum.CardIconId.PreDelete
end

function var_0_0.getASFDMgr()
	local var_158_0 = GameSceneMgr.instance:getCurScene()
	local var_158_1 = var_158_0 and var_158_0.mgr

	return var_158_1 and var_158_1:getASFDMgr()
end

function var_0_0.getEntityCareer(arg_159_0)
	local var_159_0 = arg_159_0 and FightDataHelper.entityMgr:getById(arg_159_0)

	return var_159_0 and var_159_0:getCareer() or 0
end

function var_0_0.isRestrain(arg_160_0, arg_160_1)
	local var_160_0 = var_0_0.getEntityCareer(arg_160_0)
	local var_160_1 = var_0_0.getEntityCareer(arg_160_1)

	return (FightConfig.instance:getRestrain(var_160_0, var_160_1) or 1000) > 1000
end

var_0_0.tempEntityMoList = {}

function var_0_0.hasSkinId(arg_161_0)
	local var_161_0 = var_0_0.tempEntityMoList

	tabletool.clear(var_161_0)

	local var_161_1 = FightDataHelper.entityMgr:getMyNormalList(var_161_0)

	for iter_161_0, iter_161_1 in ipairs(var_161_1) do
		if iter_161_1.originSkin == arg_161_0 then
			return true
		end
	end

	return false
end

function var_0_0.getBloodPoolSkillId()
	return tonumber(lua_fight_xcjl_const.configDict[4].value)
end

function var_0_0.isBloodPoolSkill(arg_163_0)
	return arg_163_0 == var_0_0.getBloodPoolSkillId()
end

function var_0_0.getSurvivalEntityHealth(arg_164_0)
	local var_164_0 = FightDataHelper.fieldMgr.customData and FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Survival]

	if not var_164_0 then
		return
	end

	if not var_164_0.hero2Health then
		return
	end

	local var_164_1 = FightDataHelper.entityMgr:getById(arg_164_0)

	if not var_164_1 then
		return
	end

	local var_164_2 = var_164_1.modelId

	return var_164_0.hero2Health[tostring(var_164_2)]
end

function var_0_0.getSurvivalMaxHealth()
	local var_165_0 = FightDataHelper.fieldMgr.customData and FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Survival]

	if not var_165_0 then
		return
	end

	return var_165_0.maxHealth
end

function var_0_0.getCurBattleIdBossHpType()
	local var_166_0 = FightDataHelper.fieldMgr.battleId
	local var_166_1 = lua_battle.configDict[var_166_0]
	local var_166_2 = var_166_1 and var_166_1.bossHpType
	local var_166_3 = not string.nilorempty(var_166_2) and FightStrUtil.instance:getSplitCache(var_166_2, "#")

	return var_166_3 and tonumber(var_166_3[1])
end

function var_0_0.getCurBossEntityMo()
	local var_167_0 = FightModel.instance:getCurMonsterGroupId()
	local var_167_1 = var_167_0 and lua_monster_group.configDict[var_167_0]
	local var_167_2 = var_167_1 and var_167_1.bossId

	if string.nilorempty(var_167_2) then
		return
	end

	local var_167_3 = FightDataHelper.entityMgr:getEnemyNormalList()

	for iter_167_0, iter_167_1 in ipairs(var_167_3) do
		if var_0_0.isBossId(var_167_2, iter_167_1.modelId) then
			return iter_167_1
		end
	end

	local var_167_4 = {}

	for iter_167_2, iter_167_3 in ipairs(var_167_3) do
		table.insert(var_167_4, iter_167_3.modelId)
	end

	logError(string.format("获取boss数据失败： monsterGroupId ： %s, bossId : %s, curEnemyList : %s", var_167_0, var_167_2, table.concat(var_167_4, ",")))
end

function var_0_0.getBossCurStageCo_500M(arg_168_0)
	local var_168_0 = arg_168_0 or var_0_0.getCurBossEntityMo()

	if not var_168_0 then
		logError("entityMo is nil")

		return lua_fight_tower_500m_boss_behaviour.configList[1]
	end

	for iter_168_0, iter_168_1 in ipairs(lua_fight_tower_500m_boss_behaviour.configList) do
		local var_168_1 = FightStrUtil.instance:getSplitToNumberCache(iter_168_1.monsterid, "#")

		if var_168_1 then
			for iter_168_2, iter_168_3 in ipairs(var_168_1) do
				if iter_168_3 == var_168_0.modelId then
					return iter_168_1
				end
			end
		end
	end

	logError(string.format("获取阶段数据失败： bossId : %s", var_168_0.modelId))

	return lua_fight_tower_500m_boss_behaviour.configList[1]
end

function var_0_0.isOppositeSide(arg_169_0, arg_169_1)
	if arg_169_0 == FightEnum.EntitySide.MySide then
		return arg_169_1 == FightEnum.EntitySide.EnemySide
	elseif arg_169_0 == FightEnum.EntitySide.EnemySide then
		return arg_169_1 == FightEnum.EntitySide.MySide
	else
		return false
	end
end

function var_0_0.isOppositeByEntityId(arg_170_0, arg_170_1)
	local var_170_0 = FightDataHelper.entityMgr:getById(arg_170_0)
	local var_170_1 = FightDataHelper.entityMgr:getById(arg_170_1)
	local var_170_2 = var_170_0 and var_170_0.side
	local var_170_3 = var_170_1 and var_170_1.side

	return var_0_0.isOppositeSide(var_170_2, var_170_3)
end

return var_0_0
