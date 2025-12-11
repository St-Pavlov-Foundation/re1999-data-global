module("modules.logic.versionactivity3_1.dungeon.view.map.VersionActivity3_1DungeonMapView", package.seeall)

local var_0_0 = class("VersionActivity3_1DungeonMapView", VersionActivityFixedDungeonMapView)

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)

	arg_1_0._goswitch = gohelper.findChild(arg_1_0.viewGO, "#go_switch")
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnActivityDungeonMoChange, arg_2_0.onActivityDungeonMoChange, arg_2_0)
	arg_2_0:addEventCb(VersionActivityFixedDungeonController.instance, VersionActivity3_1DungeonEvent.V3a1SceneAnimFinish, arg_2_0._V3a1SceneAnimFinish, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnActivityDungeonMoChange, arg_3_0.onActivityDungeonMoChange, arg_3_0)
	arg_3_0:removeEventCb(VersionActivityFixedDungeonController.instance, VersionActivity3_1DungeonEvent.V3a1SceneAnimFinish, arg_3_0._V3a1SceneAnimFinish, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	var_0_0.super.onOpen(arg_4_0)

	arg_4_0._lastEpisodeId = arg_4_0.activityDungeonMo.episodeId
end

function var_0_0.onModeChange(arg_5_0)
	arg_5_0._lastEpisodeId = arg_5_0.activityDungeonMo.episodeId

	var_0_0.super.onModeChange(arg_5_0)
end

function var_0_0.onActivityDungeonMoChange(arg_6_0)
	arg_6_0._sceneAnimName = nil

	if arg_6_0._lastEpisodeId and arg_6_0.activityDungeonMo.episodeId ~= arg_6_0._lastEpisodeId then
		local var_6_0 = arg_6_0.activityDungeonMo.episodeId

		if var_6_0 > arg_6_0._lastEpisodeId then
			arg_6_0._sceneAnimName = VersionActivity3_1DungeonEnum.LevelAnim.left_close
		elseif var_6_0 < arg_6_0._lastEpisodeId then
			arg_6_0._sceneAnimName = VersionActivity3_1DungeonEnum.LevelAnim.right_close
		end
	end

	if not string.nilorempty(arg_6_0._sceneAnimName) then
		arg_6_0:_playSceneAnim(arg_6_0._sceneAnimName)
	end

	arg_6_0._lastEpisodeId = arg_6_0.activityDungeonMo.episodeId
end

function var_0_0._V3a1SceneAnimFinish(arg_7_0)
	local var_7_0

	if not string.nilorempty(arg_7_0._sceneAnimName) then
		if arg_7_0._sceneAnimName == VersionActivity3_1DungeonEnum.LevelAnim.right_close then
			var_7_0 = VersionActivity3_1DungeonEnum.LevelAnim.right_open
		elseif arg_7_0._sceneAnimName == VersionActivity3_1DungeonEnum.LevelAnim.left_close then
			var_7_0 = VersionActivity3_1DungeonEnum.LevelAnim.left_open
		end
	end

	if not string.nilorempty(var_7_0) then
		arg_7_0:_playSceneAnim(var_7_0, arg_7_0._hideSceneAnim)
	end

	arg_7_0._sceneAnimName = nil
end

function var_0_0._playLoopAnim(arg_8_0)
	arg_8_0:_playSceneAnim(VersionActivity3_1DungeonEnum.LevelAnim.loop)
end

function var_0_0._hideSceneAnim(arg_9_0)
	gohelper.setActive(arg_9_0._goswitch, false)
end

function var_0_0._playSceneAnim(arg_10_0, arg_10_1, arg_10_2)
	if string.nilorempty(arg_10_1) or not arg_10_0._goswitch then
		return
	end

	arg_10_0._sceneAnim = SLFramework.AnimatorPlayer.Get(arg_10_0._goswitch.gameObject)

	if not arg_10_0._sceneAnim then
		return
	end

	gohelper.setActive(arg_10_0._goswitch, true)
	arg_10_0._sceneAnim:Play(arg_10_1, arg_10_2, arg_10_0)
end

return var_0_0
