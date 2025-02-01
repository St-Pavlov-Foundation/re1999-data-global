module("modules.logic.fight.model.mo.FightEntityMO", package.seeall)

slot0 = pureTable("FightEntityMO")

if SLFramework.FrameworkSettings.IsEditor then
	function slot0.__newindex(slot0, slot1, slot2)
		if type(slot2) == "userdata" or type(slot2) == "function" then
			error("pureTable instance object field not support userdata or function,key=" .. slot1)
		else
			if type(slot2) == "table" and slot2._cached_byte_size then
				logError("entityMO不可以直接引用protobuf数据,请构建一个数据")
			end

			rawset(slot0, slot1, slot2)
		end
	end
end

slot1 = -9999

function slot0.ctor(slot0)
	slot0.buffModel = BaseModel.New()
	slot0.playCardExPoint = 0
	slot0.moveCardExPoint = 0
	slot0._afterUniqueMoveCount = uv0
	slot0._afterUniqueCombineCount = uv0
	slot0.skillList = {}
	slot0.skillId2Lv = {}
	slot0.skillNextLvId = {}
	slot0.skillPrevLvId = {}
	slot0.skillGroup1 = {}
	slot0.skillGroup2 = {}
end

function slot0.setIsOnlyData(slot0)
	slot0.isOnlyData = true
end

function slot0.init(slot0, slot1, slot2)
	slot0._playCardAddExpoint = 1
	slot0._moveCardAddExpoint = 1
	slot0._combineCardAddExpoint = 1
	slot0.expointMaxAdd = slot1.expointMaxAdd
	slot0.exSkillPointChange = slot1.exSkillPointChange or 0
	slot0.id = slot1.uid
	slot0.uid = slot1.uid
	slot0.modelId = slot1.modelId
	slot0.skin = FightHelper.processEntitySkin(slot1.skin, slot1.uid)
	slot0.originSkin = slot0.skin
	slot0.position = slot1.position
	slot0.entityType = slot1.entityType
	slot0.userId = slot1.userId

	slot0:setExPoint(slot1.exPoint)

	slot0.level = slot1.level
	slot0.currentHp = slot1.currentHp
	slot0.attrMO = slot0:_buildAttr(slot1.attr)

	slot0:_buildBuffs(slot1.buffs)
	slot0:_buildSkills(slot1)

	slot0.shieldValue = slot1.shieldValue
	slot0.equipUid = slot1.equipUid
	slot0.trialId = slot1.trialId

	if slot1.trialEquip then
		slot0.trialEquip = {
			equipUid = slot1.trialEquip.equipUid,
			equipId = slot1.trialEquip.equipId,
			equipLv = slot1.trialEquip.equipLv,
			refineLv = slot1.trialEquip.refineLv
		}
	else
		slot0.trialEquip = nil
	end

	slot0.exSkillLevel = slot1.exSkillLevel

	if FightModel.instance:getVersion() >= 1 then
		slot0.side = slot1.teamType == FightEnum.TeamType.MySide and FightEnum.EntitySide.MySide or FightEnum.EntitySide.EnemySide
	else
		slot0.side = slot2
	end

	slot0:setPowerInfos(slot1.powerInfos)
	slot0:buildSummonedInfo(slot1.SummonedList)

	slot0.teamType = slot1.teamType

	slot0:buildEnhanceInfoBox(slot1.enhanceInfoBox)

	slot0.career = slot1.career

	slot0:updateStoredExPoint()

	slot0.guard = slot1.guard
	slot0.subCd = slot1.subCd
end

function slot0._buildAttr(slot0, slot1)
	slot2 = slot0.attrMO or HeroAttributeMO.New()

	slot2:init(slot1)

	return slot2
end

function slot0._buildBuffs(slot0, slot1)
	slot2 = slot0.buffModel:getList()
	slot3 = {}

	tabletool.addValues(slot3, slot1)

	for slot7, slot8 in ipairs(slot3) do
		if not slot2[slot7] then
			table.insert(slot2, FightBuffMO.New())
		end

		slot9:init(slot8, slot0.id)
	end

	for slot7 = #slot2, #slot3 + 1, -1 do
		slot2[slot7] = nil
	end

	slot0.buffModel:setList(slot2)
	slot0:_dealBuffFeature()
end

function slot0.getBuffList(slot0)
	return slot0.buffModel:getList()
end

function slot0._buildSkills(slot0, slot1)
	slot0.skillList = {}
	slot0.skillId2Lv = {}
	slot0.skillNextLvId = {}
	slot0.skillPrevLvId = {}
	slot0.passiveSkillDic = {}
	slot0.skillGroup1 = {}
	slot0.skillGroup2 = {}

	for slot5, slot6 in ipairs(slot1.skillGroup1) do
		table.insert(slot0.skillList, slot6)
		table.insert(slot0.skillGroup1, slot6)

		slot0.skillId2Lv[slot6] = slot5
		slot0.skillNextLvId[slot6] = slot1.skillGroup1[slot5 + 1]
		slot0.skillPrevLvId[slot6] = slot1.skillGroup1[slot5 - 1]
	end

	for slot5, slot6 in ipairs(slot1.skillGroup2) do
		table.insert(slot0.skillList, slot6)
		table.insert(slot0.skillGroup2, slot6)

		slot0.skillId2Lv[slot6] = slot5
		slot0.skillNextLvId[slot6] = slot1.skillGroup2[slot5 + 1]
		slot0.skillPrevLvId[slot6] = slot1.skillGroup2[slot5 - 1]
	end

	for slot5, slot6 in ipairs(slot1.passiveSkill) do
		table.insert(slot0.skillList, slot6)

		slot0.passiveSkillDic[slot6] = true
	end

	table.insert(slot0.skillList, slot1.exSkill)

	slot0.skillId2Lv[slot1.exSkill] = 4
	slot0.exSkill = slot1.exSkill
end

function slot0.addPassiveSkill(slot0, slot1)
	if slot0.passiveSkillDic then
		slot0.passiveSkillDic[slot1] = true
	end

	if slot0.skillList and not tabletool.indexOf(slot0.skillList, slot1) then
		table.insert(slot0.skillList, slot1)
	end
end

function slot0.removePassiveSkill(slot0, slot1)
	if slot0.passiveSkillDic then
		slot0.passiveSkillDic[slot1] = nil
	end

	if slot0.skillList then
		tabletool.removeValue(slot0.skillList, slot1)
	end
end

function slot0.isPassiveSkill(slot0, slot1)
	return slot0.passiveSkillDic and slot0.passiveSkillDic[slot1]
end

function slot0.hasSkill(slot0, slot1)
	return slot0.skillId2Lv[slot1] ~= nil
end

function slot0.getSkillLv(slot0, slot1)
	return slot0.skillId2Lv[slot1] or FightConfig.instance:getSkillLv(slot1)
end

function slot0.getSkillNextLvId(slot0, slot1)
	return slot0.skillNextLvId[slot1] or FightHelper.processNextSkillId(slot1) or FightConfig.instance:getSkillNextLvId(slot1)
end

function slot0.getSkillPrevLvId(slot0, slot1)
	return slot0.skillPrevLvId[slot1] or FightConfig.instance:getSkillPrevLvId(slot1)
end

function slot0.isUniqueSkill(slot0, slot1)
	return slot0.skillId2Lv[slot1] == FightEnum.UniqueSkillCardLv or FightConfig.instance:isUniqueSkill(slot1)
end

function slot0.isActiveSkill(slot0, slot1)
	return slot0.skillId2Lv[slot1] ~= nil or FightConfig.instance:isActiveSkill(slot1)
end

function slot0.addBuff(slot0, slot1)
	if not slot0.buffModel:getById(slot1.uid) then
		slot2 = FightBuffMO.New()

		slot2:init(slot1, slot0.id)
		slot0.buffModel:addAtLast(slot2)
		slot0:_dealBuffFeature()

		return true
	else
		return false
	end
end

function slot0.delBuff(slot0, slot1)
	if slot1 then
		slot0.buffModel:remove(slot1)
		slot0:_dealBuffFeature()
	end
end

function slot0.updateBuff(slot0, slot1)
	if slot0.buffModel:getById(slot1.uid) then
		slot2:init(slot1, slot0.id)
	else
		logNormal(string.format("%s: BuffError not exist, update fail, buff.uid = %s buffId = %d", slot0:getEntityName(), slot1.uid, slot1.buffId))
	end
end

function slot0.getBuffMO(slot0, slot1)
	return slot0.buffModel:getById(slot1)
end

function slot0.getEntityName(slot0)
	return slot0:getCO() and slot1.name or "nil"
end

function slot0.getIdName(slot0)
	return string.format("%s_%d", slot0.side == FightEnum.EntitySide.MySide and FightEnum.EntityGOName.MySide or FightEnum.EntityGOName.EnemySide, slot0.position)
end

function slot0.getCO(slot0)
	if slot0:isCharacter() then
		return lua_character.configDict[slot0.modelId]
	elseif slot0:isMonster() then
		return lua_monster.configDict[slot0.modelId]
	end

	logError("实体配置表找不到,实体类型:" .. slot0.entityType .. "  modelId:" .. slot0.modelId)

	return lua_character.configDict[slot0.modelId] or lua_monster.configDict[slot0.modelId]
end

function slot0.isCharacter(slot0)
	return slot0.entityType == 1
end

function slot0.isMonster(slot0)
	return slot0.entityType == 2 or slot0.entityType == 3
end

function slot0.getSpineSkinCO(slot0)
	slot1 = slot0.skin or lua_character.configDict[slot0.modelId] and slot2.skinId or lua_monster.configDict[slot0.modelId] and slot2.skinId

	if FightConfig.instance:getSkinCO(slot0.skin) then
		return slot2
	else
		logError("skin not exist: " .. slot0.skin .. " modelId: " .. slot0.modelId)
	end
end

function slot0.resetSimulateExPoint(slot0)
	slot0.playCardExPoint = 0
	slot0.moveCardExPoint = 0
	slot0._afterUniqueMoveCount = uv0
	slot0._afterUniqueCombineCount = uv0
end

function slot0.applyMoveCardExPoint(slot0)
	slot0.moveCardExPoint = 0
	slot0.playCardExPoint = 0
end

function slot0.getExPoint(slot0)
	return slot0.exPoint
end

function slot0.setExPoint(slot0, slot1)
	slot0.exPoint = slot1
end

function slot0.changeExpointMaxAdd(slot0, slot1)
	slot0.expointMaxAdd = slot0.expointMaxAdd or 0
	slot0.expointMaxAdd = slot0.expointMaxAdd + slot1
end

function slot0.getMaxExPoint(slot0)
	return slot0:getCO().uniqueSkill_point + slot0:getExpointMaxAddNum()
end

function slot0.getExpointMaxAddNum(slot0)
	return slot0.expointMaxAdd or 0
end

function slot0.changeServerUniqueCost(slot0, slot1)
	slot0.exSkillPointChange = slot0:getExpointCostOffsetNum() + slot1
end

function slot0.getUniqueSkillPoint(slot0)
	for slot5, slot6 in ipairs(slot0.buffModel:getList()) do
		if slot0:getFeaturesSplitInfoByBuffId(slot6.buffId) then
			for slot12, slot13 in ipairs(slot8) do
				if slot13[1] == FightEnum.BuffActId.ExSkillNoConsumption then
					return 0
				end
			end
		end
	end

	return slot0:getCO().uniqueSkill_point + slot0:getExpointCostOffsetNum()
end

function slot0.getExpointCostOffsetNum(slot0)
	return slot0.exSkillPointChange or 0
end

function slot0.getPreviewExPoint(slot0)
	return slot0.exPoint + slot0.moveCardExPoint + slot0.playCardExPoint - FightHelper.getPredeductionExpoint(slot0.id)
end

function slot0.onPlayCardExPoint(slot0, slot1)
	if not slot0:isUniqueSkill(slot1) then
		if slot0:getPreviewExPoint() < slot0:getMaxExPoint() then
			slot0.playCardExPoint = slot0.playCardExPoint + slot0._playCardAddExpoint

			if slot2 < slot0:getPreviewExPoint() then
				slot0.playCardExPoint = slot0.playCardExPoint - (slot0:getPreviewExPoint() - slot2)
			end
		end
	else
		slot0._afterUniqueMoveCount = 0
		slot0._afterUniqueCombineCount = 0
	end
end

function slot0.onMoveCardExPoint(slot0, slot1)
	if slot0:getPreviewExPoint() < slot0:getMaxExPoint() then
		slot0.moveCardExPoint = slot0.moveCardExPoint + (slot1 and slot0._moveCardAddExpoint or slot0._combineCardAddExpoint)

		if slot3 < slot0:getPreviewExPoint() then
			slot0.moveCardExPoint = slot0.moveCardExPoint - (slot0:getPreviewExPoint() - slot3)
		end
	end

	if slot1 and slot0._afterUniqueMoveCount ~= uv0 then
		slot0._afterUniqueMoveCount = slot0._afterUniqueMoveCount + 1
	end

	if not slot1 and slot0._afterUniqueCombineCount ~= uv0 then
		slot0._afterUniqueCombineCount = slot0._afterUniqueCombineCount + 1
	end
end

function slot0._dealBuffFeature(slot0)
	slot0._playCardAddExpoint = 1
	slot0._moveCardAddExpoint = 1
	slot0._combineCardAddExpoint = 1

	for slot5, slot6 in ipairs(slot0.buffModel:getList()) do
		if slot0:getFeaturesSplitInfoByBuffId(slot6.buffId) then
			for slot12, slot13 in ipairs(slot8) do
				if slot13[1] == 606 then
					slot0._combineCardAddExpoint = slot0._combineCardAddExpoint + slot13[2]
				elseif slot13[1] == 607 then
					slot0._moveCardAddExpoint = slot0._moveCardAddExpoint + slot13[2]
				elseif slot13[1] == 603 then
					slot0._playCardAddExpoint = 0
					slot0._combineCardAddExpoint = 0
					slot0._moveCardAddExpoint = 0

					return
				end
			end
		end
	end
end

function slot0.getFeaturesSplitInfoByBuffId(slot0, slot1)
	if not slot0.buffFeaturesSplit then
		slot0.buffFeaturesSplit = {}
	end

	if not slot0.buffFeaturesSplit[slot1] and not string.nilorempty(lua_skill_buff.configDict[slot1] and slot2.features) then
		slot0.buffFeaturesSplit[slot1] = FightStrUtil.instance:getSplitString2Cache(slot3, true)
	end

	return slot0.buffFeaturesSplit[slot1]
end

function slot0.hasBuffFeature(slot0, slot1)
	for slot6, slot7 in ipairs(slot0.buffModel:getList()) do
		if slot0:getFeaturesSplitInfoByBuffId(slot7.buffId) then
			for slot13, slot14 in ipairs(slot9) do
				if lua_buff_act.configDict[slot14[1]] and slot15.type == slot1 then
					return true
				end
			end
		end
	end
end

function slot0.setHp(slot0, slot1)
	if slot1 < 0 then
		slot1 = 0
	end

	if slot0.attrMO.hp < slot1 then
		slot1 = slot0.attrMO.hp
	end

	slot0.currentHp = slot1
end

function slot0.setShield(slot0, slot1)
	slot0.shieldValue = slot1
end

function slot0.onChangeHero(slot0)
	slot0.buffModel:clear()
	slot0:_dealBuffFeature()
	slot0:setShield(0)
end

function slot0.setPowerInfos(slot0, slot1)
	slot0._powerInfos = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = slot0._powerInfos[slot6.powerId] or {}
		slot7.powerId = slot6.powerId
		slot7.num = slot6.num
		slot7.max = slot6.max
		slot0._powerInfos[slot6.powerId] = slot7
	end
end

function slot0.getPowerInfos(slot0)
	return slot0._powerInfos or {}
end

function slot0.getPowerInfo(slot0, slot1)
	return slot0._powerInfos and slot0._powerInfos[slot1]
end

function slot0.hasStress(slot0)
	slot1 = slot0._powerInfos and slot0._powerInfos[FightEnum.PowerType.Stress]

	return slot1 and slot1.max > 0
end

function slot0.changePowerMax(slot0, slot1, slot2)
	if slot0._powerInfos and slot0._powerInfos[slot1] then
		slot0._powerInfos[slot1].max = slot0._powerInfos[slot1].max + slot2
	end
end

function slot0.buildSummonedInfo(slot0, slot1)
	slot0.summonedInfo = slot0.summonedInfo or FightEntitySummonedInfo.New()

	slot0.summonedInfo:init(slot1)

	return slot0.summonedInfo
end

function slot0.getSummonedInfo(slot0)
	slot0.summonedInfo = slot0.summonedInfo or FightEntitySummonedInfo.New()

	return slot0.summonedInfo
end

function slot0.buildEnhanceInfoBox(slot0, slot1)
	slot0.canUpgradeIds = {}
	slot0.upgradedOptions = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1.canUpgradeIds) do
			slot0.canUpgradeIds[slot6] = slot6
		end

		for slot5, slot6 in ipairs(slot1.upgradedOptions) do
			slot0.upgradedOptions[slot6] = slot6
		end
	end
end

function slot0.getTrialAttrCo(slot0)
	if not slot0.trialId or slot0.trialId <= 0 then
		return
	end

	if not lua_hero_trial.configDict[slot0.trialId][0] then
		return
	end

	if slot1.attrId <= 0 then
		return
	end

	return lua_hero_trial_attr.configDict[slot1.attrId]
end

function slot0.updateStoredExPoint(slot0)
	slot0.storedExPoint = 0

	for slot4, slot5 in ipairs(slot0:getBuffList()) do
		if not string.nilorempty(slot5.actCommonParams) and (lua_buff_act.configDict[FightStrUtil.instance:getSplitToNumberCache(slot6, "#")[1]] and slot9.type) == FightEnum.BuffType_ExPointOverflowBank then
			slot0.storedExPoint = slot0.storedExPoint + slot7[2]
		end
	end
end

function slot0.setStoredExPoint(slot0, slot1)
	slot2 = slot0.storedExPoint
	slot0.storedExPoint = slot1

	if slot0.isOnlyData then
		return
	end

	FightController.instance:dispatchEvent(FightEvent.OnStoreExPointChange, slot0.id, slot2)
end

function slot0.changeStoredExPoint(slot0, slot1)
	slot2 = slot0.storedExPoint
	slot0.storedExPoint = slot0.storedExPoint + slot1

	if slot0.isOnlyData then
		return
	end

	FightController.instance:dispatchEvent(FightEvent.OnStoreExPointChange, slot0.id, slot2)
end

function slot0.getStoredExPoint(slot0)
	return slot0.storedExPoint
end

function slot0.hadStoredExPoint(slot0)
	return slot0.storedExPoint > 0
end

function slot0.getResistanceDict(slot0)
	slot0.resistanceDict = slot0.resistanceDict or {}

	tabletool.clear(slot0.resistanceDict)

	if FightModel.instance:getSpAttributeMo(slot0.uid) then
		for slot5, slot6 in pairs(FightEnum.ResistanceKeyToSpAttributeMoField) do
			if slot1[slot6] and slot7 > 0 then
				slot0.resistanceDict[slot5] = slot7
			end
		end
	end

	return slot0.resistanceDict
end

function slot0.isFullResistance(slot0, slot1)
	if not FightModel.instance:getSpAttributeMo(slot0.uid) then
		return false
	end

	if not slot2[slot1] then
		logError(string.format("%s 不存在 %s 的sp attr", slot0:getEntityName(), slot1))

		return false
	end

	return slot3 >= 1000
end

function slot0.setNotifyBindContract(slot0)
	slot0.notifyBindContract = true
end

function slot0.clearNotifyBindContract(slot0)
	slot0.notifyBindContract = nil
end

return slot0
