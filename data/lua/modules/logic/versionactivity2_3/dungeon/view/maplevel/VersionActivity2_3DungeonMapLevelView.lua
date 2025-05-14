module("modules.logic.versionactivity2_3.dungeon.view.maplevel.VersionActivity2_3DungeonMapLevelView", package.seeall)

local var_0_0 = class("VersionActivity2_3DungeonMapLevelView", BaseView)
local var_0_1 = 0.4
local var_0_2 = 2.7

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goVersionActivity = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity")
	arg_1_0.animator = arg_1_0.goVersionActivity:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_1_0.goVersionActivity)
	arg_1_0.animationEventWrap = arg_1_0.goVersionActivity:GetComponent(typeof(ZProj.AnimationEventWrap))
	arg_1_0._simageactivitynormalbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/versionactivity/bgmask/#simage_activitynormalbg")
	arg_1_0._simageactivityhardbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/versionactivity/bgmask/#simage_activityhardbg")
	arg_1_0._txtmapName = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName")
	arg_1_0._txtmapNameEn = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNameEn")
	arg_1_0._txtmapNum = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum")
	arg_1_0._txtmapChapterIndex = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/#txt_mapChapterIndex")
	arg_1_0._gonormaleye = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/#image_normal")
	arg_1_0._gohardeye = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/#image_hard")
	arg_1_0._imagestar1 = gohelper.findChildImage(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/stars/starLayout/#image_star1")
	arg_1_0._imagestar2 = gohelper.findChildImage(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/stars/starLayout/#image_star2")
	arg_1_0._goswitch = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch")
	arg_1_0._gotype1 = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type1")
	arg_1_0._gotype2 = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type2")
	arg_1_0._gotype3 = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type3")
	arg_1_0._gotype4 = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type4")
	arg_1_0._gotype0 = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type0")
	arg_1_0._btnleftarrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_leftarrow")
	arg_1_0._btnrightarrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_rightarrow")
	arg_1_0._gorecommend = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_recommend")
	arg_1_0._txtrecommendlv = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_recommend/txt/#txt_recommendlv")
	arg_1_0._txtactivitydesc = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/content/#txt_activitydesc")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/#go_rewards")
	arg_1_0._goactivityrewarditem = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/#go_rewards/rewardList/#go_activityrewarditem")
	arg_1_0._btnactivityreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/#go_rewards/#btn_activityreward")
	arg_1_0._gonorewards = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/#go_norewards")
	arg_1_0.startBtnAnimator = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/startBtn"):GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._btnnormalStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart")
	arg_1_0._txtusepowernormal = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/#txt_usepowernormal")
	arg_1_0._txtnorstarttext = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/#txt_norstarttext")
	arg_1_0._txtnorstarttexten = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/#txt_norstarttexten")
	arg_1_0._btnhardStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_hardStart")
	arg_1_0._txtusepowerhard = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_hardStart/#txt_usepowerhard")
	arg_1_0._btnlockStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_lock")
	arg_1_0._simagepower = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#simage_power")
	arg_1_0._btnreplayStory = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_replayStory")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "anim/#go_righttop")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "anim/#go_lefttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0._onCurrencyChange, arg_2_0)
	arg_2_0._btnleftarrow:AddClickListener(arg_2_0._btnleftarrowOnClick, arg_2_0)
	arg_2_0._btnrightarrow:AddClickListener(arg_2_0._btnrightarrowOnClick, arg_2_0)
	arg_2_0._btnactivityreward:AddClickListener(arg_2_0._btnactivityrewardOnClick, arg_2_0)
	arg_2_0._btnnormalStart:AddClickListener(arg_2_0._btnnormalStartOnClick, arg_2_0)
	arg_2_0._btnhardStart:AddClickListener(arg_2_0._btnhardStartOnClick, arg_2_0)
	arg_2_0._btnlockStart:AddClickListener(arg_2_0._btnlockStartOnClick, arg_2_0)
	arg_2_0._btnreplayStory:AddClickListener(arg_2_0._btnreplayStoryOnClick, arg_2_0)
	arg_2_0.animationEventWrap:AddEventListener("refresh", arg_2_0.refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0._onCurrencyChange, arg_3_0)
	arg_3_0._btnleftarrow:RemoveClickListener()
	arg_3_0._btnrightarrow:RemoveClickListener()
	arg_3_0._btnactivityreward:RemoveClickListener()
	arg_3_0._btnnormalStart:RemoveClickListener()
	arg_3_0._btnhardStart:RemoveClickListener()
	arg_3_0._btnlockStart:RemoveClickListener()
	arg_3_0._btnreplayStory:RemoveClickListener()
	arg_3_0.animationEventWrap:RemoveAllEventListener()
end

function var_0_0._onCurrencyChange(arg_4_0, arg_4_1)
	if not arg_4_1[CurrencyEnum.CurrencyType.Power] then
		return
	end

	arg_4_0:refreshCostPower()
end

function var_0_0._btnleftarrowOnClick(arg_5_0)
	if arg_5_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard or #arg_5_0.mode2EpisodeDict == 1 or arg_5_0.modeIndex <= 1 then
		return
	end

	arg_5_0.modeIndex = arg_5_0.modeIndex - 1

	arg_5_0:refreshUIByMode(arg_5_0.modeList[arg_5_0.modeIndex])
end

function var_0_0._btnrightarrowOnClick(arg_6_0)
	if arg_6_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard or #arg_6_0.mode2EpisodeDict == 1 or arg_6_0.modeIndex >= #arg_6_0.modeList then
		return
	end

	arg_6_0.modeIndex = arg_6_0.modeIndex + 1

	arg_6_0:refreshUIByMode(arg_6_0.modeList[arg_6_0.modeIndex])
end

function var_0_0.refreshUIByMode(arg_7_0, arg_7_1)
	if arg_7_0.mode == arg_7_1 then
		return
	end

	arg_7_0.animator:Play(UIAnimationName.Switch, 0, 0)

	arg_7_0.mode = arg_7_1
	arg_7_0.showEpisodeCo = arg_7_0.mode2EpisodeDict[arg_7_0.mode]
	arg_7_0.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(arg_7_0.showEpisodeCo.id)

	if not arg_7_0.showEpisodeMo then
		arg_7_0.showEpisodeMo = UserDungeonMO.New()

		arg_7_0.showEpisodeMo:initFromManual(arg_7_0.showEpisodeCo.chapterId, arg_7_0.showEpisodeCo.id, 0, 0)
	end
end

function var_0_0._btnactivityrewardOnClick(arg_8_0)
	DungeonController.instance:openDungeonRewardView(arg_8_0.showEpisodeCo)
end

function var_0_0._btnnormalStartOnClick(arg_9_0)
	if arg_9_0.modeCanFight then
		arg_9_0:startBattle()
	else
		arg_9_0:_btnlockStartOnClick()
	end
end

function var_0_0._btnhardStartOnClick(arg_10_0)
	arg_10_0:startBattle()
end

function var_0_0.startBattle(arg_11_0)
	if arg_11_0.showEpisodeCo.type == DungeonEnum.EpisodeType.Story then
		if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SkipStroy) or arg_11_0.showEpisodeCo.beforeStory == 0 then
			arg_11_0:_playSkipMainStory()
		else
			arg_11_0:_playMainStory()
		end

		return
	end

	if arg_11_0.isSpecialEpisode then
		arg_11_0.lastEpisodeSelectModeDict[tostring(arg_11_0.specialEpisodeId)] = arg_11_0.mode

		local var_11_0 = VersionActivity2_3DungeonEnum.PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastSelectMode
		local var_11_1 = cjson.encode(arg_11_0.lastEpisodeSelectModeDict)

		VersionActivity2_3DungeonController.instance:savePlayerPrefs(var_11_0, var_11_1)
	end

	if DungeonModel.instance:hasPassLevelAndStory(arg_11_0.showEpisodeCo.id) then
		arg_11_0:_enterFight()

		return
	end

	if arg_11_0.showEpisodeCo.beforeStory > 0 then
		if not StoryModel.instance:isStoryFinished(arg_11_0.showEpisodeCo.beforeStory) then
			arg_11_0:_playStoryAndEnterFight(arg_11_0.showEpisodeCo.beforeStory)

			return
		end

		if arg_11_0.showEpisodeMo.star <= DungeonEnum.StarType.None then
			arg_11_0:_enterFight()

			return
		end

		if arg_11_0.showEpisodeCo.afterStory > 0 and not StoryModel.instance:isStoryFinished(arg_11_0.showEpisodeCo.afterStory) then
			arg_11_0:playAfterStory(arg_11_0.showEpisodeCo.afterStory)

			return
		end
	end

	arg_11_0:_enterFight()
end

function var_0_0._playSkipMainStory(arg_12_0)
	DungeonRpc.instance:sendStartDungeonRequest(arg_12_0.showEpisodeCo.chapterId, arg_12_0.showEpisodeCo.id)
	arg_12_0:onStoryFinished()
end

function var_0_0._playMainStory(arg_13_0)
	DungeonRpc.instance:sendStartDungeonRequest(arg_13_0.showEpisodeCo.chapterId, arg_13_0.showEpisodeCo.id)

	local var_13_0 = {}

	var_13_0.mark = true
	var_13_0.episodeId = arg_13_0.showEpisodeCo.id

	StoryController.instance:playStory(arg_13_0.showEpisodeCo.beforeStory, var_13_0, arg_13_0.onStoryFinished, arg_13_0)
end

function var_0_0.onStoryFinished(arg_14_0)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(arg_14_0.showEpisodeCo.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
	arg_14_0:closeThis()
end

function var_0_0._playStoryAndEnterFight(arg_15_0, arg_15_1)
	if StoryModel.instance:isStoryFinished(arg_15_1) then
		arg_15_0:_enterFight()

		return
	end

	local var_15_0 = {}

	var_15_0.mark = true
	var_15_0.episodeId = arg_15_0.showEpisodeCo.id

	StoryController.instance:playStory(arg_15_1, var_15_0, arg_15_0._enterFight, arg_15_0)
end

function var_0_0._enterFight(arg_16_0)
	DungeonFightController.instance:enterFight(arg_16_0.showEpisodeCo.chapterId, arg_16_0.showEpisodeCo.id, 1)
end

function var_0_0.playAfterStory(arg_17_0, arg_17_1)
	local var_17_0 = {}

	var_17_0.mark = true
	var_17_0.episodeId = arg_17_0.showEpisodeCo.id

	StoryController.instance:playStory(arg_17_1, var_17_0, function()
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo, nil)

		DungeonMapModel.instance.playAfterStory = true

		arg_17_0:closeThis()
	end, arg_17_0)
end

function var_0_0._btnlockStartOnClick(arg_19_0)
	local var_19_0 = arg_19_0:getPreModeName()

	GameFacade.showToast(ToastEnum.VersionActivityCanFight, var_19_0)
end

function var_0_0.getPreModeName(arg_20_0)
	local var_20_0 = arg_20_0.modeIndex - 1
	local var_20_1 = arg_20_0.modeList[var_20_0]

	if not var_20_1 then
		logWarn("not modeIndex mode : " .. var_20_0)

		return ""
	end

	return luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[var_20_1])
end

function var_0_0._btnreplayStoryOnClick(arg_21_0)
	if not arg_21_0.storyIdList or #arg_21_0.storyIdList < 1 then
		return
	end

	StoryController.instance:playStories(arg_21_0.storyIdList)

	local var_21_0 = {}

	var_21_0.isLeiMiTeActivityStory = true

	StoryController.instance:resetStoryParam(var_21_0)
end

function var_0_0._editableInitView(arg_22_0)
	arg_22_0.rewardItems = {}

	gohelper.setActive(arg_22_0._goactivityrewarditem, false)
	gohelper.setActive(arg_22_0._gonormaleye, false)
	gohelper.setActive(arg_22_0._gohardeye, false)

	arg_22_0.lockTypeAnimator = arg_22_0._gotype0:GetComponent(typeof(UnityEngine.Animator))
	arg_22_0.txtLockType = gohelper.findChildText(arg_22_0._gotype0, "txt")
	arg_22_0.lockTypeIconGo = gohelper.findChild(arg_22_0._gotype0, "txt/icon")
	arg_22_0.leftArrowLight = gohelper.findChild(arg_22_0._btnleftarrow.gameObject, "left_arrow")
	arg_22_0.leftArrowDisable = gohelper.findChild(arg_22_0._btnleftarrow.gameObject, "left_arrow_disable")
	arg_22_0.rightArrowLight = gohelper.findChild(arg_22_0._btnrightarrow.gameObject, "right_arrow")
	arg_22_0.rightArrowDisable = gohelper.findChild(arg_22_0._btnrightarrow.gameObject, "right_arrow_disable")

	arg_22_0:initLocalEpisodeMode()
end

function var_0_0.initLocalEpisodeMode(arg_23_0)
	local var_23_0 = VersionActivity2_3DungeonEnum.PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastUnLockMode
	local var_23_1 = VersionActivity2_3DungeonController.instance:getPlayerPrefs(var_23_0, "")

	arg_23_0.unlockedEpisodeModeDict = VersionActivity2_3DungeonController.instance:loadDictFromStr(var_23_1)

	local var_23_2 = VersionActivity2_3DungeonEnum.PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastSelectMode
	local var_23_3 = VersionActivity2_3DungeonController.instance:getPlayerPrefs(var_23_2, "")

	arg_23_0.lastEpisodeSelectModeDict = VersionActivity2_3DungeonController.instance:loadDictFromStr(var_23_3)
end

function var_0_0.onUpdateParam(arg_24_0)
	arg_24_0:onOpen()
	arg_24_0.animator:Play(UIAnimationName.Open, 0, 0)
end

function var_0_0.onOpen(arg_25_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_pagesopen)
	arg_25_0:initViewParam()
	arg_25_0:initMode()
	arg_25_0:markSelectEpisode()
	arg_25_0:refreshStoryIdList()
	arg_25_0:refreshBg()
	arg_25_0:refreshUI()
	arg_25_0.animator:Play(UIAnimationName.Open, 0, 0)
end

function var_0_0.initViewParam(arg_26_0)
	arg_26_0.originEpisodeId = arg_26_0.viewParam.episodeId
	arg_26_0.originEpisodeConfig = DungeonConfig.instance:getEpisodeCO(arg_26_0.originEpisodeId)
	arg_26_0.isFromJump = arg_26_0.viewParam.isJump
	arg_26_0.index = VersionActivity2_3DungeonConfig.instance:getEpisodeIndex(arg_26_0.originEpisodeId)

	arg_26_0.viewContainer:setOpenedEpisodeId(arg_26_0.originEpisodeId)

	arg_26_0.showEpisodeCo = DungeonConfig.instance:getEpisodeCO(arg_26_0.originEpisodeId)
	arg_26_0.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(arg_26_0.originEpisodeId)
end

function var_0_0.initMode(arg_27_0)
	arg_27_0.mode = ActivityConfig.instance:getChapterIdMode(arg_27_0.originEpisodeConfig.chapterId)
	arg_27_0.modeIndex = 1

	if arg_27_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		return
	end

	arg_27_0.modeList = {
		VersionActivityDungeonBaseEnum.DungeonMode.Story,
		VersionActivityDungeonBaseEnum.DungeonMode.Story2,
		VersionActivityDungeonBaseEnum.DungeonMode.Story3
	}

	local var_27_0 = DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(arg_27_0.originEpisodeConfig)

	arg_27_0.mode2EpisodeDict = {}

	for iter_27_0, iter_27_1 in ipairs(var_27_0) do
		local var_27_1 = ActivityConfig.instance:getChapterIdMode(iter_27_1.chapterId)

		arg_27_0.mode2EpisodeDict[var_27_1] = iter_27_1
	end

	arg_27_0.isSpecialEpisode = #var_27_0 > 1
	arg_27_0.specialEpisodeId = var_27_0[1].id

	if not arg_27_0.isSpecialEpisode then
		return
	end

	if arg_27_0.isFromJump then
		arg_27_0:checkNeedPlayModeUnLockAnimation()
	else
		local var_27_2

		for iter_27_2 = #var_27_0, 1, -1 do
			local var_27_3 = var_27_0[iter_27_2]

			if DungeonModel.instance:hasPassLevelAndStory(var_27_3.preEpisode) then
				arg_27_0.mode = arg_27_0.modeList[iter_27_2]

				break
			end
		end

		arg_27_0:checkNeedPlayModeUnLockAnimation()

		if not arg_27_0.needPlayUnlockModeAnimation then
			arg_27_0.mode = arg_27_0.lastEpisodeSelectModeDict[tostring(arg_27_0.specialEpisodeId)] or VersionActivityDungeonBaseEnum.DungeonMode.Story
		end
	end

	for iter_27_3, iter_27_4 in ipairs(arg_27_0.modeList) do
		if iter_27_4 == arg_27_0.mode then
			arg_27_0.modeIndex = iter_27_3

			break
		end
	end

	arg_27_0.showEpisodeCo = arg_27_0.mode2EpisodeDict[arg_27_0.mode]
	arg_27_0.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(arg_27_0.showEpisodeCo.id)

	if not arg_27_0.showEpisodeMo then
		arg_27_0.showEpisodeMo = UserDungeonMO.New()

		arg_27_0.showEpisodeMo:initFromManual(arg_27_0.showEpisodeCo.chapterId, arg_27_0.showEpisodeCo.id, 0, 0)
	end
end

function var_0_0.checkNeedPlayModeUnLockAnimation(arg_28_0)
	local var_28_0 = arg_28_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story

	if arg_28_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard or arg_28_0.mode == var_28_0 then
		arg_28_0.needPlayUnlockModeAnimation = false
	else
		arg_28_0.needPlayUnlockModeAnimation = (arg_28_0.unlockedEpisodeModeDict[tostring(arg_28_0.specialEpisodeId)] or VersionActivityDungeonBaseEnum.DungeonMode.Story) < arg_28_0.mode
	end
end

function var_0_0.markSelectEpisode(arg_29_0)
	if arg_29_0.originEpisodeConfig.type == DungeonEnum.EpisodeType.Normal then
		VersionActivityDungeonBaseController.instance:setChapterIdLastSelectEpisodeId(arg_29_0.originEpisodeConfig.chapterId, arg_29_0.originEpisodeId)
	end
end

function var_0_0.refreshStoryIdList(arg_30_0)
	local var_30_0 = arg_30_0.originEpisodeConfig.type == DungeonEnum.EpisodeType.Story
	local var_30_1 = arg_30_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard

	if var_30_0 or var_30_1 then
		arg_30_0.storyIdList = nil

		return
	end

	local var_30_2 = arg_30_0.originEpisodeConfig
	local var_30_3 = VersionActivityDungeonBaseEnum.DungeonMode.Story
	local var_30_4 = arg_30_0.mode2EpisodeDict and arg_30_0.mode2EpisodeDict[var_30_3]

	if var_30_4 then
		var_30_2 = var_30_4
	end

	arg_30_0.storyIdList = {}

	local var_30_5 = var_30_2.beforeStory

	if var_30_5 > 0 and StoryModel.instance:isStoryHasPlayed(var_30_5) then
		table.insert(arg_30_0.storyIdList, var_30_5)
	end

	local var_30_6 = var_30_2.afterStory

	if var_30_6 > 0 and StoryModel.instance:isStoryHasPlayed(var_30_6) then
		table.insert(arg_30_0.storyIdList, var_30_6)
	end
end

function var_0_0.refreshBg(arg_31_0)
	gohelper.setActive(arg_31_0._simageactivitynormalbg.gameObject, arg_31_0.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Hard)
	gohelper.setActive(arg_31_0._simageactivityhardbg.gameObject, arg_31_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard)
end

function var_0_0.refreshUI(arg_32_0)
	arg_32_0:refreshModeCanFight()
	arg_32_0:refreshEpisodeTextInfo()
	arg_32_0:refreshStar()
	arg_32_0:refreshMode()
	arg_32_0:refreshArrow()
	arg_32_0:refreshReward()
	arg_32_0:refreshStartBtn()
	arg_32_0:refreshEye()

	if arg_32_0.needPlayUnlockModeAnimation then
		TaskDispatcher.runDelay(arg_32_0.playModeUnlockAnimation, arg_32_0, var_0_1)
	end
end

function var_0_0.refreshModeCanFight(arg_33_0)
	if arg_33_0.showEpisodeCo.preEpisode == 0 then
		arg_33_0.modeCanFight = true

		return
	end

	arg_33_0.modeCanFight = DungeonModel.instance:hasPassLevelAndStory(arg_33_0.showEpisodeCo.preEpisode)
end

function var_0_0.refreshEpisodeTextInfo(arg_34_0)
	local var_34_0 = DungeonConfig.instance:getChapterCO(arg_34_0.showEpisodeCo.chapterId)
	local var_34_1

	if var_34_0.id == VersionActivity2_3DungeonEnum.DungeonChapterId.Story then
		var_34_1 = arg_34_0.showEpisodeCo
	else
		var_34_1 = VersionActivity2_3DungeonConfig.instance:getStoryEpisodeCo(arg_34_0.showEpisodeCo.id)
	end

	arg_34_0._txtmapName.text = arg_34_0:buildEpisodeName(var_34_1)

	local var_34_2 = arg_34_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard and "#cfccc9" or "#cfccc9"

	arg_34_0._txtmapNameEn.text = arg_34_0:buildColorText(var_34_1.name_En, var_34_2)
	arg_34_0._txtmapNum.text = arg_34_0:buildColorText(string.format("%02d", arg_34_0.index), var_34_2)
	arg_34_0._txtmapChapterIndex.text = arg_34_0:buildColorText(var_34_0.chapterIndex .. " .", var_34_2)
	arg_34_0._txtactivitydesc.text = var_34_1.desc

	local var_34_3 = DungeonHelper.getEpisodeRecommendLevel(arg_34_0.showEpisodeCo.id)

	gohelper.setActive(arg_34_0._gorecommend, var_34_3 > 0)

	if var_34_3 > 0 then
		arg_34_0._txtrecommendlv.text = HeroConfig.instance:getCommonLevelDisplay(var_34_3)
	end
end

function var_0_0.buildEpisodeName(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_1.name
	local var_35_1 = GameUtil.utf8sub(var_35_0, 1, 1)
	local var_35_2 = ""
	local var_35_3 = GameUtil.utf8len(var_35_0)

	if var_35_3 > 1 then
		var_35_2 = GameUtil.utf8sub(var_35_0, 2, var_35_3 - 1)
	end

	local var_35_4 = arg_35_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard and "#cfccc9" or "#cfccc9"

	return arg_35_0:buildColorText(string.format("<size=112>%s</size>%s", var_35_1, var_35_2), var_35_4)
end

function var_0_0.buildColorText(arg_36_0, arg_36_1, arg_36_2)
	return string.format("<color=%s>%s</color>", arg_36_2, arg_36_1)
end

function var_0_0.refreshStar(arg_37_0)
	local var_37_0 = arg_37_0.showEpisodeCo.id
	local var_37_1 = var_37_0 and DungeonModel.instance:hasPassLevelAndStory(var_37_0)
	local var_37_2 = DungeonConfig.instance:getEpisodeAdvancedConditionText(var_37_0)

	arg_37_0:setStarImage(arg_37_0._imagestar1, var_37_1, var_37_0)

	if string.nilorempty(var_37_2) then
		gohelper.setActive(arg_37_0._imagestar2.gameObject, false)
	else
		gohelper.setActive(arg_37_0._imagestar2.gameObject, true)
		arg_37_0:setStarImage(arg_37_0._imagestar2, var_37_1 and arg_37_0.showEpisodeMo.star >= DungeonEnum.StarType.Advanced, var_37_0)
	end
end

function var_0_0.setStarImage(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = DungeonConfig.instance:getEpisodeCO(arg_38_3)
	local var_38_1 = VersionActivity2_3DungeonEnum.EpisodeStarType[var_38_0.chapterId]

	if arg_38_2 then
		local var_38_2 = var_38_1.light

		UISpriteSetMgr.instance:setV2a3DungeonSprite(arg_38_1, var_38_2)
	else
		local var_38_3 = var_38_1.empty

		UISpriteSetMgr.instance:setV2a3DungeonSprite(arg_38_1, var_38_3)
	end
end

function var_0_0.refreshMode(arg_39_0)
	gohelper.setActive(arg_39_0._gotype1, arg_39_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story)
	gohelper.setActive(arg_39_0._gotype2, arg_39_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story2)
	gohelper.setActive(arg_39_0._gotype3, arg_39_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story3)
	gohelper.setActive(arg_39_0._gotype4, arg_39_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard)

	local var_39_0 = not arg_39_0.modeCanFight or arg_39_0.needPlayUnlockModeAnimation

	gohelper.setActive(arg_39_0._gotype0, var_39_0)

	if var_39_0 then
		arg_39_0.lockTypeAnimator.enabled = true
		arg_39_0.txtLockType.text = luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[arg_39_0.mode])

		if arg_39_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story2 then
			SLFramework.UGUI.GuiHelper.SetColor(arg_39_0.txtLockType, "#757563")
		elseif arg_39_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story3 then
			SLFramework.UGUI.GuiHelper.SetColor(arg_39_0.txtLockType, "#757563")
		end
	end

	gohelper.setActive(arg_39_0.lockTypeIconGo, var_39_0)
end

function var_0_0.refreshArrow(arg_40_0)
	local var_40_0 = arg_40_0.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Hard and arg_40_0.isSpecialEpisode

	gohelper.setActive(arg_40_0._btnleftarrow.gameObject, var_40_0)
	gohelper.setActive(arg_40_0._btnrightarrow.gameObject, var_40_0)

	if var_40_0 then
		gohelper.setActive(arg_40_0.leftArrowLight, arg_40_0.modeIndex ~= 1)
		gohelper.setActive(arg_40_0.leftArrowDisable, arg_40_0.modeIndex == 1)

		local var_40_1 = #arg_40_0.modeList == arg_40_0.modeIndex

		gohelper.setActive(arg_40_0.rightArrowLight, not var_40_1)
		gohelper.setActive(arg_40_0.rightArrowDisable, var_40_1)
	end
end

function var_0_0.refreshReward(arg_41_0)
	local var_41_0 = {}
	local var_41_1 = 0
	local var_41_2 = 0

	if arg_41_0.showEpisodeMo.star ~= DungeonEnum.StarType.Advanced then
		tabletool.addValues(var_41_0, DungeonModel.instance:getEpisodeAdvancedBonus(arg_41_0.showEpisodeCo.id))

		var_41_2 = #var_41_0
	end

	if arg_41_0.showEpisodeMo.star == DungeonEnum.StarType.None then
		tabletool.addValues(var_41_0, DungeonModel.instance:getEpisodeFirstBonus(arg_41_0.showEpisodeCo.id))

		var_41_1 = #var_41_0
	end

	tabletool.addValues(var_41_0, DungeonModel.instance:getEpisodeReward(arg_41_0.showEpisodeCo.id))
	tabletool.addValues(var_41_0, DungeonModel.instance:getEpisodeRewardDisplayList(arg_41_0.showEpisodeCo.id))

	local var_41_3 = #var_41_0

	gohelper.setActive(arg_41_0._gorewards, var_41_3 > 0)
	gohelper.setActive(arg_41_0._gonorewards, var_41_3 == 0)

	if var_41_3 == 0 then
		return
	end

	local var_41_4 = math.min(#var_41_0, 3)
	local var_41_5
	local var_41_6

	for iter_41_0 = 1, var_41_4 do
		local var_41_7 = arg_41_0.rewardItems[iter_41_0]

		if not var_41_7 then
			var_41_7 = arg_41_0:getUserDataTb_()
			var_41_7.go = gohelper.cloneInPlace(arg_41_0._goactivityrewarditem, "item" .. iter_41_0)
			var_41_7.iconItem = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(var_41_7.go, "itemicon"))
			var_41_7.gonormal = gohelper.findChild(var_41_7.go, "rare/#go_rare1")
			var_41_7.gofirst = gohelper.findChild(var_41_7.go, "rare/#go_rare2")
			var_41_7.goadvance = gohelper.findChild(var_41_7.go, "rare/#go_rare3")
			var_41_7.gofirsthard = gohelper.findChild(var_41_7.go, "rare/#go_rare4")
			var_41_7.txtnormal = gohelper.findChildText(var_41_7.go, "rare/#go_rare1/txt")

			table.insert(arg_41_0.rewardItems, var_41_7)
		end

		local var_41_8 = var_41_0[iter_41_0]

		gohelper.setActive(var_41_7.gonormal, false)
		gohelper.setActive(var_41_7.gofirst, false)
		gohelper.setActive(var_41_7.goadvance, false)
		gohelper.setActive(var_41_7.gofirsthard, false)

		local var_41_9
		local var_41_10
		local var_41_11 = var_41_8[3]
		local var_41_12 = true

		if arg_41_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
			var_41_9 = var_41_7.gofirsthard
			var_41_10 = var_41_7.goadvance
		else
			var_41_9 = var_41_7.gofirst
			var_41_10 = var_41_7.goadvance
		end

		if iter_41_0 <= var_41_2 then
			gohelper.setActive(var_41_10, true)
		elseif iter_41_0 <= var_41_1 then
			gohelper.setActive(var_41_9, true)
		else
			gohelper.setActive(var_41_7.gonormal, true)

			local var_41_13 = var_41_8[3]

			var_41_12 = true

			if var_41_8.tagType then
				var_41_13 = var_41_8.tagType
				var_41_12 = var_41_11 ~= 0
			elseif #var_41_8 >= 4 then
				var_41_11 = var_41_8[4]
			else
				var_41_12 = false
			end

			var_41_7.txtnormal.text = luaLang("dungeon_prob_flag" .. var_41_13)
		end

		var_41_7.iconItem:setMOValue(var_41_8[1], var_41_8[2], var_41_11, nil, true)
		var_41_7.iconItem:setCountFontSize(40)
		var_41_7.iconItem:setHideLvAndBreakFlag(true)
		var_41_7.iconItem:hideEquipLvAndBreak(true)
		var_41_7.iconItem:isShowCount(var_41_12)
		gohelper.setActive(var_41_7.go, true)
	end

	for iter_41_1 = var_41_4 + 1, #arg_41_0.rewardItems do
		gohelper.setActive(arg_41_0.rewardItems[iter_41_1].go, false)
	end
end

function var_0_0.refreshStartBtn(arg_42_0)
	arg_42_0:refreshCostPower()

	local var_42_0 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	local var_42_1 = ResUrl.getCurrencyItemIcon(var_42_0.icon .. "_btn")

	arg_42_0._simagepower:LoadImage(var_42_1)

	local var_42_2 = arg_42_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard
	local var_42_3 = not var_42_2

	gohelper.setActive(arg_42_0._btnnormalStart.gameObject, arg_42_0.modeCanFight and var_42_3)
	gohelper.setActive(arg_42_0._btnhardStart.gameObject, var_42_2)
	gohelper.setActive(arg_42_0._btnlockStart.gameObject, not arg_42_0.modeCanFight or arg_42_0.needPlayUnlockModeAnimation)

	local var_42_4 = arg_42_0.storyIdList and #arg_42_0.storyIdList > 0
	local var_42_5 = VersionActivityDungeonBaseEnum.DungeonMode.Story
	local var_42_6 = arg_42_0.mode2EpisodeDict and arg_42_0.mode2EpisodeDict[var_42_5]
	local var_42_7 = var_42_6 and var_42_6.id or arg_42_0.originEpisodeConfig.id
	local var_42_8 = DungeonModel.instance:hasPassLevelAndStory(var_42_7)

	gohelper.setActive(arg_42_0._btnreplayStory.gameObject, var_42_8 and var_42_4)

	if var_42_2 then
		return
	end

	if arg_42_0.modeCanFight then
		local var_42_9 = DungeonModel.instance:hasPassLevel(arg_42_0.showEpisodeCo.id)
		local var_42_10 = StoryModel.instance:isStoryFinished(arg_42_0.showEpisodeCo.afterStory)

		if var_42_9 and arg_42_0.showEpisodeCo.afterStory > 0 and not var_42_10 then
			arg_42_0._txtnorstarttext.text = luaLang("p_dungeonlevelview_continuestory")

			recthelper.setAnchorX(arg_42_0._txtnorstarttext.gameObject.transform, 0)
			recthelper.setAnchorX(arg_42_0._txtnorstarttexten.gameObject.transform, 0)
			gohelper.setActive(arg_42_0._txtusepowernormal.gameObject, false)
			gohelper.setActive(arg_42_0._simagepower.gameObject, false)
		else
			arg_42_0._txtnorstarttext.text = luaLang("p_dungeonlevelview_startfight")

			recthelper.setAnchorX(arg_42_0._txtnorstarttext.gameObject.transform, 121)
			recthelper.setAnchorX(arg_42_0._txtnorstarttexten.gameObject.transform, 121)
			gohelper.setActive(arg_42_0._txtusepowernormal.gameObject, true)
			gohelper.setActive(arg_42_0._simagepower.gameObject, true)
		end
	else
		gohelper.setActive(arg_42_0._simagepower.gameObject, false)
		gohelper.setActive(arg_42_0._txtusepowernormal.gameObject, false)
	end
end

function var_0_0.refreshCostPower(arg_43_0)
	local var_43_0 = 0

	if not string.nilorempty(arg_43_0.showEpisodeCo.cost) then
		var_43_0 = string.splitToNumber(arg_43_0.showEpisodeCo.cost, "#")[3]
	end

	arg_43_0._txtusepowernormal.text = "-" .. var_43_0
	arg_43_0._txtusepowerhard.text = "-" .. var_43_0

	if var_43_0 <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(arg_43_0._txtusepowernormal, "#070706")
		SLFramework.UGUI.GuiHelper.SetColor(arg_43_0._txtusepowerhard, "#FFEAEA")
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_43_0._txtusepowernormal, "#800015")
		SLFramework.UGUI.GuiHelper.SetColor(arg_43_0._txtusepowerhard, "#C44945")
	end
end

function var_0_0.refreshEye(arg_44_0)
	if not (arg_44_0.originEpisodeConfig.displayMark == 1) then
		gohelper.setActive(arg_44_0._gonormaleye, false)
		gohelper.setActive(arg_44_0._gohardeye, false)

		return
	end

	local var_44_0 = arg_44_0.originEpisodeConfig.chapterId == VersionActivity2_3DungeonEnum.DungeonChapterId.Hard

	gohelper.setActive(arg_44_0._gonormaleye, not var_44_0)
	gohelper.setActive(arg_44_0._gohardeye, var_44_0)
end

function var_0_0.playModeUnlockAnimation(arg_45_0)
	if not arg_45_0.needPlayUnlockModeAnimation then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_difficulty)
	arg_45_0:_playModeUnLockAnimation(UIAnimationName.Unlock)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity2_3DungeonEnum.BlockKey.MapLevelViewPlayUnlockAnim)
	TaskDispatcher.runDelay(arg_45_0.onModeUnlockAnimationPlayDone, arg_45_0, var_0_2)
end

function var_0_0._playModeUnLockAnimation(arg_46_0, arg_46_1)
	arg_46_0.lockTypeAnimator.enabled = true

	arg_46_0.lockTypeAnimator:Play(arg_46_1)
	arg_46_0.startBtnAnimator:Play(arg_46_1)
end

function var_0_0.onModeUnlockAnimationPlayDone(arg_47_0)
	arg_47_0:_playModeUnLockAnimation(UIAnimationName.Idle)

	arg_47_0.unlockedEpisodeModeDict[tostring(arg_47_0.specialEpisodeId)] = arg_47_0.mode

	local var_47_0 = VersionActivity2_3DungeonEnum.PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastUnLockMode
	local var_47_1 = cjson.encode(arg_47_0.unlockedEpisodeModeDict)

	VersionActivity2_3DungeonController.instance:savePlayerPrefs(var_47_0, var_47_1)

	arg_47_0.needPlayUnlockModeAnimation = false

	arg_47_0:refreshMode()
	arg_47_0:refreshStartBtn()
	UIBlockMgr.instance:endBlock(VersionActivity2_3DungeonEnum.BlockKey.MapLevelViewPlayUnlockAnim)
end

function var_0_0.onClose(arg_48_0)
	TaskDispatcher.cancelTask(arg_48_0.playModeUnlockAnimation, arg_48_0)
	TaskDispatcher.cancelTask(arg_48_0.onModeUnlockAnimationPlayDone, arg_48_0)
	UIBlockMgr.instance:endBlock(VersionActivity2_3DungeonEnum.BlockKey.MapLevelViewPlayUnlockAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.onDestroyView(arg_49_0)
	arg_49_0.rewardItems = nil

	arg_49_0._simagepower:UnLoadImage()
end

return var_0_0
