module("modules.logic.chessgame.game.scene.ChessGameScene", package.seeall)

local var_0_0 = class("ChessGameScene", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotouch = gohelper.findChild(arg_1_0.viewGO, "#go_touch")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._tfTouch = arg_2_0._gotouch.transform
	arg_2_0._click = SLFramework.UGUI.UIClickListener.Get(arg_2_0._gotouch)

	arg_2_0._click:AddClickListener(arg_2_0.onClickContainer, arg_2_0)

	arg_2_0._baseTiles = {}
	arg_2_0._baseTilePool = {}
	arg_2_0._dirItems = {}
	arg_2_0._dirItemPool = {}
	arg_2_0._alarmItems = {}
	arg_2_0._alarmItemPool = {}
	arg_2_0._interactItemList = {}
	arg_2_0._baffleItems = {}
	arg_2_0._baffleItemPool = {}
	arg_2_0._avatarMap = {}
	arg_2_0.loadDoneInteractList = {}
	arg_2_0.needLoadInteractIdList = {}
	arg_2_0._fixedOrder = 0

	MainCameraMgr.instance:addView(arg_2_0.viewName, arg_2_0.initCamera, nil, arg_2_0)
	arg_2_0:addEventCb(ChessGameController.instance, ChessGameEvent.DeleteInteractAvatar, arg_2_0.deleteInteractObj, arg_2_0)
	arg_2_0:addEventCb(ChessGameController.instance, ChessGameEvent.AddInteractObj, arg_2_0.createOrUpdateInteractItem, arg_2_0)
	arg_2_0:addEventCb(ChessGameController.instance, ChessGameEvent.ChangeMap, arg_2_0.changeMap, arg_2_0)
	arg_2_0:addEventCb(ChessGameController.instance, ChessGameEvent.GamePointReturn, arg_2_0._onGamePointReturn, arg_2_0)
	arg_2_0:addEventCb(ChessGameController.instance, ChessGameEvent.SetAlarmAreaVisible, arg_2_0.onSetAlarmAreaVisible, arg_2_0)
	arg_2_0:addEventCb(ChessGameController.instance, ChessGameEvent.SetNeedChooseDirectionVisible, arg_2_0.onSetDirectionVisible, arg_2_0)
	arg_2_0:addEventCb(ChessGameController.instance, ChessGameEvent.GameReset, arg_2_0.onResetGame, arg_2_0)
	arg_2_0:addEventCb(ChessGameController.instance, ChessGameEvent.GameMapDataUpdate, arg_2_0.onGameDataUpdate, arg_2_0)
	arg_2_0:addEventCb(ChessGameController.instance, ChessGameEvent.GameResultQuit, arg_2_0.onResultQuit, arg_2_0)
	arg_2_0:addEventCb(ChessGameController.instance, ChessGameEvent.PlayStoryFinish, arg_2_0._onPlayStoryFinish, arg_2_0)
	arg_2_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_2_0.onScreenResize, arg_2_0)
	arg_2_0:createSceneRoot()
	arg_2_0:loadRes()
end

function var_0_0.createSceneRoot(arg_3_0)
	local var_3_0 = CameraMgr.instance:getMainCameraTrs().parent
	local var_3_1 = CameraMgr.instance:getSceneRoot()

	arg_3_0._sceneRoot = UnityEngine.GameObject.New("ChessGameScene")
	arg_3_0._sceneBackground = UnityEngine.GameObject.New("background")
	arg_3_0._sceneGround = UnityEngine.GameObject.New("ground")
	arg_3_0._sceneContainer = UnityEngine.GameObject.New("container")

	local var_3_2, var_3_3, var_3_4 = transformhelper.getLocalPos(var_3_0)

	transformhelper.setLocalPos(arg_3_0._sceneRoot.transform, 0, var_3_3, 0)

	arg_3_0._sceneOffsetY = var_3_3

	gohelper.addChild(var_3_1, arg_3_0._sceneRoot)
	gohelper.addChild(arg_3_0._sceneRoot, arg_3_0._sceneBackground)
	gohelper.addChild(arg_3_0._sceneRoot, arg_3_0._sceneGround)
	gohelper.addChild(arg_3_0._sceneRoot, arg_3_0._sceneContainer)
end

function var_0_0.initCamera(arg_4_0)
	if arg_4_0._isInitCamera then
		return
	end

	arg_4_0._isInitCamera = true

	arg_4_0:onScreenResize()
end

function var_0_0.onScreenResize(arg_5_0)
	local var_5_0 = CameraMgr.instance:getMainCamera()

	var_5_0.orthographic = true
	var_5_0.orthographicSize = 7.5 * GameUtil.getAdapterScale(true)
end

function var_0_0._onPlayStoryFinish(arg_6_0)
	ChessGameController.instance:setSceneCamera(true)
end

function var_0_0.loadRes(arg_7_0)
	UIBlockMgr.instance:startBlock(var_0_0.BLOCK_KEY)

	arg_7_0._loader = MultiAbLoader.New()

	arg_7_0._loader:addPath(arg_7_0:getCurrentSceneUrl())
	arg_7_0._loader:addPath(arg_7_0:getGroundItemUrl())
	arg_7_0._loader:addPath(ChessGameEnum.SceneResPath.DirItem)
	arg_7_0._loader:addPath(ChessGameEnum.SceneResPath.AlarmItem)
	arg_7_0:onLoadRes()
	arg_7_0._loader:startLoad(arg_7_0.loadResCompleted, arg_7_0)
end

function var_0_0.onLoadRes(arg_8_0)
	return
end

function var_0_0.onloadResCompleted(arg_9_0, arg_9_1)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.GameLoadingMapStateUpdate, ChessGameEvent.LoadingMapState.Finish, true)
end

function var_0_0.getGroundItemUrl(arg_10_0)
	return ChessGameEnum.NodePath
end

function var_0_0.getCurrentSceneUrl(arg_11_0)
	return ChessGameModel.instance:getNowMapResPath()
end

function var_0_0.onOpen(arg_12_0)
	return
end

function var_0_0.loadResCompleted(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1:getAssetItem(ChessGameModel.instance:getNowMapResPath())

	if var_13_0 then
		arg_13_0._sceneGo = gohelper.clone(var_13_0:GetResource(), arg_13_0._sceneRoot, "scene")
		arg_13_0._sceneAnim = arg_13_0._sceneGo:GetComponent(typeof(UnityEngine.Animator))

		arg_13_0._sceneBackground.transform:SetParent(arg_13_0._sceneGo.transform, false)
		arg_13_0._sceneGround.transform:SetParent(arg_13_0._sceneGo.transform, false)
		arg_13_0._sceneContainer.transform:SetParent(arg_13_0._sceneGo.transform, false)
		transformhelper.setLocalPos(arg_13_0._sceneBackground.transform, 0, 0, -0.5)
		transformhelper.setLocalPos(arg_13_0._sceneGround.transform, 0, 0, -1)
		transformhelper.setLocalPos(arg_13_0._sceneContainer.transform, 0, 0, -1.5)
		arg_13_0:fillChessBoardBase()
		arg_13_0:createAllInteractObjs()
		arg_13_0:onloadResCompleted(arg_13_1)
		arg_13_0:playEnterAnim()
		ChessGameController.instance:autoSelectPlayer()
	end

	UIBlockMgr.instance:endBlock(var_0_0.BLOCK_KEY)

	local var_13_1 = ChessModel.instance:getEpisodeId()

	ChessController.instance:dispatchEvent(ChessGameEvent.GuideOnEnterEpisode, tostring(var_13_1))
end

function var_0_0.changeMap(arg_14_0, arg_14_1)
	if not arg_14_1 then
		return
	end

	if not arg_14_0._oldLoader then
		arg_14_0._oldLoader = arg_14_0._loader
		arg_14_0._oldSceneGo = arg_14_0._sceneGo
	elseif arg_14_0._loader then
		arg_14_0._loader:dispose()

		arg_14_0._loader = nil
	end

	local var_14_0 = arg_14_1

	ChessGameModel.instance:setNowMapResPath(var_14_0)
	arg_14_0:loadRes()
end

function var_0_0.playEnterAnim(arg_15_0)
	if arg_15_0._sceneAnim then
		arg_15_0._sceneAnim:Play(UIAnimationName.Open, 0, 0)
	end
end

function var_0_0.playAudio(arg_16_0)
	local var_16_0 = ChessGameModel.instance:getActId()

	if var_16_0 then
		local var_16_1 = ChessGameConfig.instance:getMapCo(var_16_0)

		arg_16_0:stopAudio()

		if var_16_1 and var_16_1.audioAmbient ~= 0 then
			arg_16_0._triggerAmbientId = AudioMgr.instance:trigger(var_16_1.audioAmbient)
		end
	end
end

function var_0_0.fillChessBoardBase(arg_17_0)
	arg_17_0:resetTiles()

	local var_17_0 = ChessGameNodeModel.instance:getAllNodes()

	for iter_17_0, iter_17_1 in pairs(var_17_0) do
		arg_17_0._baseTiles[iter_17_0] = arg_17_0._baseTiles[iter_17_0] or {}

		for iter_17_2, iter_17_3 in pairs(iter_17_1) do
			local var_17_1 = arg_17_0:createTileBaseItem(iter_17_0, iter_17_2)

			arg_17_0._baseTiles[iter_17_0][iter_17_2] = var_17_1

			arg_17_0:onTileItemCreate(iter_17_0, iter_17_2, var_17_1)
		end
	end
end

function var_0_0.onTileItemCreate(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	return
end

function var_0_0.createTileBaseItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0
	local var_19_1 = arg_19_0._baseTiles[arg_19_1][arg_19_2]

	if not var_19_1 then
		var_19_1 = arg_19_0:getUserDataTb_()

		local var_19_2 = arg_19_0:getGroundItemUrl(arg_19_1, arg_19_2)
		local var_19_3 = arg_19_0._loader:getAssetItem(var_19_2)
		local var_19_4 = gohelper.clone(var_19_3:GetResource(), arg_19_0._sceneBackground, "tilebase_" .. arg_19_1 .. "_" .. arg_19_2)

		var_19_1.go = var_19_4
		var_19_1.sceneTf = var_19_4.transform
		var_19_1.pos = {
			x = arg_19_1,
			y = arg_19_2
		}
	end

	gohelper.setActive(var_19_1.go, true)

	var_19_1.sceneTf.position = Vector3(arg_19_1, arg_19_2, 0)

	arg_19_0:setTileBasePosition(var_19_1.sceneTf)

	return var_19_1
end

function var_0_0.setTileBasePosition(arg_20_0, arg_20_1)
	local var_20_0 = ChessGameHelper.nodePosToWorldPos(arg_20_1.position)

	transformhelper.setLocalPos(arg_20_1, var_20_0.x, var_20_0.y, var_20_0.z)
end

function var_0_0.createAllInteractObjs(arg_21_0)
	if not ChessGameController.instance.interactsMgr then
		return
	end

	local var_21_0 = ChessGameController.instance.interactsMgr:getList()

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		if iter_21_1:isShow() then
			arg_21_0:createOrUpdateInteractItem(iter_21_1)
		end
	end

	arg_21_0:addEventCb(ChessGameController.instance, ChessGameEvent.AllObjectCreated, arg_21_0.createAllInteractObjs, arg_21_0)
end

function var_0_0.createOrUpdateInteractItem(arg_22_0, arg_22_1)
	if gohelper.isNil(arg_22_0._sceneContainer) then
		logNormal("ChessGameScene: game is already end")

		return
	end

	local var_22_0 = arg_22_0._avatarMap[arg_22_1.id]

	if not var_22_0 then
		var_22_0 = arg_22_0:getUserDataTb_()
		var_22_0.sceneGo = UnityEngine.GameObject.New("item_" .. arg_22_1.id)
		var_22_0.sceneTf = var_22_0.sceneGo.transform
		var_22_0.loader = PrefabInstantiate.Create(var_22_0.sceneGo)

		var_22_0.sceneTf:SetParent(arg_22_0._sceneContainer.transform, false)

		arg_22_0._avatarMap[arg_22_1.id] = var_22_0
	end

	arg_22_1:setAvatar(var_22_0)
end

function var_0_0.deleteInteractObj(arg_23_0, arg_23_1)
	arg_23_0._avatarMap[arg_23_1] = nil
end

function var_0_0.onSetDirectionVisible(arg_24_0, arg_24_1)
	arg_24_0:recycleAllDirItem()

	if not arg_24_1 then
		return
	end

	if arg_24_1.visible then
		local var_24_0 = arg_24_1.selectType or ChessGameEnum.ChessSelectType.Normal

		for iter_24_0 = 1, #arg_24_1.posXList do
			local var_24_1 = arg_24_0:createDirItem()

			arg_24_0:addDirectionItem(var_24_1, arg_24_1.posXList[iter_24_0], arg_24_1.posYList[iter_24_0])

			local var_24_2 = arg_24_1.dirList[iter_24_0]

			for iter_24_1, iter_24_2 in pairs(ChessGameEnum.Direction) do
				gohelper.setActive(var_24_1["goDir" .. iter_24_2], iter_24_2 == var_24_2)
			end

			gohelper.setActive(var_24_1.goNormal, ChessGameEnum.ChessSelectType.Normal == var_24_0)
			gohelper.setActive(var_24_1.goItem, ChessGameEnum.ChessSelectType.CatchObj == var_24_0)
			gohelper.setActive(var_24_1.goCenter, false)
		end

		if arg_24_1.selfPosX ~= nil and arg_24_1.selfPosY ~= nil then
			local var_24_3 = arg_24_0:createDirItem()

			arg_24_0:addDirectionItem(var_24_3, arg_24_1.selfPosX, arg_24_1.selfPosY)
			gohelper.setActive(var_24_3.goNormal, false)
			gohelper.setActive(var_24_3.goItem, false)
			gohelper.setActive(var_24_3.goCenter, true)
		end

		if ChessGameEnum.ChessSelectType.Normal == var_24_0 then
			local var_24_4 = {
				arg_24_1.selfPosX + 1,
				arg_24_1.selfPosX - 1,
				arg_24_1.selfPosX,
				arg_24_1.selfPosX
			}
			local var_24_5 = {
				arg_24_1.selfPosY,
				arg_24_1.selfPosY,
				arg_24_1.selfPosY + 1,
				arg_24_1.selfPosY - 1
			}

			ChessGameController.instance:checkInteractCanUse(var_24_4, var_24_5)
		end
	end
end

function var_0_0.recycleAllDirItem(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(arg_25_0._dirItems) do
		gohelper.setActive(iter_25_1.go, false)
		table.insert(arg_25_0._dirItemPool, iter_25_1)

		arg_25_0._dirItems[iter_25_0] = nil
	end
end

function var_0_0.createDirItem(arg_26_0)
	local var_26_0
	local var_26_1 = #arg_26_0._dirItemPool

	if var_26_1 > 0 then
		var_26_0 = arg_26_0._dirItemPool[var_26_1]
		arg_26_0._dirItemPool[var_26_1] = nil
	end

	if not var_26_0 then
		var_26_0 = arg_26_0:getUserDataTb_()

		local var_26_2 = arg_26_0._loader:getAssetItem(ChessGameEnum.SceneResPath.DirItem)

		var_26_0.go = gohelper.clone(var_26_2:GetResource(), arg_26_0._sceneGround, "dirItem")
		var_26_0.sceneTf = var_26_0.go.transform
		var_26_0.goCenter = gohelper.findChild(var_26_0.go, "#go_center")
		var_26_0.goNormal = gohelper.findChild(var_26_0.go, "#go_normal")
		var_26_0.goItem = gohelper.findChild(var_26_0.go, "#go_item")

		for iter_26_0, iter_26_1 in pairs(ChessGameEnum.Direction) do
			var_26_0["goDir" .. iter_26_1] = gohelper.findChild(var_26_0.goItem, "jiantou_" .. iter_26_1)
		end
	end

	table.insert(arg_26_0._dirItems, var_26_0)

	return var_26_0
end

function var_0_0.addDirectionItem(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	gohelper.setActive(arg_27_1.go, true)

	local var_27_0 = {
		z = 0,
		x = arg_27_2,
		y = arg_27_3
	}
	local var_27_1 = ChessGameHelper.nodePosToWorldPos(var_27_0)

	arg_27_1.tileX = arg_27_2
	arg_27_1.tileY = arg_27_3

	transformhelper.setLocalPos(arg_27_1.sceneTf, var_27_1.x, var_27_1.y, var_27_1.z)
end

function var_0_0.onSetAlarmAreaVisible(arg_28_0, arg_28_1)
	arg_28_0:recycleAllAlarmItem()

	if not arg_28_1 then
		return
	end

	if arg_28_1.visible then
		arg_28_0:refreshAlarmArea()
	end
end

function var_0_0.refreshAlarmArea(arg_29_0)
	arg_29_0._isWaitingRefreshAlarm = false

	if not ChessGameController.instance.interactsMgr then
		return
	end

	local var_29_0 = ChessGameController.instance.interactsMgr:getList()

	if not var_29_0 then
		return
	end

	local var_29_1 = {}

	for iter_29_0, iter_29_1 in ipairs(var_29_0) do
		if iter_29_1.objType == ChessGameEnum.InteractType.Hunter then
			iter_29_1:getHandler():onDrawAlert(var_29_1)
		end
	end

	for iter_29_2, iter_29_3 in pairs(var_29_1) do
		for iter_29_4, iter_29_5 in pairs(iter_29_3) do
			for iter_29_6, iter_29_7 in pairs(iter_29_5) do
				arg_29_0:createAlarmItem(iter_29_2, iter_29_4, nil, iter_29_7)
			end
		end
	end
end

function var_0_0.recycleAllAlarmItem(arg_30_0, arg_30_1)
	for iter_30_0, iter_30_1 in pairs(arg_30_0._alarmItems) do
		for iter_30_2, iter_30_3 in pairs(iter_30_1) do
			local var_30_0 = not iter_30_3.isManual
			local var_30_1 = arg_30_1 or not iter_30_3.isStatic

			if var_30_0 and var_30_1 then
				gohelper.setActive(iter_30_3.go, false)

				local var_30_2 = arg_30_0._alarmItemPool[iter_30_3.resPath]

				if not var_30_2 then
					var_30_2 = {}
					arg_30_0._alarmItemPool[iter_30_3.resPath] = var_30_2
				end

				table.insert(var_30_2, iter_30_3)

				iter_30_1[iter_30_2] = nil
			end
		end
	end
end

function var_0_0.createAlarmItem(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	local var_31_0 = false
	local var_31_1 = ChessGameEnum.SceneResPath.AlarmItem

	var_31_1 = type(arg_31_4) == "table" and arg_31_4.resPath or var_31_1

	local var_31_2 = ChessGameHelper.calPosIndex(arg_31_1, arg_31_2)
	local var_31_3 = arg_31_0._alarmItems[var_31_2]

	if var_31_3 then
		for iter_31_0, iter_31_1 in ipairs(var_31_3) do
			if iter_31_1.resPath == var_31_1 then
				return
			end
		end
	end

	local var_31_4
	local var_31_5 = arg_31_0._alarmItemPool[var_31_1]

	if var_31_5 then
		local var_31_6 = #var_31_5

		if var_31_6 > 0 then
			var_31_4 = var_31_5[var_31_6]
			var_31_5[var_31_6] = nil
		end
	end

	if not var_31_4 then
		var_31_4 = arg_31_0:getUserDataTb_()

		local var_31_7 = arg_31_0._loader:getAssetItem(var_31_1) or arg_31_0._loader:getAssetItem(ChessGameEnum.SceneResPath.AlarmItem)

		var_31_4.go = gohelper.clone(var_31_7:GetResource(), arg_31_0._sceneGround, "alarmItem")
		var_31_4.sceneTf = var_31_4.go.transform
	end

	gohelper.setActive(var_31_4.go, true)

	local var_31_8 = {
		z = 0,
		x = arg_31_1,
		y = arg_31_2
	}
	local var_31_9 = ChessGameHelper.nodePosToWorldPos(var_31_8)

	var_31_4.tileX = arg_31_1
	var_31_4.tileY = arg_31_2
	var_31_4.isManual = arg_31_3
	var_31_4.isStatic = var_31_0
	var_31_4.resPath = var_31_1

	transformhelper.setLocalPos(var_31_4.sceneTf, var_31_9.x, var_31_9.y, var_31_9.z)

	if not var_31_3 then
		var_31_3 = {}
		arg_31_0._alarmItems[var_31_2] = var_31_3
	end

	var_31_3[#var_31_3 + 1] = var_31_4

	return var_31_4
end

function var_0_0.addNeedLoadInteractList(arg_32_0, arg_32_1)
	if not tabletool.indexOf(arg_32_0.needLoadInteractIdList, arg_32_1) then
		table.insert(arg_32_0.needLoadInteractIdList, arg_32_1)
	end
end

function var_0_0.findInteractItem(arg_33_0, arg_33_1)
	for iter_33_0, iter_33_1 in ipairs(arg_33_0._interactItemList) do
		if iter_33_1.id == arg_33_1 then
			return iter_33_1
		end
	end
end

function var_0_0.getPlayerInteractItem(arg_34_0)
	return arg_34_0.playerInteractItem
end

function var_0_0.setInteractObjActive(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_0:findInteractItem(arg_35_1)

	if not var_35_0 then
		return
	end

	var_35_0:setActive(arg_35_2)
end

function var_0_0.onClickContainer(arg_36_0, arg_36_1, arg_36_2)
	if ChessGameController.instance:isNeedBlock() then
		return
	end

	local var_36_0 = CameraMgr.instance:getMainCamera()
	local var_36_1 = recthelper.screenPosToWorldPos(GamepadController.instance:getMousePosition(), var_36_0, arg_36_0._sceneBackground.transform.position)

	logNormal("click Scene wolrdX, worldY : " .. tostring(var_36_1.x) .. ", " .. tostring(var_36_1.y))

	local var_36_2 = {
		x = var_36_1.x,
		y = var_36_1.y - arg_36_0._sceneOffsetY,
		z = var_36_1.z
	}
	local var_36_3 = ChessGameHelper.worldPosToNodePos(var_36_2)

	logNormal("click Scene X, Y : " .. tostring(var_36_3.x) .. ", " .. tostring(var_36_3.y))

	if var_36_3 then
		arg_36_0:onClickChessPos(var_36_3.x, var_36_3.y)
	end
end

function var_0_0.onClickChessPos(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = ChessGameController.instance.eventMgr

	if var_37_0 and var_37_0:getCurEvent() then
		local var_37_1 = var_37_0:getCurEvent()

		if var_37_1 then
			var_37_1:onClickPos(arg_37_1, arg_37_2, true)
		end
	end
end

function var_0_0._guideClickTile(arg_38_0, arg_38_1)
	local var_38_0 = string.splitToNumber(arg_38_1, "_")
	local var_38_1 = var_38_0[1]
	local var_38_2 = var_38_0[2]

	arg_38_0:onClickChessPos(var_38_1, var_38_2)
end

function var_0_0.recycleAllInteract(arg_39_0)
	for iter_39_0, iter_39_1 in ipairs(arg_39_0._interactItemList) do
		iter_39_1:deleteSelf()
	end
end

function var_0_0.disposeInteractItem(arg_40_0)
	for iter_40_0, iter_40_1 in ipairs(arg_40_0._interactItemList) do
		iter_40_1:dispose()
	end

	arg_40_0._interactItemList = nil
end

function var_0_0.disposeBaffle(arg_41_0)
	local var_41_0

	for iter_41_0 = 1, #arg_41_0._baffleItems do
		arg_41_0._baffleItems[iter_41_0]:dispose()
	end

	for iter_41_1 = 1, #arg_41_0._baffleItemPool do
		arg_41_0._baffleItemPool[iter_41_1]:dispose()
	end

	arg_41_0._baffleItems = nil
	arg_41_0._baffleItemPool = nil
end

function var_0_0.disposeSceneRoot(arg_42_0)
	if arg_42_0._sceneRoot then
		gohelper.destroy(arg_42_0._sceneRoot)

		arg_42_0._sceneRoot = nil
	end
end

function var_0_0.releaseLoader(arg_43_0)
	if arg_43_0._loader then
		arg_43_0._loader:dispose()

		arg_43_0._loader = nil
	end
end

function var_0_0.refreshNearInteractIcon(arg_44_0)
	ChessGameController.instance.interactsMgr:getMainPlayer():getHandler():calCanWalkArea()
end

function var_0_0.onCancelSelectInteract(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_0:findInteractItem(arg_45_1)

	if var_45_0 and not var_45_0.delete and var_45_0:getHandler() then
		var_45_0:getHandler():onCancelSelect()
	end
end

function var_0_0.onGameDataUpdate(arg_46_0)
	if not ChessGameController.instance:getSelectObj() then
		ChessGameController.instance:autoSelectPlayer(true)
	end
end

function var_0_0.onResetGame(arg_47_0)
	arg_47_0:fillChessBoardBase()
	ChessGameController.instance:setSelectObj(nil)
	ChessGameController.instance:autoSelectPlayer(true)
end

function var_0_0.resetTiles(arg_48_0)
	for iter_48_0, iter_48_1 in pairs(arg_48_0._baseTiles) do
		for iter_48_2, iter_48_3 in pairs(iter_48_1) do
			gohelper.setActive(iter_48_3.go, false)
		end
	end
end

function var_0_0.onClose(arg_49_0)
	if not ChessGameModel.instance:getGameState() then
		ChessStatController.instance:statAbort()
	end
end

function var_0_0.resetCamera(arg_50_0)
	local var_50_0 = CameraMgr.instance:getMainCamera()

	var_50_0.orthographicSize = 5
	var_50_0.orthographic = false
end

function var_0_0.onResultQuit(arg_51_0)
	arg_51_0:closeThis()
end

function var_0_0.onDestroyView(arg_52_0)
	if arg_52_0._click then
		arg_52_0._click:RemoveClickListener()

		arg_52_0._click = nil
	end

	arg_52_0._baseTiles = nil
	arg_52_0._alarmItemPool = {}

	arg_52_0:resetCamera()
	arg_52_0:disposeSceneRoot()
	arg_52_0:releaseLoader()
end

return var_0_0
