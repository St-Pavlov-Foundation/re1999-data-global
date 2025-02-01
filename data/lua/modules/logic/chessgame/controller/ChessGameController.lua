module("modules.logic.chessgame.controller.ChessGameController", package.seeall)

slot0 = class("ChessGameController", BaseController)

function slot0.addConstEvents(slot0)
end

function slot0.initServerMap(slot0, slot1, slot2)
	slot3 = nil

	if slot2.episodeId and slot2.currMapIndex then
		slot4 = slot2.currMapIndex + 1

		ChessGameModel.instance:clear()
		slot0:checkShowEffect()
		ChessGameInteractModel.instance:clear()
		ChessGameModel.instance:initData(slot1, slot2.episodeId, slot4)
		ChessGameModel.instance:setNowMapIndex(slot4)
		ChessGameModel.instance:setCompletedCount(slot2.completedCount)

		slot3 = ChessConfig.instance:getEpisodeCo(slot1, slot2.episodeId).mapIds

		ChessGameConfig.instance:setCurrentMapGroupId(slot3)
		ChessGameNodeModel.instance:setNodeDatas(ChessGameConfig.instance:getMapCo(slot3)[slot4].nodes)

		if slot2.interact then
			ChessGameInteractModel.instance:setInteractDatas(slot2.interact, slot4)
		end
	end

	slot0:setClickStatus(ChessGameEnum.SelectPosStatus.None)

	slot0._selectObj = nil

	slot0:setSelectObj(nil)

	slot0.interactsMgr = slot0.interactsMgr or ChessInteractMgr.New()

	if not slot0:existGame() then
		slot0.interactsMgr:removeAll()
	end

	slot0:initObjects(slot2.currMapIndex + 1)

	slot0.eventMgr = slot0.eventMgr or ChessEventMgr.New()

	slot0.eventMgr:removeAll()
	slot0.eventMgr:setCurEvent(nil)

	slot0._isPlaying = true

	uv0.instance:dispatchEvent(ChessGameEvent.CurrentConditionUpdate)
end

function slot0.enterChessGame(slot0, slot1, slot2, slot3)
	logNormal("ChessGameController : enterChessGame!")

	slot0._viewName = slot3 or slot0._viewName

	ViewMgr.instance:openView(slot0._viewName, slot0:packViewParam())
	ChessGameModel.instance:clearRollbackNum()
	ChessStatController.instance:startStat()
end

function slot0.exitGame(slot0)
	ChessGameModel.instance:clear()
	ChessGameInteractModel.instance:clear()
	ChessGameNodeModel.instance:clear()
	ChessGameModel.instance:clearRollbackNum()
	slot0:abortGame()
	ChessGameJumpHandler["jump" .. 0] or ChessGameJumpHandler.defaultJump()
end

function slot0.reInit(slot0)
	slot0:release()
end

function slot0.release(slot0)
	if slot0.interactsMgr then
		slot0.interactsMgr:removeAll()
	end

	if slot0.eventMgr then
		slot0.eventMgr:removeAll()
	end

	slot0._treeComp = nil
	slot0.interactsMgr = nil
	slot0.eventMgr = nil
	slot0._isPlaying = false
end

function slot0.setViewName(slot0, slot1)
	if slot1 then
		slot0._viewName = slot1
	end
end

function slot0.getViewName(slot0)
	return slot0._viewName or ViewName.ChessGameScene
end

function slot0.packViewParam(slot0)
end

function slot0.deleteInteractObj(slot0, slot1)
	if not ChessGameInteractModel.instance:getInteractById(slot1) then
		return
	end

	ChessGameInteractModel.instance:deleteInteractById(slot1)
	slot0.interactsMgr:remove(slot1)
end

function slot0.addInteractObj(slot0, slot1)
	if uv0.instance.interactsMgr:get(slot1.id) and slot3:tryGetGameObject() then
		return
	end

	if ChessGameInteractModel.instance:addInteractMo(ChessGameConfig.instance:getInteractCoById(slot1.mapGroupId or ChessGameConfig.instance:getCurrentMapGroupId(), slot2), slot1):isShow() then
		slot8 = ChessInteractComp.New()

		slot8:init(ChessGameModel.instance:getNowMapIndex(), slot7)

		if slot8.config ~= nil then
			slot0.interactsMgr:add(slot8)
		end

		slot0:dispatchEvent(ChessGameEvent.AddInteractObj, slot8)
	end
end

function slot0.getSelectObj(slot0)
	return slot0._selectObj
end

function slot0.isNeedBlock(slot0)
	if slot0.eventMgr and slot0.eventMgr:isNeedBlock() then
		return true
	end

	return false
end

function slot0.initObjects(slot0, slot1)
	slot2 = ChessGameInteractModel.instance:getInteractsByMapIndex(slot1)

	if #slot0.interactsMgr:getList() > 0 then
		for slot7, slot8 in pairs(slot2) do
			if not slot0.interactsMgr:get(slot8.id) then
				slot0:addInteractObj(slot8)
			elseif slot9 and slot8:isShow() and not slot9:isShow() then
				slot0.interactsMgr:remove(slot8.id)
				slot0:addInteractObj(slot8)
			else
				slot9:updateComp(slot8)
			end
		end

		for slot7 = #slot3, 1, -1 do
			if not ChessGameInteractModel.instance:getInteractById(slot3[slot7].mo.id) or not slot9:isShow() then
				slot0.interactsMgr:hideCompById(slot8.mo.id)
				slot0.interactsMgr:remove(slot8.mo.id)
			end
		end
	else
		for slot7, slot8 in pairs(slot2) do
			slot9 = ChessInteractComp.New()

			slot9:init(slot1, slot8)

			if slot9.config ~= nil then
				slot0.interactsMgr:add(slot9)
			end
		end

		slot0:dispatchEvent(ChessGameEvent.AllObjectCreated)
	end
end

function slot0.setClickStatus(slot0, slot1)
	slot0._clickStatus = slot1
end

function slot0.getClickStatus(slot0)
	return slot0._clickStatus
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

function slot0.filterSelectable(slot0)
	return slot0.config and slot0.config.interactType == ChessGameEnum.InteractType.Role
end

function slot0.searchInteractByPos(slot0, slot1, slot2, slot3)
	slot5, slot6 = nil
	slot7 = 0

	for slot11, slot12 in ipairs(slot0.interactsMgr:getList()) do
		if slot12.mo.posX == slot1 and slot12.mo.posY == slot2 and slot12:isShow() and (not slot3 or slot3(slot12)) then
			if slot5 ~= nil then
				table.insert(slot6 or {
					slot5
				}, slot12)
			else
				slot5 = slot12
			end

			slot7 = slot7 + 1
		end
	end

	return slot7, slot6 or slot5
end

function slot0.sortSelectObj(slot0, slot1)
	return slot0:getSelectPriority() < slot1:getSelectPriority()
end

function slot0.autoSelectPlayer(slot0)
	if not slot0.interactsMgr then
		return
	end

	if not slot0.interactsMgr:getList() then
		return
	end

	slot2 = {}

	for slot6, slot7 in pairs(slot1) do
		if (slot7.config and slot7.config.interactType or nil) == ChessGameEnum.InteractType.Role then
			table.insert(slot2, slot7)
		end
	end

	table.sort(slot2, uv0.sortInteractObjById)

	if #slot2 > 0 then
		slot0:setSelectObj(slot2[1])
	end
end

function slot0.sortInteractObjById(slot0, slot1)
	if slot0.config.interactType ~= slot1.config.interactType then
		return slot2 < slot3
	end

	return slot0.id < slot1.id
end

function slot0.posCanWalk(slot0, slot1, slot2)
	slot3 = true

	if not ChessGameNodeModel.instance:getNode(slot1, slot2) then
		return false
	end

	if slot4.tileType == ChessGameEnum.TileBaseType.None then
		return false
	end

	return slot0:checkInteractCanWalk(slot1, slot2)
end

function slot0.checkInteractCanWalk(slot0, slot1, slot2)
	slot3, slot4 = slot0:searchInteractByPos(slot1, slot2)

	if not slot4 then
		return true
	end

	slot5 = nil
	slot6 = ChessGameModel.instance:getCatchObj()

	if slot3 > 1 then
		for slot10, slot11 in ipairs(slot4) do
			if not slot11.mo.walkable then
				return false
			end

			if slot6 then
				if slot5.interactType == ChessGameEnum.InteractType.Prey or slot5.interactType == ChessGameEnum.InteractType.Hunter then
					return false
				end

				if slot11:checkShowAvatar() then
					return false
				end
			end
		end
	else
		if not slot4.mo.walkable then
			return false
		end

		if slot6 then
			if slot5.interactType == ChessGameEnum.InteractType.Prey or slot5.interactType == ChessGameEnum.InteractType.Hunter then
				return false
			end

			if slot4:checkShowAvatar() then
				return false
			end
		end
	end

	return true
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
	if slot0.interactsMgr and slot0._tempSelectObjId and slot0.interactsMgr:get(slot0._tempSelectObjId) then
		slot0:setSelectObj(slot1)

		slot0._tempSelectObjId = nil

		return true
	end

	slot0:autoSelectPlayer(true)

	return false
end

function slot0.setCatchObj(slot0, slot1)
	slot0._catchObj = slot1
end

function slot0.getCatchObj(slot0)
	return slot0._catchObj
end

function slot0.forceRefreshObjSelectedView(slot0)
	if slot0._selectObj ~= nil then
		slot0._selectObj:onSelected()
	end
end

function slot0.setLoadingScene(slot0, slot1)
	slot0._isLoadingScene = slot1
end

function slot0.isLoadingScene(slot0)
	return slot0._isLoadingScene
end

function slot0.setSceneCamera(slot0, slot1)
	if slot1 then
		slot3 = CameraMgr.instance:getUnitCamera()
		slot3.orthographic = true
		slot3.orthographicSize = CameraMgr.instance:getMainCamera().orthographicSize

		gohelper.setActive(CameraMgr.instance:getUnitCameraGO(), true)
		gohelper.setActive(PostProcessingMgr.instance._unitPPVolume.gameObject, true)
		PostProcessingMgr.instance:setUnitActive(true)
		PostProcessingMgr.instance:setUnitPPValue("localBloomActive", false)
		PostProcessingMgr.instance:setUnitPPValue("bloomActive", false)
		PostProcessingMgr.instance:setUnitPPValue("dofFactor", 0)
	else
		CameraMgr.instance:getUnitCamera().orthographic = false

		gohelper.setActive(CameraMgr.instance:getUnitCameraGO(), false)
		PostProcessingMgr.instance:setUnitActive(false)
		PostProcessingMgr.instance:setUnitPPValue("localBloomActive", true)
		PostProcessingMgr.instance:setUnitPPValue("bloomActive", true)
	end
end

function slot0.existGame(slot0)
	return slot0._isPlaying
end

function slot0.abortGame(slot0)
	slot0._isPlaying = false
end

function slot0.gameOver(slot0)
	ChessGameModel.instance:setGameState(ChessGameEnum.GameState.Fail)
	ChessStatController.instance:statFail()

	slot0._isPlaying = false
end

function slot0.gameWin(slot0)
	ChessGameModel.instance:setGameState(ChessGameEnum.GameState.Win)
	ChessStatController.instance:statSuccess()

	slot0._isPlaying = false
end

function slot0.checkInteractCanUse(slot0, slot1, slot2)
	slot3 = nil

	for slot7 = 1, #slot1 do
		if slot0:getPosCanClickInteract(slot1[slot7], slot2[slot7]) then
			if slot10.mo:getEffectType() and slot11 ~= ChessGameEnum.GameEffectType.None then
				slot10.chessEffectObj:onAvatarFinish(slot11)
			end

			(slot3 or {})[slot10.mo.id] = slot10
		end
	end

	if not ChessGameInteractModel.instance:getShowEffects() then
		return
	end

	slot5 = {}

	for slot9, slot10 in pairs(slot4) do
		if slot3 then
			if not slot3[slot9] and slot10 and slot0.interactsMgr:get(slot9) then
				slot11.chessEffectObj:hideEffect()
			end
		elseif slot10 and slot0.interactsMgr:get(slot9) then
			slot11.chessEffectObj:hideEffect()
		end

		if ChessGameInteractModel.instance:getInteractById(slot9) and ChessGameInteractModel.instance:checkInteractFinish(slot11.id) and slot0.interactsMgr:get(slot9) then
			slot12.chessEffectObj:hideEffect()
		end
	end
end

function slot0.getPosCanClickInteract(slot0, slot1, slot2)
	slot3, slot4 = slot0:searchInteractByPos(slot1, slot2)
	slot5 = nil

	if slot3 > 1 then
		for slot9, slot10 in ipairs(slot4) do
			if slot10:checkShowAvatar() and slot10.config.touchTrigger then
				slot5 = slot10

				break
			end
		end
	else
		slot5 = slot4 and slot4:checkShowAvatar() and slot4.config.touchTrigger and slot4
	end

	return slot5
end

function slot0.checkShowEffect(slot0)
	if not ChessGameInteractModel.instance:getShowEffects() or not slot0.interactsMgr then
		return
	end

	for slot5, slot6 in pairs(slot1) do
		if slot0.interactsMgr:get(slot5) then
			slot7.chessEffectObj:hideEffect()
		end
	end
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
