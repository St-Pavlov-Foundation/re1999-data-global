module("modules.logic.versionactivity2_7.dungeon.view.map.scene.VersionActivity2_7DungeonMapScene", package.seeall)

local var_0_0 = class("VersionActivity2_7DungeonMapScene", VersionActivityFixedDungeonMapScene)
local var_0_1 = 1
local var_0_2 = 0.16

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0._screenWidth, arg_1_0._screenHeight = GameGlobalMgr.instance:getScreenState():getScreenSize()
	arg_1_0._mainCameraGO = CameraMgr.instance:getMainCameraGO()
	arg_1_0._mainRoot = CameraMgr.instance:getCameraTraceGO()
	arg_1_0._mainCamera = CameraMgr.instance:getMainCamera()
	arg_1_0._mainCameraAnim = gohelper.onceAddComponent(CameraMgr.instance:getCameraRootGO(), typeof(UnityEngine.Animator))
	arg_1_0._mainCustomCameraData = arg_1_0._mainCameraGO:GetComponent(PostProcessingMgr.PPCustomCamDataType)
	arg_1_0._unitCameraGO = CameraMgr.instance:getUnitCameraGO()
	arg_1_0._unitCamera = CameraMgr.instance:getUnitCamera()
	arg_1_0._ppVolumeGo = gohelper.findChild(arg_1_0._unitCameraGO, "PPVolume")
	arg_1_0._unitPPVolume = arg_1_0._ppVolumeGo:GetComponent(PostProcessingMgr.PPVolumeWrapType)

	local var_1_0, var_1_1 = transformhelper.getLocalRotation(arg_1_0._mainRoot.transform)

	arg_1_0._ppvalue = {
		BloomActive = false,
		bloomThreshold = 0.7,
		localBloomActive = false
	}

	local var_1_2 = {}

	for iter_1_0, iter_1_1 in pairs(arg_1_0._ppvalue) do
		var_1_2[iter_1_0] = PostProcessingMgr.instance:getUnitPPValue(iter_1_0)
	end

	local var_1_3 = PostProcessingMgr.instance:getIgnoreUIBlur()

	arg_1_0._cameraParam = {
		runtimeAnimatorController = arg_1_0._mainCameraAnim.runtimeAnimatorController,
		volumeTrigger = arg_1_0._mainCustomCameraData.volumeTrigger,
		usePostProcess = arg_1_0._mainCustomCameraData.usePostProcess,
		unitCameraGOActive = arg_1_0._unitCameraGO.gameObject.activeSelf,
		unitCameraEnable = arg_1_0._unitCamera.enabled,
		unitPPValue = var_1_2,
		orthographic = arg_1_0._mainCamera.orthographic,
		Fov = arg_1_0._mainCamera.fieldOfView,
		RotateY = var_1_1,
		IgnoreUIBlur = var_1_3
	}
	arg_1_0._isNeedCircleMv = UIBlockMgrExtend.needCircleMv
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, arg_2_0._onOpenFullViewFinish, arg_2_0, LuaEventSystem.Low)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0._onOpenView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0)
	arg_2_0:addEventCb(VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.SwitchBGM, arg_2_0._switchBGM, arg_2_0)
	arg_2_0:addEventCb(VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OpenFinishMapLevelView, arg_2_0._openFinishMapLevelView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, arg_3_0._onOpenFullViewFinish, arg_3_0, LuaEventSystem.Low)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0._onOpenView, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
	arg_3_0:removeEventCb(VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.SwitchBGM, arg_3_0._switchBGM, arg_3_0)
	arg_3_0:removeEventCb(VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OpenFinishMapLevelView, arg_3_0._openFinishMapLevelView, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0:_onLoadRes()
	var_0_0.super.onOpen(arg_4_0)
end

function var_0_0._checkCameraParam(arg_5_0)
	if arg_5_0:_isSpaceScene() then
		arg_5_0:_setCameraParam()
	else
		arg_5_0:_resetCameraParam()
	end
end

function var_0_0._onOpenFullViewFinish(arg_6_0, arg_6_1)
	if arg_6_1 == arg_6_0.viewName then
		arg_6_0:_checkCameraParam()
	end
end

local var_0_3 = {
	ViewName.VersionActivity2_7StoreView,
	ViewName.VersionActivity2_7TaskView,
	ViewName.DungeonRewardView,
	ViewName.StoryFrontView
}

function var_0_0._onOpenView(arg_7_0, arg_7_1)
	if LuaUtil.tableContains(var_0_3, arg_7_1) then
		arg_7_0:_resetCameraParam()
	end

	if arg_7_1 == ViewName.StoryFrontView then
		arg_7_0:_playSceneBgm(false)
	end
end

function var_0_0._openFinishMapLevelView(arg_8_0, arg_8_1)
	arg_8_0:_setLoadParent(arg_8_1)
end

function var_0_0._onCloseView(arg_9_0, arg_9_1)
	if LuaUtil.tableContains(var_0_3, arg_9_1) then
		arg_9_0:_checkCameraParam()
	end

	if arg_9_1 == ViewName.VersionActivity2_7DungeonMapLevelView then
		arg_9_0:_setLoadParent(arg_9_0.viewGO)
	end
end

function var_0_0._onCloseViewFinish(arg_10_0, arg_10_1)
	if arg_10_1 == ViewName.StoryFrontView then
		arg_10_0:_switchBGM()
		arg_10_0:refreshMap()
	end
end

function var_0_0._switchBGM(arg_11_0)
	local var_11_0 = arg_11_0:_isSpaceScene()

	arg_11_0:_playSceneBgm(var_11_0)
end

function var_0_0._setLoadParent(arg_12_0, arg_12_1)
	if arg_12_0._loadObj then
		arg_12_0._loadObj.transform:SetParent(arg_12_1.transform, true)
	end
end

function var_0_0._cancelTask(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._cutSpaceScene, arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._spaceSceneAnimFinish, arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._enterOrReturnSpace, arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._setMapPos, arg_13_0)
end

function var_0_0.onClose(arg_14_0)
	var_0_0.super.onClose(arg_14_0)
	arg_14_0:_cancelTask()
	arg_14_0:_resetCameraParam()
	arg_14_0:_playSceneBgm(false)

	if arg_14_0._rotateTweenId then
		ZProj.TweenHelper.KillById(arg_14_0._rotateTweenId)
	end

	arg_14_0:tweenFinishRotateCallback()

	if arg_14_0._mainCameraAnim then
		arg_14_0._mainCameraAnim.runtimeAnimatorController = arg_14_0._cameraParam.runtimeAnimatorController
	end

	arg_14_0._curEpisodeIndex = nil

	VersionActivity2_7DungeonController.instance:resetLoading()

	local var_14_0, var_14_1 = GameGlobalMgr.instance:getScreenState():getScreenSize()

	if var_14_0 ~= arg_14_0._screenWidth or var_14_1 ~= arg_14_0._screenHeight then
		GameGlobalMgr.instance:dispatchEvent(GameStateEvent.OnScreenResize, var_14_0, var_14_1)
	end
end

function var_0_0.refreshMap(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0._mapCfg = arg_15_2 or VersionActivityFixedDungeonConfig.instance:getEpisodeMapConfig(arg_15_0.activityDungeonMo.episodeId)
	arg_15_0.needTween = arg_15_1

	arg_15_0:_checkGoSpaceOrReturn()
end

function var_0_0._initScene(arg_16_0)
	if gohelper.findChild(arg_16_0._sceneGo, "root/size") then
		var_0_0.super._initScene(arg_16_0)
	else
		arg_16_0._mapMinX = nil
		arg_16_0._mapMaxX = nil
		arg_16_0._mapMinY = nil
		arg_16_0._mapMaxY = nil
	end
end

function var_0_0._reallyCutScene(arg_17_0)
	if arg_17_0._mapCfg.id == arg_17_0._lastLoadMapId then
		if not arg_17_0.loadedDone then
			return
		end

		arg_17_0:_initElements()
		arg_17_0:_setMapPos()
	else
		if arg_17_0._lastLoadMapId and lua_chapter_map.configDict[arg_17_0._lastLoadMapId].res == arg_17_0._mapCfg.res then
			arg_17_0._lastLoadMapId = arg_17_0._mapCfg.id

			arg_17_0:_initScene()
			arg_17_0:_setMapPos()
			arg_17_0:_addMapLight()
			arg_17_0:_initElements()
			arg_17_0:_addMapAudio()

			return
		end

		arg_17_0._lastLoadMapId = arg_17_0._mapCfg.id

		arg_17_0:loadMap()
	end

	VersionActivityFixedDungeonModel.instance:setMapNeedTweenState(true)
end

var_0_0.UI_CLICK_BLOCK_KEY = "VersionActivity2_7DungeonMapScene_Click"

function var_0_0._startBlock(arg_18_0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(var_0_0.UI_CLICK_BLOCK_KEY)
end

function var_0_0._endBlock(arg_19_0)
	UIBlockMgrExtend.setNeedCircleMv(arg_19_0._isNeedCircleMv)
	UIBlockMgr.instance:endBlock(var_0_0.UI_CLICK_BLOCK_KEY)
end

function var_0_0._checkGoSpaceOrReturn(arg_20_0)
	local var_20_0 = DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(arg_20_0.activityDungeonMo.episodeId)
	local var_20_1 = arg_20_0._curEpisodeIndex

	arg_20_0:_cancelTask()

	if var_20_1 and not arg_20_0:_isSpaceScene(var_20_1) and arg_20_0:_isSpaceScene(var_20_0) then
		arg_20_0._sceneAnimType = VersionActivity2_7DungeonEnum.SceneAnimType.GotoSpace

		arg_20_0:_startBlock()
		arg_20_0:_tweenPreSpaceScenePos()
	elseif var_20_1 and arg_20_0:_isSpaceScene(var_20_1) and not arg_20_0:_isSpaceScene(var_20_0) then
		arg_20_0._sceneAnimType = VersionActivity2_7DungeonEnum.SceneAnimType.ReturnEarth

		arg_20_0:_startBlock()
		arg_20_0:_enterOrReturnSpace()
	else
		arg_20_0._sceneAnimType = VersionActivity2_7DungeonEnum.SceneAnimType.Normal

		arg_20_0:_reallyCutScene()
	end

	arg_20_0._curEpisodeIndex = var_20_0
end

function var_0_0._getEpisodeCoByIndex(arg_21_0, arg_21_1)
	if not arg_21_0._episodeList then
		local var_21_0 = VersionActivityFixedHelper.getVersionActivityDungeonEnum()

		arg_21_0._episodeList = DungeonConfig.instance:getChapterEpisodeCOList(var_21_0.DungeonChapterId.Story)
	end

	if arg_21_0._episodeList[arg_21_1] then
		local var_21_1 = arg_21_0._episodeList[arg_21_1].id

		return lua_chapter_map.configDict[var_21_1]
	end
end

function var_0_0._getPreSpaceScenePos(arg_22_0)
	local var_22_0 = arg_22_0:_getFirstSpaceSceneEpisodeIndex() - 1

	return arg_22_0:_getEpisodeCoByIndex(var_22_0).initPos
end

function var_0_0._getFirstSpaceSceneEpisodeIndex(arg_23_0)
	return VersionActivity2_7DungeonEnum.SpaceSceneEpisodeIndexs[1] or 18
end

function var_0_0._tweenPreSpaceScenePos(arg_24_0)
	local var_24_0 = arg_24_0:_getPreSpaceScenePos()
	local var_24_1 = string.splitToNumber(var_24_0, "#")

	arg_24_0._tempVector:Set(var_24_1[1], var_24_1[2], 0)

	if arg_24_0._tempVector == arg_24_0._oldScenePos then
		arg_24_0:tweenFinishCallback()

		return
	end

	arg_24_0:tweenSetScenePos(arg_24_0._tempVector, arg_24_0._oldScenePos)
end

function var_0_0.focusElementByCo(arg_25_0, arg_25_1)
	local var_25_0 = string.splitToNumber(arg_25_1.pos, "#")
	local var_25_1 = -var_25_0[1] or 0
	local var_25_2 = -var_25_0[2] or 0

	arg_25_0._tempVector:Set(var_25_1, var_25_2, 0)
	arg_25_0:tweenSetScenePos(arg_25_0._tempVector)
end

function var_0_0.tweenFinishCallback(arg_26_0)
	var_0_0.super.tweenFinishCallback(arg_26_0)

	if arg_26_0._sceneAnimType == VersionActivity2_7DungeonEnum.SceneAnimType.GotoSpace then
		TaskDispatcher.cancelTask(arg_26_0._enterOrReturnSpace, arg_26_0)
		TaskDispatcher.runDelay(arg_26_0._enterOrReturnSpace, arg_26_0, var_0_2)

		arg_26_0.needTween = false
	end
end

function var_0_0._loadSceneFinish(arg_27_0)
	arg_27_0.loadedDone = true

	arg_27_0:disposeOldMap()

	local var_27_0 = arg_27_0._sceneUrl
	local var_27_1 = arg_27_0._mapLoader:getAssetItem(var_27_0):GetResource(var_27_0)

	arg_27_0._sceneGo = gohelper.clone(var_27_1, arg_27_0._sceneRoot, arg_27_0._mapCfg.id)
	arg_27_0._sceneTrans = arg_27_0._sceneGo.transform

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnLoadSceneFinish, {
		mapConfig = arg_27_0._mapCfg,
		mapSceneGo = arg_27_0._sceneGo
	})
	TaskDispatcher.cancelTask(arg_27_0._setMapPos, arg_27_0)
	arg_27_0:_initScene()

	if arg_27_0._sceneAnimType == VersionActivity2_7DungeonEnum.SceneAnimType.ReturnEarth then
		arg_27_0:_tweenPreSpaceScenePos()
		arg_27_0:_resetCameraParam()
	else
		if arg_27_0._sceneAnimType == VersionActivity2_7DungeonEnum.SceneAnimType.GotoSpace then
			arg_27_0._sceneAnimType = VersionActivity2_7DungeonEnum.SceneAnimType.Normal
		end

		arg_27_0:_setMapPos()
	end

	arg_27_0:_addMapLight()
	arg_27_0:_initElements()
	arg_27_0:_addMapAudio()
	VersionActivity2_7DungeonController.instance:loadingFinish(arg_27_0.activityDungeonMo.episodeId, arg_27_0._sceneGo)
end

function var_0_0._enterOrReturnSpace(arg_28_0)
	gohelper.setActive(arg_28_0._loadObj, true)

	local var_28_0 = arg_28_0._sceneAnimType == VersionActivity2_7DungeonEnum.SceneAnimType.GotoSpace

	arg_28_0:_playEnterOrReturnSpaceAnim(var_28_0, 0)

	local var_28_1 = var_28_0 and VersionActivity2_7DungeonEnum.GotoSpaceAnimName or VersionActivity2_7DungeonEnum.returnAnimName

	arg_28_0:_playSceneAnimBgm(var_28_0)

	local var_28_2 = 2.2

	if arg_28_0._animClipTime and arg_28_0._animClipTime[var_28_1] then
		var_28_2 = arg_28_0._animClipTime[var_28_1]
	end

	TaskDispatcher.cancelTask(arg_28_0._cutSpaceScene, arg_28_0)
	TaskDispatcher.runDelay(arg_28_0._cutSpaceScene, arg_28_0, var_0_1)
	TaskDispatcher.cancelTask(arg_28_0._spaceSceneAnimFinish, arg_28_0)
	TaskDispatcher.runDelay(arg_28_0._spaceSceneAnimFinish, arg_28_0, var_28_2)
end

function var_0_0._playEnterOrReturnSpaceAnim(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_1 and VersionActivity2_7DungeonEnum.GotoSpaceAnimName or VersionActivity2_7DungeonEnum.returnAnimName

	if arg_29_0._mainCameraAnim then
		arg_29_0._mainCameraAnim.enabled = true

		arg_29_0._mainCameraAnim:Play(var_29_0, 0, arg_29_2 or 0)
	end

	if arg_29_0._loadAnim then
		arg_29_0._loadAnim:Play(var_29_0, 0, arg_29_2 or 0)
	end

	if arg_29_2 == 1 then
		arg_29_0:_playSceneBgm(arg_29_1)
	else
		arg_29_0:_playSceneAnimBgm(arg_29_1)
	end
end

function var_0_0._playSceneBgm(arg_30_0, arg_30_1)
	local var_30_0 = AudioEnum2_7.VersionActivity2_7SpaceBGM
	local var_30_1 = arg_30_1 and var_30_0.play_2_7_yuzhou_ui_checkpoint_amb_space or var_30_0.stop_2_7_yuzhou_ui_checkpoint_amb_space

	AudioMgr.instance:trigger(var_30_1)
end

function var_0_0._playSceneAnimBgm(arg_31_0, arg_31_1)
	local var_31_0 = AudioEnum2_7.VersionActivity2_7SpaceBGM
	local var_31_1 = arg_31_1 and var_31_0.play_2_7_yuzhou_ui_checkinspace or var_31_0.play_2_7_yuzhou_ui_checkoutspace

	AudioMgr.instance:trigger(var_31_1)
end

function var_0_0._cutSpaceScene(arg_32_0)
	arg_32_0:_reallyCutScene()

	if arg_32_0:_isSpaceScene() then
		arg_32_0:_setCameraParam()
	end
end

function var_0_0._spaceSceneAnimFinish(arg_33_0)
	arg_33_0:_setLoadParent(arg_33_0.viewGO)
	gohelper.setActive(arg_33_0._loadObj, false)

	local var_33_0 = arg_33_0:_isSpaceScene()

	if not var_33_0 then
		arg_33_0._mainCameraAnim.enabled = false
	end

	if arg_33_0._sceneAnimType == VersionActivity2_7DungeonEnum.SceneAnimType.ReturnEarth then
		arg_33_0.needTween = true

		TaskDispatcher.cancelTask(arg_33_0._setMapPos, arg_33_0)

		if arg_33_0._curEpisodeIndex == arg_33_0:_getFirstSpaceSceneEpisodeIndex() - 1 then
			arg_33_0:_setMapPos()
		else
			TaskDispatcher.runDelay(arg_33_0._setMapPos, arg_33_0, var_0_2)
		end

		arg_33_0._sceneAnimType = VersionActivity2_7DungeonEnum.SceneAnimType.Normal
	end

	arg_33_0:_playSceneBgm(var_33_0)
	arg_33_0:_endBlock()
end

function var_0_0._onLoadRes(arg_34_0)
	if arg_34_0._loader then
		arg_34_0._loader:dispose()
	end

	local var_34_0 = {
		VersionActivity2_7DungeonEnum.SceneLoadObj,
		VersionActivity2_7DungeonEnum.SceneLoadAnim
	}

	arg_34_0._loader = MultiAbLoader.New()

	arg_34_0._loader:setPathList(var_34_0)
	arg_34_0._loader:startLoad(arg_34_0._onLoadedFinish, arg_34_0)
end

function var_0_0._onLoadedFinish(arg_35_0)
	local var_35_0 = VersionActivity2_7DungeonEnum.SceneLoadAnim
	local var_35_1 = VersionActivity2_7DungeonEnum.SceneLoadObj
	local var_35_2 = arg_35_0._loader:getAssetItem(var_35_0):GetResource(var_35_0)
	local var_35_3 = arg_35_0._loader:getAssetItem(var_35_1):GetResource(var_35_1)

	arg_35_0._loadObj = gohelper.clone(var_35_3, arg_35_0.viewGO)
	arg_35_0._loadAnim = gohelper.onceAddComponent(arg_35_0._loadObj, typeof(UnityEngine.Animator))

	gohelper.setActive(arg_35_0._loadObj, false)

	arg_35_0._mainCameraAnim.runtimeAnimatorController = var_35_2
	arg_35_0._mainCameraAnim.enabled = false

	if not arg_35_0._animClipTime then
		arg_35_0._animClipTime = {}

		if var_35_2 then
			for iter_35_0 = 0, var_35_2.animationClips.Length - 1 do
				local var_35_4 = var_35_2.animationClips[iter_35_0]

				arg_35_0._animClipTime[var_35_4.name] = var_35_4.length
			end
		end
	end

	arg_35_0:_playEnterOrReturnSpaceAnim(arg_35_0:_isSpaceScene(), 1)
end

function var_0_0._setCameraParam(arg_36_0)
	arg_36_0._mainCustomCameraData.usePostProcess = true
	arg_36_0._mainCustomCameraData.volumeTrigger = arg_36_0._ppVolumeGo.transform

	gohelper.setActive(arg_36_0._unitCameraGO, true)

	arg_36_0._unitCamera.enabled = false

	for iter_36_0, iter_36_1 in pairs(arg_36_0._ppvalue) do
		PostProcessingMgr.instance:setUnitPPValue(iter_36_0, iter_36_1)
	end

	PostProcessingMgr.instance:setIgnoreUIBlur(true)
end

function var_0_0._resetCameraParam(arg_37_0)
	arg_37_0._mainCustomCameraData.usePostProcess = arg_37_0._cameraParam.usePostProcess
	arg_37_0._mainCustomCameraData.volumeTrigger = arg_37_0._cameraParam.volumeTrigger

	gohelper.setActive(arg_37_0._unitCameraGO, arg_37_0._cameraParam.unitCameraGOActive)

	arg_37_0._unitCamera.enabled = arg_37_0._cameraParam.unitCameraEnable

	local var_37_0 = arg_37_0._cameraParam.unitPPValue

	for iter_37_0, iter_37_1 in pairs(arg_37_0._ppvalue) do
		PostProcessingMgr.instance:setUnitPPValue(iter_37_0, var_37_0[iter_37_0])
	end

	PostProcessingMgr.instance:setIgnoreUIBlur(arg_37_0._cameraParam.IgnoreUIBlur)
end

function var_0_0._initCamera(arg_38_0)
	if not arg_38_0:_isSpaceScene() then
		var_0_0.super._initCamera(arg_38_0)
	end
end

function var_0_0._resetCamera(arg_39_0)
	if not arg_39_0:_isSpaceScene() then
		var_0_0.super._resetCamera(arg_39_0)
	end
end

function var_0_0._isSpaceScene(arg_40_0, arg_40_1)
	local var_40_0 = VersionActivity2_7DungeonEnum.SpaceSceneEpisodeIndexs

	arg_40_1 = arg_40_1 or DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(arg_40_0.activityDungeonMo.episodeId)

	for iter_40_0, iter_40_1 in ipairs(var_40_0) do
		if arg_40_1 == iter_40_1 then
			return true
		end
	end
end

function var_0_0._onDragBegin(arg_41_0, arg_41_1, arg_41_2)
	var_0_0.super._onDragBegin(arg_41_0, arg_41_1, arg_41_2)
	arg_41_0:killTween()
end

function var_0_0._onDrag(arg_42_0, arg_42_1, arg_42_2)
	if arg_42_0:_isSpaceScene() then
		local var_42_0 = arg_42_2.delta.x
		local var_42_1, var_42_2, var_42_3 = transformhelper.getLocalRotation(arg_42_0._mainRoot.transform)

		if var_42_2 > 200 then
			var_42_2 = var_42_2 - 360
		end

		local var_42_4 = Mathf.Clamp(var_42_2 + var_42_0, -35, 35)

		arg_42_0:directSetCameraRotate(var_42_1, var_42_4, var_42_3)
	else
		var_0_0.super._onDrag(arg_42_0, arg_42_1, arg_42_2)
	end
end

function var_0_0._onDragEnd(arg_43_0, arg_43_1, arg_43_2)
	arg_43_0:killTween()

	if arg_43_0:_isSpaceScene() then
		local var_43_0, var_43_1, var_43_2 = transformhelper.getLocalRotation(arg_43_0._mainRoot.transform)
		local var_43_3 = arg_43_0._cameraParam.RotateY

		if var_43_1 > 200 then
			var_43_3 = 360
		end

		arg_43_0._rotateTweenId = ZProj.TweenHelper.DOTweenFloat(var_43_1, var_43_3, VersionActivity2_7DungeonEnum.DragEndAnimTime, arg_43_0.tweenFrameRotateCallback, arg_43_0.tweenFinishRotateCallback, arg_43_0, nil, EaseType.OutCubic)
	else
		arg_43_0._dragBeginPos = nil
	end
end

function var_0_0.killTween(arg_44_0)
	var_0_0.super.killTween(arg_44_0)

	if arg_44_0._rotateTweenId then
		ZProj.TweenHelper.KillById(arg_44_0._rotateTweenId)
	end
end

function var_0_0.tweenFrameRotateCallback(arg_45_0, arg_45_1)
	if not arg_45_0._mainRoot then
		arg_45_0._mainRoot = CameraMgr.instance:getCameraTraceGO()
	end

	local var_45_0, var_45_1, var_45_2 = transformhelper.getLocalRotation(arg_45_0._mainRoot.transform)

	transformhelper.setLocalRotation(arg_45_0._mainRoot.transform, var_45_0, arg_45_1, var_45_2)
end

function var_0_0.tweenFinishRotateCallback(arg_46_0)
	if not arg_46_0._mainRoot then
		arg_46_0._mainRoot = CameraMgr.instance:getCameraTraceGO()
	end

	local var_46_0, var_46_1, var_46_2 = transformhelper.getLocalRotation(arg_46_0._mainRoot.transform)
	local var_46_3 = arg_46_0._cameraParam.RotateY

	transformhelper.setLocalRotation(arg_46_0._mainRoot.transform, var_46_0, var_46_3, var_46_2)
end

function var_0_0.directSetCameraRotate(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	if not arg_47_0._mainRoot or gohelper.isNil(arg_47_0._mainRoot) then
		return
	end

	local var_47_0 = Time.deltaTime * VersionActivity2_7DungeonEnum.DragSpeed

	transformhelper.setLocalRotationLerp(arg_47_0._mainRoot.transform, arg_47_1, arg_47_2, arg_47_3, var_47_0)
	VersionActivityFixedHelper.getVersionActivityDungeonController().instance:dispatchEvent(VersionActivityFixedDungeonEvent.OnMapPosChanged, arg_47_0._scenePos, arg_47_0.needTween)
	arg_47_0:_updateElementArrow()
end

function var_0_0.onDestroyView(arg_48_0)
	var_0_0.super.onDestroyView(arg_48_0)

	if arg_48_0._loader then
		arg_48_0._loader:dispose()

		arg_48_0._loader = nil
	end

	if arg_48_0._loadObj then
		gohelper.destroy(arg_48_0._loadObj)

		arg_48_0._loadObj = nil
		arg_48_0._loadAnim = nil
	end
end

return var_0_0
