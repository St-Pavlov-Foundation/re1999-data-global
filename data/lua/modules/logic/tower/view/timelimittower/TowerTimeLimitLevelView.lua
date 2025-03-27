module("modules.logic.tower.view.timelimittower.TowerTimeLimitLevelView", package.seeall)

slot0 = class("TowerTimeLimitLevelView", BaseView)

function slot0.onInitView(slot0)
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "simage_title/timebg/#txt_time")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "score/#simage_icon")
	slot0._goTaskPointContent = gohelper.findChild(slot0.viewGO, "score/#go_taskPointContent")
	slot0._goTaskPointItem = gohelper.findChild(slot0.viewGO, "score/#go_taskPointContent/#go_taskPointItem")
	slot0._txtscore = gohelper.findChildText(slot0.viewGO, "score/#txt_score")
	slot0._btntaskClick = gohelper.findChildButtonWithAudio(slot0.viewGO, "score/#btn_taskClick")
	slot0._goBoss = gohelper.findChild(slot0.viewGO, "root/main/boss")
	slot0._btnbossClick = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/main/boss/#btn_bossClick")
	slot0._gobossContent = gohelper.findChild(slot0.viewGO, "root/main/boss/#go_bossContent")
	slot0._gobossItem = gohelper.findChild(slot0.viewGO, "root/main/boss/#go_bossContent/#go_bossItem")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._btncloseDetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_closeDetail")
	slot0._godetailInfo = gohelper.findChild(slot0.viewGO, "root/#go_detailInfo")
	slot0._goSwitchEfeect = gohelper.findChild(slot0.viewGO, "root/#go_detailInfo/#go_difficulty/index/vx_refresh")
	slot0._goTaskReddot = gohelper.findChild(slot0.viewGO, "score/#go_taskReddot")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncloseDetail:AddClickListener(slot0._btncloseDetailOnClick, slot0)
	slot0._btntaskClick:AddClickListener(slot0._btnTaskClick, slot0)
	slot0._btnbossClick:AddClickListener(slot0._btnBossClick, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.DailyReresh, slot0.refreshUI, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.OnTowerResetSubEpisode, slot0.refreshUI, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncloseDetail:RemoveClickListener()
	slot0._btntaskClick:RemoveClickListener()
	slot0._btnbossClick:RemoveClickListener()
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.DailyReresh, slot0.refreshUI, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.OnTowerResetSubEpisode, slot0.refreshUI, slot0)
end

slot0.AnimBlockKey = "TowerTimeLimitDetailAnimBlock"
slot0.EpisodeScaleAnimTime = 0.5
slot0.OpenDetailTime = 0.25
slot0.closeDetailTime = 0.167
slot0.closeToNormalTime = 0.33
slot0.fadeItemAlpha = 0.6

function slot0._btncloseDetailOnClick(slot0)
	UIBlockMgr.instance:startBlock(uv0.AnimBlock)

	if slot0.isOpenDetail then
		slot0.rootAnimtorPlayer:Play(UIAnimationName.Close, slot0.closeDetailFinish, slot0)
	end

	slot0.isOpenDetail = false

	TowerTimeLimitLevelModel.instance:setCurSelectEntrance(0)
	slot0:setCloseOverrideFunc()
	slot0:refreshDetailShowUI()
	slot0:playCloseItemAnim()

	slot0.lastSelectEntranceId = 0

	gohelper.setActive(slot0._goSwitchEfeect, false)
end

function slot0.closeDetailFinish(slot0)
	UIBlockMgr.instance:endBlock(uv0.AnimBlock)
	gohelper.setActive(slot0._btncloseDetail.gameObject, false)
end

function slot0._btnEpisodeItemClick(slot0, slot1)
	TowerTimeLimitLevelModel.instance:setCurSelectEntrance(slot1.entranceId)

	if not slot0.isOpenDetail then
		UIBlockMgr.instance:startBlock(uv0.AnimBlock)
		slot0.rootAnimtorPlayer:Play(UIAnimationName.Open, slot0.openDetailFinish, slot0)
		slot0.viewContainer:getTowerTimeLimitLevelInfoView():refreshUI()
	end

	slot0:playOpenAndSwitchItemAnim(slot1)

	slot0.lastSelectEntranceId = slot1.entranceId
	slot0.isOpenDetail = true

	slot0:setCloseOverrideFunc()
	slot0:refreshDetailShowUI()
end

function slot0.openDetailFinish(slot0)
	UIBlockMgr.instance:endBlock(uv0.AnimBlock)
	gohelper.setActive(slot0._btncloseDetail.gameObject, true)
end

function slot0._btnTaskClick(slot0)
	TowerController.instance:openTowerTaskView({
		towerType = TowerEnum.TowerType.Limited,
		towerId = slot0.seasonId
	})
end

function slot0._btnBossClick(slot0)
	TowerController.instance:openAssistBossView(nil, , TowerEnum.TowerType.Limited, slot0.seasonId)
end

function slot0._editableInitView(slot0)
	slot0.goRoot = gohelper.findChild(slot0.viewGO, "root")
	slot0.rootAnimtorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0.goRoot)
	slot0.episodeTab = slot0:getUserDataTb_()
	slot0.bossItemTab = slot0:getUserDataTb_()

	slot0:initEpisodeItem()
	TowerTimeLimitLevelModel.instance:initDifficultyMulti()

	slot0.isOpenDetail = false

	gohelper.setActive(slot0._btncloseDetail.gameObject, false)

	slot0.lastSelectEntranceId = 0
end

function slot0.initEpisodeItem(slot0)
	for slot4 = 1, 3 do
		slot5 = {
			entranceId = slot4,
			go = gohelper.findChild(slot0.viewGO, "root/main/episodeNode/episode" .. slot4)
		}
		slot5.goSelect = gohelper.findChild(slot5.go, "go_select")
		slot5.goFinish = gohelper.findChild(slot5.go, "go_finish")
		slot5.goEnemy = gohelper.findChild(slot5.go, "go_finish/group/enemy")
		slot5.simageEnemy = gohelper.findChildSingleImage(slot5.go, "go_finish/group/enemy/simage_enemy")
		slot5.goHeroContent = gohelper.findChild(slot5.go, "go_finish/group/hero")
		slot5.goHeroItem = gohelper.findChild(slot5.go, "go_finish/group/hero/heroItem")
		slot5.txtScore = gohelper.findChildText(slot5.go, "go_finish/score/txt_score")
		slot5.btnClick = gohelper.findChildButtonWithAudio(slot5.go, "click")

		slot5.btnClick:AddClickListener(slot0._btnEpisodeItemClick, slot0, slot5)

		slot5.curDifficulty = TowerEnum.Difficulty.Easy
		slot5.heroItemTab = slot0:getUserDataTb_()
		slot5.anim = slot5.go:GetComponent(gohelper.Type_Animator)
		slot5.canvasGroup = slot5.go:GetComponent(gohelper.Type_CanvasGroup)
		slot5.canvasGroup.alpha = 1

		gohelper.setActive(slot5.goHeroItem, false)
		table.insert(slot0.episodeTab, slot5)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_mln_day_night)
	RedDotController.instance:addRedDot(slot0._goTaskReddot, RedDotEnum.DotNode.TowerTask)
	gohelper.setActive(slot0._godetailInfo.gameObject, false)
	slot0:refreshUI()
	slot0:setCloseOverrideFunc()
end

function slot0.refreshUI(slot0)
	if TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower() then
		slot0.seasonId = slot1.towerId

		TowerModel.instance:setLocalPrefsState(TowerEnum.LocalPrefsKey.NewTimeLimitOpen, slot1.id, slot1, TowerEnum.UnlockKey)
	else
		logError("数据异常，当前没有开启的限时塔")

		return
	end

	slot0:refreshEpisode()
	slot0:refreshTotalScore()
	slot0:refreshRemainTime()
	slot0:refreshAssistBoss()
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
	TaskDispatcher.runRepeat(slot0.refreshRemainTime, slot0, 1)
end

function slot0.refreshEpisode(slot0)
	slot1 = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Limited, slot0.seasonId)
	slot0.totalScore = 0

	for slot5, slot6 in ipairs(slot0.episodeTab) do
		slot8 = TowerConfig.instance:getTowerLimitedTimeCoList(slot0.seasonId, slot5)[1].layerId
		slot11 = slot1:getLayerSubEpisodeList(slot8) and slot10[1].assistBossId or 0
		slot12 = slot10 and slot10[1].heroIds or {}

		gohelper.setActive(slot6.goSelect, TowerTimeLimitLevelModel.instance.curSelectEntrance == slot5)
		gohelper.setActive(slot6.goFinish, slot12 and #slot12 > 0)
		gohelper.setActive(slot6.goEnemy, slot11 > 0)
		gohelper.setActive(slot6.goHeroContent, slot12 and #slot12 > 0)

		slot6.txtScore.text = slot1:getLayerScore(slot8)

		if slot11 > 0 then
			slot6.simageEnemy:LoadImage(ResUrl.monsterHeadIcon(FightConfig.instance:getSkinCO(TowerConfig.instance:getAssistBossConfig(slot11).skinId).headIcon))
		end

		for slot17, slot18 in ipairs(slot12) do
			if not slot6.heroItemTab[slot17] then
				slot6.heroItemTab[slot17] = {
					go = gohelper.clone(slot6.goHeroItem, slot6.goHeroContent, "heroItem" .. slot17)
				}
				slot6.heroItemTab[slot17].simageHero = gohelper.findChildSingleImage(slot6.heroItemTab[slot17].go, "simage_hero")
			end

			gohelper.setActive(slot6.heroItemTab[slot17].go, true)

			if HeroModel.instance:getByHeroId(slot18) then
				slot6.heroItemTab[slot17].simageHero:LoadImage(ResUrl.getHeadIconSmall(FightConfig.instance:getSkinCO(slot19.skin).retangleIcon))
			else
				logError(slot18 .. " 对应的heroMO不存在，请检查")
			end
		end

		for slot17 = #slot12 + 1, #slot6.heroItemTab do
			gohelper.setActive(slot6.heroItemTab[slot17].go, false)
		end

		slot0.totalScore = slot0.totalScore + slot9
	end
end

function slot0.refreshTotalScore(slot0)
	slot1 = TowerTaskModel.instance.limitTimeTaskList
	slot0.taskFinishCount = TowerTaskModel.instance:getTaskItemRewardCount(slot1)

	gohelper.CreateObjList(slot0, slot0.taskProgressShow, slot1, slot0._goTaskPointContent, slot0._goTaskPointItem)

	slot0._txtscore.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towertimelimit_curtotalscore"), {
		slot0.totalScore
	})
end

function slot0.taskProgressShow(slot0, slot1, slot2, slot3)
	gohelper.setActive(gohelper.findChild(slot1, "go_light"), slot3 <= slot0.taskFinishCount)
end

function slot0.refreshRemainTime(slot0)
	slot2 = TowerModel.instance:getTowerOpenInfo(TowerEnum.TowerType.Limited, slot0.seasonId, TowerEnum.TowerStatus.Open).nextTime / 1000 - ServerTime.now()
	slot0._txttime.text = slot2 > 0 and GameUtil.getSubPlaceholderLuaLang(luaLang("towertimelimit_refreshtime"), {
		TimeUtil.getFormatTime(slot2),
		""
	}) or ""
end

function slot0.refreshAssistBoss(slot0)
	slot0.entranceBossUseMap = TowerTimeLimitLevelModel.instance:getEntranceBossUsedMap(slot0.seasonId)

	gohelper.CreateObjList(slot0, slot0.bossItemShow, string.splitToNumber(TowerConfig.instance:getTowerLimitedTimeCo(slot0.seasonId).bossPool, "#"), slot0._gobossContent, slot0._gobossItem)

	if ViewMgr.instance:isOpen(ViewName.TowerAssistBossView) then
		TowerController.instance:openAssistBossView(nil, , TowerEnum.TowerType.Limited, slot0.seasonId)
	end
end

function slot0.bossItemShow(slot0, slot1, slot2, slot3)
	if not slot0.bossItemTab[slot3] then
		slot0.bossItemTab[slot3] = {}
	end

	slot4.go = slot1
	slot4.simageEnemy = gohelper.findChildSingleImage(slot4.go, "simage_enemy")
	slot4.imageCareer = gohelper.findChildImage(slot4.go, "image_career")
	slot4.goUsed = gohelper.findChild(slot4.go, "go_used")
	slot4.txtOrder = gohelper.findChildText(slot4.go, "go_used/txt_order")
	slot5 = TowerConfig.instance:getAssistBossConfig(slot2)

	slot4.simageEnemy:LoadImage(ResUrl.monsterHeadIcon(FightConfig.instance:getSkinCO(slot5.skinId).headIcon))

	slot12 = slot5.career
	slot11 = tostring(slot12)

	UISpriteSetMgr.instance:setEnemyInfoSprite(slot4.imageCareer, "sxy_" .. slot11)

	slot7 = 0

	for slot11, slot12 in pairs(slot0.entranceBossUseMap) do
		if slot12 == slot2 then
			slot7 = slot11

			break
		end
	end

	gohelper.setActive(slot4.goUsed, slot7 > 0)

	slot4.txtOrder.text = slot7 > 0 and slot7 or ""
end

function slot0.refreshDetailShowUI(slot0)
	gohelper.setActive(slot0._godetailInfo.gameObject, slot0.isOpenDetail)
	gohelper.setActive(slot0._goBoss, not slot0.isOpenDetail)
	gohelper.setActive(slot0._btncloseDetail.gameObject, slot0.isOpenDetail)

	for slot5, slot6 in pairs(slot0.episodeTab) do
		gohelper.setActive(slot6.goSelect, slot5 == TowerTimeLimitLevelModel.instance.curSelectEntrance)
	end
end

function slot0.playOpenAndSwitchItemAnim(slot0, slot1)
	if slot0.lastSelectEntranceId ~= slot1.entranceId then
		slot1.anim:Play(UIAnimationName.Open, 0, 0)

		if slot0.isOpenDetail then
			if slot0["itemTweenId" .. slot1.entranceId] then
				ZProj.TweenHelper.KillById(slot0["itemTweenId" .. slot1.entranceId])
			end

			slot0["itemTweenId" .. slot1.entranceId] = ZProj.TweenHelper.DOFadeCanvasGroup(slot0.episodeTab[slot1.entranceId].go, uv0.fadeItemAlpha, 1, uv0.OpenDetailTime)
		end

		if slot0.lastSelectEntranceId ~= 0 then
			slot0.rootAnimtorPlayer:Play(UIAnimationName.Switch)
			slot0.episodeTab[slot0.lastSelectEntranceId].anim:Play(UIAnimationName.Close, 0, 0)

			if slot0["itemTweenId" .. slot0.lastSelectEntranceId] then
				ZProj.TweenHelper.KillById(slot0["itemTweenId" .. slot0.lastSelectEntranceId])
			end

			slot0["itemTweenId" .. slot0.lastSelectEntranceId] = ZProj.TweenHelper.DOFadeCanvasGroup(slot0.episodeTab[slot0.lastSelectEntranceId].go, 1, uv0.fadeItemAlpha, uv0.closeDetailTime)
		end

		for slot5, slot6 in ipairs(slot0.episodeTab) do
			if slot0.lastSelectEntranceId > 0 then
				if slot5 ~= slot1.entranceId and slot5 ~= slot0.lastSelectEntranceId then
					slot6.anim:Play(UIAnimationName.Idle, 0, 0)

					slot6.canvasGroup.alpha = uv0.fadeItemAlpha
				end
			elseif slot5 ~= slot1.entranceId then
				if slot0["itemTweenId" .. slot5] then
					ZProj.TweenHelper.KillById(slot0["itemTweenId" .. slot5])
				end

				slot0["itemTweenId" .. slot5] = ZProj.TweenHelper.DOFadeCanvasGroup(slot0.episodeTab[slot5].go, 1, uv0.fadeItemAlpha, uv0.OpenDetailTime)
			end
		end
	end
end

function slot0.playCloseItemAnim(slot0)
	slot4 = 0
	slot5 = 0

	slot0.episodeTab[slot0.lastSelectEntranceId].anim:Play(UIAnimationName.Close, slot4, slot5)

	for slot4, slot5 in pairs(slot0.episodeTab) do
		if slot4 ~= slot0.lastSelectEntranceId then
			if slot0["itemTweenId" .. slot4] then
				ZProj.TweenHelper.KillById(slot0["itemTweenId" .. slot4])
			end

			slot0["itemTweenId" .. slot4] = ZProj.TweenHelper.DOFadeCanvasGroup(slot5.go, uv0.fadeItemAlpha, 1, uv0.closeToNormalTime)
		end
	end
end

function slot0.setCloseOverrideFunc(slot0)
	if slot0.isOpenDetail then
		slot0.viewContainer:setOverrideCloseClick(slot0._btncloseDetailOnClick, slot0)
	else
		slot0.viewContainer:setOverrideCloseClick(slot0.closeThis, slot0)
	end
end

function slot0.onClose(slot0)
	TowerTimeLimitLevelModel.instance:cleanData()
	slot0.rootAnimtorPlayer:Stop()

	for slot4 = 1, 3 do
		if slot0["itemTweenId" .. slot4] then
			ZProj.TweenHelper.KillById(slot0["itemTweenId" .. slot4])
		end
	end
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0.episodeTab) do
		slot5.simageEnemy:UnLoadImage()
		slot5.btnClick:RemoveClickListener()

		for slot9, slot10 in pairs(slot5.heroItemTab) do
			slot10.simageHero:UnLoadImage()
		end
	end

	for slot4, slot5 in pairs(slot0.bossItemTab) do
		slot5.simageEnemy:UnLoadImage()
	end
end

return slot0
