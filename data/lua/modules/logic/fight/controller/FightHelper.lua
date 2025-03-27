module("modules.logic.fight.controller.FightHelper", package.seeall)

slot0 = _M
slot1 = 1000001
slot2 = -1000001
slot3 = Vector2.zero

function slot0.getEntityStanceId(slot0, slot1)
	slot2 = FightEnum.MySideDefaultStanceId

	if slot0 and slot0.side == FightEnum.EntitySide.MySide then
		slot4 = FightModel.instance:getFightParam() and slot3.battleId

		if slot4 and lua_battle.configDict[slot4] and not string.nilorempty(slot5.myStance) and not tonumber(slot5.myStance) then
			if #FightStrUtil.instance:getSplitToNumberCache(slot5.myStance, "#") > 0 then
				slot1 = slot1 or FightModel.instance:getCurWaveId()
				slot2 = slot6[slot1 <= #slot6 and slot1 or #slot6]
			else
				logError("站位配置有误，战斗id = " .. slot3.battleId)
			end
		end

		if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
			slot2 = SkillEditorMgr.instance.stance_id
		end
	else
		slot2 = lua_monster_group.configDict[FightModel.instance:getCurMonsterGroupId()] and slot4.stanceId or FightEnum.EnemySideDefaultStanceId

		if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
			slot2 = SkillEditorMgr.instance.enemy_stance_id
		end
	end

	return slot2
end

function slot0.getEntityStandPos(slot0, slot1)
	if slot0:isAssistBoss() then
		return uv0.getAssistBossStandPos(slot0, slot1)
	end

	if FightEntityDataHelper.isPlayerUid(slot0.uid) then
		return 0, 0, 0, 1
	end

	if not lua_stance.configDict[uv0.getEntityStanceId(slot0, slot1)] then
		if slot0.side == FightEnum.EntitySide.MySide then
			logError("我方用了不存在的站位，战斗id=" .. (FightModel.instance:getFightParam() and slot4.battleId or "nil") .. "， 站位id=" .. slot2)
		else
			logError("敌方用了不存在的站位，怪物组=" .. (FightModel.instance:getCurMonsterGroupId() or "nil") .. "， 站位id=" .. slot2)
		end
	end

	slot5 = nil

	if FightDataHelper.entityMgr:isSub(slot0.uid) and not slot3.subPos1 or not slot3["pos" .. slot0.position] or not slot5[1] or not slot5[2] or not slot5[3] then
		if isDebugBuild then
			logError("stance pos nil: stance_" .. (slot2 or "nil") .. " posIndex_" .. (slot0.position or "nil"))
		end

		return 0, 0, 0, 1
	end

	return slot5[1], slot5[2], slot5[3], slot5[4] or 1
end

function slot0.getAssistBossStandPos(slot0, slot1)
	if not (lua_assist_boss_stance.configDict[slot0.skin] and slot5[FightModel.instance:getFightParam():getScene(slot1 or FightModel.instance:getCurWaveId())] or slot5 and slot5[0]) then
		logError(string.format("协助boss站位表未配置 皮肤id：%s, 场景id : %s", slot3, slot4))

		return 9.4, 0, -2.75, 0.9
	end

	slot7 = slot6.position

	return slot7[1], slot7[2], slot7[3], slot6.scale
end

function slot0.getSpineLookDir(slot0)
	return slot0 == FightEnum.EntitySide.MySide and SpineLookDir.Left or SpineLookDir.Right
end

function slot0.getEntitySpineLookDir(slot0)
	if slot0 then
		if FightConfig.instance:getSkinCO(slot0.skin) and slot2.flipX and slot2.flipX == 1 then
			return slot0.side == FightEnum.EntitySide.MySide and SpineLookDir.Right or SpineLookDir.Left
		else
			return slot1 == FightEnum.EntitySide.MySide and SpineLookDir.Left or SpineLookDir.Right
		end
	end
end

function slot0.getEffectLookDir(slot0)
	return slot0 == FightEnum.EntitySide.MySide and FightEnum.EffectLookDir.Left or FightEnum.EffectLookDir.Right
end

function slot0.getEffectLookDirQuaternion(slot0)
	if slot0 == FightEnum.EntitySide.MySide then
		return FightEnum.RotationQuaternion.Zero
	else
		return FightEnum.RotationQuaternion.Ohae
	end
end

function slot0.getEntity(slot0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		return GameSceneMgr.instance:getCurScene().entityMgr:getEntity(slot0)
	end
end

function slot0.getDefenders(slot0, slot1, slot2)
	slot3 = {}

	for slot7, slot8 in ipairs(slot0.actEffectMOs) do
		slot9 = false

		if slot2 and slot2[slot8.effectType] then
			slot9 = true
		end

		if slot8.effectType == FightEnum.EffectType.SHIELD and not uv0.checkShieldHit(slot8) then
			slot9 = true
		end

		if not slot9 then
			if uv0.getEntity(slot8.targetId) then
				table.insert(slot3, slot10)
			else
				logNormal("get defender fail, entity not exist: " .. slot8.targetId)
			end
		end
	end

	if slot1 and not tabletool.indexOf(slot3, uv0.getEntity(slot0.toId)) then
		table.insert(slot3, slot4)
	end

	return slot3
end

function slot0.getPreloadAssetItem(slot0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		return FightPreloadController.instance:getFightAssetItem(slot0)
	end
end

function slot0.getEnemySideEntitys(slot0, slot1)
	if uv0.getEntity(slot0) then
		if slot2:getSide() == FightEnum.EntitySide.EnemySide then
			return uv0.getSideEntitys(FightEnum.EntitySide.MySide, slot1)
		elseif slot3 == FightEnum.EntitySide.MySide then
			return uv0.getSideEntitys(FightEnum.EntitySide.EnemySide, slot1)
		end
	end

	return {}
end

function slot0.getSideEntitys(slot0, slot1)
	slot2 = {}

	if GameSceneMgr.instance:getCurScene().entityMgr:getTagUnitDict(slot0 == FightEnum.EntitySide.MySide and SceneTag.UnitPlayer or SceneTag.UnitMonster) then
		for slot9, slot10 in pairs(slot5) do
			if not FightDataHelper.entityMgr:isAssistBoss(slot10.id) and (slot1 or not FightDataHelper.entityMgr:isSub(slot10.id)) then
				table.insert(slot2, slot10)
			end
		end
	end

	return slot2
end

function slot0.getSubEntity(slot0)
	if GameSceneMgr.instance:getCurScene().entityMgr:getTagUnitDict(slot0 == FightEnum.EntitySide.MySide and SceneTag.UnitPlayer or SceneTag.UnitMonster) then
		for slot7, slot8 in pairs(slot3) do
			if not slot8.isDead and FightDataHelper.entityMgr:isSub(slot8.id) then
				return slot8
			end
		end
	end
end

function slot0.getAllEntitys()
	slot0 = {}

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		slot1 = GameSceneMgr.instance:getCurScene().entityMgr
		slot3 = slot1:getTagUnitDict(SceneTag.UnitMonster)

		if slot1:getTagUnitDict(SceneTag.UnitPlayer) then
			for slot7, slot8 in pairs(slot2) do
				table.insert(slot0, slot8)
			end
		end

		if slot3 then
			for slot7, slot8 in pairs(slot3) do
				table.insert(slot0, slot8)
			end
		end
	end

	return slot0
end

function slot0.isAllEntityDead(slot0)
	slot1 = true
	slot2 = nil

	for slot6, slot7 in ipairs((not slot0 or uv0.getSideEntitys(slot0, true)) and uv0.getAllEntitys()) do
		if not slot7.isDead then
			slot1 = false
		end
	end

	return slot1
end

function slot0.getAllEntitysContainUnitNpc()
	slot0 = {}

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		slot1 = GameSceneMgr.instance:getCurScene().entityMgr

		LuaUtil.mergeTable(slot0, slot1:getTagUnitDict(SceneTag.UnitPlayer), slot1:getTagUnitDict(SceneTag.UnitMonster), slot1:getTagUnitDict(SceneTag.UnitNpc))
	end

	return slot0
end

function slot0.validEntityEffectType(slot0)
	if slot0 == FightEnum.EffectType.EXPOINTCHANGE then
		return false
	end

	if slot0 == FightEnum.EffectType.INDICATORCHANGE then
		return false
	end

	if slot0 == FightEnum.EffectType.POWERCHANGE then
		return false
	end

	return true
end

function slot0.getRelativeEntityIdDict(slot0, slot1)
	if slot0.fromId then
		-- Nothing
	end

	if slot0.toId then
		slot2[slot0.toId] = true
	end

	for slot6, slot7 in ipairs(slot0.actEffectMOs) do
		slot8 = false

		if slot1 and slot1[slot7.effectType] then
			slot8 = true
		end

		if slot7.effectType == FightEnum.EffectType.SHIELD and not uv0.checkShieldHit(slot7) then
			slot8 = true
		end

		if not slot8 and slot7.effectType ~= FightEnum.EffectType.EXPOINTCHANGE and slot7.targetId then
			slot2[slot7.targetId] = true
		end
	end

	return {
		[slot0.fromId] = true
	}
end

function slot0.getSkillTargetEntitys(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0.actEffectMOs) do
		slot8 = false

		if slot1 and slot1[slot7.effectType] then
			slot8 = true
		end

		if slot7.effectType == FightEnum.EffectType.SHIELD and not uv0.checkShieldHit(slot7) then
			slot8 = true
		end

		if not slot8 and slot7.effectType ~= FightEnum.EffectType.EXPOINTCHANGE and uv0.getEntity(slot7.targetId) and not tabletool.indexOf(slot2, slot9) then
			table.insert(slot2, slot9)
		end
	end

	return slot2
end

function slot0.getTargetLimits(slot0, slot1, slot2)
	slot4 = uv0.getSideEntitys(slot0, false)
	slot5 = uv0.getSideEntitys(slot0 == FightEnum.EntitySide.MySide and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide, false)
	slot7 = {}

	if not lua_skill.configDict[slot1] then
		for slot11, slot12 in ipairs(slot5) do
			table.insert(slot7, slot12.id)
		end

		logError("no target limits, skillId_" .. slot1)
	elseif slot6.targetLimit == FightEnum.TargetLimit.None then
		-- Nothing
	elseif slot6.targetLimit == FightEnum.TargetLimit.EnemySide then
		for slot11, slot12 in ipairs(slot5) do
			table.insert(slot7, slot12.id)
		end
	elseif slot6.targetLimit == FightEnum.TargetLimit.MySide then
		for slot11, slot12 in ipairs(slot4) do
			table.insert(slot7, slot12.id)
		end
	else
		for slot11, slot12 in ipairs(slot5) do
			table.insert(slot7, slot12.id)
		end

		logError("target limit type not implement:" .. slot6.targetLimit .. " skillId = " .. slot1)
	end

	if slot6.logicTarget == 3 then
		if slot2 then
			for slot12 = #slot7, 1, -1 do
				if slot7[slot12] == slot8 then
					table.remove(slot7, slot12)
				end
			end
		end
	elseif slot6.logicTarget == 1 then
		for slot11 = 1, FightEnum.MaxBehavior do
			if FightStrUtil.instance:getSplitCache(slot6["behavior" .. slot11], "#")[1] == "60032" then
				for slot17 = #slot7, 1, -1 do
					if FightDataHelper.entityMgr:getById(slot7[slot17]) and (#slot18.skillGroup1 == 0 or #slot18.skillGroup2 == 0) then
						table.remove(slot7, slot17)
					end
				end
			end
		end
	end

	return slot7
end

function slot0.getEntityWorldTopPos(slot0)
	slot1, slot2 = uv0.getEntityBoxSizeOffsetV2(slot0)
	slot3, slot4, slot5 = uv0.getProcessEntitySpinePos(slot0)

	return slot3 + slot2.x, slot4 + slot2.y + slot1.y / 2, slot5
end

function slot0.getEntityWorldCenterPos(slot0)
	slot1, slot2 = uv0.getEntityBoxSizeOffsetV2(slot0)
	slot3, slot4, slot5 = uv0.getProcessEntitySpinePos(slot0)

	return slot3 + slot2.x, slot4 + slot2.y, slot5
end

function slot0.getEntityHangPointPos(slot0, slot1)
	slot2 = slot0:getHangPoint(slot1).transform.position

	return slot2.x, slot2.y, slot2.z
end

function slot0.getEntityWorldBottomPos(slot0)
	slot1, slot2 = uv0.getEntityBoxSizeOffsetV2(slot0)
	slot3, slot4, slot5 = uv0.getProcessEntitySpinePos(slot0)

	return slot3 + slot2.x, slot4 + slot2.y - slot1.y / 2, slot5
end

function slot0.getEntityLocalTopPos(slot0)
	slot1, slot2 = uv0.getEntityBoxSizeOffsetV2(slot0)

	return slot2.x, slot2.y + slot1.y / 2, 0
end

function slot0.getEntityLocalCenterPos(slot0)
	slot1, slot2 = uv0.getEntityBoxSizeOffsetV2(slot0)

	return slot2.x, slot2.y, 0
end

function slot0.getEntityLocalBottomPos(slot0)
	slot1, slot2 = uv0.getEntityBoxSizeOffsetV2(slot0)

	return slot2.x, slot2.y - slot1.y / 2, 0
end

function slot0.getEntityBoxSizeOffsetV2(slot0)
	if uv0.isAssembledMonster(slot0) then
		slot2 = lua_fight_assembled_monster.configDict[slot0:getMO().skin]

		return {
			x = slot2.virtualSpineSize[1],
			y = slot2.virtualSpineSize[2]
		}, uv1
	end

	if slot0.spine and slot0.spine:getSpineGO() and slot1:GetComponent("BoxCollider2D") then
		slot3, slot4, slot5 = transformhelper.getLocalScale(slot0.go.transform)
		slot6 = slot2.size
		slot7 = slot2.offset
		slot7.x = slot7.x * slot3
		slot7.y = slot7.y * slot4

		if slot0.spine:getLookDir() == SpineLookDir.Right then
			slot7.x = -slot7.x
		end

		slot6.x = slot6.x * slot3
		slot6.y = slot6.y * slot4

		return slot6, slot7
	end

	return uv1, uv1
end

function slot0.getModelSize(slot0)
	slot1, slot2 = uv0.getEntityBoxSizeOffsetV2(slot0)

	if slot1.x + slot1.y > 14 then
		return 4
	elseif slot3 > 7 then
		return 3
	elseif slot3 > 3 then
		return 2
	else
		return 1
	end
end

function slot0.getEffectUrlWithLod(slot0)
	return ResUrl.getEffect(slot0)
end

function slot0.processRoundStep(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0) do
		uv0.addRoundStep(slot1, slot6)
	end

	return slot1
end

function slot0.addRoundStep(slot0, slot1)
	table.insert(slot0, slot1)
	uv0.detectStepEffect(slot0, slot1.actEffect)
end

function slot0.detectStepEffect(slot0, slot1)
	if slot1 and #slot1 > 0 then
		slot2 = 1

		while slot1[slot2] do
			if slot1[slot2].effectType == FightEnum.EffectType.FIGHTSTEP then
				if slot3.fightStep.actType == FightEnum.ActType.SKILL then
					if uv0.needAddRoundStep(slot4) then
						uv0.addRoundStep(slot0, slot3.fightStep)
					else
						uv0.detectStepEffect(slot0, slot4.actEffect)
					end
				elseif slot4.actType == FightEnum.ActType.CHANGEHERO then
					uv0.addRoundStep(slot0, slot3.fightStep)
				elseif slot4.actType == FightEnum.ActType.CHANGEWAVE then
					uv0.addRoundStep(slot0, slot3.fightStep)
				else
					uv0.detectStepEffect(slot0, slot4.actEffect)
				end
			end

			slot2 = slot2 + 1
		end
	end
end

function slot0.needAddRoundStep(slot0)
	if slot0 then
		if uv0.isTimelineStep(slot0) then
			return true
		elseif slot0.actType == FightEnum.ActType.CHANGEHERO then
			return true
		elseif slot0.actType == FightEnum.ActType.CHANGEWAVE then
			return true
		end
	end
end

function slot0.buildInfoMOs(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0) do
		slot8 = slot1.New()

		slot8:init(slot7)
		table.insert(slot2, slot8)
	end

	return slot2
end

function slot0.logForPCSkillEditor(slot0)
	if not SkillEditorMgr.instance.inEditMode or SLFramework.FrameworkSettings.IsEditor then
		logNormal(slot0)
	end
end

function slot0.getEffectLabel(slot0, slot1)
	if gohelper.isNil(slot0) then
		return
	end

	if not slot0:GetComponentsInChildren(typeof(ZProj.EffectLabel)) or slot2.Length <= 0 then
		return
	end

	slot3 = {}

	for slot7 = 0, slot2.Length - 1 do
		slot8 = slot2[slot7]

		if not slot1 or slot8.label == slot1 then
			table.insert(slot3, slot8)
		end
	end

	return slot3
end

function slot0.shouUIPoisoningEffect(slot0)
	if FightConfig.instance:hasBuffFeature(slot0, FightEnum.BuffType_Dot) and lua_skill_buff.configDict[slot0] and lua_fight_buff_use_poison_ui_effect.configDict[slot2.typeId] then
		return true
	end

	return false
end

function slot0.dealDirectActEffectData(slot0, slot1, slot2)
	slot3 = uv0.filterActEffect(slot0, slot2)
	slot4 = #slot3
	slot5 = {}

	if slot3[slot1] then
		slot5 = slot3[slot1]
	elseif slot4 > 0 then
		slot5 = slot3[slot4]
	end

	return slot5
end

function slot0.filterActEffect(slot0, slot1)
	slot2 = {}
	slot3 = {}
	slot4 = {}

	for slot8, slot9 in ipairs(slot0) do
		slot11 = false

		if slot9.effectType == FightEnum.EffectType.SHIELD and not uv0.checkShieldHit(slot10) then
			slot11 = true
		end

		if not slot11 and slot1[slot9.effectType] then
			if not slot3[slot9.targetId] then
				slot3[slot9.targetId] = {}

				table.insert(slot4, slot9.targetId)
			end

			table.insert(slot3[slot9.targetId], slot9)
		end
	end

	for slot8, slot9 in ipairs(slot4) do
		slot2[slot8] = slot3[slot9]
	end

	return slot2
end

function slot0.detectAttributeCounter()
	slot1, slot2 = uv0.getAttributeCounter(FightModel.instance:getFightParam().monsterGroupIds, GameSceneMgr.instance:isSpScene())

	return slot1, slot2
end

function slot0.getAttributeCounter(slot0, slot1)
	slot2 = nil
	slot3 = {}

	for slot7, slot8 in ipairs(slot0) do
		if not string.nilorempty(lua_monster_group.configDict[slot8].bossId) then
			slot2 = lua_monster_group.configDict[slot8].bossId
		end

		for slot13, slot14 in ipairs(FightStrUtil.instance:getSplitToNumberCache(lua_monster_group.configDict[slot8].monster, "#")) do
			if not lua_monster.configDict[slot14] then
				logError("怪物表找不到id:" .. slot14)
			end

			if lua_monster.configDict[slot14].career ~= 5 and slot15 ~= 6 then
				slot3[slot15] = (slot3[slot15] or 0) + 1

				if uv0.isBossId(lua_monster_group.configDict[slot8].bossId, slot14) then
					slot3[slot15] = (slot3[slot15] or 0) + 1
				end
			end
		end
	end

	slot4 = {}

	if slot1 then
		return slot4, {}
	end

	if #slot4 == 0 then
		slot7 = 0
		slot8 = {}

		for slot13, slot14 in pairs(slot3) do
			if slot14 >= 2 then
				slot6 = 0 + 1

				table.insert({}, slot13)
			else
				slot7 = slot7 + 1

				table.insert(slot8, slot13)
			end
		end

		if slot6 == 1 then
			table.insert(slot4, FightConfig.instance:restrainedBy(slot9[1]))
			table.insert(slot5, FightConfig.instance:restrained(slot9[1]))
		elseif slot6 == 2 then
			if uv0.checkHadRestrain(slot9[1], slot9[2]) then
				table.insert(slot4, FightConfig.instance:restrainedBy(slot9[1]))
				table.insert(slot4, FightConfig.instance:restrainedBy(slot9[2]))
				table.insert(slot5, FightConfig.instance:restrained(slot9[1]))
				table.insert(slot5, FightConfig.instance:restrained(slot9[2]))
			end
		elseif slot6 == 0 then
			if slot7 == 1 then
				table.insert(slot4, FightConfig.instance:restrainedBy(slot8[1]))
				table.insert(slot5, FightConfig.instance:restrained(slot8[1]))
			elseif slot7 == 2 and uv0.checkHadRestrain(slot8[1], slot8[2]) then
				table.insert(slot4, FightConfig.instance:restrainedBy(slot8[1]))
				table.insert(slot4, FightConfig.instance:restrainedBy(slot8[2]))
				table.insert(slot5, FightConfig.instance:restrained(slot8[1]))
				table.insert(slot5, FightConfig.instance:restrained(slot8[2]))
			end
		end
	end

	for slot9 = #slot5, 1, -1 do
		if tabletool.indexOf(slot4, slot5[1]) then
			table.remove(slot5, slot9)
		end
	end

	return slot4, slot5
end

function slot0.checkHadRestrain(slot0, slot1)
	return FightConfig.instance:getRestrain(slot0, slot1) > 1000 or FightConfig.instance:getRestrain(slot1, slot0) > 1000
end

function slot0.setMonsterGuideFocusState(slot0)
	PlayerPrefsHelper.setNumber(FightWorkSkillOrBuffFocusMonster.getPlayerPrefKey(slot0), 1)

	if not string.nilorempty(slot0.completeWithGroup) then
		for slot6, slot7 in ipairs(FightStrUtil.instance:getSplitCache(slot0.completeWithGroup, "|")) do
			slot8 = FightStrUtil.instance:getSplitToNumberCache(slot7, "#")

			if FightConfig.instance:getMonsterGuideFocusConfig(slot8[1], slot8[2], slot8[3], slot8[4]) then
				PlayerPrefsHelper.setNumber(FightWorkSkillOrBuffFocusMonster.getPlayerPrefKey(slot9), 1)
			else
				logError("怪物指引图表找不到id：", slot8[1], slot8[2], slot8[3], slot8[4])
			end
		end
	end
end

function slot0.detectTimelinePlayEffectCondition(slot0, slot1, slot2)
	if string.nilorempty(slot1) or slot1 == "0" then
		return true
	end

	if slot1 == "1" then
		slot3 = false

		for slot7, slot8 in pairs(slot0.actEffectMOs) do
			if slot8.effectType == FightEnum.EffectType.DEAD then
				slot3 = true
			end
		end

		return slot3
	end

	if FightStrUtil.instance:getSplitToNumberCache(slot1, "#")[1] == 2 then
		for slot7, slot8 in ipairs(slot0.actEffectMOs) do
			if slot8.effectType == FightEnum.EffectType.MISS or slot8.effectType == FightEnum.EffectType.DAMAGE or slot8.effectType == FightEnum.EffectType.CRIT or slot8.effectType == FightEnum.EffectType.SHIELD then
				slot9 = uv0.getEntity(slot8.targetId)

				for slot13 = 2, #slot3 do
					if slot2 then
						if slot2 == slot9 and uv0.detectEntityIncludeBuffType(slot9, slot3[slot13]) then
							return true
						end
					elseif uv0.detectEntityIncludeBuffType(slot9, slot3[slot13]) then
						return true
					end
				end
			end
		end
	end

	if slot3[1] == 3 and uv0.getEntity(slot0.fromId) then
		for slot8 = 2, #slot3 do
			if uv0.detectEntityIncludeBuffType(slot4, slot3[slot8]) then
				return true
			end
		end
	end

	if slot3[1] == 4 then
		for slot7, slot8 in ipairs(slot0.actEffectMOs) do
			if slot8.effectType == FightEnum.EffectType.MISS or slot8.effectType == FightEnum.EffectType.DAMAGE or slot8.effectType == FightEnum.EffectType.CRIT or slot8.effectType == FightEnum.EffectType.SHIELD then
				for slot13 = 2, #slot3 do
					if slot2 then
						if slot2 == uv0.getEntity(slot8.targetId) and slot2.buff and slot2.buff:haveBuffId(slot3[slot13]) then
							return true
						end
					elseif slot9.buff and slot9.buff:haveBuffId(slot3[slot13]) then
						return true
					end
				end
			end
		end
	end

	if slot3[1] == 5 and uv0.getEntity(slot0.fromId) and slot4.buff then
		for slot8 = 2, #slot3 do
			if slot4.buff:haveBuffId(slot3[slot8]) then
				return true
			end
		end
	end

	if slot3[1] == 6 then
		for slot7, slot8 in ipairs(slot0.actEffectMOs) do
			if slot8.effectType == FightEnum.EffectType.MISS or slot8.effectType == FightEnum.EffectType.DAMAGE or slot8.effectType == FightEnum.EffectType.CRIT or slot8.effectType == FightEnum.EffectType.SHIELD then
				for slot13 = 2, #slot3 do
					if slot2 then
						if slot2 == uv0.getEntity(slot8.targetId) and slot2:getMO() and slot14.skin == slot3[slot13] then
							return true
						end
					elseif slot9:getMO() and slot14.skin == slot3[slot13] then
						return true
					end
				end
			end
		end
	end

	if slot3[1] == 7 then
		for slot7, slot8 in ipairs(slot0.actEffectMOs) do
			if slot8.targetId == slot0.fromId and slot8.configEffect == slot3[2] then
				if slot8.configEffect == 30011 then
					if slot8.effectNum ~= 0 then
						return true
					end
				else
					return true
				end
			end
		end
	end

	if slot3[1] == 8 then
		for slot7, slot8 in ipairs(slot0.actEffectMOs) do
			if slot8.targetId ~= slot0.fromId and slot8.configEffect == slot3[2] then
				if slot8.configEffect == 30011 then
					if slot8.effectNum ~= 0 then
						return true
					end
				else
					return true
				end
			end
		end
	end

	if slot3[1] == 9 and uv0.getEntity(slot0.fromId) and slot4.buff then
		for slot8 = 2, #slot3 do
			if slot4.buff:haveBuffId(slot3[slot8]) then
				return false
			end
		end

		return true
	end

	return false
end

function slot0.detectEntityIncludeBuffType(slot0, slot1, slot2)
	slot3 = slot0 and slot0:getMO()

	for slot7, slot8 in ipairs(slot2 or slot3 and slot3:getBuffList() or {}) do
		if slot1 == lua_skill_bufftype.configDict[lua_skill_buff.configDict[slot8.buffId].typeId].type then
			return true
		end
	end
end

function slot0.hideDefenderBuffEffect(slot0, slot1)
	slot3 = {}

	if lua_skin_monster_hide_buff_effect.configDict[slot0.actId] then
		slot4 = {}
		slot5 = nil

		if slot2.effectName == "all" then
			slot5 = true
		end

		slot6 = FightStrUtil.instance:getSplitCache(slot2.effectName, "#")
		slot8 = {}

		for slot12, slot13 in ipairs(uv0.getDefenders(slot0, true)) do
			if not slot8[slot13.id] then
				slot8[slot13.id] = true

				if uv0.isAssembledMonster(slot13) then
					for slot18, slot19 in ipairs(uv0.getSideEntitys(slot13:getSide())) do
						if uv0.isAssembledMonster(slot19) and not slot8[slot19.id] then
							slot8[slot19.id] = true

							table.insert(slot7, slot19)
						end
					end
				end
			end
		end

		for slot12, slot13 in ipairs(slot7) do
			if slot5 and slot13.skinSpineEffect then
				slot3[slot13.id] = slot13.id

				if slot14._effectWrapDict then
					for slot18, slot19 in pairs(slot14._effectWrapDict) do
						table.insert(slot4, slot19)
					end
				end
			end

			if slot13.buff and slot13.buff._buffEffectDict then
				for slot18, slot19 in pairs(slot14) do
					if slot5 then
						slot3[slot13.id] = slot13.id

						table.insert(slot4, slot19)
					else
						for slot23, slot24 in ipairs(slot6) do
							if uv0.getEffectUrlWithLod(slot24) == slot19.path then
								slot3[slot13.id] = slot13.id

								table.insert(slot4, slot19)
							end
						end
					end
				end
			end
		end

		slot10 = {
			[uv0.getEffectUrlWithLod(slot15)] = true
		}

		for slot14, slot15 in ipairs(FightStrUtil.instance:getSplitCache(slot2.exceptEffect, "#")) do
			-- Nothing
		end

		for slot14, slot15 in ipairs(slot4) do
			if not slot10[slot4[slot14].path] then
				slot16:setActive(false, slot1)
			end
		end
	end

	return slot3
end

function slot0.revertDefenderBuffEffect(slot0, slot1)
	for slot5, slot6 in ipairs(slot0) do
		if uv0.getEntity(slot6) then
			if slot7.buff then
				slot7.buff:showBuffEffects(slot1)
			end

			if slot7.skinSpineEffect then
				slot7.skinSpineEffect:showEffects(slot1)
			end
		end
	end
end

function slot0.getEffectAbPath(slot0)
	if GameResMgr.IsFromEditorDir or string.find(slot0, "/buff/") then
		return slot0
	else
		return SLFramework.FileHelper.GetUnityPath(System.IO.Path.GetDirectoryName(slot0))
	end
end

function slot0.getRolesTimelinePath(slot0)
	if GameResMgr.IsFromEditorDir then
		return ResUrl.getSkillTimeline(slot0)
	else
		return ResUrl.getRolesTimeline()
	end
end

function slot0.getCameraAniPath(slot0)
	if GameResMgr.IsFromEditorDir then
		return ResUrl.getCameraAnim(slot0)
	else
		return ResUrl.getCameraAnimABUrl()
	end
end

function slot0.getEntityAniPath(slot0)
	if GameResMgr.IsFromEditorDir then
		return ResUrl.getEntityAnim(slot0)
	else
		return ResUrl.getEntityAnimABUrl()
	end
end

function slot0.refreshCombinativeMonsterScaleAndPos(slot0, slot1)
	if not slot0:getMO() then
		return
	end

	if not FightConfig.instance:getSkinCO(slot2.skin) or slot3.canHide ~= 1 then
		return
	end

	slot5 = nil

	for slot9, slot10 in ipairs(uv0.getSideEntitys(slot0:getSide())) do
		slot10:setScale(slot1)

		if slot10:getMO() and FightConfig.instance:getSkinCO(slot11.skin) and slot12.mainBody == 1 then
			slot5 = slot10
		end
	end

	if slot5 then
		slot6, slot7, slot8 = uv0.getEntityStandPos(slot5:getMO())
		slot9, slot10, slot11 = transformhelper.getPos(slot5.go.transform)

		for slot15, slot16 in ipairs(slot4) do
			if slot16 ~= slot5 then
				slot17, slot18, slot19 = uv0.getEntityStandPos(slot16:getMO())

				transformhelper.setPos(slot16.go.transform, (slot17 - slot6) * slot1 + slot9, (slot18 - slot7) * slot1 + slot10, (slot19 - slot8) * slot1 + slot11)
			end
		end
	end
end

function slot0.getEntityDefaultIdleAniName(slot0)
	if slot0:getMO() and slot1.modelId == 3025 then
		for slot6, slot7 in ipairs(uv0.getSideEntitys(slot0:getSide(), true)) do
			if slot7:getMO().modelId == 3028 then
				return SpineAnimState.idle_special
			end
		end
	end

	return SpineAnimState.idle1
end

slot0.XingTiSpineUrl2Special = {
	["roles/500502_xingti2hao/500502_xingti2hao_fight.prefab"] = "roles/500502_xingti2hao_special/500502_xingti2hao_special_fight.prefab",
	["roles/500503_xingti2hao/500503_xingti2hao_fight.prefab"] = "roles/500503_xingti2hao_special/500503_xingti2hao_special_fight.prefab",
	["roles/500501_xingti2hao/500501_xingti2hao_fight.prefab"] = "roles/500501_xingti2hao_special/500501_xingti2hao_special_fight.prefab"
}

function slot0.preloadXingTiSpecialUrl(slot0)
	if uv0.isShowTogether(FightEnum.EntitySide.MySide, {
		3025,
		3028
	}) then
		for slot5, slot6 in ipairs(slot0) do
			if slot6 == 3025 then
				return 2
			end
		end

		return 1
	end
end

function slot0.detectXingTiSpecialUrl(slot0)
	if slot0:isMySide() then
		return uv0.isShowTogether(slot0:getSide(), {
			3025,
			3028
		})
	end
end

function slot0.isShowTogether(slot0, slot1)
	for slot7, slot8 in ipairs(FightDataHelper.entityMgr:getSideList(slot0)) do
		if tabletool.indexOf(slot1, slot8.modelId) then
			slot3 = 0 + 1
		end
	end

	if slot3 == #slot1 then
		return true
	end
end

function slot0.getPredeductionExpoint(slot0)
	slot1 = 0

	if FightModel.instance:getCurStage() == FightEnum.Stage.Card and uv0.getEntity(slot0) then
		slot3 = slot2:getMO()

		for slot8, slot9 in ipairs(FightCardModel.instance:getCardOps()) do
			if slot0 == slot9.belongToEntityId and slot9:isPlayCard() and slot3:isUniqueSkill(slot9.skillId) then
				slot1 = slot1 + slot3:getUniqueSkillPoint()
			end
		end
	end

	return slot1
end

function slot0.setBossSkillSpeed(slot0)
	if uv0.getEntity(slot0) and slot1:getMO() and lua_monster_skin.configDict[slot2.skin] and slot3.bossSkillSpeed == 1 then
		FightModel.instance.useBossSkillSpeed = true

		FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	end
end

function slot0.cancelBossSkillSpeed()
	if FightModel.instance.useBossSkillSpeed then
		FightModel.instance.useBossSkillSpeed = false

		FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	end
end

function slot0.setTimelineExclusiveSpeed(slot0)
	if lua_fight_timeline_speed.configDict[slot0] then
		FightModel.instance.useExclusiveSpeed = FightStrUtil.instance:getSplitToNumberCache(slot1.speed, "#")[FightModel.instance:getUserSpeed()]

		FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	end
end

function slot0.cancelExclusiveSpeed()
	if FightModel.instance.useExclusiveSpeed then
		FightModel.instance.useExclusiveSpeed = false

		FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	end
end

function slot0.needPlayTransitionAni(slot0, slot1)
	if slot0 and slot0:getMO() and lua_fight_transition_act.configDict[slot2.skin] and slot4[slot0.spine:getAnimState()] and slot4[slot5][slot1] then
		return true, slot4[slot5][slot1].transitionAct
	end
end

function slot0._stepBuffDealStackedBuff(slot0, slot1, slot2, slot3)
	slot4 = false

	if slot3 and slot3._actEffectMO and not FightSkillBuffMgr.instance:hasPlayBuff(slot5) and lua_skill_buff.configDict[slot5.buff.buffId] and slot6.id == slot2.id and slot5.effectType == FightEnum.EffectType.BUFFADD then
		slot4 = true
	end

	table.insert(slot1, FunctionWork.New(function ()
		if uv0.getEntity(uv1) then
			slot0.buff.lockFloat = uv2
		end
	end))
	table.insert(slot1, WorkWaitSeconds.New(0.01))
end

function slot0.hideAllEntity()
	for slot4, slot5 in ipairs(uv0.getAllEntitys()) do
		slot5:setActive(false, true)
		slot5:setVisibleByPos(false)
		slot5:setAlpha(0, 0)
	end
end

function slot0.isBossId(slot0, slot1)
	for slot6, slot7 in ipairs(FightStrUtil.instance:getSplitToNumberCache(slot0, "#")) do
		if slot1 == slot7 then
			return true
		end
	end
end

function slot0.getCurBossId()
	slot1 = FightModel.instance:getCurMonsterGroupId() and lua_monster_group.configDict[slot0]

	return slot1 and not string.nilorempty(slot1.bossId) and slot1.bossId or nil
end

function slot0.setEffectEntitySide(slot0)
	if slot0.targetId == FightEntityScene.MySideId then
		slot0.entityMO.side = FightEnum.EntitySide.MySide

		return
	elseif slot1 == FightEntityScene.EnemySideId then
		slot0.entityMO.side = FightEnum.EntitySide.EnemySide

		return
	end

	if FightDataHelper.entityMgr:getById(slot1) and slot0.entityMO then
		slot0.entityMO.side = slot2.side
	end
end

function slot0.preloadZongMaoShaLiMianJu(slot0, slot1)
	if uv0.getZongMaoShaLiMianJuPath(slot0) then
		table.insert(slot1, slot2)
	end
end

function slot0.setZongMaoShaLiMianJuSpineUrl(slot0, slot1)
	if uv0.getZongMaoShaLiMianJuPath(slot0) then
		slot1[slot2] = true
	end
end

function slot0.getZongMaoShaLiMianJuPath(slot0)
	if lua_skin.configDict[slot0] and slot1.characterId == 3072 then
		slot2 = string.format("roles/v1a3_%d_zongmaoshali_m/%d_zongmaoshali_m_fight.prefab", slot0, slot0)

		if slot1.id == 307203 then
			slot2 = "roles/v2a2_307203_zmsl_m/307203_zmsl_m_fight.prefab"
		end

		return slot2
	end
end

function slot0.getEnemyEntityByMonsterId(slot0)
	for slot5, slot6 in ipairs(uv0.getSideEntitys(FightEnum.EntitySide.EnemySide)) do
		if slot6:getMO() and slot7.modelId == slot0 then
			return slot6
		end
	end
end

function slot0.sortAssembledMonster(slot0)
	if slot0:getByIndex(1) and lua_fight_assembled_monster.configDict[slot1.skin] then
		slot0:sort(uv0.sortAssembledMonsterFunc)
	end
end

function slot0.sortAssembledMonsterFunc(slot0, slot1)
	if slot0 and lua_fight_assembled_monster.configDict[slot0.skin] and not (slot1 and lua_fight_assembled_monster.configDict[slot1.skin]) then
		return true
	elseif not slot2 and slot3 then
		return false
	elseif slot2 and slot3 then
		return slot2.part < slot3.part
	else
		return tonumber(slot1.id) < tonumber(slot0.id)
	end
end

function slot0.sortBuffReplaceSpineActConfig(slot0, slot1)
	return slot1.priority < slot0.priority
end

function slot0.processEntityActionName(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	if slot0:getMO() and lua_fight_buff_replace_spine_act.configDict[slot3.skin] then
		slot5 = {}

		for slot9, slot10 in pairs(slot4) do
			for slot14, slot15 in pairs(slot10) do
				table.insert(slot5, slot15)
			end
		end

		table.sort(slot5, uv0.sortBuffReplaceSpineActConfig)

		if slot0.buff then
			for slot10, slot11 in ipairs(slot5) do
				if slot6:haveBuffId(slot11.buffId) then
					for slot16, slot17 in ipairs(slot11.combination) do
						if slot6:haveBuffId(slot17) then
							slot12 = 0 + 1
						end
					end

					if slot12 == #slot11.combination and slot0.spine and slot0.spine:hasAnimation(slot1 .. slot11.suffix) then
						slot1 = slot1 .. slot11.suffix

						break
					end
				end
			end
		end
	end

	if slot1 and slot3 and lua_fight_skin_special_behaviour.configDict[slot3.skin] and slot0.buff then
		if string.find(slot1, "hit") then
			slot6 = "hit"
		end

		if not string.nilorempty(slot4[slot6]) then
			for slot11, slot12 in ipairs(GameUtil.splitString2(slot4[slot6])) do
				if slot5:haveBuffId(tonumber(slot12[1])) then
					slot1 = slot12[2]
				end
			end
		end
	end

	if uv0.isAssembledMonster(slot0) and slot1 == "hit" then
		slot4 = slot0:getPartIndex()

		if slot2 then
			for slot8, slot9 in ipairs(slot2.actEffectMOs) do
				if FightTLEventDefHit.directCharacterHitEffectType[slot9.effectType] and slot9.targetId ~= slot0.id and (isTypeOf(uv0.getEntity(slot9.targetId), FightEntityAssembledMonsterMain) or isTypeOf(slot10, FightEntityAssembledMonsterSub)) then
					return slot1
				end
			end
		end

		slot1 = string.format("%s_part_%d", slot1, slot4)
	end

	return slot1
end

function slot0.getProcessEntityStancePos(slot0)
	slot1, slot2, slot3 = uv0.getEntityStandPos(slot0)

	if uv0.getEntity(slot0.id) and uv0.isAssembledMonster(slot4) then
		slot6 = lua_fight_assembled_monster.configDict[slot0.skin].virtualStance

		return slot1 + slot6[1], slot2 + slot6[2], slot3 + slot6[3]
	end

	return slot1, slot2, slot3
end

function slot0.isAssembledMonster(slot0)
	if isTypeOf(slot0, FightEntityAssembledMonsterMain) or isTypeOf(slot0, FightEntityAssembledMonsterSub) then
		return true
	end
end

function slot0.getProcessEntitySpinePos(slot0)
	slot1, slot2, slot3 = transformhelper.getPos(slot0.go.transform)

	if uv0.isAssembledMonster(slot0) then
		slot5 = lua_fight_assembled_monster.configDict[slot0:getMO().skin]
		slot1 = slot1 + slot5.virtualStance[1]
		slot2 = slot2 + slot5.virtualStance[2]
		slot3 = slot3 + slot5.virtualStance[3]
	end

	return slot1, slot2, slot3
end

function slot0.getProcessEntitySpineLocalPos(slot0)
	if uv0.isAssembledMonster(slot0) then
		slot5 = lua_fight_assembled_monster.configDict[slot0:getMO().skin]
		slot1 = 0 + slot5.virtualStance[1]
		slot2 = 0 + slot5.virtualStance[2]
		slot3 = 0 + slot5.virtualStance[3]
	end

	return slot1, slot2, slot3
end

slot4 = {}

function slot0.getAssembledEffectPosOfSpineHangPointRoot(slot0, slot1)
	if uv0[slot1] then
		return 0, 0, 0
	end

	return uv1.getProcessEntitySpineLocalPos(slot0)
end

function slot0.processBuffEffectPath(slot0, slot1, slot2, slot3, slot4)
	if lua_fight_effect_buff_skin.configDict[slot2] then
		slot5 = (not slot5[1] or slot5[1]) and slot5[2]

		for slot11, slot12 in ipairs(uv0.getSideEntitys(slot1:getSide(), true)) do
			if slot12:getMO() and slot5[slot13.skin] and not string.nilorempty(slot5[slot14][slot3]) then
				return slot5[slot14][slot3], slot5[slot14].audio ~= 0 and slot15 or slot4
			end
		end
	end

	return slot0, slot4
end

function slot0.filterBuffEffectBySkin(slot0, slot1, slot2, slot3)
	if not lua_fight_buff_effect_to_skin.configDict[slot0] then
		return slot2, slot3
	end

	slot5 = slot1 and slot1:getMO()

	if not (slot5 and slot5.skin) then
		return "", 0
	end

	if tabletool.indexOf(FightStrUtil.instance:getSplitToNumberCache(slot4.skinIdList, "|"), slot6) then
		return slot2, slot3
	end

	return "", 0
end

function slot0.getBuffListForReplaceTimeline(slot0, slot1, slot2)
	if slot0 and slot0.simulate == 1 then
		slot3 = uv0.simulateFightStepMO(slot2, uv0.getEntitysCloneBuff(slot1))
	end

	slot4 = {}

	for slot8, slot9 in pairs(slot3) do
		tabletool.addValues(slot4, slot9)
	end

	return slot4
end

function slot0.getTimelineListByName(slot0, slot1)
	slot2 = slot0
	slot3 = {}

	if lua_fight_replace_timeline.configDict[slot0] then
		for slot8, slot9 in pairs(slot4) do
			if FightStrUtil.instance:getSplitCache(slot9.condition, "#")[1] == "5" then
				for slot16 = 2, #slot10 do
				end

				if ({
					[tonumber(slot10[slot16])] = true
				})[slot1] then
					slot2 = slot9.timeline
				end
			else
				table.insert(slot3, slot9.timeline)
			end
		end
	end

	table.insert(slot3, slot2)

	return slot3
end

slot5 = {}

function slot0.detectReplaceTimeline(slot0, slot1)
	if lua_fight_replace_timeline.configDict[slot0] then
		slot3 = {}

		for slot7, slot8 in pairs(slot2) do
			table.insert(slot3, slot8)
		end

		table.sort(slot3, uv0.sortReplaceTimelineConfig)

		for slot7, slot8 in ipairs(slot3) do
			slot9 = {
				[slot1.fromId] = FightDataHelper.entityMgr:getById(slot1.fromId)
			}

			if slot8.target == 1 then
				-- Nothing
			elseif slot8.target == 2 then
				slot9[slot1.toId] = FightDataHelper.entityMgr:getById(slot1.toId)
			elseif slot8.target == 3 or slot8.target == 4 then
				slot10 = nil
				slot12 = FightDataHelper.entityMgr
				slot16 = slot8.target == 4

				for slot16, slot17 in ipairs(slot12:getSideList((slot1.fromId ~= FightEntityScene.MySideId or FightEnum.EntitySide.MySide) and (slot11 ~= FightEntityScene.EnemySideId or FightEnum.EntitySide.EnemySide) and (not FightDataHelper.entityMgr:getById(slot1.fromId) or slot12.side) and FightEnum.EntitySide.MySide, nil, slot16)) do
					slot9[slot17.id] = slot17
				end
			end

			if FightStrUtil.instance:getSplitCache(slot8.condition, "#")[1] == "1" then
				for slot18, slot19 in ipairs(uv0.getBuffListForReplaceTimeline(slot8, slot9, slot1)) do
					if slot19.buffId == tonumber(slot10[2]) and tonumber(slot10[3]) <= slot19.count then
						return slot8.timeline
					end
				end
			elseif slot11 == "2" then
				for slot15, slot16 in pairs(slot1.actEffectMOs) do
					if slot16.effectType == FightEnum.EffectType.DEAD then
						return slot8.timeline
					end
				end
			elseif slot11 == "3" then
				for slot16 = 2, #slot10 do
					if uv0.detectEntityIncludeBuffType(nil, tonumber(slot10[slot16]), uv0.getBuffListForReplaceTimeline(slot8, slot9, slot1)) then
						return slot8.timeline
					end
				end
			elseif slot11 == "4" then
				slot12 = {
					[tonumber(slot10[slot16])] = true
				}

				for slot16 = 2, #slot10 do
				end

				for slot17, slot18 in ipairs(uv0.getBuffListForReplaceTimeline(slot8, slot9, slot1)) do
					if slot12[slot18.buffId] then
						return slot8.timeline
					end
				end
			elseif slot11 == "5" then
				slot12 = {
					[tonumber(slot10[slot16])] = true
				}

				for slot16 = 2, #slot10 do
				end

				for slot16, slot17 in pairs(slot9) do
					slot18 = slot17.skin

					if slot8.target == 1 then
						slot18 = uv0.processSkinByStepMO(slot1, slot17)
					end

					if slot17 and slot12[slot18] then
						return slot8.timeline
					end
				end
			elseif slot11 == "6" then
				slot12 = {
					[tonumber(slot10[slot16])] = true
				}

				for slot16 = 2, #slot10 do
				end

				for slot16, slot17 in ipairs(slot1.actEffectMOs) do
					if slot9[slot17.targetId] and slot12[slot17.configEffect] then
						return slot8.timeline
					end
				end
			elseif slot11 == "7" then
				slot12 = {
					[tonumber(slot10[slot16])] = true
				}

				for slot16 = 2, #slot10 do
				end

				for slot17, slot18 in ipairs(uv0.getBuffListForReplaceTimeline(slot8, slot9, slot1)) do
					if slot12[slot18.buffId] then
						return slot0
					end
				end

				return slot8.timeline
			elseif slot11 == "8" then
				slot12 = tonumber(slot10[2])
				slot13 = tonumber(slot10[3])
				slot14 = uv0.getEntitysCloneBuff(slot9)

				if slot8.simulate == 1 then
					for slot19, slot20 in ipairs(uv0.getBuffListForReplaceTimeline(nil, slot9, slot1)) do
						if slot20.buffId == slot12 and slot13 <= slot20.count then
							return slot8.timeline
						end
					end

					if uv0.simulateFightStepMO(slot1, slot14, uv0.detectBuffCountEnough, {
						buffId = slot12,
						count = slot13
					}) == true then
						return slot8.timeline
					end
				else
					for slot19, slot20 in ipairs(uv0.getBuffListForReplaceTimeline(slot8, slot9, slot1)) do
						if slot20.buffId == slot12 and slot13 <= slot20.count then
							return slot8.timeline
						end
					end
				end
			elseif slot11 == "9" then
				while true do
					if math.random(1, #slot3) ~= uv1[slot0] then
						uv1[slot0] = slot13

						return slot3[slot13].timeline
					end
				end
			elseif slot11 == "10" then
				if tonumber(slot10[2]) == 1 then
					if slot1.fromId == slot1.toId then
						return slot8.timeline
					end
				elseif slot12 == 2 and slot1.fromId ~= slot1.toId then
					return slot8.timeline
				end
			elseif slot11 == "11" then
				slot12 = {
					[tonumber(slot10[slot17])] = true
				}
				slot13 = tonumber(slot10[2])

				for slot17 = 3, #slot10 do
				end

				for slot17, slot18 in pairs(slot9) do
					slot19 = slot18.skin

					if slot8.target == 1 then
						slot19 = uv0.processSkinByStepMO(slot1, slot18)
					end

					if slot13 == slot19 then
						for slot24, slot25 in ipairs(uv0.getBuffListForReplaceTimeline(slot8, slot9, slot1)) do
							if slot12[slot25.buffId] then
								return slot8.timeline
							end
						end
					end
				end
			elseif slot11 == "12" then
				slot12 = {
					[tonumber(slot10[slot16])] = true
				}

				for slot16 = 2, #slot10 - 1 do
				end

				for slot16, slot17 in pairs(slot9) do
					slot18 = slot17.skin

					if slot8.target == 1 then
						slot18 = uv0.processSkinByStepMO(slot1, slot17)
					end

					if slot17 and slot12[slot18] then
						if slot10[#slot10] == "1" then
							if slot1.fromId == slot1.toId then
								return slot8.timeline
							end
						elseif slot19 == "2" then
							slot21 = FightDataHelper.entityMgr:getById(slot1.toId)

							if FightDataHelper.entityMgr:getById(slot1.fromId) and slot21 and slot20.id ~= slot21.id and slot20.side == slot21.side then
								return slot8.timeline
							end
						elseif slot19 == "3" then
							slot21 = FightDataHelper.entityMgr:getById(slot1.toId)

							if FightDataHelper.entityMgr:getById(slot1.fromId) and slot21 and slot20.side ~= slot21.side then
								return slot8.timeline
							end
						end
					end
				end
			end
		end
	end

	return slot0
end

function slot0.detectBuffCountEnough(slot0, slot1)
	for slot7, slot8 in ipairs(slot0) do
		if slot1.buffId == slot8.buffId and slot1.count <= slot8.count then
			return true
		end
	end
end

function slot0.simulateFightStepMO(slot0, slot1, slot2, slot3)
	for slot7, slot8 in ipairs(slot0.actEffectMOs) do
		slot12 = slot1 and slot1[slot9]

		if uv0.getEntity(slot8.targetId) and slot10:getMO() and slot12 then
			if slot8.effectType == FightEnum.EffectType.BUFFADD then
				if not slot11:getBuffMO(slot8.buff.uid) then
					slot14 = FightBuffMO.New()

					slot14:init(slot8.buff, slot8.targetId)
					table.insert(slot12, slot14)
				end

				if slot2 and slot2(slot12, slot3) then
					return true
				end
			elseif slot8.effectType == FightEnum.EffectType.BUFFDEL or slot8.effectType == FightEnum.EffectType.BUFFDELNOEFFECT then
				for slot16, slot17 in ipairs(slot12) do
					if slot17.uid == slot8.buff.uid then
						table.remove(slot12, slot16)

						break
					end
				end

				if slot2 and slot2(slot12, slot3) then
					return true
				end
			elseif slot8.effectType == FightEnum.EffectType.BUFFUPDATE then
				for slot16, slot17 in ipairs(slot12) do
					if slot17.uid == slot8.buff.uid then
						slot17:init(slot8.buff, slot9)
					end
				end

				if slot2 and slot2(slot12, slot3) then
					return true
				end
			end
		end
	end

	return slot1
end

function slot0.getEntitysCloneBuff(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0) do
		slot7 = {}

		for slot12, slot13 in ipairs(slot6:getBuffList()) do
			table.insert(slot7, slot13:clone())
		end

		slot1[slot6.id] = slot7
	end

	return slot1
end

function slot0.sortReplaceTimelineConfig(slot0, slot1)
	return slot0.priority < slot1.priority
end

function slot0.getMagicSide(slot0)
	if FightDataHelper.entityMgr:getById(slot0) then
		return slot1.side
	elseif slot0 == FightEntityScene.MySideId then
		return FightEnum.EntitySide.MySide
	elseif slot0 == FightEntityScene.EnemySideId then
		return FightEnum.EntitySide.EnemySide
	end

	return FightEnum.EntitySide.MySide
end

function slot0.isBossRushChannelSkill(slot0)
	if lua_skill.configDict[slot0] and lua_skill_effect.configDict[slot1.skillEffect] then
		for slot7 = 1, FightEnum.MaxBehavior do
			if not string.nilorempty(slot3["behavior" .. slot7]) and FightStrUtil.instance:getSplitCache(slot8, "#")[1] == "1" and lua_skill_buff.configDict[tonumber(slot9[2])] and FightStrUtil.instance:getSplitCache(slot11.features, "#")[1] == "742" then
				return true, tonumber(slot12[2]), tonumber(slot12[5])
			end
		end
	end
end

function slot0.processEntitySkin(slot0, slot1)
	if HeroModel.instance:getById(slot1) and slot2.skin > 0 then
		return slot2.skin
	end

	return slot0
end

function slot0.isPlayerCardSkill(slot0)
	if not slot0.cardIndex then
		return
	end

	if slot0.cardIndex == 0 then
		return
	end

	if slot0.fromId == FightEntityScene.MySideId then
		return true
	end

	if not FightDataHelper.entityMgr:getById(slot1) then
		return
	end

	return slot2.teamType == FightEnum.TeamType.MySide
end

function slot0.isEnemyCardSkill(slot0)
	if not slot0.cardIndex then
		return
	end

	if slot0.cardIndex == 0 then
		return
	end

	if slot0.fromId == FightEntityScene.EnemySideId then
		return true
	end

	if not FightDataHelper.entityMgr:getById(slot1) then
		return
	end

	return slot2.teamType == FightEnum.TeamType.EnemySide
end

function slot0.buildMonsterA2B(slot0, slot1, slot2, slot3)
	slot2:addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.BeforeMonsterA2B, slot1.modelId))

	if lua_fight_boss_evolution_client.configDict[slot1.skin] then
		slot2:addWork(Work2FightWork.New(FightWorkPlayTimeline, slot0, slot4.timeline))
		slot2:registWork(FightWorkFunction, uv0.setBossEvolution, uv0, slot0, slot4)
	end

	if slot3 then
		slot2:addWork(slot3)
	end

	slot2:addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.AfterMonsterA2B, slot1.modelId))
end

function slot0.setBossEvolution(slot0, slot1, slot2)
	FightController.instance:dispatchEvent(FightEvent.SetBossEvolution, slot1, slot2.nextSkinId)
	FightMsgMgr.sendMsg(FightMsgId.SetBossEvolution, slot1, slot2.nextSkinId)

	if uv0.getEntity(slot1.id) == slot1 then
		GameSceneMgr.instance:getCurScene().entityMgr:removeUnitData(slot1:getTag(), slot1.id)
	end
end

function slot0.buildDeadPerformanceWork(slot0, slot1)
	slot2 = FlowSequence.New()

	for slot6 = 1, FightEnum.DeadPerformanceMaxNum do
		slot8 = slot0["actParam" .. slot6]

		if slot0["actType" .. slot6] == 0 then
			break
		end

		if slot7 == 1 then
			slot2:addWork(FightWorkPlayTimeline.New(slot1, slot8))
		elseif slot7 == 2 then
			slot2:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.DeadPerformanceNoCondition, tonumber(slot8)))
		end
	end

	return slot2
end

function slot0.compareData(slot0, slot1, slot2)
	if type(slot0) == "function" then
		return true
	elseif slot3 == "table" then
		for slot7, slot8 in pairs(slot0) do
			slot9 = false

			if type(slot7) == "table" then
				slot9 = true
			end

			if slot2 and slot2[slot7] then
				slot9 = true
			end

			if not slot1 then
				return false
			end

			if type(slot1) ~= "table" then
				return false
			end

			if not slot9 and not uv0.compareData(slot8, slot1[slot7], slot2) then
				return false, slot7, slot8, slot1[slot7]
			end
		end

		return true
	else
		return slot0 == slot1
	end
end

slot6 = 0

function slot0.logStr(slot0, slot1)
	slot2 = ""
	uv0 = 0

	return type(slot0) == "table" and slot2 .. uv1.logTable(slot0, slot1) or slot2 .. tostring(slot0)
end

function slot0.logTable(slot0, slot1)
	slot2 = "" .. "{\n"
	uv0 = uv0 + 1
	slot3 = tabletool.len(slot0)
	slot4 = 0

	for slot8, slot9 in pairs(slot0) do
		slot10 = false

		if slot1 and slot1[slot8] then
			slot10 = true
		end

		if not slot10 then
			for slot14 = 1, uv0 do
				slot2 = slot2 .. "\t"
			end

			slot2 = slot2 .. slot8 .. " = "

			if slot3 > slot4 + 1 then
				slot2 = (type(slot9) == "table" and slot2 .. uv1.logTable(slot9, slot1) or slot2 .. tostring(slot9)) .. ","
			end

			slot2 = slot2 .. "\n"
		end
	end

	uv0 = uv0 - 1

	for slot8 = 1, uv0 do
		slot2 = slot2 .. "\t"
	end

	return slot2 .. "}"
end

function slot0.deepCopySimpleWithMeta(slot0, slot1)
	if type(slot0) ~= "table" then
		return slot0
	else
		slot2 = {}

		for slot6, slot7 in pairs(slot0) do
			slot8 = false

			if slot1 and slot1[slot6] then
				slot8 = true
			end

			if not slot8 then
				slot2[slot6] = uv0.deepCopySimpleWithMeta(slot7, slot1)
			end
		end

		if getmetatable(slot0) then
			setmetatable(slot2, slot3)
		end

		return slot2
	end
end

function slot0.getPassiveSkill(slot0, slot1)
	if not FightDataHelper.entityMgr:getById(slot0) then
		return slot1
	end

	for slot7, slot8 in pairs(slot2.upgradedOptions) do
		if lua_hero_upgrade_options.configDict[slot8] and not string.nilorempty(slot9.replacePassiveSkill) then
			for slot14, slot15 in ipairs(GameUtil.splitString2(slot9.replacePassiveSkill, true)) do
				if slot1 == slot15[1] and slot2:isPassiveSkill(slot15[2]) then
					return slot15[2]
				end
			end
		end
	end

	return slot1
end

function slot0.isSupportCard(slot0)
	if slot0.cardType == FightEnum.CardType.SUPPORT_NORMAL or slot0.cardType == FightEnum.CardType.SUPPORT_EX then
		return true
	end
end

function slot0.curIsRougeFight()
	if not FightModel.instance:getFightParam() then
		return false
	end

	return DungeonConfig.instance:getChapterCO(slot0.chapterId) and slot2.type == DungeonEnum.ChapterType.Rouge
end

function slot0.processSkinByStepMO(slot0, slot1)
	slot1 = slot1 or FightDataHelper.entityMgr:getById(slot0.fromId)

	if slot0.supportHeroId ~= 0 and slot1 and slot1.modelId ~= slot2 then
		if uv0.curIsRougeFight() and RougeModel.instance:getTeamInfo() and slot3:getAssistHeroMo(slot2) then
			return slot4.skin
		end

		if HeroModel.instance:getByHeroId(slot2) and slot3.skin > 0 then
			return slot3.skin
		elseif lua_character.configDict[slot2] then
			return slot4.skinId
		end
	end

	return slot1 and slot1.skin or 0
end

function slot0.processSkinId(slot0, slot1)
	if (slot1.cardType == FightEnum.CardType.SUPPORT_NORMAL or slot1.cardType == FightEnum.CardType.SUPPORT_EX) and slot1.heroId ~= slot0.modelId then
		if HeroModel.instance:getByHeroId(slot1.heroId) and slot2.skin > 0 then
			return slot2.skin
		elseif lua_character.configDict[slot1.heroId] then
			return slot3.skinId
		end
	end

	return slot0.skin
end

function slot0.processNextSkillId(slot0)
	if DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId) and slot1.type == DungeonEnum.EpisodeType.Rouge and FightModel.instance:getRougeExData(FightEnum.ExIndexForRouge.SupportHeroSkill) then
		for slot6, slot7 in pairs(cjson.decode(slot2)) do
			if slot7.skill1 then
				for slot11, slot12 in ipairs(slot7.skill1) do
					slot13 = slot7.skill1[slot11 + 1]

					if slot12 == slot0 and slot13 then
						return slot13
					end
				end
			end

			if slot7.skill2 then
				for slot11, slot12 in ipairs(slot7.skill2) do
					slot13 = slot7.skill2[slot11 + 1]

					if slot12 == slot0 and slot13 then
						return slot13
					end
				end
			end
		end
	end
end

function slot0.isTimelineStep(slot0)
	if slot0 and slot0.actType == FightEnum.ActType.SKILL and not string.nilorempty(FightConfig.instance:getSkinSkillTimeline(FightDataHelper.entityMgr:getById(slot0.fromId) and slot1.skin, slot0.actId)) then
		return true
	end
end

function slot0.getClickEntity(slot0, slot1, slot2)
	table.sort(slot0, uv0.sortEntityList)

	for slot6, slot7 in ipairs(slot0) do
		if slot7:getMO() then
			slot9, slot10, slot11, slot12, slot13, slot14, slot15, slot16 = nil

			if isTypeOf(uv0.getEntity(slot8.id), FightEntityAssembledMonsterMain) or isTypeOf(slot17, FightEntityAssembledMonsterSub) then
				slot18 = lua_fight_assembled_monster.configDict[slot8.skin]
				slot19, slot20, slot21 = transformhelper.getPos(slot7.go.transform)
				slot19 = slot19 + slot18.virtualSpinePos[1]
				slot20 = slot20 + slot18.virtualSpinePos[2]
				slot21 = slot21 + slot18.virtualSpinePos[3]
				slot15, slot16 = recthelper.worldPosToAnchorPosXYZ(slot19, slot20, slot21, slot1)
				slot22 = slot18.virtualSpineSize[1] * 0.5
				slot23 = slot18.virtualSpineSize[2] * 0.5
				slot30, slot31, slot32 = recthelper.worldPosToAnchorPosXYZ(slot19 - slot22, slot20 - slot23, slot21, slot1)
				slot33, slot34, slot35 = recthelper.worldPosToAnchorPosXYZ(slot19 + slot22, slot20 + slot23, slot21, slot1)
				slot9 = (slot33 - slot30) / 2
				slot10 = slot15 - slot9
				slot11 = slot15 + slot9
				slot12 = (slot34 - slot31) / 2
				slot13 = slot16 - slot12
				slot14 = slot16 + slot12
			else
				slot18, slot19, slot20, slot21 = uv0.calcRect(slot7, slot1)

				if slot7:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle) then
					slot23, slot24, slot25 = transformhelper.getPos(slot22.transform)
					slot15, slot16 = recthelper.worldPosToAnchorPosXYZ(slot23, slot24, slot25, slot1)
				else
					slot15 = (slot18 + slot20) / 2
					slot16 = (slot19 + slot21) / 2
				end

				slot26 = lua_monster_skin.configDict[slot8.skin] and slot25.clickBoxUnlimit == 1
				slot9 = Mathf.Clamp(math.abs(slot18 - slot20), 150, slot26 and 800 or 200) / 2
				slot10 = slot15 - slot9
				slot11 = slot15 + slot9
				slot12 = Mathf.Clamp(math.abs(slot19 - slot21), 150, slot26 and 800 or 500) / 2
				slot13 = slot16 - slot12
				slot14 = slot16 + slot12
			end

			slot18, slot19 = recthelper.screenPosToAnchorPos2(slot2, slot1)

			if slot10 <= slot18 and slot18 <= slot11 and slot13 <= slot19 and slot19 <= slot14 then
				return slot7.id, slot15, slot16
			end
		end
	end
end

function slot0.calcRect(slot0, slot1)
	if not slot0 then
		return 10000, 10000, 10000, 10000
	end

	if not slot0:getHangPoint(ModuleEnum.SpineHangPoint.BodyStatic) then
		return 10000, 10000, 10000, 10000
	end

	slot3, slot4, slot5 = transformhelper.getPos(slot2.transform)
	slot6, slot7 = uv0.getEntityBoxSizeOffsetV2(slot0)
	slot8 = slot0:isMySide() and 1 or -1
	slot9, slot10 = recthelper.worldPosToAnchorPosXYZ(slot3 - slot6.x * 0.5, slot4 - slot6.y * 0.5 * slot8, slot5, slot1)
	slot11, slot12 = recthelper.worldPosToAnchorPosXYZ(slot3 + slot6.x * 0.5, slot4 + slot6.y * 0.5 * slot8, slot5, slot1)

	return slot9, slot10, slot11, slot12
end

function slot0.sortEntityList(slot0, slot1)
	if (isTypeOf(slot0, FightEntityAssembledMonsterMain) or isTypeOf(slot0, FightEntityAssembledMonsterSub)) and (isTypeOf(slot1, FightEntityAssembledMonsterMain) or isTypeOf(slot1, FightEntityAssembledMonsterSub)) then
		return lua_fight_assembled_monster.configDict[slot1:getMO().skin].clickIndex < lua_fight_assembled_monster.configDict[slot0:getMO().skin].clickIndex
	elseif slot4 and not slot5 then
		return true
	elseif not slot4 and slot5 then
		return false
	else
		slot6, slot7, slot8 = uv0.getEntityStandPos(slot2)
		slot9, slot10, slot11 = uv0.getEntityStandPos(slot3)

		if slot8 ~= slot11 then
			return slot8 < slot11
		else
			return tonumber(slot3.id) < tonumber(slot2.id)
		end
	end
end

function slot0.sortNextRoundGetCardConfig(slot0, slot1)
	return slot1.priority < slot0.priority
end

function slot0.sortNextRoundGetCard(slot0, slot1)
	return slot0.index < slot1.index
end

function slot0.getNextRoundGetCardList()
	slot0 = {}
	slot1 = {}

	for slot6, slot7 in ipairs(FightCardModel.instance:getCardOps()) do
		if slot7:isPlayCard() and lua_fight_next_round_get_card.configDict[slot7.skillId] then
			slot10 = {}

			for slot14, slot15 in pairs(slot9) do
				table.insert(slot10, slot15)
			end

			table.sort(slot10, uv0.sortNextRoundGetCardConfig)

			for slot14, slot15 in ipairs(slot10) do
				if uv0.checkNextRoundCardCondition(slot7, slot15.condition) then
					if slot15.exclusion ~= 0 then
						slot0[slot15.exclusion] = slot0[slot15.exclusion] or {}
						slot0[slot15.exclusion].index = slot6
						slot0[slot15.exclusion].skillId = slot15.skillId
						slot0[slot15.exclusion].entityId = slot7.belongToEntityId
						slot0[slot15.exclusion].tempCard = slot15.tempCard

						break
					end

					table.insert(slot1, {
						index = slot6,
						skillId = slot15.skillId,
						entityId = slot7.belongToEntityId,
						tempCard = slot15.tempCard
					})

					break
				end
			end
		end
	end

	for slot6, slot7 in pairs(slot0) do
		table.insert(slot1, slot7)
	end

	table.sort(slot1, uv0.sortNextRoundGetCard)

	slot3 = {}

	for slot7, slot8 in ipairs(slot1) do
		for slot13, slot14 in ipairs(string.splitToNumber(slot8.skillId, "#")) do
			slot15 = FightCardInfoMO.New()

			slot15:init({
				uid = slot8.entityId,
				skillId = slot14,
				tempCard = slot8.tempCard
			})
			table.insert(slot3, slot15)
		end
	end

	return slot3
end

function slot0.checkNextRoundCardCondition(slot0, slot1)
	if string.nilorempty(slot1) then
		return true
	end

	if #string.split(slot1, "&") > 1 then
		for slot7, slot8 in ipairs(slot2) do
			if uv0.checkNextRoundCardSingleCondition(slot0, slot8) then
				slot3 = 0 + 1
			end
		end

		return slot3 == #slot2
	else
		return uv0.checkNextRoundCardSingleCondition(slot0, slot2[1])
	end
end

function slot0.checkNextRoundCardSingleCondition(slot0, slot1)
	slot4 = uv0.getEntity(slot0.belongToEntityId) and slot3:getMO()

	if string.split(slot1, "#")[1] == "1" then
		if slot5[2] and slot4 then
			slot6, slot7 = HeroConfig.instance:getShowLevel(slot4.level)

			if tonumber(slot5[2]) <= slot7 - 1 then
				return true
			end
		end
	elseif slot5[1] == "2" and slot5[2] and slot4 then
		return slot4.exSkillLevel == tonumber(slot5[2])
	end
end

function slot0.checkShieldHit(slot0)
	if slot0.effectNum1 == FightEnum.EffectType.SHAREHURT then
		return false
	end

	return true
end

slot0.SkillEditorHp = 2000

function slot0.buildMySideFightEntityMOList(slot0)
	slot1 = FightEnum.EntitySide.MySide
	slot2 = {
		[slot7] = slot8.heroId
	}
	slot3 = {
		[slot7] = slot8.skin
	}

	for slot7 = 1, SkillEditorMgr.instance.stance_count_limit do
		if HeroModel.instance:getById(slot0.mySideUids[slot7]) then
			-- Nothing
		end
	end

	slot4 = {}
	slot5 = {}

	for slot9, slot10 in ipairs(slot0.mySideSubUids) do
		if HeroModel.instance:getById(slot10) then
			table.insert(slot4, slot11.heroId)
			table.insert(slot5, slot11.skin)
		end
	end

	return uv0.buildHeroEntityMOList(slot1, slot2, slot3, slot4, slot5)
end

function slot0.getEmptyFightEntityMO(slot0, slot1, slot2, slot3)
	if not slot1 or slot1 == 0 then
		return
	end

	slot4 = lua_character.configDict[slot1]
	slot5 = FightEntityMO.New()
	slot5.id = tostring(slot0)
	slot5.uid = slot5.id
	slot5.modelId = slot1 or 0
	slot5.entityType = 1
	slot5.exPoint = 0
	slot5.side = FightEnum.EntitySide.MySide
	slot5.currentHp = 0
	slot5.attrMO = uv0._buildAttr(slot4)
	slot5.skillIds = uv0._buildHeroSkills(slot4)
	slot5.shieldValue = 0
	slot5.level = slot2 or 1
	slot5.skin = slot3 or slot4.skinId

	if not string.nilorempty(slot4.powerMax) then
		slot6 = FightStrUtil.instance:getSplitToNumberCache(slot4.powerMax, "#")

		slot5:setPowerInfos({
			{
				num = 0,
				powerId = slot6[1],
				max = slot6[2]
			}
		})
	end

	return slot5
end

function slot0.buildHeroEntityMOList(slot0, slot1, slot2, slot3, slot4)
	slot7 = {}

	for slot12 = 1, slot1 and #slot1 or SkillEditorMgr.instance.stance_count_limit do
		if slot1[slot12] and slot13 ~= 0 then
			if lua_character.configDict[slot13] then
				function (slot0, slot1)
					slot2 = FightEntityMO.New()
					slot2.id = tostring(uv0)
					slot2.uid = slot2.id
					slot2.modelId = slot0 or 0
					slot2.entityType = 1
					slot2.exPoint = 0
					slot2.side = uv1
					slot2.currentHp = uv2.SkillEditorHp
					slot2.attrMO = uv2._buildAttr(slot1)
					slot2.skillIds = uv2._buildHeroSkills(slot1)
					slot2.shieldValue = 0
					slot2.level = 1
					slot2.storedExPoint = 0

					if not string.nilorempty(slot1.powerMax) then
						slot3 = FightStrUtil.instance:getSplitToNumberCache(slot1.powerMax, "#")

						slot2:setPowerInfos({
							{
								num = 0,
								powerId = slot3[1],
								max = slot3[2]
							}
						})
					end

					uv0 = uv0 + 1

					return slot2
				end(slot13, slot14).position = slot12
				slot15.skin = slot2 and slot2[slot12] or slot14.skinId

				table.insert({}, slot15)
			else
				logError(string.format("%s%d号站位的角色配置已被删除，角色id=%d", slot0 == FightEnum.EntitySide.MySide and "我方" or "敌方", slot12, slot13))
			end
		end
	end

	if slot3 then
		for slot12, slot13 in ipairs(slot3) do
			if lua_character.configDict[slot13] then
				slot5(slot13, slot14).position = -1
				slot15.skin = slot4 and slot4[slot12] or slot14.skinId

				table.insert(slot7, slot15)
			else
				logError((slot0 == FightEnum.EntitySide.MySide and "我方" or "敌方") .. "替补角色的配置已被删除，角色id=" .. slot13)
			end
		end
	end

	return slot6, slot7
end

function slot0.buildEnemySideFightEntityMOList(slot0, slot1)
	slot4 = lua_monster_group.configDict[slot0.monsterGroupIds[slot1]]

	return uv0.buildMonsterEntityMOList(FightEnum.EntitySide.EnemySide, FightStrUtil.instance:getSplitToNumberCache(slot4.monster, "#"), slot4.subMonsters)
end

function slot0.buildMonsterEntityMOList(slot0, slot1, slot2)
	slot4 = {}

	for slot8 = 1, SkillEditorMgr.instance.enemy_stance_count_limit do
		if slot1[slot8] and slot9 ~= 0 then
			if lua_monster.configDict[slot9] then
				slot11 = FightEntityMO.New()
				slot11.id = tostring(uv0)
				slot11.uid = slot11.id
				slot11.modelId = slot9
				slot11.position = slot8
				slot11.entityType = 2
				slot11.exPoint = 0
				slot11.skin = slot10.skinId
				slot11.side = slot0
				slot11.currentHp = uv1.SkillEditorHp
				slot11.attrMO = uv1._buildAttr(slot10)
				slot11.skillIds = uv1._buildMonsterSkills(slot10)
				slot11.shieldValue = 0
				slot11.level = 1
				slot11.storedExPoint = 0
				uv0 = uv0 - 1

				table.insert({}, slot11)
			else
				logError(string.format("%s%d号站位的怪物配置已被删除，怪物id=%d", slot0 == FightEnum.EntitySide.MySide and "我方" or "敌方", slot8, slot9))
			end
		end
	end

	if slot2 then
		for slot8, slot9 in ipairs(slot2) do
			if lua_monster.configDict[slot9] then
				slot11 = FightEntityMO.New()
				slot11.id = tostring(uv0)
				slot11.uid = slot11.id
				slot11.modelId = slot9
				slot11.position = 5
				slot11.entityType = 2
				slot11.exPoint = 0
				slot11.skin = slot10.skinId
				slot11.side = slot0
				slot11.currentHp = uv1.SkillEditorHp
				slot11.attrMO = uv1._buildAttr(slot10)
				slot11.skillIds = uv1._buildMonsterSkills(slot10)
				slot11.shieldValue = 0
				slot11.level = 1
				uv0 = uv0 - 1

				table.insert(slot4, slot11)
			else
				logError((slot0 == FightEnum.EntitySide.MySide and "我方" or "敌方") .. "替补怪物的配置已被删除，怪物id=" .. slot9)
			end
		end
	end

	return slot3, slot4
end

function slot0.buildSkills(slot0)
	if lua_character.configDict[slot0] then
		return uv0._buildHeroSkills(slot1)
	end

	if lua_monster.configDict[slot0] then
		return uv0._buildMonsterSkills(slot2)
	end
end

function slot0._buildHeroSkills(slot0)
	slot1 = {}

	if lua_character.configDict[slot0.id] then
		for slot7, slot8 in pairs(GameUtil.splitString2(slot2.skill, true)) do
			for slot12 = 2, #slot8 do
				if slot8[slot12] ~= 0 then
					table.insert(slot1, slot8[slot12])
				else
					logError(slot0.id .. " 角色技能id=0，检查下角色表-角色")
				end
			end
		end
	end

	if slot2.exSkill ~= 0 then
		table.insert(slot1, slot2.exSkill)
	end

	if lua_skill_ex_level.configDict[slot0.id] then
		for slot7, slot8 in pairs(slot3) do
			if slot8.skillEx ~= 0 then
				table.insert(slot1, slot8.skillEx)
			end
		end
	end

	if lua_skill_passive_level.configDict[slot0.id] then
		for slot8, slot9 in pairs(slot4) do
			if slot9.skillPassive ~= 0 then
				table.insert(slot1, slot9.skillPassive)
			else
				logError(slot0.id .. " 角色被动技能id=0，检查下角色养成表-被动升级")
			end
		end
	end

	return slot1
end

function slot0._buildMonsterSkills(slot0)
	slot1 = {}

	if not string.nilorempty(slot0.activeSkill) then
		slot6 = "|"
		slot7 = "#"

		for slot6, slot7 in ipairs(FightStrUtil.instance:getSplitString2Cache(slot0.activeSkill, true, slot6, slot7)) do
			for slot11, slot12 in ipairs(slot7) do
				if lua_skill.configDict[slot12] then
					table.insert(slot1, slot12)
				end
			end
		end
	end

	if slot0.uniqueSkill and #slot0.uniqueSkill > 0 then
		for slot5, slot6 in ipairs(slot0.uniqueSkill) do
			table.insert(slot1, slot6)
		end
	end

	tabletool.addValues(slot1, FightConfig.instance:getPassiveSkills(slot0.id))

	return slot1
end

function slot0._buildAttr(slot0)
	slot1 = HeroAttributeMO.New()
	slot1.hp = uv0.SkillEditorHp
	slot1.attack = 100
	slot1.defense = 100
	slot1.crit = 100
	slot1.crit_damage = 100
	slot1.multiHpNum = 0
	slot1.multiHpIdx = 0

	return slot1
end

function slot0.buildTestCard()
	FightCardModel.instance:updateCard({
		cardGroup = {
			300201,
			300301,
			300401,
			300501,
			300401,
			300301,
			300201,
			300501
		},
		actPoint = 4,
		moveNum = 20
	})
end

function slot0.getEpisodeRecommendLevel(slot0, slot1)
	if not DungeonConfig.instance:getEpisodeBattleId(slot0) then
		return 0
	end

	return uv0.getBattleRecommendLevel(slot2, slot1)
end

function slot0.getBattleRecommendLevel(slot0, slot1)
	slot2 = slot1 and "levelEasy" or "level"

	if not lua_battle.configDict[slot0] then
		return 0
	end

	slot4 = {}
	slot5 = {}
	slot6, slot7 = nil
	slot11 = slot3.monsterGroupIds
	slot12 = "#"

	for slot11, slot12 in ipairs(FightStrUtil.instance:getSplitToNumberCache(slot11, slot12)) do
		slot16 = "#"

		for slot16, slot17 in ipairs(FightStrUtil.instance:getSplitToNumberCache(lua_monster_group.configDict[slot12].monster, slot16)) do
			if uv0.isBossId(lua_monster_group.configDict[slot12].bossId, slot17) then
				table.insert(slot5, slot17)
			else
				table.insert(slot4, slot17)
			end
		end
	end

	if #slot5 > 0 then
		return lua_monster.configDict[slot5[1]][slot2]
	elseif #slot4 > 0 then
		for slot12, slot13 in ipairs(slot4) do
			slot8 = 0 + lua_monster.configDict[slot13][slot2]
		end

		return math.ceil(slot8 / #slot4)
	else
		return 0
	end
end

function slot0.initBuildSceneAndLevelHandle()
	if uv0.buildSceneAndLevelHandleDict then
		return
	end

	uv0.buildSceneAndLevelHandleDict = {
		[DungeonEnum.EpisodeType.Cachot] = uv0.buildCachotSceneAndLevel,
		[DungeonEnum.EpisodeType.Rouge] = uv0.buildRougeSceneAndLevel
	}
end

function slot0.buildDefaultSceneAndLevel(slot0, slot1)
	slot2 = {}
	slot3 = {}

	for slot10, slot11 in ipairs(string.splitToNumber(lua_battle.configDict[slot1].sceneIds, "#")) do
		table.insert(slot2, slot11)
		table.insert(slot3, SceneConfig.instance:getSceneLevelCOs(slot11)[1].id)
	end

	return slot2, slot3
end

function slot0.buildCachotSceneAndLevel(slot0, slot1)
	slot2 = 0

	if V1a6_CachotRoomModel.instance:getNowBattleEventMo() and lua_rogue_event_fight.configDict[slot3:getEventCo().eventId].isChangeScene ~= 1 then
		slot2 = V1a6_CachotModel.instance:getRogueInfo().layer
	end

	if slot2 > 0 then
		if V1a6_CachotEventConfig.instance:getSceneIdByLayer(slot2) then
			slot5 = {}
			slot6 = {}

			table.insert(slot5, slot4.sceneId)
			table.insert(slot6, slot4.levelId)

			return slot5, slot6
		else
			logError("肉鸽战斗场景配置不存在" .. slot2)

			return uv0.buildDefaultSceneAndLevel(slot0, slot1)
		end
	else
		return uv0.buildDefaultSceneAndLevel(slot0, slot1)
	end
end

function slot0.buildRougeSceneAndLevel(slot0, slot1)
	slot4 = RougeMapHelper.isFightEvent(RougeMapModel.instance:getCurEvent() and slot2.type) and lua_rouge_fight_event.configDict[slot2.id]

	if slot4 and slot4.isChangeScene == 1 then
		slot8 = slot6 and slot6.levelId

		if (RougeMapModel.instance:getLayerCo() and slot6.sceneId) ~= 0 and slot8 ~= 0 then
			return {
				slot7
			}, {
				slot8
			}
		end

		logError(string.format("layerId : %s, config Incorrect, sceneId : %s, levelId : %s", slot6 and slot6.id, slot7, slot8))

		return uv0.buildDefaultSceneAndLevel(slot0, slot1)
	else
		return uv0.buildDefaultSceneAndLevel(slot0, slot1)
	end
end

function slot0.buildSceneAndLevel(slot0, slot1)
	uv0.initBuildSceneAndLevelHandle()

	return lua_episode.configDict[slot0] and uv0.buildSceneAndLevelHandleDict[slot2.type] or uv0.buildDefaultSceneAndLevel(slot0, slot1)
end

function slot0.getStressStatus(slot0)
	if not slot0 then
		logError("stress is nil")

		return FightEnum.Status.Positive
	end

	for slot4 = 1, 2 do
		if slot0 <= FightEnum.StressThreshold[slot4] then
			return slot4
		end
	end

	return nil
end

function slot0.getResistanceKeyById(slot0)
	if not uv0.resistanceId2KeyDict then
		uv0.resistanceId2KeyDict = {}

		for slot4, slot5 in pairs(FightEnum.Resistance) do
			uv0.resistanceId2KeyDict[slot5] = slot4
		end
	end

	return uv0.resistanceId2KeyDict[slot0]
end

function slot0.canAddPoint(slot0)
	if not slot0 then
		return false
	end

	if slot0:hasBuffFeature(FightEnum.BuffType_TransferAddExPoint) then
		return false
	end

	if slot0:hasBuffFeature(FightEnum.ExPointCantAdd) then
		return false
	end

	return true
end

function slot0.getEntityName(slot0)
	slot1 = slot0 and slot0:getMO()

	return tostring(slot1 and slot1:getEntityName())
end

function slot0.getEntityById(slot0)
	return uv0.getEntityName(uv0.getEntity(slot0))
end

function slot0.isSameCardMo(slot0, slot1)
	if slot0 == slot1 then
		return true
	end

	if not slot0 or not slot1 then
		return false
	end

	return slot0.custom_enemyCardIndex == slot1.custom_enemyCardIndex
end

function slot0.getAssitHeroInfoByUid(slot0, slot1)
	if FightDataHelper.entityMgr:getById(slot0) and slot2:isCharacter() then
		return {
			skin = slot2.skin,
			level = slot2.level,
			config = HeroConfig.instance:getHeroCO(slot2.modelId)
		}
	end
end

function slot0.canSelectEnemyEntity(slot0)
	if not slot0 then
		return false
	end

	if not FightDataHelper.entityMgr:getById(slot0) then
		return false
	end

	if slot1.side == FightEnum.EntitySide.MySide then
		return false
	end

	if slot1:hasBuffFeature(FightEnum.BuffType_CantSelect) then
		return false
	end

	if slot1:hasBuffFeature(FightEnum.BuffType_CantSelectEx) then
		return false
	end

	return true
end

function slot0.clearNoUseEffect()
	for slot4, slot5 in pairs(FightEffectPool.releaseUnuseEffect()) do
		FightPreloadController.instance:releaseAsset(slot4)
	end

	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC)
end

function slot0.isASFDSkill(slot0)
	return slot0 == FightASFDConfig.instance.skillId
end

function slot0.getASFDMgr()
	slot1 = GameSceneMgr.instance:getCurScene() and slot0.mgr

	return slot1 and slot1:getASFDMgr()
end

function slot0.getEntityCareer(slot0)
	slot1 = slot0 and FightDataHelper.entityMgr:getById(slot0)

	return slot1 and slot1:getCareer() or 0
end

function slot0.isRestrain(slot0, slot1)
	return (FightConfig.instance:getRestrain(uv0.getEntityCareer(slot0), uv0.getEntityCareer(slot1)) or 1000) > 1000
end

slot0.tempEntityMoList = {}

function slot0.hasSkinId(slot0)
	slot1 = uv0.tempEntityMoList

	tabletool.clear(slot1)

	for slot6, slot7 in ipairs(FightDataHelper.entityMgr:getMyNormalList(slot1)) do
		if slot7.originSkin == slot0 then
			return true
		end
	end

	return false
end

return slot0
