module("modules.logic.activity.controller.chessmap.ActivityChessGameController", package.seeall)

slot0 = class("ActivityChessGameController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
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

function slot0.enterChessGame(slot0, slot1, slot2)
	logNormal("ActivityChessGameController : enterChessGame!")
	GuideController.instance:dispatchEvent(GuideEvent["OnChessEnter" .. Activity109ChessModel.instance:getEpisodeId()])
	slot0:initData(slot1, slot2)
	ViewMgr.instance:openView(ViewName.ActivityChessGame, slot0:packViewParam())
	Activity109ChessController.instance:statStart()
end

function slot0.packViewParam(slot0)
	return {
		fromRefuseBattle = Activity109ChessController.instance:getFromRefuseBattle()
	}
end

function slot0.initData(slot0, slot1, slot2)
	slot0._treeComp = ActivityChessGameTree.New()

	ActivityChessGameModel.instance:initData(slot1, slot2)

	slot0._tempSelectObjId = nil

	if Activity109Config.instance:getMapCo(slot1, slot2) and not string.nilorempty(slot3.offset) then
		slot4 = string.splitToNumber(slot3.offset, ",")
		slot0._cacheOffsetX = slot4[1]
		slot0._cacheOffsetY = slot4[2]
	else
		slot0._cacheOffsetX = nil
		slot0._cacheOffsetY = nil
	end
end

function slot0.initServerMap(slot0, slot1, slot2)
	slot0:setClickStatus(ActivityChessEnum.SelectPosStatus.None)
	slot0:setSelectObj(nil)

	slot0.interacts = slot0.interacts or ActivityChessInteractMgr.New()

	slot0.interacts:removeAll()
	ActivityChessGameModel.instance:initObjects(slot1, slot2.interactObjects)
	slot0:initObjects()

	slot0.event = slot0.event or ActivityChessEventMgr.New()

	slot0.event:removeAll()
	slot0.event:setCurEvent(slot2.currentEvent)
	ActivityChessGameModel.instance:setRound(slot2.currentRound)
	ActivityChessGameModel.instance:setResult(nil)
	ActivityChessGameModel.instance:updateFinishInteracts(slot2.finishInteracts)

	slot0._hasMap = true
end

function slot0.initObjects(slot0)
	for slot5, slot6 in ipairs(ActivityChessGameModel.instance:getInteractDatas()) do
		slot7 = ActivityChessInteractObject.New()

		slot7:init(slot6)

		if slot7.config ~= nil then
			slot0.interacts:add(slot7)
		end
	end

	for slot6, slot7 in ipairs(slot0.interacts:getList()) do
		slot7.goToObject:init()
	end

	slot0:dispatchEvent(ActivityChessEvent.AllObjectCreated)
end

function slot0.initSceneTree(slot0, slot1, slot2)
	slot0._treeSceneComp = ActivityChessGameTree.New()
	slot0._offsetSceneY = slot2
	slot3 = slot0._treeSceneComp:createLeaveNode()
	slot4, slot5 = ActivityChessGameModel.instance:getGameSize()

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

function slot0.calcTilePosInScene(slot0, slot1, slot2, slot3)
	slot4 = ActivityChessEnum.TileShowSettings
	slot5, slot6 = nil

	if not slot0._cacheOffsetX then
		slot6 = slot2 * slot4.height + slot4.offsetY * slot1 + slot4.offsetYX * (slot1 + slot2) + ActivityChessEnum.ChessBoardOffsetY
		slot5 = slot1 * slot4.width + slot4.offsetX * slot2 + slot4.offsetXY * (slot1 + slot2) + ActivityChessEnum.ChessBoardOffsetX
	else
		slot6 = slot2 * slot4.height + slot4.offsetY * slot1 + slot4.offsetYX * (slot1 + slot2) + slot0._cacheOffsetY
		slot5 = slot1 * slot4.width + slot4.offsetX * slot2 + slot4.offsetXY * (slot1 + slot2) + slot0._cacheOffsetX
	end

	return slot5 * 0.01, slot6 * 0.01, slot6 * 0.001 + (slot3 or 0) * 1e-06
end

function slot0.getOffsetSceneY(slot0)
	return slot0._offsetSceneY
end

function slot0.addInteractObj(slot0, slot1)
	slot2 = ActivityChessInteractObject.New()

	slot2:init(slot1)
	slot0.interacts:add(slot2)
	slot2.goToObject:init()
	slot0:dispatchEvent(ActivityChessEvent.InteractObjectCreated, slot2)
end

function slot0.deleteInteractObj(slot0, slot1)
	slot0.interacts:remove(slot1)
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
	return slot0.config and slot0.config.interactType == ActivityChessEnum.InteractType.Player
end

function slot0.existGame(slot0)
	return slot0._hasMap
end

function slot0.setSelectObj(slot0, slot1)
	if slot0._selectObj == slot1 then
		return
	end

	if slot0._selectObj ~= nil and slot0._selectObj:getHandler() then
		slot0._selectObj:getHandler():onCancelSelect()
	end

	slot0._selectObj = slot1

	if slot1 ~= nil and slot0._selectObj:getHandler() then
		slot1:getHandler():onSelectCall()
	end
end

function slot0.saveTempSelectObj(slot0)
	if slot0._selectObj then
		slot0._tempSelectObjId = slot0._selectObj.id
	end
end

function slot0.tryResumeSelectObj(slot0)
	if slot0.interacts and slot0._tempSelectObjId and slot0.interacts:get(slot0._tempSelectObjId) then
		slot0:setSelectObj(slot1)

		slot0._tempSelectObjId = nil

		return true
	end

	return false
end

function slot0.syncServerMap(slot0)
	slot2 = ActivityChessGameModel.instance:getMapId()
	slot0._tempInteractMgr = slot0.interacts
	slot0._tempEventMgr = slot0.event

	if ActivityChessGameModel.instance:getActId() and slot2 then
		slot0.interacts = nil
		slot0.event = nil

		ActivityChessGameModel.instance:release()
		ActivityChessGameModel.instance:initData(slot1, slot2)
		Activity109Rpc.instance:sendGetAct109InfoRequest(slot1, slot0.onReceiveWhenSync, slot0)
		slot0:dispatchEvent(ActivityChessEvent.ResetMapView)
	end
end

function slot0.onReceiveWhenSync(slot0, slot1, slot2)
	if slot2 ~= 0 then
		return
	end

	slot4 = ActivityChessGameModel.instance:getMapId()

	if ActivityChessGameModel.instance:getActId() and slot4 then
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

function slot0.autoSelectPlayer(slot0)
	if not slot0.interacts then
		return
	end

	if slot0.interacts:getList() then
		slot2 = {}

		for slot6, slot7 in pairs(slot1) do
			if slot7.config and slot7.config.interactType == ActivityChessEnum.InteractType.Player then
				table.insert(slot2, slot7)
			end
		end

		table.sort(slot2, uv0.sortInteractObjById)

		if #slot2 > 0 then
			slot0:setSelectObj(slot2[1])
		end
	end
end

function slot0.sortInteractObjById(slot0, slot1)
	return slot0.id < slot1.id
end

function slot0.gameClear(slot0)
	ActivityChessGameModel.instance:setResult(true)
	slot0:dispatchEvent(ActivityChessEvent.SetViewVictory)
	slot0:dispatchEvent(ActivityChessEvent.CurrentConditionUpdate)
end

function slot0.gameOver(slot0)
	ActivityChessGameModel.instance:setResult(false)
	slot0:dispatchEvent(ActivityChessEvent.SetViewFail)
	slot0:dispatchEvent(ActivityChessEvent.CurrentConditionUpdate)
end

function slot0.checkInActivityDuration(slot0)
	if ActivityModel.instance:getActMO(ActivityChessGameModel.instance:getActId()) ~= nil and ActivityModel.instance:isActOnLine(slot1) and slot2:isOpen() and not slot2:isExpired() then
		return true
	end

	slot0:closeViewFromActivityExpired()

	return false
end

function slot0.closeViewFromActivityExpired(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, function ()
		ViewMgr.instance:closeView(ViewName.ActivityChessGame)
		ViewMgr.instance:closeView(ViewName.Activity109ChessEntry)
	end)
end

function slot0.posCanWalk(slot0, slot1, slot2)
	if ActivityChessGameModel.instance:isPosInChessBoard(slot1, slot2) and ActivityChessGameModel.instance:getBaseTile(slot1, slot2) ~= ActivityChessEnum.TileBaseType.None then
		return slot0:posObjCanWalk(slot1, slot2)
	end

	return false
end

function slot0.posObjCanWalk(slot0, slot1, slot2)
	slot3, slot4 = slot0:searchInteractByPos(slot1, slot2)

	if slot3 == 1 then
		if slot4 and slot4:canBlock() then
			return false
		end
	elseif slot3 > 1 then
		for slot8 = 1, slot3 do
			if slot4[slot8] and slot4[slot8]:canBlock() then
				return false
			end
		end
	else
		return true
	end

	return true
end

function slot0.getNearestScenePos(slot0, slot1, slot2)
	if not slot0._treeSceneComp then
		return nil
	end

	slot4 = 99999999
	slot5 = nil
	slot6 = ActivityChessEnum.ClickYWeight

	if slot0._treeSceneComp:search(slot1, slot2) then
		for slot10 = 1, #slot3 do
			slot11 = slot3[slot10]
			slot13 = slot11.y - slot2

			if math.abs(slot11.x - slot1) <= ActivityChessEnum.ClickRangeX and math.abs(slot13) <= ActivityChessEnum.ClickRangeY and slot4 > slot12 * slot12 + slot13 * slot13 * slot6 then
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
