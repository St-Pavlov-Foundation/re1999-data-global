module("modules.logic.versionactivity3_1.dungeon.view.map.scene.VersionActivity3_1DungeonMapScene", package.seeall)

local var_0_0 = class("VersionActivity3_1DungeonMapScene", VersionActivityFixedDungeonMapScene)

function var_0_0._initScene(arg_1_0)
	local var_1_0 = gohelper.findChild(arg_1_0._sceneGo, "root/size")
	local var_1_1 = gohelper.findChild(arg_1_0._sceneGo, "root/BackGround")

	if var_1_0 then
		var_0_0.super._initScene(arg_1_0)
	else
		arg_1_0._mapMinX = nil
		arg_1_0._mapMaxX = nil
		arg_1_0._mapMinY = nil
		arg_1_0._mapMaxY = nil
	end

	if var_1_1 then
		arg_1_0._bgAnim = var_1_1:GetComponent(typeof(UnityEngine.Animator))
	end
end

function var_0_0._playSceneAnim(arg_2_0, arg_2_1)
	if string.nilorempty(arg_2_1) or not arg_2_0._sceneGo then
		return
	end

	arg_2_0._sceneAnim = arg_2_0._sceneGo:GetComponent(typeof(UnityEngine.Animator))

	if not arg_2_0._sceneAnim then
		return
	end

	arg_2_0._sceneAnim:Play(arg_2_1, 0, 0)
end

function var_0_0.refreshMap(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0._sceneAnimName = nil

	if arg_3_3 then
		if arg_3_0._lastEpisodeId and arg_3_0.activityDungeonMo.episodeId ~= arg_3_0._lastEpisodeId then
			local var_3_0 = arg_3_0.activityDungeonMo.episodeId

			if var_3_0 > arg_3_0._lastEpisodeId then
				arg_3_0._sceneAnimName = VersionActivity3_1DungeonEnum.LevelAnim.left_close
			elseif var_3_0 < arg_3_0._lastEpisodeId then
				arg_3_0._sceneAnimName = VersionActivity3_1DungeonEnum.LevelAnim.right_close
			end
		end

		if not string.nilorempty(arg_3_0._sceneAnimName) then
			arg_3_0:_playSceneAnim(arg_3_0._sceneAnimName)
		end
	end

	arg_3_0._lastEpisodeId = arg_3_0.activityDungeonMo.episodeId

	var_0_0.super.refreshMap(arg_3_0, arg_3_1, arg_3_2)
end

function var_0_0._loadSceneFinish(arg_4_0)
	arg_4_0.loadedDone = true

	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivity3_1DungeonEvent.V3a1SceneLoadSceneFinish)

	local var_4_0 = arg_4_0._sceneUrl
	local var_4_1 = arg_4_0._mapLoader:getAssetItem(var_4_0):GetResource(var_4_0)

	arg_4_0._sceneGo = gohelper.clone(var_4_1, arg_4_0._sceneRoot, arg_4_0._mapCfg.id)
	arg_4_0._sceneTrans = arg_4_0._sceneGo.transform

	gohelper.setActive(arg_4_0._sceneGo, string.nilorempty(arg_4_0._sceneAnimName))
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnLoadSceneFinish, {
		mapConfig = arg_4_0._mapCfg,
		mapSceneGo = arg_4_0._sceneGo
	})
	arg_4_0:_initScene()
	arg_4_0:_setMapPos()
	arg_4_0:_addMapLight()
	arg_4_0:_initElements()
	arg_4_0:_addMapAudio()
end

function var_0_0.directSetScenePos(arg_5_0, arg_5_1)
	var_0_0.super.directSetScenePos(arg_5_0, arg_5_1)
	TaskDispatcher.cancelTask(arg_5_0._endSceneAnim, arg_5_0)

	if string.nilorempty(arg_5_0._sceneAnimName) then
		arg_5_0:_endSceneAnimCB()
	else
		TaskDispatcher.runDelay(arg_5_0._endSceneAnim, arg_5_0, VersionActivity3_1DungeonEnum.LevelAnimDelayTime)
	end
end

function var_0_0._endSceneAnim(arg_6_0)
	arg_6_0:_endSceneAnimCB()

	local var_6_0

	if not string.nilorempty(arg_6_0._sceneAnimName) then
		if arg_6_0._sceneAnimName == VersionActivity3_1DungeonEnum.LevelAnim.right_close then
			var_6_0 = VersionActivity3_1DungeonEnum.LevelAnim.right_open
		elseif arg_6_0._sceneAnimName == VersionActivity3_1DungeonEnum.LevelAnim.left_close then
			var_6_0 = VersionActivity3_1DungeonEnum.LevelAnim.left_open
		end
	end

	if not string.nilorempty(var_6_0) then
		arg_6_0:_playSceneAnim(var_6_0)
	end

	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivity3_1DungeonEvent.V3a1SceneAnimFinish)

	arg_6_0._sceneAnimName = nil
end

function var_0_0._endSceneAnimCB(arg_7_0)
	arg_7_0:disposeOldMap()
	gohelper.setActive(arg_7_0._sceneGo, true)

	if arg_7_0._bgAnim then
		arg_7_0._bgAnim.enabled = arg_7_0._mapCfg.playEffect == 1
	end
end

function var_0_0.onModeChange(arg_8_0)
	var_0_0.super.onModeChange(arg_8_0)
end

function var_0_0.onActivityDungeonMoChange(arg_9_0)
	local var_9_0 = VersionActivityFixedDungeonModel.instance:getMapNeedTweenState()

	arg_9_0:refreshMap(var_9_0, nil, true)
end

function var_0_0._onDragBegin(arg_10_0, arg_10_1, arg_10_2)
	return
end

function var_0_0._onDrag(arg_11_0, arg_11_1, arg_11_2)
	return
end

function var_0_0._onDragEnd(arg_12_0, arg_12_1, arg_12_2)
	return
end

function var_0_0.onClose(arg_13_0)
	var_0_0.super.onClose(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._endSceneAnim, arg_13_0)
end

return var_0_0
