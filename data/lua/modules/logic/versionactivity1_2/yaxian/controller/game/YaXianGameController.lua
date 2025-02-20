module("modules.logic.versionactivity1_2.yaxian.controller.game.YaXianGameController", package.seeall)

slot0 = class("YaXianGameController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.release(slot0)
	if slot0.state then
		slot0.state:removeAll()
	end

	if slot0.stepMgr then
		slot0.stepMgr:removeAll()
		slot0.stepMgr:dispose()
	end

	slot0.interactItemList = nil
	slot0.state = nil
	slot0.stepMgr = nil
	slot0.searchTree = nil
	slot0.selectInteractObjId = nil
	slot0.clickStatus = YaXianGameEnum.SelectPosStatus.None
end

function slot0.enterChessGame(slot0, slot1)
	Activity115Rpc.instance:sendAct115StartEpisodeRequest(YaXianGameEnum.ActivityId, slot1, slot0._openGame, slot0)
end

function slot0._openGame(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	if YaXianGameModel.instance:getInteractMo(YaXianGameEnum.BossInteractId) then
		slot4:setXY(YaXianGameEnum.FakeBossStartPos.posX, YaXianGameEnum.FakeBossStartPos.posY)
		slot4:setDirection(YaXianGameEnum.FakeBossDirection)
		YaXianGameModel.instance:setNeedFeatureInteractMo(slot4)
	else
		YaXianGameModel.instance:clearFeatureInteract()
	end

	Stat1_2Controller.instance:yaXianStatStart()
	ViewMgr.instance:openView(ViewName.YaXianGameView)
end

function slot0.initMapByMapMsg(slot0, slot1, slot2)
	YaXianGameModel.instance:release()
	YaXianGameModel.instance:initLocalConfig(slot1, slot2.id)
	YaXianGameModel.instance:initServerDataByServerData(slot2)
	slot0:setSelectObj()

	slot0.state = slot0.state or YaXianStateMgr.New()

	slot0.state:removeAll()
	slot0.state:setCurEvent(slot2.currentEvent)

	slot0.stepMgr = slot0.stepMgr or YaXianStepMgr.New()

	slot0.stepMgr:disposeAllStep()
end

function slot0.initMapByMapMo(slot0, slot1)
	YaXianGameModel.instance:release()
	YaXianGameModel.instance:initLocalConfig(slot1.actId, slot1.episodeId)
	YaXianGameModel.instance:initServerDataByMapMo(slot1)
	slot0:setSelectObj()

	slot0.state = slot0.state or YaXianStateMgr.New()

	slot0.state:removeAll()
	slot0.state:setCurEvent(slot1.currentEvent)

	slot0.stepMgr = slot0.stepMgr or YaXianStepMgr.New()

	slot0.stepMgr:disposeAllStep()
end

function slot0.setInteractItemList(slot0, slot1)
	slot0.interactItemList = slot1
end

function slot0.setPlayerInteractItem(slot0, slot1)
	slot0.playerInteractItem = slot1
end

function slot0.getInteractItemList(slot0)
	return slot0.interactItemList
end

function slot0.getInteractItem(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.interactItemList) do
		if slot6.id == slot1 then
			return slot6
		end
	end
end

function slot0.getPlayerInteractItem(slot0)
	return slot0.playerInteractItem
end

function slot0.getSelectedInteractItem(slot0)
	return slot0:getInteractItem(slot0.selectInteractObjId)
end

function slot0.initSceneTree(slot0, slot1, slot2)
	slot0.searchTree = YaXianGameTree.New()
	slot3 = slot0.searchTree:createLeaveNode()
	slot4, slot5 = YaXianGameModel.instance:getGameSize()

	for slot9 = 1, slot4 do
		for slot13 = 1, slot5 do
			slot14 = {
				y = slot18.y,
				x = slot18.x,
				tileY = slot13 - 1,
				tileX = slot9 - 1
			}
			slot15, slot16, slot17 = YaXianGameHelper.calcTilePosInScene(slot9 - 1, slot13 - 1)
			slot18 = recthelper.worldPosToAnchorPos(Vector3.New(slot15, slot16 + slot2, 0), slot1.transform)

			table.insert(slot3.nodes, slot14)

			slot3.keys = slot14
		end
	end

	slot0.searchTree:growToBranch(slot3)
	slot0.searchTree:buildTree(slot3)
end

function slot0.searchInteractByPos(slot0, slot1, slot2, slot3)
	slot5 = {}

	for slot9, slot10 in ipairs(YaXianGameModel.instance:getInteractMoList()) do
		if slot10.posX == slot1 and slot10.posY == slot2 and (not slot3 or slot3(slot10.config)) then
			table.insert(slot5, slot10)
		end
	end

	if #slot5 > 1 then
		table.sort(slot5, slot0.sortSelectObj)
	end

	return slot5
end

function slot0.sortSelectObj(slot0, slot1)
	return (YaXianGameEnum.InteractSelectPriority[slot0.config.interactType] or slot0.id) < (YaXianGameEnum.InteractSelectPriority[slot1.config.interactType] or slot1.id)
end

function slot0.updateAllPosInteractActive(slot0)
	slot1 = {}
	slot4 = YaXianGameModel.instance
	slot6 = slot4

	for slot5, slot6 in ipairs(slot4.getInteractMoList(slot6)) do
		if not slot1[YaXianGameHelper.getPosHashKey(slot6.posX, slot6.posY)] then
			slot0:updatePosInteractActive(slot6.posX, slot6.posY)

			slot1[slot7] = true
		end
	end
end

function slot0.updatePosInteractActive(slot0, slot1, slot2)
	if #slot0:searchInteractByPos(slot1, slot2) < 1 then
		return
	end

	if #slot3 == 1 then
		slot0:getInteractItem(slot3[1].id):updateActiveByShowPriority(YaXianGameEnum.MinShowPriority)

		return
	end

	slot4 = YaXianGameEnum.MinShowPriority
	slot5 = {}

	for slot9, slot10 in ipairs(slot3) do
		table.insert(slot5, slot0:getInteractItem(slot10.id))
	end

	for slot9, slot10 in ipairs(slot5) do
		if slot4 < slot10:getShowPriority() then
			slot4 = slot10:getShowPriority()
		end
	end

	for slot9, slot10 in ipairs(slot5) do
		slot10:updateActiveByShowPriority(slot4)
	end
end

function slot0.setSelectObj(slot0, slot1)
	if slot0.selectInteractObjId and slot0.selectInteractObjId ~= slot1 then
		slot0:dispatchEvent(YaXianEvent.OnCancelSelectInteract, slot0.selectInteractObjId)
	end

	slot0.selectInteractObjId = slot1

	if slot1 ~= nil and slot1 ~= 0 then
		slot0:dispatchEvent(YaXianEvent.OnSelectInteract, slot0.selectInteractObjId)
	end
end

function slot0.getSelectInteractId(slot0)
	return slot0.selectInteractObjId
end

function slot0.isSelectingPlayer(slot0)
	return slot0.selectInteractObjId and slot0.selectInteractObjId == YaXianGameModel.instance:getPlayerInteractMo().id
end

function slot0.autoSelectPlayer(slot0)
	slot0:setSelectObj(YaXianGameModel.instance:getPlayerInteractMo().id)
end

function slot0.sortInteractObjById(slot0, slot1)
	return slot0.id < slot1.id
end

function slot0.gameVictory(slot0)
	YaXianGameModel.instance:setResult(true)
	Stat1_2Controller.instance:yaXianStatEnd(StatEnum.Result.Success)
	slot0:dispatchEvent(YaXianEvent.OnGameVictory)
end

function slot0.gameOver(slot0)
	YaXianGameModel.instance:setResult(false)
	Stat1_2Controller.instance:yaXianStatEnd(StatEnum.Result.Fail)
	slot0:dispatchEvent(YaXianEvent.OnGameFail)
end

function slot0.posCanWalk(slot0, slot1, slot2)
	if YaXianGameModel.instance:isPosInChessBoard(slot1, slot2) and YaXianGameModel.instance:getBaseTile(slot1, slot2) ~= YaXianGameEnum.TileBaseType.None then
		return slot0:posObjCanWalk(slot1, slot2)
	end

	return false
end

function slot0.posObjCanWalk(slot0, slot1, slot2)
	slot7 = slot2

	for slot7, slot8 in ipairs(slot0:searchInteractByPos(slot1, slot7)) do
		if YaXianGameHelper.canBlock(slot8.config) then
			return false
		end
	end

	return true
end

function slot0.getMoveTargetPos(slot0, slot1)
	slot2 = slot1.posX
	slot3 = slot1.posY
	slot4 = slot1.moveDirection
	slot5 = slot1.throughDistance
	slot6 = slot1.isHide
	slot8 = slot1.lastCanWalkPosX
	slot9 = slot1.lastCanWalkPosY
	slot11 = slot1.level and slot1.level + 1 or 1

	if slot1.usedThrough and not slot1.isBafflePos and slot0:posObjCanWalk(slot2, slot3) then
		return slot2, slot3, slot10
	end

	slot8 = slot8 or slot2
	slot9 = slot9 or slot3

	if slot11 > 1 and not slot6 and YaXianGameModel.instance:isAlertArea(slot8, slot9) then
		return slot8, slot9, slot10
	end

	if YaXianGameModel.instance:hasInteract(slot8, slot9) then
		return slot8, slot9, slot10
	end

	slot12, slot13, slot14, slot15 = nil

	if slot4 == YaXianGameEnum.MoveDirection.Bottom then
		slot12 = slot2
		slot13 = slot3 - 1
		slot14 = YaXianGameEnum.BaffleDirectionPowerPos.Bottom
		slot15 = YaXianGameEnum.BaffleDirectionPowerPos.Top
	elseif slot4 == YaXianGameEnum.MoveDirection.Left then
		slot12 = slot2 - 1
		slot13 = slot3
		slot14 = YaXianGameEnum.BaffleDirectionPowerPos.Left
		slot15 = YaXianGameEnum.BaffleDirectionPowerPos.Right
	elseif slot4 == YaXianGameEnum.MoveDirection.Right then
		slot12 = slot2 + 1
		slot13 = slot3
		slot14 = YaXianGameEnum.BaffleDirectionPowerPos.Right
		slot15 = YaXianGameEnum.BaffleDirectionPowerPos.Left
	elseif slot4 == YaXianGameEnum.MoveDirection.Top then
		slot12 = slot2
		slot13 = slot3 + 1
		slot14 = YaXianGameEnum.BaffleDirectionPowerPos.Top
		slot15 = YaXianGameEnum.BaffleDirectionPowerPos.Bottom
	else
		logError(string.format("un support direction, x : %s, y : %s, direction : %s", slot2, slot3, slot4))

		return slot8, slot9, slot10
	end

	if not YaXianGameModel.instance:isPosInChessBoard(slot12, slot13) then
		return slot8, slot9, slot10
	end

	if YaXianGameModel.instance:getBaseTile(slot12, slot13) == 0 then
		return slot8, slot9, slot10
	end

	if slot7 then
		if slot0:posObjCanWalk(slot12, slot13) then
			return slot12, slot13, slot10
		else
			return slot0:getMoveTargetPos({
				isBafflePos = false,
				posX = slot12,
				posY = slot13,
				moveDirection = slot4,
				throughDistance = slot5 - 1,
				isHide = slot6,
				lastCanWalkPosX = slot8,
				lastCanWalkPosY = slot9,
				usedThrough = slot10,
				level = slot11
			})
		end
	end

	if YaXianGameHelper.hasBaffle(YaXianGameModel.instance:getBaseTile(slot2, slot3), slot14) or YaXianGameHelper.hasBaffle(YaXianGameModel.instance:getBaseTile(slot12, slot13), slot15) then
		if slot5 <= 0 then
			return slot8, slot9, slot10
		else
			return slot0:getMoveTargetPos({
				isBafflePos = true,
				usedThrough = true,
				posX = slot2,
				posY = slot3,
				moveDirection = slot4,
				throughDistance = slot5 - 1,
				isHide = slot6,
				lastCanWalkPosX = slot8,
				lastCanWalkPosY = slot9,
				level = slot11
			})
		end
	elseif slot0:posObjCanWalk(slot12, slot13) then
		return slot0:getMoveTargetPos({
			isBafflePos = false,
			posX = slot12,
			posY = slot13,
			moveDirection = slot4,
			throughDistance = slot5,
			isHide = slot6,
			usedThrough = slot10,
			level = slot11
		})
	elseif slot5 <= 0 then
		return slot8, slot9, slot10
	else
		return slot0:getMoveTargetPos({
			isBafflePos = false,
			usedThrough = true,
			posX = slot12,
			posY = slot13,
			moveDirection = slot4,
			throughDistance = slot5 - 1,
			isHide = slot6,
			lastCanWalkPosX = slot8,
			lastCanWalkPosY = slot9,
			level = slot11
		})
	end
end

function slot0.getNearestScenePos(slot0, slot1, slot2)
	if not slot0.searchTree then
		return nil
	end

	slot4 = 99999999
	slot5 = nil
	slot6 = YaXianGameEnum.ClickYWeight

	if slot0.searchTree:search(slot1, slot2) then
		for slot10 = 1, #slot3 do
			slot11 = slot3[slot10]
			slot13 = slot11.y - slot2

			if math.abs(slot11.x - slot1) <= YaXianGameEnum.ClickRangeX and math.abs(slot13) <= YaXianGameEnum.ClickRangeY and slot4 > slot12 * slot12 + slot13 * slot13 * slot6 then
				slot5 = slot11
				slot4 = slot14
			end
		end
	end

	if slot5 then
		return slot5.tileX, slot5.tileY
	else
		return nil
	end
end

function slot0.getInteractStatusPool(slot0)
	if not slot0.interactStatusPool then
		slot0.interactStatusPool = LuaObjPool.New(16, YaXianGameStatusMo.NewFunc, YaXianGameStatusMo.releaseFunc, YaXianGameStatusMo.resetFunc)
	end

	return slot0.interactStatusPool
end

function slot0.stopRunningStep(slot0)
	if slot0.stepMgr then
		slot0.stepMgr:disposeAllStep()
	end
end

function slot0.playEffectAudio(slot0, slot1)
	if not slot1 or slot1 == 0 then
		return
	end

	slot0.lastPlayTimeDict = slot0.lastPlayTimeDict or {}
	slot3 = Time.realtimeSinceStartup

	if not slot0.lastPlayTimeDict[slot1] or YaXianGameEnum.EffectInterval <= slot3 - slot2 then
		AudioMgr.instance:trigger(slot1)

		slot0.lastPlayTimeDict[slot1] = slot3
	end
end

slot0.instance = slot0.New()

return slot0
