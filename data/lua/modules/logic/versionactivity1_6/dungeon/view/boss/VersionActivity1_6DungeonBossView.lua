module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6DungeonBossView", package.seeall)

slot0 = class("VersionActivity1_6DungeonBossView", BaseView)
slot1 = 5
slot2 = VersionActivity1_6DungeonEnum.bossMaxOrder
slot3 = VersionActivity1_6Enum.ActivityId.DungeonBossRush .. "UnlockBossEpisode_"
slot4 = VersionActivity1_6Enum.ActivityId.DungeonBossRush .. "GotMaxScore_"
slot5 = VersionActivity1_6Enum.ActivityId.DungeonBossRush .. "FirstPassBoss_"

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._goNormalBG = gohelper.findChild(slot0.viewGO, "Left/#simage_NormalBG")
	slot0._goHardBG = gohelper.findChild(slot0.viewGO, "Left/#simage_HardBG")
	slot0._goNormalTitleBG = gohelper.findChild(slot0.viewGO, "Left/Title/image_NormalTitleBG")
	slot0._goHardTitleBG = gohelper.findChild(slot0.viewGO, "Left/Title/image_HardTitleBG")
	slot0._goLvNormalBG = gohelper.findChild(slot0.viewGO, "Left/Lv/image_LvNormalBG")
	slot0._goLvHardBG = gohelper.findChild(slot0.viewGO, "Left/Lv/image_LvHardBG")
	slot0._goBosslv = gohelper.findChild(slot0.viewGO, "Left/Lv")
	slot0._txtBosslv = gohelper.findChildText(slot0.viewGO, "Left/Lv/#txt_Lv")
	slot0._txtTipsNum = gohelper.findChildText(slot0.viewGO, "Left/Lv/Tips/#txt_TipsNum")
	slot0._btnPreLv = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/Lv/#btn_Left")
	slot0._imagePreLv = gohelper.findChildImage(slot0.viewGO, "Left/Lv/#btn_Left")
	slot0._goBtnPreLv = gohelper.findChild(slot0.viewGO, "Left/Lv/#btn_Left")
	slot0._btnNextLv = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/Lv/#btn_Right")
	slot0._imageNextLv = gohelper.findChildImage(slot0.viewGO, "Left/Lv/#btn_Right")
	slot0._goBtnNextLv = gohelper.findChild(slot0.viewGO, "Left/Lv/#btn_Right")
	slot0._goBtnNextLvLock = gohelper.findChild(slot0.viewGO, "Left/Lv/#txt_Lv/#btn_Lock")
	slot0._txtScoreNum = gohelper.findChildText(slot0.viewGO, "Left/Score/txt_ScoreNum")
	slot0._goMaxScoreTips = gohelper.findChild(slot0.viewGO, "Left/Score/txt_ScoreNum/#go_ScoreTips")
	slot0._btnInfo = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/Title/#btn_Info")
	slot0._btnScoreDetailInfo = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/Score/#btn_Score")
	slot0._btnCloseScoreDetailInfo = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/Score/#btn_Score/image_ScoreTipsBG/#btn_tipsClose")
	slot0._goScoreDetailTips = gohelper.findChild(slot0.viewGO, "Left/Score/#btn_Score/image_ScoreTipsBG")
	slot0._btnLock = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/Lv/#txt_Lv/#btn_Lock")
	slot0._goBtnReward = gohelper.findChild(slot0.viewGO, "Right/#btn_Reward")
	slot0._btnReward = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Reward")
	slot0._btnCloseReward = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Reward/RewardTips/#btn_closeReawrds")
	slot0._goRewardTips = gohelper.findChild(slot0.viewGO, "Right/#btn_Reward/RewardTips")
	slot0._goRewards = gohelper.findChild(slot0.viewGO, "Right/#btn_Reward/RewardTips/#scroll_Rewards/Viewport/#go_rewards")
	slot0._btnEnterNormal = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_EnterNormal")
	slot0._btnEnterHard = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_EnterHard")
	slot0._goEnterNormalLocked = gohelper.findChild(slot0.viewGO, "Right/#btn_EnterNormalLocked")
	slot0._goEnterHardLocked = gohelper.findChild(slot0.viewGO, "Right/#btn_EnterHardLocked")
	slot0._btnSchedule = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/Reward/image_RewardBG")
	slot0._redDotSchedule = gohelper.findChild(slot0.viewGO, "Right/Reward/#go_reddot")
	slot0._imageScoreProgress = gohelper.findChildImage(slot0.viewGO, "Right/Reward/image_RewardSlider")
	slot0._rewardEffect = gohelper.findChild(slot0.viewGO, "Right/Reward/vx_collect")
	slot0._rewardEffectAnimator = slot0._rewardEffect:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnPreLv:AddClickListener(slot0._preLvclick, slot0)
	slot0._btnNextLv:AddClickListener(slot0._nextLvclick, slot0)
	slot0._btnLock:AddClickListener(slot0._lockLvclick, slot0)
	slot0._btnReward:AddClickListener(slot0._onClickRewardBtn, slot0)
	slot0._btnCloseReward:AddClickListener(slot0._onClicClosekRewardBtn, slot0)
	slot0._btnEnterHard:AddClickListener(slot0._enterFightClick, slot0)
	slot0._btnEnterNormal:AddClickListener(slot0._enterFightClick, slot0)
	slot0._btnSchedule:AddClickListener(slot0._btnScheduleOnClick, slot0)
	slot0._btnInfo:AddClickListener(slot0._btnInfoOnClick, slot0)
	slot0._btnScoreDetailInfo:AddClickListener(slot0._btnScoreDetailOnClick, slot0)
	slot0._btnCloseScoreDetailInfo:AddClickListener(slot0._btnCloseScoreDetailOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnPreLv:RemoveClickListener()
	slot0._btnNextLv:RemoveClickListener()
	slot0._btnLock:RemoveClickListener()
	slot0._btnReward:RemoveClickListener()
	slot0._btnCloseReward:RemoveClickListener()
	slot0._btnEnterNormal:RemoveClickListener()
	slot0._btnEnterHard:RemoveClickListener()
	slot0._btnSchedule:RemoveClickListener()
	slot0._btnInfo:RemoveClickListener()
	slot0._btnScoreDetailInfo:RemoveClickListener()
	slot0._btnCloseScoreDetailInfo:RemoveClickListener()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot2, slot3 = VersionActivity1_6DungeonBossModel.instance:getMaxOrderMo()
	slot6 = VersionActivity1_6DungeonBossModel.instance:getAct149MoByEpisodeId(DungeonModel.instance.lastSendEpisodeId)

	if slot0.viewParam and slot0.viewParam.toPreEpisode and slot6 then
		slot0._curBossEpisodeMo = slot6
		slot0._curBossEpisodeOrder = slot6.cfg.order
	else
		slot0._curBossEpisodeMo = slot2
		slot0._curBossEpisodeOrder = slot3
	end

	slot0._curBossCfg = slot1:getAct149EpisodeCfgIdByOrder(slot0._curBossEpisodeOrder)
	slot0._curMaxOrder = slot3
	slot0._lvIcons = slot0:getUserDataTb_()

	for slot10 = 1, uv0 do
		slot0._lvIcons[slot10] = gohelper.findChild(slot0.viewGO, "Left/Lv/#txt_Lv/image_Lv" .. slot10)
	end

	gohelper.setActive(slot0._goRewardTips, false)
	gohelper.setActive(slot0._goScoreDetailTips, false)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
	slot0:addEventCb(VersionActivity1_6DungeonController.instance, VersionActivity1_6DungeonEvent.DungeonBossInfoUpdated, slot0._onDungeonBossInfoUpdated, slot0)
	slot0:addEventCb(JumpController.instance, JumpEvent.BeforeJump, slot0.closeThis, slot0)
	RedDotController.instance:addRedDot(slot0._redDotSchedule, RedDotEnum.DotNode.V1a6DungeonBossReward)
end

function slot0.onOpenFinish(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonBossViewAmbient)
	slot0:_refreshUI()

	if slot0.viewParam and slot0.viewParam.showDailyBonus then
		slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onDailyBonusViewCloase, slot0)
	else
		slot0:_playAnimations()
		slot0:dispatchGuideEvent()
	end
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonBossViewStopAmbient)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0._refreshUI(slot0)
	slot0:_refreshBossLvArea()
	slot0:_refreshScoreArea()
	slot0:_refreshScoreBtn()
	slot0:_refreshRuleView()
	slot0:_refreshRewardArea()
	slot0:_refreshBtnState()
end

function slot0._refreshUIOnBossChange(slot0)
	slot0:_refreshBossLvArea()
	slot0:_refreshRuleView()
	slot0:_refreshBtnState()
	slot0:_playAnimations()
end

function slot0._refreshBossLvArea(slot0)
	slot0._txtBosslv.text = "Lv." .. slot0._curBossEpisodeOrder

	for slot5 = 1, uv0 do
		if slot0._lvIcons[slot5] then
			gohelper.setActive(slot6, slot5 == slot1 and slot0._curBossEpisodeMo ~= nil)
		end
	end

	slot0._txtTipsNum.text = math.floor(slot0._curBossCfg.multi * 100) .. "%"

	gohelper.setActive(slot0._goBtnNextLv, true)
	gohelper.setActive(slot0._goBtnPreLv, true)
	gohelper.setActive(slot0._goBtnNextLvLock, false)

	slot3 = slot0._curBossEpisodeOrder == uv1

	ZProj.UGUIHelper.SetColorAlpha(slot0._imageNextLv, slot3 and 0.5 or 1)
	ZProj.UGUIHelper.SetColorAlpha(slot0._imagePreLv, slot0._curBossEpisodeOrder == 1 and 0.5 or 1)
	gohelper.setActive(slot0._goNormalBG, not slot3)
	gohelper.setActive(slot0._goHardBG, slot3)
	gohelper.setActive(slot0._goLvNormalBG, not slot3)
	gohelper.setActive(slot0._goLvHardBG, slot3)
	gohelper.setActive(slot0._goNormalTitleBG, not slot3)
	gohelper.setActive(slot0._goHardTitleBG, slot3)
end

function slot0._refreshBtnState(slot0)
	slot1 = slot0._curBossEpisodeMo ~= nil

	gohelper.setActive(slot0._btnEnterNormal.gameObject, slot1)
	gohelper.setActive(slot0._btnEnterHard.gameObject, slot1)
	gohelper.setActive(slot0._goEnterNormalLocked, not slot1)
	gohelper.setActive(slot0._goEnterHardLocked, not slot1)
end

function slot0._refreshScoreArea(slot0)
	slot1 = VersionActivity1_6DungeonBossModel.instance:getCurMaxScore()
	slot0._txtScoreNum.text = slot1

	gohelper.setActive(slot0._goBtnReward, not slot1 or slot1 == 0)
	gohelper.setActive(slot0._goMaxScoreTips, slot1 == Activity149Config.instance:getEpisodeMaxScore(slot0._curBossCfg.id, VersionActivity1_6Enum.ActivityId.DungeonBossRush))
end

function slot0._refreshScoreBtn(slot0)
	slot0._imageScoreProgress.fillAmount = VersionActivity1_6DungeonBossModel.instance:getTotalScore() / (1 * Activity149Config.instance:getBossRewardMaxScore())
end

function slot0._refreshRuleView(slot0)
	slot1 = slot0._curBossCfg.id
	slot3 = nil

	if slot0._curBossCfg.order == uv0 and not VersionActivity1_6DungeonBossModel.instance:isLastBossEpisode() then
		slot3 = Activity149Config.instance:getDungeonEpisodeCfg(Activity149Config.instance:getNextBossEpisodeCfgById(slot2.id).id).battleId
	end

	slot0.viewContainer:getBossRuleView():refreshUI(Activity149Config.instance:getDungeonEpisodeCfg(slot1).battleId, slot3)
end

function slot0._refreshRewardArea(slot0)
	IconMgr.instance:getCommonPropItemIconList(slot0, slot0._onRewardItemShow, ItemModel.instance:getItemDataListByConfigStr(Activity149Config.instance:getAct149ConstValue(2)), slot0._goRewards)
end

function slot0._onRewardItemShow(slot0, slot1, slot2, slot3)
	slot1:onUpdateMO(slot2)
	slot1:setConsume(true)
	slot1:showStackableNum2()
	slot1:isShowEffect(true)
	slot1:setAutoPlay(true)
	slot1:setCountFontSize(48)
end

function slot0._onDailyRefresh(slot0)
	if ActivityHelper.getActivityStatus(VersionActivity1_6Enum.ActivityId.DungeonBossRush) == ActivityEnum.ActivityStatus.Normal then
		VersionActivity1_6DungeonRpc.instance:sendGet149InfoRequest()
	end
end

function slot0._onDungeonBossInfoUpdated(slot0)
	slot1 = VersionActivity1_6DungeonBossModel.instance
	slot2, slot0._curMaxOrder = slot1:getMaxOrderMo()
	slot0._curBossCfg = slot1:getAct149EpisodeCfgIdByOrder(slot0._curBossEpisodeOrder)
	slot0._curBossEpisodeMo = slot1:getAct149MoByOrder(slot0._curBossEpisodeOrder)

	slot0:_refreshUI()
	slot0:_playAnimations()
	slot0:_showUnlockAnimation()
	slot0:dispatchGuideEvent()
end

function slot0._onDailyBonusViewCloase(slot0, slot1)
	if slot1 == ViewName.CommonPropView then
		slot0:_playAnimations()
	end
end

function slot0.dispatchGuideEvent(slot0)
	VersionActivity1_6DungeonController.instance:dispatchEvent(VersionActivity1_6DungeonEvent.DungeonBossOrder, slot0._curMaxOrder)
end

function slot0._enterFightClick(slot0)
	if slot0._curBossEpisodeMo then
		VersionActivity1_6DungeonController.instance:enterBossFightScene(slot0._curBossCfg.id)
	end
end

function slot0._btnScheduleOnClick(slot0)
	ViewMgr.instance:openView(ViewName.VersionActivity1_6_BossScheduleView)
end

function slot0._preLvclick(slot0)
	if slot0._curBossEpisodeOrder <= 1 then
		return
	end

	slot0._curBossEpisodeOrder = slot0._curBossEpisodeOrder - 1
	slot1 = VersionActivity1_6DungeonBossModel.instance
	slot0._curBossCfg = slot1:getAct149EpisodeCfgIdByOrder(slot0._curBossEpisodeOrder)
	slot0._curBossEpisodeMo = slot1:getAct149MoByOrder(slot0._curBossEpisodeOrder)

	slot0:_refreshUIOnBossChange()
end

function slot0._nextLvclick(slot0)
	if VersionActivity1_6DungeonEnum.bossMaxOrder <= slot0._curBossEpisodeOrder then
		return
	end

	slot0._curBossEpisodeOrder = slot0._curBossEpisodeOrder + 1
	slot1 = VersionActivity1_6DungeonBossModel.instance
	slot0._curBossCfg = slot1:getAct149EpisodeCfgIdByOrder(slot0._curBossEpisodeOrder)
	slot0._curBossEpisodeMo = slot1:getAct149MoByOrder(slot0._curBossEpisodeOrder)

	slot0:_refreshUIOnBossChange()
end

function slot0._lockLvclick(slot0)
	slot0._curBossCfg = VersionActivity1_6DungeonBossModel.instance:getAct149EpisodeCfgIdByOrder(slot0._curBossEpisodeOrder)
	slot0._curBossEpisodeMo = VersionActivity1_6DungeonBossModel.instance:getAct149MoByOrder(slot0._curBossEpisodeOrder)

	if DungeonModel.instance:getEpisodeInfo(slot0._curBossCfg.episodeId) and slot2.star > 0 then
		GameFacade.showToast(ToastEnum.Act1_6DungeonToast60205)
	else
		GameFacade.showToast(ToastEnum.Act1_6DungeonToast60204)
	end
end

function slot0._onClickRewardBtn(slot0)
	gohelper.setActive(slot0._goRewardTips, true)
end

function slot0._onClicClosekRewardBtn(slot0)
	gohelper.setActive(slot0._goRewardTips, false)
end

function slot0._btnInfoOnClick(slot0)
	slot1 = slot0._curBossCfg and DungeonConfig.instance:getEpisodeCO(slot0._curBossCfg.episodeId)

	if slot1 and slot1.battleId then
		EnemyInfoController.instance:openEnemyInfoViewByBattleId(slot2)
	end
end

function slot0._btnScoreDetailOnClick(slot0)
	gohelper.setActive(slot0._goScoreDetailTips, true)
end

function slot0._btnCloseScoreDetailOnClick(slot0)
	gohelper.setActive(slot0._goScoreDetailTips, false)
end

function slot0._playAnimations(slot0)
	slot0:_showUnlockAnimation()
	slot0:_showTodayMaxScoreAnimation()

	if not slot0:_showFirstPassBossAnimation() then
		slot0:_showGotScroeAnimation()
	else
		VersionActivity1_6DungeonBossModel.instance:applyPreScoreToCurScore()
	end
end

function slot0._showUnlockAnimation(slot0)
	if slot0._curBossEpisodeMo ~= nil and PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(uv0 .. slot0._curBossEpisodeOrder)) ~= 1 then
		PlayerPrefsHelper.setNumber(slot4, 1)
		slot0._goBosslv:GetComponent(typeof(UnityEngine.Animator)):Play(UIAnimationName.Unlock, 0, 0)
	end
end

function slot0._showTodayMaxScoreAnimation(slot0)
	slot1 = slot0._curBossEpisodeOrder
	slot2 = VersionActivity1_6DungeonBossModel.instance

	if not (VersionActivity1_6DungeonBossModel.instance:getCurMaxScore() == Activity149Config.instance:getEpisodeMaxScore(slot0._curBossCfg.id, VersionActivity1_6Enum.ActivityId.DungeonBossRush)) then
		return
	end

	if not (PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(uv0 .. slot1)) == 1) then
		PlayerPrefsHelper.setNumber(slot7, 1)

		slot10 = gohelper.findChild(slot0.viewGO, "Left/Score/vx_highscore")

		gohelper.setActive(slot10, false)
		gohelper.setActive(slot10, true)
	end
end

function slot0._showFirstPassBossAnimation(slot0)
	if not VersionActivity1_6DungeonBossModel.instance:checkEpisodePassedByOrder(slot0._curBossEpisodeOrder) then
		return
	end

	if not (PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(uv0 .. slot1)) == 1) then
		PlayerPrefsHelper.setNumber(slot5, 1)
		gohelper.setActive(slot0._rewardEffect, true)
		slot0._rewardEffectAnimator:Play(UIAnimationName.Finish .. 1, 0, 0)
		AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonBossViewGetScore)

		return true
	end
end

function slot0._showGotScroeAnimation(slot0)
	if VersionActivity1_6DungeonBossModel.instance:HasGotHigherScore() then
		slot1:applyPreScoreToCurScore()
		gohelper.setActive(slot0._rewardEffect, true)
		slot0._rewardEffectAnimator:Play(UIAnimationName.Finish .. 2, 0, 0)
		AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonBossViewGetScore)
	end
end

return slot0
