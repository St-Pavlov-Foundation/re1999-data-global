module("modules.logic.fight.system.work.FightWorkEndResultViewShow", package.seeall)

slot0 = class("FightWorkEndResultViewShow", BaseWork)

function slot0.onStart(slot0)
	FightController.instance:checkFightQuitTipViewClose()

	slot1 = DungeonModel.instance.curSendEpisodeId
	slot3 = false
	slot4 = nil

	if DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId) then
		slot3 = slot2.type == DungeonEnum.EpisodeType.Sp
		slot4 = DungeonConfig.instance:getChapterCO(slot2.chapterId)
	end

	if slot1 and DungeonConfig.instance:getElementEpisode(slot1) and not slot3 then
		slot0:_done()

		return
	end

	if slot0:_needHideEntity() then
		FightHelper.hideAllEntity()
		FightMsgMgr.sendMsg(FightMsgId.ReleaseAllEntrustedEntity)
		FightController.instance:dispatchEvent(FightEvent.ReleaseAllEntrustedEntity)
	end

	slot7 = FightModel.instance:getRecordMO().fightResult

	if FightModel.instance:isShowSettlement() == false then
		slot0:_done()
	elseif slot7 == FightEnum.FightResult.Succ then
		slot0:showSuccView()
	elseif slot7 == FightEnum.FightResult.Fail or slot7 == FightEnum.FightResult.Abort or slot6.fightResult == FightEnum.FightResult.OutOfRoundFail then
		if slot2 and slot2.type == DungeonEnum.EpisodeType.RoleStoryChallenge and slot7 ~= FightEnum.FightResult.Abort then
			slot0:showSuccView()
		elseif slot3 and slot7 ~= FightEnum.FightResult.Abort then
			ViewMgr.instance:openView(ViewName.FightFailTipsView, {
				show_scene_dissolve_effect = true,
				fight_result = slot7
			})
		elseif slot2 and slot2.type == DungeonEnum.EpisodeType.TowerLimited then
			slot0:showSuccView()
		else
			if slot7 == FightEnum.FightResult.OutOfRoundFail then
				if BossRushController.instance:isInBossRushDungeon() then
					FightController.instance:registerCallback(FightEvent.OnResultViewClose, slot0._done, slot0)
					BossRushController.instance:openResultPanel()

					return
				end

				ViewMgr.instance:openView(ViewName.FightFailTipsView, {
					fight_result = slot7,
					callback = function ()
						uv0:showFailView()
					end
				})

				return
			end

			slot0:showFailView()
		end
	end
end

function slot0.showSuccView(slot0)
	FightAudioMgr.instance:setSwitch(FightEnum.AudioSwitch.Victory)
	PopupController.instance:setPause("fightsuccess", true)
	FightController.instance:registerCallback(FightEvent.OnResultViewClose, slot0._done, slot0)
	slot0:_showSuccView()
end

function slot0._showSuccView(slot0)
	if DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId) then
		if slot1.type == DungeonEnum.EpisodeType.Season then
			Activity104Controller.instance:openSeasonSettlementView()

			return
		elseif slot1.type == DungeonEnum.EpisodeType.SeasonRetail or slot1.type == DungeonEnum.EpisodeType.SeasonTrial then
			PopupController.instance:setPause("fightsuccess", false)
			Activity104Controller.instance:openSeasonFightSuccView()

			return
		elseif ToughBattleConfig.instance:isActStage2EpisodeId(DungeonModel.instance.curSendEpisodeId) or ToughBattleConfig.instance:isStage1EpisodeId(DungeonModel.instance.curSendEpisodeId) then
			ViewMgr.instance:openView(ViewName.ToughBattleFightSuccView)

			return
		elseif slot1.type == DungeonEnum.EpisodeType.SeasonSpecial then
			Activity104Controller.instance:openSeasonSettlementView()

			return
		elseif slot1.type == DungeonEnum.EpisodeType.Season123 then
			Season123Controller.instance:openSeason123SettlementView()

			return
		elseif slot1.type == DungeonEnum.EpisodeType.Season123Retail or slot1.type == DungeonEnum.EpisodeType.Season123Trial then
			PopupController.instance:setPause("fightsuccess", false)
			Season123Controller.instance:openSeasonFightSuccView()

			return
		elseif slot1.type == DungeonEnum.EpisodeType.RoleStoryChallenge then
			ViewMgr.instance:openView(ViewName.RoleStoryFightSuccView)

			return
		elseif slot1.type == DungeonEnum.EpisodeType.Act1_6DungeonBoss then
			ViewMgr.instance:openView(ViewName.VersionActivity1_6BossFightSuccView)

			return
		elseif slot1.type == DungeonEnum.EpisodeType.Cachot then
			if V1a6_CachotModel.instance:getRogueEndingInfo() then
				slot0:_done()

				return
			end
		elseif slot1.type == DungeonEnum.EpisodeType.Rouge then
			ViewMgr.instance:openView(ViewName.RougeFightSuccessView)

			return
		elseif slot1.type == DungeonEnum.EpisodeType.Season166Base or slot1.type == DungeonEnum.EpisodeType.Season166Train then
			Season166Controller.instance:openResultPanel()

			return
		elseif slot1.type == DungeonEnum.EpisodeType.TowerBoss then
			ViewMgr.instance:openView(ViewName.TowerBossResultView)

			return
		elseif slot1.type == DungeonEnum.EpisodeType.TowerPermanent or slot1.type == DungeonEnum.EpisodeType.TowerLimited then
			ViewMgr.instance:openView(ViewName.TowerPermanentResultView)

			return
		elseif slot1.type == DungeonEnum.EpisodeType.Act183 then
			ViewMgr.instance:openView(ViewName.Act183FightSuccView)

			return
		end
	end

	if BossRushController.instance:isInBossRushDungeon() then
		BossRushController.instance:openResultPanel()

		return
	end

	ViewMgr.instance:openView(ViewName.FightSuccView)
end

function slot0.showFailView(slot0)
	FightAudioMgr.instance:setSwitch(FightEnum.AudioSwitch.Losing)
	FightController.instance:registerCallback(FightEvent.OnResultViewClose, slot0._done, slot0)

	if DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId) then
		if Activity104Model.instance:isSeasonEpisodeType(slot1.type) then
			Activity104Controller.instance:openSeasonFightFailView()

			return
		elseif Season123Controller.isSeason123EpisodeType(slot1.type) then
			Season123Controller.instance:openSeasonFightFailView()

			return
		elseif slot1.type == DungeonEnum.EpisodeType.Act1_6DungeonBoss then
			ViewMgr.instance:openView(ViewName.VersionActivity1_6BossFightSuccView)

			return
		elseif slot1.type == DungeonEnum.EpisodeType.Season166Base then
			Season166Controller.instance:openResultPanel()

			return
		end
	end

	if BossRushController.instance:isInBossRushDungeon() then
		BossRushController.instance:openResultPanel()

		return
	end

	ViewMgr.instance:openView(ViewName.FightFailView)
end

function slot0._needHideEntity(slot0)
	if DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId) and slot1.type == DungeonEnum.EpisodeType.Season then
		return false
	end

	return true
end

function slot0._done(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnResultViewClose, slot0._done, slot0)
	PopupController.instance:setPause("fightsuccess", false)
end

return slot0
