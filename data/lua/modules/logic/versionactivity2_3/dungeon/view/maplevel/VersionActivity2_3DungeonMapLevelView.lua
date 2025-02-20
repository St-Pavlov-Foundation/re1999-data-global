module("modules.logic.versionactivity2_3.dungeon.view.maplevel.VersionActivity2_3DungeonMapLevelView", package.seeall)

slot0 = class("VersionActivity2_3DungeonMapLevelView", BaseView)
slot1 = 0.4
slot2 = 2.7

function slot0.onInitView(slot0)
	slot0.goVersionActivity = gohelper.findChild(slot0.viewGO, "anim/versionactivity")
	slot0.animator = slot0.goVersionActivity:GetComponent(typeof(UnityEngine.Animator))
	slot0.animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.goVersionActivity)
	slot0.animationEventWrap = slot0.goVersionActivity:GetComponent(typeof(ZProj.AnimationEventWrap))
	slot0._simageactivitynormalbg = gohelper.findChildSingleImage(slot0.viewGO, "anim/versionactivity/bgmask/#simage_activitynormalbg")
	slot0._simageactivityhardbg = gohelper.findChildSingleImage(slot0.viewGO, "anim/versionactivity/bgmask/#simage_activityhardbg")
	slot0._txtmapName = gohelper.findChildText(slot0.viewGO, "anim/versionactivity/right/title/#txt_mapName")
	slot0._txtmapNameEn = gohelper.findChildText(slot0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNameEn")
	slot0._txtmapNum = gohelper.findChildText(slot0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum")
	slot0._txtmapChapterIndex = gohelper.findChildText(slot0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/#txt_mapChapterIndex")
	slot0._gonormaleye = gohelper.findChild(slot0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/#image_normal")
	slot0._gohardeye = gohelper.findChild(slot0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/#image_hard")
	slot0._imagestar1 = gohelper.findChildImage(slot0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/stars/starLayout/#image_star1")
	slot0._imagestar2 = gohelper.findChildImage(slot0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/stars/starLayout/#image_star2")
	slot0._goswitch = gohelper.findChild(slot0.viewGO, "anim/versionactivity/right/content/#go_switch")
	slot0._gotype1 = gohelper.findChild(slot0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type1")
	slot0._gotype2 = gohelper.findChild(slot0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type2")
	slot0._gotype3 = gohelper.findChild(slot0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type3")
	slot0._gotype4 = gohelper.findChild(slot0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type4")
	slot0._gotype0 = gohelper.findChild(slot0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type0")
	slot0._btnleftarrow = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_leftarrow")
	slot0._btnrightarrow = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_rightarrow")
	slot0._gorecommend = gohelper.findChild(slot0.viewGO, "anim/versionactivity/right/content/#go_recommend")
	slot0._txtrecommendlv = gohelper.findChildText(slot0.viewGO, "anim/versionactivity/right/content/#go_recommend/txt/#txt_recommendlv")
	slot0._txtactivitydesc = gohelper.findChildText(slot0.viewGO, "anim/versionactivity/right/content/#txt_activitydesc")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "anim/versionactivity/right/#go_rewards")
	slot0._goactivityrewarditem = gohelper.findChild(slot0.viewGO, "anim/versionactivity/right/#go_rewards/rewardList/#go_activityrewarditem")
	slot0._btnactivityreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/versionactivity/right/#go_rewards/#btn_activityreward")
	slot0._gonorewards = gohelper.findChild(slot0.viewGO, "anim/versionactivity/right/#go_norewards")
	slot0.startBtnAnimator = gohelper.findChild(slot0.viewGO, "anim/versionactivity/right/startBtn"):GetComponent(typeof(UnityEngine.Animator))
	slot0._btnnormalStart = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart")
	slot0._txtusepowernormal = gohelper.findChildText(slot0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/#txt_usepowernormal")
	slot0._txtnorstarttext = gohelper.findChildText(slot0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/#txt_norstarttext")
	slot0._txtnorstarttexten = gohelper.findChildText(slot0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/#txt_norstarttexten")
	slot0._btnhardStart = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/versionactivity/right/startBtn/#btn_hardStart")
	slot0._txtusepowerhard = gohelper.findChildText(slot0.viewGO, "anim/versionactivity/right/startBtn/#btn_hardStart/#txt_usepowerhard")
	slot0._btnlockStart = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/versionactivity/right/startBtn/#btn_lock")
	slot0._simagepower = gohelper.findChildSingleImage(slot0.viewGO, "anim/versionactivity/right/startBtn/#simage_power")
	slot0._btnreplayStory = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/versionactivity/right/startBtn/#btn_replayStory")
	slot0._gorighttop = gohelper.findChild(slot0.viewGO, "anim/#go_righttop")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "anim/#go_lefttop")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
	slot0._btnleftarrow:AddClickListener(slot0._btnleftarrowOnClick, slot0)
	slot0._btnrightarrow:AddClickListener(slot0._btnrightarrowOnClick, slot0)
	slot0._btnactivityreward:AddClickListener(slot0._btnactivityrewardOnClick, slot0)
	slot0._btnnormalStart:AddClickListener(slot0._btnnormalStartOnClick, slot0)
	slot0._btnhardStart:AddClickListener(slot0._btnhardStartOnClick, slot0)
	slot0._btnlockStart:AddClickListener(slot0._btnlockStartOnClick, slot0)
	slot0._btnreplayStory:AddClickListener(slot0._btnreplayStoryOnClick, slot0)
	slot0.animationEventWrap:AddEventListener("refresh", slot0.refreshUI, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
	slot0._btnleftarrow:RemoveClickListener()
	slot0._btnrightarrow:RemoveClickListener()
	slot0._btnactivityreward:RemoveClickListener()
	slot0._btnnormalStart:RemoveClickListener()
	slot0._btnhardStart:RemoveClickListener()
	slot0._btnlockStart:RemoveClickListener()
	slot0._btnreplayStory:RemoveClickListener()
	slot0.animationEventWrap:RemoveAllEventListener()
end

function slot0._onCurrencyChange(slot0, slot1)
	if not slot1[CurrencyEnum.CurrencyType.Power] then
		return
	end

	slot0:refreshCostPower()
end

function slot0._btnleftarrowOnClick(slot0)
	if slot0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard or #slot0.mode2EpisodeDict == 1 or slot0.modeIndex <= 1 then
		return
	end

	slot0.modeIndex = slot0.modeIndex - 1

	slot0:refreshUIByMode(slot0.modeList[slot0.modeIndex])
end

function slot0._btnrightarrowOnClick(slot0)
	if slot0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard or #slot0.mode2EpisodeDict == 1 or slot0.modeIndex >= #slot0.modeList then
		return
	end

	slot0.modeIndex = slot0.modeIndex + 1

	slot0:refreshUIByMode(slot0.modeList[slot0.modeIndex])
end

function slot0.refreshUIByMode(slot0, slot1)
	if slot0.mode == slot1 then
		return
	end

	slot0.animator:Play(UIAnimationName.Switch, 0, 0)

	slot0.mode = slot1
	slot0.showEpisodeCo = slot0.mode2EpisodeDict[slot0.mode]
	slot0.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(slot0.showEpisodeCo.id)

	if not slot0.showEpisodeMo then
		slot0.showEpisodeMo = UserDungeonMO.New()

		slot0.showEpisodeMo:initFromManual(slot0.showEpisodeCo.chapterId, slot0.showEpisodeCo.id, 0, 0)
	end
end

function slot0._btnactivityrewardOnClick(slot0)
	DungeonController.instance:openDungeonRewardView(slot0.showEpisodeCo)
end

function slot0._btnnormalStartOnClick(slot0)
	if slot0.modeCanFight then
		slot0:startBattle()
	else
		slot0:_btnlockStartOnClick()
	end
end

function slot0._btnhardStartOnClick(slot0)
	slot0:startBattle()
end

function slot0.startBattle(slot0)
	if slot0.showEpisodeCo.type == DungeonEnum.EpisodeType.Story then
		if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SkipStroy) or slot0.showEpisodeCo.beforeStory == 0 then
			slot0:_playSkipMainStory()
		else
			slot0:_playMainStory()
		end

		return
	end

	if slot0.isSpecialEpisode then
		slot0.lastEpisodeSelectModeDict[tostring(slot0.specialEpisodeId)] = slot0.mode

		VersionActivity2_3DungeonController.instance:savePlayerPrefs(VersionActivity2_3DungeonEnum.PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastSelectMode, cjson.encode(slot0.lastEpisodeSelectModeDict))
	end

	if DungeonModel.instance:hasPassLevelAndStory(slot0.showEpisodeCo.id) then
		slot0:_enterFight()

		return
	end

	if slot0.showEpisodeCo.beforeStory > 0 then
		if not StoryModel.instance:isStoryFinished(slot0.showEpisodeCo.beforeStory) then
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
	end

	slot0:_enterFight()
end

function slot0._playSkipMainStory(slot0)
	DungeonRpc.instance:sendStartDungeonRequest(slot0.showEpisodeCo.chapterId, slot0.showEpisodeCo.id)
	slot0:onStoryFinished()
end

function slot0._playMainStory(slot0)
	DungeonRpc.instance:sendStartDungeonRequest(slot0.showEpisodeCo.chapterId, slot0.showEpisodeCo.id)
	StoryController.instance:playStory(slot0.showEpisodeCo.beforeStory, {
		mark = true,
		episodeId = slot0.showEpisodeCo.id
	}, slot0.onStoryFinished, slot0)
end

function slot0.onStoryFinished(slot0)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(slot0.showEpisodeCo.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
	slot0:closeThis()
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
	DungeonFightController.instance:enterFight(slot0.showEpisodeCo.chapterId, slot0.showEpisodeCo.id, 1)
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

function slot0._btnlockStartOnClick(slot0)
	GameFacade.showToast(ToastEnum.VersionActivityCanFight, slot0:getPreModeName())
end

function slot0.getPreModeName(slot0)
	if not slot0.modeList[slot0.modeIndex - 1] then
		logWarn("not modeIndex mode : " .. slot1)

		return ""
	end

	return luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[slot2])
end

function slot0._btnreplayStoryOnClick(slot0)
	if not slot0.storyIdList or #slot0.storyIdList < 1 then
		return
	end

	StoryController.instance:playStories(slot0.storyIdList)
	StoryController.instance:resetStoryParam({
		isLeiMiTeActivityStory = true
	})
end

function slot0._editableInitView(slot0)
	slot0.rewardItems = {}

	gohelper.setActive(slot0._goactivityrewarditem, false)
	gohelper.setActive(slot0._gonormaleye, false)
	gohelper.setActive(slot0._gohardeye, false)

	slot0.lockTypeAnimator = slot0._gotype0:GetComponent(typeof(UnityEngine.Animator))
	slot0.txtLockType = gohelper.findChildText(slot0._gotype0, "txt")
	slot0.lockTypeIconGo = gohelper.findChild(slot0._gotype0, "txt/icon")
	slot0.leftArrowLight = gohelper.findChild(slot0._btnleftarrow.gameObject, "left_arrow")
	slot0.leftArrowDisable = gohelper.findChild(slot0._btnleftarrow.gameObject, "left_arrow_disable")
	slot0.rightArrowLight = gohelper.findChild(slot0._btnrightarrow.gameObject, "right_arrow")
	slot0.rightArrowDisable = gohelper.findChild(slot0._btnrightarrow.gameObject, "right_arrow_disable")

	slot0:initLocalEpisodeMode()
end

function slot0.initLocalEpisodeMode(slot0)
	slot0.unlockedEpisodeModeDict = VersionActivity2_3DungeonController.instance:loadDictFromStr(VersionActivity2_3DungeonController.instance:getPlayerPrefs(VersionActivity2_3DungeonEnum.PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastUnLockMode, ""))
	slot0.lastEpisodeSelectModeDict = VersionActivity2_3DungeonController.instance:loadDictFromStr(VersionActivity2_3DungeonController.instance:getPlayerPrefs(VersionActivity2_3DungeonEnum.PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastSelectMode, ""))
end

function slot0.onUpdateParam(slot0)
	slot0:onOpen()
	slot0.animator:Play(UIAnimationName.Open, 0, 0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_pagesopen)
	slot0:initViewParam()
	slot0:initMode()
	slot0:markSelectEpisode()
	slot0:refreshStoryIdList()
	slot0:refreshBg()
	slot0:refreshUI()
	slot0.animator:Play(UIAnimationName.Open, 0, 0)
end

function slot0.initViewParam(slot0)
	slot0.originEpisodeId = slot0.viewParam.episodeId
	slot0.originEpisodeConfig = DungeonConfig.instance:getEpisodeCO(slot0.originEpisodeId)
	slot0.isFromJump = slot0.viewParam.isJump
	slot0.index = VersionActivity2_3DungeonConfig.instance:getEpisodeIndex(slot0.originEpisodeId)

	slot0.viewContainer:setOpenedEpisodeId(slot0.originEpisodeId)

	slot0.showEpisodeCo = DungeonConfig.instance:getEpisodeCO(slot0.originEpisodeId)
	slot0.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(slot0.originEpisodeId)
end

function slot0.initMode(slot0)
	slot0.mode = ActivityConfig.instance:getChapterIdMode(slot0.originEpisodeConfig.chapterId)
	slot0.modeIndex = 1

	if slot0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		return
	end

	slot0.modeList = {
		VersionActivityDungeonBaseEnum.DungeonMode.Story,
		VersionActivityDungeonBaseEnum.DungeonMode.Story2,
		VersionActivityDungeonBaseEnum.DungeonMode.Story3
	}
	slot0.mode2EpisodeDict = {}

	for slot5, slot6 in ipairs(DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(slot0.originEpisodeConfig)) do
		slot0.mode2EpisodeDict[ActivityConfig.instance:getChapterIdMode(slot6.chapterId)] = slot6
	end

	slot0.isSpecialEpisode = #slot1 > 1
	slot0.specialEpisodeId = slot1[1].id

	if not slot0.isSpecialEpisode then
		return
	end

	if slot0.isFromJump then
		slot0:checkNeedPlayModeUnLockAnimation()
	else
		slot2 = nil

		for slot6 = #slot1, 1, -1 do
			if DungeonModel.instance:hasPassLevelAndStory(slot1[slot6].preEpisode) then
				slot0.mode = slot0.modeList[slot6]

				break
			end
		end

		slot0:checkNeedPlayModeUnLockAnimation()

		if not slot0.needPlayUnlockModeAnimation then
			slot0.mode = slot0.lastEpisodeSelectModeDict[tostring(slot0.specialEpisodeId)] or VersionActivityDungeonBaseEnum.DungeonMode.Story
		end
	end

	for slot5, slot6 in ipairs(slot0.modeList) do
		if slot6 == slot0.mode then
			slot0.modeIndex = slot5

			break
		end
	end

	slot0.showEpisodeCo = slot0.mode2EpisodeDict[slot0.mode]
	slot0.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(slot0.showEpisodeCo.id)

	if not slot0.showEpisodeMo then
		slot0.showEpisodeMo = UserDungeonMO.New()

		slot0.showEpisodeMo:initFromManual(slot0.showEpisodeCo.chapterId, slot0.showEpisodeCo.id, 0, 0)
	end
end

function slot0.checkNeedPlayModeUnLockAnimation(slot0)
	if slot0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard or slot0.mode == (slot0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story) then
		slot0.needPlayUnlockModeAnimation = false
	else
		slot0.needPlayUnlockModeAnimation = (slot0.unlockedEpisodeModeDict[tostring(slot0.specialEpisodeId)] or VersionActivityDungeonBaseEnum.DungeonMode.Story) < slot0.mode
	end
end

function slot0.markSelectEpisode(slot0)
	if slot0.originEpisodeConfig.type == DungeonEnum.EpisodeType.Normal then
		VersionActivityDungeonBaseController.instance:setChapterIdLastSelectEpisodeId(slot0.originEpisodeConfig.chapterId, slot0.originEpisodeId)
	end
end

function slot0.refreshStoryIdList(slot0)
	if slot0.originEpisodeConfig.type == DungeonEnum.EpisodeType.Story or slot0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		slot0.storyIdList = nil

		return
	end

	slot3 = slot0.originEpisodeConfig

	if slot0.mode2EpisodeDict and slot0.mode2EpisodeDict[VersionActivityDungeonBaseEnum.DungeonMode.Story] then
		slot3 = slot5
	end

	slot0.storyIdList = {}

	if slot3.beforeStory > 0 and StoryModel.instance:isStoryHasPlayed(slot6) then
		table.insert(slot0.storyIdList, slot6)
	end

	if slot3.afterStory > 0 and StoryModel.instance:isStoryHasPlayed(slot7) then
		table.insert(slot0.storyIdList, slot7)
	end
end

function slot0.refreshBg(slot0)
	gohelper.setActive(slot0._simageactivitynormalbg.gameObject, slot0.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Hard)
	gohelper.setActive(slot0._simageactivityhardbg.gameObject, slot0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard)
end

function slot0.refreshUI(slot0)
	slot0:refreshModeCanFight()
	slot0:refreshEpisodeTextInfo()
	slot0:refreshStar()
	slot0:refreshMode()
	slot0:refreshArrow()
	slot0:refreshReward()
	slot0:refreshStartBtn()
	slot0:refreshEye()

	if slot0.needPlayUnlockModeAnimation then
		TaskDispatcher.runDelay(slot0.playModeUnlockAnimation, slot0, uv0)
	end
end

function slot0.refreshModeCanFight(slot0)
	if slot0.showEpisodeCo.preEpisode == 0 then
		slot0.modeCanFight = true

		return
	end

	slot0.modeCanFight = DungeonModel.instance:hasPassLevelAndStory(slot0.showEpisodeCo.preEpisode)
end

function slot0.refreshEpisodeTextInfo(slot0)
	slot2 = nil
	slot2 = (DungeonConfig.instance:getChapterCO(slot0.showEpisodeCo.chapterId).id ~= VersionActivity2_3DungeonEnum.DungeonChapterId.Story or slot0.showEpisodeCo) and VersionActivity2_3DungeonConfig.instance:getStoryEpisodeCo(slot0.showEpisodeCo.id)
	slot0._txtmapName.text = slot0:buildEpisodeName(slot2)
	slot3 = slot0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard and "#cfccc9" or "#cfccc9"
	slot0._txtmapNameEn.text = slot0:buildColorText(slot2.name_En, slot3)
	slot0._txtmapNum.text = slot0:buildColorText(string.format("%02d", slot0.index), slot3)
	slot0._txtmapChapterIndex.text = slot0:buildColorText(slot1.chapterIndex .. " .", slot3)
	slot0._txtactivitydesc.text = slot2.desc

	gohelper.setActive(slot0._gorecommend, DungeonHelper.getEpisodeRecommendLevel(slot0.showEpisodeCo.id) > 0)

	if slot4 > 0 then
		slot0._txtrecommendlv.text = HeroConfig.instance:getCommonLevelDisplay(slot4)
	end
end

function slot0.buildEpisodeName(slot0, slot1)
	slot2 = slot1.name
	slot3 = GameUtil.utf8sub(slot2, 1, 1)
	slot4 = ""

	if GameUtil.utf8len(slot2) > 1 then
		slot4 = GameUtil.utf8sub(slot2, 2, slot5 - 1)
	end

	return slot0:buildColorText(string.format("<size=112>%s</size>%s", slot3, slot4), slot0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard and "#cfccc9" or "#cfccc9")
end

function slot0.buildColorText(slot0, slot1, slot2)
	return string.format("<color=%s>%s</color>", slot2, slot1)
end

function slot0.refreshStar(slot0)
	slot0:setStarImage(slot0._imagestar1, slot0.showEpisodeCo.id and DungeonModel.instance:hasPassLevelAndStory(slot1), slot1)

	if string.nilorempty(DungeonConfig.instance:getEpisodeAdvancedConditionText(slot1)) then
		gohelper.setActive(slot0._imagestar2.gameObject, false)
	else
		gohelper.setActive(slot0._imagestar2.gameObject, true)
		slot0:setStarImage(slot0._imagestar2, slot2 and DungeonEnum.StarType.Advanced <= slot0.showEpisodeMo.star, slot1)
	end
end

function slot0.setStarImage(slot0, slot1, slot2, slot3)
	if slot2 then
		UISpriteSetMgr.instance:setV2a3DungeonSprite(slot1, VersionActivity2_3DungeonEnum.EpisodeStarType[DungeonConfig.instance:getEpisodeCO(slot3).chapterId].light)
	else
		UISpriteSetMgr.instance:setV2a3DungeonSprite(slot1, slot5.empty)
	end
end

function slot0.refreshMode(slot0)
	gohelper.setActive(slot0._gotype1, slot0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story)
	gohelper.setActive(slot0._gotype2, slot0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story2)
	gohelper.setActive(slot0._gotype3, slot0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story3)
	gohelper.setActive(slot0._gotype4, slot0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard)

	slot1 = not slot0.modeCanFight or slot0.needPlayUnlockModeAnimation

	gohelper.setActive(slot0._gotype0, slot1)

	if slot1 then
		slot0.lockTypeAnimator.enabled = true
		slot0.txtLockType.text = luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[slot0.mode])

		if slot0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story2 then
			SLFramework.UGUI.GuiHelper.SetColor(slot0.txtLockType, "#757563")
		elseif slot0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story3 then
			SLFramework.UGUI.GuiHelper.SetColor(slot0.txtLockType, "#757563")
		end
	end

	gohelper.setActive(slot0.lockTypeIconGo, slot1)
end

function slot0.refreshArrow(slot0)
	slot1 = slot0.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Hard and slot0.isSpecialEpisode

	gohelper.setActive(slot0._btnleftarrow.gameObject, slot1)
	gohelper.setActive(slot0._btnrightarrow.gameObject, slot1)

	if slot1 then
		gohelper.setActive(slot0.leftArrowLight, slot0.modeIndex ~= 1)
		gohelper.setActive(slot0.leftArrowDisable, slot0.modeIndex == 1)

		slot2 = #slot0.modeList == slot0.modeIndex

		gohelper.setActive(slot0.rightArrowLight, not slot2)
		gohelper.setActive(slot0.rightArrowDisable, slot2)
	end
end

function slot0.refreshReward(slot0)
	slot1 = {}
	slot2 = 0
	slot3 = 0

	if slot0.showEpisodeMo.star ~= DungeonEnum.StarType.Advanced then
		tabletool.addValues(slot1, DungeonModel.instance:getEpisodeAdvancedBonus(slot0.showEpisodeCo.id))

		slot3 = #slot1
	end

	if slot0.showEpisodeMo.star == DungeonEnum.StarType.None then
		tabletool.addValues(slot1, DungeonModel.instance:getEpisodeFirstBonus(slot0.showEpisodeCo.id))

		slot2 = #slot1
	end

	tabletool.addValues(slot1, DungeonModel.instance:getEpisodeReward(slot0.showEpisodeCo.id))
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
			slot7.gonormal = gohelper.findChild(slot7.go, "rare/#go_rare1")
			slot7.gofirst = gohelper.findChild(slot7.go, "rare/#go_rare2")
			slot7.goadvance = gohelper.findChild(slot7.go, "rare/#go_rare3")
			slot7.gofirsthard = gohelper.findChild(slot7.go, "rare/#go_rare4")
			slot7.txtnormal = gohelper.findChildText(slot7.go, "rare/#go_rare1/txt")

			table.insert(slot0.rewardItems, slot7)
		end

		gohelper.setActive(slot7.gonormal, false)
		gohelper.setActive(slot7.gofirst, false)
		gohelper.setActive(slot7.goadvance, false)
		gohelper.setActive(slot7.gofirsthard, false)

		slot12, slot13 = nil
		slot14 = slot1[slot11][3]
		slot15 = true

		if slot0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
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

			slot16 = slot6[3]
			slot15 = true

			if slot6.tagType then
				slot16 = slot6.tagType
				slot15 = slot14 ~= 0
			elseif #slot6 >= 4 then
				slot14 = slot6[4]
			else
				slot15 = false
			end

			slot7.txtnormal.text = luaLang("dungeon_prob_flag" .. slot16)
		end

		slot7.iconItem:setMOValue(slot6[1], slot6[2], slot14, nil, true)
		slot7.iconItem:setCountFontSize(40)
		slot7.iconItem:setHideLvAndBreakFlag(true)
		slot7.iconItem:hideEquipLvAndBreak(true)
		slot7.iconItem:isShowCount(slot15)
		gohelper.setActive(slot7.go, true)
	end

	for slot11 = slot5 + 1, #slot0.rewardItems do
		gohelper.setActive(slot0.rewardItems[slot11].go, false)
	end
end

function slot0.refreshStartBtn(slot0)
	slot0:refreshCostPower()
	slot0._simagepower:LoadImage(ResUrl.getCurrencyItemIcon(CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power).icon .. "_btn"))

	slot3 = slot0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard

	gohelper.setActive(slot0._btnnormalStart.gameObject, slot0.modeCanFight and not slot3)
	gohelper.setActive(slot0._btnhardStart.gameObject, slot3)
	gohelper.setActive(slot0._btnlockStart.gameObject, not slot0.modeCanFight or slot0.needPlayUnlockModeAnimation)

	slot7 = slot0.mode2EpisodeDict and slot0.mode2EpisodeDict[VersionActivityDungeonBaseEnum.DungeonMode.Story]

	gohelper.setActive(slot0._btnreplayStory.gameObject, DungeonModel.instance:hasPassLevelAndStory(slot7 and slot7.id or slot0.originEpisodeConfig.id) and (slot0.storyIdList and #slot0.storyIdList > 0))

	if slot3 then
		return
	end

	if slot0.modeCanFight then
		if DungeonModel.instance:hasPassLevel(slot0.showEpisodeCo.id) and slot0.showEpisodeCo.afterStory > 0 and not StoryModel.instance:isStoryFinished(slot0.showEpisodeCo.afterStory) then
			slot0._txtnorstarttext.text = luaLang("p_dungeonlevelview_continuestory")

			recthelper.setAnchorX(slot0._txtnorstarttext.gameObject.transform, 0)
			recthelper.setAnchorX(slot0._txtnorstarttexten.gameObject.transform, 0)
			gohelper.setActive(slot0._txtusepowernormal.gameObject, false)
			gohelper.setActive(slot0._simagepower.gameObject, false)
		else
			slot0._txtnorstarttext.text = luaLang("p_dungeonlevelview_startfight")

			recthelper.setAnchorX(slot0._txtnorstarttext.gameObject.transform, 121)
			recthelper.setAnchorX(slot0._txtnorstarttexten.gameObject.transform, 121)
			gohelper.setActive(slot0._txtusepowernormal.gameObject, true)
			gohelper.setActive(slot0._simagepower.gameObject, true)
		end
	else
		gohelper.setActive(slot0._simagepower.gameObject, false)
		gohelper.setActive(slot0._txtusepowernormal.gameObject, false)
	end
end

function slot0.refreshCostPower(slot0)
	slot1 = 0

	if not string.nilorempty(slot0.showEpisodeCo.cost) then
		slot1 = string.splitToNumber(slot0.showEpisodeCo.cost, "#")[3]
	end

	slot0._txtusepowernormal.text = "-" .. slot1
	slot0._txtusepowerhard.text = "-" .. slot1

	if slot1 <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtusepowernormal, "#070706")
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtusepowerhard, "#FFEAEA")
	else
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtusepowernormal, "#800015")
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtusepowerhard, "#C44945")
	end
end

function slot0.refreshEye(slot0)
	if not (slot0.originEpisodeConfig.displayMark == 1) then
		gohelper.setActive(slot0._gonormaleye, false)
		gohelper.setActive(slot0._gohardeye, false)

		return
	end

	slot2 = slot0.originEpisodeConfig.chapterId == VersionActivity2_3DungeonEnum.DungeonChapterId.Hard

	gohelper.setActive(slot0._gonormaleye, not slot2)
	gohelper.setActive(slot0._gohardeye, slot2)
end

function slot0.playModeUnlockAnimation(slot0)
	if not slot0.needPlayUnlockModeAnimation then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_difficulty)
	slot0:_playModeUnLockAnimation(UIAnimationName.Unlock)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity2_3DungeonEnum.BlockKey.MapLevelViewPlayUnlockAnim)
	TaskDispatcher.runDelay(slot0.onModeUnlockAnimationPlayDone, slot0, uv0)
end

function slot0._playModeUnLockAnimation(slot0, slot1)
	slot0.lockTypeAnimator.enabled = true

	slot0.lockTypeAnimator:Play(slot1)
	slot0.startBtnAnimator:Play(slot1)
end

function slot0.onModeUnlockAnimationPlayDone(slot0)
	slot0:_playModeUnLockAnimation(UIAnimationName.Idle)

	slot0.unlockedEpisodeModeDict[tostring(slot0.specialEpisodeId)] = slot0.mode

	VersionActivity2_3DungeonController.instance:savePlayerPrefs(VersionActivity2_3DungeonEnum.PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastUnLockMode, cjson.encode(slot0.unlockedEpisodeModeDict))

	slot0.needPlayUnlockModeAnimation = false

	slot0:refreshMode()
	slot0:refreshStartBtn()
	UIBlockMgr.instance:endBlock(VersionActivity2_3DungeonEnum.BlockKey.MapLevelViewPlayUnlockAnim)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.playModeUnlockAnimation, slot0)
	TaskDispatcher.cancelTask(slot0.onModeUnlockAnimationPlayDone, slot0)
	UIBlockMgr.instance:endBlock(VersionActivity2_3DungeonEnum.BlockKey.MapLevelViewPlayUnlockAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function slot0.onDestroyView(slot0)
	slot0.rewardItems = nil

	slot0._simagepower:UnLoadImage()
end

return slot0
