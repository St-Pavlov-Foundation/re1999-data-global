module("modules.logic.versionactivity1_2.yaxian.model.game.YaXianGameModel", package.seeall)

slot0 = class("YaXianGameModel", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.release(slot0)
	slot0.actId = nil
	slot0.mapId = nil
	slot0.episodeId = nil
	slot0.episodeCo = nil
	slot0.width = nil
	slot0.height = nil
	slot0.round = nil
	slot0.result = nil
	slot0.mapTileBaseList = nil
	slot0.mapInteractMoList = nil
	slot0.playerInteractMo = nil
	slot0.finishInteract = nil
	slot0.baffleList = nil
	slot0.skillDict = nil
	slot0.mapOffsetX = nil
	slot0.mapOffsetY = nil
	slot0.canWalkTargetPosDict = nil
	slot0.gameLoadOne = nil
	slot0.currentDeleteInteractId = nil
end

function slot0.initLocalConfig(slot0, slot1, slot2)
	slot0.episodeCo = YaXianConfig.instance:getEpisodeConfig(slot1, slot2)
	slot0.episodeId = slot2
	slot0.actId = slot1
	slot0.mapId = slot0.episodeCo.mapId
	slot0.mapCo = YaXianConfig.instance:getMapConfig(slot1, slot0.mapId)
	slot0.width = slot0.mapCo.width
	slot0.height = slot0.mapCo.height

	if slot0.mapCo and not string.nilorempty(slot0.mapCo.offset) then
		slot3 = string.splitToNumber(slot0.mapCo.offset, ",")
		slot0.mapOffsetX = slot3[1]
		slot0.mapOffsetY = slot3[2]
	else
		slot0.mapOffsetX = YaXianGameEnum.ChessBoardOffsetX
		slot0.mapOffsetY = YaXianGameEnum.ChessBoardOffsetY
	end

	slot0.mapTileBaseList = string.splitToNumber(slot0.mapCo.tilebase, ",")

	slot0:initBaffleData()
end

function slot0.initBaffleData(slot0)
	slot0.baffleList = {}
	slot1, slot2 = nil

	for slot6 = 0, slot0.width - 1 do
		for slot10 = 0, slot0.height - 1 do
			if slot0.mapTileBaseList[slot0:getIndex(slot6, slot10)] > 1 then
				if YaXianGameHelper.hasBaffle(slot1, YaXianGameEnum.BaffleDirectionPowerPos.Left) then
					table.insert(slot0.baffleList, slot0:buildBaffleData(slot6, slot10, YaXianGameEnum.BaffleDirection.Left, YaXianGameHelper.getBaffleType(slot1, YaXianGameEnum.BaffleDirectionPowerPos.Left)))
				end

				if YaXianGameHelper.hasBaffle(slot1, YaXianGameEnum.BaffleDirectionPowerPos.Right) then
					table.insert(slot0.baffleList, slot0:buildBaffleData(slot6, slot10, YaXianGameEnum.BaffleDirection.Right, YaXianGameHelper.getBaffleType(slot1, YaXianGameEnum.BaffleDirectionPowerPos.Right)))
				end

				if YaXianGameHelper.hasBaffle(slot1, YaXianGameEnum.BaffleDirectionPowerPos.Top) then
					table.insert(slot0.baffleList, slot0:buildBaffleData(slot6, slot10, YaXianGameEnum.BaffleDirection.Top, YaXianGameHelper.getBaffleType(slot1, YaXianGameEnum.BaffleDirectionPowerPos.Top)))
				end

				if YaXianGameHelper.hasBaffle(slot1, YaXianGameEnum.BaffleDirectionPowerPos.Bottom) then
					table.insert(slot0.baffleList, slot0:buildBaffleData(slot6, slot10, YaXianGameEnum.BaffleDirection.Bottom, YaXianGameHelper.getBaffleType(slot1, YaXianGameEnum.BaffleDirectionPowerPos.Bottom)))
				end
			end
		end
	end
end

function slot0.initServerDataByServerData(slot0, slot1)
	slot0:setRound(slot1.currentRound)
	slot0:initObjects(slot1.interactObjects)
	slot0:updateFinishInteracts(slot1.finishInteracts)
end

function slot0.initServerDataByMapMo(slot0, slot1)
	slot0:setRound(slot1.currentRound)
	slot0:setObjects(slot1.interactObjs)
	slot0:updateFinishInteracts(slot1.finishInteracts)
end

function slot0.getBaffleList(slot0)
	return slot0.baffleList
end

function slot0.addInteractMo(slot0, slot1)
	table.insert(slot0.mapInteractMoList, slot1)
end

function slot0.removeInteractMo(slot0, slot1)
	tabletool.removeValue(slot0.mapInteractMoList, slot1)
end

function slot0.getPlayerInteractMo(slot0)
	return slot0.playerInteractMo
end

function slot0.setPlayerInteractMo(slot0)
	for slot4, slot5 in ipairs(slot0.mapInteractMoList) do
		if slot5.config.interactType == YaXianGameEnum.InteractType.Player then
			slot0.playerInteractMo = slot5

			return
		end
	end

	logError("not found Player InteractMo")
end

function slot0.getExitInteractMo(slot0)
	return slot0.exitInteractMo
end

function slot0.setExitInteractMo(slot0)
	for slot4, slot5 in ipairs(slot0.mapInteractMoList) do
		if slot5.config.interactType == YaXianGameEnum.InteractType.TriggerVictory then
			slot0.exitInteractMo = slot5

			return
		end
	end

	logError("not found Exit InteractMo")
end

function slot0.initObjects(slot0, slot1)
	slot0.mapInteractMoList = {}

	for slot6 = 1, #slot1 do
		slot8 = YaXianGameInteractMO.New()

		slot8:init(slot0.actId, slot1[slot6])
		table.insert(slot0.mapInteractMoList, slot8)
	end

	slot0:setPlayerInteractMo()
	slot0:setExitInteractMo()
	slot0:initInteractData()
end

function slot0.setObjects(slot0, slot1)
	slot0.mapInteractMoList = slot1

	slot0:setPlayerInteractMo()
	slot0:setExitInteractMo()
	slot0:initInteractData()
end

function slot0.addObject(slot0, slot1)
	slot2 = YaXianGameInteractMO.New()

	slot2:init(slot0.actId, slot1)
	table.insert(slot0.mapInteractMoList, slot2)

	return slot2
end

function slot0.removeObjectById(slot0, slot1)
	for slot5 = 1, #slot0.mapInteractMoList do
		if slot0.mapInteractMoList[slot5].id == slot1 then
			table.remove(slot0.mapInteractMoList, slot5)

			return slot0.mapInteractMoList[slot5]
		end
	end
end

function slot0.initInteractData(slot0)
	for slot4, slot5 in ipairs(slot0.mapInteractMoList) do
		if slot5.config.interactType == YaXianGameEnum.InteractType.Player then
			if slot0:updateSkillInfoAndCheckHasChange(slot5.data and slot5.data.skills) then
				YaXianGameController.instance:dispatchEvent(YaXianEvent.OnUpdateSkillInfo)
			end

			if slot0:updateEffectsAndCheckHasChange(slot5.data and slot5.data.effects) then
				YaXianGameController.instance:dispatchEvent(YaXianEvent.OnUpdateEffectInfo)
			end
		end
	end
end

function slot0.updateFinishInteracts(slot0, slot1)
	slot0.finishInteract = {}

	if slot1 then
		for slot5 = 1, #slot1 do
			slot0.finishInteract[slot1[slot5]] = true
		end
	end
end

function slot0.setFinishInteracts(slot0, slot1)
	slot0.finishInteract = slot1
end

function slot0.isAlertArea(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot0.mapInteractMoList) do
		if slot7.alertPosList then
			for slot11, slot12 in ipairs(slot7.alertPosList) do
				if slot1 == slot12.posX and slot2 == slot12.posY then
					return true
				end
			end
		end
	end

	return false
end

function slot0.hasInteract(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot0.mapInteractMoList) do
		if slot1 == slot7.posX and slot2 == slot7.posY and slot7.config.interactType ~= YaXianGameEnum.InteractType.Player then
			return true
		end
	end

	return false
end

function slot0.updateSkillInfo(slot0, slot1)
	if not slot1 then
		slot0.skillDict = nil

		return
	end

	slot0.skillDict = slot0.skillDict or {}

	for slot5, slot6 in ipairs(slot1) do
		if not slot0.skillDict[slot6.skillId] then
			slot7 = YaXianGameSkillMo.New()

			slot7:init(slot0.actId, slot6)

			slot0.skillDict[slot6.skillId] = slot7
		else
			slot7:updateMO(slot6)
		end
	end
end

function slot0.updateSkillInfoAndCheckHasChange(slot0, slot1)
	if not slot1 then
		if not slot0.skillDict then
			return false
		else
			slot0:updateSkillInfo(slot1)

			return true
		end
	end

	slot0.skillDict = slot0.skillDict or {}

	for slot5, slot6 in ipairs(slot1) do
		if not slot0.skillDict[slot6.skillId] then
			slot0:updateSkillInfo(slot1)

			return true
		elseif slot7.canUseCount ~= slot6.canUseCount then
			slot0:updateSkillInfo(slot1)

			return true
		end
	end

	return false
end

function slot0.getSkillMo(slot0, slot1)
	return slot0.skillDict and slot0.skillDict[slot1]
end

function slot0.hasSkill(slot0)
	return slot0.skillDict ~= nil
end

function slot0.updateEffects(slot0, slot1)
	if not slot1 then
		slot0._effectsDict = nil

		return
	end

	slot0.effectsPool = slot0.effectsPool or {}

	if slot0._effectsDict then
		for slot5, slot6 in pairs(slot0._effectsDict) do
			slot0.effectsPool[slot5] = slot6
		end
	end

	slot0._effectsDict = {}

	for slot5, slot6 in ipairs(slot1) do
		if not slot0.effectsPool[slot6.effectType] then
			YaXianGameSkillEffectMo.New():init(slot0.actId, slot6)
		else
			slot7:updateMO(slot6)
		end

		slot0._effectsDict[slot7.effectType] = slot7
	end
end

function slot0.updateEffectsAndCheckHasChange(slot0, slot1)
	if not slot1 and not slot0._effectsDict then
		slot0._effectsDict = nil

		return false
	end

	if not slot1 then
		slot0._effectsDict = nil

		return true
	end

	if not slot0._effectsDict then
		slot0:updateEffects(slot1)

		return true
	end

	if #slot1 ~= tabletool.len(slot0._effectsDict) then
		slot0:updateEffects(slot1)

		return true
	end

	for slot5, slot6 in ipairs(slot1) do
		if not slot0._effectsDict[slot6.effectType] then
			slot0:updateEffects(slot1)

			return true
		elseif slot7.remainRound ~= slot1.remainRound then
			slot0:updateEffects(slot1)

			return true
		end
	end
end

function slot0.getEffectByType(slot0, slot1)
	return slot0._effectsDict and slot0._effectsDict[slot1]
end

function slot0.isShowVisibleStatus(slot0)
	return slot0._effectsDict and slot0._effectsDict[YaXianGameEnum.SkillType.InVisible] and slot0._effectsDict[YaXianGameEnum.SkillType.InVisible].remainRound > 0
end

function slot0.isShowThroughStatus(slot0)
	return slot0._effectsDict and slot0._effectsDict[YaXianGameEnum.SkillType.ThroughWall] and slot0._effectsDict[YaXianGameEnum.SkillType.ThroughWall].remainRound > 0
end

function slot0.hasInVisibleEffect(slot0)
	return slot0._effectsDict and slot0._effectsDict[YaXianGameEnum.SkillType.InVisible] and slot0._effectsDict[YaXianGameEnum.SkillType.InVisible].remainRound > 1
end

function slot0.hasThroughWallEffect(slot0)
	return slot0._effectsDict and slot0._effectsDict[YaXianGameEnum.SkillType.ThroughWall] and slot0._effectsDict[YaXianGameEnum.SkillType.ThroughWall].remainRound > 0
end

function slot0.addFinishInteract(slot0, slot1)
	slot0.finishInteract[slot1] = true
end

function slot0.isInteractFinish(slot0, slot1)
	if slot0.finishInteract then
		return slot0.finishInteract[slot1]
	end
end

function slot0.getBaseTile(slot0, slot1, slot2)
	return slot0.mapTileBaseList[slot0:getIndex(slot1, slot2)]
end

function slot0.setBaseTile(slot0, slot1, slot2, slot3)
	slot0.mapTileBaseList[slot0:getIndex(slot1, slot2)] = slot3
end

function slot0.setRound(slot0, slot1)
	slot0.round = slot1
end

function slot0.setResult(slot0, slot1)
	slot0.result = slot1
end

function slot0.getResult(slot0)
	return slot0.result
end

function slot0.getInteractMoList(slot0)
	return slot0.mapInteractMoList
end

function slot0.getInteractMo(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.mapInteractMoList) do
		if slot6.id == slot1 then
			return slot6
		end
	end
end

function slot0.getIndex(slot0, slot1, slot2)
	return slot2 * slot0.width + slot1 + 1
end

function slot0.getGameSize(slot0)
	return slot0.width, slot0.height
end

function slot0.getMapId(slot0)
	return slot0.mapId
end

function slot0.getActId(slot0)
	return slot0.actId
end

function slot0.getRound(slot0)
	return math.max(slot0.round or 1, 1)
end

function slot0.isRoundUseUp(slot0)
	return slot0:getRound() == slot0.episodeCo.maxRound
end

function slot0.getEpisodeId(slot0)
	return slot0.episodeId
end

function slot0.getEpisodeCo(slot0)
	return slot0.episodeCo
end

function slot0.isPosInChessBoard(slot0, slot1, slot2)
	return slot1 >= 0 and slot1 < slot0.width and slot2 >= 0 and slot2 < slot0.height
end

function slot0.buildBaffleData(slot0, slot1, slot2, slot3, slot4)
	return {
		x = slot1,
		y = slot2,
		direction = slot3,
		type = slot4
	}
end

function slot0.setCanWalkTargetPosDict(slot0, slot1)
	slot0.canWalkDirection2Pos = slot1
	slot0.canWalkPos2Direction = {}

	for slot5, slot6 in pairs(slot0.canWalkDirection2Pos) do
		slot0.canWalkPos2Direction[YaXianGameHelper.getPosHashKey(slot6.x, slot6.y)] = slot5
	end
end

function slot0.getCanWalkTargetPosDict(slot0)
	return slot0.canWalkDirection2Pos
end

function slot0.getCanWalkPos2Direction(slot0)
	return slot0.canWalkPos2Direction
end

function slot0.setGameLoadDone(slot0, slot1)
	slot0.gameLoadOne = slot1
end

function slot0.gameIsLoadDone(slot0)
	return slot0.gameLoadOne
end

function slot0.setNeedFeatureInteractMo(slot0, slot1)
	slot0.needFeatureInteractMo = slot1
	slot0.featurePrePosX = slot0.needFeatureInteractMo.prePosX
	slot0.featurePrePosY = slot0.needFeatureInteractMo.prePosY
	slot0.featurePreDirection = slot0.needFeatureInteractMo.preDirection
end

function slot0.clearFeatureInteract(slot0)
	slot0.needFeatureInteractMo = nil
	slot0.featurePrePosX = nil
	slot0.featurePrePosY = nil
	slot0.featurePreDirection = nil
end

function slot0.getNeedFeatureInteractMo(slot0)
	return slot0.needFeatureInteractMo
end

function slot0.checkFinishCondition(slot0, slot1, slot2)
	if slot1 == YaXianGameEnum.ConditionType.PassEpisode then
		return slot0.result
	elseif slot1 == YaXianGameEnum.ConditionType.Round then
		return slot0.result and slot0.round <= slot2
	elseif slot1 == YaXianGameEnum.ConditionType.FinishInteract then
		return slot0:isInteractFinish(slot2)
	elseif slot1 == YaXianGameEnum.ConditionType.FinishAllInteract then
		if slot2 > 0 and slot2 < slot0.round then
			return false
		end

		slot3 = 0

		if slot0.finishInteract then
			for slot7, slot8 in pairs(slot0.finishInteract) do
				if YaXianConfig.instance:checkInteractCanFinish(YaXianConfig.instance:getInteractObjectCo(slot0.actId, slot7)) then
					slot3 = slot3 + 1
				end
			end
		end

		return slot3 == YaXianConfig.instance:getEpisodeCanFinishInteractCount(slot0.episodeCo)
	else
		logError("un support condition type")

		return false
	end
end

function slot0.getFinishConditionCount(slot0)
	for slot6, slot7 in ipairs(YaXianConfig.instance:getConditionList(slot0.episodeCo)) do
		if slot0:checkFinishCondition(slot7[1], slot7[2]) then
			slot2 = 0 + 1
		end
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
