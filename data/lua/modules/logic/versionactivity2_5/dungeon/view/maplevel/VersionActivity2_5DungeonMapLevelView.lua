module("modules.logic.versionactivity2_5.dungeon.view.maplevel.VersionActivity2_5DungeonMapLevelView", package.seeall)

local var_0_0 = class("VersionActivity2_5DungeonMapLevelView", BaseView)
local var_0_1 = {
	2510101,
	2510116,
	2520117,
	2510117
}

function var_0_0._buildEpisodeName_overseas(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	local var_1_0 = LangSettings.instance:isJp() or LangSettings.instance:isEn()
	local var_1_1 = false

	if var_1_0 then
		local var_1_2 = arg_1_0.showEpisodeCo.id

		for iter_1_0, iter_1_1 in ipairs(var_0_1) do
			if var_1_2 == iter_1_1 then
				var_1_1 = true

				break
			end
		end
	end

	if var_1_1 then
		return arg_1_0:buildColorText(string.format("<size=90>%s</size>%s", arg_1_1, arg_1_2), arg_1_3)
	else
		return arg_1_0:buildColorText(string.format("<size=112>%s</size>%s", arg_1_1, arg_1_2), arg_1_3)
	end
end

local var_0_2 = 0.4
local var_0_3 = 2.7

function var_0_0.onInitView(arg_2_0)
	arg_2_0.goVersionActivity = gohelper.findChild(arg_2_0.viewGO, "anim/versionactivity")
	arg_2_0.animator = arg_2_0.goVersionActivity:GetComponent(typeof(UnityEngine.Animator))
	arg_2_0.animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_2_0.goVersionActivity)
	arg_2_0.animationEventWrap = arg_2_0.goVersionActivity:GetComponent(typeof(ZProj.AnimationEventWrap))
	arg_2_0._simageactivitynormalbg = gohelper.findChildSingleImage(arg_2_0.viewGO, "anim/versionactivity/bgmask/#simage_activitynormalbg")
	arg_2_0._simageactivityhardbg = gohelper.findChildSingleImage(arg_2_0.viewGO, "anim/versionactivity/bgmask/#simage_activityhardbg")
	arg_2_0._txtmapName = gohelper.findChildText(arg_2_0.viewGO, "anim/versionactivity/right/title/#txt_mapName")
	arg_2_0._txtmapNameEn = gohelper.findChildText(arg_2_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNameEn")
	arg_2_0._txtmapNum = gohelper.findChildText(arg_2_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum")
	arg_2_0._txtmapChapterIndex = gohelper.findChildText(arg_2_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/#txt_mapChapterIndex")
	arg_2_0._gonormaleye = gohelper.findChild(arg_2_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/#image_normal")
	arg_2_0._gohardeye = gohelper.findChild(arg_2_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/#image_hard")
	arg_2_0._imagestar1 = gohelper.findChildImage(arg_2_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/stars/starLayout/#image_star1")
	arg_2_0._imagestar2 = gohelper.findChildImage(arg_2_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/stars/starLayout/#image_star2")
	arg_2_0._goswitch = gohelper.findChild(arg_2_0.viewGO, "anim/versionactivity/right/content/#go_switch")
	arg_2_0._gotype1 = gohelper.findChild(arg_2_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type1")
	arg_2_0._gotype2 = gohelper.findChild(arg_2_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type2")
	arg_2_0._gotype3 = gohelper.findChild(arg_2_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type3")
	arg_2_0._gotype4 = gohelper.findChild(arg_2_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type4")
	arg_2_0._gotype0 = gohelper.findChild(arg_2_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type0")
	arg_2_0._btnleftarrow = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_leftarrow")
	arg_2_0._btnrightarrow = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_rightarrow")
	arg_2_0._gorecommend = gohelper.findChild(arg_2_0.viewGO, "anim/versionactivity/right/content/#go_recommend")
	arg_2_0._txtrecommendlv = gohelper.findChildText(arg_2_0.viewGO, "anim/versionactivity/right/content/#go_recommend/txt/#txt_recommendlv")
	arg_2_0._txtactivitydesc = gohelper.findChildText(arg_2_0.viewGO, "anim/versionactivity/right/content/#txt_activitydesc")
	arg_2_0._gorewards = gohelper.findChild(arg_2_0.viewGO, "anim/versionactivity/right/#go_rewards")
	arg_2_0._goactivityrewarditem = gohelper.findChild(arg_2_0.viewGO, "anim/versionactivity/right/#go_rewards/rewardList/#go_activityrewarditem")
	arg_2_0._btnactivityreward = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "anim/versionactivity/right/#go_rewards/#btn_activityreward")
	arg_2_0._gonorewards = gohelper.findChild(arg_2_0.viewGO, "anim/versionactivity/right/#go_norewards")
	arg_2_0.startBtnAnimator = gohelper.findChild(arg_2_0.viewGO, "anim/versionactivity/right/startBtn"):GetComponent(typeof(UnityEngine.Animator))
	arg_2_0._btnnormalStart = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart")
	arg_2_0._txtusepowernormal = gohelper.findChildText(arg_2_0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/#txt_usepowernormal")
	arg_2_0._txtnorstarttext = gohelper.findChildText(arg_2_0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/#txt_norstarttext")
	arg_2_0._txtnorstarttexten = gohelper.findChildText(arg_2_0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/#txt_norstarttexten")
	arg_2_0._btnhardStart = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "anim/versionactivity/right/startBtn/#btn_hardStart")
	arg_2_0._txtusepowerhard = gohelper.findChildText(arg_2_0.viewGO, "anim/versionactivity/right/startBtn/#btn_hardStart/#txt_usepowerhard")
	arg_2_0._btnlockStart = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "anim/versionactivity/right/startBtn/#btn_lock")
	arg_2_0._simagepower = gohelper.findChildSingleImage(arg_2_0.viewGO, "anim/versionactivity/right/startBtn/#simage_power")
	arg_2_0._btnreplayStory = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "anim/versionactivity/right/startBtn/#btn_replayStory")
	arg_2_0._gorighttop = gohelper.findChild(arg_2_0.viewGO, "anim/#go_righttop")
	arg_2_0._golefttop = gohelper.findChild(arg_2_0.viewGO, "anim/#go_lefttop")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0._onCurrencyChange, arg_3_0)
	arg_3_0._btnleftarrow:AddClickListener(arg_3_0._btnleftarrowOnClick, arg_3_0)
	arg_3_0._btnrightarrow:AddClickListener(arg_3_0._btnrightarrowOnClick, arg_3_0)
	arg_3_0._btnactivityreward:AddClickListener(arg_3_0._btnactivityrewardOnClick, arg_3_0)
	arg_3_0._btnnormalStart:AddClickListener(arg_3_0._btnnormalStartOnClick, arg_3_0)
	arg_3_0._btnhardStart:AddClickListener(arg_3_0._btnhardStartOnClick, arg_3_0)
	arg_3_0._btnlockStart:AddClickListener(arg_3_0._btnlockStartOnClick, arg_3_0)
	arg_3_0._btnreplayStory:AddClickListener(arg_3_0._btnreplayStoryOnClick, arg_3_0)
	arg_3_0.animationEventWrap:AddEventListener("refresh", arg_3_0.refreshUI, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_4_0._onCurrencyChange, arg_4_0)
	arg_4_0._btnleftarrow:RemoveClickListener()
	arg_4_0._btnrightarrow:RemoveClickListener()
	arg_4_0._btnactivityreward:RemoveClickListener()
	arg_4_0._btnnormalStart:RemoveClickListener()
	arg_4_0._btnhardStart:RemoveClickListener()
	arg_4_0._btnlockStart:RemoveClickListener()
	arg_4_0._btnreplayStory:RemoveClickListener()
	arg_4_0.animationEventWrap:RemoveAllEventListener()
end

function var_0_0._onCurrencyChange(arg_5_0, arg_5_1)
	if not arg_5_1[CurrencyEnum.CurrencyType.Power] then
		return
	end

	arg_5_0:refreshCostPower()
end

function var_0_0._btnleftarrowOnClick(arg_6_0)
	if arg_6_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard or #arg_6_0.mode2EpisodeDict == 1 or arg_6_0.modeIndex <= 1 then
		return
	end

	arg_6_0.modeIndex = arg_6_0.modeIndex - 1

	arg_6_0:refreshUIByMode(arg_6_0.modeList[arg_6_0.modeIndex])
end

function var_0_0._btnrightarrowOnClick(arg_7_0)
	if arg_7_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard or #arg_7_0.mode2EpisodeDict == 1 or arg_7_0.modeIndex >= #arg_7_0.modeList then
		return
	end

	arg_7_0.modeIndex = arg_7_0.modeIndex + 1

	arg_7_0:refreshUIByMode(arg_7_0.modeList[arg_7_0.modeIndex])
end

function var_0_0.refreshUIByMode(arg_8_0, arg_8_1)
	if arg_8_0.mode == arg_8_1 then
		return
	end

	arg_8_0.animator:Play(UIAnimationName.Switch, 0, 0)

	arg_8_0.mode = arg_8_1
	arg_8_0.showEpisodeCo = arg_8_0.mode2EpisodeDict[arg_8_0.mode]
	arg_8_0.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(arg_8_0.showEpisodeCo.id)

	if not arg_8_0.showEpisodeMo then
		arg_8_0.showEpisodeMo = UserDungeonMO.New()

		arg_8_0.showEpisodeMo:initFromManual(arg_8_0.showEpisodeCo.chapterId, arg_8_0.showEpisodeCo.id, 0, 0)
	end
end

function var_0_0._btnactivityrewardOnClick(arg_9_0)
	DungeonController.instance:openDungeonRewardView(arg_9_0.showEpisodeCo)
end

function var_0_0._btnnormalStartOnClick(arg_10_0)
	if arg_10_0.modeCanFight then
		arg_10_0:startBattle()
	else
		arg_10_0:_btnlockStartOnClick()
	end
end

function var_0_0._btnhardStartOnClick(arg_11_0)
	arg_11_0:startBattle()
end

function var_0_0.startBattle(arg_12_0)
	if arg_12_0.showEpisodeCo.type == DungeonEnum.EpisodeType.Story then
		if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SkipStroy) or arg_12_0.showEpisodeCo.beforeStory == 0 then
			arg_12_0:_playSkipMainStory()
		else
			arg_12_0:_playMainStory()
		end

		return
	end

	if arg_12_0.isSpecialEpisode then
		arg_12_0.lastEpisodeSelectModeDict[tostring(arg_12_0.specialEpisodeId)] = arg_12_0.mode

		local var_12_0 = VersionActivity2_5DungeonEnum.PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastSelectMode
		local var_12_1 = cjson.encode(arg_12_0.lastEpisodeSelectModeDict)

		VersionActivity2_5DungeonController.instance:savePlayerPrefs(var_12_0, var_12_1)
	end

	if DungeonModel.instance:hasPassLevelAndStory(arg_12_0.showEpisodeCo.id) then
		arg_12_0:_enterFight()

		return
	end

	if arg_12_0.showEpisodeCo.beforeStory > 0 then
		if not StoryModel.instance:isStoryFinished(arg_12_0.showEpisodeCo.beforeStory) then
			arg_12_0:_playStoryAndEnterFight(arg_12_0.showEpisodeCo.beforeStory)

			return
		end

		if arg_12_0.showEpisodeMo.star <= DungeonEnum.StarType.None then
			arg_12_0:_enterFight()

			return
		end

		if arg_12_0.showEpisodeCo.afterStory > 0 and not StoryModel.instance:isStoryFinished(arg_12_0.showEpisodeCo.afterStory) then
			arg_12_0:playAfterStory(arg_12_0.showEpisodeCo.afterStory)

			return
		end
	end

	arg_12_0:_enterFight()
end

function var_0_0._playSkipMainStory(arg_13_0)
	DungeonRpc.instance:sendStartDungeonRequest(arg_13_0.showEpisodeCo.chapterId, arg_13_0.showEpisodeCo.id)
	arg_13_0:onStoryFinished()
end

function var_0_0._playMainStory(arg_14_0)
	DungeonRpc.instance:sendStartDungeonRequest(arg_14_0.showEpisodeCo.chapterId, arg_14_0.showEpisodeCo.id)

	local var_14_0 = {}

	var_14_0.mark = true
	var_14_0.episodeId = arg_14_0.showEpisodeCo.id

	StoryController.instance:playStory(arg_14_0.showEpisodeCo.beforeStory, var_14_0, arg_14_0.onStoryFinished, arg_14_0)
end

function var_0_0.onStoryFinished(arg_15_0)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(arg_15_0.showEpisodeCo.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
	arg_15_0:closeThis()
end

function var_0_0._playStoryAndEnterFight(arg_16_0, arg_16_1)
	if StoryModel.instance:isStoryFinished(arg_16_1) then
		arg_16_0:_enterFight()

		return
	end

	local var_16_0 = {}

	var_16_0.mark = true
	var_16_0.episodeId = arg_16_0.showEpisodeCo.id

	StoryController.instance:playStory(arg_16_1, var_16_0, arg_16_0._enterFight, arg_16_0)
end

function var_0_0._enterFight(arg_17_0)
	DungeonFightController.instance:enterFight(arg_17_0.showEpisodeCo.chapterId, arg_17_0.showEpisodeCo.id, 1)
end

function var_0_0.playAfterStory(arg_18_0, arg_18_1)
	local var_18_0 = {}

	var_18_0.mark = true
	var_18_0.episodeId = arg_18_0.showEpisodeCo.id

	StoryController.instance:playStory(arg_18_1, var_18_0, function()
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo, nil)

		DungeonMapModel.instance.playAfterStory = true

		arg_18_0:closeThis()
	end, arg_18_0)
end

function var_0_0._btnlockStartOnClick(arg_20_0)
	local var_20_0 = arg_20_0:getPreModeName()

	GameFacade.showToast(ToastEnum.VersionActivityCanFight, var_20_0)
end

function var_0_0.getPreModeName(arg_21_0)
	local var_21_0 = arg_21_0.modeIndex - 1
	local var_21_1 = arg_21_0.modeList[var_21_0]

	if not var_21_1 then
		logWarn("not modeIndex mode : " .. var_21_0)

		return ""
	end

	return luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[var_21_1])
end

function var_0_0._btnreplayStoryOnClick(arg_22_0)
	if not arg_22_0.storyIdList or #arg_22_0.storyIdList < 1 then
		return
	end

	StoryController.instance:playStories(arg_22_0.storyIdList)

	local var_22_0 = {}

	var_22_0.isLeiMiTeActivityStory = true

	StoryController.instance:resetStoryParam(var_22_0)
end

function var_0_0._editableInitView(arg_23_0)
	arg_23_0.rewardItems = {}

	gohelper.setActive(arg_23_0._goactivityrewarditem, false)
	gohelper.setActive(arg_23_0._gonormaleye, false)
	gohelper.setActive(arg_23_0._gohardeye, false)

	arg_23_0.lockTypeAnimator = arg_23_0._gotype0:GetComponent(typeof(UnityEngine.Animator))
	arg_23_0.txtLockType = gohelper.findChildText(arg_23_0._gotype0, "txt")
	arg_23_0.lockTypeIconGo = gohelper.findChild(arg_23_0._gotype0, "txt/icon")
	arg_23_0.leftArrowLight = gohelper.findChild(arg_23_0._btnleftarrow.gameObject, "left_arrow")
	arg_23_0.leftArrowDisable = gohelper.findChild(arg_23_0._btnleftarrow.gameObject, "left_arrow_disable")
	arg_23_0.rightArrowLight = gohelper.findChild(arg_23_0._btnrightarrow.gameObject, "right_arrow")
	arg_23_0.rightArrowDisable = gohelper.findChild(arg_23_0._btnrightarrow.gameObject, "right_arrow_disable")

	arg_23_0:initLocalEpisodeMode()
end

function var_0_0.initLocalEpisodeMode(arg_24_0)
	local var_24_0 = VersionActivity2_5DungeonEnum.PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastUnLockMode
	local var_24_1 = VersionActivity2_5DungeonController.instance:getPlayerPrefs(var_24_0, "")

	arg_24_0.unlockedEpisodeModeDict = VersionActivity2_5DungeonController.instance:loadDictFromStr(var_24_1)

	local var_24_2 = VersionActivity2_5DungeonEnum.PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastSelectMode
	local var_24_3 = VersionActivity2_5DungeonController.instance:getPlayerPrefs(var_24_2, "")

	arg_24_0.lastEpisodeSelectModeDict = VersionActivity2_5DungeonController.instance:loadDictFromStr(var_24_3)
end

function var_0_0.onUpdateParam(arg_25_0)
	arg_25_0:onOpen()
	arg_25_0.animator:Play(UIAnimationName.Open, 0, 0)
end

function var_0_0.onOpen(arg_26_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_pagesopen)
	arg_26_0:initViewParam()
	arg_26_0:initMode()
	arg_26_0:markSelectEpisode()
	arg_26_0:refreshStoryIdList()
	arg_26_0:refreshBg()
	arg_26_0:refreshUI()
	arg_26_0.animator:Play(UIAnimationName.Open, 0, 0)
end

function var_0_0.initViewParam(arg_27_0)
	arg_27_0.originEpisodeId = arg_27_0.viewParam.episodeId
	arg_27_0.originEpisodeConfig = DungeonConfig.instance:getEpisodeCO(arg_27_0.originEpisodeId)
	arg_27_0.isFromJump = arg_27_0.viewParam.isJump
	arg_27_0.index = VersionActivity2_5DungeonConfig.instance:getEpisodeIndex(arg_27_0.originEpisodeId)

	arg_27_0.viewContainer:setOpenedEpisodeId(arg_27_0.originEpisodeId)

	arg_27_0.showEpisodeCo = DungeonConfig.instance:getEpisodeCO(arg_27_0.originEpisodeId)
	arg_27_0.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(arg_27_0.originEpisodeId)
end

function var_0_0.initMode(arg_28_0)
	arg_28_0.mode = ActivityConfig.instance:getChapterIdMode(arg_28_0.originEpisodeConfig.chapterId)
	arg_28_0.modeIndex = 1

	if arg_28_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		return
	end

	arg_28_0.modeList = {
		VersionActivityDungeonBaseEnum.DungeonMode.Story,
		VersionActivityDungeonBaseEnum.DungeonMode.Story2,
		VersionActivityDungeonBaseEnum.DungeonMode.Story3
	}

	local var_28_0 = DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(arg_28_0.originEpisodeConfig)

	arg_28_0.mode2EpisodeDict = {}

	for iter_28_0, iter_28_1 in ipairs(var_28_0) do
		local var_28_1 = ActivityConfig.instance:getChapterIdMode(iter_28_1.chapterId)

		arg_28_0.mode2EpisodeDict[var_28_1] = iter_28_1
	end

	arg_28_0.isSpecialEpisode = #var_28_0 > 1
	arg_28_0.specialEpisodeId = var_28_0[1].id

	if not arg_28_0.isSpecialEpisode then
		return
	end

	if arg_28_0.isFromJump then
		arg_28_0:checkNeedPlayModeUnLockAnimation()
	else
		local var_28_2

		for iter_28_2 = #var_28_0, 1, -1 do
			local var_28_3 = var_28_0[iter_28_2]

			if DungeonModel.instance:hasPassLevelAndStory(var_28_3.preEpisode) then
				arg_28_0.mode = arg_28_0.modeList[iter_28_2]

				break
			end
		end

		arg_28_0:checkNeedPlayModeUnLockAnimation()

		if not arg_28_0.needPlayUnlockModeAnimation then
			arg_28_0.mode = arg_28_0.lastEpisodeSelectModeDict[tostring(arg_28_0.specialEpisodeId)] or VersionActivityDungeonBaseEnum.DungeonMode.Story
		end
	end

	for iter_28_3, iter_28_4 in ipairs(arg_28_0.modeList) do
		if iter_28_4 == arg_28_0.mode then
			arg_28_0.modeIndex = iter_28_3

			break
		end
	end

	arg_28_0.showEpisodeCo = arg_28_0.mode2EpisodeDict[arg_28_0.mode]
	arg_28_0.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(arg_28_0.showEpisodeCo.id)

	if not arg_28_0.showEpisodeMo then
		arg_28_0.showEpisodeMo = UserDungeonMO.New()

		arg_28_0.showEpisodeMo:initFromManual(arg_28_0.showEpisodeCo.chapterId, arg_28_0.showEpisodeCo.id, 0, 0)
	end
end

function var_0_0.checkNeedPlayModeUnLockAnimation(arg_29_0)
	local var_29_0 = arg_29_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story

	if arg_29_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard or arg_29_0.mode == var_29_0 then
		arg_29_0.needPlayUnlockModeAnimation = false
	else
		arg_29_0.needPlayUnlockModeAnimation = (arg_29_0.unlockedEpisodeModeDict[tostring(arg_29_0.specialEpisodeId)] or VersionActivityDungeonBaseEnum.DungeonMode.Story) < arg_29_0.mode
	end
end

function var_0_0.markSelectEpisode(arg_30_0)
	if arg_30_0.originEpisodeConfig.type == DungeonEnum.EpisodeType.Normal then
		VersionActivityDungeonBaseController.instance:setChapterIdLastSelectEpisodeId(arg_30_0.originEpisodeConfig.chapterId, arg_30_0.originEpisodeId)
	end
end

function var_0_0.refreshStoryIdList(arg_31_0)
	local var_31_0 = arg_31_0.originEpisodeConfig.type == DungeonEnum.EpisodeType.Story
	local var_31_1 = arg_31_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard

	if var_31_0 or var_31_1 then
		arg_31_0.storyIdList = nil

		return
	end

	local var_31_2 = arg_31_0.originEpisodeConfig
	local var_31_3 = VersionActivityDungeonBaseEnum.DungeonMode.Story
	local var_31_4 = arg_31_0.mode2EpisodeDict and arg_31_0.mode2EpisodeDict[var_31_3]

	if var_31_4 then
		var_31_2 = var_31_4
	end

	arg_31_0.storyIdList = {}

	local var_31_5 = var_31_2.beforeStory

	if var_31_5 > 0 and StoryModel.instance:isStoryHasPlayed(var_31_5) then
		table.insert(arg_31_0.storyIdList, var_31_5)
	end

	local var_31_6 = var_31_2.afterStory

	if var_31_6 > 0 and StoryModel.instance:isStoryHasPlayed(var_31_6) then
		table.insert(arg_31_0.storyIdList, var_31_6)
	end
end

function var_0_0.refreshBg(arg_32_0)
	gohelper.setActive(arg_32_0._simageactivitynormalbg.gameObject, arg_32_0.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Hard)
	gohelper.setActive(arg_32_0._simageactivityhardbg.gameObject, arg_32_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard)
end

function var_0_0.refreshUI(arg_33_0)
	arg_33_0:refreshModeCanFight()
	arg_33_0:refreshEpisodeTextInfo()
	arg_33_0:refreshStar()
	arg_33_0:refreshMode()
	arg_33_0:refreshArrow()
	arg_33_0:refreshReward()
	arg_33_0:refreshStartBtn()
	arg_33_0:refreshEye()

	if arg_33_0.needPlayUnlockModeAnimation then
		TaskDispatcher.runDelay(arg_33_0.playModeUnlockAnimation, arg_33_0, var_0_2)
	end
end

function var_0_0.refreshModeCanFight(arg_34_0)
	if arg_34_0.showEpisodeCo.preEpisode == 0 then
		arg_34_0.modeCanFight = true

		return
	end

	arg_34_0.modeCanFight = DungeonModel.instance:hasPassLevelAndStory(arg_34_0.showEpisodeCo.preEpisode)
end

function var_0_0.refreshEpisodeTextInfo(arg_35_0)
	local var_35_0 = DungeonConfig.instance:getChapterCO(arg_35_0.showEpisodeCo.chapterId)
	local var_35_1

	if var_35_0.id == VersionActivity2_5DungeonEnum.DungeonChapterId.Story then
		var_35_1 = arg_35_0.showEpisodeCo
	else
		var_35_1 = VersionActivity2_5DungeonConfig.instance:getStoryEpisodeCo(arg_35_0.showEpisodeCo.id)
	end

	arg_35_0._txtmapName.text = arg_35_0:buildEpisodeName(var_35_1)

	local var_35_2 = arg_35_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard and "#cfccc9" or "#cfccc9"

	arg_35_0._txtmapNameEn.text = arg_35_0:buildColorText(var_35_1.name_En, var_35_2)
	arg_35_0._txtmapNum.text = arg_35_0:buildColorText(string.format("%02d", arg_35_0.index), var_35_2)
	arg_35_0._txtmapChapterIndex.text = arg_35_0:buildColorText(var_35_0.chapterIndex .. " .", var_35_2)
	arg_35_0._txtactivitydesc.text = var_35_1.desc

	local var_35_3 = DungeonHelper.getEpisodeRecommendLevel(arg_35_0.showEpisodeCo.id)
	local var_35_4 = lua_battle.configDict[arg_35_0.showEpisodeCo.battleId]
	local var_35_5 = lua_battle.configDict[arg_35_0.showEpisodeCo.firstBattleId]
	local var_35_6 = var_35_5 and not string.nilorempty(var_35_5.balance)
	local var_35_7 = var_35_4 and not string.nilorempty(var_35_4.balance)
	local var_35_8 = DungeonModel.instance:hasPassLevel(arg_35_0.showEpisodeCo.id)

	gohelper.setActive(arg_35_0._gorecommend, var_35_3 > 0)

	if (var_35_6 or var_35_7) and not var_35_8 then
		arg_35_0._txtrecommendlv.text = "---"
	elseif var_35_3 > 0 then
		arg_35_0._txtrecommendlv.text = HeroConfig.instance:getCommonLevelDisplay(var_35_3)
	end
end

function var_0_0.buildEpisodeName(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_1.name
	local var_36_1 = GameUtil.utf8sub(var_36_0, 1, 1)
	local var_36_2 = ""
	local var_36_3 = GameUtil.utf8len(var_36_0)

	if var_36_3 > 1 then
		var_36_2 = GameUtil.utf8sub(var_36_0, 2, var_36_3 - 1)
	end

	local var_36_4 = arg_36_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard and "#cfccc9" or "#cfccc9"

	return arg_36_0:_buildEpisodeName_overseas(var_36_1, var_36_2, var_36_4, arg_36_1, var_36_3)
end

function var_0_0.buildColorText(arg_37_0, arg_37_1, arg_37_2)
	return string.format("<color=%s>%s</color>", arg_37_2, arg_37_1)
end

function var_0_0.refreshStar(arg_38_0)
	local var_38_0 = arg_38_0.showEpisodeCo.id
	local var_38_1 = var_38_0 and DungeonModel.instance:hasPassLevelAndStory(var_38_0)
	local var_38_2 = DungeonConfig.instance:getEpisodeAdvancedConditionText(var_38_0)

	arg_38_0:setStarImage(arg_38_0._imagestar1, var_38_1, var_38_0)

	if string.nilorempty(var_38_2) then
		gohelper.setActive(arg_38_0._imagestar2.gameObject, false)
	else
		gohelper.setActive(arg_38_0._imagestar2.gameObject, true)
		arg_38_0:setStarImage(arg_38_0._imagestar2, var_38_1 and arg_38_0.showEpisodeMo.star >= DungeonEnum.StarType.Advanced, var_38_0)
	end
end

function var_0_0.setStarImage(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	local var_39_0 = DungeonConfig.instance:getEpisodeCO(arg_39_3)
	local var_39_1 = VersionActivity2_5DungeonEnum.EpisodeStarType[var_39_0.chapterId]

	if arg_39_2 then
		local var_39_2 = var_39_1.light

		UISpriteSetMgr.instance:setV2a3DungeonSprite(arg_39_1, var_39_2)
	else
		local var_39_3 = var_39_1.empty

		UISpriteSetMgr.instance:setV2a3DungeonSprite(arg_39_1, var_39_3)
	end
end

function var_0_0.refreshMode(arg_40_0)
	gohelper.setActive(arg_40_0._gotype1, arg_40_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story)
	gohelper.setActive(arg_40_0._gotype2, arg_40_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story2)
	gohelper.setActive(arg_40_0._gotype3, arg_40_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story3)
	gohelper.setActive(arg_40_0._gotype4, arg_40_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard)

	local var_40_0 = not arg_40_0.modeCanFight or arg_40_0.needPlayUnlockModeAnimation

	gohelper.setActive(arg_40_0._gotype0, var_40_0)

	if var_40_0 then
		arg_40_0.lockTypeAnimator.enabled = true
		arg_40_0.txtLockType.text = luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[arg_40_0.mode])

		if arg_40_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story2 then
			SLFramework.UGUI.GuiHelper.SetColor(arg_40_0.txtLockType, "#757563")
		elseif arg_40_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story3 then
			SLFramework.UGUI.GuiHelper.SetColor(arg_40_0.txtLockType, "#757563")
		end
	end

	gohelper.setActive(arg_40_0.lockTypeIconGo, var_40_0)
end

function var_0_0.refreshArrow(arg_41_0)
	local var_41_0 = arg_41_0.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Hard and arg_41_0.isSpecialEpisode

	gohelper.setActive(arg_41_0._btnleftarrow.gameObject, var_41_0)
	gohelper.setActive(arg_41_0._btnrightarrow.gameObject, var_41_0)

	if var_41_0 then
		gohelper.setActive(arg_41_0.leftArrowLight, arg_41_0.modeIndex ~= 1)
		gohelper.setActive(arg_41_0.leftArrowDisable, arg_41_0.modeIndex == 1)

		local var_41_1 = #arg_41_0.modeList == arg_41_0.modeIndex

		gohelper.setActive(arg_41_0.rightArrowLight, not var_41_1)
		gohelper.setActive(arg_41_0.rightArrowDisable, var_41_1)
	end
end

function var_0_0.refreshReward(arg_42_0)
	local var_42_0 = {}
	local var_42_1 = 0
	local var_42_2 = 0

	if arg_42_0.showEpisodeMo.star ~= DungeonEnum.StarType.Advanced then
		tabletool.addValues(var_42_0, DungeonModel.instance:getEpisodeAdvancedBonus(arg_42_0.showEpisodeCo.id))

		var_42_2 = #var_42_0
	end

	if arg_42_0.showEpisodeMo.star == DungeonEnum.StarType.None then
		tabletool.addValues(var_42_0, DungeonModel.instance:getEpisodeFirstBonus(arg_42_0.showEpisodeCo.id))

		var_42_1 = #var_42_0
	end

	tabletool.addValues(var_42_0, DungeonModel.instance:getEpisodeReward(arg_42_0.showEpisodeCo.id))
	tabletool.addValues(var_42_0, DungeonModel.instance:getEpisodeRewardDisplayList(arg_42_0.showEpisodeCo.id))

	local var_42_3 = #var_42_0

	gohelper.setActive(arg_42_0._gorewards, var_42_3 > 0)
	gohelper.setActive(arg_42_0._gonorewards, var_42_3 == 0)

	if var_42_3 == 0 then
		return
	end

	local var_42_4 = math.min(#var_42_0, 3)
	local var_42_5
	local var_42_6

	for iter_42_0 = 1, var_42_4 do
		local var_42_7 = arg_42_0.rewardItems[iter_42_0]

		if not var_42_7 then
			var_42_7 = arg_42_0:getUserDataTb_()
			var_42_7.go = gohelper.cloneInPlace(arg_42_0._goactivityrewarditem, "item" .. iter_42_0)
			var_42_7.iconItem = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(var_42_7.go, "itemicon"))
			var_42_7.gonormal = gohelper.findChild(var_42_7.go, "rare/#go_rare1")
			var_42_7.gofirst = gohelper.findChild(var_42_7.go, "rare/#go_rare2")
			var_42_7.goadvance = gohelper.findChild(var_42_7.go, "rare/#go_rare3")
			var_42_7.gofirsthard = gohelper.findChild(var_42_7.go, "rare/#go_rare4")
			var_42_7.txtnormal = gohelper.findChildText(var_42_7.go, "rare/#go_rare1/txt")

			table.insert(arg_42_0.rewardItems, var_42_7)
		end

		local var_42_8 = var_42_0[iter_42_0]

		gohelper.setActive(var_42_7.gonormal, false)
		gohelper.setActive(var_42_7.gofirst, false)
		gohelper.setActive(var_42_7.goadvance, false)
		gohelper.setActive(var_42_7.gofirsthard, false)

		local var_42_9
		local var_42_10
		local var_42_11 = var_42_8[3]
		local var_42_12 = true

		if arg_42_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
			var_42_9 = var_42_7.gofirsthard
			var_42_10 = var_42_7.goadvance
		else
			var_42_9 = var_42_7.gofirst
			var_42_10 = var_42_7.goadvance
		end

		if iter_42_0 <= var_42_2 then
			gohelper.setActive(var_42_10, true)
		elseif iter_42_0 <= var_42_1 then
			gohelper.setActive(var_42_9, true)
		else
			gohelper.setActive(var_42_7.gonormal, true)

			local var_42_13 = var_42_8[3]

			var_42_12 = true

			if var_42_8.tagType then
				var_42_13 = var_42_8.tagType
				var_42_12 = var_42_11 ~= 0
			elseif #var_42_8 >= 4 then
				var_42_11 = var_42_8[4]
			else
				var_42_12 = false
			end

			var_42_7.txtnormal.text = luaLang("dungeon_prob_flag" .. var_42_13)
		end

		var_42_7.iconItem:setMOValue(var_42_8[1], var_42_8[2], var_42_11, nil, true)
		var_42_7.iconItem:setCountFontSize(40)
		var_42_7.iconItem:setHideLvAndBreakFlag(true)
		var_42_7.iconItem:hideEquipLvAndBreak(true)
		var_42_7.iconItem:isShowCount(var_42_12)
		gohelper.setActive(var_42_7.go, true)
	end

	for iter_42_1 = var_42_4 + 1, #arg_42_0.rewardItems do
		gohelper.setActive(arg_42_0.rewardItems[iter_42_1].go, false)
	end
end

function var_0_0.refreshStartBtn(arg_43_0)
	arg_43_0:refreshCostPower()

	local var_43_0 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	local var_43_1 = ResUrl.getCurrencyItemIcon(var_43_0.icon .. "_btn")

	arg_43_0._simagepower:LoadImage(var_43_1)

	local var_43_2 = arg_43_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard
	local var_43_3 = not var_43_2

	gohelper.setActive(arg_43_0._btnnormalStart.gameObject, arg_43_0.modeCanFight and var_43_3)
	gohelper.setActive(arg_43_0._btnhardStart.gameObject, var_43_2)
	gohelper.setActive(arg_43_0._btnlockStart.gameObject, not arg_43_0.modeCanFight or arg_43_0.needPlayUnlockModeAnimation)

	local var_43_4 = arg_43_0.storyIdList and #arg_43_0.storyIdList > 0
	local var_43_5 = VersionActivityDungeonBaseEnum.DungeonMode.Story
	local var_43_6 = arg_43_0.mode2EpisodeDict and arg_43_0.mode2EpisodeDict[var_43_5]
	local var_43_7 = var_43_6 and var_43_6.id or arg_43_0.originEpisodeConfig.id
	local var_43_8 = DungeonModel.instance:hasPassLevelAndStory(var_43_7)

	gohelper.setActive(arg_43_0._btnreplayStory.gameObject, var_43_8 and var_43_4)

	if var_43_2 then
		return
	end

	if arg_43_0.modeCanFight then
		local var_43_9 = DungeonModel.instance:hasPassLevel(arg_43_0.showEpisodeCo.id)
		local var_43_10 = StoryModel.instance:isStoryFinished(arg_43_0.showEpisodeCo.afterStory)

		if var_43_9 and arg_43_0.showEpisodeCo.afterStory > 0 and not var_43_10 then
			arg_43_0._txtnorstarttext.text = luaLang("p_dungeonlevelview_continuestory")

			recthelper.setAnchorX(arg_43_0._txtnorstarttext.gameObject.transform, 0)
			recthelper.setAnchorX(arg_43_0._txtnorstarttexten.gameObject.transform, 0)
			gohelper.setActive(arg_43_0._txtusepowernormal.gameObject, false)
			gohelper.setActive(arg_43_0._simagepower.gameObject, false)
		else
			arg_43_0._txtnorstarttext.text = luaLang("p_dungeonlevelview_startfight")

			recthelper.setAnchorX(arg_43_0._txtnorstarttext.gameObject.transform, 121)
			recthelper.setAnchorX(arg_43_0._txtnorstarttexten.gameObject.transform, 121)
			gohelper.setActive(arg_43_0._txtusepowernormal.gameObject, true)
			gohelper.setActive(arg_43_0._simagepower.gameObject, true)
		end
	else
		gohelper.setActive(arg_43_0._simagepower.gameObject, false)
		gohelper.setActive(arg_43_0._txtusepowernormal.gameObject, false)
	end
end

function var_0_0.refreshCostPower(arg_44_0)
	local var_44_0 = 0

	if not string.nilorempty(arg_44_0.showEpisodeCo.cost) then
		var_44_0 = string.splitToNumber(arg_44_0.showEpisodeCo.cost, "#")[3]
	end

	arg_44_0._txtusepowernormal.text = "-" .. var_44_0
	arg_44_0._txtusepowerhard.text = "-" .. var_44_0

	if var_44_0 <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(arg_44_0._txtusepowernormal, "#070706")
		SLFramework.UGUI.GuiHelper.SetColor(arg_44_0._txtusepowerhard, "#FFEAEA")
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_44_0._txtusepowernormal, "#800015")
		SLFramework.UGUI.GuiHelper.SetColor(arg_44_0._txtusepowerhard, "#C44945")
	end
end

function var_0_0.refreshEye(arg_45_0)
	if not (arg_45_0.originEpisodeConfig.displayMark == 1) then
		gohelper.setActive(arg_45_0._gonormaleye, false)
		gohelper.setActive(arg_45_0._gohardeye, false)

		return
	end

	local var_45_0 = arg_45_0.originEpisodeConfig.chapterId == VersionActivity2_5DungeonEnum.DungeonChapterId.Hard

	gohelper.setActive(arg_45_0._gonormaleye, not var_45_0)
	gohelper.setActive(arg_45_0._gohardeye, var_45_0)
end

function var_0_0.playModeUnlockAnimation(arg_46_0)
	if not arg_46_0.needPlayUnlockModeAnimation then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_difficulty)
	arg_46_0:_playModeUnLockAnimation(UIAnimationName.Unlock)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity2_5DungeonEnum.BlockKey.MapLevelViewPlayUnlockAnim)
	TaskDispatcher.runDelay(arg_46_0.onModeUnlockAnimationPlayDone, arg_46_0, var_0_3)
end

function var_0_0._playModeUnLockAnimation(arg_47_0, arg_47_1)
	arg_47_0.lockTypeAnimator.enabled = true

	arg_47_0.lockTypeAnimator:Play(arg_47_1)
	arg_47_0.startBtnAnimator:Play(arg_47_1)
end

function var_0_0.onModeUnlockAnimationPlayDone(arg_48_0)
	arg_48_0:_playModeUnLockAnimation(UIAnimationName.Idle)

	arg_48_0.unlockedEpisodeModeDict[tostring(arg_48_0.specialEpisodeId)] = arg_48_0.mode

	local var_48_0 = VersionActivity2_5DungeonEnum.PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastUnLockMode
	local var_48_1 = cjson.encode(arg_48_0.unlockedEpisodeModeDict)

	VersionActivity2_5DungeonController.instance:savePlayerPrefs(var_48_0, var_48_1)

	arg_48_0.needPlayUnlockModeAnimation = false

	arg_48_0:refreshMode()
	arg_48_0:refreshStartBtn()
	UIBlockMgr.instance:endBlock(VersionActivity2_5DungeonEnum.BlockKey.MapLevelViewPlayUnlockAnim)
end

function var_0_0.onClose(arg_49_0)
	TaskDispatcher.cancelTask(arg_49_0.playModeUnlockAnimation, arg_49_0)
	TaskDispatcher.cancelTask(arg_49_0.onModeUnlockAnimationPlayDone, arg_49_0)
	UIBlockMgr.instance:endBlock(VersionActivity2_5DungeonEnum.BlockKey.MapLevelViewPlayUnlockAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.onDestroyView(arg_50_0)
	arg_50_0.rewardItems = nil

	arg_50_0._simagepower:UnLoadImage()
end

return var_0_0
