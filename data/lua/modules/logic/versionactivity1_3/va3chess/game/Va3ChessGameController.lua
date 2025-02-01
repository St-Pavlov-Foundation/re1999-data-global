module("modules.logic.versionactivity1_3.va3chess.game.Va3ChessGameController", package.seeall)

slot0 = class("Va3ChessGameController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0._registerGameController(slot0)
	return {
		[Va3ChessEnum.ActivityId.Act122] = Activity1_3ChessGameController.instance
	}
end

function slot0._getActiviyXGameControllerIns(slot0, slot1)
	if not slot0._actXGameCtlInsMap then
		slot0._actXGameCtrlInsMap = slot0:_registerGameController()
	end

	return slot0._actXGameCtrlInsMap[slot1]
end

function slot0.release(slot0)
	if slot0.interacts then
		slot0.interacts:removeAll()
	end

	if slot0.event then
		slot0.event:removeAll()
	end

	slot0._treeComp = nil
	slot0.interacts = nil
	slot0.event = nil
	slot0._hasMap = false
end

function slot0.setViewName(slot0, slot1)
	if slot1 then
		slot0._viewName = slot1
	end
end

function slot0.getViewName(slot0)
	return slot0._viewName or ViewName.Va3ChessGameScene
end

function slot0.enterChessGame(slot0, slot1, slot2, slot3)
	logNormal("Va3ChessGameController : enterChessGame!")
	GuideController.instance:dispatchEvent(GuideEvent["OnChessEnter" .. Va3ChessModel.instance:getEpisodeId()])
	slot0:initData(slot1, slot2)

	slot0._viewName = slot3 or slot0._viewName

	ViewMgr.instance:openView(slot0._viewName, slot0:packViewParam())
end

function slot0.packViewParam(slot0)
	return {
		fromRefuseBattle = Va3ChessController.instance:getFromRefuseBattle()
	}
end

function slot0.initData(slot0, slot1, slot2)
	slot0._treeComp = Va3ChessGameTree.New()

	Va3ChessGameModel.instance:initData(slot1, slot2)

	slot0._tempSelectObjId = nil

	if Va3ChessConfig.instance:getMapCo(slot1, slot2) and not string.nilorempty(slot3.offset) then
		slot4 = string.splitToNumber(slot3.offset, ",")
		slot0._cacheOffsetX = slot4[1]
		slot0._cacheOffsetY = slot4[2]
	else
		slot0._cacheOffsetX = nil
		slot0._cacheOffsetY = nil
	end
end

function slot0.initServerMap(slot0, slot1, slot2)
	if slot2.mapId then
		Va3ChessGameModel.instance:initData(slot1, slot2.mapId)
	end

	Va3ChessGameModel.instance:setRound(slot2.currentRound)
	Va3ChessGameModel.instance:setHp(slot2.hp)
	Va3ChessGameModel.instance:setFinishedTargetNum(slot2.targetNum)
	Va3ChessGameModel.instance:setResult(nil)
	Va3ChessGameModel.instance:setFireBallCount(slot2.fireballNum)
	Va3ChessGameModel.instance:updateFinishInteracts(slot2.finishInteracts)
	Va3ChessGameModel.instance:updateAllFinishInteracts(slot2.allFinishInteracts)

	if slot2.fragileTilebases then
		Va3ChessGameModel.instance:updateFragileTilebases(slot1, slot2.fragileTilebases)
	end

	if slot2.brokenTilebases then
		Va3ChessGameModel.instance:updateBrokenTilebases(slot1, slot2.brokenTilebases)
	end

	slot0:setClickStatus(Va3ChessEnum.SelectPosStatus.None)

	slot0._selectObj = nil

	slot0:setSelectObj(nil)

	slot0.interacts = slot0.interacts or Va3ChessInteractMgr.New()

	slot0.interacts:removeAll()
	Va3ChessGameModel.instance:initObjects(slot1, slot2.interactObjects or slot2.id2Interact)

	if slot2.brazierIds then
		Va3ChessGameModel.instance:updateLightUpBrazier(slot1, slot2.brazierIds)
	end

	slot0:initObjects()

	slot0.event = slot0.event or Va3ChessEventMgr.New()

	slot0.event:removeAll()
	slot0.event:setCurEvent(slot2.currentEvent)
	slot0:onInitServerMap(slot1, slot2)

	slot0._hasMap = true
end

function slot0.isNeedBlock(slot0)
	if slot0.event and slot0.event:isNeedBlock() then
		return true
	end

	return false
end

function slot0.onInitServerMap(slot0, slot1, slot2)
	if slot0:_getActiviyXGameControllerIns(slot1) and slot3.onInitServerMap then
		slot3:onInitServerMap(slot2)
	end
end

function slot0.updateServerMap(slot0, slot1, slot2)
	if slot0:_getActiviyXGameControllerIns(slot1) and slot3.onUpdateServerMap then
		slot3:onUpdateServerMap(slot2)
	end
end

function slot0.initObjects(slot0)
	for slot5, slot6 in ipairs(Va3ChessGameModel.instance:getInteractDatas()) do
		slot7 = Va3ChessInteractObject.New()

		slot7:init(slot6)

		if slot7.config ~= nil then
			slot0.interacts:add(slot7)
		end
	end

	slot0:onInitObjects()

	for slot6, slot7 in ipairs(slot0.interacts:getList()) do
		slot7.goToObject:init()
	end

	slot0:dispatchEvent(Va3ChessEvent.AllObjectCreated)
end

function slot0.onInitObjects(slot0)
	if slot0:_getActiviyXGameControllerIns(Va3ChessModel.instance:getActId()) and slot2.onInitObjects then
		slot2:onInitObjects()
	end
end

function slot0.initSceneTree(slot0, slot1, slot2)
	slot0._treeSceneComp = Va3ChessGameTree.New()
	slot0._offsetSceneY = slot2
	slot3 = slot0._treeSceneComp:createLeaveNode()
	slot4, slot5 = Va3ChessGameModel.instance:getGameSize()

	for slot9 = 1, slot4 do
		for slot13 = 1, slot5 do
			slot14 = {
				y = slot18.y,
				x = slot18.x,
				tileY = slot13 - 1,
				tileX = slot9 - 1
			}
			slot15, slot16, slot17 = slot0:calcTilePosInScene(slot9 - 1, slot13 - 1)
			slot18 = recthelper.worldPosToAnchorPos(Vector3.New(slot15, slot16 + slot2, 0), slot1.transform)

			table.insert(slot3.nodes, slot14)

			slot3.keys = slot14
		end
	end

	slot0._treeSceneComp:growToBranch(slot3)
	slot0._treeSceneComp:buildTree(slot3)
end

function slot0.calcTilePosInScene(slot0, slot1, slot2, slot3, slot4)
	slot5 = Va3ChessEnum.TileShowSettings
	slot9 = (slot2 * slot5.height + slot5.offsetY * slot1 + slot5.offsetYX * (slot1 + slot2) + (slot0._cacheOffsetY or Va3ChessEnum.ChessBoardOffsetY)) * 0.01
	slot10 = 0
	slot11 = (slot3 or 0) * 0.001

	return (slot1 * slot5.width + slot5.offsetX * slot2 + slot5.offsetXY * (slot1 + slot2) + (slot0._cacheOffsetX or Va3ChessEnum.ChessBoardOffsetX)) * 0.01, slot9, slot4 and slot0:getPosZ(slot1, slot2) + slot11 or slot9 * 0.001 + slot11
end

function slot0.getPosZ(slot0, slot1, slot2)
	slot3, slot4 = Va3ChessGameModel.instance:getGameSize()

	return Mathf.Lerp(Va3ChessEnum.ScenePosZRange.Min, Va3ChessEnum.ScenePosZRange.Max, slot1 / slot3) + Mathf.Lerp(Va3ChessEnum.ScenePosZRange.Max, Va3ChessEnum.ScenePosZRange.Min, slot2 / slot4)
end

function slot0.getOffsetSceneY(slot0)
	return slot0._offsetSceneY
end

function slot0.addInteractObj(slot0, slot1)
	slot2 = Va3ChessInteractObject.New()

	slot2:init(slot1)
	slot0.interacts:add(slot2)
	slot2.goToObject:init()
	slot0:dispatchEvent(Va3ChessEvent.AddInteractObj, slot2)
end

function slot0.deleteInteractObj(slot0, slot1)
	slot0.interacts:remove(slot1)
	slot0:dispatchEvent(Va3ChessEvent.DeleteInteractObj, slot1)
end

function slot0.searchInteractByPos(slot0, slot1, slot2, slot3)
	slot7 = 0

	for slot11, slot12 in ipairs(slot0.interacts:getList()) do
		if slot12.originData.posX == slot1 and slot12.originData.posY == slot2 and (not slot3 or slot3(slot12)) then
			if slot5 ~= nil then
				table.insert(nil or {
					slot5
				}, slot12)
			else
				slot5 = slot12
			end

			slot7 = slot7 + 1
		end
	end

	if slot7 > 1 then
		table.sort(slot6, uv0.sortSelectObj)
	end

	return slot7, slot6 or slot5
end

function slot0.sortSelectObj(slot0, slot1)
	return slot0:getSelectPriority() < slot1:getSelectPriority()
end

function slot0.filterSelectable(slot0)
	return slot0.config and (slot0.config.interactType == Va3ChessEnum.InteractType.Player or slot0.config.interactType == Va3ChessEnum.InteractType.AssistPlayer)
end

function slot0.existGame(slot0)
	return slot0._hasMap
end

function slot0.setSelectObj(slot0, slot1)
	if slot0._selectObj == slot1 then
		return
	end

	if slot0._selectObj ~= nil then
		slot0._selectObj:onCancelSelect()
	end

	slot0._selectObj = slot1

	if slot1 ~= nil then
		slot1:onSelected()
	end
end

function slot0.forceRefreshObjSelectedView(slot0)
	if slot0._selectObj ~= nil then
		slot0._selectObj:onSelected()
	end
end

function slot0.saveTempSelectObj(slot0)
	if slot0._selectObj then
		slot0._tempSelectObjId = slot0._selectObj.id
	end
end

function slot0.isTempSelectObj(slot0, slot1)
	return slot0._tempSelectObjId == slot1
end

function slot0.tryResumeSelectObj(slot0)
	if slot0.interacts and slot0._tempSelectObjId and slot0.interacts:get(slot0._tempSelectObjId) then
		slot0:setSelectObj(slot1)

		slot0._tempSelectObjId = nil

		return true
	end

	slot0:autoSelectPlayer(true)

	return false
end

function slot0.refreshAllInteractKillEff(slot0)
	for slot5, slot6 in ipairs(slot0.interacts:getList()) do
		if slot6 and slot6.chessEffectObj and slot6.chessEffectObj.refreshKillEffect then
			slot6.chessEffectObj:refreshKillEffect()
		end
	end
end

function slot0.syncServerMap(slot0)
	slot2 = Va3ChessGameModel.instance:getMapId()
	slot0._tempInteractMgr = slot0.interacts
	slot0._tempEventMgr = slot0.event

	if Va3ChessGameModel.instance:getActId() and slot2 then
		slot0.interacts = nil
		slot0.event = nil

		Va3ChessGameModel.instance:release()
		Va3ChessGameModel.instance:initData(slot1, slot2)
		Va3ChessRpcController.instance:sendGetActInfoRequest(slot1, slot0.onReceiveWhenSync, slot0)
		slot0:dispatchEvent(Va3ChessEvent.ResetMapView)
	end
end

function slot0.onReceiveWhenSync(slot0, slot1, slot2)
	if slot2 ~= 0 then
		return
	end

	slot4 = Va3ChessGameModel.instance:getMapId()

	if Va3ChessGameModel.instance:getActId() and slot4 then
		if slot0._tempInteractMgr then
			slot0._tempInteractMgr:dispose()

			slot0._tempInteractMgr = nil
		end

		if slot0._tempEventMgr then
			slot0._tempEventMgr:removeAll()

			slot0._tempEventMgr = nil
		end

		slot0:initData(slot3, slot4)
		slot0:initObjects()
	end
end

function slot0.getSelectObj(slot0)
	return slot0._selectObj
end

function slot0.setClickStatus(slot0, slot1)
	slot0._clickStatus = slot1
end

function slot0.getClickStatus(slot0)
	return slot0._clickStatus
end

function slot0.autoSelectPlayer(slot0, slot1)
	if not slot0.interacts then
		return
	end

	if not slot0.interacts:getList() then
		return
	end

	slot3 = {}

	for slot7, slot8 in pairs(slot2) do
		slot9 = slot8.config and slot8.config.interactType or nil

		if slot9 == Va3ChessEnum.InteractType.Player or slot1 and slot9 == Va3ChessEnum.InteractType.AssistPlayer then
			table.insert(slot3, slot8)
		end
	end

	table.sort(slot3, uv0.sortInteractObjById)

	if #slot3 > 0 then
		slot0:setSelectObj(slot3[1])
	end
end

function slot0.sortInteractObjById(slot0, slot1)
	if slot0.config.interactType ~= slot1.config.interactType then
		return slot2 < slot3
	end

	return slot0.id < slot1.id
end

function slot0.gameClear(slot0)
	Va3ChessGameModel.instance:setResult(true)
	slot0:dispatchEvent(Va3ChessEvent.SetViewVictory)
	slot0:dispatchEvent(Va3ChessEvent.CurrentConditionUpdate)
end

function slot0.gameOver(slot0)
	Va3ChessGameModel.instance:setResult(false)
	slot0:dispatchEvent(Va3ChessEvent.SetViewFail)
	slot0:dispatchEvent(Va3ChessEvent.CurrentConditionUpdate)
end

function slot0.posCanWalk(slot0, slot1, slot2, slot3, slot4)
	if not Va3ChessGameModel.instance:isPosInChessBoard(slot1, slot2) then
		return false
	end

	if not Va3ChessGameModel.instance:getTileMO(slot1, slot2) or slot6.tileType == Va3ChessEnum.TileBaseType.None then
		return slot5
	end

	if not slot6:isFinishTrigger(Va3ChessEnum.TileTrigger.PoSui) and not slot6:isFinishTrigger(Va3ChessEnum.TileTrigger.Broken) and not slot0:isBaffleBlock(slot1, slot2, slot3) then
		slot5 = slot0:posObjCanWalk(slot1, slot2, slot3, slot4)
	end

	return slot5
end

function slot0.getPlayerNextCanWalkPosDict(slot0)
	if not (slot0.interacts and slot0.interacts:getMainPlayer(true) or nil) then
		return {}
	end

	slot3 = slot2.originData.posX
	slot4 = slot2.originData.posY

	for slot9, slot10 in ipairs({
		{
			x = slot3,
			y = slot4 + 1
		},
		{
			x = slot3,
			y = slot4 - 1
		},
		{
			x = slot3 - 1,
			y = slot4
		},
		{
			x = slot3 + 1,
			y = slot4
		}
	}) do
		if slot0:posCanWalk(slot10.x, slot10.y, Va3ChessMapUtils.ToDirection(slot3, slot4, slot10.x, slot10.y), slot2.objType) then
			slot1[Activity142Helper.getPosHashKey(slot10.x, slot10.y)] = true
		end
	end

	return slot1
end

function slot0.isBaffleBlock(slot0, slot1, slot2, slot3)
	slot4 = false
	slot5, slot6, slot7 = nil

	if slot3 == Va3ChessEnum.Direction.Down then
		slot5 = slot1
		slot6 = slot2 + 1
		slot7 = Va3ChessEnum.Direction.Up
	elseif slot3 == Va3ChessEnum.Direction.Left then
		slot5 = slot1 + 1
		slot6 = slot2
		slot7 = Va3ChessEnum.Direction.Right
	elseif slot3 == Va3ChessEnum.Direction.Right then
		slot5 = slot1 - 1
		slot6 = slot2
		slot7 = Va3ChessEnum.Direction.Left
	elseif slot3 == Va3ChessEnum.Direction.Up then
		slot5 = slot1
		slot6 = slot2 - 1
		slot7 = Va3ChessEnum.Direction.Down
	else
		logError(string.format("Va3ChessGameController:isBaffleBlock error, un support direction, x : %s, y : %s, direction : %s", slot1, slot2, slot3))

		return slot4
	end

	slot8 = true

	if Va3ChessGameModel.instance:getTileMO(slot5, slot6) then
		slot8 = slot9:isHasBaffleInDir(slot3)
	end

	slot10 = true

	if Va3ChessGameModel.instance:getTileMO(slot1, slot2) then
		slot10 = slot11:isHasBaffleInDir(slot7)
	end

	return slot8 or slot10
end

function slot0.posObjCanWalk(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6 = slot0:searchInteractByPos(slot1, slot2)

	if slot5 == 1 then
		if slot6 then
			if slot6:canBlock(slot3, slot4) then
				return false
			else
				slot6:showStateView(Va3ChessEnum.ObjState.Interoperable, {
					dir = slot3,
					objType = slot4
				})
			end
		end
	elseif slot5 > 1 then
		for slot10 = 1, slot5 do
			if slot6[slot10] then
				if slot6[slot10]:canBlock(slot3, slot4) then
					return false
				else
					slot6[slot10]:showStateView(Va3ChessEnum.ObjState.Interoperable, {
						dir = slot3,
						objType = slot4
					})
				end
			end
		end
	else
		return true
	end

	return true
end

function slot0.resetObjStateOnNewRound(slot0)
	for slot5, slot6 in ipairs(slot0.interacts:getList()) do
		slot6:showStateView(Va3ChessEnum.ObjState.Idle)
	end
end

function slot0.getNearestScenePos(slot0, slot1, slot2)
	if not slot0._treeSceneComp then
		return nil
	end

	slot4 = 99999999
	slot5 = nil
	slot6 = Va3ChessEnum.ClickYWeight

	if slot0._treeSceneComp:search(slot1, slot2) then
		for slot10 = 1, #slot3 do
			slot11 = slot3[slot10]
			slot13 = slot11.y - slot2

			if math.abs(slot11.x - slot1) <= Va3ChessEnum.ClickRangeX and math.abs(slot13) <= Va3ChessEnum.ClickRangeY and slot4 > slot12 * slot12 + slot13 * slot13 * slot6 then
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

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
