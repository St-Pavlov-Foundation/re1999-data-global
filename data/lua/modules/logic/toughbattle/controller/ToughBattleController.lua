module("modules.logic.toughbattle.controller.ToughBattleController", package.seeall)

slot0 = class("ToughBattleController", BaseController)

function slot0.reInit(slot0)
	slot0._delayOpenViewAndParam = nil

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, slot0.onOpenDungeonMapView, slot0)
end

function slot0.addConstEvents(slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, slot0._getAct158Info, slot0)
end

function slot0._getAct158Info(slot0, slot1)
	if not slot1 or slot1 == VersionActivity1_9Enum.ActivityId.ToughBattle then
		if ActivityHelper.getActivityStatus(VersionActivity1_9Enum.ActivityId.ToughBattle) == ActivityEnum.ActivityStatus.Normal then
			Activity158Rpc.instance:sendGet158InfosRequest(VersionActivity1_9Enum.ActivityId.ToughBattle, slot0._onGetActInfo, slot0)
		else
			ToughBattleModel.instance:setActOffLine()
			slot0:dispatchEvent(ToughBattleEvent.ToughBattleActChange)
		end
	end
end

function slot0._onGetActInfo(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		-- Nothing
	end
end

function slot0.checkIsToughBattle(slot0)
	if not DungeonConfig.instance:getChapterCO(DungeonModel.instance.curSendChapterId) or slot2.type ~= DungeonEnum.ChapterType.ToughBattle then
		return false
	end

	return true
end

function slot0.onRecvToughInfo(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		slot0:_enterToughBattle()
	else
		MainController.instance:enterMainScene(slot0._isFromGroupView, false)
	end
end

function slot0.enterToughBattle(slot0, slot1)
	if not ToughBattleConfig.instance:getCoByEpisodeId(DungeonModel.instance.curSendEpisodeId) then
		logError("攻坚战配置不存在" .. tostring(slot2))
		MainController.instance:enterMainScene(slot1, false)

		return
	end

	slot0._isFromGroupView = slot1
	slot0._preEpisodeId = slot2
	slot0._isFightSuccess = nil

	if not slot1 and FightModel.instance:getRecordMO() and slot4.fightResult == FightEnum.FightResult.Succ then
		slot0._isFightSuccess = true
	end

	DungeonModel.instance:resetSendChapterEpisodeId()

	if ToughBattleConfig.instance:isActEpisodeId(slot2) then
		Activity158Rpc.instance:sendGet158InfosRequest(VersionActivity1_9Enum.ActivityId.ToughBattle, slot0.onRecvToughInfo, slot0)
	else
		SiegeBattleRpc.instance:sendGetSiegeBattleInfoRequest(slot0.onRecvToughInfo, slot0)
	end
end

function slot0._enterToughBattle(slot0)
	slot1 = slot0._preEpisodeId
	slot2 = slot0._isFightSuccess
	slot3 = ToughBattleConfig.instance:getCoByEpisodeId(slot1)
	slot5 = nil
	slot5 = (not ToughBattleConfig.instance:isActEpisodeId(slot1) or ToughBattleModel.instance:getActInfo()) and ToughBattleModel.instance:getStoryInfo()

	MainController.instance:enterMainScene(slot0._isFromGroupView, false)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		slot0 = {
			mode = uv0 and ToughBattleEnum.Mode.Act or ToughBattleEnum.Mode.Story,
			lastFightSuccIndex = uv1 and uv2.sort
		}
		slot1 = uv0 and ViewName.ToughBattleActEnterView or ViewName.ToughBattleEnterView
		slot2 = uv0 and ViewName.ToughBattleActMapView or ViewName.ToughBattleMapView

		if uv0 then
			JumpController.instance:jumpByParam("4#10728#1")
		else
			JumpController.instance:jumpByParam("3#107")
		end

		uv3._delayOpenViewAndParam = nil

		if #uv4.passChallengeIds == 4 and uv1 or not uv4.openChallenge then
			if uv0 then
				GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, slot1)

				if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
					ViewMgr.instance:openView(slot1, slot0)
				else
					uv3._delayOpenViewAndParam = {
						slot1,
						slot0
					}
				end
			end
		else
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, slot2)

			if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
				ViewMgr.instance:openView(slot2, slot0)
			else
				uv3._delayOpenViewAndParam = {
					slot2,
					slot0
				}
			end
		end

		if uv3._delayOpenViewAndParam then
			ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, uv3.onOpenDungeonMapView, uv3)
		end
	end)
end

function slot0.jumpToActView(slot0)
	if not ToughBattleModel.instance:getActInfo() then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
		if not slot1.openChallenge then
			ViewMgr.instance:openView(ViewName.ToughBattleActEnterView, {
				mode = ToughBattleEnum.Mode.Act
			})
		else
			ViewMgr.instance:openView(ViewName.ToughBattleActMapView, {
				mode = ToughBattleEnum.Mode.Act
			})
		end
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0.onOpenDungeonMapView, slot0)

		if not slot1.openChallenge then
			slot0._delayOpenViewAndParam = {
				ViewName.ToughBattleActEnterView,
				{
					mode = ToughBattleEnum.Mode.Act
				}
			}
		else
			slot0._delayOpenViewAndParam = {
				ViewName.ToughBattleActMapView,
				{
					mode = ToughBattleEnum.Mode.Act
				}
			}
		end
	end
end

function slot0.onOpenDungeonMapView(slot0, slot1)
	if slot1 == ViewName.DungeonMapView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, slot0.onOpenDungeonMapView, slot0)

		if slot0._delayOpenViewAndParam then
			ViewMgr.instance:openView(unpack(slot0._delayOpenViewAndParam))

			slot0._delayOpenViewAndParam = nil
		end
	end
end

slot0.instance = slot0.New()

return slot0
