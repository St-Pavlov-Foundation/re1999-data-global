module("modules.logic.chessgame.game.scene.ChessGameScene", package.seeall)

slot0 = class("ChessGameScene", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._gotouch = gohelper.findChild(slot0.viewGO, "#go_touch")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	slot0._tfTouch = slot0._gotouch.transform
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0._gotouch)

	slot0._click:AddClickListener(slot0.onClickContainer, slot0)

	slot0._baseTiles = {}
	slot0._baseTilePool = {}
	slot0._dirItems = {}
	slot0._dirItemPool = {}
	slot0._alarmItems = {}
	slot0._alarmItemPool = {}
	slot0._interactItemList = {}
	slot0._baffleItems = {}
	slot0._baffleItemPool = {}
	slot0._avatarMap = {}
	slot0.loadDoneInteractList = {}
	slot0.needLoadInteractIdList = {}
	slot0._fixedOrder = 0

	MainCameraMgr.instance:addView(slot0.viewName, slot0.initCamera, nil, slot0)
	slot0:addEventCb(ChessGameController.instance, ChessGameEvent.DeleteInteractAvatar, slot0.deleteInteractObj, slot0)
	slot0:addEventCb(ChessGameController.instance, ChessGameEvent.AddInteractObj, slot0.createOrUpdateInteractItem, slot0)
	slot0:addEventCb(ChessGameController.instance, ChessGameEvent.ChangeMap, slot0.changeMap, slot0)
	slot0:addEventCb(ChessGameController.instance, ChessGameEvent.GamePointReturn, slot0._onGamePointReturn, slot0)
	slot0:addEventCb(ChessGameController.instance, ChessGameEvent.SetAlarmAreaVisible, slot0.onSetAlarmAreaVisible, slot0)
	slot0:addEventCb(ChessGameController.instance, ChessGameEvent.SetNeedChooseDirectionVisible, slot0.onSetDirectionVisible, slot0)
	slot0:addEventCb(ChessGameController.instance, ChessGameEvent.GameReset, slot0.onResetGame, slot0)
	slot0:addEventCb(ChessGameController.instance, ChessGameEvent.GameMapDataUpdate, slot0.onGameDataUpdate, slot0)
	slot0:addEventCb(ChessGameController.instance, ChessGameEvent.GameResultQuit, slot0.onResultQuit, slot0)
	slot0:addEventCb(ChessGameController.instance, ChessGameEvent.PlayStoryFinish, slot0._onPlayStoryFinish, slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0.onScreenResize, slot0)
	slot0:createSceneRoot()
	slot0:loadRes()
end

function slot0.createSceneRoot(slot0)
	slot0._sceneRoot = UnityEngine.GameObject.New("ChessGameScene")
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

function slot0.initCamera(slot0)
	if slot0._isInitCamera then
		return
	end

	slot0._isInitCamera = true

	slot0:onScreenResize()
end

function slot0.onScreenResize(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographic = true
	slot1.orthographicSize = 7.5 * GameUtil.getAdapterScale(true)
end

function slot0._onPlayStoryFinish(slot0)
	ChessGameController.instance:setSceneCamera(true)
end

function slot0.loadRes(slot0)
	UIBlockMgr.instance:startBlock(uv0.BLOCK_KEY)

	slot0._loader = MultiAbLoader.New()

	slot0._loader:addPath(slot0:getCurrentSceneUrl())
	slot0._loader:addPath(slot0:getGroundItemUrl())
	slot0._loader:addPath(ChessGameEnum.SceneResPath.DirItem)
	slot0._loader:addPath(ChessGameEnum.SceneResPath.AlarmItem)
	slot0:onLoadRes()
	slot0._loader:startLoad(slot0.loadResCompleted, slot0)
end

function slot0.onLoadRes(slot0)
end

function slot0.onloadResCompleted(slot0, slot1)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.GameLoadingMapStateUpdate, ChessGameEvent.LoadingMapState.Finish, true)
end

function slot0.getGroundItemUrl(slot0)
	return ChessGameEnum.NodePath
end

function slot0.getCurrentSceneUrl(slot0)
	return ChessGameModel.instance:getNowMapResPath()
end

function slot0.onOpen(slot0)
end

function slot0.loadResCompleted(slot0, slot1)
	if slot1:getAssetItem(ChessGameModel.instance:getNowMapResPath()) then
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
		ChessGameController.instance:autoSelectPlayer()
	end

	UIBlockMgr.instance:endBlock(uv0.BLOCK_KEY)
	ChessController.instance:dispatchEvent(ChessGameEvent.GuideOnEnterEpisode, tostring(ChessModel.instance:getEpisodeId()))
end

function slot0.changeMap(slot0, slot1)
	if not slot1 then
		return
	end

	if not slot0._oldLoader then
		slot0._oldLoader = slot0._loader
		slot0._oldSceneGo = slot0._sceneGo
	elseif slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	ChessGameModel.instance:setNowMapResPath(slot1)
	slot0:loadRes()
end

function slot0.playEnterAnim(slot0)
	if slot0._sceneAnim then
		slot0._sceneAnim:Play(UIAnimationName.Open, 0, 0)
	end
end

function slot0.playAudio(slot0)
	if ChessGameModel.instance:getActId() then
		slot0:stopAudio()

		if ChessGameConfig.instance:getMapCo(slot1) and slot2.audioAmbient ~= 0 then
			slot0._triggerAmbientId = AudioMgr.instance:trigger(slot2.audioAmbient)
		end
	end
end

function slot0.fillChessBoardBase(slot0)
	slot0:resetTiles()

	for slot5, slot6 in pairs(ChessGameNodeModel.instance:getAllNodes()) do
		slot0._baseTiles[slot5] = slot0._baseTiles[slot5] or {}

		for slot10, slot11 in pairs(slot6) do
			slot12 = slot0:createTileBaseItem(slot5, slot10)
			slot0._baseTiles[slot5][slot10] = slot12

			slot0:onTileItemCreate(slot5, slot10, slot12)
		end
	end
end

function slot0.onTileItemCreate(slot0, slot1, slot2, slot3)
end

function slot0.createTileBaseItem(slot0, slot1, slot2)
	slot3 = nil

	if not slot0._baseTiles[slot1][slot2] then
		slot3 = slot0:getUserDataTb_()
		slot6 = gohelper.clone(slot0._loader:getAssetItem(slot0:getGroundItemUrl(slot1, slot2)):GetResource(), slot0._sceneBackground, "tilebase_" .. slot1 .. "_" .. slot2)
		slot3.go = slot6
		slot3.sceneTf = slot6.transform
		slot3.pos = {
			x = slot1,
			y = slot2
		}
	end

	gohelper.setActive(slot3.go, true)

	slot3.sceneTf.position = Vector3(slot1, slot2, 0)

	slot0:setTileBasePosition(slot3.sceneTf)

	return slot3
end

function slot0.setTileBasePosition(slot0, slot1)
	slot2 = ChessGameHelper.nodePosToWorldPos(slot1.position)

	transformhelper.setLocalPos(slot1, slot2.x, slot2.y, slot2.z)
end

function slot0.createAllInteractObjs(slot0)
	if not ChessGameController.instance.interactsMgr then
		return
	end

	for slot5, slot6 in ipairs(ChessGameController.instance.interactsMgr:getList()) do
		if slot6:isShow() then
			slot0:createOrUpdateInteractItem(slot6)
		end
	end

	slot0:addEventCb(ChessGameController.instance, ChessGameEvent.AllObjectCreated, slot0.createAllInteractObjs, slot0)
end

function slot0.createOrUpdateInteractItem(slot0, slot1)
	if gohelper.isNil(slot0._sceneContainer) then
		logNormal("ChessGameScene: game is already end")

		return
	end

	if not slot0._avatarMap[slot1.id] then
		slot2 = slot0:getUserDataTb_()
		slot2.sceneGo = UnityEngine.GameObject.New("item_" .. slot1.id)
		slot2.sceneTf = slot2.sceneGo.transform
		slot2.loader = PrefabInstantiate.Create(slot2.sceneGo)

		slot2.sceneTf:SetParent(slot0._sceneContainer.transform, false)

		slot0._avatarMap[slot1.id] = slot2
	end

	slot1:setAvatar(slot2)
end

function slot0.deleteInteractObj(slot0, slot1)
	slot0._avatarMap[slot1] = nil
end

function slot0.onSetDirectionVisible(slot0, slot1)
	slot0:recycleAllDirItem()

	if not slot1 then
		return
	end

	if slot1.visible then
		slot2 = slot1.selectType or ChessGameEnum.ChessSelectType.Normal

		for slot6 = 1, #slot1.posXList do
			slot12 = slot1.posXList[slot6]
			slot13 = slot1.posYList[slot6]

			slot0:addDirectionItem(slot0:createDirItem(), slot12, slot13)

			for slot12, slot13 in pairs(ChessGameEnum.Direction) do
				gohelper.setActive(slot7["goDir" .. slot13], slot13 == slot1.dirList[slot6])
			end

			gohelper.setActive(slot7.goNormal, ChessGameEnum.ChessSelectType.Normal == slot2)
			gohelper.setActive(slot7.goItem, ChessGameEnum.ChessSelectType.CatchObj == slot2)
			gohelper.setActive(slot7.goCenter, false)
		end

		if slot1.selfPosX ~= nil and slot1.selfPosY ~= nil then
			slot3 = slot0:createDirItem()

			slot0:addDirectionItem(slot3, slot1.selfPosX, slot1.selfPosY)
			gohelper.setActive(slot3.goNormal, false)
			gohelper.setActive(slot3.goItem, false)
			gohelper.setActive(slot3.goCenter, true)
		end

		if ChessGameEnum.ChessSelectType.Normal == slot2 then
			ChessGameController.instance:checkInteractCanUse({
				slot1.selfPosX + 1,
				slot1.selfPosX - 1,
				slot1.selfPosX,
				slot1.selfPosX
			}, {
				slot1.selfPosY,
				slot1.selfPosY,
				slot1.selfPosY + 1,
				slot1.selfPosY - 1
			})
		end
	end
end

function slot0.recycleAllDirItem(slot0)
	for slot4, slot5 in pairs(slot0._dirItems) do
		gohelper.setActive(slot5.go, false)
		table.insert(slot0._dirItemPool, slot5)

		slot0._dirItems[slot4] = nil
	end
end

function slot0.createDirItem(slot0)
	slot1 = nil

	if #slot0._dirItemPool > 0 then
		slot1 = slot0._dirItemPool[slot2]
		slot0._dirItemPool[slot2] = nil
	end

	if not slot1 then
		slot1 = slot0:getUserDataTb_()
		slot8 = "dirItem"
		slot1.go = gohelper.clone(slot0._loader:getAssetItem(ChessGameEnum.SceneResPath.DirItem):GetResource(), slot0._sceneGround, slot8)
		slot1.sceneTf = slot1.go.transform
		slot1.goCenter = gohelper.findChild(slot1.go, "#go_center")
		slot1.goNormal = gohelper.findChild(slot1.go, "#go_normal")
		slot7 = "#go_item"
		slot1.goItem = gohelper.findChild(slot1.go, slot7)

		for slot7, slot8 in pairs(ChessGameEnum.Direction) do
			slot1["goDir" .. slot8] = gohelper.findChild(slot1.goItem, "jiantou_" .. slot8)
		end
	end

	table.insert(slot0._dirItems, slot1)

	return slot1
end

function slot0.addDirectionItem(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot1.go, true)

	slot5 = ChessGameHelper.nodePosToWorldPos({
		z = 0,
		x = slot2,
		y = slot3
	})
	slot1.tileX = slot2
	slot1.tileY = slot3

	transformhelper.setLocalPos(slot1.sceneTf, slot5.x, slot5.y, slot5.z)
end

function slot0.onSetAlarmAreaVisible(slot0, slot1)
	slot0:recycleAllAlarmItem()

	if not slot1 then
		return
	end

	if slot1.visible then
		slot0:refreshAlarmArea()
	end
end

function slot0.refreshAlarmArea(slot0)
	slot0._isWaitingRefreshAlarm = false

	if not ChessGameController.instance.interactsMgr then
		return
	end

	if not ChessGameController.instance.interactsMgr:getList() then
		return
	end

	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		if slot7.objType == ChessGameEnum.InteractType.Hunter then
			slot7:getHandler():onDrawAlert(slot2)
		end
	end

	for slot6, slot7 in pairs(slot2) do
		for slot11, slot12 in pairs(slot7) do
			for slot16, slot17 in pairs(slot12) do
				slot0:createAlarmItem(slot6, slot11, nil, slot17)
			end
		end
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

function slot0.createAlarmItem(slot0, slot1, slot2, slot3, slot4)
	slot5 = false

	if type(slot4) == "table" then
		slot6 = slot4.resPath or ChessGameEnum.SceneResPath.AlarmItem
	end

	if slot0._alarmItems[ChessGameHelper.calPosIndex(slot1, slot2)] then
		for slot12, slot13 in ipairs(slot8) do
			if slot13.resPath == slot6 then
				return
			end
		end
	end

	slot9 = nil

	if slot0._alarmItemPool[slot6] and #slot10 > 0 then
		slot9 = slot10[slot11]
		slot10[slot11] = nil
	end

	if not slot9 then
		slot9 = slot0:getUserDataTb_()
		slot9.go = gohelper.clone((slot0._loader:getAssetItem(slot6) or slot0._loader:getAssetItem(ChessGameEnum.SceneResPath.AlarmItem)):GetResource(), slot0._sceneGround, "alarmItem")
		slot9.sceneTf = slot9.go.transform
	end

	gohelper.setActive(slot9.go, true)

	slot12 = ChessGameHelper.nodePosToWorldPos({
		z = 0,
		x = slot1,
		y = slot2
	})
	slot9.tileX = slot1
	slot9.tileY = slot2
	slot9.isManual = slot3
	slot9.isStatic = slot5
	slot9.resPath = slot6

	transformhelper.setLocalPos(slot9.sceneTf, slot12.x, slot12.y, slot12.z)

	if not slot8 then
		slot0._alarmItems[slot7] = {}
	end

	slot8[#slot8 + 1] = slot9

	return slot9
end

function slot0.addNeedLoadInteractList(slot0, slot1)
	if not tabletool.indexOf(slot0.needLoadInteractIdList, slot1) then
		table.insert(slot0.needLoadInteractIdList, slot1)
	end
end

function slot0.findInteractItem(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._interactItemList) do
		if slot6.id == slot1 then
			return slot6
		end
	end
end

function slot0.getPlayerInteractItem(slot0)
	return slot0.playerInteractItem
end

function slot0.setInteractObjActive(slot0, slot1, slot2)
	if not slot0:findInteractItem(slot1) then
		return
	end

	slot3:setActive(slot2)
end

function slot0.onClickContainer(slot0, slot1, slot2)
	if ChessGameController.instance:isNeedBlock() then
		return
	end

	slot4 = recthelper.screenPosToWorldPos(GamepadController.instance:getMousePosition(), CameraMgr.instance:getMainCamera(), slot0._sceneBackground.transform.position)

	logNormal("click Scene wolrdX, worldY : " .. tostring(slot4.x) .. ", " .. tostring(slot4.y))

	slot6 = ChessGameHelper.worldPosToNodePos({
		x = slot4.x,
		y = slot4.y - slot0._sceneOffsetY,
		z = slot4.z
	})

	logNormal("click Scene X, Y : " .. tostring(slot6.x) .. ", " .. tostring(slot6.y))

	if slot6 then
		slot0:onClickChessPos(slot6.x, slot6.y)
	end
end

function slot0.onClickChessPos(slot0, slot1, slot2)
	if ChessGameController.instance.eventMgr and slot3:getCurEvent() and slot3:getCurEvent() then
		slot4:onClickPos(slot1, slot2, true)
	end
end

function slot0._guideClickTile(slot0, slot1)
	slot2 = string.splitToNumber(slot1, "_")

	slot0:onClickChessPos(slot2[1], slot2[2])
end

function slot0.recycleAllInteract(slot0)
	for slot4, slot5 in ipairs(slot0._interactItemList) do
		slot5:deleteSelf()
	end
end

function slot0.disposeInteractItem(slot0)
	for slot4, slot5 in ipairs(slot0._interactItemList) do
		slot5:dispose()
	end

	slot0._interactItemList = nil
end

function slot0.disposeBaffle(slot0)
	slot1 = nil

	for slot5 = 1, #slot0._baffleItems do
		slot0._baffleItems[slot5]:dispose()
	end

	for slot5 = 1, #slot0._baffleItemPool do
		slot0._baffleItemPool[slot5]:dispose()
	end

	slot0._baffleItems = nil
	slot0._baffleItemPool = nil
end

function slot0.disposeSceneRoot(slot0)
	if slot0._sceneRoot then
		gohelper.destroy(slot0._sceneRoot)

		slot0._sceneRoot = nil
	end
end

function slot0.releaseLoader(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

function slot0.refreshNearInteractIcon(slot0)
	ChessGameController.instance.interactsMgr:getMainPlayer():getHandler():calCanWalkArea()
end

function slot0.onCancelSelectInteract(slot0, slot1)
	if slot0:findInteractItem(slot1) and not slot2.delete and slot2:getHandler() then
		slot2:getHandler():onCancelSelect()
	end
end

function slot0.onGameDataUpdate(slot0)
	if not ChessGameController.instance:getSelectObj() then
		ChessGameController.instance:autoSelectPlayer(true)
	end
end

function slot0.onResetGame(slot0)
	slot0:fillChessBoardBase()
	ChessGameController.instance:setSelectObj(nil)
	ChessGameController.instance:autoSelectPlayer(true)
end

function slot0.resetTiles(slot0)
	for slot4, slot5 in pairs(slot0._baseTiles) do
		for slot9, slot10 in pairs(slot5) do
			gohelper.setActive(slot10.go, false)
		end
	end
end

function slot0.onClose(slot0)
	if not ChessGameModel.instance:getGameState() then
		ChessStatController.instance:statAbort()
	end
end

function slot0.resetCamera(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographicSize = 5
	slot1.orthographic = false
end

function slot0.onResultQuit(slot0)
	slot0:closeThis()
end

function slot0.onDestroyView(slot0)
	if slot0._click then
		slot0._click:RemoveClickListener()

		slot0._click = nil
	end

	slot0._baseTiles = nil
	slot0._alarmItemPool = {}

	slot0:resetCamera()
	slot0:disposeSceneRoot()
	slot0:releaseLoader()
end

return slot0
