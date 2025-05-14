module("modules.logic.versionactivity1_2.yaxian.view.game.YaXianGameSceneView", package.seeall)

local var_0_0 = class("YaXianGameSceneView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotouch = gohelper.findChild(arg_1_0.viewGO, "#go_touch")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(YaXianGameController.instance, YaXianEvent.InteractObjectCreated, arg_2_0.createOrUpdateInteractObj, arg_2_0)
	arg_2_0:addEventCb(YaXianGameController.instance, YaXianEvent.DeleteInteractObj, arg_2_0.deleteInteractObj, arg_2_0)
	arg_2_0:addEventCb(YaXianGameController.instance, YaXianEvent.OnUpdateEffectInfo, arg_2_0.onUpdateEffectInfo, arg_2_0)
	arg_2_0:addEventCb(YaXianGameController.instance, YaXianEvent.OnSelectInteract, arg_2_0.onSelectInteract, arg_2_0)
	arg_2_0:addEventCb(YaXianGameController.instance, YaXianEvent.OnCancelSelectInteract, arg_2_0.onCancelSelectInteract, arg_2_0)
	arg_2_0:addEventCb(YaXianGameController.instance, YaXianEvent.OnRevert, arg_2_0.onRevert, arg_2_0)
	arg_2_0:addEventCb(YaXianGameController.instance, YaXianEvent.OnResetView, arg_2_0.resetMapView, arg_2_0)
	arg_2_0:addEventCb(YaXianGameController.instance, YaXianEvent.UpdateRound, arg_2_0.onUpdateRound, arg_2_0)
	arg_2_0:addEventCb(YaXianGameController.instance, YaXianEvent.OnInteractLoadDone, arg_2_0.checkAllInteractLoadDone, arg_2_0)
	arg_2_0:addEventCb(YaXianGameController.instance, YaXianEvent.SetInteractObjActive, arg_2_0.setInteractObjActive, arg_2_0)
	arg_2_0:addEventCb(YaXianGameController.instance, YaXianEvent.GuideClickTile, arg_2_0._guideClickTile, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

var_0_0.BLOCK_KEY = "YaXianGameSceneViewLoading"

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._tfTouch = arg_4_0._gotouch.transform
	arg_4_0._click = SLFramework.UGUI.UIClickListener.Get(arg_4_0._gotouch)

	arg_4_0._click:AddClickListener(arg_4_0.onClickContainer, arg_4_0)

	arg_4_0._baseTiles = {}
	arg_4_0._baseTilePool = {}
	arg_4_0._interactItemList = {}
	arg_4_0._baffleItems = {}
	arg_4_0._baffleItemPool = {}
	arg_4_0.loadDoneInteractList = {}
	arg_4_0.needLoadInteractIdList = {}

	MainCameraMgr.instance:addView(arg_4_0.viewName, arg_4_0.initCamera, nil, arg_4_0)
	arg_4_0:createSceneRoot()
	arg_4_0:addEvents()
	arg_4_0:initSceneTree()
	arg_4_0:loadRes()
end

function var_0_0.initSceneTree(arg_5_0)
	YaXianGameController.instance:initSceneTree(arg_5_0._gotouch, arg_5_0._sceneOffsetY)
end

function var_0_0.createSceneRoot(arg_6_0)
	local var_6_0 = CameraMgr.instance:getMainCameraTrs().parent
	local var_6_1 = CameraMgr.instance:getSceneRoot()

	arg_6_0._sceneRoot = UnityEngine.GameObject.New("YaXianScene")

	local var_6_2, var_6_3, var_6_4 = transformhelper.getLocalPos(var_6_0)

	transformhelper.setLocalPos(arg_6_0._sceneRoot.transform, 0, var_6_3, 0)

	arg_6_0._sceneOffsetY = var_6_3

	gohelper.addChild(var_6_1, arg_6_0._sceneRoot)
end

function var_0_0.initCamera(arg_7_0)
	local var_7_0 = CameraMgr.instance:getMainCamera()

	var_7_0.orthographic = true
	var_7_0.orthographicSize = 7.5 * GameUtil.getAdapterScale(true)
end

function var_0_0.loadRes(arg_8_0)
	UIBlockMgr.instance:startBlock(var_0_0.BLOCK_KEY)

	arg_8_0._loader = MultiAbLoader.New()
	arg_8_0.sceneUrl = arg_8_0:getCurrentSceneUrl()

	arg_8_0._loader:addPath(arg_8_0.sceneUrl)
	arg_8_0._loader:addPath(YaXianGameEnum.SceneResPath.GroundItem)
	arg_8_0._loader:addPath(YaXianGameEnum.SceneResPath.DirItem)
	arg_8_0._loader:addPath(YaXianGameEnum.SceneResPath.AlarmItem)
	arg_8_0._loader:addPath(YaXianGameEnum.SceneResPath.TargetItem)
	arg_8_0._loader:addPath(YaXianGameEnum.SceneResPath.GreenLine)
	arg_8_0._loader:addPath(YaXianGameEnum.SceneResPath.RedLine)
	arg_8_0._loader:addPath(YaXianGameEnum.SceneResPath.GreedLineHalf)
	arg_8_0._loader:addPath(YaXianGameEnum.SceneResPath.RedLineHalf)
	arg_8_0._loader:startLoad(arg_8_0.onLoadResCompleted, arg_8_0)
end

function var_0_0.onUpdateParam(arg_9_0)
	arg_9_0:createAllMapElement()
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:createAllMapElement()
end

function var_0_0.getCurrentSceneUrl(arg_11_0)
	local var_11_0 = YaXianGameModel.instance:getMapId()
	local var_11_1 = YaXianGameModel.instance:getActId()
	local var_11_2 = YaXianConfig.instance:getMapConfig(var_11_1, var_11_0)

	if var_11_2 and not string.nilorempty(var_11_2.bgPath) then
		return string.format(YaXianGameEnum.SceneResPath.SceneFormatPath, var_11_2.bgPath)
	else
		return YaXianGameEnum.SceneResPath.DefaultScene
	end
end

function var_0_0.onLoadResCompleted(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1:getAssetItem(arg_12_0.sceneUrl)

	if var_12_0 then
		arg_12_0._sceneGo = gohelper.clone(var_12_0:GetResource(), arg_12_0._sceneRoot, "scene")

		arg_12_0.viewContainer:setRootSceneGo(arg_12_0._sceneGo)

		arg_12_0._sceneBackground = UnityEngine.GameObject.New("backgroundContainer")
		arg_12_0._interactContainer = UnityEngine.GameObject.New("interactContainer")

		arg_12_0._sceneBackground.transform:SetParent(arg_12_0._sceneGo.transform, false)
		arg_12_0._interactContainer.transform:SetParent(arg_12_0._sceneGo.transform, false)
		transformhelper.setLocalPos(arg_12_0._sceneBackground.transform, 0, 0, YaXianGameEnum.ContainerOffsetZ.Background)
		transformhelper.setLocalPos(arg_12_0._interactContainer.transform, 0, 0, YaXianGameEnum.ContainerOffsetZ.Interact)

		arg_12_0.groundPrefab = arg_12_0._loader:getAssetItem(YaXianGameEnum.SceneResPath.GroundItem):GetResource()
		arg_12_0.mainResLoadDone = true

		arg_12_0:createAllMapElement()
	end

	UIBlockMgr.instance:endBlock(var_0_0.BLOCK_KEY)
end

function var_0_0.createAllMapElement(arg_13_0)
	if arg_13_0.mainResLoadDone and arg_13_0.viewContainer._viewStatus >= BaseViewContainer.Status_Opening then
		YaXianGameController.instance:dispatchEvent(YaXianEvent.MainResLoadDone, arg_13_0._loader)
		arg_13_0:fillChessBoardBase()
		arg_13_0:createAllInteractObjs()
		arg_13_0:createAllBaffleObjs()
		arg_13_0:checkAllInteractLoadDone()
	end
end

function var_0_0.checkAllInteractLoadDone(arg_14_0, arg_14_1)
	if arg_14_1 and not tabletool.indexOf(arg_14_0.loadDoneInteractList, arg_14_1) then
		table.insert(arg_14_0.loadDoneInteractList, arg_14_1)
	end

	if #arg_14_0.loadDoneInteractList ~= #arg_14_0.needLoadInteractIdList then
		return
	end

	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.loadDoneInteractList) do
		var_14_0[iter_14_1] = true
	end

	for iter_14_2, iter_14_3 in ipairs(arg_14_0.needLoadInteractIdList) do
		if not var_14_0[iter_14_3] then
			return
		end
	end

	arg_14_0.featureInteractMo = YaXianGameModel.instance:getNeedFeatureInteractMo()

	if arg_14_0.featureInteractMo then
		TaskDispatcher.runDelay(arg_14_0.playFeatureAnimation, arg_14_0, 1)

		return
	end

	YaXianGameModel.instance:setGameLoadDone(true)
	YaXianGameController.instance:updateAllPosInteractActive()
	YaXianGameController.instance:autoSelectPlayer()

	local var_14_1 = YaXianGameModel.instance:getEpisodeId()

	YaXianGameController.instance:dispatchEvent(YaXianEvent.OnGameLoadDone, tostring(var_14_1))
end

function var_0_0.playFeatureAnimation(arg_15_0)
	arg_15_0.featureInteractItem = arg_15_0:findInteractItem(arg_15_0.featureInteractMo.id)

	arg_15_0.featureInteractItem:getHandler():moveTo(YaXianGameModel.instance.featurePrePosX, YaXianGameModel.instance.featurePrePosY, arg_15_0.featureAnimationDone, arg_15_0)
end

function var_0_0.featureAnimationDone(arg_16_0)
	arg_16_0.featureInteractItem:getHandler():faceTo(YaXianGameModel.instance.featurePreDirection)
	YaXianGameModel.instance:clearFeatureInteract()
	YaXianGameController.instance:updateAllPosInteractActive()
	YaXianGameModel.instance:setGameLoadDone(true)
	YaXianGameController.instance:autoSelectPlayer()

	local var_16_0 = YaXianGameModel.instance:getEpisodeId()

	YaXianGameController.instance:dispatchEvent(YaXianEvent.OnGameLoadDone, tostring(var_16_0))
end

function var_0_0.fillChessBoardBase(arg_17_0)
	arg_17_0:recycleBaseTiles()

	local var_17_0 = 8
	local var_17_1 = 8

	logNormal("fill w = " .. tostring(var_17_0) .. ", h = " .. tostring(var_17_1))

	for iter_17_0 = 1, var_17_0 do
		arg_17_0._baseTiles[iter_17_0] = arg_17_0._baseTiles[iter_17_0] or {}

		for iter_17_1 = 1, var_17_1 do
			local var_17_2 = arg_17_0:createTileBaseItem(iter_17_0 - 1, iter_17_1 - 1)

			arg_17_0._baseTiles[iter_17_0][iter_17_1] = var_17_2

			local var_17_3 = YaXianGameModel.instance:getBaseTile(iter_17_0 - 1, iter_17_1 - 1)

			gohelper.setActive(var_17_2.go, var_17_3 ~= 0)
		end
	end
end

function var_0_0.createTileBaseItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0
	local var_18_1 = #arg_18_0._baseTilePool

	if var_18_1 > 0 then
		var_18_0 = arg_18_0._baseTilePool[var_18_1]
		arg_18_0._baseTilePool[var_18_1] = nil
	end

	if not var_18_0 then
		var_18_0 = arg_18_0:getUserDataTb_()

		local var_18_2 = gohelper.clone(arg_18_0.groundPrefab, arg_18_0._sceneBackground, "tilebase_" .. arg_18_1 .. "_" .. arg_18_2)

		var_18_0.go = var_18_2
		var_18_0.sceneTf = var_18_2.transform
	else
		var_18_0.go.name = "tilebase_" .. arg_18_1 .. "_" .. arg_18_2
	end

	arg_18_0:setTileBasePosition(var_18_0, arg_18_1, arg_18_2)

	return var_18_0
end

function var_0_0.setTileBasePosition(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0, var_19_1, var_19_2 = YaXianGameHelper.calcTilePosInScene(arg_19_2, arg_19_3)

	transformhelper.setLocalPos(arg_19_1.sceneTf, var_19_0, var_19_1, var_19_2)
end

function var_0_0.createAllBaffleObjs(arg_20_0)
	local var_20_0 = YaXianGameModel.instance:getBaffleList()

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		arg_20_0:createBaffleItem(iter_20_1)
	end
end

function var_0_0.createBaffleItem(arg_21_0, arg_21_1)
	local var_21_0
	local var_21_1 = #arg_21_0._baffleItemPool

	if var_21_1 > 0 then
		var_21_0 = arg_21_0._baffleItemPool[var_21_1]
		arg_21_0._baffleItemPool[var_21_1] = nil
	end

	if not var_21_0 then
		var_21_0 = YaXianBaffleObject.New(arg_21_0._interactContainer.transform)

		var_21_0:init()
	end

	var_21_0:updatePos(arg_21_1)
	table.insert(arg_21_0._baffleItems, var_21_0)
end

function var_0_0.createAllInteractObjs(arg_22_0)
	local var_22_0 = YaXianGameModel.instance:getInteractMoList()
	local var_22_1 = YaXianGameModel.instance:getPlayerInteractMo()

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		local var_22_2 = arg_22_0:createOrUpdateInteractObj(iter_22_1)

		arg_22_0:addNeedLoadInteractList(iter_22_1.id)

		if iter_22_1 == var_22_1 then
			arg_22_0.playerInteractItem = var_22_2
		end
	end

	YaXianGameController.instance:setInteractItemList(arg_22_0._interactItemList)
	YaXianGameController.instance:setPlayerInteractItem(arg_22_0.playerInteractItem)
end

function var_0_0.createOrUpdateInteractObj(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:findInteractItem(arg_23_1.id)

	if not var_23_0 then
		var_23_0 = YaXianInteractObject.New(arg_23_0._interactContainer.transform)

		var_23_0:init(arg_23_1)
		var_23_0:loadAvatar()
		var_23_0:updateInteractPos()
		table.insert(arg_23_0._interactItemList, var_23_0)
	else
		var_23_0:renewSelf()
		var_23_0:updateInteractMo(arg_23_1)
	end

	return var_23_0
end

function var_0_0.addNeedLoadInteractList(arg_24_0, arg_24_1)
	if not tabletool.indexOf(arg_24_0.needLoadInteractIdList, arg_24_1) then
		table.insert(arg_24_0.needLoadInteractIdList, arg_24_1)
	end
end

function var_0_0.findInteractItem(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(arg_25_0._interactItemList) do
		if iter_25_1.id == arg_25_1 then
			return iter_25_1
		end
	end
end

function var_0_0.getPlayerInteractItem(arg_26_0)
	return arg_26_0.playerInteractItem
end

function var_0_0.deleteInteractObj(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0:findInteractItem(arg_27_1)

	if not var_27_0 then
		return
	end

	var_27_0:deleteSelf()
	YaXianGameModel.instance:removeObjectById(arg_27_1)
end

function var_0_0.setInteractObjActive(arg_28_0, arg_28_1)
	local var_28_0 = string.split(arg_28_1, "_")
	local var_28_1 = tonumber(var_28_0[1])
	local var_28_2 = tonumber(var_28_0[2]) == 1
	local var_28_3 = arg_28_0:findInteractItem(var_28_1)

	if not var_28_3 then
		return
	end

	var_28_3:setActive(var_28_2)
end

function var_0_0.onClickContainer(arg_29_0, arg_29_1, arg_29_2)
	if not YaXianGameController.instance:isSelectingPlayer() then
		return
	end

	local var_29_0 = recthelper.screenPosToAnchorPos(arg_29_2, arg_29_0._tfTouch)
	local var_29_1, var_29_2 = YaXianGameController.instance:getNearestScenePos(var_29_0.x, var_29_0.y)

	if var_29_1 then
		logNormal("click Scene tileX, tileY : " .. tostring(var_29_1) .. ", " .. tostring(var_29_2))
		arg_29_0:onClickChessPos(var_29_1, var_29_2)
	end
end

function var_0_0.onClickChessPos(arg_30_0, arg_30_1, arg_30_2)
	if not YaXianGameController.instance:isSelectingPlayer() then
		return
	end

	arg_30_0.playerInteractItem:getHandler():onSelectPos(arg_30_1, arg_30_2)
end

function var_0_0._guideClickTile(arg_31_0, arg_31_1)
	local var_31_0 = string.splitToNumber(arg_31_1, "_")
	local var_31_1 = var_31_0[1]
	local var_31_2 = var_31_0[2]

	arg_31_0:onClickChessPos(var_31_1, var_31_2)
end

function var_0_0.recycleBaseTiles(arg_32_0)
	for iter_32_0, iter_32_1 in pairs(arg_32_0._baseTiles) do
		for iter_32_2, iter_32_3 in pairs(iter_32_1) do
			table.insert(arg_32_0._baseTilePool, arg_32_0._baseTiles[iter_32_0][iter_32_2])
		end
	end

	arg_32_0._baseTiles = {}
end

function var_0_0.recycleAllBaffleItem(arg_33_0)
	local var_33_0

	for iter_33_0 = 1, #arg_33_0._baffleItems do
		local var_33_1 = arg_33_0._baffleItems[iter_33_0]

		var_33_1:recycle()
		table.insert(arg_33_0._baffleItemPool, var_33_1)

		arg_33_0._baffleItems[iter_33_0] = nil
	end
end

function var_0_0.recycleAllInteract(arg_34_0)
	for iter_34_0, iter_34_1 in ipairs(arg_34_0._interactItemList) do
		iter_34_1:deleteSelf()
	end
end

function var_0_0.disposeInteractItem(arg_35_0)
	for iter_35_0, iter_35_1 in ipairs(arg_35_0._interactItemList) do
		iter_35_1:dispose()
	end

	arg_35_0._interactItemList = nil
end

function var_0_0.disposeBaffle(arg_36_0)
	local var_36_0

	for iter_36_0 = 1, #arg_36_0._baffleItems do
		arg_36_0._baffleItems[iter_36_0]:dispose()
	end

	for iter_36_1 = 1, #arg_36_0._baffleItemPool do
		arg_36_0._baffleItemPool[iter_36_1]:dispose()
	end

	arg_36_0._baffleItems = nil
	arg_36_0._baffleItemPool = nil
end

function var_0_0.disposeSceneRoot(arg_37_0)
	if arg_37_0._sceneRoot then
		gohelper.destroy(arg_37_0._sceneRoot)

		arg_37_0._sceneRoot = nil
	end
end

function var_0_0.releaseLoader(arg_38_0)
	if arg_38_0._loader then
		arg_38_0._loader:dispose()

		arg_38_0._loader = nil
	end
end

function var_0_0.resetMapView(arg_39_0)
	YaXianGameModel.instance:setGameLoadDone(false)
	arg_39_0:recycleBaseTiles()
	arg_39_0:recycleAllInteract()
	arg_39_0:recycleAllBaffleItem()
end

function var_0_0.onUpdateEffectInfo(arg_40_0)
	local var_40_0 = YaXianGameModel.instance:isShowVisibleStatus()
	local var_40_1 = YaXianGameModel.instance:isShowThroughStatus()

	if var_40_0 and var_40_1 then
		arg_40_0.playerInteractItem:playAnimation(YaXianGameEnum.InteractAnimationName.TwoEffect)

		return
	end

	if var_40_0 then
		arg_40_0.playerInteractItem:playAnimation(YaXianGameEnum.InteractAnimationName.InVisible)

		return
	end

	if var_40_1 then
		arg_40_0.playerInteractItem:playAnimation(YaXianGameEnum.InteractAnimationName.ThroughWall)

		return
	end

	arg_40_0.playerInteractItem:stopAnimation()
end

function var_0_0.onSelectInteract(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0:findInteractItem(arg_41_1)

	if var_41_0 and not var_41_0.delete and var_41_0:getHandler() then
		var_41_0:getHandler():onSelectCall()
	end
end

function var_0_0.onCancelSelectInteract(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_0:findInteractItem(arg_42_1)

	if var_42_0 and not var_42_0.delete and var_42_0:getHandler() then
		var_42_0:getHandler():onCancelSelect()
	end
end

function var_0_0.onUpdateRound(arg_43_0)
	YaXianGameController.instance:updateAllPosInteractActive()
	YaXianGameController.instance:autoSelectPlayer()
end

function var_0_0.onRevert(arg_44_0)
	YaXianGameController.instance:setSelectObj()
	arg_44_0:createAllInteractObjs()
	arg_44_0:checkAllInteractLoadDone()
	YaXianGameController.instance:updateAllPosInteractActive()
end

function var_0_0.onClose(arg_45_0)
	TaskDispatcher.cancelTask(arg_45_0.playFeatureAnimation, arg_45_0)
end

function var_0_0.onDestroyView(arg_46_0)
	if arg_46_0._click then
		arg_46_0._click:RemoveClickListener()

		arg_46_0._click = nil
	end

	arg_46_0._baseTiles = nil

	arg_46_0:disposeInteractItem()
	arg_46_0:disposeBaffle()
	arg_46_0:disposeSceneRoot()
	arg_46_0:releaseLoader()
end

return var_0_0
