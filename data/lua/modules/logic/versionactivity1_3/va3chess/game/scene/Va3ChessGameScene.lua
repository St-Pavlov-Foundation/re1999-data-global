module("modules.logic.versionactivity1_3.va3chess.game.scene.Va3ChessGameScene", package.seeall)

slot0 = class("Va3ChessGameScene", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._gotouch = gohelper.findChild(slot0.viewGO, "#go_touch")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0.onScreenResize, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.AddInteractObj, slot0.createInteractObj, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.DeleteInteractAvatar, slot0.deleteInteractObj, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.ResetMapView, slot0.onResetMapView, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.SetNeedChooseDirectionVisible, slot0.onSetDirectionVisible, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameReset, slot0.onResetGame, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.RefreshAlarmArea, slot0.onAlarmAreaRefresh, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.RefreshAlarmAreaOnXY, slot0.refreshAlarmAreaOnXY, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameMapDataUpdate, slot0.onGameDataUpdate, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GuideClickTile, slot0._guideClickTile, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.ResetGameByResultView, slot0.handleResetByResult, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.GameResultQuit, slot0.onResultQuit, slot0)
	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.EventStart, slot0.onChessStateUpdate, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.StoryFrontViewDestroy, slot0._afterPlayStory, slot0)
end

function slot0.removeEvents(slot0)
end

slot0.BLOCK_KEY = "Va3ChessGameSceneLoading"

function slot0._editableInitView(slot0)
	slot0._tfTouch = slot0._gotouch.transform
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0._gotouch)

	slot0._click:AddClickListener(slot0.onClickContainer, slot0)

	slot0._handler = Va3ChessGameHandler.New()

	slot0._handler:init(slot0)

	slot0._baseTiles = {}
	slot0._baseTilePool = {}
	slot0._dirItems = {}
	slot0._dirItemPool = {}
	slot0._alarmItems = {}
	slot0._alarmItemPool = {}
	slot0._avatarMap = {}
	slot0._fixedOrder = 0

	slot0:createSceneRoot()
	slot0:initCamera()
	Va3ChessGameController.instance:initSceneTree(slot0._gotouch, slot0._sceneOffsetY)
	slot0:loadRes()
end

function slot0.onDestroyView(slot0)
	if slot0._click then
		slot0._click:RemoveClickListener()

		slot0._click = nil
	end

	if slot0._handler then
		slot0._handler:dispose()

		slot0._handler = nil
	end

	slot0._baseTiles = nil

	slot0:resetCamera()
	slot0:releaseRes()
	slot0:disposeSceneRoot()
	TaskDispatcher.cancelTask(slot0.delayRefreshAlarmArea, slot0)

	slot0._isWaitingRefreshAlarm = false
end

function slot0.onOpen(slot0)
end

function slot0.onOpenFinish(slot0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameViewOpened, slot0.viewParam)
end

function slot0.onClose(slot0)
	UIBlockMgr.instance:endBlock(uv0.BLOCK_KEY)
	slot0:stopAudio()
end

function slot0.playAudio(slot0)
	slot2 = Va3ChessGameModel.instance:getMapId()

	if Va3ChessGameModel.instance:getActId() and slot2 then
		slot0:stopAudio()

		if Va3ChessConfig.instance:getMapCo(slot1, slot2) and slot3.audioAmbient ~= 0 then
			slot0._triggerAmbientId = AudioMgr.instance:trigger(slot3.audioAmbient)
		end
	end
end

function slot0.stopAudio(slot0)
	if slot0._triggerAmbientId then
		AudioMgr.instance:stopPlayingID(slot0._triggerAmbientId)

		slot0._triggerAmbientId = nil
	end
end

function slot0.onScreenResize(slot0)
	if slot0._sceneGo then
		CameraMgr.instance:getMainCamera().orthographicSize = 7.5 * GameUtil.getAdapterScale(true)
	end
end

function slot0.initCamera(slot0)
	if slot0._isInitCamera then
		return
	end

	slot0._isInitCamera = true
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographic = true
	slot1.orthographicSize = 7.5 * GameUtil.getAdapterScale(true)
end

function slot0.resetCamera(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographicSize = 5
	slot1.orthographic = false
end

function slot0.loadRes(slot0)
	UIBlockMgr.instance:startBlock(uv0.BLOCK_KEY)

	slot0._loader = MultiAbLoader.New()

	slot0._loader:addPath(slot0:getCurrentSceneUrl())
	slot0._loader:addPath(slot0:getGroundItemUrl())
	slot0._loader:addPath(Va3ChessEnum.SceneResPath.DirItem)
	slot0._loader:addPath(Va3ChessEnum.SceneResPath.AlarmItem)
	slot0._loader:addPath(Va3ChessEnum.SceneResPath.AlarmItem2)
	slot0._loader:addPath(Va3ChessEnum.SceneResPath.AlarmItem3)
	slot0:onLoadRes()
	slot0._loader:startLoad(slot0.loadResCompleted, slot0)
end

function slot0.onLoadRes(slot0)
end

function slot0.getGroundItemUrl(slot0)
	return Va3ChessEnum.SceneResPath.GroundItem
end

function slot0.getCurrentSceneUrl(slot0)
	if Va3ChessConfig.instance:getMapCo(Va3ChessGameModel.instance:getActId(), Va3ChessGameModel.instance:getMapId()) and not string.nilorempty(slot3.bgPath) then
		return string.format(Va3ChessEnum.SceneResPath.SceneFormatPath, slot3.bgPath)
	else
		return Va3ChessEnum.SceneResPath.DefaultScene
	end
end

function slot0.loadResCompleted(slot0, slot1)
	if slot1:getAssetItem(slot0:getCurrentSceneUrl()) then
		slot0._sceneGo = gohelper.clone(slot2:GetResource(), slot0._sceneRoot, "scene")
		slot0._sceneAnim = slot0._sceneGo:GetComponent(typeof(UnityEngine.Animator))

		slot0._sceneBackground.transform:SetParent(slot0._sceneGo.transform, false)
		slot0._sceneGround.transform:SetParent(slot0._sceneGo.transform, false)
		slot0._sceneContainer.transform:SetParent(slot0._sceneGo.transform, false)
		transformhelper.setLocalPos(slot0._sceneBackground.transform, 0, 0, -0.5)
		transformhelper.setLocalPos(slot0._sceneGround.transform, 0, 0, -1)
		transformhelper.setLocalPos(slot0._sceneContainer.transform, 0, 0, -1.5)
		slot0:fillChessBoardBase()
		slot0:createAllInteractObjs()
		slot0:onloadResCompleted(slot1)
		slot0:playEnterAnim()
		slot0:playAudio()

		if not Va3ChessGameController.instance:getSelectObj() then
			Va3ChessGameController.instance:autoSelectPlayer(true)
		end
	end

	UIBlockMgr.instance:endBlock(uv0.BLOCK_KEY)
	Va3ChessController.instance:dispatchEvent(Va3ChessEvent.GuideOnEnterEpisode, tostring(Va3ChessModel.instance:getActId()) .. "_" .. tostring(Va3ChessModel.instance:getEpisodeId()))
end

function slot0.onloadResCompleted(slot0, slot1)
end

function slot0.releaseRes(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

function slot0.createSceneRoot(slot0)
	slot0._sceneRoot = UnityEngine.GameObject.New("ChessMap")
	slot0._sceneBackground = UnityEngine.GameObject.New("background")
	slot0._sceneGround = UnityEngine.GameObject.New("ground")
	slot0._sceneContainer = UnityEngine.GameObject.New("container")
	slot3, slot4, slot5 = transformhelper.getLocalPos(CameraMgr.instance:getMainCameraTrs().parent)

	transformhelper.setLocalPos(slot0._sceneRoot.transform, 0, slot4, 0)

	slot0._sceneOffsetY = slot4

	gohelper.addChild(CameraMgr.instance:getSceneRoot(), slot0._sceneRoot)
	gohelper.addChild(slot0._sceneRoot, slot0._sceneBackground)
	gohelper.addChild(slot0._sceneRoot, slot0._sceneGround)
	gohelper.addChild(slot0._sceneRoot, slot0._sceneContainer)
end

function slot0.disposeSceneRoot(slot0)
	if slot0._sceneRoot then
		gohelper.destroy(slot0._sceneRoot)

		slot0._sceneRoot = nil
	end
end

function slot0.fillChessBoardBase(slot0)
	slot1, slot2 = Va3ChessGameModel.instance:getGameSize()
	slot6 = ", h = "

	logNormal("fill w = " .. tostring(slot1) .. slot6 .. tostring(slot2))

	for slot6 = 1, slot1 do
		slot0._baseTiles[slot6] = slot0._baseTiles[slot6] or {}

		for slot10 = 1, slot2 do
			slot11 = slot0:createTileBaseItem(slot6 - 1, slot10 - 1)
			slot0._baseTiles[slot6][slot10] = slot11

			slot0:onTileItemCreate(slot6 - 1, slot10 - 1, slot11)
			gohelper.setActive(slot11.go, Va3ChessGameModel.instance:getBaseTile(slot6 - 1, slot10 - 1) == Va3ChessEnum.TileBaseType.Normal)
		end
	end
end

function slot0.createTileBaseItem(slot0, slot1, slot2)
	slot3 = nil

	if #slot0._baseTilePool > 0 then
		slot3 = slot0._baseTilePool[1]

		table.remove(slot0._baseTilePool, 1)
	end

	if not slot3 then
		slot3 = slot0:getUserDataTb_()
		slot7 = gohelper.clone(slot0._loader:getAssetItem(slot0:getGroundItemUrl(slot1, slot2)):GetResource(), slot0._sceneBackground, "tilebase_" .. slot1 .. "_" .. slot2)
		slot3.go = slot7
		slot3.sceneTf = slot7.transform
	end

	slot0:setTileBasePosition(slot3, slot1, slot2)

	return slot3
end

function slot0.setTileBasePosition(slot0, slot1, slot2, slot3)
	slot4, slot5, slot6 = Va3ChessGameController.instance:calcTilePosInScene(slot2, slot3)

	transformhelper.setLocalPos(slot1.sceneTf, slot4, slot5, slot6)
end

function slot0.onTileItemCreate(slot0, slot1, slot2, slot3)
end

function slot0.resetTiles(slot0)
	for slot4, slot5 in pairs(slot0._baseTiles) do
		for slot9, slot10 in pairs(slot5) do
			table.insert(slot0._baseTilePool, slot10)
		end
	end

	slot0._baseTiles = {}

	slot0:fillChessBoardBase()
end

function slot0.createAllInteractObjs(slot0)
	logNormal("createAllObjects")

	if not Va3ChessGameController.instance.interacts then
		return
	end

	slot1 = Va3ChessGameController.instance.interacts:getList()

	table.sort(slot1, Va3ChessInteractMgr.sortRenderOrder)

	for slot5, slot6 in ipairs(slot1) do
		slot0:createInteractObj(slot6)
	end

	slot0:addEventCb(Va3ChessGameController.instance, Va3ChessEvent.AllObjectCreated, slot0.createAllInteractObjs, slot0)
end

function slot0.createInteractObj(slot0, slot1)
	if gohelper.isNil(slot0._sceneContainer) then
		logNormal("Va3ChessGameScene: game is already end")

		return
	end

	slot3 = slot0:getUserDataTb_()
	slot3.sceneGo = UnityEngine.GameObject.New("item_" .. slot1.id)
	slot3.sceneTf = slot3.sceneGo.transform
	slot3.loader = PrefabInstantiate.Create(slot3.sceneGo)

	slot3.sceneTf:SetParent(slot0._sceneContainer.transform, false)

	slot3.order = Va3ChessInteractMgr.getRenderOrder(slot1) + slot0._fixedOrder
	slot0._fixedOrder = slot0._fixedOrder + 0.01

	slot1:setAvatar(slot3)

	slot0._avatarMap[slot1.id] = slot3

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SceneInteractObjCreated, Va3ChessGameModel.instance:getActId() .. "_" .. slot1.id)
end

function slot0.deleteInteractObj(slot0, slot1)
	slot0._avatarMap[slot1] = nil
end

function slot0.createDirItem(slot0)
	slot1 = nil

	if #slot0._dirItemPool > 0 then
		slot1 = slot0._dirItemPool[slot2]
		slot0._dirItemPool[slot2] = nil
	end

	if not slot1 then
		slot1 = slot0:getUserDataTb_()
		slot1.go = gohelper.clone(slot0._loader:getAssetItem(Va3ChessEnum.SceneResPath.DirItem):GetResource(), slot0._sceneGround, "dirItem")
		slot1.sceneTf = slot1.go.transform
		slot1.goCenter = gohelper.findChild(slot1.go, "#go_center")
		slot1.goNormal = gohelper.findChild(slot1.go, "#go_normal")
		slot1.goItem = gohelper.findChild(slot1.go, "#go_item")
	end

	table.insert(slot0._dirItems, slot1)

	return slot1
end

function slot0.recycleAllDirItem(slot0)
	for slot4, slot5 in pairs(slot0._dirItems) do
		gohelper.setActive(slot5.go, false)
		table.insert(slot0._dirItemPool, slot5)

		slot0._dirItems[slot4] = nil
	end
end

function slot0.onResetMapView(slot0)
	slot0:resetTiles()
end

function slot0.onResetGame(slot0)
	slot0._fixedOrder = 1

	slot0:playEnterAnim()
	slot0:resetTiles()
	Va3ChessGameController.instance:setSelectObj(nil)
	Va3ChessGameController.instance:autoSelectPlayer(true)
end

function slot0.onGameDataUpdate(slot0)
	if not Va3ChessGameController.instance:getSelectObj() then
		Va3ChessGameController.instance:autoSelectPlayer(true)
	end
end

function slot0.onChessStateUpdate(slot0, slot1)
	if slot1 == Va3ChessEnum.GameEventType.Normal then
		if Va3ChessGameModel.instance:getMapId() then
			Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GuideRoundStartCheckPlayerPos, slot5 .. "_" .. Va3ChessGameController.instance.interacts:getMainPlayer(true):getObjPosIndex())
		end

		slot6 = slot3.originData.posX
		slot7 = slot3.originData.posY

		slot0:updatePlayerInteractState(slot3, slot6 + 1, slot7)
		slot0:updatePlayerInteractState(slot3, slot6 - 1, slot7)
		slot0:updatePlayerInteractState(slot3, slot6, slot7 + 1)
		slot0:updatePlayerInteractState(slot3, slot6, slot7 - 1)
	end
end

function slot0.updatePlayerInteractState(slot0, slot1, slot2, slot3)
	Va3ChessGameController.instance:posCanWalk(slot2, slot3, Va3ChessMapUtils.ToDirection(slot1.originData.posX, slot1.originData.posY, slot2, slot3), slot1.objType)
end

function slot0.onSetDirectionVisible(slot0, slot1)
	slot0:recycleAllDirItem()

	if not slot1 then
		return
	end

	if slot1.visible then
		slot2 = slot1.selectType or Va3ChessEnum.ChessSelectType.Normal

		for slot6 = 1, #slot1.posXList do
			slot7 = slot0:createDirItem()

			slot0:addDirectionItem(slot7, slot1.posXList[slot6], slot1.posYList[slot6])
			gohelper.setActive(slot7.goNormal, Va3ChessEnum.ChessSelectType.Normal == slot2)
			gohelper.setActive(slot7.goItem, Va3ChessEnum.ChessSelectType.UseItem == slot2)
			gohelper.setActive(slot7.goCenter, false)
		end

		if slot1.selfPosX ~= nil and slot1.selfPosY ~= nil then
			slot3 = slot0:createDirItem()

			slot0:addDirectionItem(slot3, slot1.selfPosX, slot1.selfPosY)
			gohelper.setActive(slot3.goNormal, false)
			gohelper.setActive(slot3.goItem, false)
			gohelper.setActive(slot3.goCenter, true)
		end

		slot0:delayRefreshAlarmArea()
	else
		slot0:recycleAllAlarmItem()
	end
end

function slot0.addDirectionItem(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot1.go, true)

	slot4, slot5, slot6 = Va3ChessGameController.instance:calcTilePosInScene(slot2, slot3, Va3ChessEnum.AlarmOrder.DirItem)
	slot1.tileX = slot2
	slot1.tileY = slot3

	transformhelper.setLocalPos(slot1.sceneTf, slot4, slot5, slot6)
end

function slot0._afterPlayStory(slot0)
	slot0:playAudio()
end

function slot0.createAlarmItem(slot0, slot1, slot2, slot3, slot4)
	if type(slot4) == "table" then
		slot5 = slot4.isStatic or false
		slot6 = slot4.resPath or Va3ChessEnum.SceneResPath.AlarmItem3
		slot7 = slot4.showDirLine or {}
		slot8 = slot4.showOrangeStyle or false
	end

	if slot0._alarmItems[Va3ChessMapUtils.calPosIndex(slot1, slot2)] then
		for slot14, slot15 in ipairs(slot10) do
			if slot15.resPath == slot6 then
				return
			end
		end
	end

	slot11 = nil

	if slot0._alarmItemPool[slot6] and #slot12 > 0 then
		slot11 = slot12[slot13]
		slot12[slot13] = nil
	end

	if not slot11 then
		slot11 = slot0:getUserDataTb_()
		slot11.go = gohelper.clone((slot0._loader:getAssetItem(slot6) or slot0._loader:getAssetItem(Va3ChessEnum.SceneResPath.AlarmItem)):GetResource(), slot0._sceneGround, "alarmItem")
		slot11.dir2GO = {}

		for slot17, slot18 in pairs(Va3ChessEnum.Direction) do
			slot11.dir2GO[slot18] = gohelper.findChild(slot11.go, string.format("dir_%s", slot18))
		end

		slot11.sceneTf = slot11.go.transform
		slot11.redStyle = gohelper.findChild(slot11.go, "diban_red")
		slot11.orangeStyle = gohelper.findChild(slot11.go, "diban_orange")
	end

	for slot16, slot17 in pairs(slot11.dir2GO) do
		if not gohelper.isNil(slot17) then
			gohelper.setActive(slot17, false)
		end
	end

	for slot16, slot17 in pairs(slot7) do
		if not gohelper.isNil(slot11.dir2GO[slot17]) then
			gohelper.setActive(slot18, true)
		end
	end

	gohelper.setActive(slot11.orangeStyle, slot8)
	gohelper.setActive(slot11.redStyle, not slot8)
	gohelper.setActive(slot11.go, true)

	slot13, slot14, slot15 = Va3ChessGameController.instance:calcTilePosInScene(slot1, slot2, Va3ChessEnum.AlarmOrder.AlarmItem)
	slot11.tileX = slot1
	slot11.tileY = slot2
	slot11.isManual = slot3
	slot11.isStatic = slot5
	slot11.resPath = slot6

	transformhelper.setLocalPos(slot11.sceneTf, slot13, slot14, slot15)

	if not slot10 then
		slot0._alarmItems[slot9] = {}
	end

	slot10[#slot10 + 1] = slot11

	return slot11
end

function slot0.recycleAlarmItem(slot0, slot1, slot2, slot3)
	if not slot0._alarmItems[Va3ChessMapUtils.calPosIndex(slot1, slot2)] then
		return
	end

	for slot9, slot10 in ipairs(slot5) do
		gohelper.setActive(slot10.go, false)

		slot10.tileX = nil
		slot10.tileY = nil
		slot10.isManual = nil
		slot10.isStatic = nil

		if not slot0._alarmItemPool[slot10.resPath] then
			slot0._alarmItemPool[slot10.resPath] = {}
		end

		table.insert(slot11, slot10)

		slot5[slot9] = nil
	end
end

function slot0.recycleAllAlarmItem(slot0, slot1)
	for slot5, slot6 in pairs(slot0._alarmItems) do
		for slot10, slot11 in pairs(slot6) do
			if not slot11.isManual and (slot1 or not slot11.isStatic) then
				gohelper.setActive(slot11.go, false)

				if not slot0._alarmItemPool[slot11.resPath] then
					slot0._alarmItemPool[slot11.resPath] = {}
				end

				table.insert(slot14, slot11)

				slot6[slot10] = nil
			end
		end
	end
end

function slot0.onAlarmAreaRefresh(slot0)
	if slot0._isWaitingRefreshAlarm then
		return
	end

	slot0._isWaitingRefreshAlarm = true

	TaskDispatcher.runDelay(slot0.delayRefreshAlarmArea, slot0, 0.001)
end

function slot0.delayRefreshAlarmArea(slot0)
	TaskDispatcher.cancelTask(slot0.delayRefreshAlarmArea, slot0)

	slot0._isWaitingRefreshAlarm = false

	slot0:recycleAllAlarmItem(true)

	if not Va3ChessGameController.instance.interacts then
		return
	end

	if not Va3ChessGameController.instance.interacts:getList() then
		return
	end

	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot7:getHandler():onDrawAlert(slot2)
	end

	for slot6, slot7 in pairs(slot2) do
		for slot11, slot12 in pairs(slot7) do
			for slot16, slot17 in pairs(slot12) do
				slot0:createAlarmItem(slot6, slot11, nil, slot17)
			end
		end
	end
end

function slot0.refreshAlarmAreaOnXY(slot0, slot1, slot2, slot3)
	if slot3 then
		slot0:createAlarmItem(slot1, slot2, true)
	else
		slot0:recycleAlarmItem(slot1, slot2)
	end
end

function slot0.onResultQuit(slot0)
	slot0:closeThis()
end

function slot0.handleResetByResult(slot0)
	if slot0._sceneAnim then
		slot0._sceneAnim:Play("open", 0, 0)
	end
end

function slot0.playEnterAnim(slot0)
	if slot0._sceneAnim then
		slot0._sceneAnim:Play(UIAnimationName.Open, 0, 0)
	end
end

function slot0._guideClickTile(slot0, slot1)
	slot2 = string.splitToNumber(slot1, "_")

	slot0:onClickChessPos(slot2[1], slot2[2])
end

function slot0.onClickContainer(slot0)
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	slot1 = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), slot0._tfTouch)
	slot2, slot3 = Va3ChessGameController.instance:getNearestScenePos(slot1.x, slot1.y)

	if slot2 then
		logNormal("click Scene tileX, tileY : " .. tostring(slot2) .. ", " .. tostring(slot3) .. " index: " .. Va3ChessMapUtils.calPosIndex(slot2, slot3))
		slot0:onClickChessPos(slot2, slot3)
	end
end

function slot0.onClickChessPos(slot0, slot1, slot2)
	if Va3ChessGameController.instance.event and slot3:getCurEvent() and slot3:getCurEvent() then
		slot4:onClickPos(slot1, slot2, true)
	end
end

function slot0.getBaseTile(slot0, slot1, slot2)
	return slot0._baseTiles[slot1 + 1][slot2 + 1]
end

return slot0
