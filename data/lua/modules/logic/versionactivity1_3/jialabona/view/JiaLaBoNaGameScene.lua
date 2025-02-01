module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaGameScene", package.seeall)

slot0 = class("JiaLaBoNaGameScene", Va3ChessGameScene)

function slot0._editableInitView(slot0)
	slot0._posuiGroundTbList = {}

	uv0.super._editableInitView(slot0)
end

function slot0.addEvents(slot0)
end

function slot0.resetCamera(slot0)
	if not ViewMgr.instance:isOpen(ViewName.JiaLaBoNaMapView) then
		uv0.super.resetCamera(slot0)
	end
end

function slot0._getGroundItemUrlList(slot0)
	slot1 = Va3ChessGameModel.instance:getMapId()
	slot2 = Va3ChessGameModel.instance:getActId()

	if slot0._groundItemUrlList and slot0._lastActId == slot2 and slot0._lastMapId == slot1 then
		return slot0._groundItemUrlList
	end

	slot0._lastActId = slot2
	slot0._lastMapId = slot1
	slot0._groundItemUrlList = {}

	if Va3ChessConfig.instance:getMapCo(slot2, slot1) and slot3.groundItems and not string.nilorempty(slot3.groundItems) and string.split(slot3.groundItems, "#") and #slot4 > 0 then
		for slot8, slot9 in ipairs(slot4) do
			if not string.nilorempty(slot9) then
				table.insert(slot0._groundItemUrlList, string.format(Va3ChessEnum.SceneResPath.AvatarItemPath, slot9))
			end
		end
	end

	if #slot0._groundItemUrlList < 1 then
		table.insert(slot0._groundItemUrlList, Va3ChessEnum.SceneResPath.GroundItem)
	end

	return slot0._groundItemUrlList
end

function slot0.onLoadRes(slot0)
	for slot5, slot6 in ipairs(slot0:_getGroundItemUrlList()) do
		slot0._loader:addPath(slot6)
	end

	slot0._loader:addPath(JiaLaBoNaEnum.SceneResPath.GroundPoSui)
end

function slot0.getGroundItemUrl(slot0)
	if slot0:_getGroundItemUrlList() and #slot1 > 0 then
		return slot1[math.random(1, #slot1)]
	end

	return Va3ChessEnum.SceneResPath.GroundItem
end

function slot0._initEventCb(slot0)
	if slot0._isFinshInitEventCb then
		return
	end

	slot0._isFinshInitEventCb = true

	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.EnterNextMap, slot0._onEnterNextMap, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.TilePosuiTrigger, slot0._onTilePosuiTrigger, slot0)
	slot0:addEventCb(JiaLaBoNaController.instance, JiaLaBoNaEvent.GamePointReturn, slot0._onGamePointReturn, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameMapDataUpdate, slot0.onGameDataUpdate, slot0)
	uv0.super.addEvents(slot0)
end

function slot0._onEnterNextMap(slot0)
	slot0:_checkLoadMapScene()
	slot0:resetTiles()
	Va3ChessGameController.instance:setSelectObj(nil)
	Va3ChessGameController.instance:autoSelectPlayer()
end

function slot0._onGamePointReturn(slot0)
	slot0:_checkLoadMapScene()
	slot0:resetTiles()
	Va3ChessGameController.instance:setSelectObj(nil)
	Va3ChessGameController.instance:autoSelectPlayer()
end

function slot0._checkLoadMapScene(slot0)
	if slot0._currentSceneResPath ~= slot0:getCurrentSceneUrl() then
		UIBlockMgr.instance:startBlock(Va3ChessGameScene.BLOCK_KEY)
		slot0._loader:addPath(slot1)
		slot0._loader:startLoad(slot0.loadResCompleted, slot0)
	else
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameLoadingMapStateUpdate, Va3ChessEvent.LoadingMapState.Finish)
	end
end

function slot0.loadResCompleted(slot0, slot1)
	slot0._currentSceneResPath = slot0:getCurrentSceneUrl()

	uv0.super.loadResCompleted(slot0, slot1)

	if slot0._sceneGo then
		gohelper.destroy(slot2)
	end

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameLoadingMapStateUpdate, Va3ChessEvent.LoadingMapState.Finish)
	slot0:_initEventCb()
end

function slot0.onResetGame(slot0)
	slot0:_resetMapId()
	slot0:_checkLoadMapScene()
	uv0.super.onResetGame(slot0)
end

function slot0.handleResetByResult(slot0)
	slot0:_resetMapId()
	slot0:_checkLoadMapScene()
	slot0:resetTiles()
	uv0.super.handleResetByResult(slot0)
end

function slot0.fillChessBoardBase(slot0)
	uv0.super.fillChessBoardBase(slot0)

	slot2, slot3 = Va3ChessGameModel.instance:getGameSize()
	slot4 = 0

	for slot8 = 1, slot2 do
		for slot12 = 1, slot3 do
			if slot1:getTileMO(slot8 - 1, slot12 - 1) and slot13:isHasTrigger(Va3ChessEnum.TileTrigger.PoSui) then
				if slot4 + 1 >= #slot0._posuiGroundTbList then
					table.insert(slot0._posuiGroundTbList, slot0:_cratePosuiItemTb())
				end

				slot14 = slot0._posuiGroundTbList[slot4]
				slot14.posX = slot8 - 1
				slot14.posY = slot12 - 1

				slot0:setTileBasePosition(slot14, slot14.posX, slot14.posY)
				slot0:_updatePosuiItemTb(slot14, slot13)

				if slot0:getBaseTile(slot14.posX, slot14.posY) then
					gohelper.setActive(slot15.go, false)
				end
			end
		end
	end

	for slot8 = slot4 + 1, #slot0._posuiGroundTbList do
		slot9 = slot0._posuiGroundTbList[slot8]
		slot9.posX = -1
		slot9.posY = -1

		slot0:_updatePosuiItemTb(slot9)
	end
end

function slot0._cratePosuiItemTb(slot0)
	slot1 = slot0:getUserDataTb_()
	slot3 = gohelper.clone(slot0._loader:getAssetItem(JiaLaBoNaEnum.SceneResPath.GroundPoSui):GetResource(), slot0._sceneBackground, "posui")
	slot1.go = slot3
	slot1.sceneTf = slot3.transform
	slot1.animName = nil
	slot1.animator = slot3:GetComponent(JiaLaBoNaEnum.ComponentType.Animator)

	return slot1
end

function slot0.getPosuiItem(slot0, slot1, slot2)
	for slot6 = 1, #slot0._posuiGroundTbList do
		if slot0._posuiGroundTbList[slot6].posX == slot1 and slot7.posY == slot2 then
			return slot7
		end
	end
end

function slot0._onTilePosuiTrigger(slot0, slot1, slot2)
	slot0:_updatePosuiItemTb(slot0:getPosuiItem(slot1, slot2), Va3ChessGameModel.instance:getTileMO(slot1, slot2), true)
end

function slot0._updatePosuiItemTb(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	if slot2 and slot2:isHasTrigger(Va3ChessEnum.TileTrigger.PoSui) then
		gohelper.setActive(slot1.go, true)

		slot5 = slot2:isFinishTrigger(Va3ChessEnum.TileTrigger.PoSui) and "close" or "idle"

		if slot3 or slot5 ~= slot1.animName then
			slot1.animName = slot5

			slot1.animator:Play(slot5, 0, slot3 and 0 or 1)
		end

		if slot3 and slot4 then
			AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_glass_broken)
		end
	else
		slot1.animName = nil

		gohelper.setActive(slot1.go, false)
	end
end

function slot0._resetMapId(slot0)
	Va3ChessGameModel.instance:initData(Va3ChessModel.instance:getActId(), Va3ChessModel.instance:getMapId())
end

function slot0.loadRes(slot0)
	UIBlockMgr.instance:startBlock(Va3ChessGameScene.BLOCK_KEY)

	slot0._loader = MultiAbLoader.New()

	slot0._loader:addPath(slot0:getCurrentSceneUrl())
	slot0._loader:addPath(slot0:getGroundItemUrl())
	slot0._loader:addPath(Va3ChessEnum.SceneResPath.DirItem)
	slot0._loader:addPath(Va3ChessEnum.SceneResPath.AlarmItem)
	slot0:onLoadRes()
	slot0._loader:startLoad(slot0.loadResCompleted, slot0)
end

return slot0
