module("modules.logic.tower.view.timelimittower.TowerTimeLimitLevelView", package.seeall)

local var_0_0 = class("TowerTimeLimitLevelView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "simage_title/timebg/#txt_time")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "score/#simage_icon")
	arg_1_0._goTaskPointContent = gohelper.findChild(arg_1_0.viewGO, "score/#go_taskPointContent")
	arg_1_0._goTaskPointItem = gohelper.findChild(arg_1_0.viewGO, "score/#go_taskPointContent/#go_taskPointItem")
	arg_1_0._txtscore = gohelper.findChildText(arg_1_0.viewGO, "score/#txt_score")
	arg_1_0._btntaskClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "score/#btn_taskClick")
	arg_1_0._goBoss = gohelper.findChild(arg_1_0.viewGO, "root/main/boss")
	arg_1_0._btnbossClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/main/boss/#btn_bossClick")
	arg_1_0._gobossContent = gohelper.findChild(arg_1_0.viewGO, "root/main/boss/#go_bossContent")
	arg_1_0._gobossItem = gohelper.findChild(arg_1_0.viewGO, "root/main/boss/#go_bossContent/#go_bossItem")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._btncloseDetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_closeDetail")
	arg_1_0._godetailInfo = gohelper.findChild(arg_1_0.viewGO, "root/#go_detailInfo")
	arg_1_0._goSwitchEfeect = gohelper.findChild(arg_1_0.viewGO, "root/#go_detailInfo/#go_difficulty/index/vx_refresh")
	arg_1_0._goTaskReddot = gohelper.findChild(arg_1_0.viewGO, "score/#go_taskReddot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncloseDetail:AddClickListener(arg_2_0._btncloseDetailOnClick, arg_2_0)
	arg_2_0._btntaskClick:AddClickListener(arg_2_0._btnTaskClick, arg_2_0)
	arg_2_0._btnbossClick:AddClickListener(arg_2_0._btnBossClick, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.DailyReresh, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.OnTowerResetSubEpisode, arg_2_0.refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncloseDetail:RemoveClickListener()
	arg_3_0._btntaskClick:RemoveClickListener()
	arg_3_0._btnbossClick:RemoveClickListener()
	TaskDispatcher.cancelTask(arg_3_0.refreshRemainTime, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.DailyReresh, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.OnTowerResetSubEpisode, arg_3_0.refreshUI, arg_3_0)
end

var_0_0.AnimBlockKey = "TowerTimeLimitDetailAnimBlock"
var_0_0.EpisodeScaleAnimTime = 0.5
var_0_0.OpenDetailTime = 0.25
var_0_0.closeDetailTime = 0.167
var_0_0.closeToNormalTime = 0.33
var_0_0.fadeItemAlpha = 0.6

function var_0_0._btncloseDetailOnClick(arg_4_0)
	UIBlockMgr.instance:startBlock(var_0_0.AnimBlock)

	if arg_4_0.isOpenDetail then
		arg_4_0.rootAnimtorPlayer:Play(UIAnimationName.Close, arg_4_0.closeDetailFinish, arg_4_0)
	end

	arg_4_0.isOpenDetail = false

	TowerTimeLimitLevelModel.instance:setCurSelectEntrance(0)
	arg_4_0:setCloseOverrideFunc()
	arg_4_0:refreshDetailShowUI()
	arg_4_0:playCloseItemAnim()

	arg_4_0.lastSelectEntranceId = 0

	gohelper.setActive(arg_4_0._goSwitchEfeect, false)
end

function var_0_0.closeDetailFinish(arg_5_0)
	UIBlockMgr.instance:endBlock(var_0_0.AnimBlock)
	gohelper.setActive(arg_5_0._btncloseDetail.gameObject, false)
end

function var_0_0._btnEpisodeItemClick(arg_6_0, arg_6_1)
	TowerTimeLimitLevelModel.instance:setCurSelectEntrance(arg_6_1.entranceId)

	if not arg_6_0.isOpenDetail then
		UIBlockMgr.instance:startBlock(var_0_0.AnimBlock)
		arg_6_0.rootAnimtorPlayer:Play(UIAnimationName.Open, arg_6_0.openDetailFinish, arg_6_0)
		arg_6_0.viewContainer:getTowerTimeLimitLevelInfoView():refreshUI()
	end

	arg_6_0:playOpenAndSwitchItemAnim(arg_6_1)

	arg_6_0.lastSelectEntranceId = arg_6_1.entranceId
	arg_6_0.isOpenDetail = true

	arg_6_0:setCloseOverrideFunc()
	arg_6_0:refreshDetailShowUI()
end

function var_0_0.openDetailFinish(arg_7_0)
	UIBlockMgr.instance:endBlock(var_0_0.AnimBlock)
	gohelper.setActive(arg_7_0._btncloseDetail.gameObject, true)
end

function var_0_0._btnTaskClick(arg_8_0)
	local var_8_0 = {
		towerType = TowerEnum.TowerType.Limited,
		towerId = arg_8_0.seasonId
	}

	TowerController.instance:openTowerTaskView(var_8_0)
end

function var_0_0._btnBossClick(arg_9_0)
	TowerController.instance:openAssistBossView(nil, nil, TowerEnum.TowerType.Limited, arg_9_0.seasonId)
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0.goRoot = gohelper.findChild(arg_10_0.viewGO, "root")
	arg_10_0.rootAnimtorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_10_0.goRoot)
	arg_10_0.episodeTab = arg_10_0:getUserDataTb_()
	arg_10_0.bossItemTab = arg_10_0:getUserDataTb_()

	arg_10_0:initEpisodeItem()
	TowerTimeLimitLevelModel.instance:initDifficultyMulti()

	arg_10_0.isOpenDetail = false

	gohelper.setActive(arg_10_0._btncloseDetail.gameObject, false)

	arg_10_0.lastSelectEntranceId = 0
end

function var_0_0.initEpisodeItem(arg_11_0)
	for iter_11_0 = 1, 3 do
		local var_11_0 = {
			entranceId = iter_11_0,
			go = gohelper.findChild(arg_11_0.viewGO, "root/main/episodeNode/episode" .. iter_11_0)
		}

		var_11_0.goSelect = gohelper.findChild(var_11_0.go, "go_select")
		var_11_0.goFinish = gohelper.findChild(var_11_0.go, "go_finish")
		var_11_0.goEnemy = gohelper.findChild(var_11_0.go, "go_finish/group/enemy")
		var_11_0.simageEnemy = gohelper.findChildSingleImage(var_11_0.go, "go_finish/group/enemy/simage_enemy")
		var_11_0.goHeroContent = gohelper.findChild(var_11_0.go, "go_finish/group/hero")
		var_11_0.goHeroItem = gohelper.findChild(var_11_0.go, "go_finish/group/hero/heroItem")
		var_11_0.txtScore = gohelper.findChildText(var_11_0.go, "go_finish/score/txt_score")
		var_11_0.btnClick = gohelper.findChildButtonWithAudio(var_11_0.go, "click")

		var_11_0.btnClick:AddClickListener(arg_11_0._btnEpisodeItemClick, arg_11_0, var_11_0)

		var_11_0.curDifficulty = TowerEnum.Difficulty.Easy
		var_11_0.heroItemTab = arg_11_0:getUserDataTb_()
		var_11_0.anim = var_11_0.go:GetComponent(gohelper.Type_Animator)
		var_11_0.canvasGroup = var_11_0.go:GetComponent(gohelper.Type_CanvasGroup)
		var_11_0.canvasGroup.alpha = 1

		gohelper.setActive(var_11_0.goHeroItem, false)
		table.insert(arg_11_0.episodeTab, var_11_0)
	end
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0.onOpen(arg_13_0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_mln_day_night)
	RedDotController.instance:addRedDot(arg_13_0._goTaskReddot, RedDotEnum.DotNode.TowerTask)
	gohelper.setActive(arg_13_0._godetailInfo.gameObject, false)
	arg_13_0:refreshUI()
	arg_13_0:setCloseOverrideFunc()
end

function var_0_0.refreshUI(arg_14_0)
	local var_14_0 = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()

	if var_14_0 then
		arg_14_0.seasonId = var_14_0.towerId

		TowerModel.instance:setLocalPrefsState(TowerEnum.LocalPrefsKey.NewTimeLimitOpen, var_14_0.id, var_14_0, TowerEnum.UnlockKey)
	else
		logError("数据异常，当前没有开启的限时塔")

		return
	end

	arg_14_0:refreshEpisode()
	arg_14_0:refreshTotalScore()
	arg_14_0:refreshRemainTime()
	arg_14_0:refreshAssistBoss()
	TaskDispatcher.cancelTask(arg_14_0.refreshRemainTime, arg_14_0)
	TaskDispatcher.runRepeat(arg_14_0.refreshRemainTime, arg_14_0, 1)
end

function var_0_0.refreshEpisode(arg_15_0)
	local var_15_0 = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Limited, arg_15_0.seasonId)

	arg_15_0.totalScore = 0

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.episodeTab) do
		local var_15_1 = TowerConfig.instance:getTowerLimitedTimeCoList(arg_15_0.seasonId, iter_15_0)[1].layerId
		local var_15_2 = var_15_0:getLayerScore(var_15_1)
		local var_15_3 = var_15_0:getLayerSubEpisodeList(var_15_1)
		local var_15_4 = var_15_3 and var_15_3[1].assistBossId or 0
		local var_15_5 = var_15_3 and var_15_3[1].heroIds or {}
		local var_15_6 = TowerTimeLimitLevelModel.instance.curSelectEntrance

		gohelper.setActive(iter_15_1.goSelect, var_15_6 == iter_15_0)
		gohelper.setActive(iter_15_1.goFinish, var_15_5 and #var_15_5 > 0)
		gohelper.setActive(iter_15_1.goEnemy, var_15_4 > 0)
		gohelper.setActive(iter_15_1.goHeroContent, var_15_5 and #var_15_5 > 0)

		iter_15_1.txtScore.text = var_15_2

		if var_15_4 > 0 then
			local var_15_7 = TowerConfig.instance:getAssistBossConfig(var_15_4)
			local var_15_8 = FightConfig.instance:getSkinCO(var_15_7.skinId)

			iter_15_1.simageEnemy:LoadImage(ResUrl.monsterHeadIcon(var_15_8.headIcon))
		end

		for iter_15_2, iter_15_3 in ipairs(var_15_5) do
			if not iter_15_1.heroItemTab[iter_15_2] then
				iter_15_1.heroItemTab[iter_15_2] = {}
				iter_15_1.heroItemTab[iter_15_2].go = gohelper.clone(iter_15_1.goHeroItem, iter_15_1.goHeroContent, "heroItem" .. iter_15_2)
				iter_15_1.heroItemTab[iter_15_2].simageHero = gohelper.findChildSingleImage(iter_15_1.heroItemTab[iter_15_2].go, "simage_hero")
			end

			gohelper.setActive(iter_15_1.heroItemTab[iter_15_2].go, true)

			local var_15_9 = HeroModel.instance:getByHeroId(iter_15_3)

			if var_15_9 then
				local var_15_10 = FightConfig.instance:getSkinCO(var_15_9.skin)

				iter_15_1.heroItemTab[iter_15_2].simageHero:LoadImage(ResUrl.getHeadIconSmall(var_15_10.retangleIcon))
			else
				logError(iter_15_3 .. " 对应的heroMO不存在，请检查")
			end
		end

		for iter_15_4 = #var_15_5 + 1, #iter_15_1.heroItemTab do
			gohelper.setActive(iter_15_1.heroItemTab[iter_15_4].go, false)
		end

		arg_15_0.totalScore = arg_15_0.totalScore + var_15_2
	end
end

function var_0_0.refreshTotalScore(arg_16_0)
	local var_16_0 = TowerTaskModel.instance.limitTimeTaskList

	arg_16_0.taskFinishCount = TowerTaskModel.instance:getTaskItemRewardCount(var_16_0)

	gohelper.CreateObjList(arg_16_0, arg_16_0.taskProgressShow, var_16_0, arg_16_0._goTaskPointContent, arg_16_0._goTaskPointItem)

	arg_16_0._txtscore.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towertimelimit_curtotalscore"), {
		arg_16_0.totalScore
	})
end

function var_0_0.taskProgressShow(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = gohelper.findChild(arg_17_1, "go_light")

	gohelper.setActive(var_17_0, arg_17_3 <= arg_17_0.taskFinishCount)
end

function var_0_0.refreshRemainTime(arg_18_0)
	local var_18_0 = TowerModel.instance:getTowerOpenInfo(TowerEnum.TowerType.Limited, arg_18_0.seasonId, TowerEnum.TowerStatus.Open).nextTime / 1000 - ServerTime.now()
	local var_18_1 = TimeUtil.getFormatTime(var_18_0)
	local var_18_2 = ""

	arg_18_0._txttime.text = var_18_0 > 0 and GameUtil.getSubPlaceholderLuaLang(luaLang("towertimelimit_refreshtime"), {
		var_18_1,
		var_18_2
	}) or ""
end

function var_0_0.refreshAssistBoss(arg_19_0)
	local var_19_0 = TowerConfig.instance:getTowerLimitedTimeCo(arg_19_0.seasonId)
	local var_19_1 = string.splitToNumber(var_19_0.bossPool, "#")

	arg_19_0.entranceBossUseMap = TowerTimeLimitLevelModel.instance:getEntranceBossUsedMap(arg_19_0.seasonId)

	gohelper.CreateObjList(arg_19_0, arg_19_0.bossItemShow, var_19_1, arg_19_0._gobossContent, arg_19_0._gobossItem)

	if ViewMgr.instance:isOpen(ViewName.TowerAssistBossView) then
		TowerController.instance:openAssistBossView(nil, nil, TowerEnum.TowerType.Limited, arg_19_0.seasonId)
	end
end

function var_0_0.bossItemShow(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = arg_20_0.bossItemTab[arg_20_3]

	if not var_20_0 then
		var_20_0 = {}
		arg_20_0.bossItemTab[arg_20_3] = var_20_0
	end

	var_20_0.go = arg_20_1
	var_20_0.simageEnemy = gohelper.findChildSingleImage(var_20_0.go, "simage_enemy")
	var_20_0.imageCareer = gohelper.findChildImage(var_20_0.go, "image_career")
	var_20_0.goUsed = gohelper.findChild(var_20_0.go, "go_used")
	var_20_0.txtOrder = gohelper.findChildText(var_20_0.go, "go_used/txt_order")

	local var_20_1 = TowerConfig.instance:getAssistBossConfig(arg_20_2)
	local var_20_2 = FightConfig.instance:getSkinCO(var_20_1.skinId)

	var_20_0.simageEnemy:LoadImage(ResUrl.monsterHeadIcon(var_20_2.headIcon))
	UISpriteSetMgr.instance:setEnemyInfoSprite(var_20_0.imageCareer, "sxy_" .. tostring(var_20_1.career))

	local var_20_3 = 0

	for iter_20_0, iter_20_1 in pairs(arg_20_0.entranceBossUseMap) do
		if iter_20_1 == arg_20_2 then
			var_20_3 = iter_20_0

			break
		end
	end

	gohelper.setActive(var_20_0.goUsed, var_20_3 > 0)

	var_20_0.txtOrder.text = var_20_3 > 0 and var_20_3 or ""
end

function var_0_0.refreshDetailShowUI(arg_21_0)
	gohelper.setActive(arg_21_0._godetailInfo.gameObject, arg_21_0.isOpenDetail)
	gohelper.setActive(arg_21_0._goBoss, not arg_21_0.isOpenDetail)
	gohelper.setActive(arg_21_0._btncloseDetail.gameObject, arg_21_0.isOpenDetail)

	local var_21_0 = TowerTimeLimitLevelModel.instance.curSelectEntrance

	for iter_21_0, iter_21_1 in pairs(arg_21_0.episodeTab) do
		gohelper.setActive(iter_21_1.goSelect, iter_21_0 == var_21_0)
	end
end

function var_0_0.playOpenAndSwitchItemAnim(arg_22_0, arg_22_1)
	if arg_22_0.lastSelectEntranceId ~= arg_22_1.entranceId then
		arg_22_1.anim:Play(UIAnimationName.Open, 0, 0)

		if arg_22_0.isOpenDetail then
			if arg_22_0["itemTweenId" .. arg_22_1.entranceId] then
				ZProj.TweenHelper.KillById(arg_22_0["itemTweenId" .. arg_22_1.entranceId])
			end

			arg_22_0["itemTweenId" .. arg_22_1.entranceId] = ZProj.TweenHelper.DOFadeCanvasGroup(arg_22_0.episodeTab[arg_22_1.entranceId].go, var_0_0.fadeItemAlpha, 1, var_0_0.OpenDetailTime)
		end

		if arg_22_0.lastSelectEntranceId ~= 0 then
			arg_22_0.rootAnimtorPlayer:Play(UIAnimationName.Switch)
			arg_22_0.episodeTab[arg_22_0.lastSelectEntranceId].anim:Play(UIAnimationName.Close, 0, 0)

			if arg_22_0["itemTweenId" .. arg_22_0.lastSelectEntranceId] then
				ZProj.TweenHelper.KillById(arg_22_0["itemTweenId" .. arg_22_0.lastSelectEntranceId])
			end

			arg_22_0["itemTweenId" .. arg_22_0.lastSelectEntranceId] = ZProj.TweenHelper.DOFadeCanvasGroup(arg_22_0.episodeTab[arg_22_0.lastSelectEntranceId].go, 1, var_0_0.fadeItemAlpha, var_0_0.closeDetailTime)
		end

		for iter_22_0, iter_22_1 in ipairs(arg_22_0.episodeTab) do
			if arg_22_0.lastSelectEntranceId > 0 then
				if iter_22_0 ~= arg_22_1.entranceId and iter_22_0 ~= arg_22_0.lastSelectEntranceId then
					iter_22_1.anim:Play(UIAnimationName.Idle, 0, 0)

					iter_22_1.canvasGroup.alpha = var_0_0.fadeItemAlpha
				end
			elseif iter_22_0 ~= arg_22_1.entranceId then
				if arg_22_0["itemTweenId" .. iter_22_0] then
					ZProj.TweenHelper.KillById(arg_22_0["itemTweenId" .. iter_22_0])
				end

				arg_22_0["itemTweenId" .. iter_22_0] = ZProj.TweenHelper.DOFadeCanvasGroup(arg_22_0.episodeTab[iter_22_0].go, 1, var_0_0.fadeItemAlpha, var_0_0.OpenDetailTime)
			end
		end
	end
end

function var_0_0.playCloseItemAnim(arg_23_0)
	arg_23_0.episodeTab[arg_23_0.lastSelectEntranceId].anim:Play(UIAnimationName.Close, 0, 0)

	for iter_23_0, iter_23_1 in pairs(arg_23_0.episodeTab) do
		if iter_23_0 ~= arg_23_0.lastSelectEntranceId then
			if arg_23_0["itemTweenId" .. iter_23_0] then
				ZProj.TweenHelper.KillById(arg_23_0["itemTweenId" .. iter_23_0])
			end

			arg_23_0["itemTweenId" .. iter_23_0] = ZProj.TweenHelper.DOFadeCanvasGroup(iter_23_1.go, var_0_0.fadeItemAlpha, 1, var_0_0.closeToNormalTime)
		end
	end
end

function var_0_0.setCloseOverrideFunc(arg_24_0)
	if arg_24_0.isOpenDetail then
		arg_24_0.viewContainer:setOverrideCloseClick(arg_24_0._btncloseDetailOnClick, arg_24_0)
	else
		arg_24_0.viewContainer:setOverrideCloseClick(arg_24_0.closeThis, arg_24_0)
	end
end

function var_0_0.onClose(arg_25_0)
	TowerTimeLimitLevelModel.instance:cleanData()
	arg_25_0.rootAnimtorPlayer:Stop()

	for iter_25_0 = 1, 3 do
		if arg_25_0["itemTweenId" .. iter_25_0] then
			ZProj.TweenHelper.KillById(arg_25_0["itemTweenId" .. iter_25_0])
		end
	end
end

function var_0_0.onDestroyView(arg_26_0)
	for iter_26_0, iter_26_1 in pairs(arg_26_0.episodeTab) do
		iter_26_1.simageEnemy:UnLoadImage()
		iter_26_1.btnClick:RemoveClickListener()

		for iter_26_2, iter_26_3 in pairs(iter_26_1.heroItemTab) do
			iter_26_3.simageHero:UnLoadImage()
		end
	end

	for iter_26_4, iter_26_5 in pairs(arg_26_0.bossItemTab) do
		iter_26_5.simageEnemy:UnLoadImage()
	end
end

return var_0_0
