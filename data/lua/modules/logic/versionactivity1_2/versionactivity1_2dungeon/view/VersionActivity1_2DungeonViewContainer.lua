module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity1_2DungeonViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_2DungeonViewContainer", BaseViewContainer)

function var_0_0.openInternal(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:_processParam(arg_1_1)

	arg_1_0._isOpenImmediate = arg_1_2

	arg_1_0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceiveGet121InfosReply, arg_1_0._onReceiveGet121InfosReply, arg_1_0)
	Activity116Rpc.instance:sendGet116InfosRequest()
	Activity121Rpc.instance:sendGet121InfosRequest()
end

function var_0_0._processParam(arg_2_0, arg_2_1)
	if not arg_2_1.chapterId then
		arg_2_1.chapterId = VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1
	end

	if not arg_2_1.episodeId then
		arg_2_1.episodeId = VersionActivity1_2DungeonController.instance:_getDefaultFocusEpisode(arg_2_1.chapterId)
	end

	arg_2_1.chapterId = DungeonConfig.instance:getEpisodeCO(arg_2_1.episodeId).chapterId
	arg_2_0.viewParam = arg_2_1
end

function var_0_0._onReceiveGet121InfosReply(arg_3_0, arg_3_1)
	arg_3_0:removeEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceiveGet121InfosReply, arg_3_0._onReceiveGet121InfosReply, arg_3_0)

	if arg_3_1 == 0 then
		var_0_0.super.openInternal(arg_3_0, arg_3_0.viewParam, arg_3_0._isOpenImmediate)
	else
		ViewMgr.instance:closeView(ViewName.VersionActivity1_2DungeonView)
	end
end

function var_0_0.onContainerUpdateParam(arg_4_0)
	arg_4_0.mapScene:setVisible(true)
	arg_4_0:_processParam(arg_4_0.viewParam)
	arg_4_0.mapEpisodeView:reopenViewParamPrecessed()
	arg_4_0.mapScene:reopenViewParamPrecessed()
end

function var_0_0.buildViews(arg_5_0)
	local var_5_0 = {}

	arg_5_0.mapScene = VersionActivity1_2DungeonMapScene.New()
	arg_5_0.mapView = VersionActivity1_2DungeonView.New()
	arg_5_0.mapEpisodeView = VersionActivity1_2DungeonMapEpisodeView.New()
	arg_5_0.mapSceneElement = VersionActivity1_2DungeonMapSceneElement.New()

	table.insert(var_5_0, arg_5_0.mapView)
	table.insert(var_5_0, arg_5_0.mapSceneElement)
	table.insert(var_5_0, arg_5_0.mapScene)
	table.insert(var_5_0, arg_5_0.mapEpisodeView)
	table.insert(var_5_0, DungeonMapElementReward.New())
	table.insert(var_5_0, TabViewGroup.New(1, "top_left"))

	return var_5_0
end

function var_0_0.buildTabViews(arg_6_0, arg_6_1)
	if arg_6_1 == 1 then
		arg_6_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		arg_6_0.navigateView:setOverrideClose(arg_6_0.overClose, arg_6_0)

		return {
			arg_6_0.navigateView
		}
	end
end

function var_0_0.onContainerInit(arg_7_0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_2Enum.ActivityId.Dungeon)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_2Enum.ActivityId.Dungeon
	})
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
end

function var_0_0.overClose(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	AudioEffectMgr.instance:stopAudio(AudioEnum.Story.Play_Chapter_Start)
	arg_8_0:closeThis()
end

function var_0_0.setVisibleInternal(arg_9_0, arg_9_1)
	var_0_0.super.setVisibleInternal(arg_9_0, arg_9_1)

	if arg_9_0.mapScene then
		arg_9_0.mapScene:setVisible(arg_9_1)
	end
end

return var_0_0
