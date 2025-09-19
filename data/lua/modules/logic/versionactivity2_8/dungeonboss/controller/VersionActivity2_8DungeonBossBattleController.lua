module("modules.logic.versionactivity2_8.dungeonboss.controller.VersionActivity2_8DungeonBossBattleController", package.seeall)

local var_0_0 = class("VersionActivity2_8DungeonBossBattleController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_2_0.onOpenDungeonMapView, arg_2_0)
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.checkIsBossBattle(arg_4_0)
	local var_4_0 = DungeonModel.instance.curSendChapterId
	local var_4_1 = DungeonConfig.instance:getChapterCO(var_4_0)

	return var_4_1 and var_4_1.id == VersionActivity2_8BossEnum.BossActChapterId
end

function var_0_0.enterBossView(arg_5_0, arg_5_1)
	local var_5_0 = DungeonModel.instance.curSendEpisodeId
	local var_5_1 = DungeonModel.instance.curSendChapterId
	local var_5_2 = DungeonConfig.instance:getChapterCO(var_5_1).actId
	local var_5_3 = ActivityHelper.getActivityStatus(var_5_2) == ActivityEnum.ActivityStatus.Normal

	DungeonModel.instance:resetSendChapterEpisodeId()

	arg_5_0._isFromGroupView = arg_5_1

	MainController.instance:enterMainScene(arg_5_0._isFromGroupView, false)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		arg_5_0._delayOpenViewAndParam = nil

		if var_5_3 then
			local var_6_0 = ViewName.VersionActivity2_8BossActEnterView

			arg_5_0._delayOpenViewAndParam = {
				var_6_0,
				{
					episodeId = var_5_0
				}
			}

			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, var_6_0)
		else
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.DungeonMapView)
		end

		if arg_5_0._delayOpenViewAndParam then
			ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_5_0.onOpenDungeonMapView, arg_5_0)
		end

		JumpController.instance:jumpByParam("3#110")
	end)
end

function var_0_0.onOpenDungeonMapView(arg_7_0, arg_7_1)
	if arg_7_1 == ViewName.DungeonMapView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_7_0.onOpenDungeonMapView, arg_7_0)

		if arg_7_0._delayOpenViewAndParam then
			ViewMgr.instance:openView(unpack(arg_7_0._delayOpenViewAndParam))

			arg_7_0._delayOpenViewAndParam = nil
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
