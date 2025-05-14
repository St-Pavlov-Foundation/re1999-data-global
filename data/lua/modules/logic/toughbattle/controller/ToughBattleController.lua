module("modules.logic.toughbattle.controller.ToughBattleController", package.seeall)

local var_0_0 = class("ToughBattleController", BaseController)

function var_0_0.reInit(arg_1_0)
	arg_1_0._delayOpenViewAndParam = nil

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_1_0.onOpenDungeonMapView, arg_1_0)
end

function var_0_0.addConstEvents(arg_2_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, arg_2_0._getAct158Info, arg_2_0)
end

function var_0_0._getAct158Info(arg_3_0, arg_3_1)
	if not arg_3_1 or arg_3_1 == VersionActivity1_9Enum.ActivityId.ToughBattle then
		if ActivityHelper.getActivityStatus(VersionActivity1_9Enum.ActivityId.ToughBattle) == ActivityEnum.ActivityStatus.Normal then
			Activity158Rpc.instance:sendGet158InfosRequest(VersionActivity1_9Enum.ActivityId.ToughBattle, arg_3_0._onGetActInfo, arg_3_0)
		else
			ToughBattleModel.instance:setActOffLine()
			arg_3_0:dispatchEvent(ToughBattleEvent.ToughBattleActChange)
		end
	end
end

function var_0_0._onGetActInfo(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_2 == 0 then
		-- block empty
	end
end

function var_0_0.checkIsToughBattle(arg_5_0)
	local var_5_0 = DungeonModel.instance.curSendChapterId
	local var_5_1 = DungeonConfig.instance:getChapterCO(var_5_0)

	if not var_5_1 or var_5_1.type ~= DungeonEnum.ChapterType.ToughBattle then
		return false
	end

	return true
end

function var_0_0.onRecvToughInfo(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_2 == 0 then
		arg_6_0:_enterToughBattle()
	else
		MainController.instance:enterMainScene(arg_6_0._isFromGroupView, false)
	end
end

function var_0_0.enterToughBattle(arg_7_0, arg_7_1)
	local var_7_0 = DungeonModel.instance.curSendEpisodeId

	if not ToughBattleConfig.instance:getCoByEpisodeId(var_7_0) then
		logError("攻坚战配置不存在" .. tostring(var_7_0))
		MainController.instance:enterMainScene(arg_7_1, false)

		return
	end

	arg_7_0._isFromGroupView = arg_7_1
	arg_7_0._preEpisodeId = var_7_0
	arg_7_0._isFightSuccess = nil

	if not arg_7_1 then
		local var_7_1 = FightModel.instance:getRecordMO()

		if var_7_1 and var_7_1.fightResult == FightEnum.FightResult.Succ then
			arg_7_0._isFightSuccess = true
		end
	end

	DungeonModel.instance:resetSendChapterEpisodeId()

	if ToughBattleConfig.instance:isActEpisodeId(var_7_0) then
		Activity158Rpc.instance:sendGet158InfosRequest(VersionActivity1_9Enum.ActivityId.ToughBattle, arg_7_0.onRecvToughInfo, arg_7_0)
	else
		SiegeBattleRpc.instance:sendGetSiegeBattleInfoRequest(arg_7_0.onRecvToughInfo, arg_7_0)
	end
end

function var_0_0._enterToughBattle(arg_8_0)
	local var_8_0 = arg_8_0._preEpisodeId
	local var_8_1 = arg_8_0._isFightSuccess
	local var_8_2 = ToughBattleConfig.instance:getCoByEpisodeId(var_8_0)
	local var_8_3 = ToughBattleConfig.instance:isActEpisodeId(var_8_0)
	local var_8_4

	if var_8_3 then
		var_8_4 = ToughBattleModel.instance:getActInfo()
	else
		var_8_4 = ToughBattleModel.instance:getStoryInfo()
	end

	MainController.instance:enterMainScene(arg_8_0._isFromGroupView, false)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		local var_9_0 = {
			mode = var_8_3 and ToughBattleEnum.Mode.Act or ToughBattleEnum.Mode.Story,
			lastFightSuccIndex = var_8_1 and var_8_2.sort
		}
		local var_9_1 = var_8_3 and ViewName.ToughBattleActEnterView or ViewName.ToughBattleEnterView
		local var_9_2 = var_8_3 and ViewName.ToughBattleActMapView or ViewName.ToughBattleMapView

		if var_8_3 then
			JumpController.instance:jumpByParam("4#10728#1")
		else
			JumpController.instance:jumpByParam("3#107")
		end

		arg_8_0._delayOpenViewAndParam = nil

		if #var_8_4.passChallengeIds == 4 and var_8_1 or not var_8_4.openChallenge then
			if var_8_3 then
				GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, var_9_1)

				if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
					ViewMgr.instance:openView(var_9_1, var_9_0)
				else
					arg_8_0._delayOpenViewAndParam = {
						var_9_1,
						var_9_0
					}
				end
			end
		else
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, var_9_2)

			if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
				ViewMgr.instance:openView(var_9_2, var_9_0)
			else
				arg_8_0._delayOpenViewAndParam = {
					var_9_2,
					var_9_0
				}
			end
		end

		if arg_8_0._delayOpenViewAndParam then
			ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_8_0.onOpenDungeonMapView, arg_8_0)
		end
	end)
end

function var_0_0.jumpToActView(arg_10_0)
	local var_10_0 = ToughBattleModel.instance:getActInfo()

	if not var_10_0 then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
		if not var_10_0.openChallenge then
			ViewMgr.instance:openView(ViewName.ToughBattleActEnterView, {
				mode = ToughBattleEnum.Mode.Act
			})
		else
			ViewMgr.instance:openView(ViewName.ToughBattleActMapView, {
				mode = ToughBattleEnum.Mode.Act
			})
		end
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_10_0.onOpenDungeonMapView, arg_10_0)

		if not var_10_0.openChallenge then
			arg_10_0._delayOpenViewAndParam = {
				ViewName.ToughBattleActEnterView,
				{
					mode = ToughBattleEnum.Mode.Act
				}
			}
		else
			arg_10_0._delayOpenViewAndParam = {
				ViewName.ToughBattleActMapView,
				{
					mode = ToughBattleEnum.Mode.Act
				}
			}
		end
	end
end

function var_0_0.onOpenDungeonMapView(arg_11_0, arg_11_1)
	if arg_11_1 == ViewName.DungeonMapView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_11_0.onOpenDungeonMapView, arg_11_0)

		if arg_11_0._delayOpenViewAndParam then
			ViewMgr.instance:openView(unpack(arg_11_0._delayOpenViewAndParam))

			arg_11_0._delayOpenViewAndParam = nil
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
