module("modules.logic.versionactivity2_2.tianshinana.model.TianShiNaNaModel", package.seeall)

slot0 = class("TianShiNaNaModel", BaseModel)

function slot0.onInit(slot0)
	slot0.nowMapId = nil
	slot0._curState = TianShiNaNaEnum.CurState.None
	slot0.unitMos = {}
	slot0.nowScenePos = nil
	slot0.currEpisodeId = 0
	slot0._episodeStars = {}
	slot0.sceneLevelLoadFinish = false
	slot0.waitStartFlow = false
	slot0.waitClickJump = false
	slot0.statMo = nil
	slot0.curSelectIndex = 1
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.initInfo(slot0, slot1)
	slot2 = {
		[slot7.episodeId] = slot7.star
	}

	for slot6, slot7 in ipairs(slot1) do
		if slot7.passChessGame then
			-- Nothing
		end
	end

	for slot7 = 1, #TianShiNaNaConfig.instance:getEpisodeCoList(VersionActivity2_2Enum.ActivityId.TianShiNaNa) do
		if slot3[slot7].episodeType == 1 then
			slot8 = true

			if slot3[slot7].storyBefore > 0 then
				slot8 = StoryModel.instance:isStoryFinished(slot3[slot7].storyBefore)
			end

			slot0._episodeStars[slot7] = slot8 and 1 or 0
		else
			slot0._episodeStars[slot7] = slot2[slot3[slot7].id] or 0
		end
	end
end

function slot0.markEpisodeFinish(slot0, slot1, slot2)
	slot0.currEpisodeId = 0

	if slot0._episodeStars[slot1] ~= slot2 then
		slot0._episodeStars[slot1] = slot2

		TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.EpisodeStarChange, slot1, slot0._episodeStars[slot1], slot2)
	end

	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.EpisodeFinish)
end

function slot0.getEpisodeStar(slot0, slot1)
	return slot0._episodeStars[slot1] or 0
end

function slot0.getUnLockMaxIndex(slot0)
	slot1 = 0

	while slot0:getEpisodeStar(slot1 + 1) > 0 do
		slot1 = slot1 + 1
	end

	return slot1
end

function slot0.initDatas(slot0, slot1, slot2)
	slot0.statMo = TianShiNaNaStatMo.New()
	slot0._curState = TianShiNaNaEnum.CurState.None
	slot0.episodeCo = lua_activity167_episode.configDict[VersionActivity2_2Enum.ActivityId.TianShiNaNa][slot1]
	slot0.nowMapId = slot0.episodeCo.mapId
	slot0.unitMos = {}
	slot0.mapCo = TianShiNaNaConfig.instance:getMapCo(slot0.episodeCo.mapId)
	slot0.heroMo = nil
	slot0.nowRound = slot2.currentRound
	slot0.stepCount = slot2.stepCount

	for slot7, slot8 in ipairs(slot2.interact) do
		if slot3:getUnitCo(slot8.id) then
			slot11 = TianShiNaNaMapUnitMo.New()

			slot11:init(slot10)
			slot11:updatePos(slot8.x, slot8.y, slot8.direction)
			slot11:setActive(slot8.active)

			slot0.unitMos[slot10.id] = slot11

			if slot10.unitType == TianShiNaNaEnum.UnitType.Player then
				slot0.heroMo = slot11
			end
		else
			logError(string.format("天使娜娜地图 %d 元件 %d 不存在", slot0.nowMapId, slot9))
		end
	end

	slot0.remainCubeList = string.splitToNumber(slot0.episodeCo.cubeList, "#")
	slot0.totalRound = #slot0.remainCubeList

	if not slot0.heroMo then
		logError(string.format("天使娜娜地图 %d 角色元件不存在", slot0.nowMapId))
	end

	slot0.curOperList = {}
	slot0.curPointList = {}
	slot0.waitClickJump = false
end

function slot0.sendStat(slot0, slot1)
	if slot0.statMo then
		slot0.statMo:sendStatData(slot1)

		slot0.statMo = nil
	end
end

function slot0.isWaitClick(slot0)
	return slot0._curState == TianShiNaNaEnum.CurState.DoStep and slot0.waitClickJump
end

function slot0.resetScene(slot0, slot1, slot2)
	if slot0.statMo then
		if slot2 then
			slot0.statMo:sendStatData("重置")
			slot0.statMo:reset()
		else
			slot0.statMo:addBackNum()
		end
	else
		slot0.statMo = TianShiNaNaStatMo.New()
	end

	TianShiNaNaController.instance:clearFlow()

	slot0.waitClickJump = false
	slot0.nowRound = slot1.currentRound
	slot0.stepCount = slot1.stepCount
	slot3 = {
		[slot7] = true
	}

	for slot7 in pairs(slot0.unitMos) do
		-- Nothing
	end

	slot4 = slot0.mapCo

	for slot8, slot9 in ipairs(slot1.interact) do
		if slot3[slot9.id] then
			slot3[slot10] = nil
		end

		if slot0.unitMos[slot10] then
			slot11:updatePos(slot9.x, slot9.y, slot9.direction)
			slot11:setActive(slot9.active)

			if TianShiNaNaEntityMgr.instance:getEntity(slot10) then
				slot12:updatePosAndDir()
			end
		elseif slot4:getUnitCo(slot10) then
			slot11 = TianShiNaNaMapUnitMo.New()

			slot11:init(slot12)
			slot11:updatePos(slot9.x, slot9.y, slot9.direction)

			slot0.unitMos[slot12.id] = slot11

			if slot12.unitType == TianShiNaNaEnum.UnitType.Player then
				slot0.heroMo = slot11
			end
		else
			logError(string.format("天使娜娜地图 %d 元件 %d 不存在", slot0.nowMapId, slot10))
		end
	end

	for slot8 in pairs(slot3) do
		slot0:removeUnit(slot8)
	end

	slot0.curOperList = slot1.operations
	slot0.curPointList = {}

	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.CubePointUpdate)
end

function slot0.removeUnit(slot0, slot1)
	if slot0.unitMos[slot1] then
		TianShiNaNaEntityMgr.instance:removeEntity(slot1)

		slot0.unitMos[slot1] = nil
	end
end

function slot0.getNextCubeType(slot0)
	if not slot0.remainCubeList then
		return
	end

	return slot0.remainCubeList[slot0.nowRound + 1]
end

function slot0.setState(slot0, slot1)
	if slot1 ~= slot0._curState then
		TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.StatuChange, slot0._curState, slot1)

		slot0._curState = slot1
	end
end

function slot0.getState(slot0)
	return slot0._curState
end

function slot0.getHeroMo(slot0)
	return slot0.heroMo
end

function slot0.isNodeCanPlace(slot0, slot1, slot2, slot3)
	if not slot0.nowMapId then
		return false
	end

	for slot7, slot8 in pairs(slot0.unitMos) do
		if slot8:isPosEqual(slot1, slot2) and not slot8:canWalk() then
			return false
		end
	end

	if not slot0.mapCo:getNodeCo(slot1, slot2) or slot3 and slot4 and slot4.nodeType == TianShiNaNaEnum.NodeType.Swamp then
		return false
	end

	if not slot4.walkable then
		return false
	end

	if slot4:isCollapse() then
		return false
	end

	return true
end

slot0.instance = slot0.New()

return slot0
