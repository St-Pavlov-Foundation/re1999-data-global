module("modules.logic.activity.view.chessmap.ActivityChessGameScene", package.seeall)

slot0 = class("ActivityChessGameScene", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._gochessboard = gohelper.findChild(slot0.viewGO, "scroll/viewport/#go_content/#go_chessboard")
	slot0._gotouch = gohelper.findChild(slot0.viewGO, "#go_touch")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot0.BLOCK_KEY = "ActivityChessGameSceneLoading"

function slot0._editableInitView(slot0)
	slot0._tfTouch = slot0._gotouch.transform
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0._gotouch)

	slot0._click:AddClickListener(slot0.onClickContainer, slot0)

	slot0._handler = ActivityChessGameHandler.New()

	slot0._handler:init(slot0)

	slot0._baseTiles = {}
	slot0._baseTilePool = {}
	slot0._dirItems = {}
	slot0._dirItemPool = {}
	slot0._alarmItems = {}
	slot0._alarmItemPool = {}
	slot0._avatars = {}
	slot0._fixedOrder = 0

	slot0:createSceneRoot()
	slot0:initCamera()
	ActivityChessGameController.instance:initSceneTree(slot0._gotouch, slot0._sceneOffsetY)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0.onScreenResize, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.DestroyViewFinish, slot0.onDestroyOtherView, slot0)
	slot0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.InteractObjectCreated, slot0.createInteractObj, slot0)
	slot0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.DeleteInteractAvatar, slot0.deleteInteractObj, slot0)
	slot0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.ResetMapView, slot0.onResetMapView, slot0)
	slot0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.SetNeedChooseDirectionVisible, slot0.onSetDirectionVisible, slot0)
	slot0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.GameReset, slot0.onResetGame, slot0)
	slot0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.RefreshAlarmArea, slot0.onAlarmAreaRefresh, slot0)
	slot0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.GameMapDataUpdate, slot0.onGameDataUpdate, slot0)
	slot0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.GuideClickTile, slot0._guideClickTile, slot0)
	slot0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.ResetGameByResultView, slot0.handleResetByResult, slot0)
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
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.GameViewOpened, slot0.viewParam)
end

function slot0.onClose(slot0)
	UIBlockMgr.instance:endBlock(uv0.BLOCK_KEY)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.Stop)
end

function slot0.playAudio(slot0)
	slot2 = ActivityChessGameModel.instance:getMapId()

	if ActivityChessGameModel.instance:getActId() and slot2 and Activity109Config.instance:getMapCo(slot1, slot2) then
		AudioMgr.instance:trigger(slot3.audioAmbient)
	end
end

function slot0.onDestroyOtherView(slot0, slot1)
	slot0:onScreenResize()
end

function slot0.onScreenResize(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographic = true
	slot1.orthographicSize = 7.5 * GameUtil.getAdapterScale(true)
end

function slot0.initCamera(slot0)
	if slot0._isInitCamera then
		return
	end

	slot0._isInitCamera = true

	slot0:onScreenResize()
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
	slot0._loader:addPath(ActivityChessEnum.SceneResPath.GroundItem)
	slot0._loader:addPath(ActivityChessEnum.SceneResPath.DirItem)
	slot0._loader:addPath(ActivityChessEnum.SceneResPath.AlarmItem)
	slot0._loader:startLoad(slot0.onLoadResCompleted, slot0)
end

function slot0.getCurrentSceneUrl(slot0)
	if Activity109Config.instance:getMapCo(ActivityChessGameModel.instance:getActId(), ActivityChessGameModel.instance:getMapId()) and not string.nilorempty(slot3.bgPath) then
		return string.format(ActivityChessEnum.SceneResPath.SceneFormatPath, slot3.bgPath)
	else
		return ActivityChessEnum.SceneResPath.DefaultScene
	end
end

function slot0.onLoadResCompleted(slot0, slot1)
	if slot1:getAssetItem(slot0:getCurrentSceneUrl()) then
		slot0._sceneGo = gohelper.clone(slot2:GetResource(), slot0._sceneRoot, "scene")
		slot0._sceneAnim = slot0._sceneGo:GetComponent(typeof(UnityEngine.Animator))
		slot0._sceneBackground = UnityEngine.GameObject.New("background")
		slot0._sceneGround = UnityEngine.GameObject.New("ground")
		slot0._sceneContainer = UnityEngine.GameObject.New("container")

		slot0._sceneBackground.transform:SetParent(slot0._sceneGo.transform, false)
		slot0._sceneGround.transform:SetParent(slot0._sceneGo.transform, false)
		slot0._sceneContainer.transform:SetParent(slot0._sceneGo.transform, false)
		transformhelper.setLocalPos(slot0._sceneBackground.transform, 0, 0, -0.5)
		transformhelper.setLocalPos(slot0._sceneGround.transform, 0, 0, -1)
		transformhelper.setLocalPos(slot0._sceneContainer.transform, 0, 0, -1.5)
		slot0:fillChessBoardBase()
		slot0:createAllInteractObjs()

		if not ActivityChessGameController.instance:getSelectObj() then
			ActivityChessGameController.instance:autoSelectPlayer()
		end

		slot0:playEnterAnim()
		slot0:playAudio()
	end

	UIBlockMgr.instance:endBlock(uv0.BLOCK_KEY)
end

function slot0.releaseRes(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

function slot0.createSceneRoot(slot0)
	slot0._sceneRoot = UnityEngine.GameObject.New("ChessMap")
	slot3, slot4, slot5 = transformhelper.getLocalPos(CameraMgr.instance:getMainCameraTrs().parent)

	transformhelper.setLocalPos(slot0._sceneRoot.transform, 0, slot4, 0)

	slot0._sceneOffsetY = slot4

	gohelper.addChild(CameraMgr.instance:getSceneRoot(), slot0._sceneRoot)
end

function slot0.disposeSceneRoot(slot0)
	if slot0._sceneRoot then
		gohelper.destroy(slot0._sceneRoot)

		slot0._sceneRoot = nil
	end
end

function slot0.fillChessBoardBase(slot0)
	slot1, slot2 = ActivityChessGameModel.instance:getGameSize()
	slot6 = tostring(slot1)

	logNormal("fill w = " .. slot6 .. ", h = " .. tostring(slot2))

	for slot6 = 1, slot1 do
		slot0._baseTiles[slot6] = slot0._baseTiles[slot6] or {}

		for slot10 = 1, slot2 do
			slot11 = slot0:createTileBaseItem(slot6 - 1, slot10 - 1)
			slot0._baseTiles[slot6][slot10] = slot11

			gohelper.setActive(slot11.go, ActivityChessGameModel.instance:getBaseTile(slot6 - 1, slot10 - 1) == ActivityChessEnum.TileBaseType.Normal)
		end
	end
end

function slot0.createTileBaseItem(slot0, slot1, slot2)
	slot3 = nil

	if #slot0._baseTilePool > 0 then
		slot3 = slot0._baseTilePool[slot4]
		slot0._baseTilePool[slot4] = nil
	end

	if not slot3 then
		slot3 = slot0:getUserDataTb_()
		slot6 = gohelper.clone(slot0._loader:getAssetItem(ActivityChessEnum.SceneResPath.GroundItem):GetResource(), slot0._sceneBackground, "tilebase_" .. slot1 .. "_" .. slot2)
		slot3.go = slot6
		slot3.sceneTf = slot6.transform
	end

	slot0:setTileBasePosition(slot3, slot1, slot2)

	return slot3
end

function slot0.setTileBasePosition(slot0, slot1, slot2, slot3)
	slot4, slot5, slot6 = ActivityChessGameController.instance:calcTilePosInScene(slot2, slot3)

	transformhelper.setLocalPos(slot1.sceneTf, slot4, slot5, slot6)
end

function slot0.resetTiles(slot0)
	for slot4, slot5 in pairs(slot0._baseTiles) do
		for slot9, slot10 in pairs(slot5) do
			table.insert(slot0._baseTilePool, slot0._baseTiles[slot4][slot9])
		end
	end

	slot0._baseTiles = {}

	slot0:fillChessBoardBase()
end

function slot0.createAllInteractObjs(slot0)
	logNormal("createAllObjects")

	if not ActivityChessGameController.instance.interacts then
		return
	end

	slot1 = ActivityChessGameController.instance.interacts:getList()
	slot5 = ActivityChessInteractMgr.sortRenderOrder

	table.sort(slot1, slot5)

	for slot5, slot6 in ipairs(slot1) do
		slot0:createInteractObj(slot6)
	end

	slot0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.AllObjectCreated, slot0.createAllInteractObjs, slot0)
end

function slot0.createInteractObj(slot0, slot1)
	slot3 = slot0:getUserDataTb_()
	slot3.sceneGo = UnityEngine.GameObject.New("item_" .. slot1.id)
	slot3.sceneTf = slot3.sceneGo.transform
	slot3.loader = PrefabInstantiate.Create(slot3.sceneGo)

	slot3.sceneTf:SetParent(slot0._sceneContainer.transform, false)

	slot3.order = ActivityChessInteractMgr.getRenderOrder(slot1) + slot0._fixedOrder
	slot0._fixedOrder = slot0._fixedOrder + 0.01

	slot1:setAvatar(slot3)
	table.insert(slot0._avatars, slot3)
end

function slot0.deleteInteractObj(slot0, slot1)
	tabletool.removeValue(slot0._avatars, slot1)
end

function slot0.createDirItem(slot0)
	slot1 = nil

	if #slot0._dirItemPool > 0 then
		slot1 = slot0._dirItemPool[slot2]
		slot0._dirItemPool[slot2] = nil
	end

	if not slot1 then
		slot1 = slot0:getUserDataTb_()
		slot1.go = gohelper.clone(slot0._loader:getAssetItem(ActivityChessEnum.SceneResPath.DirItem):GetResource(), slot0._sceneGround, "dirItem")
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

function slot0.createAlarmItem(slot0)
	slot1 = nil

	if #slot0._alarmItemPool > 0 then
		slot1 = slot0._alarmItemPool[slot2]
		slot0._alarmItemPool[slot2] = nil
	end

	if not slot1 then
		slot1 = slot0:getUserDataTb_()
		slot1.go = gohelper.clone(slot0._loader:getAssetItem(ActivityChessEnum.SceneResPath.AlarmItem):GetResource(), slot0._sceneGround, "alarmItem")
		slot1.sceneTf = slot1.go.transform
	end

	table.insert(slot0._alarmItems, slot1)

	return slot1
end

function slot0.recycleAllAlarmItem(slot0)
	for slot4, slot5 in pairs(slot0._alarmItems) do
		gohelper.setActive(slot5.go, false)
		table.insert(slot0._alarmItemPool, slot5)

		slot0._alarmItems[slot4] = nil
	end
end

function slot0.onResetMapView(slot0)
	slot0:resetTiles()
end

function slot0.onResetGame(slot0)
	slot0._fixedOrder = 1

	slot0:playEnterAnim()
end

function slot0.onGameDataUpdate(slot0)
	if not ActivityChessGameController.instance:getSelectObj() then
		ActivityChessGameController.instance:autoSelectPlayer()
	end
end

function slot0.onSetDirectionVisible(slot0, slot1)
	slot0:recycleAllDirItem()

	if slot1 and slot1.visible then
		slot2 = slot1.selectType or ActivityChessEnum.ChessSelectType.Normal

		for slot6 = 1, #slot1.posXList do
			slot7 = slot0:createDirItem()

			slot0:addDirectionItem(slot7, slot1.posXList[slot6], slot1.posYList[slot6])
			gohelper.setActive(slot7.goNormal, ActivityChessEnum.ChessSelectType.Normal == slot2)
			gohelper.setActive(slot7.goItem, ActivityChessEnum.ChessSelectType.UseItem == slot2)
			gohelper.setActive(slot7.goCenter, false)
		end

		if slot1.selfPosX ~= nil and slot1.selfPosY ~= nil then
			slot3 = slot0:createDirItem()

			slot0:addDirectionItem(slot3, slot1.selfPosX, slot1.selfPosY)
			gohelper.setActive(slot3.goNormal, false)
			gohelper.setActive(slot3.goItem, false)
			gohelper.setActive(slot3.goCenter, true)
		end
	end
end

function slot0.addDirectionItem(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot1.go, true)

	slot4, slot5, slot6 = ActivityChessGameController.instance:calcTilePosInScene(slot2, slot3)
	slot1.tileX = slot2
	slot1.tileY = slot3

	transformhelper.setLocalPos(slot1.sceneTf, slot4, slot5, slot6)
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

	slot0:recycleAllAlarmItem()

	if not ActivityChessGameController.instance.interacts then
		return
	end

	if not ActivityChessGameController.instance.interacts:getList() then
		return
	end

	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot7:getHandler():onDrawAlert(slot2)
	end

	for slot6, slot7 in pairs(slot2) do
		for slot11, slot12 in pairs(slot7) do
			slot13 = slot0:createAlarmItem()

			gohelper.setActive(slot13.go, true)

			slot14, slot15, slot16 = ActivityChessGameController.instance:calcTilePosInScene(slot6, slot11)
			slot13.tileX = slot6
			slot13.tileY = slot11

			transformhelper.setLocalPos(slot13.sceneTf, slot14, slot15, slot16)
		end
	end
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

	Activity109ChessController.instance:dispatchEvent(ActivityChessEvent.GuideOnEnterMap, tostring(Activity109ChessModel.instance:getEpisodeId()))
end

function slot0._guideClickTile(slot0, slot1)
	slot2 = string.splitToNumber(slot1, "_")

	slot0:onClickChessPos(slot2[1], slot2[2])
end

function slot0.onClickContainer(slot0)
	slot1 = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), slot0._tfTouch)
	slot2, slot3 = ActivityChessGameController.instance:getNearestScenePos(slot1.x, slot1.y)

	if slot2 then
		logNormal("click Scene tileX, tileY : " .. tostring(slot2) .. ", " .. tostring(slot3))
		slot0:onClickChessPos(slot2, slot3)
	end
end

function slot0.onClickChessPos(slot0, slot1, slot2)
	if not ActivityChessGameController.instance:checkInActivityDuration() then
		return
	end

	if ActivityChessGameController.instance.event and slot3:getCurEvent() and slot3:getCurEvent() then
		slot4:onClickPos(slot1, slot2, true)
	end
end

function slot0.getBaseTile(slot0, slot1, slot2)
	return slot0._baseTiles[slot1 + 1][slot2 + 1]
end

return slot0
