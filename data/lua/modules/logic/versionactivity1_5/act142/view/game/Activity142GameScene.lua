module("modules.logic.versionactivity1_5.act142.view.game.Activity142GameScene", package.seeall)

slot0 = class("Activity142GameScene", Va3ChessGameScene)

function slot0._editableInitView(slot0)
	slot0._baffleItems = {}
	slot0._baffleItemPools = {}

	uv0.super._editableInitView(slot0)
end

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.TileTriggerUpdate, slot0._onTileTriggerUpdate, slot0)
	slot0:addEventCb(Activity142Controller.instance, Activity142Event.Back2CheckPoint, slot0._onMapChange, slot0)
	slot0:addEventCb(Activity142Controller.instance, Activity142Event.PlaySwitchPlayerEff, slot0.playSwitchPlayerEff, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.EnterNextMap, slot0._onMapChange, slot0)
end

function slot0.removeEvents(slot0)
	uv0.super.removeEvents(slot0)
	slot0:removeEventCb(Va3ChessGameController.instance, Va3ChessEvent.TileTriggerUpdate, slot0._onTileTriggerUpdate, slot0)
	slot0:removeEventCb(Activity142Controller.instance, Activity142Event.Back2CheckPoint, slot0._onMapChange, slot0)
	slot0:removeEventCb(Activity142Controller.instance, Activity142Event.PlaySwitchPlayerEff, slot0.playSwitchPlayerEff, slot0)
	slot0:removeEventCb(Va3ChessGameController.instance, Va3ChessEvent.EnterNextMap, slot0._onMapChange, slot0)
end

function slot0._onTileTriggerUpdate(slot0, slot1, slot2, slot3)
	if not Va3ChessGameModel.instance:getTileMO(slot1, slot2) or not slot4:isHasTrigger(slot3) then
		return
	end

	if slot3 == Va3ChessEnum.TileTrigger.Broken then
		slot0:updateBrokenTile(slot0:getBaseTile(slot1, slot2), slot4, true)
	end
end

function slot0._onMapChange(slot0)
	slot0:resetTiles()
	slot0:resetBaffle()
	Va3ChessGameController.instance:setSelectObj(nil)
	Va3ChessGameController.instance:autoSelectPlayer(true)
end

function slot0.onResetMapView(slot0)
	slot0:resetBaffle()
	uv0.super.onResetMapView(slot0)
end

function slot0.onResetGame(slot0)
	slot0:resetBaffle()
	uv0.super.onResetGame(slot0)
end

function slot0.onLoadRes(slot0)
	for slot5, slot6 in ipairs(slot0:_getGroundItemUrlList()) do
		slot0._loader:addPath(slot6)
	end

	slot0._loader:addPath(Activity142Enum.BrokenGroundItemPath)
	slot0._loader:addPath(Activity142Enum.SwitchPlayerEffPath)
end

function slot0._getGroundItemUrlList(slot0)
	if not Activity142Config.instance:getGroundItemUrlList(Va3ChessGameModel.instance:getActId(), Va3ChessGameModel.instance:getMapId()) or #slot3 < 0 then
		slot3 = {
			Va3ChessEnum.SceneResPath.GroundItem
		}
	end

	return slot3
end

function slot0.getGroundItemUrl(slot0, slot1, slot2)
	slot3 = nil
	slot4 = slot0:_getGroundItemUrlList()

	if slot1 and slot2 and Va3ChessGameModel.instance:getTileMO(slot1, slot2) and slot5:isHasTrigger(Va3ChessEnum.TileTrigger.Broken) then
		slot3 = Activity142Enum.BrokenGroundItemPath
	end

	if string.nilorempty(slot3) then
		slot3 = slot4[math.random(1, #slot4)]
	end

	return slot3
end

function slot0.onTileItemCreate(slot0, slot1, slot2, slot3)
	slot3.animator = slot3.go:GetComponent(Va3ChessEnum.ComponentType.Animator)

	slot0:updateBrokenTile(slot3, Va3ChessGameModel.instance:getTileMO(slot1, slot2))
end

slot2 = {
	{
		idle = "xianjing_b",
		tween = "xianjing_b"
	},
	{
		idle = "xianjing_c",
		tween = "BtoC"
	},
	{
		idle = "xianjing_d",
		tween = "CtoD"
	}
}

function slot0.updateBrokenTile(slot0, slot1, slot2, slot3)
	if not slot1 or not slot2 or not slot2:isHasTrigger(Va3ChessEnum.TileTrigger.Broken) then
		return
	end

	if not uv0[slot2:getTriggerBrokenStatus()] then
		return
	end

	slot7 = nil

	if (not slot3 or slot6.tween) and slot6.idle and slot1.animator then
		slot1.animator:Play(slot7, 0, 0)

		if slot7 == uv1 then
			AudioMgr.instance:trigger(AudioEnum.chess_activity142.TileBroken)
		end
	end
end

function slot0.onloadResCompleted(slot0, slot1)
	slot0:createAllBaffleObj()
end

function slot0.createAllBaffleObj(slot0)
	for slot4, slot5 in pairs(slot0._baseTiles) do
		for slot9, slot10 in pairs(slot5) do
			if Va3ChessGameModel.instance:getTileMO(slot4 - 1, slot9 - 1):getBaffleDataList() and #slot12 >= 0 then
				slot0:createBaffleItem(slot4 - 1, slot9 - 1, slot12)
			end
		end
	end
end

function slot0.createBaffleItem(slot0, slot1, slot2, slot3)
	if not slot3 or #slot3 <= 0 then
		return
	end

	for slot7, slot8 in ipairs(slot3) do
		slot9 = nil

		if Activity142Helper.getBaffleResPath(slot8) and (slot0._baffleItemPools[slot10] and #slot11 or 0) > 0 then
			slot9 = slot11[slot12]
			slot11[slot12] = nil
		end

		if not slot9 then
			Activity142BaffleObject.New(slot0._sceneContainer.transform):init()
		end

		slot8.x = slot1
		slot8.y = slot2

		slot9:updatePos(slot8)
		table.insert(slot0._baffleItems, slot9)
	end
end

function slot0.resetBaffle(slot0)
	slot0:recycleAllBaffleItem()
	slot0:createAllBaffleObj()
end

function slot0.recycleAllBaffleItem(slot0)
	slot1 = nil

	for slot5 = 1, #slot0._baffleItems do
		slot1 = slot0._baffleItems[slot5]

		slot1:recycle()

		if slot1:getBaffleResPath() then
			if not slot0._baffleItemPools[slot6] then
				slot0._baffleItemPools[slot6] = {}
			end

			table.insert(slot7, slot1)
		else
			slot1:dispose()
		end

		slot0._baffleItems[slot5] = nil
	end
end

function slot0.playSwitchPlayerEff(slot0, slot1, slot2)
	if gohelper.isNil(slot0:getSwitchEffGO()) or not slot1 or not slot2 then
		return
	end

	Activity142Helper.setAct142UIBlock(true, Activity142Enum.SWITCH_PLAYER)

	slot4, slot5, slot6 = Va3ChessGameController.instance:calcTilePosInScene(slot1, slot2)

	transformhelper.setLocalPos(slot3.transform, slot4, slot5, slot6)
	gohelper.setActive(slot3, false)
	gohelper.setActive(slot3, true)
	AudioMgr.instance:trigger(AudioEnum.chess_activity142.SwitchPlayer)
	TaskDispatcher.cancelTask(slot0.switchPlayerFinish, slot0)
	TaskDispatcher.runDelay(slot0.switchPlayerFinish, slot0, Activity142Enum.PLAYER_SWITCH_TIME)
end

function slot0.getSwitchEffGO(slot0)
	if not slot0._switchEffGO and slot0._loader:getAssetItem(Activity142Enum.SwitchPlayerEffPath) then
		slot0._switchEffGO = gohelper.clone(slot1:GetResource(), slot0._sceneContainer, "switchEff")

		gohelper.setActive(slot0._switchEffGO, false)
	end

	return slot0._switchEffGO
end

function slot0.switchPlayerFinish(slot0)
	Activity142Helper.setAct142UIBlock(false, Activity142Enum.SWITCH_PLAYER)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.switchPlayerFinish, slot0)
	slot0:switchPlayerFinish()

	if slot0._switchEffGO then
		gohelper.destroy(slot0._switchEffGO)

		slot0._switchEffGO = nil
	end

	slot0:removeEvents()
	slot0:disposeBaffle()
	uv0.super.onDestroyView(slot0)
end

function slot0.disposeBaffle(slot0)
	for slot4, slot5 in ipairs(slot0._baffleItems) do
		slot5:dispose()
	end

	for slot4, slot5 in pairs(slot0._baffleItemPools) do
		for slot9, slot10 in ipairs(slot5) do
			slot10:dispose()
		end
	end

	slot0._baffleItems = {}
	slot0._baffleItemPools = {}
end

return slot0
