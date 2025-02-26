module("modules.logic.versionactivity1_3.chess.view.game.Activity1_3ChessGameScene", package.seeall)

slot0 = class("Activity1_3ChessGameScene", Va3ChessGameScene)

function slot0._editableInitView(slot0)
	slot0._btnEffect1ClickArea = gohelper.findChildButton(slot0.viewGO, "btn_effect1ClickArea")
	slot0._btnEffect2ClickArea = gohelper.findChildButton(slot0.viewGO, "btn_effect2ClickArea")
	slot0._fireTileMap = {}
	slot0._sightTileMap = {}

	uv0.super._editableInitView(slot0)
end

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.ObjMoveStep, slot0._onObjMove, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.ObjMoveEnd, slot0._onObjMoveEnd, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.EnterNextMap, slot0._onEnterNextMap, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.CurrentHpUpdate, slot0._onHpUpdate, slot0)
	slot0:addEventCb(Activity1_3ChessGameController.instance, Activity1_3ChessEvent.UpdateGameScene, slot0._onMapUpdate, slot0)
	slot0:addEventCb(Activity1_3ChessGameController.instance, Activity1_3ChessEvent.InitGameScene, slot0._onSceneInit, slot0)
	slot0:addEventCb(Activity1_3ChessController.instance, Activity1_3ChessEvent.AfterResetChessGame, slot0._onResetGame, slot0)
	slot0:addEventCb(Activity1_3ChessController.instance, Activity1_3ChessEvent.OnReadChessGame, slot0._onReadGame, slot0)
	slot0._btnEffect1ClickArea:AddClickListener(slot0._onClickEffect1, slot0)
	slot0._btnEffect2ClickArea:AddClickListener(slot0._onClickEffect2, slot0)
end

function slot0.removeEvents(slot0)
	uv0.super.removeEvents(slot0)
	slot0:removeEventCb(Activity1_3ChessGameController.instance, Activity1_3ChessEvent.UpdateGameScene, slot0._onMapUpdate, slot0)
	slot0:removeEventCb(Va3ChessGameController.instance, Va3ChessEvent.ObjMoveStep, slot0._onObjMove, slot0)
	slot0:removeEventCb(Va3ChessGameController.instance, Va3ChessEvent.ObjMoveEnd, slot0._onObjMoveEnd, slot0)
	slot0:removeEventCb(Activity1_3ChessGameController.instance, Activity1_3ChessEvent.InitGameScene, slot0._onSceneInit, slot0)
	slot0:removeEventCb(Va3ChessGameController.instance, Va3ChessEvent.EnterNextMap, slot0._onEnterNextMap, slot0)
	slot0:removeEventCb(Va3ChessGameController.instance, Va3ChessEvent.CurrentHpUpdate, slot0._onHpUpdate, slot0)
	slot0:removeEventCb(Activity1_3ChessController.instance, Activity1_3ChessEvent.AfterResetChessGame, slot0._onResetGame, slot0)
	slot0:removeEventCb(Activity1_3ChessController.instance, Activity1_3ChessEvent.OnReadChessGame, slot0._onReadGame, slot0)
	slot0._btnEffect1ClickArea:RemoveClickListener()
	slot0._btnEffect2ClickArea:RemoveClickListener()
end

function slot0.onRefreshViewParam(slot0)
	slot2 = CameraMgr.instance:getUnitCamera()
	slot2.orthographic = true
	slot2.orthographicSize = CameraMgr.instance:getMainCamera().orthographicSize

	gohelper.setActive(CameraMgr.instance:getUnitCameraGO(), true)
	gohelper.setActive(PostProcessingMgr.instance._unitPPVolume.gameObject, true)
	PostProcessingMgr.instance:setUnitActive(true)
	PostProcessingMgr.instance:setUnitPPValue("localBloomActive", false)
	PostProcessingMgr.instance:setUnitPPValue("bloomActive", false)
end

function slot0.initCamera(slot0)
end

function slot0.resetCamera(slot0)
end

function slot0.loadRes(slot0)
	UIBlockMgr.instance:startBlock(Va3ChessGameScene.BLOCK_KEY)

	slot0._loader = MultiAbLoader.New()

	slot0._loader:addPath(slot0:getCurrentSceneUrl())
	slot0._loader:addPath(Va3ChessEnum.SceneResPath.GroundItem)
	slot0._loader:addPath(Va3ChessEnum.SceneResPath.DirItem)
	slot0._loader:addPath(Va3ChessEnum.SceneResPath.AlarmItem)
	slot0:onLoadRes()
	slot0._loader:startLoad(slot0.loadResCompleted, slot0)
end

function slot0.onLoadRes(slot0)
	slot0._loader:addPath(Activity1_3ChessEnum.SceneResPath.FireTile)
	slot0._loader:addPath(Activity1_3ChessEnum.SceneResPath.SightTile1)
	slot0._loader:addPath(Activity1_3ChessEnum.SceneResPath.SightTile2)
	slot0._loader:addPath(Activity1_3ChessEnum.SceneResPath.SightTile3)
	slot0._loader:addPath(Activity1_3ChessEnum.SceneResPath.SightEdgeTile)
end

function slot0.createAllInteractObjs(slot0)
	if not Va3ChessGameController.instance.interacts then
		return
	end

	slot1 = Va3ChessGameController.instance.interacts:getList()

	table.sort(slot1, Va3ChessInteractMgr.sortRenderOrder)

	for slot5, slot6 in ipairs(slot1) do
		if slot6:GetIgnoreSight() then
			slot0:createInteractObj(slot6)
		end
	end

	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.AllObjectCreated, slot0.createAllInteractObjs, slot0)
end

function slot0.onloadResCompleted(slot0, slot1)
	gohelper.setActive(gohelper.findChild(slot0._sceneGo, "Obj-Plant/scence_smoke"), true)

	slot0._sceneSight = UnityEngine.GameObject.New("sight")

	transformhelper.setLocalPos(slot0._sceneSight.transform, 0, 0, -2.5)

	slot0._sceneFire = UnityEngine.GameObject.New("fire")

	transformhelper.setLocalPos(slot0._sceneFire.transform, 0, 0, -1)
	slot0._sceneSight.transform:SetParent(slot0._sceneGo.transform, false)
	slot0._sceneFire.transform:SetParent(slot0._sceneGo.transform, false)

	slot0._sceneEffect1 = gohelper.findChild(slot0._sceneGo, "Obj-Plant/all/diffuse/vx_click_quan")
	slot0._sceneEffect2 = gohelper.findChild(slot0._sceneGo, "Obj-Plant/all/diffuse/vx_click_eye")

	if slot0._sceneEffect1 then
		slot3 = CameraMgr.instance:getUICamera()
		slot4 = CameraMgr.instance:getMainCamera()
		slot5 = Vector3.New()
		slot5.x, slot5.y, slot5.z = transformhelper.getPos(slot0._sceneEffect1.transform)
		slot7 = Vector3.New()
		slot7.x, slot7.y, slot7.z = transformhelper.getPos(slot0._sceneEffect2.transform)
		slot0._btnEffect1ClickArea.transform.localPosition = recthelper.worldPosToAnchorPos(slot5, slot0.viewGO.transform, slot3, slot4)
		slot0._btnEffect2ClickArea.transform.localPosition = recthelper.worldPosToAnchorPos(slot7, slot0.viewGO.transform, slot3, slot4)

		gohelper.setActive(slot0._sceneEffect1, false)
		gohelper.setActive(slot0._sceneEffect2, false)
	else
		gohelper.setActive(slot0._btnEffect1ClickArea.gameObject, false)
		gohelper.setActive(slot0._btnEffect2ClickArea.gameObject, false)
	end

	slot0:_onSceneInit()
end

function slot0._onSceneInit(slot0)
	slot0:removeFireTiles()
	slot0:removeSightTiles()

	for slot5, slot6 in pairs(Activity122Model.instance:getCurEpisodeSightMap()) do
		slot7, slot8 = Va3ChessMapUtils.calPosXY(slot5)

		slot0:createSightTileItem(slot7, slot8)

		slot9, slot10 = Va3ChessGameController.instance:searchInteractByPos(slot7, slot8)

		if slot9 == 1 then
			if slot10 then
				slot0:createInteractObj(slot11)
			end
		elseif slot9 > 1 then
			for slot15, slot16 in pairs(slot10) do
				slot0:createInteractObj(slot16)
			end
		end
	end

	for slot6, slot7 in pairs(Activity122Model.instance:getCurEpisodeFireMap()) do
		slot8, slot9 = Va3ChessMapUtils.calPosXY(slot6)

		slot0:createFireTileItem(slot8, slot9)
	end

	Activity1_3ChessGameController.instance:dispatchEvent(Activity1_3ChessEvent.GameSceneInited, Va3ChessGameModel.instance:getMapId())
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameViewOpened, slot0.viewParam)
end

function slot0.onOpenFinish(slot0)
end

function slot0.onChessStateUpdate(slot0, slot1)
	uv0.super.onChessStateUpdate(slot0)

	if slot1 == Va3ChessEnum.GameEventType.Normal then
		-- Nothing
	end
end

function slot0._onMapUpdate(slot0, slot1)
	slot3 = false

	if slot1.addFires then
		for slot7, slot8 in ipairs(slot2) do
			slot0:createFireTileItem(slot8.x, slot8.y)

			slot3 = true
		end
	end

	if slot3 then
		AudioMgr.instance:trigger(AudioEnum.Role2ChessGame1_3.FireSpread)
	end

	if slot1.removeFires then
		for slot8, slot9 in ipairs(slot4) do
			slot0:hideFireTileItem(slot9.x, slot9.y)
		end
	end

	if slot1.addSights then
		for slot9, slot10 in ipairs(slot5) do
			slot0:createSightTileItem(slot10.x, slot10.y)

			slot11, slot12 = Va3ChessGameController.instance:searchInteractByPos(slot10.x, slot10.y)

			if slot11 == 1 then
				if (slot11 == 1 and slot12[1] or slot12) and not slot0._avatarMap[slot13.id] then
					slot0:createInteractObj(slot13)
				end
			elseif slot11 > 1 then
				for slot16, slot17 in pairs(slot12) do
					if not slot0._avatarMap[slot17.id] then
						slot0:createInteractObj(slot17)
					end
				end
			end
		end
	end
end

function slot0._onObjMove(slot0, slot1, slot2, slot3)
	if not Activity122Model.instance:checkPosIndexInSight(Va3ChessMapUtils.calPosIndex(slot2, slot3)) then
		return
	end

	if slot0._avatarMap[slot1] then
		Va3ChessGameController.instance.interacts:get(slot1):getHandler():setAlertActive(true)
		gohelper.setActive(slot0._avatarMap[slot1].sceneGo, true)

		return
	end

	slot0:createInteractObj(Va3ChessGameController.instance.interacts:get(slot1))
end

function slot0._onObjMoveEnd(slot0, slot1, slot2, slot3)
	if not Activity122Model.instance:checkPosIndexInSight(Va3ChessMapUtils.calPosIndex(slot2, slot3)) then
		if not slot0._avatarMap[slot1] then
			return
		end

		gohelper.setActive(slot0._avatarMap[slot1].sceneGo, false)
		Va3ChessGameController.instance.interacts:get(slot1):getHandler():setAlertActive(false)
	end
end

function slot0._onHpUpdate(slot0)
	if Va3ChessGameController.instance.interacts:getMainPlayer() and slot2:getHandler() then
		slot2:getHandler():showHitAni()
	end
end

function slot0._onClickEffect1(slot0)
	if not slot0._sceneEffect1 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Role2ChessGame1_3.DrumHit)
	gohelper.setActive(slot0._sceneEffect1, false)
	gohelper.setActive(slot0._sceneEffect1, true)
end

function slot0._onClickEffect2(slot0)
	if not slot0._sceneEffect2 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Role2ChessGame1_3.MonsterCroaking)
	gohelper.setActive(slot0._sceneEffect2, false)
	gohelper.setActive(slot0._sceneEffect2, true)
end

function slot0.createFireTileItem(slot0, slot1, slot2)
	slot3 = nil

	if slot0._fireTileMap[Va3ChessMapUtils.calPosIndex(slot1, slot2)] then
		slot3 = slot0._fireTileMap[slot4]
	end

	if not slot3 then
		slot3 = slot0:getUserDataTb_()
		slot6 = gohelper.clone(slot0._loader:getAssetItem(Activity1_3ChessEnum.SceneResPath.FireTile):GetResource(), slot0._sceneFire, "fireTile" .. slot1 .. "_" .. slot2)
		slot3.go = slot6
		slot3.sceneTf = slot6.transform
		slot0._fireTileMap[slot4] = slot3

		Activity1_3ChessGameController.instance:dispatchEvent(Activity1_3ChessEvent.GameSceneFireCreated, slot4)
	end

	gohelper.setActive(slot3.go, true)
	slot0:setTileBasePosition(slot3, slot1, slot2)

	return slot3
end

function slot0.hideFireTileItem(slot0, slot1, slot2)
	if slot0._fireTileMap[Va3ChessMapUtils.calPosIndex(slot1, slot2)] then
		gohelper.setActive(slot0._fireTileMap[slot3].go, false)
	end
end

function slot0.removeFireTiles(slot0)
	for slot4, slot5 in pairs(slot0._fireTileMap) do
		UnityEngine.GameObject.Destroy(slot5.go)

		slot5.sceneTf = nil
	end

	slot0._fireTileMap = {}
end

function slot0.createSightTileItem(slot0, slot1, slot2)
	slot3 = nil

	if slot0._sightTileMap[Va3ChessMapUtils.calPosIndex(slot1, slot2)] then
		slot3 = slot0._sightTileMap[slot4]
	end

	if not slot3 then
		slot3 = slot0:getUserDataTb_()
		slot6 = nil
		slot7 = gohelper.clone(((not Va3ChessMapUtils.IsEdgeTile(slot1, slot2) or slot0._loader:getAssetItem(Activity1_3ChessEnum.SceneResPath.SightEdgeTile)) and slot0._loader:getAssetItem(Activity1_3ChessEnum.SceneResPath["SightTile" .. math.random(3)])):GetResource(), slot0._sceneSight, "sightTile" .. slot1 .. "_" .. slot2)
		slot3.go = slot7
		slot3.sceneTf = slot7.transform
		slot0._sightTileMap[slot4] = slot3
	end

	gohelper.setActive(slot3.go, true)
	slot0:setTileBasePosition(slot3, slot1, slot2)

	return slot3
end

function slot0.hideSightTileItem(slot0, slot1, slot2)
	if slot0._sightTileMap[Va3ChessMapUtils.calPosIndex(slot1, slot2)] then
		gohelper.setActive(slot0._sightTileMap[slot3].go, false)
	end
end

function slot0.removeSightTiles(slot0)
	for slot4, slot5 in pairs(slot0._sightTileMap) do
		UnityEngine.GameObject.Destroy(slot5.go)

		slot5.sceneTf = nil
	end

	slot0._sightTileMap = {}
end

function slot0._onResetGame(slot0)
	slot0:resetTiles()
	Va3ChessGameController.instance:setSelectObj(nil)
	Va3ChessGameController.instance:autoSelectPlayer()
end

function slot0._onReadGame(slot0)
	slot0:resetTiles()
	Va3ChessGameController.instance:setSelectObj(nil)
	Va3ChessGameController.instance:autoSelectPlayer()
end

function slot0._onEnterNextMap(slot0)
	slot0:resetTiles()
	Va3ChessGameController.instance:setSelectObj(nil)
	Va3ChessGameController.instance:autoSelectPlayer()
end

function slot0.handleResetByResult(slot0)
	slot0:removeFireTiles()
	slot0:removeSightTiles()
	slot0:resetTiles()
	uv0.super.handleResetByResult(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:removeFireTiles()
	slot0:removeSightTiles()
	slot0:removeEvents()
	uv0.super.onDestroyView(slot0)
end

return slot0
