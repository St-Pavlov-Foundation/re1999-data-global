module("modules.logic.activity.view.chessmap.ActivityChessGameScene", package.seeall)

local var_0_0 = class("ActivityChessGameScene", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._gochessboard = gohelper.findChild(arg_1_0.viewGO, "scroll/viewport/#go_content/#go_chessboard")
	arg_1_0._gotouch = gohelper.findChild(arg_1_0.viewGO, "#go_touch")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

var_0_0.BLOCK_KEY = "ActivityChessGameSceneLoading"

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._tfTouch = arg_4_0._gotouch.transform
	arg_4_0._click = SLFramework.UGUI.UIClickListener.Get(arg_4_0._gotouch)

	arg_4_0._click:AddClickListener(arg_4_0.onClickContainer, arg_4_0)

	arg_4_0._handler = ActivityChessGameHandler.New()

	arg_4_0._handler:init(arg_4_0)

	arg_4_0._baseTiles = {}
	arg_4_0._baseTilePool = {}
	arg_4_0._dirItems = {}
	arg_4_0._dirItemPool = {}
	arg_4_0._alarmItems = {}
	arg_4_0._alarmItemPool = {}
	arg_4_0._avatars = {}
	arg_4_0._fixedOrder = 0

	arg_4_0:createSceneRoot()
	arg_4_0:initCamera()
	ActivityChessGameController.instance:initSceneTree(arg_4_0._gotouch, arg_4_0._sceneOffsetY)
	arg_4_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_4_0.onScreenResize, arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.DestroyViewFinish, arg_4_0.onDestroyOtherView, arg_4_0)
	arg_4_0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.InteractObjectCreated, arg_4_0.createInteractObj, arg_4_0)
	arg_4_0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.DeleteInteractAvatar, arg_4_0.deleteInteractObj, arg_4_0)
	arg_4_0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.ResetMapView, arg_4_0.onResetMapView, arg_4_0)
	arg_4_0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.SetNeedChooseDirectionVisible, arg_4_0.onSetDirectionVisible, arg_4_0)
	arg_4_0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.GameReset, arg_4_0.onResetGame, arg_4_0)
	arg_4_0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.RefreshAlarmArea, arg_4_0.onAlarmAreaRefresh, arg_4_0)
	arg_4_0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.GameMapDataUpdate, arg_4_0.onGameDataUpdate, arg_4_0)
	arg_4_0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.GuideClickTile, arg_4_0._guideClickTile, arg_4_0)
	arg_4_0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.ResetGameByResultView, arg_4_0.handleResetByResult, arg_4_0)
	arg_4_0:loadRes()
end

function var_0_0.onDestroyView(arg_5_0)
	if arg_5_0._click then
		arg_5_0._click:RemoveClickListener()

		arg_5_0._click = nil
	end

	if arg_5_0._handler then
		arg_5_0._handler:dispose()

		arg_5_0._handler = nil
	end

	arg_5_0._baseTiles = nil

	arg_5_0:resetCamera()
	arg_5_0:releaseRes()
	arg_5_0:disposeSceneRoot()
	TaskDispatcher.cancelTask(arg_5_0.delayRefreshAlarmArea, arg_5_0)

	arg_5_0._isWaitingRefreshAlarm = false
end

function var_0_0.onOpen(arg_6_0)
	return
end

function var_0_0.onOpenFinish(arg_7_0)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.GameViewOpened, arg_7_0.viewParam)
end

function var_0_0.onClose(arg_8_0)
	UIBlockMgr.instance:endBlock(var_0_0.BLOCK_KEY)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.Stop)
end

function var_0_0.playAudio(arg_9_0)
	local var_9_0 = ActivityChessGameModel.instance:getActId()
	local var_9_1 = ActivityChessGameModel.instance:getMapId()

	if var_9_0 and var_9_1 then
		local var_9_2 = Activity109Config.instance:getMapCo(var_9_0, var_9_1)

		if var_9_2 then
			AudioMgr.instance:trigger(var_9_2.audioAmbient)
		end
	end
end

function var_0_0.onDestroyOtherView(arg_10_0, arg_10_1)
	arg_10_0:onScreenResize()
end

function var_0_0.onScreenResize(arg_11_0)
	local var_11_0 = CameraMgr.instance:getMainCamera()

	var_11_0.orthographic = true
	var_11_0.orthographicSize = 7.5 * GameUtil.getAdapterScale(true)
end

function var_0_0.initCamera(arg_12_0)
	if arg_12_0._isInitCamera then
		return
	end

	arg_12_0._isInitCamera = true

	arg_12_0:onScreenResize()
end

function var_0_0.resetCamera(arg_13_0)
	local var_13_0 = CameraMgr.instance:getMainCamera()

	var_13_0.orthographicSize = 5
	var_13_0.orthographic = false
end

function var_0_0.loadRes(arg_14_0)
	UIBlockMgr.instance:startBlock(var_0_0.BLOCK_KEY)

	arg_14_0._loader = MultiAbLoader.New()

	arg_14_0._loader:addPath(arg_14_0:getCurrentSceneUrl())
	arg_14_0._loader:addPath(ActivityChessEnum.SceneResPath.GroundItem)
	arg_14_0._loader:addPath(ActivityChessEnum.SceneResPath.DirItem)
	arg_14_0._loader:addPath(ActivityChessEnum.SceneResPath.AlarmItem)
	arg_14_0._loader:startLoad(arg_14_0.onLoadResCompleted, arg_14_0)
end

function var_0_0.getCurrentSceneUrl(arg_15_0)
	local var_15_0 = ActivityChessGameModel.instance:getMapId()
	local var_15_1 = ActivityChessGameModel.instance:getActId()
	local var_15_2 = Activity109Config.instance:getMapCo(var_15_1, var_15_0)

	if var_15_2 and not string.nilorempty(var_15_2.bgPath) then
		return string.format(ActivityChessEnum.SceneResPath.SceneFormatPath, var_15_2.bgPath)
	else
		return ActivityChessEnum.SceneResPath.DefaultScene
	end
end

function var_0_0.onLoadResCompleted(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1:getAssetItem(arg_16_0:getCurrentSceneUrl())

	if var_16_0 then
		arg_16_0._sceneGo = gohelper.clone(var_16_0:GetResource(), arg_16_0._sceneRoot, "scene")
		arg_16_0._sceneAnim = arg_16_0._sceneGo:GetComponent(typeof(UnityEngine.Animator))
		arg_16_0._sceneBackground = UnityEngine.GameObject.New("background")
		arg_16_0._sceneGround = UnityEngine.GameObject.New("ground")
		arg_16_0._sceneContainer = UnityEngine.GameObject.New("container")

		arg_16_0._sceneBackground.transform:SetParent(arg_16_0._sceneGo.transform, false)
		arg_16_0._sceneGround.transform:SetParent(arg_16_0._sceneGo.transform, false)
		arg_16_0._sceneContainer.transform:SetParent(arg_16_0._sceneGo.transform, false)
		transformhelper.setLocalPos(arg_16_0._sceneBackground.transform, 0, 0, -0.5)
		transformhelper.setLocalPos(arg_16_0._sceneGround.transform, 0, 0, -1)
		transformhelper.setLocalPos(arg_16_0._sceneContainer.transform, 0, 0, -1.5)
		arg_16_0:fillChessBoardBase()
		arg_16_0:createAllInteractObjs()

		if not ActivityChessGameController.instance:getSelectObj() then
			ActivityChessGameController.instance:autoSelectPlayer()
		end

		arg_16_0:playEnterAnim()
		arg_16_0:playAudio()
	end

	UIBlockMgr.instance:endBlock(var_0_0.BLOCK_KEY)
end

function var_0_0.releaseRes(arg_17_0)
	if arg_17_0._loader then
		arg_17_0._loader:dispose()

		arg_17_0._loader = nil
	end
end

function var_0_0.createSceneRoot(arg_18_0)
	local var_18_0 = CameraMgr.instance:getMainCameraTrs().parent
	local var_18_1 = CameraMgr.instance:getSceneRoot()

	arg_18_0._sceneRoot = UnityEngine.GameObject.New("ChessMap")

	local var_18_2, var_18_3, var_18_4 = transformhelper.getLocalPos(var_18_0)

	transformhelper.setLocalPos(arg_18_0._sceneRoot.transform, 0, var_18_3, 0)

	arg_18_0._sceneOffsetY = var_18_3

	gohelper.addChild(var_18_1, arg_18_0._sceneRoot)
end

function var_0_0.disposeSceneRoot(arg_19_0)
	if arg_19_0._sceneRoot then
		gohelper.destroy(arg_19_0._sceneRoot)

		arg_19_0._sceneRoot = nil
	end
end

function var_0_0.fillChessBoardBase(arg_20_0)
	local var_20_0, var_20_1 = ActivityChessGameModel.instance:getGameSize()

	logNormal("fill w = " .. tostring(var_20_0) .. ", h = " .. tostring(var_20_1))

	for iter_20_0 = 1, var_20_0 do
		arg_20_0._baseTiles[iter_20_0] = arg_20_0._baseTiles[iter_20_0] or {}

		for iter_20_1 = 1, var_20_1 do
			local var_20_2 = arg_20_0:createTileBaseItem(iter_20_0 - 1, iter_20_1 - 1)

			arg_20_0._baseTiles[iter_20_0][iter_20_1] = var_20_2

			local var_20_3 = ActivityChessGameModel.instance:getBaseTile(iter_20_0 - 1, iter_20_1 - 1)

			gohelper.setActive(var_20_2.go, var_20_3 == ActivityChessEnum.TileBaseType.Normal)
		end
	end
end

function var_0_0.createTileBaseItem(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0
	local var_21_1 = #arg_21_0._baseTilePool

	if var_21_1 > 0 then
		var_21_0 = arg_21_0._baseTilePool[var_21_1]
		arg_21_0._baseTilePool[var_21_1] = nil
	end

	if not var_21_0 then
		var_21_0 = arg_21_0:getUserDataTb_()

		local var_21_2 = arg_21_0._loader:getAssetItem(ActivityChessEnum.SceneResPath.GroundItem)
		local var_21_3 = gohelper.clone(var_21_2:GetResource(), arg_21_0._sceneBackground, "tilebase_" .. arg_21_1 .. "_" .. arg_21_2)

		var_21_0.go = var_21_3
		var_21_0.sceneTf = var_21_3.transform
	end

	arg_21_0:setTileBasePosition(var_21_0, arg_21_1, arg_21_2)

	return var_21_0
end

function var_0_0.setTileBasePosition(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0, var_22_1, var_22_2 = ActivityChessGameController.instance:calcTilePosInScene(arg_22_2, arg_22_3)

	transformhelper.setLocalPos(arg_22_1.sceneTf, var_22_0, var_22_1, var_22_2)
end

function var_0_0.resetTiles(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0._baseTiles) do
		for iter_23_2, iter_23_3 in pairs(iter_23_1) do
			table.insert(arg_23_0._baseTilePool, arg_23_0._baseTiles[iter_23_0][iter_23_2])
		end
	end

	arg_23_0._baseTiles = {}

	arg_23_0:fillChessBoardBase()
end

function var_0_0.createAllInteractObjs(arg_24_0)
	logNormal("createAllObjects")

	if not ActivityChessGameController.instance.interacts then
		return
	end

	local var_24_0 = ActivityChessGameController.instance.interacts:getList()

	table.sort(var_24_0, ActivityChessInteractMgr.sortRenderOrder)

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		arg_24_0:createInteractObj(iter_24_1)
	end

	arg_24_0:addEventCb(ActivityChessGameController.instance, ActivityChessEvent.AllObjectCreated, arg_24_0.createAllInteractObjs, arg_24_0)
end

function var_0_0.createInteractObj(arg_25_0, arg_25_1)
	local var_25_0 = ActivityChessInteractMgr.getRenderOrder(arg_25_1)
	local var_25_1 = arg_25_0:getUserDataTb_()

	var_25_1.sceneGo = UnityEngine.GameObject.New("item_" .. arg_25_1.id)
	var_25_1.sceneTf = var_25_1.sceneGo.transform
	var_25_1.loader = PrefabInstantiate.Create(var_25_1.sceneGo)

	var_25_1.sceneTf:SetParent(arg_25_0._sceneContainer.transform, false)

	var_25_1.order = var_25_0 + arg_25_0._fixedOrder
	arg_25_0._fixedOrder = arg_25_0._fixedOrder + 0.01

	arg_25_1:setAvatar(var_25_1)
	table.insert(arg_25_0._avatars, var_25_1)
end

function var_0_0.deleteInteractObj(arg_26_0, arg_26_1)
	tabletool.removeValue(arg_26_0._avatars, arg_26_1)
end

function var_0_0.createDirItem(arg_27_0)
	local var_27_0
	local var_27_1 = #arg_27_0._dirItemPool

	if var_27_1 > 0 then
		var_27_0 = arg_27_0._dirItemPool[var_27_1]
		arg_27_0._dirItemPool[var_27_1] = nil
	end

	if not var_27_0 then
		var_27_0 = arg_27_0:getUserDataTb_()

		local var_27_2 = arg_27_0._loader:getAssetItem(ActivityChessEnum.SceneResPath.DirItem)

		var_27_0.go = gohelper.clone(var_27_2:GetResource(), arg_27_0._sceneGround, "dirItem")
		var_27_0.sceneTf = var_27_0.go.transform
		var_27_0.goCenter = gohelper.findChild(var_27_0.go, "#go_center")
		var_27_0.goNormal = gohelper.findChild(var_27_0.go, "#go_normal")
		var_27_0.goItem = gohelper.findChild(var_27_0.go, "#go_item")
	end

	table.insert(arg_27_0._dirItems, var_27_0)

	return var_27_0
end

function var_0_0.recycleAllDirItem(arg_28_0)
	for iter_28_0, iter_28_1 in pairs(arg_28_0._dirItems) do
		gohelper.setActive(iter_28_1.go, false)
		table.insert(arg_28_0._dirItemPool, iter_28_1)

		arg_28_0._dirItems[iter_28_0] = nil
	end
end

function var_0_0.createAlarmItem(arg_29_0)
	local var_29_0
	local var_29_1 = #arg_29_0._alarmItemPool

	if var_29_1 > 0 then
		var_29_0 = arg_29_0._alarmItemPool[var_29_1]
		arg_29_0._alarmItemPool[var_29_1] = nil
	end

	if not var_29_0 then
		var_29_0 = arg_29_0:getUserDataTb_()

		local var_29_2 = arg_29_0._loader:getAssetItem(ActivityChessEnum.SceneResPath.AlarmItem)

		var_29_0.go = gohelper.clone(var_29_2:GetResource(), arg_29_0._sceneGround, "alarmItem")
		var_29_0.sceneTf = var_29_0.go.transform
	end

	table.insert(arg_29_0._alarmItems, var_29_0)

	return var_29_0
end

function var_0_0.recycleAllAlarmItem(arg_30_0)
	for iter_30_0, iter_30_1 in pairs(arg_30_0._alarmItems) do
		gohelper.setActive(iter_30_1.go, false)
		table.insert(arg_30_0._alarmItemPool, iter_30_1)

		arg_30_0._alarmItems[iter_30_0] = nil
	end
end

function var_0_0.onResetMapView(arg_31_0)
	arg_31_0:resetTiles()
end

function var_0_0.onResetGame(arg_32_0)
	arg_32_0._fixedOrder = 1

	arg_32_0:playEnterAnim()
end

function var_0_0.onGameDataUpdate(arg_33_0)
	if not ActivityChessGameController.instance:getSelectObj() then
		ActivityChessGameController.instance:autoSelectPlayer()
	end
end

function var_0_0.onSetDirectionVisible(arg_34_0, arg_34_1)
	arg_34_0:recycleAllDirItem()

	if arg_34_1 and arg_34_1.visible then
		local var_34_0 = arg_34_1.selectType or ActivityChessEnum.ChessSelectType.Normal

		for iter_34_0 = 1, #arg_34_1.posXList do
			local var_34_1 = arg_34_0:createDirItem()

			arg_34_0:addDirectionItem(var_34_1, arg_34_1.posXList[iter_34_0], arg_34_1.posYList[iter_34_0])
			gohelper.setActive(var_34_1.goNormal, ActivityChessEnum.ChessSelectType.Normal == var_34_0)
			gohelper.setActive(var_34_1.goItem, ActivityChessEnum.ChessSelectType.UseItem == var_34_0)
			gohelper.setActive(var_34_1.goCenter, false)
		end

		if arg_34_1.selfPosX ~= nil and arg_34_1.selfPosY ~= nil then
			local var_34_2 = arg_34_0:createDirItem()

			arg_34_0:addDirectionItem(var_34_2, arg_34_1.selfPosX, arg_34_1.selfPosY)
			gohelper.setActive(var_34_2.goNormal, false)
			gohelper.setActive(var_34_2.goItem, false)
			gohelper.setActive(var_34_2.goCenter, true)
		end
	end
end

function var_0_0.addDirectionItem(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	gohelper.setActive(arg_35_1.go, true)

	local var_35_0, var_35_1, var_35_2 = ActivityChessGameController.instance:calcTilePosInScene(arg_35_2, arg_35_3)

	arg_35_1.tileX = arg_35_2
	arg_35_1.tileY = arg_35_3

	transformhelper.setLocalPos(arg_35_1.sceneTf, var_35_0, var_35_1, var_35_2)
end

function var_0_0.onAlarmAreaRefresh(arg_36_0)
	if arg_36_0._isWaitingRefreshAlarm then
		return
	end

	arg_36_0._isWaitingRefreshAlarm = true

	TaskDispatcher.runDelay(arg_36_0.delayRefreshAlarmArea, arg_36_0, 0.001)
end

function var_0_0.delayRefreshAlarmArea(arg_37_0)
	TaskDispatcher.cancelTask(arg_37_0.delayRefreshAlarmArea, arg_37_0)

	arg_37_0._isWaitingRefreshAlarm = false

	arg_37_0:recycleAllAlarmItem()

	if not ActivityChessGameController.instance.interacts then
		return
	end

	local var_37_0 = ActivityChessGameController.instance.interacts:getList()

	if not var_37_0 then
		return
	end

	local var_37_1 = {}

	for iter_37_0, iter_37_1 in ipairs(var_37_0) do
		iter_37_1:getHandler():onDrawAlert(var_37_1)
	end

	for iter_37_2, iter_37_3 in pairs(var_37_1) do
		for iter_37_4, iter_37_5 in pairs(iter_37_3) do
			local var_37_2 = arg_37_0:createAlarmItem()

			gohelper.setActive(var_37_2.go, true)

			local var_37_3, var_37_4, var_37_5 = ActivityChessGameController.instance:calcTilePosInScene(iter_37_2, iter_37_4)

			var_37_2.tileX = iter_37_2
			var_37_2.tileY = iter_37_4

			transformhelper.setLocalPos(var_37_2.sceneTf, var_37_3, var_37_4, var_37_5)
		end
	end
end

function var_0_0.handleResetByResult(arg_38_0)
	if arg_38_0._sceneAnim then
		arg_38_0._sceneAnim:Play("open", 0, 0)
	end
end

function var_0_0.playEnterAnim(arg_39_0)
	if arg_39_0._sceneAnim then
		arg_39_0._sceneAnim:Play(UIAnimationName.Open, 0, 0)
	end

	local var_39_0 = Activity109ChessModel.instance:getEpisodeId()

	Activity109ChessController.instance:dispatchEvent(ActivityChessEvent.GuideOnEnterMap, tostring(var_39_0))
end

function var_0_0._guideClickTile(arg_40_0, arg_40_1)
	local var_40_0 = string.splitToNumber(arg_40_1, "_")
	local var_40_1 = var_40_0[1]
	local var_40_2 = var_40_0[2]

	arg_40_0:onClickChessPos(var_40_1, var_40_2)
end

function var_0_0.onClickContainer(arg_41_0)
	local var_41_0 = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), arg_41_0._tfTouch)
	local var_41_1, var_41_2 = ActivityChessGameController.instance:getNearestScenePos(var_41_0.x, var_41_0.y)

	if var_41_1 then
		logNormal("click Scene tileX, tileY : " .. tostring(var_41_1) .. ", " .. tostring(var_41_2))
		arg_41_0:onClickChessPos(var_41_1, var_41_2)
	end
end

function var_0_0.onClickChessPos(arg_42_0, arg_42_1, arg_42_2)
	if not ActivityChessGameController.instance:checkInActivityDuration() then
		return
	end

	local var_42_0 = ActivityChessGameController.instance.event

	if var_42_0 and var_42_0:getCurEvent() then
		local var_42_1 = var_42_0:getCurEvent()

		if var_42_1 then
			var_42_1:onClickPos(arg_42_1, arg_42_2, true)
		end
	end
end

function var_0_0.getBaseTile(arg_43_0, arg_43_1, arg_43_2)
	return arg_43_0._baseTiles[arg_43_1 + 1][arg_43_2 + 1]
end

return var_0_0
