module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6DungeonBossView", package.seeall)

local var_0_0 = class("VersionActivity1_6DungeonBossView", BaseView)
local var_0_1 = 8
local var_0_2 = VersionActivity1_6DungeonEnum.bossMaxOrder
local var_0_3 = VersionActivity1_6Enum.ActivityId.DungeonBossRush .. "UnlockBossEpisode_"
local var_0_4 = VersionActivity1_6Enum.ActivityId.DungeonBossRush .. "GotMaxScore_"
local var_0_5 = VersionActivity1_6Enum.ActivityId.DungeonBossRush .. "FirstPassBoss_"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._goNormalBG = gohelper.findChild(arg_1_0.viewGO, "Left/#simage_NormalBG")
	arg_1_0._goHardBG = gohelper.findChild(arg_1_0.viewGO, "Left/#simage_HardBG")
	arg_1_0._goNormalTitleBG = gohelper.findChild(arg_1_0.viewGO, "Left/Title/image_NormalTitleBG")
	arg_1_0._goHardTitleBG = gohelper.findChild(arg_1_0.viewGO, "Left/Title/image_HardTitleBG")
	arg_1_0._goLvNormalBG = gohelper.findChild(arg_1_0.viewGO, "Left/Lv/image_LvNormalBG")
	arg_1_0._goLvHardBG = gohelper.findChild(arg_1_0.viewGO, "Left/Lv/image_LvHardBG")
	arg_1_0._goBosslv = gohelper.findChild(arg_1_0.viewGO, "Left/Lv")
	arg_1_0._txtBosslv = gohelper.findChildText(arg_1_0.viewGO, "Left/Lv/#txt_Lv")
	arg_1_0._txtTipsNum = gohelper.findChildText(arg_1_0.viewGO, "Left/Lv/Tips/#txt_TipsNum")
	arg_1_0._btnPreLv = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/Lv/#btn_Left")
	arg_1_0._imagePreLv = gohelper.findChildImage(arg_1_0.viewGO, "Left/Lv/#btn_Left")
	arg_1_0._goBtnPreLv = gohelper.findChild(arg_1_0.viewGO, "Left/Lv/#btn_Left")
	arg_1_0._btnNextLv = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/Lv/#btn_Right")
	arg_1_0._imageNextLv = gohelper.findChildImage(arg_1_0.viewGO, "Left/Lv/#btn_Right")
	arg_1_0._goBtnNextLv = gohelper.findChild(arg_1_0.viewGO, "Left/Lv/#btn_Right")
	arg_1_0._goBtnNextLvLock = gohelper.findChild(arg_1_0.viewGO, "Left/Lv/#txt_Lv/#btn_Lock")
	arg_1_0._txtScoreNum = gohelper.findChildText(arg_1_0.viewGO, "Left/Score/txt_ScoreNum")
	arg_1_0._goMaxScoreTips = gohelper.findChild(arg_1_0.viewGO, "Left/Score/txt_ScoreNum/#go_ScoreTips")
	arg_1_0._btnInfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/Title/#btn_Info")
	arg_1_0._btnScoreDetailInfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/Score/#btn_Score")
	arg_1_0._btnCloseScoreDetailInfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/Score/#btn_Score/image_ScoreTipsBG/#btn_tipsClose")
	arg_1_0._goScoreDetailTips = gohelper.findChild(arg_1_0.viewGO, "Left/Score/#btn_Score/image_ScoreTipsBG")
	arg_1_0._btnLock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/Lv/#txt_Lv/#btn_Lock")
	arg_1_0._goBtnReward = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_Reward")
	arg_1_0._btnReward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Reward")
	arg_1_0._btnCloseReward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Reward/RewardTips/#btn_closeReawrds")
	arg_1_0._goRewardTips = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_Reward/RewardTips")
	arg_1_0._goRewards = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_Reward/RewardTips/#scroll_Rewards/Viewport/#go_rewards")
	arg_1_0._btnEnterNormal = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_EnterNormal")
	arg_1_0._btnEnterHard = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_EnterHard")
	arg_1_0._goEnterNormalLocked = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_EnterNormalLocked")
	arg_1_0._goEnterHardLocked = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_EnterHardLocked")
	arg_1_0._btnSchedule = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/Reward/image_RewardBG")
	arg_1_0._redDotSchedule = gohelper.findChild(arg_1_0.viewGO, "Right/Reward/#go_reddot")
	arg_1_0._imageScoreProgress = gohelper.findChildImage(arg_1_0.viewGO, "Right/Reward/image_RewardSlider")
	arg_1_0._rewardEffect = gohelper.findChild(arg_1_0.viewGO, "Right/Reward/vx_collect")
	arg_1_0._rewardEffectAnimator = arg_1_0._rewardEffect:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnPreLv:AddClickListener(arg_2_0._preLvclick, arg_2_0)
	arg_2_0._btnNextLv:AddClickListener(arg_2_0._nextLvclick, arg_2_0)
	arg_2_0._btnLock:AddClickListener(arg_2_0._lockLvclick, arg_2_0)
	arg_2_0._btnReward:AddClickListener(arg_2_0._onClickRewardBtn, arg_2_0)
	arg_2_0._btnCloseReward:AddClickListener(arg_2_0._onClicClosekRewardBtn, arg_2_0)
	arg_2_0._btnEnterHard:AddClickListener(arg_2_0._enterFightClick, arg_2_0)
	arg_2_0._btnEnterNormal:AddClickListener(arg_2_0._enterFightClick, arg_2_0)
	arg_2_0._btnSchedule:AddClickListener(arg_2_0._btnScheduleOnClick, arg_2_0)
	arg_2_0._btnInfo:AddClickListener(arg_2_0._btnInfoOnClick, arg_2_0)
	arg_2_0._btnScoreDetailInfo:AddClickListener(arg_2_0._btnScoreDetailOnClick, arg_2_0)
	arg_2_0._btnCloseScoreDetailInfo:AddClickListener(arg_2_0._btnCloseScoreDetailOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnPreLv:RemoveClickListener()
	arg_3_0._btnNextLv:RemoveClickListener()
	arg_3_0._btnLock:RemoveClickListener()
	arg_3_0._btnReward:RemoveClickListener()
	arg_3_0._btnCloseReward:RemoveClickListener()
	arg_3_0._btnEnterNormal:RemoveClickListener()
	arg_3_0._btnEnterHard:RemoveClickListener()
	arg_3_0._btnSchedule:RemoveClickListener()
	arg_3_0._btnInfo:RemoveClickListener()
	arg_3_0._btnScoreDetailInfo:RemoveClickListener()
	arg_3_0._btnCloseScoreDetailInfo:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = VersionActivity1_6DungeonBossModel.instance
	local var_6_1, var_6_2 = var_6_0:getMaxOrderMo()
	local var_6_3 = arg_6_0.viewParam and arg_6_0.viewParam.toPreEpisode
	local var_6_4 = DungeonModel.instance.lastSendEpisodeId
	local var_6_5 = VersionActivity1_6DungeonBossModel.instance:getAct149MoByEpisodeId(var_6_4)

	if var_6_3 and var_6_5 then
		arg_6_0._curBossEpisodeMo = var_6_5
		arg_6_0._curBossEpisodeOrder = var_6_5.cfg.order
	else
		arg_6_0._curBossEpisodeMo = var_6_1
		arg_6_0._curBossEpisodeOrder = var_6_2
	end

	arg_6_0._curBossCfg = var_6_0:getAct149EpisodeCfgIdByOrder(arg_6_0._curBossEpisodeOrder)
	arg_6_0._curMaxOrder = var_6_2
	arg_6_0._lvIcons = arg_6_0:getUserDataTb_()

	for iter_6_0 = 1, var_0_1 do
		local var_6_6 = gohelper.findChild(arg_6_0.viewGO, "Left/Lv/#txt_Lv/image_Lv" .. iter_6_0)

		arg_6_0._lvIcons[iter_6_0] = var_6_6
	end

	gohelper.setActive(arg_6_0._goRewardTips, false)
	gohelper.setActive(arg_6_0._goScoreDetailTips, false)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_6_0._onDailyRefresh, arg_6_0)
	arg_6_0:addEventCb(VersionActivity1_6DungeonController.instance, VersionActivity1_6DungeonEvent.DungeonBossInfoUpdated, arg_6_0._onDungeonBossInfoUpdated, arg_6_0)
	arg_6_0:addEventCb(JumpController.instance, JumpEvent.BeforeJump, arg_6_0.closeThis, arg_6_0)
	RedDotController.instance:addRedDot(arg_6_0._redDotSchedule, RedDotEnum.DotNode.V1a6DungeonBossReward)
end

function var_0_0.onOpenFinish(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonBossViewAmbient)
	arg_7_0:_refreshUI()

	if arg_7_0.viewParam and arg_7_0.viewParam.showDailyBonus then
		arg_7_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_7_0._onDailyBonusViewCloase, arg_7_0)
	else
		arg_7_0:_playAnimations()
		arg_7_0:dispatchGuideEvent()
	end
end

function var_0_0.onClose(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonBossViewStopAmbient)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_8_0._onDailyRefresh, arg_8_0)
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

function var_0_0._refreshUI(arg_10_0)
	arg_10_0:_refreshBossLvArea()
	arg_10_0:_refreshScoreArea()
	arg_10_0:_refreshScoreBtn()
	arg_10_0:_refreshRuleView()
	arg_10_0:_refreshRewardArea()
	arg_10_0:_refreshBtnState()
end

function var_0_0._refreshUIOnBossChange(arg_11_0)
	arg_11_0:_refreshBossLvArea()
	arg_11_0:_refreshRuleView()
	arg_11_0:_refreshBtnState()
	arg_11_0:_playAnimations()
end

function var_0_0._refreshBossLvArea(arg_12_0)
	local var_12_0 = arg_12_0._curBossEpisodeOrder

	arg_12_0._txtBosslv.text = "Lv." .. var_12_0

	for iter_12_0 = 1, var_0_1 do
		local var_12_1 = arg_12_0._lvIcons[iter_12_0]

		if var_12_1 then
			gohelper.setActive(var_12_1, iter_12_0 == var_12_0 and arg_12_0._curBossEpisodeMo ~= nil)
		end
	end

	local var_12_2 = math.floor(arg_12_0._curBossCfg.multi * 100)

	arg_12_0._txtTipsNum.text = var_12_2 .. "%"

	gohelper.setActive(arg_12_0._goBtnNextLv, true)
	gohelper.setActive(arg_12_0._goBtnPreLv, true)
	gohelper.setActive(arg_12_0._goBtnNextLvLock, false)

	local var_12_3 = arg_12_0._curBossEpisodeOrder == var_0_2

	ZProj.UGUIHelper.SetColorAlpha(arg_12_0._imageNextLv, var_12_3 and 0.5 or 1)
	ZProj.UGUIHelper.SetColorAlpha(arg_12_0._imagePreLv, arg_12_0._curBossEpisodeOrder == 1 and 0.5 or 1)
	gohelper.setActive(arg_12_0._goNormalBG, not var_12_3)
	gohelper.setActive(arg_12_0._goHardBG, var_12_3)
	gohelper.setActive(arg_12_0._goLvNormalBG, not var_12_3)
	gohelper.setActive(arg_12_0._goLvHardBG, var_12_3)
	gohelper.setActive(arg_12_0._goNormalTitleBG, not var_12_3)
	gohelper.setActive(arg_12_0._goHardTitleBG, var_12_3)
end

function var_0_0._refreshBtnState(arg_13_0)
	local var_13_0 = arg_13_0._curBossEpisodeMo ~= nil

	gohelper.setActive(arg_13_0._btnEnterNormal.gameObject, var_13_0)
	gohelper.setActive(arg_13_0._btnEnterHard.gameObject, var_13_0)
	gohelper.setActive(arg_13_0._goEnterNormalLocked, not var_13_0)
	gohelper.setActive(arg_13_0._goEnterHardLocked, not var_13_0)
end

function var_0_0._refreshScoreArea(arg_14_0)
	local var_14_0 = VersionActivity1_6DungeonBossModel.instance:getCurMaxScore()

	arg_14_0._txtScoreNum.text = var_14_0

	gohelper.setActive(arg_14_0._goBtnReward, false)

	local var_14_1 = Activity149Config.instance:getEpisodeMaxScore(arg_14_0._curBossCfg.id, VersionActivity1_6Enum.ActivityId.DungeonBossRush)

	gohelper.setActive(arg_14_0._goMaxScoreTips, var_14_0 == var_14_1)
end

function var_0_0._refreshScoreBtn(arg_15_0)
	local var_15_0 = VersionActivity1_6DungeonBossModel.instance:getTotalScore()
	local var_15_1 = Activity149Config.instance:getBossRewardMaxScore()

	arg_15_0._imageScoreProgress.fillAmount = var_15_0 / (1 * var_15_1)
end

function var_0_0._refreshRuleView(arg_16_0)
	local var_16_0 = arg_16_0._curBossCfg.id
	local var_16_1 = arg_16_0._curBossCfg
	local var_16_2
	local var_16_3 = VersionActivity1_6DungeonBossModel.instance

	if var_16_1.order == var_0_1 and not var_16_3:isLastBossEpisode() then
		local var_16_4 = Activity149Config.instance:getNextBossEpisodeCfgById(var_16_1.id)

		var_16_2 = Activity149Config.instance:getDungeonEpisodeCfg(var_16_4.id).battleId
	end

	local var_16_5 = Activity149Config.instance:getDungeonEpisodeCfg(var_16_0).battleId

	arg_16_0.viewContainer:getBossRuleView():refreshUI(var_16_5, var_16_2)
end

function var_0_0._refreshRewardArea(arg_17_0)
	local var_17_0 = 2
	local var_17_1 = Activity149Config.instance:getAct149ConstValue(var_17_0)
	local var_17_2 = ItemModel.instance:getItemDataListByConfigStr(var_17_1)

	IconMgr.instance:getCommonPropItemIconList(arg_17_0, arg_17_0._onRewardItemShow, var_17_2, arg_17_0._goRewards)
end

function var_0_0._onRewardItemShow(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_1:onUpdateMO(arg_18_2)
	arg_18_1:setConsume(true)
	arg_18_1:showStackableNum2()
	arg_18_1:isShowEffect(true)
	arg_18_1:setAutoPlay(true)
	arg_18_1:setCountFontSize(48)
end

function var_0_0._onDailyRefresh(arg_19_0)
	if ActivityHelper.getActivityStatus(VersionActivity1_6Enum.ActivityId.DungeonBossRush) == ActivityEnum.ActivityStatus.Normal then
		VersionActivity1_6DungeonRpc.instance:sendGet149InfoRequest()
	end
end

function var_0_0._onDungeonBossInfoUpdated(arg_20_0)
	local var_20_0 = VersionActivity1_6DungeonBossModel.instance
	local var_20_1, var_20_2 = var_20_0:getMaxOrderMo()

	arg_20_0._curMaxOrder = var_20_2
	arg_20_0._curBossCfg = var_20_0:getAct149EpisodeCfgIdByOrder(arg_20_0._curBossEpisodeOrder)
	arg_20_0._curBossEpisodeMo = var_20_0:getAct149MoByOrder(arg_20_0._curBossEpisodeOrder)

	arg_20_0:_refreshUI()
	arg_20_0:_playAnimations()
	arg_20_0:_showUnlockAnimation()
	arg_20_0:dispatchGuideEvent()
end

function var_0_0._onDailyBonusViewCloase(arg_21_0, arg_21_1)
	if arg_21_1 == ViewName.CommonPropView then
		arg_21_0:_playAnimations()
	end
end

function var_0_0.dispatchGuideEvent(arg_22_0)
	local var_22_0 = arg_22_0._curMaxOrder

	VersionActivity1_6DungeonController.instance:dispatchEvent(VersionActivity1_6DungeonEvent.DungeonBossOrder, var_22_0)
end

function var_0_0._enterFightClick(arg_23_0)
	if arg_23_0._curBossEpisodeMo then
		VersionActivity1_6DungeonController.instance:enterBossFightScene(arg_23_0._curBossCfg.id)
	end
end

function var_0_0._btnScheduleOnClick(arg_24_0)
	ViewMgr.instance:openView(ViewName.VersionActivity1_6_BossScheduleView)
end

function var_0_0._preLvclick(arg_25_0)
	if arg_25_0._curBossEpisodeOrder <= 1 then
		return
	end

	arg_25_0._curBossEpisodeOrder = arg_25_0._curBossEpisodeOrder - 1

	local var_25_0 = VersionActivity1_6DungeonBossModel.instance

	arg_25_0._curBossCfg = var_25_0:getAct149EpisodeCfgIdByOrder(arg_25_0._curBossEpisodeOrder)
	arg_25_0._curBossEpisodeMo = var_25_0:getAct149MoByOrder(arg_25_0._curBossEpisodeOrder)

	arg_25_0:_refreshUIOnBossChange()
end

function var_0_0._nextLvclick(arg_26_0)
	if arg_26_0._curBossEpisodeOrder >= VersionActivity1_6DungeonEnum.bossMaxOrder then
		return
	end

	arg_26_0._curBossEpisodeOrder = arg_26_0._curBossEpisodeOrder + 1

	local var_26_0 = VersionActivity1_6DungeonBossModel.instance

	arg_26_0._curBossCfg = var_26_0:getAct149EpisodeCfgIdByOrder(arg_26_0._curBossEpisodeOrder)
	arg_26_0._curBossEpisodeMo = var_26_0:getAct149MoByOrder(arg_26_0._curBossEpisodeOrder)

	arg_26_0:_refreshUIOnBossChange()
end

function var_0_0._lockLvclick(arg_27_0)
	arg_27_0._curBossCfg = VersionActivity1_6DungeonBossModel.instance:getAct149EpisodeCfgIdByOrder(arg_27_0._curBossEpisodeOrder)
	arg_27_0._curBossEpisodeMo = VersionActivity1_6DungeonBossModel.instance:getAct149MoByOrder(arg_27_0._curBossEpisodeOrder)

	local var_27_0 = DungeonModel.instance:getEpisodeInfo(arg_27_0._curBossCfg.episodeId)

	if var_27_0 and var_27_0.star > 0 then
		GameFacade.showToast(ToastEnum.Act1_6DungeonToast60205)
	else
		GameFacade.showToast(ToastEnum.Act1_6DungeonToast60204)
	end
end

function var_0_0._onClickRewardBtn(arg_28_0)
	gohelper.setActive(arg_28_0._goRewardTips, true)
end

function var_0_0._onClicClosekRewardBtn(arg_29_0)
	gohelper.setActive(arg_29_0._goRewardTips, false)
end

function var_0_0._btnInfoOnClick(arg_30_0)
	local var_30_0 = arg_30_0._curBossCfg and DungeonConfig.instance:getEpisodeCO(arg_30_0._curBossCfg.episodeId)
	local var_30_1 = var_30_0 and var_30_0.battleId

	if var_30_1 then
		EnemyInfoController.instance:openEnemyInfoViewByBattleId(var_30_1)
	end
end

function var_0_0._btnScoreDetailOnClick(arg_31_0)
	gohelper.setActive(arg_31_0._goScoreDetailTips, true)
end

function var_0_0._btnCloseScoreDetailOnClick(arg_32_0)
	gohelper.setActive(arg_32_0._goScoreDetailTips, false)
end

function var_0_0._playAnimations(arg_33_0)
	arg_33_0:_showUnlockAnimation()
	arg_33_0:_showTodayMaxScoreAnimation()

	if not arg_33_0:_showFirstPassBossAnimation() then
		arg_33_0:_showGotScroeAnimation()
	else
		VersionActivity1_6DungeonBossModel.instance:applyPreScoreToCurScore()
	end
end

function var_0_0._showUnlockAnimation(arg_34_0)
	local var_34_0 = arg_34_0._curBossEpisodeOrder
	local var_34_1 = arg_34_0._curBossEpisodeMo ~= nil
	local var_34_2 = var_0_3 .. var_34_0
	local var_34_3 = PlayerModel.instance:getPlayerPrefsKey(var_34_2)
	local var_34_4 = PlayerPrefsHelper.getNumber(var_34_3)

	if var_34_1 and var_34_4 ~= 1 then
		PlayerPrefsHelper.setNumber(var_34_3, 1)
		arg_34_0._goBosslv:GetComponent(typeof(UnityEngine.Animator)):Play(UIAnimationName.Unlock, 0, 0)
	end
end

function var_0_0._showTodayMaxScoreAnimation(arg_35_0)
	local var_35_0 = arg_35_0._curBossEpisodeOrder
	local var_35_1 = VersionActivity1_6DungeonBossModel.instance

	if not (VersionActivity1_6DungeonBossModel.instance:getCurMaxScore() == Activity149Config.instance:getEpisodeMaxScore(arg_35_0._curBossCfg.id, VersionActivity1_6Enum.ActivityId.DungeonBossRush)) then
		return
	end

	local var_35_2 = var_0_4 .. var_35_0
	local var_35_3 = PlayerModel.instance:getPlayerPrefsKey(var_35_2)

	if not (PlayerPrefsHelper.getNumber(var_35_3) == 1) then
		PlayerPrefsHelper.setNumber(var_35_3, 1)

		local var_35_4 = gohelper.findChild(arg_35_0.viewGO, "Left/Score/vx_highscore")

		gohelper.setActive(var_35_4, false)
		gohelper.setActive(var_35_4, true)
	end
end

function var_0_0._showFirstPassBossAnimation(arg_36_0)
	local var_36_0 = arg_36_0._curBossEpisodeOrder

	if not VersionActivity1_6DungeonBossModel.instance:checkEpisodePassedByOrder(var_36_0) then
		return
	end

	local var_36_1 = var_0_5 .. var_36_0
	local var_36_2 = PlayerModel.instance:getPlayerPrefsKey(var_36_1)

	if not (PlayerPrefsHelper.getNumber(var_36_2) == 1) then
		PlayerPrefsHelper.setNumber(var_36_2, 1)
		gohelper.setActive(arg_36_0._rewardEffect, true)
		arg_36_0._rewardEffectAnimator:Play(UIAnimationName.Finish .. 1, 0, 0)
		AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonBossViewGetScore)

		return true
	end
end

function var_0_0._showGotScroeAnimation(arg_37_0)
	local var_37_0 = VersionActivity1_6DungeonBossModel.instance

	if var_37_0:HasGotHigherScore() then
		var_37_0:applyPreScoreToCurScore()
		gohelper.setActive(arg_37_0._rewardEffect, true)
		arg_37_0._rewardEffectAnimator:Play(UIAnimationName.Finish .. 2, 0, 0)
		AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonBossViewGetScore)
	end
end

return var_0_0
