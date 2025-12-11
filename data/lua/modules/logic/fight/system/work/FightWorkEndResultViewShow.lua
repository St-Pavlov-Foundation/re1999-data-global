module("modules.logic.fight.system.work.FightWorkEndResultViewShow", package.seeall)

local var_0_0 = class("FightWorkEndResultViewShow", BaseWork)

function var_0_0.onStart(arg_1_0)
	FightController.instance:checkFightQuitTipViewClose()

	local var_1_0 = DungeonModel.instance.curSendEpisodeId
	local var_1_1 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)
	local var_1_2 = false
	local var_1_3
	local var_1_4 = false

	if var_1_1 then
		var_1_2 = var_1_1.type == DungeonEnum.EpisodeType.Sp
		var_1_4 = var_1_1.type == DungeonEnum.EpisodeType.Assassin2Stealth

		local var_1_5 = var_1_1.chapterId
		local var_1_6 = DungeonConfig.instance:getChapterCO(var_1_5)

		if var_1_5 == DungeonEnum.ChapterId.BossStory then
			VersionActivity2_8BossModel.instance:setFocusElement(true)

			if var_1_0 ~= VersionActivity2_8BossEnum.StoryBossLastEpisode then
				arg_1_0:_done()

				return
			end
		end
	end

	local var_1_7 = var_1_0 and DungeonConfig.instance:getElementEpisode(var_1_0)

	if var_1_4 or var_1_7 and not var_1_2 then
		arg_1_0:_done()

		return
	end

	if arg_1_0:_needHideEntity() then
		FightHelper.hideAllEntity()
		FightMsgMgr.sendMsg(FightMsgId.ReleaseAllEntrustedEntity)
		FightController.instance:dispatchEvent(FightEvent.ReleaseAllEntrustedEntity)
	end

	local var_1_8 = FightModel.instance:getRecordMO()
	local var_1_9 = var_1_8.fightResult
	local var_1_10

	if var_1_1 and var_1_1.type == DungeonEnum.EpisodeType.WeekWalk_2 then
		var_1_10 = WeekWalk_2Model.instance:isWin()

		if var_1_9 == FightEnum.FightResult.Succ then
			var_1_9 = FightEnum.FightResult.Fail
		end
	end

	if FightModel.instance:isShowSettlement() == false then
		arg_1_0:_done()
	elseif var_1_9 == FightEnum.FightResult.Succ then
		arg_1_0:showSuccView()
	elseif var_1_9 == FightEnum.FightResult.Fail or var_1_9 == FightEnum.FightResult.Abort or var_1_8.fightResult == FightEnum.FightResult.OutOfRoundFail then
		if var_1_1 and var_1_1.type == DungeonEnum.EpisodeType.RoleStoryChallenge and var_1_9 ~= FightEnum.FightResult.Abort then
			arg_1_0:showSuccView()
		elseif var_1_2 and var_1_9 ~= FightEnum.FightResult.Abort then
			ViewMgr.instance:openView(ViewName.FightFailTipsView, {
				show_scene_dissolve_effect = true,
				fight_result = var_1_9
			})
		elseif var_1_1 and var_1_1.type == DungeonEnum.EpisodeType.TowerLimited then
			arg_1_0:showSuccView()
		elseif var_1_10 then
			arg_1_0:showSuccView()
		elseif var_1_1 and var_1_1.type == DungeonEnum.EpisodeType.Odyssey then
			local var_1_11 = OdysseyModel.instance:getFightResultInfo()

			if var_1_11 and var_1_11:checkFightTypeIsMyth() and var_1_11:canShowMythSuccess() then
				arg_1_0:showSuccView()
			elseif var_1_11 and var_1_11:checkFightTypeIsConquer() and FightModel.instance:getCurWaveId() > 1 then
				arg_1_0:showSuccView()
			else
				arg_1_0:showFailView()
			end
		else
			if var_1_9 == FightEnum.FightResult.OutOfRoundFail then
				if BossRushController.instance:isInBossRushDungeon() then
					FightController.instance:registerCallback(FightEvent.OnResultViewClose, arg_1_0._done, arg_1_0)
					BossRushController.instance:openResultPanel()

					return
				end

				ViewMgr.instance:openView(ViewName.FightFailTipsView, {
					fight_result = var_1_9,
					callback = function()
						arg_1_0:showFailView()
					end
				})

				return
			end

			arg_1_0:showFailView()
		end
	end
end

function var_0_0.showSuccView(arg_3_0)
	FightAudioMgr.instance:setSwitch(FightEnum.AudioSwitch.Victory)
	PopupController.instance:setPause("fightsuccess", true)
	FightController.instance:registerCallback(FightEvent.OnResultViewClose, arg_3_0._done, arg_3_0)
	arg_3_0:_showSuccView()
end

function var_0_0._showSuccView(arg_4_0)
	local var_4_0 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if var_4_0 then
		if var_4_0.type == DungeonEnum.EpisodeType.Season then
			Activity104Controller.instance:openSeasonSettlementView()

			return
		elseif var_4_0.type == DungeonEnum.EpisodeType.SeasonRetail or var_4_0.type == DungeonEnum.EpisodeType.SeasonTrial then
			PopupController.instance:setPause("fightsuccess", false)
			Activity104Controller.instance:openSeasonFightSuccView()

			return
		elseif ToughBattleConfig.instance:isActStage2EpisodeId(DungeonModel.instance.curSendEpisodeId) or ToughBattleConfig.instance:isStage1EpisodeId(DungeonModel.instance.curSendEpisodeId) then
			ViewMgr.instance:openView(ViewName.ToughBattleFightSuccView)

			return
		elseif var_4_0.type == DungeonEnum.EpisodeType.SeasonSpecial then
			Activity104Controller.instance:openSeasonSettlementView()

			return
		elseif var_4_0.type == DungeonEnum.EpisodeType.Season123 then
			Season123Controller.instance:openSeason123SettlementView()

			return
		elseif var_4_0.type == DungeonEnum.EpisodeType.Season123Retail or var_4_0.type == DungeonEnum.EpisodeType.Season123Trial then
			PopupController.instance:setPause("fightsuccess", false)
			Season123Controller.instance:openSeasonFightSuccView()

			return
		elseif var_4_0.type == DungeonEnum.EpisodeType.RoleStoryChallenge then
			ViewMgr.instance:openView(ViewName.RoleStoryFightSuccView)

			return
		elseif var_4_0.type == DungeonEnum.EpisodeType.Act1_6DungeonBoss then
			ViewMgr.instance:openView(ViewName.VersionActivity1_6BossFightSuccView)

			return
		elseif var_4_0.type == DungeonEnum.EpisodeType.Cachot then
			if V1a6_CachotModel.instance:getRogueEndingInfo() then
				arg_4_0:_done()

				return
			end
		elseif var_4_0.type == DungeonEnum.EpisodeType.Rouge then
			ViewMgr.instance:openView(ViewName.RougeFightSuccessView)

			return
		elseif var_4_0.type == DungeonEnum.EpisodeType.Season166Base or var_4_0.type == DungeonEnum.EpisodeType.Season166Train then
			Season166Controller.instance:openResultPanel()

			return
		elseif var_4_0.type == DungeonEnum.EpisodeType.TowerBoss or var_4_0.type == DungeonEnum.EpisodeType.TowerBossTeach then
			ViewMgr.instance:openView(ViewName.TowerBossResultView)

			return
		elseif var_4_0.type == DungeonEnum.EpisodeType.TowerPermanent or var_4_0.type == DungeonEnum.EpisodeType.TowerLimited then
			ViewMgr.instance:openView(ViewName.TowerPermanentResultView)

			return
		elseif var_4_0.type == DungeonEnum.EpisodeType.Act183 then
			ViewMgr.instance:openView(ViewName.Act183FightSuccView)

			return
		elseif var_4_0.type == DungeonEnum.EpisodeType.Act191 then
			Activity191Controller.instance:openResultPanel(true)

			return
		elseif VersionActivity2_9DungeonHelper.isTargetActEpisode(var_4_0.id, VersionActivity2_9Enum.ActivityId.Dungeon) then
			VersionActivity2_9DungeonController.instance:openFightSuccView()

			return
		elseif var_4_0.type == DungeonEnum.EpisodeType.Odyssey then
			OdysseyController.instance:openFightSuccView()

			return
		elseif var_4_0.type == DungeonEnum.EpisodeType.TowerDeep then
			local var_4_1, var_4_2 = TowerPermanentDeepModel.instance:checkCanShowResultView()

			if var_4_1 and var_4_2 == TowerDeepEnum.FightResult.Succ then
				ViewMgr.instance:openView(ViewName.TowerDeepResultView)
			else
				arg_4_0:_done()
			end

			return
		end
	end

	if BossRushController.instance:isInBossRushDungeon() then
		BossRushController.instance:openResultPanel()

		return
	end

	ViewMgr.instance:openView(ViewName.FightSuccView)
end

function var_0_0.showFailView(arg_5_0)
	FightAudioMgr.instance:setSwitch(FightEnum.AudioSwitch.Losing)
	FightController.instance:registerCallback(FightEvent.OnResultViewClose, arg_5_0._done, arg_5_0)

	local var_5_0 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if var_5_0 then
		if Activity104Model.instance:isSeasonEpisodeType(var_5_0.type) then
			Activity104Controller.instance:openSeasonFightFailView()

			return
		elseif Season123Controller.isSeason123EpisodeType(var_5_0.type) then
			Season123Controller.instance:openSeasonFightFailView()

			return
		elseif var_5_0.type == DungeonEnum.EpisodeType.Act1_6DungeonBoss then
			ViewMgr.instance:openView(ViewName.VersionActivity1_6BossFightSuccView)

			return
		elseif var_5_0.type == DungeonEnum.EpisodeType.Season166Base then
			Season166Controller.instance:openResultPanel()

			return
		elseif var_5_0.type == DungeonEnum.EpisodeType.Act191 then
			Activity191Controller.instance:openResultPanel(false)

			return
		elseif var_5_0.type == DungeonEnum.EpisodeType.TowerDeep then
			local var_5_1, var_5_2 = TowerPermanentDeepModel.instance:checkCanShowResultView()

			if var_5_1 and var_5_2 == TowerDeepEnum.FightResult.Fail then
				ViewMgr.instance:openView(ViewName.TowerDeepResultView)
			else
				arg_5_0:_done()
			end

			return
		end
	end

	if BossRushController.instance:isInBossRushDungeon() then
		BossRushController.instance:openResultPanel()

		return
	end

	ViewMgr.instance:openView(ViewName.FightFailView)
end

function var_0_0._needHideEntity(arg_6_0)
	local var_6_0 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if var_6_0 and var_6_0.type == DungeonEnum.EpisodeType.Season then
		return false
	end

	return true
end

function var_0_0._done(arg_7_0)
	arg_7_0:onDone(true)
end

function var_0_0.clearWork(arg_8_0)
	FightController.instance:unregisterCallback(FightEvent.OnResultViewClose, arg_8_0._done, arg_8_0)
	PopupController.instance:setPause("fightsuccess", false)
end

return var_0_0
