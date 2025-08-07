module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonMapScene", package.seeall)

local var_0_0 = class("VersionActivity2_9DungeonMapScene", VersionActivityFixedDungeonMapScene)

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)

	arg_1_0._mapPosYCurve = ZProj.AnimationCurveHelper.GetAnimationCurve(VersionActivity2_9DungeonEnum.MapPosYCurve)
	arg_1_0._mapPosZCurve = ZProj.AnimationCurveHelper.GetAnimationCurve(VersionActivity2_9DungeonEnum.MapPosZCurve)
	arg_1_0._mapWorldPos = Vector3()
	arg_1_0._mapLocalPos = Vector3()
	arg_1_0._offset = Vector2()
	arg_1_0._tempVector2 = Vector2()
	arg_1_0._tempVector3 = Vector3()

	arg_1_0:initBg()
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0:addEventCb(VersionActivity2_9DungeonController.instance, VersionActivity2_9Event.OnAllWorkLoadDone, arg_2_0._onAllWorkLoadDone, arg_2_0)
	arg_2_0:addEventCb(VersionActivity2_9DungeonController.instance, VersionActivity2_9Event.OnScrollEpisodeList, arg_2_0._onScrollEpisodeList, arg_2_0)
	arg_2_0:addEventCb(VersionActivity2_9DungeonController.instance, VersionActivity2_9Event.OnSelectEpisodeItem, arg_2_0._onSelectEpisodeItem, arg_2_0)
	arg_2_0:addEventCb(VersionActivity2_9DungeonController.instance, VersionActivity2_9Event.OnEpisodeListVisible, arg_2_0._onEpisodeListVisible, arg_2_0)
	arg_2_0:addEventCb(VersionActivity2_9DungeonController.instance, VersionActivity2_9Event.FocusEpisodeNode, arg_2_0._focusEpisodeNode, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_2_0._initMapMoveRange, arg_2_0, LuaEventSystem.High)
end

function var_0_0.initBg(arg_3_0)
	local var_3_0 = arg_3_0.viewContainer:getSetting()

	arg_3_0._gobgroot = arg_3_0:getResInst(var_3_0.otherRes[4], arg_3_0._sceneRoot, "bgroot")
	arg_3_0._gocanvas = gohelper.findChild(arg_3_0._gobgroot, "Canvas")
	arg_3_0._canvas = arg_3_0._gocanvas:GetComponent("Canvas")
	arg_3_0._canvas.worldCamera = CameraMgr.instance:getMainCamera()
	arg_3_0._govideo = gohelper.findChild(arg_3_0._gobgroot, "Canvas/#go_video")
	arg_3_0._bgVideoComp = VersionActivityVideoComp.get(arg_3_0._govideo, arg_3_0)

	arg_3_0._bgVideoComp:play(langVideoUrl(VersionActivity2_9DungeonEnum.MapBgAudioName), true)
end

function var_0_0.refreshMap(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._mapCfg = arg_4_2 or VersionActivityFixedDungeonConfig.instance:getEpisodeMapConfig(arg_4_0.activityDungeonMo.episodeId)
	arg_4_0.needTween = arg_4_1

	if arg_4_0._mapCfg.id == arg_4_0._lastLoadMapId then
		if not arg_4_0.loadedDone then
			return
		end

		arg_4_0:_initElements()
		arg_4_0:_setMapPos()
		arg_4_0:_initSelectEpisode()
	elseif arg_4_0._mapCfg.res == arg_4_0._lastLoadMapRes then
		if not arg_4_0.loadedDone then
			return
		end

		DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnChangeMap)
		DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnDisposeOldMap, arg_4_0.viewName)
		DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnLoadSceneFinish, {
			mapConfig = arg_4_0._mapCfg,
			mapSceneGo = arg_4_0._sceneGo
		})

		arg_4_0._lastLoadMapId = arg_4_0._mapCfg.id

		arg_4_0:_initElements()
		arg_4_0:_setMapPos()
		arg_4_0:_initSelectEpisode()
	else
		arg_4_0:loadMap()
	end

	VersionActivityFixedDungeonModel.instance:setMapNeedTweenState(true)
end

function var_0_0.loadMap(arg_5_0)
	var_0_0.super.loadMap(arg_5_0)

	arg_5_0._lastLoadMapId = arg_5_0._mapCfg.id
	arg_5_0._lastLoadMapRes = arg_5_0._mapCfg.res
end

function var_0_0._disposeScene(arg_6_0)
	var_0_0.super._disposeScene(arg_6_0)

	arg_6_0.loadedDone = false
	arg_6_0._lastLoadMapId = nil
	arg_6_0._lastLoadMapRes = nil
	arg_6_0._episodeNodeList = nil
	arg_6_0._curSelectIndex = nil
end

function var_0_0._loadSceneFinish(arg_7_0)
	var_0_0.super._loadSceneFinish(arg_7_0)

	arg_7_0._goroot = gohelper.findChild(arg_7_0._sceneGo, "root")
	arg_7_0._tranroot = arg_7_0._goroot.transform
	arg_7_0._goelementroot = gohelper.findChild(arg_7_0._sceneGo, "elementRoot")
	arg_7_0._tranelementroot = arg_7_0._goelementroot.transform
	arg_7_0._rootAnimator = gohelper.onceAddComponent(arg_7_0._goroot, gohelper.Type_Animator)

	arg_7_0:_buildEpisodeNodeList()
	arg_7_0:_initMapMoveRange()
	arg_7_0:_initSelectEpisode()
	arg_7_0:_updateRootPosition(arg_7_0._curRootLocalPosX, arg_7_0._curRootLocalPosY, arg_7_0._curRootLocalPosZ)
	VersionActivity2_9DungeonController.instance:dispatchEvent(VersionActivity2_9Event.OnOneWorkLoadDone, VersionActivity2_9DungeonEnum.LoadWorkType.Scene)
end

function var_0_0._initSelectEpisode(arg_8_0)
	local var_8_0 = arg_8_0.activityDungeonMo.episodeId
	local var_8_1 = DungeonConfig.instance:getChapterEpisodeCOList(arg_8_0.activityDungeonMo.chapterId)

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		if iter_8_1.id == var_8_0 then
			arg_8_0:_onSelectEpisodeItem(iter_8_0, true)

			break
		end
	end
end

function var_0_0._initMapMoveRange(arg_9_0)
	if not arg_9_0.loadedDone then
		return
	end

	arg_9_0._maxRootLocalPosX = arg_9_0._sceneTrans:InverseTransformPoint(VersionActivity2_9DungeonEnum.MapStartWorldPos).x
	arg_9_0._minRootLocalPosX = arg_9_0._maxRootLocalPosX
	arg_9_0._unlockEpisodeCount = VersionActivity2_9DungeonController.instance:getUnlockEpisodeCount(arg_9_0.activityDungeonMo.chapterId)

	local var_9_0 = arg_9_0:_getRootLocalPos4Focus(arg_9_0._unlockEpisodeCount)
	local var_9_1 = var_9_0 and var_9_0.x or 0
	local var_9_2 = var_9_1 > arg_9_0._maxRootLocalPosX

	arg_9_0._minRootLocalPosX = var_9_2 and arg_9_0._maxRootLocalPosX or var_9_1
	arg_9_0._maxRootLocalPosX = var_9_2 and var_9_1 or arg_9_0._maxRootLocalPosX
end

function var_0_0._buildEpisodeNodeList(arg_10_0)
	arg_10_0._episodeNodeList = arg_10_0:getUserDataTb_()

	for iter_10_0 = 1, math.huge do
		local var_10_0 = gohelper.findChild(arg_10_0._sceneGo, string.format("root/node/dna_node_%02d", iter_10_0))
		local var_10_1 = gohelper.findChild(arg_10_0._sceneGo, string.format("root/level/mesh_dna_%02d", iter_10_0))

		if gohelper.isNil(var_10_0) or gohelper.isNil(var_10_1) then
			break
		end

		local var_10_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_10_0, VersionActivity2_9DungeonMapNodeItem, {
			index = iter_10_0,
			meshGO = var_10_1
		})

		arg_10_0._episodeNodeList[iter_10_0] = var_10_2
	end
end

function var_0_0._onSelectEpisodeItem(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0.loadedDone then
		return
	end

	if arg_11_0._curSelectIndex == arg_11_1 and arg_11_2 then
		return
	end

	arg_11_0:_playAnimtionForEpisodeNode(arg_11_0._curSelectIndex, false)
	arg_11_0:_playAnimtionForEpisodeNode(arg_11_1, arg_11_2)
end

function var_0_0._playAnimtionForEpisodeNode(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_1 then
		return
	end

	local var_12_0 = arg_12_0._episodeNodeList[arg_12_1]

	if not var_12_0 then
		logError(string.format("DNA缺少关卡节点 levelIndex = %s", arg_12_1))

		return
	end

	var_12_0:onSelect(arg_12_2)

	if arg_12_2 then
		arg_12_0._rootAnimator:Play(string.format("s01_level_%02d", arg_12_1))
	end

	arg_12_0._curSelectIndex = arg_12_2 and arg_12_1 or nil
end

function var_0_0._brocastAllNodePos(arg_13_0)
	if not arg_13_0.loadedDone or not arg_13_0._episodeNodeList then
		return
	end

	for iter_13_0, iter_13_1 in ipairs(arg_13_0._episodeNodeList) do
		iter_13_1:brocastPosition()
	end
end

function var_0_0._onScrollEpisodeList(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_0.loadedDone then
		return
	end

	local var_14_0, var_14_1, var_14_2 = arg_14_0:_getNextRootPos(arg_14_1 * VersionActivity2_9DungeonEnum.MapScrollOffsetRate)

	arg_14_0:_updateRootPosition(var_14_0, var_14_1, var_14_2)
	TaskDispatcher.cancelTask(arg_14_0._simulateEndDragTween, arg_14_0)

	if arg_14_2 then
		arg_14_0._stopVelocity = arg_14_1 or 0
		arg_14_0._stopVelocity = arg_14_0._stopVelocity * VersionActivity2_9DungeonEnum.MapStopVelocityRate

		TaskDispatcher.runRepeat(arg_14_0._simulateEndDragTween, arg_14_0, 0.01)
	end
end

function var_0_0._simulateEndDragTween(arg_15_0)
	arg_15_0._stopVelocity = Mathf.Lerp(arg_15_0._stopVelocity, 0, VersionActivity2_9DungeonEnum.MapTweenStopLerp)

	if Mathf.Abs(arg_15_0._stopVelocity, 0) <= 0.0001 then
		TaskDispatcher.cancelTask(arg_15_0._simulateEndDragTween, arg_15_0)

		return
	end

	local var_15_0, var_15_1, var_15_2 = arg_15_0:_getNextRootPos(arg_15_0._stopVelocity)

	arg_15_0:_updateRootPosition(var_15_0, var_15_1, var_15_2)
end

function var_0_0._getNextRootPos(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0._curRootLocalPosX + arg_16_1 / VersionActivity2_9DungeonEnum.PixelPerUnit
	local var_16_1, var_16_2, var_16_3 = arg_16_0:_getRootLocalPosXYZ(var_16_0)

	return var_16_1, var_16_2, var_16_3
end

function var_0_0._getRootLocalPosXYZ(arg_17_0, arg_17_1)
	arg_17_1 = Mathf.Clamp(arg_17_1, arg_17_0._minRootLocalPosX, arg_17_0._maxRootLocalPosX)

	local var_17_0 = (arg_17_0._maxRootLocalPosX - arg_17_1) / VersionActivity2_9DungeonEnum.MapMaxPosXRange
	local var_17_1 = arg_17_0._mapPosYCurve:Evaluate(var_17_0)
	local var_17_2 = arg_17_0._mapPosZCurve:Evaluate(var_17_0)

	return arg_17_1, var_17_1, var_17_2
end

function var_0_0._updateRootPosition(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if not arg_18_0._tranroot or not arg_18_0._tranelementroot then
		return
	end

	arg_18_0._curRootLocalPosX = arg_18_1 or 0
	arg_18_0._curRootLocalPosY = arg_18_2 or 0
	arg_18_0._curRootLocalPosZ = arg_18_3 or 0

	transformhelper.setLocalPos(arg_18_0._tranroot, arg_18_0._curRootLocalPosX, arg_18_0._curRootLocalPosY, arg_18_0._curRootLocalPosZ)
	transformhelper.setLocalPos(arg_18_0._tranelementroot, arg_18_0._curRootLocalPosX, arg_18_0._curRootLocalPosY, arg_18_0._curRootLocalPosZ)
	arg_18_0:_brocastAllNodePos()
	arg_18_0:_updateElementArrow()
end

function var_0_0._onAllWorkLoadDone(arg_19_0)
	arg_19_0:_brocastAllNodePos()
	arg_19_0:_tryFocusEpisodeNode()
end

function var_0_0._onEpisodeListVisible(arg_20_0, arg_20_1)
	if not arg_20_0.loadedDone then
		return
	end

	local var_20_0 = VersionActivity2_9DungeonEnum.Map_Hide_Root_PosY

	if arg_20_1 then
		_, var_20_0 = arg_20_0:_getRootLocalPosXYZ(arg_20_0._curRootLocalPosX)
	end

	arg_20_0:killTween()

	arg_20_0._isEpisodeListVisible = arg_20_1
	arg_20_0._mapTweenId = ZProj.TweenHelper.DOTweenFloat(arg_20_0._curRootLocalPosY, var_20_0, VersionActivity2_9DungeonEnum.Map_Visible_Tween_Time, arg_20_0._onUpdateEpisodeListVisibleFrameCb, arg_20_0._onUpdateEpisodeListVisibleDoneCb, arg_20_0)
end

function var_0_0._onUpdateEpisodeListVisibleFrameCb(arg_21_0, arg_21_1)
	arg_21_0:_updateRootPosition(arg_21_0._curRootLocalPosX, arg_21_1, arg_21_0._curRootLocalPosZ)
	VersionActivity2_9DungeonController.instance:dispatchEvent(VersionActivity2_9Event.OnTweenEpisodeListVisible)
end

function var_0_0._onUpdateEpisodeListVisibleDoneCb(arg_22_0, arg_22_1)
	VersionActivity2_9DungeonController.instance:dispatchEvent(VersionActivity2_9Event.OnEpisodeListVisibleDone, arg_22_0._isEpisodeListVisible)
end

function var_0_0._onDrag(arg_23_0, arg_23_1, arg_23_2)
	return
end

function var_0_0.directSetScenePos(arg_24_0, arg_24_1)
	var_0_0.super.directSetScenePos(arg_24_0, arg_24_1)
	arg_24_0:_brocastAllNodePos()
end

function var_0_0._initCamera(arg_25_0)
	CameraMgr.instance:getMainCamera().orthographic = false
end

function var_0_0._focusEpisodeNode(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0._focusIndex = arg_26_1
	arg_26_0._tween = arg_26_2

	if not arg_26_0.loadedDone then
		return
	end

	arg_26_0:_tryFocusEpisodeNode()
end

function var_0_0._tryFocusEpisodeNode(arg_27_0)
	if not arg_27_0._focusIndex or not arg_27_0._episodeNodeList[arg_27_0._focusIndex] then
		return
	end

	local var_27_0 = arg_27_0:_getRootLocalPos4Focus(arg_27_0._focusIndex)

	arg_27_0:_tweenMap2TargetPos(var_27_0, arg_27_0._tween)

	arg_27_0._focusIndex = nil
	arg_27_0._tween = false
end

function var_0_0._tweenMap2TargetPos(arg_28_0, arg_28_1, arg_28_2)
	arg_28_0:killTween()

	if arg_28_2 then
		arg_28_0._tweenId = ZProj.TweenHelper.DOTweenFloat(arg_28_0._curRootLocalPosX, arg_28_1.x, VersionActivity2_9DungeonEnum.TWEEN_TIME, arg_28_0._tweenFocusEpisodeCb, arg_28_0._tweenFocusEpisodeDone, arg_28_0, nil, EaseType.Linear)
	else
		arg_28_0:_tweenFocusEpisodeCb(arg_28_1.x)
		TaskDispatcher.cancelTask(arg_28_0._tweenFocusEpisodeDone, arg_28_0)
		TaskDispatcher.runDelay(arg_28_0._tweenFocusEpisodeDone, arg_28_0, 0.1)
	end
end

function var_0_0._getRootLocalPos4Focus(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0._episodeNodeList[arg_29_1]

	if not var_29_0 then
		return
	end

	local var_29_1, var_29_2, var_29_3 = var_29_0:getNodeLocalPos()

	return (arg_29_0:_rootLocalPosX2TargetFocusRootLocalPos(var_29_1, var_29_2, var_29_3))
end

function var_0_0._rootLocalPosX2TargetFocusRootLocalPos(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = CameraMgr.instance:getUICamera()
	local var_30_1 = arg_30_0._maxRootLocalPosX - arg_30_1
	local var_30_2, var_30_3, var_30_4 = arg_30_0:_getRootLocalPosXYZ(var_30_1)
	local var_30_5, var_30_6, var_30_7 = transformhelper.getPos(arg_30_0._sceneTrans)
	local var_30_8 = var_30_5 + var_30_2
	local var_30_9 = var_30_6 + var_30_3
	local var_30_10 = var_30_7 + var_30_4
	local var_30_11 = var_30_8 + arg_30_1
	local var_30_12 = var_30_9 + arg_30_2
	local var_30_13 = var_30_10 + arg_30_3
	local var_30_14 = recthelper.worldPosToScreenPoint(var_30_0, var_30_11, var_30_12, var_30_13)
	local var_30_15, var_30_16 = recthelper.worldPosToScreenPoint(var_30_0, var_30_8, var_30_9, var_30_10)
	local var_30_17 = var_30_15 + (UnityEngine.Screen.width / VersionActivity2_9DungeonEnum.MapFocusScale - var_30_14)

	arg_30_0._tempVector2:Set(var_30_17, var_30_16)

	local var_30_18, var_30_19, var_30_20 = recthelper.screenPosToWorldPos3(arg_30_0._tempVector2, var_30_0, arg_30_0._sceneTrans.position)

	arg_30_0._tempVector3:Set(var_30_18, var_30_19, var_30_20)

	return (arg_30_0._sceneTrans:InverseTransformPoint(arg_30_0._tempVector3))
end

function var_0_0._tweenFocusEpisodeCb(arg_31_0, arg_31_1)
	local var_31_0, var_31_1, var_31_2 = arg_31_0:_getRootLocalPosXYZ(arg_31_1)

	arg_31_0:_updateRootPosition(var_31_0, var_31_1, var_31_2)
end

function var_0_0._tweenFocusEpisodeDone(arg_32_0)
	arg_32_0:_brocastAllNodePos()
	arg_32_0:_updateElementArrow()
end

function var_0_0.focusElementByCo(arg_33_0, arg_33_1)
	if not arg_33_0.loadedDone then
		return
	end

	local var_33_0 = string.splitToNumber(arg_33_1.pos, "#")
	local var_33_1 = arg_33_0:_rootLocalPosX2TargetFocusRootLocalPos(var_33_0[1], var_33_0[2], var_33_0[3])

	arg_33_0:_tweenMap2TargetPos(var_33_1, true)
end

function var_0_0.killTween(arg_34_0)
	var_0_0.super.killTween(arg_34_0)
	arg_34_0:_killMapVisibleTween()
	arg_34_0:_killMapFocusTween()
	TaskDispatcher.cancelTask(arg_34_0._tweenFocusEpisodeDone, arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0._simulateEndDragTween, arg_34_0)
end

function var_0_0._killMapVisibleTween(arg_35_0)
	if arg_35_0._mapTweenId then
		ZProj.TweenHelper.KillById(arg_35_0._mapTweenId)

		arg_35_0._mapTweenId = nil
	end
end

function var_0_0._killMapFocusTween(arg_36_0)
	if arg_36_0._tweenId then
		ZProj.TweenHelper.KillById(arg_36_0._tweenId)

		arg_36_0._tweenId = nil
	end
end

function var_0_0.onClose(arg_37_0)
	var_0_0.super.onClose(arg_37_0)

	arg_37_0.loadedDone = false
end

function var_0_0.onCloseFinish(arg_38_0)
	var_0_0.super.onCloseFinish(arg_38_0)
	transformhelper.setPosXY(arg_38_0._sceneRoot.transform, 100000, 0, 0)
end

function var_0_0.onDestroyView(arg_39_0)
	var_0_0.super.onDestroyView(arg_39_0)

	if arg_39_0._bgVideoComp then
		arg_39_0._bgVideoComp:destroy()

		arg_39_0._bgVideoComp = nil
	end
end

return var_0_0
