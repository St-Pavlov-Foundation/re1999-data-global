module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity1_2DungeonViewContainer", package.seeall)

slot0 = class("VersionActivity1_2DungeonViewContainer", BaseViewContainer)

function slot0.openInternal(slot0, slot1, slot2)
	slot0:_processParam(slot1)

	slot0._isOpenImmediate = slot2

	slot0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceiveGet121InfosReply, slot0._onReceiveGet121InfosReply, slot0)
	Activity116Rpc.instance:sendGet116InfosRequest()
	Activity121Rpc.instance:sendGet121InfosRequest()
end

function slot0._processParam(slot0, slot1)
	if not slot1.chapterId then
		slot1.chapterId = VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1
	end

	if not slot1.episodeId then
		slot1.episodeId = VersionActivity1_2DungeonController.instance:_getDefaultFocusEpisode(slot1.chapterId)
	end

	slot1.chapterId = DungeonConfig.instance:getEpisodeCO(slot1.episodeId).chapterId
	slot0.viewParam = slot1
end

function slot0._onReceiveGet121InfosReply(slot0, slot1)
	slot0:removeEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceiveGet121InfosReply, slot0._onReceiveGet121InfosReply, slot0)

	if slot1 == 0 then
		uv0.super.openInternal(slot0, slot0.viewParam, slot0._isOpenImmediate)
	else
		ViewMgr.instance:closeView(ViewName.VersionActivity1_2DungeonView)
	end
end

function slot0.onContainerUpdateParam(slot0)
	slot0.mapScene:setVisible(true)
	slot0:_processParam(slot0.viewParam)
	slot0.mapEpisodeView:reopenViewParamPrecessed()
	slot0.mapScene:reopenViewParamPrecessed()
end

function slot0.buildViews(slot0)
	slot1 = {}
	slot0.mapScene = VersionActivity1_2DungeonMapScene.New()
	slot0.mapView = VersionActivity1_2DungeonView.New()
	slot0.mapEpisodeView = VersionActivity1_2DungeonMapEpisodeView.New()
	slot0.mapSceneElement = VersionActivity1_2DungeonMapSceneElement.New()

	table.insert(slot1, slot0.mapView)
	table.insert(slot1, slot0.mapSceneElement)
	table.insert(slot1, slot0.mapScene)
	table.insert(slot1, slot0.mapEpisodeView)
	table.insert(slot1, DungeonMapElementReward.New())
	table.insert(slot1, TabViewGroup.New(1, "top_left"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		slot0.navigateView:setOverrideClose(slot0.overClose, slot0)

		return {
			slot0.navigateView
		}
	end
end

function slot0.onContainerInit(slot0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_2Enum.ActivityId.Dungeon)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_2Enum.ActivityId.Dungeon
	})
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
end

function slot0.overClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	AudioEffectMgr.instance:stopAudio(AudioEnum.Story.Play_Chapter_Start)
	slot0:closeThis()
end

function slot0.setVisibleInternal(slot0, slot1)
	uv0.super.setVisibleInternal(slot0, slot1)

	if slot0.mapScene then
		slot0.mapScene:setVisible(slot1)
	end
end

return slot0
