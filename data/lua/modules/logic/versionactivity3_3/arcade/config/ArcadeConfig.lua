-- chunkname: @modules/logic/versionactivity3_3/arcade/config/ArcadeConfig.lua

module("modules.logic.versionactivity3_3.arcade.config.ArcadeConfig", package.seeall)

local ArcadeConfig = class("ArcadeConfig", BaseConfig)

function ArcadeConfig:reqConfigNames()
	return {
		"arcade_const",
		"arcade_attribute",
		"arcade_grade",
		"arcade_reward",
		"arcade_talent",
		"arcade_talent_icon",
		"arcade_difficulty",
		"arcade_space",
		"arcade_room",
		"arcade_interactive_unit",
		"arcade_event_option",
		"arcade_collection",
		"arcade_drop",
		"arcade_character",
		"arcade_monster_group",
		"arcade_monster",
		"arcade_bomb",
		"arcade_floor",
		"arcade_active_skill",
		"arcade_passive_skill",
		"arcade_buff",
		"arcade_skill_target",
		"arcade_effects",
		"arcade_action_show",
		"arcade_state_show",
		"arcade_talk",
		"arcade_talk_step"
	}
end

function ArcadeConfig:onInit()
	return
end

function ArcadeConfig:onConfigLoaded(configName, configTable)
	local funcName = string.format("%sConfigLoaded", configName)
	local configLoadedFunc = self[funcName]

	if configLoadedFunc then
		configLoadedFunc(self, configTable)
	end
end

function ArcadeConfig:getArcadeConstCfg(constId, nilError)
	local cfg = lua_arcade_const.configDict[constId]

	if not cfg and nilError then
		logError(string.format("ArcadeConfig:getArcadeConstCfg error, cfg is nil, constId:%s", constId))
	end

	return cfg
end

function ArcadeConfig:getArcadeConst(constId, isToNumber, delimiter)
	local result
	local cfg = self:getArcadeConstCfg(constId, true)

	if cfg then
		result = cfg.value

		if not string.nilorempty(delimiter) then
			if isToNumber then
				result = string.splitToNumber(result, delimiter)
			else
				result = string.split(result, delimiter)
			end
		elseif isToNumber then
			result = tonumber(result)
		end
	end

	return result
end

function ArcadeConfig:getHpColorImgIndex(index)
	if not self._hpColorList then
		self._hpColorList = self:getArcadeConst(ArcadeEnum.ConstId.HpColorList, false, "#")
	end

	index = index % #self._hpColorList + 1

	return self._hpColorList[index]
end

function ArcadeConfig:getArcadeGameStartPos()
	if not self._gameStartX or not self._gameStartY then
		local startPos = self:getArcadeConst(ArcadeEnum.ConstId.GameGridStartPos, true, "#")

		self._gameStartX = startPos[1] or 0
		self._gameStartY = startPos[2] or 0
	end

	return self._gameStartX, self._gameStartY
end

function ArcadeConfig:getArcadeGameGridSize()
	if not self._gameGridSize then
		self._gameGridSize = self:getArcadeConst(ArcadeEnum.ConstId.GameGridSize, true) or 0
	end

	return self._gameGridSize
end

function ArcadeConfig:getArcadeGameUIGridSize()
	if not self._gameUIGridSize then
		self._gameUIGridSize = self:getArcadeConst(ArcadeEnum.ConstId.GameUIGridSize, true) or 0
	end

	return self._gameUIGridSize
end

function ArcadeConfig:getArcadeGradeCfg(score, nilError)
	local result

	if score then
		for _, cfg in ipairs(lua_arcade_grade.configList) do
			local needScore = cfg.needScore
			local findScore = result and result.needScore

			if needScore <= score and (not findScore or findScore < needScore) then
				result = cfg
			end
		end
	end

	if not result and nilError then
		logError(string.format("ArcadeConfig:getArcadeGradeCfg error, cfg is nil, score:%s", score))
	end

	return result
end

function ArcadeConfig:getArcadeGradeLevel(score)
	local cfg = self:getArcadeGradeCfg(score)

	return cfg and cfg.needScore
end

function ArcadeConfig:getArcadeGradeIcon(score)
	local cfg = self:getArcadeGradeCfg(score)

	return cfg and cfg.icon
end

function ArcadeConfig:getCurGradeNeedScore(score)
	local cfg = self:getArcadeGradeCfg(score)

	return cfg and cfg.needScore
end

function ArcadeConfig:getNextGradeNeedScore(score)
	local findScore

	if score then
		for _, cfg in ipairs(lua_arcade_grade.configList) do
			local needScore = cfg.needScore

			if score < needScore and (not findScore or needScore < findScore) then
				findScore = needScore
			end
		end

		findScore = findScore or self:getAttributeMax(ArcadeGameEnum.CharacterResource.Score)
	end

	return findScore
end

function ArcadeConfig:getGradeAddCoinRate(score)
	local cfg = self:getArcadeGradeCfg(score)

	return cfg and cfg.gainRateAdd or 0
end

function ArcadeConfig:getAttributeCfg(attrId, nilError)
	local cfg = lua_arcade_attribute.configDict[attrId]

	if not cfg and nilError then
		logError(string.format("ArcadeConfig:getAttributeCfg error, cfg is nil, attrId:%s", attrId))
	end

	return cfg
end

function ArcadeConfig:getAttributeMin(attrId)
	local cfg = self:getAttributeCfg(attrId, true)

	return cfg and cfg.min or 0
end

function ArcadeConfig:getAttributeMax(attrId)
	local cfg = self:getAttributeCfg(attrId, true)

	return cfg and cfg.max or 0
end

function ArcadeConfig:getAttributeInitVal(attrId)
	local cfg = self:getAttributeCfg(attrId, true)

	return cfg and cfg.initVal or 0
end

function ArcadeConfig:getAttributeIcon(attrId)
	local cfg = self:getAttributeCfg(attrId, true)

	return cfg and cfg.icon
end

function ArcadeConfig:getAttributeName(attrId)
	local cfg = self:getAttributeCfg(attrId, true)

	return cfg and cfg.name
end

function ArcadeConfig:getDifficultyCfg(difficulty, nilError)
	local cfg = lua_arcade_difficulty.configDict[difficulty]

	if not cfg and nilError then
		logError(string.format("ArcadeConfig:getDifficultyCfg error, cfg is nil, difficulty:%s", difficulty))
	end

	return cfg
end

function ArcadeConfig:getDifficultyAreaList(difficulty)
	local result = {}
	local cfg = self:getDifficultyCfg(difficulty, true)

	if cfg then
		result = string.splitToNumber(cfg.scope, "#")
	end

	return result
end

function ArcadeConfig:getDifficultyAreaIdByIndex(difficulty, areaIndex)
	local areaList = self:getDifficultyAreaList(difficulty)

	return areaList[areaIndex]
end

function ArcadeConfig:getCharacterTurnTime(difficulty)
	local cfg = self:getDifficultyCfg(difficulty, true)
	local millisecondTime = cfg and cfg.characterTurnTime or ArcadeGameEnum.Const.DefaultCharacterTurnTime

	return millisecondTime / TimeUtil.OneSecondMilliSecond
end

function ArcadeConfig:getDifficultyAddSkill(difficulty)
	local cfg = self:getDifficultyCfg(difficulty, true)

	return cfg and cfg.addSkill
end

function ArcadeConfig:getAreaCfg(areaId, nilError)
	local cfg = lua_arcade_space.configDict[areaId]

	if not cfg and nilError then
		logError(string.format("ArcadeConfig:getAreaCfg error, cfg is nil, areaId:%s", areaId))
	end

	return cfg
end

function ArcadeConfig:getAreaFirstRoom(areaId)
	local cfg = self:getAreaCfg(areaId, true)

	return cfg and cfg.firstRoom
end

function ArcadeConfig:getAreaNodeCount(areaId)
	local cfg = self:getAreaCfg(areaId, true)

	return cfg and cfg.node or 0
end

function ArcadeConfig:getPortalList(areaId, nodeIndex)
	local result = {}
	local cfg = self:getAreaCfg(areaId, true)

	if cfg and nodeIndex then
		local nodePortal = cfg[string.format("%s%s", ArcadeGameEnum.Const.AreaNodePortalName, nodeIndex)]

		if not string.nilorempty(nodePortal) then
			local portalGroupArr = string.split(nodePortal, "|")

			for _, strPortalGroup in ipairs(portalGroupArr) do
				local cfgPortalList = GameUtil.splitString2(strPortalGroup, true, ",", "#")
				local portalList = {}

				for _, data in ipairs(cfgPortalList) do
					local portalId = data[2]
					local isCanExtract = true
					local limit = self:getPortalLimit(portalId)

					if limit and limit > 0 then
						local extractionCount = ArcadeGameModel.instance:getPortalExtractionCount(portalId)

						if extractionCount and limit <= extractionCount then
							isCanExtract = false
						end
					end

					if isCanExtract then
						portalList[#portalList + 1] = data
					end
				end

				local totalWeight = 0
				local weightList = {}

				for i, data in ipairs(portalList) do
					local weight = data[1]

					weightList[i] = weight
					totalWeight = totalWeight + weight
				end

				local index = ArcadeGameHelper.getRandomIndex(weightList, totalWeight)

				if index and portalList[index] then
					local portalId = portalList[index][2]

					result[#result + 1] = portalId
				end
			end

			if #result <= 0 then
				local guaranteePortalId = self:getArcadeConst(ArcadeEnum.ConstId.GuaranteePortal, true)

				result[#result + 1] = guaranteePortalId
			end
		end
	end

	return result
end

function ArcadeConfig:getRoomCfg(roomId, nilError)
	local cfg = lua_arcade_room.configDict[roomId]

	if not cfg and nilError then
		logError(string.format("ArcadeConfig:getRoomCfg error, cfg is nil, roomId:%s", roomId))
	end

	return cfg
end

function ArcadeConfig:getRoomType(roomId)
	local cfg = self:getRoomCfg(roomId, true)

	return cfg and cfg.roomType
end

function ArcadeConfig:getDropMethod(roomId)
	local cfg = self:getRoomCfg(roomId, true)

	return cfg and cfg.dropMethod
end

function ArcadeConfig:getMonsterGroups(roomId)
	local result = {}
	local cfg = self:getRoomCfg(roomId, true)

	if cfg and not string.nilorempty(cfg.monsterGroupIds) then
		result = string.splitToNumber(cfg.monsterGroupIds, "#")
	end

	return result
end

function ArcadeConfig:getMonsterWaves(roomId)
	local cfg = self:getRoomCfg(roomId, true)

	return cfg and cfg.monsterwaves
end

function ArcadeConfig:getWaveInterval(roomId)
	local result = {}
	local cfg = self:getRoomCfg(roomId, true)

	if cfg and not string.nilorempty(cfg.waveInterval) then
		result = string.splitToNumber(cfg.waveInterval, "#")
	end

	return result
end

function ArcadeConfig:getSpMonsterWaveDict(roomId)
	local result = {}
	local cfg = self:getRoomCfg(roomId, true)

	if cfg and not string.nilorempty(cfg.spMonster) then
		local arr = GameUtil.splitString2(cfg.spMonster, true)

		for _, data in ipairs(arr) do
			result[data[1]] = {
				probability = data[2],
				monsterId = data[3],
				count = data[4]
			}
		end
	end

	return result
end

function ArcadeConfig:getRoomInitInteractiveList(roomId)
	local result = {}
	local cfg = self:getRoomCfg(roomId, true)

	if cfg and not string.nilorempty(cfg.initInteractive) then
		local interactiveArr = string.split(cfg.initInteractive, "|")

		for _, interactiveStr in ipairs(interactiveArr) do
			local data = GameUtil.splitString2(interactiveStr, true, "#", ",")

			result[#result + 1] = {
				id = data[1][1],
				x = data[2][1],
				y = data[2][2]
			}
		end
	end

	return result
end

function ArcadeConfig:getRoomInitMonsterGroupList(roomId)
	local result = {}
	local cfg = self:getRoomCfg(roomId, true)

	if cfg and not string.nilorempty(cfg.initMonster) then
		result = string.splitToNumber(cfg.initMonster, "#")
	end

	return result
end

function ArcadeConfig:getRoomPortalCoordinates(roomId)
	local result = {}
	local cfg = self:getRoomCfg(roomId, true)

	if cfg and not string.nilorempty(cfg.nodePortalCoordinates) then
		result = GameUtil.splitString2(cfg.nodePortalCoordinates, true, "|", ",")
	end

	return result
end

function ArcadeConfig:getCharacterCfg(characterId, nilError)
	local cfg = lua_arcade_character.configDict[characterId]

	if not cfg and nilError then
		logError(string.format("ArcadeConfig:getCharacterCfg error, cfg is nil, characterId:%s", characterId))
	end

	return cfg
end

function ArcadeConfig:getCharacterIcon2(characterId)
	local cfg = self:getCharacterCfg(characterId, true)

	return cfg and cfg.icon2
end

function ArcadeConfig:getCharacterIcon2Scale(characterId)
	local cfg = self:getCharacterCfg(characterId, true)

	return cfg and cfg.icon2Scale
end

function ArcadeConfig:getCharacterIcon2Offset(characterId)
	local cfg = self:getCharacterCfg(characterId, true)

	return cfg and cfg.icon2Offset
end

function ArcadeConfig:getCharacterRes(characterId)
	local cfg = self:getCharacterCfg(characterId, true)

	if cfg and not string.nilorempty(cfg.resPath) then
		return ResUrl.getArcadeSceneRes(cfg.resPath)
	end
end

function ArcadeConfig:getCharacterBomb(characterId)
	local cfg = self:getCharacterCfg(characterId, true)

	return cfg and cfg.bomb
end

function ArcadeConfig:getCharacterSkill(characterId)
	local cfg = self:getCharacterCfg(characterId, true)

	return cfg and cfg.skill
end

function ArcadeConfig:getCharacterCollection(characterId)
	local cfg = self:getCharacterCfg(characterId, true)

	return cfg and cfg.collection
end

function ArcadeConfig:getCharacterSkillCost(characterId)
	local cfg = self:getCharacterCfg(characterId, true)

	return cfg and cfg.skillCost
end

function ArcadeConfig:getCharacterSize(characterId)
	local sizeX, sizeY = 0, 0
	local cfg = self:getCharacterCfg(characterId, true)

	if cfg and not string.nilorempty(cfg.shape) then
		local arr = string.splitToNumber(cfg.shape, "#")

		sizeX = arr[1] or 0
		sizeY = arr[2] or 0
	end

	return sizeX, sizeY
end

function ArcadeConfig:getMonsterGroupRowCfg(groupId, row)
	local cfg = lua_arcade_monster_group.configDict[groupId] and lua_arcade_monster_group.configDict[groupId][row]

	return cfg
end

function ArcadeConfig:getMonsterCfg(monsterId, nilError)
	local cfg = lua_arcade_monster.configDict[monsterId]

	if not cfg and nilError then
		logError(string.format("ArcadeConfig:getMonsterCfg error, cfg is nil, monsterId:%s", monsterId))
	end

	return cfg
end

function ArcadeConfig:getMonsterSize(monsterId)
	local sizeX, sizeY = 0, 0
	local cfg = self:getMonsterCfg(monsterId, true)

	if cfg and not string.nilorempty(cfg.shape) then
		local arr = string.splitToNumber(cfg.shape, "#")

		sizeX = arr[1] or 0
		sizeY = arr[2] or 0
	end

	return sizeX, sizeY
end

function ArcadeConfig:getMonsterRes(monsterId)
	local cfg = self:getMonsterCfg(monsterId, true)

	if cfg then
		if not string.nilorempty(cfg.resPath) then
			return ResUrl.getArcadeSceneRes(cfg.resPath)
		else
			logError(string.format("ArcadeConfig:getMonsterRes error, resPath is nil, monsterId:%s", monsterId))
		end
	end
end

function ArcadeConfig:getMonsterRace(monsterId)
	local cfg = self:getMonsterCfg(monsterId, true)

	return cfg and cfg.race
end

function ArcadeConfig:getMonsterHasCorpse(monsterId)
	local cfg = self:getMonsterCfg(monsterId, true)

	return cfg and cfg.hasCorpse
end

function ArcadeConfig:getMonsterDropList(monsterId)
	local result = {}
	local cfg = self:getMonsterCfg(monsterId, true)

	if cfg and not string.nilorempty(cfg.drop) then
		result = string.splitToNumber(cfg.drop, "#")
	end

	return result
end

function ArcadeConfig:getMonsterMoveType(monsterId)
	local cfg = self:getMonsterCfg(monsterId, true)

	return cfg and cfg.moveType
end

function ArcadeConfig:getMonsterIconOffset(characterId)
	local cfg = self:getMonsterCfg(characterId, true)

	return cfg and cfg.iconOffset
end

function ArcadeConfig:getMonsterIconScale(characterId)
	local cfg = self:getMonsterCfg(characterId, true)

	return cfg and cfg.iconScale
end

function ArcadeConfig:getInteractiveCfg(id, nilError)
	local cfg = lua_arcade_interactive_unit.configDict[id]

	if not cfg and nilError then
		logError(string.format("ArcadeConfig:getInteractiveCfg error, cfg is nil, id:%s", id))
	end

	return cfg
end

function ArcadeConfig:getInteractiveGrid(id)
	local sizeX, sizeY = 0, 0
	local cfg = self:getInteractiveCfg(id, true)

	if cfg and not string.nilorempty(cfg.grid) then
		local arr = string.splitToNumber(cfg.grid, "#")

		sizeX = arr[1] or 0
		sizeY = arr[2] or 0
	end

	return sizeX, sizeY
end

function ArcadeConfig:getInteractiveName(id)
	local cfg = self:getInteractiveCfg(id, true)

	return cfg and cfg.name
end

function ArcadeConfig:getInteractiveRes(id)
	local cfg = self:getInteractiveCfg(id, true)

	if cfg and not string.nilorempty(cfg.resPath) then
		return ResUrl.getArcadeSceneRes(cfg.resPath)
	end
end

function ArcadeConfig:getInteractiveDesc(id)
	local cfg = self:getInteractiveCfg(id, true)

	return cfg and cfg.desc
end

function ArcadeConfig:getInteractiveOptionList(id)
	local result = {}
	local cfg = self:getInteractiveCfg(id, true)

	if cfg and not string.nilorempty(cfg.optionID) then
		local optionArr = string.splitToNumber(cfg.optionID, "#")

		result = optionArr
	end

	return result
end

function ArcadeConfig:getInteractiveLimit(id)
	local cfg = self:getInteractiveCfg(id, true)

	return cfg and cfg.limit
end

function ArcadeConfig:getInteractiveBombAttackEventIdList(id)
	local result = {}
	local cfg = self:getInteractiveCfg(id, true)

	if not string.nilorempty(cfg and cfg.spbehaviorID) then
		result = string.splitToNumber(cfg.spbehaviorID, "#")
	end

	return result
end

function ArcadeConfig:getInteractiveSceneIcon(id)
	local cfg = self:getInteractiveCfg(id, true)

	return cfg and cfg.sceneIcon
end

function ArcadeConfig:getInteractiveBeforeIdleShowEffId(id)
	local cfg = self:getInteractiveCfg(id, true)

	return cfg and cfg.effectBefore
end

function ArcadeConfig:getInteractiveActingEffId(id)
	local cfg = self:getInteractiveCfg(id, true)

	return cfg and cfg.effectActing
end

function ArcadeConfig:getInteractiveAfterIdleShowEffId(id)
	local cfg = self:getInteractiveCfg(id, true)

	return cfg and cfg.effectAfter
end

function ArcadeConfig:getIsGoodsInteractive(id)
	local optionIdList = self:getInteractiveOptionList(id)

	for _, optionId in ipairs(optionIdList) do
		local type = self:getEventOptionType(optionId)

		if type == ArcadeGameEnum.EventOptionType.Buy then
			return true
		end
	end
end

function ArcadeConfig:getEventOptionCfg(id, nilError)
	local cfg = lua_arcade_event_option.configDict[id]

	if not cfg and nilError then
		logError(string.format("ArcadeConfig:getEventOptionCfg error, cfg is nil, id:%s", id))
	end

	return cfg
end

function ArcadeConfig:getEventOptionType(id)
	local cfg = self:getEventOptionCfg(id, true)

	return cfg and cfg.type
end

function ArcadeConfig:getEventOptionCondition(id)
	local cfg = self:getEventOptionCfg(id, true)

	return cfg and cfg.condition
end

function ArcadeConfig:getEventOptionParam(id)
	local cfg = self:getEventOptionCfg(id, true)

	return cfg and cfg.param
end

function ArcadeConfig:getEventOptionDesc(id)
	local cfg = self:getEventOptionCfg(id, true)

	return cfg and cfg.optionDesc
end

function ArcadeConfig:getEventOptionTriggerDesc(id)
	local cfg = self:getEventOptionCfg(id, true)

	return cfg and cfg.descChange
end

function ArcadeConfig:getPortalLimit(id)
	local cfg = self:getInteractiveCfg(id, true)

	return cfg and cfg.nodePortalLimit
end

function ArcadeConfig:getBombCfg(id, nilError)
	local cfg = lua_arcade_bomb.configDict[id]

	if not cfg and nilError then
		logError(string.format("ArcadeConfig:getBombCfg error, cfg is nil, id:%s", id))
	end

	return cfg
end

function ArcadeConfig:getBombRes(id)
	local cfg = self:getBombCfg(id, true)

	if cfg and not string.nilorempty(cfg.resPath) then
		return ResUrl.getArcadeSceneRes(cfg.resPath)
	end
end

function ArcadeConfig:getBombSize(id)
	local sizeX, sizeY = 0, 0
	local cfg = self:getBombCfg(id, true)

	if cfg and not string.nilorempty(cfg.shape) then
		local arr = string.splitToNumber(cfg.shape, "#")

		sizeX = arr[1] or 0
		sizeY = arr[2] or 0
	end

	return sizeX, sizeY
end

function ArcadeConfig:getBombDamage(id)
	local cfg = self:getBombCfg(id, true)

	return cfg and cfg.damage or 0
end

function ArcadeConfig:getBombCountdown(id)
	local cfg = self:getBombCfg(id, true)

	return cfg and cfg.countdown or 0
end

function ArcadeConfig:getBombIcon(id)
	local cfg = self:getBombCfg(id, true)

	return cfg and cfg.icon
end

function ArcadeConfig:getBombTarget(id)
	local cfg = self:getBombCfg(id, true)

	return cfg and cfg.target
end

function ArcadeConfig:getBombName(id)
	local cfg = self:getBombCfg(id, true)

	return cfg and cfg.name
end

function ArcadeConfig:getBombDesc(id)
	local cfg = self:getBombCfg(id, true)

	return cfg and cfg.skillDesc
end

function ArcadeConfig:getBombAddFloor(id)
	local cfg = self:getBombCfg(id, true)

	return cfg and cfg.addFloor
end

function ArcadeConfig:getBombIdleShowEffectId(id)
	local cfg = self:getBombCfg(id, true)

	return cfg and cfg.effectDefault
end

function ArcadeConfig:getBombAlertEffectId(id)
	local cfg = self:getBombCfg(id, true)

	return cfg and cfg.alertEffectId
end

function ArcadeConfig:getActiveSkillCfg(skillId, nilError)
	local cfg = lua_arcade_active_skill.configDict[skillId]

	if not cfg and nilError then
		logError(string.format("ArcadeConfig:getActiveSkillCfg error, cfg is nil, skillId:%s", skillId))
	end

	return cfg
end

function ArcadeConfig:getActiveSkillDamage(skillId)
	local cfg = self:getActiveSkillCfg(skillId)

	return cfg and cfg.damage or 0
end

function ArcadeConfig:getActiveSkillIcon(skillId)
	local cfg = self:getActiveSkillCfg(skillId, true)

	return cfg and cfg.icon
end

function ArcadeConfig:getActiveSkillName(skillId)
	local cfg = self:getActiveSkillCfg(skillId, true)

	return cfg and cfg.skillName
end

function ArcadeConfig:getActiveSkillDesc(skillId)
	local cfg = self:getActiveSkillCfg(skillId, true)

	return cfg and cfg.skillDesc
end

function ArcadeConfig:getActiveSkillTarget(skillId)
	local cfg = self:getActiveSkillCfg(skillId, true)

	return cfg and cfg.target
end

function ArcadeConfig:getActiveSkillSpellEffect(skillId)
	local cfg = self:getActiveSkillCfg(skillId, true)

	return cfg and cfg.spellEffect
end

function ArcadeConfig:getActiveSkillBulletEffect(skillId)
	local cfg = self:getActiveSkillCfg(skillId, true)

	return cfg and cfg.bulletEffect
end

function ArcadeConfig:getActiveSkillHitEffect(id)
	local cfg = self:getActiveSkillCfg(id, true)

	return cfg and cfg.hitEffect
end

function ArcadeConfig:getPassiveSkillCfg(skillId, nilError)
	local cfg = lua_arcade_passive_skill.configDict[skillId]

	if not cfg and nilError then
		logError(string.format("ArcadeConfig:getPassiveSkillCfg error, cfg is nil, skillId:%s", skillId))
	end

	return cfg
end

function ArcadeConfig:getSkillTargetCfg(id, nilError)
	local cfg = lua_arcade_skill_target.configDict[id]

	if not cfg and nilError then
		logError(string.format("ArcadeConfig:getSkillTargetCfg error, cfg is nil, id:%s", id))
	end

	return cfg
end

function ArcadeConfig:getSkillFloorCfg(id, nilError)
	local cfg = lua_arcade_floor.configDict[id]

	if not cfg and nilError then
		logError(string.format("ArcadeConfig:getSkillFloorCfg error, cfg is nil, id:%s", id))
	end

	return cfg
end

function ArcadeConfig:getArcadeBuffCfg(buffId, nilError)
	local cfg = lua_arcade_buff.configDict[buffId]

	if not cfg and nilError then
		logError(string.format("ArcadeConfig:getArcadeBuffCfg error, cfg is nil, buffId:%s", buffId))
	end

	return cfg
end

function ArcadeConfig:getArcadeBuffEffectParamList(buffId)
	local result = {}
	local cfg = self:getArcadeBuffCfg(buffId, true)

	if cfg and not string.nilorempty(cfg.effectParam) then
		result = string.split(cfg.effectParam, "#")
	end

	return result
end

function ArcadeConfig:getArcadeBuffPassiveSkillList(buffId)
	local result = {}
	local cfg = self:getArcadeBuffCfg(buffId, true)

	if cfg and not string.nilorempty(cfg.addPassiveSkillId) then
		result = string.splitToNumber(cfg.addPassiveSkillId, "#")
	end

	return result
end

function ArcadeConfig:getArcadeBuffEntityTypeDict(buffId)
	local result = {}
	local cfg = self:getArcadeBuffCfg(buffId, true)

	if cfg and not string.nilorempty(cfg.entityType) then
		local arr = string.split(cfg.entityType, "#")

		for _, entityType in pairs(arr) do
			result[entityType] = true
		end
	end

	return result
end

function ArcadeConfig:getArcadeBuffRound(buffId)
	local cfg = self:getArcadeBuffCfg(buffId, true)

	return cfg and cfg.round
end

function ArcadeConfig:getArcadeBuffIsNotSubInRoundBegin(buffId)
	local cfg = self:getArcadeBuffCfg(buffId, true)

	return cfg and cfg.notSubInRoundBegin
end

function ArcadeConfig:getArcadeBuffShowPriority(buffId)
	local cfg = self:getArcadeBuffCfg(buffId, true)

	return cfg and cfg.showPriority
end

function ArcadeConfig:getArcadeBuffGainEffect(buffId)
	local cfg = self:getArcadeBuffCfg(buffId, true)

	return cfg and cfg.gainEffect
end

function ArcadeConfig:getArcadeBuffLoopEffect(buffId)
	local cfg = self:getArcadeBuffCfg(buffId, true)

	return cfg and cfg.loopEffect
end

function ArcadeConfig:getCollectionCfg(id, nilError)
	local cfg = lua_arcade_collection.configDict[id]

	if not cfg and nilError then
		logError(string.format("ArcadeConfig:getCollectionCfg error, cfg is nil, id:%s", id))
	end

	return cfg
end

function ArcadeConfig:getCollectionIdList()
	local result = {}

	for _, cfg in ipairs(lua_arcade_collection.configList) do
		result[#result + 1] = cfg.id
	end

	return result
end

function ArcadeConfig:getCollectionIdListWithType(type, qualityDict)
	local result = {}

	if not string.nilorempty(type) then
		for _, cfg in ipairs(lua_arcade_collection.configList) do
			if cfg.type == type and (not qualityDict or qualityDict[cfg.level]) then
				result[#result + 1] = cfg.id
			end
		end
	end

	return result
end

function ArcadeConfig:getCollectionName(id)
	local cfg = self:getCollectionCfg(id, true)

	return cfg and cfg.name
end

function ArcadeConfig:getCollectionIcon(id)
	local cfg = self:getCollectionCfg(id, true)

	return cfg and cfg.icon
end

function ArcadeConfig:getCollectionType(id)
	local cfg = self:getCollectionCfg(id, true)

	return cfg and cfg.type
end

function ArcadeConfig:getCollectionDesc(id, withDurability)
	local cfg = self:getCollectionCfg(id, true)
	local desc = cfg and cfg.describe

	if withDurability and string.find(desc, "▩1%%s") then
		local durability = self:getCollectionDurability(id)

		desc = string.gsub(desc, "▩1%%s", durability)
	end

	return desc
end

function ArcadeConfig:getCollectionDurability(id)
	local cfg = self:getCollectionCfg(id, true)

	return cfg and cfg.durable or 0
end

function ArcadeConfig:getCollectionPassiveSkillList(id)
	local result = {}
	local cfg = self:getCollectionCfg(id, true)

	if cfg and not string.nilorempty(cfg.passiveSkills) then
		result = string.splitToNumber(cfg.passiveSkills, "#")
	end

	return result
end

function ArcadeConfig:getCollectionPrice(id)
	local cfg = self:getCollectionCfg(id, true)

	return cfg and cfg.price or 0
end

function ArcadeConfig:getCollectionResPath(id)
	local cfg = self:getCollectionCfg(id, true)

	if cfg and not string.nilorempty(cfg.resPath) then
		return ResUrl.getArcadeSceneRes(cfg.resPath)
	end
end

function ArcadeConfig:getCollectionIsUnique(id)
	local cfg = self:getCollectionCfg(id, true)

	return cfg and cfg.isUnique
end

function ArcadeConfig:getCollectionGoodsWeight(id)
	local cfg = self:getCollectionCfg(id, true)

	return cfg and cfg.goodsWeight
end

function ArcadeConfig:getCollectionDropWeight(id)
	local cfg = self:getCollectionCfg(id, true)

	return cfg and cfg.dropWeight
end

function ArcadeConfig:getCollectionScale(id)
	local cfg = self:getCollectionCfg(id, true)

	return cfg and cfg.scale
end

function ArcadeConfig:getCollectionPosOffset(id)
	local cfg = self:getCollectionCfg(id, true)

	return cfg and cfg.posOffset
end

function ArcadeConfig:getCollectionShowTmpAttrChange(id)
	local cfg = self:getCollectionCfg(id, true)

	return cfg and cfg.showTmpAttrChange
end

function ArcadeConfig:getCollectionShowTempAttrVal(id, attrId)
	local result = 0
	local tmpShowAttrId = self:getCollectionShowTmpAttrChange(id)

	if attrId ~= tmpShowAttrId then
		return result
	end

	local skillList = self:getCollectionPassiveSkillList(id)

	for _, skillId in ipairs(skillList) do
		local skillCfg = self:getPassiveSkillCfg(skillId, true)

		if skillCfg then
			for _, effKey in ipairs(ArcadeGameEnum.TriggerCfgKeys.Effect) do
				local effectStr = skillCfg[effKey]

				if not string.nilorempty(effectStr) then
					local params = string.split(effectStr, "#")

					if params[1] == "attributeChange1" and tonumber(params[2]) == attrId then
						result = result + (tonumber(params[3]) or 0)
					end
				end
			end
		end
	end

	return result
end

function ArcadeConfig:getDropCfg(dropId, nilError)
	local cfg = lua_arcade_drop.configDict[dropId]

	if not cfg and nilError then
		logError(string.format("ArcadeConfig:getDropCfg error, cfg is nil, dropId:%s", dropId))
	end

	return cfg
end

function ArcadeConfig:getDropParam(dropId)
	local result
	local cfg = self:getDropCfg(dropId, true)

	if cfg then
		if not string.nilorempty(cfg.resourcedrop) then
			result = {
				dropItemType = ArcadeGameEnum.DropItemType.Resource,
				param = cfg.resourcedrop
			}
		elseif not string.nilorempty(cfg.collectiondrop) then
			result = {
				dropItemType = ArcadeGameEnum.DropItemType.Collection,
				param = cfg.collectiondrop
			}
		elseif not string.nilorempty(cfg.characterunlock) then
			result = {
				dropItemType = ArcadeGameEnum.DropItemType.Character,
				param = cfg.characterunlock
			}
		end
	end

	return result
end

function ArcadeConfig:getArcadeEffectCfg(effectId, nilError)
	local cfg = lua_arcade_effects.configDict[effectId]

	if not cfg and nilError then
		logError(string.format("ArcadeConfig:getArcadeEffectCfg error, cfg is nil, effectId:%s", effectId))
	end

	return cfg
end

function ArcadeConfig:getEffectAnim(effectId, direction)
	local cfg = self:getArcadeEffectCfg(effectId, true)
	local animName = cfg and cfg.triggerAnimation

	if not string.nilorempty(animName) and string.find(animName, "▩1%%s") then
		animName = string.gsub(animName, "▩1%%s", direction or ArcadeEnum.Direction.Up)
	end

	return animName
end

function ArcadeConfig:getEffectAudio(effectId)
	local cfg = self:getArcadeEffectCfg(effectId, true)

	return cfg and cfg.triggerAudio
end

function ArcadeConfig:getEffectResName(effectId)
	local cfg = self:getArcadeEffectCfg(effectId, true)

	return cfg and cfg.triggerEffects
end

function ArcadeConfig:getEffectIsPlayOnGrid(effectId)
	local cfg = self:getArcadeEffectCfg(effectId, true)

	return cfg and cfg.isPlayOnGrid
end

function ArcadeConfig:getEffectSpeed(effectId)
	local cfg = self:getArcadeEffectCfg(effectId, true)

	return cfg and cfg.speed
end

function ArcadeConfig:getEffectIsFromBorder(effectId)
	local cfg = self:getArcadeEffectCfg(effectId, true)

	return cfg and cfg.isFromBorder
end

function ArcadeConfig:getEffectDirection(effectId)
	local cfg = self:getArcadeEffectCfg(effectId, true)

	return cfg and cfg.direction
end

function ArcadeConfig:getEffectRotationType(effectId)
	local cfg = self:getArcadeEffectCfg(effectId, true)

	return cfg and cfg.effectsRotationType
end

function ArcadeConfig:getIsNeedShake(effectId)
	local cfg = self:getArcadeEffectCfg(effectId, true)

	return cfg and cfg.needShake
end

function ArcadeConfig:getIsNearestGrid(effectId)
	local cfg = self:getArcadeEffectCfg(effectId, true)

	return cfg and cfg.isNearestGrid
end

function ArcadeConfig:getActionShowCfg(showId, nilError)
	local cfg = lua_arcade_action_show.configDict[showId]

	if not cfg and nilError then
		logError(string.format("ArcadeConfig:getActionShowCfg error, cfg is nil, showId:%s", showId))
	end

	return cfg
end

function ArcadeConfig:getActionShowEffectIdList(showId)
	local result = {}
	local cfg = self:getActionShowCfg(showId, true)

	if cfg and cfg.effectIds then
		for i, effectId in ipairs(cfg.effectIds) do
			result[i] = effectId
		end
	end

	return result
end

function ArcadeConfig:getStateShowCfg(showId, nilError)
	local cfg = lua_arcade_state_show.configDict[showId]

	if not cfg and nilError then
		logError(string.format("ArcadeConfig:getStateShowCfg error, cfg is nil, showId:%s", showId))
	end

	return cfg
end

function ArcadeConfig:getStateShowEffectId(showId)
	local cfg = self:getStateShowCfg(showId, true)

	return cfg and cfg.effectId
end

function ArcadeConfig:getTalkCfg(id, groupId, nilError)
	local cfgList = self:getTalkGroupCfg(id, nilError)
	local cfg = cfgList and cfgList[groupId]

	if not cfg and nilError then
		logError(string.format("ArcadeConfig:getTalkCfg error, cfg is nil, id:%s, groupId:%s", id, groupId))
	end

	return cfg
end

function ArcadeConfig:getTalkGroupCfg(id, nilError)
	local cfgList = lua_arcade_talk.configDict[id]

	if not cfgList and nilError then
		logError(string.format("ArcadeConfig:getTalkGroupCfg error, cfgList is nil, id:%s", id))
	end

	return cfgList
end

function ArcadeConfig:isEntityHasTalk(id)
	local list = self:getTalkGroupCfg(id)

	return list and true or false
end

function ArcadeConfig:_initTalkTriggerTypeDict()
	self._talkTriggerTypeDict = {}

	for _, cfg in ipairs(lua_arcade_talk.configList) do
		local id = cfg.id
		local idDict = self._talkTriggerTypeDict[id]

		if not idDict then
			idDict = {}
			self._talkTriggerTypeDict[id] = idDict
		end

		local condition = cfg.condition
		local groupList = idDict[condition]

		if not groupList then
			groupList = {}
			idDict[condition] = groupList
		end

		groupList[#groupList + 1] = cfg.groupId
	end
end

function ArcadeConfig:getGroupListByTrigger(id, triggerType)
	if not self._talkTriggerTypeDict then
		self:_initTalkTriggerTypeDict()
	end

	local idDict = self._talkTriggerTypeDict[id]

	return idDict and idDict[triggerType]
end

function ArcadeConfig:getTalkGroupTriggerParam(id, groupId)
	local cfg = self:getTalkCfg(id, groupId, true)

	return cfg and cfg.param
end

function ArcadeConfig:getTalkGroupWeight(id, groupId)
	local cfg = self:getTalkCfg(id, groupId, true)

	return cfg and cfg.weight
end

function ArcadeConfig:getTalkStepCfg(groupId, step, nilError)
	local cfgList = self:getTalkStepGroupCfg(groupId, nilError)
	local cfg = cfgList and cfgList[step]

	if not cfg and nilError then
		logError(string.format("ArcadeConfig:getTalkCfg error, cfg is nil, id:%s, step:%s", groupId, step))
	end

	return cfg
end

function ArcadeConfig:getTalkStepGroupCfg(groupId, nilError)
	local cfgList = lua_arcade_talk_step.configDict[groupId]

	if not cfgList and nilError then
		logError(string.format("ArcadeConfig:getTalkStepGroupCfg error, cfgList is nil, id:%s", groupId))
	end

	return cfgList
end

ArcadeConfig.instance = ArcadeConfig.New()

return ArcadeConfig
