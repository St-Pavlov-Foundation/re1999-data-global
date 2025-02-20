module("modules.logic.versionactivity1_2.versionactivity1_2dungeonbase.view.VersionActivity1_2DungeonMapLevelBaseView", package.seeall)

slot0 = class("VersionActivity1_2DungeonMapLevelBaseView", BaseView)

function slot0._btnreplayStoryOnClick(slot0)
	if not slot0.storyIdList or #slot0.storyIdList < 1 then
		return
	end

	StoryController.instance:playStories(slot0.storyIdList)
end

function slot0.refreshStoryIdList(slot0)
	if slot0._episode_list[1].type == DungeonEnum.EpisodeType.Story then
		slot0.storyIdList = nil

		return
	end

	if slot0.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard then
		slot0.storyIdList = nil

		return
	end

	slot0.storyIdList = {}

	if slot1.beforeStory > 0 and StoryModel.instance:isStoryHasPlayed(slot1.beforeStory) then
		table.insert(slot0.storyIdList, slot1.beforeStory)
	end

	if slot1.afterStory > 0 and StoryModel.instance:isStoryHasPlayed(slot1.afterStory) then
		table.insert(slot0.storyIdList, slot1.afterStory)
	end
end

function slot0._btncloseviewOnClick(slot0)
	slot0:startCloseTaskNextFrame()
end

function slot0.startCloseTaskNextFrame(slot0)
	TaskDispatcher.runDelay(slot0.reallyClose, slot0, 0.01)
end

function slot0.cancelStartCloseTask(slot0)
	TaskDispatcher.cancelTask(slot0.reallyClose, slot0)
end

function slot0.reallyClose(slot0)
	slot0:closeThis()
end

function slot0._btnleftarrowOnClick(slot0)
	if slot0.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard then
		return
	end

	if #slot0._episode_list == 1 then
		return
	end

	if slot0._cur_select_index <= 1 then
		return
	end

	slot0._cur_select_index = slot0._cur_select_index - 1

	slot0:refreshUIByMode(slot0._cur_select_index)
end

function slot0._btnrightarrowOnClick(slot0)
	if slot0.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard then
		return
	end

	if #slot0._episode_list == 1 then
		return
	end

	if slot0._cur_select_index >= #slot0._episode_list then
		return
	end

	slot0._cur_select_index = slot0._cur_select_index + 1

	slot0:refreshUIByMode(slot0._cur_select_index)
end

function slot0.refreshUIByMode(slot0, slot1)
	slot0.animator:Play("switch", 0, 0)
	slot0:_refreshSelectData(slot1)
	slot0:refreshUI()
end

function slot0._refreshSelectData(slot0, slot1)
	slot0.showEpisodeCo = slot0._episode_list[slot1]

	if not slot0.showEpisodeCo then
		slot0._cur_select_index = 1
		slot0.showEpisodeCo = slot0._episode_list[slot0._cur_select_index]
	end

	slot0.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(slot0.showEpisodeCo.id)

	if not slot0.showEpisodeMo then
		slot0.showEpisodeMo = UserDungeonMO.New()

		slot0.showEpisodeMo:initFromManual(slot0.showEpisodeCo.chapterId, slot0.showEpisodeCo.id, 0, 0)
	end

	slot0._chapterConfig = DungeonConfig.instance:getChapterCO(slot0.showEpisodeCo.chapterId)
	slot0.modeCanFight = DungeonModel.instance:hasPassLevelAndStory(slot0.showEpisodeCo.preEpisode) and DungeonModel.instance:isFinishElementList(slot0.showEpisodeCo)

	gohelper.setActive(slot0._gorecommond, FightHelper.getEpisodeRecommendLevel(slot0.showEpisodeCo.id) > 0)

	if slot2 > 0 then
		slot0._txtrecommondlv.text = HeroConfig.instance:getCommonLevelDisplay(slot2)
	end

	gohelper.setActive(slot0._golock, not DungeonModel.instance:isUnlock(slot0.showEpisodeCo))
	slot0._lockAni:Play("idle")
end

function slot0._btnactivityrewardOnClick(slot0)
	DungeonController.instance:openDungeonRewardView(slot0.showEpisodeCo)
end

function slot0._btnnormalStartOnClick(slot0)
	if not slot0.modeCanFight then
		GameFacade.showToast(ToastEnum.VersionActivityCanFight, slot0:getPreModeName())

		return
	end

	slot0:startBattle()
end

function slot0._btnhardStartOnClick(slot0)
	slot0:startBattle()
end

function slot0._btncloseruleOnClick(slot0)
end

function slot0.startBattle(slot0)
	if slot0.showEpisodeCo.type == DungeonEnum.EpisodeType.Story then
		slot0:_playMainStory()

		return
	end

	if DungeonModel.instance:hasPassLevelAndStory(slot0.showEpisodeCo.id) then
		slot0:_enterFight()

		return
	end

	if slot0.showEpisodeCo.beforeStory > 0 and not StoryModel.instance:isStoryFinished(slot0.showEpisodeCo.beforeStory) then
		slot0:_playStoryAndEnterFight(slot0.showEpisodeCo.beforeStory)

		return
	end

	if slot0.showEpisodeMo.star <= DungeonEnum.StarType.None then
		slot0:_enterFight()

		return
	end

	if slot0.showEpisodeCo.afterStory > 0 and not StoryModel.instance:isStoryFinished(slot0.showEpisodeCo.afterStory) then
		slot0:playAfterStory(slot0.showEpisodeCo.afterStory)

		return
	end

	slot0:_enterFight()
end

function slot0._playMainStory(slot0)
	DungeonRpc.instance:sendStartDungeonRequest(slot0.showEpisodeCo.chapterId, slot0.showEpisodeCo.id)
	StoryController.instance:playStory(slot0.showEpisodeCo.beforeStory, {
		mark = true,
		episodeId = slot0.showEpisodeCo.id
	}, slot0.onStoryFinished, slot0)
end

function slot0.playAfterStory(slot0, slot1)
	StoryController.instance:playStory(slot1, {
		mark = true,
		episodeId = slot0.showEpisodeCo.id
	}, function ()
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo, nil)

		DungeonMapModel.instance.playAfterStory = true

		uv0:closeThis()
	end, slot0)
end

function slot0._playStoryAndEnterFight(slot0, slot1)
	if StoryModel.instance:isStoryFinished(slot1) then
		slot0:_enterFight()

		return
	end

	StoryController.instance:playStory(slot1, {
		mark = true,
		episodeId = slot0.showEpisodeCo.id
	}, slot0._enterFight, slot0)
end

function slot0._enterFight(slot0)
	for slot4, slot5 in ipairs(slot0._episode_list) do
		uv0.setlastBattleEpisodeId2Index(slot5.id, slot0._cur_select_index)
	end

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.enterFight, slot0._episode_list[1].id)

	DungeonModel.instance.versionActivityChapterType = DungeonConfig.instance:getChapterTypeByEpisodeId(slot0.showEpisodeCo.id)

	DungeonFightController.instance:enterFight(slot0.showEpisodeCo.chapterId, slot0.showEpisodeCo.id, 1)
end

function slot0.getlastBattleEpisodeId2Index(slot0)
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2LastBattleEpisodeId2Index .. "_" .. slot0, 1)
end

function slot0.setlastBattleEpisodeId2Index(slot0, slot1)
	return PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2LastBattleEpisodeId2Index .. "_" .. slot0, slot1)
end

function slot0.onStoryFinished(slot0)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(slot0.showEpisodeCo.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
	slot0:closeThis()
end

function slot0._onClueFlowDone(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goactivityrewarditem, false)

	slot0.storyGoType = slot0._gotype1
	slot0.story3GoType = slot0._gotype2
	slot0.story4GoType = slot0._gotype3
	slot0.hardGoType = slot0._gotype4
	slot0.rewardItems = {}

	slot0._simageactivitynormalbg:LoadImage(ResUrl.getVersionActivityDungeon_1_2("bg002"))
	slot0._simageactivityhardbg:LoadImage(ResUrl.getVersionActivityDungeon_1_2("bg003"))

	slot0.goVersionActivity = gohelper.findChild(slot0.viewGO, "anim/versionactivity")
	slot0.animator = slot0.goVersionActivity:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.onUpdateParam(slot0)
	gohelper.setActive(slot0.viewGO, false)
	gohelper.setActive(slot0.viewGO, true)
	slot0:onOpen()
end

function slot0.onOpen(slot0)
	slot0.showEpisodeCo = DungeonConfig.instance:getEpisodeCO(slot0.viewParam.episodeId)
	slot0.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(slot0.viewParam.episodeId)
	slot0.isFromJump = slot0.viewParam.isJump

	slot0:initMode()

	slot0.modeCanFight = true

	slot0:refreshStoryIdList()
	slot0:refreshBg()
	slot0:refreshUI()
	VersionActivity1_2DungeonController.instance:setDungeonSelectedEpisodeId(slot0._episode_list[1].id)
end

function slot0.getEpisodeUnlockAniFinish(slot0)
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2EpisodeUnlockAniFinish .. "_" .. slot0, 0)
end

function slot0.setEpisodeUnlockAniFinish(slot0)
	return PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2EpisodeUnlockAniFinish .. "_" .. slot0, 1)
end

function slot0.initMode(slot0)
	slot1 = uv0.getlastBattleEpisodeId2Index(slot0.showEpisodeCo.id)
	slot0.mode = VersionActivity1_2DungeonEnum.DungeonChapterId2UIModel[slot0.showEpisodeCo.chapterId]
	slot0._episode_list = {}
	slot0._playUnlockAniIndex = nil
	slot2 = DungeonConfig.instance:get1_2VersionActivityEpisodeCoList(slot0.showEpisodeCo.id)
	slot5 = DungeonConfig.instance
	slot7 = slot5

	for slot6, slot7 in ipairs(slot5.get1_2VersionActivityEpisodeCoList(slot7, slot0.showEpisodeCo.id)) do
		table.insert(slot0._episode_list, DungeonConfig.instance:getEpisodeCO(slot7))
	end

	if slot0.isFromJump then
		if DungeonModel.instance:isUnlock(slot0.showEpisodeCo) then
			for slot7, slot8 in ipairs(slot0._episode_list) do
				if slot8.id == slot0.showEpisodeCo.id then
					slot0._cur_select_index = slot7

					break
				end
			end

			if not slot0._playUnlockAniIndex and uv0.getEpisodeUnlockAniFinish(slot0.showEpisodeCo.id) == 0 then
				slot0._playUnlockAniIndex = slot0._cur_select_index

				uv0.setEpisodeUnlockAniFinish(slot0.showEpisodeCo.id)
			end
		end
	else
		for slot6, slot7 in ipairs(slot2) do
			if slot6 > 1 and DungeonModel.instance:isUnlock(DungeonConfig.instance:getEpisodeCO(slot7)) then
				if not slot0._playUnlockAniIndex and uv0.getEpisodeUnlockAniFinish(slot7) == 0 then
					slot0._playUnlockAniIndex = slot6
					slot0._cur_select_index = slot6

					uv0.setEpisodeUnlockAniFinish(slot7)
				end
			end
		end
	end

	slot0._cur_select_index = slot0._cur_select_index or slot1

	slot0:_refreshSelectData(slot0._cur_select_index)

	if slot0._playUnlockAniIndex then
		gohelper.setActive(slot0._golock, true)
		slot0._lockAni:Play("unlock")
		TaskDispatcher.runDelay(slot0._playUnlockAudio, slot0, 1)
	end
end

function slot0._playUnlockAudio(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)
end

function slot0.refreshBg(slot0)
	gohelper.setActive(slot0._simageactivitynormalbg.gameObject, slot0.mode ~= VersionActivity1_2DungeonEnum.DungeonMode.Hard)
	gohelper.setActive(slot0._simageactivityhardbg.gameObject, slot0.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard)
end

function slot0.refreshUI(slot0)
	slot0:refreshEpisodeTextInfo()
	slot0:refreshStar()
	slot0:refreshMode()
	slot0:refreshArrow()
	slot0:refreshReward()
	slot0:refreshStartBtn()
end

function slot0.refreshEpisodeTextInfo(slot0)
	slot0._txtmapName.text = slot0:buildEpisodeName()
	slot0._txtmapNameEn.text = slot0.showEpisodeCo.name_En
	slot0._txtmapNum.text = string.format("%02d", VersionActivity1_2DungeonConfig.instance:getEpisodeIndex(slot0.showEpisodeCo.id))
	slot0._txtactivitydesc.text = slot0.showEpisodeCo.desc
end

function slot0.refreshStar(slot0)
	slot0:setImage(slot0._imagestar1, slot0.showEpisodeCo.id and DungeonModel.instance:hasPassLevelAndStory(slot1))

	if string.nilorempty(DungeonConfig.instance:getEpisodeAdvancedConditionText(slot1)) then
		gohelper.setActive(slot0._imagestar2.gameObject, false)
	else
		slot0:setImage(slot0._imagestar2, DungeonEnum.StarType.Advanced <= slot0.showEpisodeMo.star)
	end
end

function slot0.refreshMode(slot0)
	gohelper.setActive(slot0.storyGoType, slot0.mode ~= VersionActivity1_2DungeonEnum.DungeonMode.Hard and slot0._cur_select_index == 1)
	gohelper.setActive(slot0.story3GoType, slot0.mode ~= VersionActivity1_2DungeonEnum.DungeonMode.Hard and slot0._cur_select_index == 2)
	gohelper.setActive(slot0.story4GoType, slot0.mode ~= VersionActivity1_2DungeonEnum.DungeonMode.Hard and slot0._cur_select_index == 3)
	gohelper.setActive(slot0.hardGoType, slot0.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard)
end

function slot0.refreshArrow(slot0)
	slot1 = slot0.mode ~= VersionActivity1_2DungeonEnum.DungeonMode.Hard and #slot0._episode_list > 1

	gohelper.setActive(slot0._btnleftarrow.gameObject, slot1)
	gohelper.setActive(slot0._btnrightarrow.gameObject, slot1)

	if slot1 then
		slot0._leftArrow = slot0._leftArrow or gohelper.findChildImage(slot0._btnleftarrow.gameObject, "left_arrow")
		slot0._rightArrow = slot0._rightArrow or gohelper.findChildImage(slot0._btnrightarrow.gameObject, "right_arrow")

		SLFramework.UGUI.GuiHelper.SetColor(slot0._leftArrow, slot0._cur_select_index == 1 and "#8C8C8C" or "#FFFFFF")
		SLFramework.UGUI.GuiHelper.SetColor(slot0._rightArrow, slot0._cur_select_index == #slot0._episode_list and "#8C8C8C" or "#FFFFFF")
	end
end

function slot0.refreshReward(slot0)
	slot1 = {}
	slot2 = 0
	slot3 = 0

	if slot0.showEpisodeMo and slot0.showEpisodeMo.star ~= DungeonEnum.StarType.Advanced then
		tabletool.addValues(slot1, DungeonModel.instance:getEpisodeAdvancedBonus(slot0.showEpisodeCo.id))

		slot3 = #slot1
	end

	if slot0.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard then
		tabletool.addValues(slot1, DungeonModel.instance:getEpisodeFirstBonus(slot0.showEpisodeCo.id))

		slot2 = #slot1
	elseif slot0.showEpisodeMo and slot0.showEpisodeMo.star == DungeonEnum.StarType.None then
		tabletool.addValues(slot1, DungeonModel.instance:getEpisodeFirstBonus(slot0.showEpisodeCo.id))

		slot2 = #slot1
	end

	tabletool.addValues(slot1, DungeonModel.instance:getEpisodeRewardDisplayList(slot0.showEpisodeCo.id))
	gohelper.setActive(slot0._gorewards, #slot1 > 0)
	gohelper.setActive(slot0._gonorewards, slot4 == 0)

	if slot4 == 0 then
		return
	end

	slot6, slot7 = nil

	for slot11 = 1, math.min(#slot1, 3) do
		if not slot0.rewardItems[slot11] then
			slot7 = slot0:getUserDataTb_()
			slot7.go = gohelper.cloneInPlace(slot0._goactivityrewarditem, "item" .. slot11)
			slot7.iconItem = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(slot7.go, "itemicon"))
			slot7.gorare = gohelper.findChild(slot7.go, "rare")
			slot7.gonormal = gohelper.findChild(slot7.go, "rare/#go_rare1")
			slot7.gofirst = gohelper.findChild(slot7.go, "rare/#go_rare2")
			slot7.goadvance = gohelper.findChild(slot7.go, "rare/#go_rare3")
			slot7.gofirsthard = gohelper.findChild(slot7.go, "rare/#go_rare4")
			slot7.txtnormal = gohelper.findChildText(slot7.go, "rare/#go_rare1/txt")
			slot7.count = gohelper.findChildText(slot7.go, "countbg/count")
			slot7.countBg = gohelper.findChild(slot7.go, "countbg")
			slot7.got = gohelper.findChild(slot7.go, "got")

			table.insert(slot0.rewardItems, slot7)
		end

		gohelper.setActive(slot7.gonormal, false)
		gohelper.setActive(slot7.gofirst, false)
		gohelper.setActive(slot7.goadvance, false)
		gohelper.setActive(slot7.gofirsthard, false)
		gohelper.setActive(slot7.got, false)
		gohelper.setActive(slot7.gorare, true)

		slot12, slot13 = nil
		slot14 = slot1[slot11][3]
		slot15 = true

		if slot0.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard then
			slot12 = slot7.gofirsthard
			slot13 = slot7.goadvance
		else
			slot12 = slot7.gofirst
			slot13 = slot7.goadvance
		end

		if slot11 <= slot3 then
			gohelper.setActive(slot13, true)
		elseif slot11 <= slot2 then
			gohelper.setActive(slot12, true)
		else
			gohelper.setActive(slot7.gonormal, true)

			slot7.txtnormal.text = luaLang("dungeon_prob_flag" .. slot6[3])

			if #slot6 >= 4 then
				slot14 = slot6[4]
			else
				slot15 = false
			end
		end

		gohelper.setActive(slot7.countBg, slot15)

		slot7.count.text = slot15 and slot14 or ""

		slot7.iconItem:setMOValue(slot6[1], slot6[2], slot14, nil, true)
		slot7.iconItem:setCountFontSize(0)
		slot7.iconItem:setHideLvAndBreakFlag(true)
		slot7.iconItem:hideEquipLvAndBreak(true)
		slot7.iconItem:isShowCount(slot15)

		if DungeonModel.instance:hasPassLevelAndStory(slot0.showEpisodeCo.id) and slot0.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard then
			gohelper.setActive(slot7.got, true)
			gohelper.setActive(slot7.gorare, false)
		end

		gohelper.setActive(slot7.go, true)
	end

	for slot11 = slot5 + 1, #slot0.rewardItems do
		gohelper.setActive(slot0.rewardItems[slot11].go, false)
	end
end

function slot0.refreshStartBtn(slot0)
	slot1 = 0

	if not string.nilorempty(slot0.showEpisodeCo.cost) then
		slot1 = string.splitToNumber(slot0.showEpisodeCo.cost, "#")[3]
	end

	if slot0._simagepower then
		slot0._simagepower:LoadImage(ResUrl.getCurrencyItemIcon(CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power).icon))
	end

	if slot0._simagepower2 then
		slot0._simagepower2:LoadImage(slot3)
	end

	slot0._txtusepowernormal.text = "-" .. slot1
	slot0._txtusepowernormal2.text = "-" .. slot1
	slot0._txtusepowerhard.text = "-" .. slot1

	if slot1 <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtusepowernormal, "#ACCB8C")
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtusepowernormal2, "#ACCB8C")
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtusepowerhard, "#FFB7B7")
	else
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtusepowernormal, "#800015")
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtusepowernormal2, "#800015")
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtusepowerhard, "#C44945")
	end

	slot4 = DungeonModel.instance:hasPassLevelAndStory(slot0._episode_list[1].id) and slot0.storyIdList and #slot0.storyIdList > 0

	if slot0._btnreplayStory then
		gohelper.setActive(slot0._btnreplayStory.gameObject, slot4)
	end

	gohelper.setActive(slot0._btnnormalStart.gameObject, slot0.mode ~= VersionActivity1_2DungeonEnum.DungeonMode.Hard and not slot4)
	gohelper.setActive(slot0._btnnormalStart2.gameObject, slot0.mode ~= VersionActivity1_2DungeonEnum.DungeonMode.Hard and slot4)
	gohelper.setActive(slot0._btnhardStart.gameObject, slot0.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard)

	if DungeonModel.instance:hasPassLevel(slot0.showEpisodeCo.id) and slot0.showEpisodeCo.afterStory > 0 and not StoryModel.instance:isStoryFinished(slot0.showEpisodeCo.afterStory) then
		slot0._txtnorstarttext.text = luaLang("p_dungeonlevelview_continuestory")
		slot0._txtnorstarttext2.text = luaLang("p_dungeonlevelview_continuestory")

		gohelper.setActive(slot0._txtusepowernormal.gameObject, false)
		gohelper.setActive(slot0._gonormalStartnode, false)

		if slot0._simagepower then
			gohelper.setActive(slot0._simagepower.gameObject, false)
		end
	else
		slot0._txtnorstarttext.text = luaLang("p_dungeonlevelview_startfight")
		slot0._txtnorstarttext2.text = luaLang("p_dungeonlevelview_startfight")

		gohelper.setActive(slot0._txtusepowernormal.gameObject, true)
		gohelper.setActive(slot0._txtusepowernormal2.gameObject, true)

		if slot0._simagepower then
			gohelper.setActive(slot0._simagepower.gameObject, true)
			gohelper.setActive(slot0._simagepower2.gameObject, true)
		end
	end
end

function slot0.setImage(slot0, slot1, slot2)
	if slot2 then
		UISpriteSetMgr.instance:setVersionActivitySprite(slot1, "star_1_3")
	else
		UISpriteSetMgr.instance:setVersionActivitySprite(slot1, "star_1_1")
	end
end

function slot0.buildEpisodeName(slot0)
	slot1 = slot0.showEpisodeCo.name
	slot2 = GameUtil.utf8sub(slot1, 1, 1)
	slot3 = ""

	if GameUtil.utf8len(slot1) > 1 then
		slot3 = GameUtil.utf8sub(slot1, 2, slot4 - 1)
	end

	slot5 = 112

	if GameConfig:GetCurLangType() == LangSettings.jp then
		slot5 = 90
	elseif GameConfig:GetCurLangType() == LangSettings.en then
		slot5 = 90
	elseif GameConfig:GetCurLangType() == LangSettings.kr then
		slot5 = 110
	end

	return string.format("<size=%s>%s</size>%s", slot5, slot2, slot3)
end

function slot0.buildColorText(slot0, slot1, slot2)
	return string.format("<color=%s>%s</color>", slot2, slot1)
end

function slot0.getPreModeName(slot0)
	if slot0._cur_select_index - 1 <= 0 then
		logWarn("not modeIndex mode : " .. slot0._cur_select_index)

		return ""
	end

	return luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[slot0.mode == VersionActivity1_2DungeonEnum.DungeonMode.Hard and 99 or slot0._cur_select_index - 1])
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._playUnlockAudio, slot0)

	if slot0._clueFlow then
		slot0._clueFlow:unregisterDoneListener(slot0._onClueFlowDone, slot0)
		slot0._clueFlow:stop()

		slot0._clueFlow = nil
	end
end

function slot0.onDestroyView(slot0)
	slot0.rewardItems = nil

	slot0._simageactivitynormalbg:UnLoadImage()
	slot0._simageactivityhardbg:UnLoadImage()

	if slot0._simagepower then
		slot0._simagepower:UnLoadImage()
	end

	if slot0._simagepower2 then
		slot0._simagepower2:UnLoadImage()
	end
end

return slot0
