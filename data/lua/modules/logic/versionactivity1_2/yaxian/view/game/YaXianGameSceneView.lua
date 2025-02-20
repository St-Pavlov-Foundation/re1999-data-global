module("modules.logic.versionactivity1_2.yaxian.view.game.YaXianGameSceneView", package.seeall)

slot0 = class("YaXianGameSceneView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotouch = gohelper.findChild(slot0.viewGO, "#go_touch")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.InteractObjectCreated, slot0.createOrUpdateInteractObj, slot0)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.DeleteInteractObj, slot0.deleteInteractObj, slot0)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.OnUpdateEffectInfo, slot0.onUpdateEffectInfo, slot0)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.OnSelectInteract, slot0.onSelectInteract, slot0)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.OnCancelSelectInteract, slot0.onCancelSelectInteract, slot0)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.OnRevert, slot0.onRevert, slot0)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.OnResetView, slot0.resetMapView, slot0)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.UpdateRound, slot0.onUpdateRound, slot0)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.OnInteractLoadDone, slot0.checkAllInteractLoadDone, slot0)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.SetInteractObjActive, slot0.setInteractObjActive, slot0)
	slot0:addEventCb(YaXianGameController.instance, YaXianEvent.GuideClickTile, slot0._guideClickTile, slot0)
end

function slot0.removeEvents(slot0)
end

slot0.BLOCK_KEY = "YaXianGameSceneViewLoading"

function slot0._editableInitView(slot0)
	slot0._tfTouch = slot0._gotouch.transform
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0._gotouch)

	slot0._click:AddClickListener(slot0.onClickContainer, slot0)

	slot0._baseTiles = {}
	slot0._baseTilePool = {}
	slot0._interactItemList = {}
	slot0._baffleItems = {}
	slot0._baffleItemPool = {}
	slot0.loadDoneInteractList = {}
	slot0.needLoadInteractIdList = {}

	MainCameraMgr.instance:addView(slot0.viewName, slot0.initCamera, nil, slot0)
	slot0:createSceneRoot()
	slot0:addEvents()
	slot0:initSceneTree()
	slot0:loadRes()
end

function slot0.initSceneTree(slot0)
	YaXianGameController.instance:initSceneTree(slot0._gotouch, slot0._sceneOffsetY)
end

function slot0.createSceneRoot(slot0)
	slot0._sceneRoot = UnityEngine.GameObject.New("YaXianScene")
	slot3, slot4, slot5 = transformhelper.getLocalPos(CameraMgr.instance:getMainCameraTrs().parent)

	transformhelper.setLocalPos(slot0._sceneRoot.transform, 0, slot4, 0)

	slot0._sceneOffsetY = slot4

	gohelper.addChild(CameraMgr.instance:getSceneRoot(), slot0._sceneRoot)
end

function slot0.initCamera(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographic = true
	slot1.orthographicSize = 7.5 * GameUtil.getAdapterScale(true)
end

function slot0.loadRes(slot0)
	UIBlockMgr.instance:startBlock(uv0.BLOCK_KEY)

	slot0._loader = MultiAbLoader.New()
	slot0.sceneUrl = slot0:getCurrentSceneUrl()

	slot0._loader:addPath(slot0.sceneUrl)
	slot0._loader:addPath(YaXianGameEnum.SceneResPath.GroundItem)
	slot0._loader:addPath(YaXianGameEnum.SceneResPath.DirItem)
	slot0._loader:addPath(YaXianGameEnum.SceneResPath.AlarmItem)
	slot0._loader:addPath(YaXianGameEnum.SceneResPath.TargetItem)
	slot0._loader:addPath(YaXianGameEnum.SceneResPath.GreenLine)
	slot0._loader:addPath(YaXianGameEnum.SceneResPath.RedLine)
	slot0._loader:addPath(YaXianGameEnum.SceneResPath.GreedLineHalf)
	slot0._loader:addPath(YaXianGameEnum.SceneResPath.RedLineHalf)
	slot0._loader:startLoad(slot0.onLoadResCompleted, slot0)
end

function slot0.onUpdateParam(slot0)
	slot0:createAllMapElement()
end

function slot0.onOpen(slot0)
	slot0:createAllMapElement()
end

function slot0.getCurrentSceneUrl(slot0)
	if YaXianConfig.instance:getMapConfig(YaXianGameModel.instance:getActId(), YaXianGameModel.instance:getMapId()) and not string.nilorempty(slot3.bgPath) then
		return string.format(YaXianGameEnum.SceneResPath.SceneFormatPath, slot3.bgPath)
	else
		return YaXianGameEnum.SceneResPath.DefaultScene
	end
end

function slot0.onLoadResCompleted(slot0, slot1)
	if slot1:getAssetItem(slot0.sceneUrl) then
		slot0._sceneGo = gohelper.clone(slot2:GetResource(), slot0._sceneRoot, "scene")

		slot0.viewContainer:setRootSceneGo(slot0._sceneGo)

		slot0._sceneBackground = UnityEngine.GameObject.New("backgroundContainer")
		slot0._interactContainer = UnityEngine.GameObject.New("interactContainer")

		slot0._sceneBackground.transform:SetParent(slot0._sceneGo.transform, false)
		slot0._interactContainer.transform:SetParent(slot0._sceneGo.transform, false)
		transformhelper.setLocalPos(slot0._sceneBackground.transform, 0, 0, YaXianGameEnum.ContainerOffsetZ.Background)
		transformhelper.setLocalPos(slot0._interactContainer.transform, 0, 0, YaXianGameEnum.ContainerOffsetZ.Interact)

		slot0.groundPrefab = slot0._loader:getAssetItem(YaXianGameEnum.SceneResPath.GroundItem):GetResource()
		slot0.mainResLoadDone = true

		slot0:createAllMapElement()
	end

	UIBlockMgr.instance:endBlock(uv0.BLOCK_KEY)
end

function slot0.createAllMapElement(slot0)
	if slot0.mainResLoadDone and BaseViewContainer.Status_Opening <= slot0.viewContainer._viewStatus then
		YaXianGameController.instance:dispatchEvent(YaXianEvent.MainResLoadDone, slot0._loader)
		slot0:fillChessBoardBase()
		slot0:createAllInteractObjs()
		slot0:createAllBaffleObjs()
		slot0:checkAllInteractLoadDone()
	end
end

function slot0.checkAllInteractLoadDone(slot0, slot1)
	if slot1 and not tabletool.indexOf(slot0.loadDoneInteractList, slot1) then
		table.insert(slot0.loadDoneInteractList, slot1)
	end

	if #slot0.loadDoneInteractList ~= #slot0.needLoadInteractIdList then
		return
	end

	slot2 = {
		[slot7] = true
	}

	for slot6, slot7 in ipairs(slot0.loadDoneInteractList) do
		-- Nothing
	end

	for slot6, slot7 in ipairs(slot0.needLoadInteractIdList) do
		if not slot2[slot7] then
			return
		end
	end

	slot0.featureInteractMo = YaXianGameModel.instance:getNeedFeatureInteractMo()

	if slot0.featureInteractMo then
		TaskDispatcher.runDelay(slot0.playFeatureAnimation, slot0, 1)

		return
	end

	YaXianGameModel.instance:setGameLoadDone(true)
	YaXianGameController.instance:updateAllPosInteractActive()
	YaXianGameController.instance:autoSelectPlayer()
	YaXianGameController.instance:dispatchEvent(YaXianEvent.OnGameLoadDone, tostring(YaXianGameModel.instance:getEpisodeId()))
end

function slot0.playFeatureAnimation(slot0)
	slot0.featureInteractItem = slot0:findInteractItem(slot0.featureInteractMo.id)

	slot0.featureInteractItem:getHandler():moveTo(YaXianGameModel.instance.featurePrePosX, YaXianGameModel.instance.featurePrePosY, slot0.featureAnimationDone, slot0)
end

function slot0.featureAnimationDone(slot0)
	slot0.featureInteractItem:getHandler():faceTo(YaXianGameModel.instance.featurePreDirection)
	YaXianGameModel.instance:clearFeatureInteract()
	YaXianGameController.instance:updateAllPosInteractActive()
	YaXianGameModel.instance:setGameLoadDone(true)
	YaXianGameController.instance:autoSelectPlayer()
	YaXianGameController.instance:dispatchEvent(YaXianEvent.OnGameLoadDone, tostring(YaXianGameModel.instance:getEpisodeId()))
end

function slot0.fillChessBoardBase(slot0)
	slot0:recycleBaseTiles()

	slot1 = 8
	slot6 = tostring(slot1)

	logNormal("fill w = " .. slot6 .. ", h = " .. tostring(8))

	for slot6 = 1, slot1 do
		slot0._baseTiles[slot6] = slot0._baseTiles[slot6] or {}

		for slot10 = 1, slot2 do
			slot11 = slot0:createTileBaseItem(slot6 - 1, slot10 - 1)
			slot0._baseTiles[slot6][slot10] = slot11

			gohelper.setActive(slot11.go, YaXianGameModel.instance:getBaseTile(slot6 - 1, slot10 - 1) ~= 0)
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
		slot5 = gohelper.clone(slot0.groundPrefab, slot0._sceneBackground, "tilebase_" .. slot1 .. "_" .. slot2)
		slot3.go = slot5
		slot3.sceneTf = slot5.transform
	else
		slot3.go.name = "tilebase_" .. slot1 .. "_" .. slot2
	end

	slot0:setTileBasePosition(slot3, slot1, slot2)

	return slot3
end

function slot0.setTileBasePosition(slot0, slot1, slot2, slot3)
	slot4, slot5, slot6 = YaXianGameHelper.calcTilePosInScene(slot2, slot3)

	transformhelper.setLocalPos(slot1.sceneTf, slot4, slot5, slot6)
end

function slot0.createAllBaffleObjs(slot0)
	for slot5, slot6 in ipairs(YaXianGameModel.instance:getBaffleList()) do
		slot0:createBaffleItem(slot6)
	end
end

function slot0.createBaffleItem(slot0, slot1)
	slot2 = nil

	if #slot0._baffleItemPool > 0 then
		slot2 = slot0._baffleItemPool[slot3]
		slot0._baffleItemPool[slot3] = nil
	end

	if not slot2 then
		YaXianBaffleObject.New(slot0._interactContainer.transform):init()
	end

	slot2:updatePos(slot1)
	table.insert(slot0._baffleItems, slot2)
end

function slot0.createAllInteractObjs(slot0)
	for slot6, slot7 in ipairs(YaXianGameModel.instance:getInteractMoList()) do
		slot0:addNeedLoadInteractList(slot7.id)

		if slot7 == YaXianGameModel.instance:getPlayerInteractMo() then
			slot0.playerInteractItem = slot0:createOrUpdateInteractObj(slot7)
		end
	end

	YaXianGameController.instance:setInteractItemList(slot0._interactItemList)
	YaXianGameController.instance:setPlayerInteractItem(slot0.playerInteractItem)
end

function slot0.createOrUpdateInteractObj(slot0, slot1)
	if not slot0:findInteractItem(slot1.id) then
		slot2 = YaXianInteractObject.New(slot0._interactContainer.transform)

		slot2:init(slot1)
		slot2:loadAvatar()
		slot2:updateInteractPos()
		table.insert(slot0._interactItemList, slot2)
	else
		slot2:renewSelf()
		slot2:updateInteractMo(slot1)
	end

	return slot2
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

function slot0.deleteInteractObj(slot0, slot1)
	if not slot0:findInteractItem(slot1) then
		return
	end

	slot2:deleteSelf()
	YaXianGameModel.instance:removeObjectById(slot1)
end

function slot0.setInteractObjActive(slot0, slot1)
	slot2 = string.split(slot1, "_")
	slot4 = tonumber(slot2[2]) == 1

	if not slot0:findInteractItem(tonumber(slot2[1])) then
		return
	end

	slot5:setActive(slot4)
end

function slot0.onClickContainer(slot0, slot1, slot2)
	if not YaXianGameController.instance:isSelectingPlayer() then
		return
	end

	slot3 = recthelper.screenPosToAnchorPos(slot2, slot0._tfTouch)
	slot4, slot5 = YaXianGameController.instance:getNearestScenePos(slot3.x, slot3.y)

	if slot4 then
		logNormal("click Scene tileX, tileY : " .. tostring(slot4) .. ", " .. tostring(slot5))
		slot0:onClickChessPos(slot4, slot5)
	end
end

function slot0.onClickChessPos(slot0, slot1, slot2)
	if not YaXianGameController.instance:isSelectingPlayer() then
		return
	end

	slot0.playerInteractItem:getHandler():onSelectPos(slot1, slot2)
end

function slot0._guideClickTile(slot0, slot1)
	slot2 = string.splitToNumber(slot1, "_")

	slot0:onClickChessPos(slot2[1], slot2[2])
end

function slot0.recycleBaseTiles(slot0)
	for slot4, slot5 in pairs(slot0._baseTiles) do
		for slot9, slot10 in pairs(slot5) do
			table.insert(slot0._baseTilePool, slot0._baseTiles[slot4][slot9])
		end
	end

	slot0._baseTiles = {}
end

function slot0.recycleAllBaffleItem(slot0)
	slot1 = nil

	for slot5 = 1, #slot0._baffleItems do
		slot1 = slot0._baffleItems[slot5]

		slot1:recycle()
		table.insert(slot0._baffleItemPool, slot1)

		slot0._baffleItems[slot5] = nil
	end
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

function slot0.resetMapView(slot0)
	YaXianGameModel.instance:setGameLoadDone(false)
	slot0:recycleBaseTiles()
	slot0:recycleAllInteract()
	slot0:recycleAllBaffleItem()
end

function slot0.onUpdateEffectInfo(slot0)
	if YaXianGameModel.instance:isShowVisibleStatus() and YaXianGameModel.instance:isShowThroughStatus() then
		slot0.playerInteractItem:playAnimation(YaXianGameEnum.InteractAnimationName.TwoEffect)

		return
	end

	if slot1 then
		slot0.playerInteractItem:playAnimation(YaXianGameEnum.InteractAnimationName.InVisible)

		return
	end

	if slot2 then
		slot0.playerInteractItem:playAnimation(YaXianGameEnum.InteractAnimationName.ThroughWall)

		return
	end

	slot0.playerInteractItem:stopAnimation()
end

function slot0.onSelectInteract(slot0, slot1)
	if slot0:findInteractItem(slot1) and not slot2.delete and slot2:getHandler() then
		slot2:getHandler():onSelectCall()
	end
end

function slot0.onCancelSelectInteract(slot0, slot1)
	if slot0:findInteractItem(slot1) and not slot2.delete and slot2:getHandler() then
		slot2:getHandler():onCancelSelect()
	end
end

function slot0.onUpdateRound(slot0)
	YaXianGameController.instance:updateAllPosInteractActive()
	YaXianGameController.instance:autoSelectPlayer()
end

function slot0.onRevert(slot0)
	YaXianGameController.instance:setSelectObj()
	slot0:createAllInteractObjs()
	slot0:checkAllInteractLoadDone()
	YaXianGameController.instance:updateAllPosInteractActive()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.playFeatureAnimation, slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._click then
		slot0._click:RemoveClickListener()

		slot0._click = nil
	end

	slot0._baseTiles = nil

	slot0:disposeInteractItem()
	slot0:disposeBaffle()
	slot0:disposeSceneRoot()
	slot0:releaseLoader()
end

return slot0
