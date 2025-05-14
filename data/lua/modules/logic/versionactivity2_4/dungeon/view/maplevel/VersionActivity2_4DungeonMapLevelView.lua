module("modules.logic.versionactivity2_4.dungeon.view.maplevel.VersionActivity2_4DungeonMapLevelView", package.seeall)

local var_0_0 = class("VersionActivity2_4DungeonMapLevelView", BaseView)
local var_0_1 = {
	2410123
}
local var_0_2 = {
	2410102
}

function var_0_0._buildEpisodeName_overseas(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = LangSettings.instance:isJp()
	local var_1_1 = arg_1_0.showEpisodeCo.id
	local var_1_2 = false
	local var_1_3 = false

	if var_1_0 then
		for iter_1_0, iter_1_1 in ipairs(var_0_1) do
			if iter_1_1 == var_1_1 then
				var_1_2 = true
			end
		end

		if not var_1_2 then
			for iter_1_2, iter_1_3 in ipairs(var_0_2) do
				if iter_1_3 == var_1_1 then
					var_1_3 = true
				end
			end
		end
	end

	local var_1_4 = arg_1_0._txtmapName.transform

	if var_1_3 then
		recthelper.setHeight(var_1_4, 140)

		return string.format("<size=74>%s</size>%s", arg_1_1, arg_1_2)
	elseif var_1_2 then
		recthelper.setHeight(var_1_4, 110)

		return string.format("<size=80>%s</size>%s", arg_1_1, arg_1_2)
	else
		recthelper.setHeight(var_1_4, 160)

		return string.format("<size=112>%s</size>%s", arg_1_1, arg_1_2)
	end
end

local var_0_3 = 0.4
local var_0_4 = 2.7

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
	arg_3_0:addEventCb(VersionActivity2_4SudokuController.instance, VersionActivity2_4DungeonEvent.SudokuCompleted, arg_3_0._onSudokuCompleted, arg_3_0)
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
	arg_4_0:removeEventCb(VersionActivity2_4SudokuController.instance, VersionActivity2_4DungeonEvent.SudokuCompleted, arg_4_0._onSudokuCompleted, arg_4_0)
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

function var_0_0._onSudokuCompleted(arg_6_0)
	if arg_6_0.showEpisodeCo.id ~= VersionActivity2_4Enum.SudokuEpisodeId then
		return
	end

	DungeonRpc.instance:sendEndDungeonRequest(false)

	if not StoryModel.instance:isStoryFinished(arg_6_0.showEpisodeCo.afterStory) then
		arg_6_0:playSudokuAfterStory(arg_6_0.showEpisodeCo.afterStory)

		return
	end
end

function var_0_0._btnleftarrowOnClick(arg_7_0)
	if arg_7_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard or #arg_7_0.mode2EpisodeDict == 1 or arg_7_0.modeIndex <= 1 then
		return
	end

	arg_7_0.modeIndex = arg_7_0.modeIndex - 1

	arg_7_0:refreshUIByMode(arg_7_0.modeList[arg_7_0.modeIndex])
end

function var_0_0._btnrightarrowOnClick(arg_8_0)
	if arg_8_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard or #arg_8_0.mode2EpisodeDict == 1 or arg_8_0.modeIndex >= #arg_8_0.modeList then
		return
	end

	arg_8_0.modeIndex = arg_8_0.modeIndex + 1

	arg_8_0:refreshUIByMode(arg_8_0.modeList[arg_8_0.modeIndex])
end

function var_0_0.refreshUIByMode(arg_9_0, arg_9_1)
	if arg_9_0.mode == arg_9_1 then
		return
	end

	arg_9_0.animator:Play(UIAnimationName.Switch, 0, 0)

	arg_9_0.mode = arg_9_1
	arg_9_0.showEpisodeCo = arg_9_0.mode2EpisodeDict[arg_9_0.mode]
	arg_9_0.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(arg_9_0.showEpisodeCo.id)

	if not arg_9_0.showEpisodeMo then
		arg_9_0.showEpisodeMo = UserDungeonMO.New()

		arg_9_0.showEpisodeMo:initFromManual(arg_9_0.showEpisodeCo.chapterId, arg_9_0.showEpisodeCo.id, 0, 0)
	end
end

function var_0_0._btnactivityrewardOnClick(arg_10_0)
	DungeonController.instance:openDungeonRewardView(arg_10_0.showEpisodeCo)
end

function var_0_0._btnnormalStartOnClick(arg_11_0)
	if arg_11_0.modeCanFight then
		arg_11_0:startBattle()
	else
		arg_11_0:_btnlockStartOnClick()
	end
end

function var_0_0._btnhardStartOnClick(arg_12_0)
	arg_12_0:startBattle()
end

function var_0_0.startBattle(arg_13_0)
	if arg_13_0.showEpisodeCo.id == VersionActivity2_4Enum.SudokuEpisodeId then
		arg_13_0:_playStoryAndOpenSudoku(arg_13_0.showEpisodeCo.beforeStory)

		return
	elseif arg_13_0.showEpisodeCo.type == DungeonEnum.EpisodeType.Story then
		if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SkipStroy) or arg_13_0.showEpisodeCo.beforeStory == 0 then
			arg_13_0:_playSkipMainStory()
		else
			arg_13_0:_playMainStory()
		end

		return
	end

	if arg_13_0.isSpecialEpisode then
		arg_13_0.lastEpisodeSelectModeDict[tostring(arg_13_0.specialEpisodeId)] = arg_13_0.mode

		local var_13_0 = VersionActivity2_4DungeonEnum.PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastSelectMode
		local var_13_1 = cjson.encode(arg_13_0.lastEpisodeSelectModeDict)

		VersionActivity2_4DungeonController.instance:savePlayerPrefs(var_13_0, var_13_1)
	end

	if DungeonModel.instance:hasPassLevelAndStory(arg_13_0.showEpisodeCo.id) then
		arg_13_0:_enterFight()

		return
	end

	if arg_13_0.showEpisodeCo.beforeStory > 0 then
		if not StoryModel.instance:isStoryFinished(arg_13_0.showEpisodeCo.beforeStory) then
			arg_13_0:_playStoryAndEnterFight(arg_13_0.showEpisodeCo.beforeStory)

			return
		end

		if arg_13_0.showEpisodeMo.star <= DungeonEnum.StarType.None then
			arg_13_0:_enterFight()

			return
		end

		if arg_13_0.showEpisodeCo.afterStory > 0 and not StoryModel.instance:isStoryFinished(arg_13_0.showEpisodeCo.afterStory) then
			arg_13_0:playAfterStory(arg_13_0.showEpisodeCo.afterStory)

			return
		end
	end

	arg_13_0:_enterFight()
end

function var_0_0._playSkipMainStory(arg_14_0)
	DungeonRpc.instance:sendStartDungeonRequest(arg_14_0.showEpisodeCo.chapterId, arg_14_0.showEpisodeCo.id)
	arg_14_0:onStoryFinished()
end

function var_0_0._playMainStory(arg_15_0)
	DungeonRpc.instance:sendStartDungeonRequest(arg_15_0.showEpisodeCo.chapterId, arg_15_0.showEpisodeCo.id)

	local var_15_0 = {}

	var_15_0.mark = true
	var_15_0.episodeId = arg_15_0.showEpisodeCo.id

	StoryController.instance:playStory(arg_15_0.showEpisodeCo.beforeStory, var_15_0, arg_15_0.onStoryFinished, arg_15_0)
end

function var_0_0.onStoryFinished(arg_16_0)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(arg_16_0.showEpisodeCo.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
	arg_16_0:closeThis()
end

function var_0_0._playStoryAndEnterFight(arg_17_0, arg_17_1)
	if StoryModel.instance:isStoryFinished(arg_17_1) then
		arg_17_0:_enterFight()

		return
	end

	local var_17_0 = {}

	var_17_0.mark = true
	var_17_0.episodeId = arg_17_0.showEpisodeCo.id

	StoryController.instance:playStory(arg_17_1, var_17_0, arg_17_0._enterFight, arg_17_0)
end

function var_0_0._enterFight(arg_18_0)
	DungeonFightController.instance:enterFight(arg_18_0.showEpisodeCo.chapterId, arg_18_0.showEpisodeCo.id, 1)
end

function var_0_0.playAfterStory(arg_19_0, arg_19_1)
	local var_19_0 = {}

	var_19_0.mark = true
	var_19_0.episodeId = arg_19_0.showEpisodeCo.id

	StoryController.instance:playStory(arg_19_1, var_19_0, function()
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo, nil)

		DungeonMapModel.instance.playAfterStory = true

		arg_19_0:closeThis()
	end, arg_19_0)
end

function var_0_0._playStoryAndOpenSudoku(arg_21_0, arg_21_1)
	DungeonRpc.instance:sendStartDungeonRequest(arg_21_0.showEpisodeCo.chapterId, arg_21_0.showEpisodeCo.id)

	if StoryModel.instance:isStoryFinished(arg_21_1) then
		arg_21_0:_openSudokuView()

		return
	end

	local var_21_0 = {}

	var_21_0.mark = true
	var_21_0.episodeId = arg_21_0.showEpisodeCo.id

	StoryController.instance:playStory(arg_21_1, var_21_0, arg_21_0._openSudokuView, arg_21_0)
end

function var_0_0._openSudokuView(arg_22_0)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(arg_22_0.showEpisodeCo.id)
	VersionActivity2_4SudokuController.instance:openSudokuView()
end

function var_0_0.playSudokuAfterStory(arg_23_0, arg_23_1)
	local var_23_0 = {}

	var_23_0.mark = true
	var_23_0.episodeId = arg_23_0.showEpisodeCo.id

	StoryController.instance:playStory(arg_23_1, var_23_0, function()
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo, nil)

		DungeonMapModel.instance.playAfterStory = true

		arg_23_0:closeThis()
	end, arg_23_0)
end

function var_0_0._btnlockStartOnClick(arg_25_0)
	local var_25_0 = arg_25_0:getPreModeName()

	GameFacade.showToast(ToastEnum.VersionActivityCanFight, var_25_0)
end

function var_0_0.getPreModeName(arg_26_0)
	local var_26_0 = arg_26_0.modeIndex - 1
	local var_26_1 = arg_26_0.modeList[var_26_0]

	if not var_26_1 then
		logWarn("not modeIndex mode : " .. var_26_0)

		return ""
	end

	return luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[var_26_1])
end

function var_0_0._btnreplayStoryOnClick(arg_27_0)
	if not arg_27_0.storyIdList or #arg_27_0.storyIdList < 1 then
		return
	end

	StoryController.instance:playStories(arg_27_0.storyIdList)

	local var_27_0 = {}

	var_27_0.isLeiMiTeActivityStory = true

	StoryController.instance:resetStoryParam(var_27_0)
end

function var_0_0._editableInitView(arg_28_0)
	arg_28_0.rewardItems = {}

	gohelper.setActive(arg_28_0._goactivityrewarditem, false)
	gohelper.setActive(arg_28_0._gonormaleye, false)
	gohelper.setActive(arg_28_0._gohardeye, false)

	arg_28_0.lockTypeAnimator = arg_28_0._gotype0:GetComponent(typeof(UnityEngine.Animator))
	arg_28_0.txtLockType = gohelper.findChildText(arg_28_0._gotype0, "txt")
	arg_28_0.lockTypeIconGo = gohelper.findChild(arg_28_0._gotype0, "txt/icon")
	arg_28_0.leftArrowLight = gohelper.findChild(arg_28_0._btnleftarrow.gameObject, "left_arrow")
	arg_28_0.leftArrowDisable = gohelper.findChild(arg_28_0._btnleftarrow.gameObject, "left_arrow_disable")
	arg_28_0.rightArrowLight = gohelper.findChild(arg_28_0._btnrightarrow.gameObject, "right_arrow")
	arg_28_0.rightArrowDisable = gohelper.findChild(arg_28_0._btnrightarrow.gameObject, "right_arrow_disable")

	arg_28_0:initLocalEpisodeMode()
end

function var_0_0.initLocalEpisodeMode(arg_29_0)
	local var_29_0 = VersionActivity2_4DungeonEnum.PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastUnLockMode
	local var_29_1 = VersionActivity2_4DungeonController.instance:getPlayerPrefs(var_29_0, "")

	arg_29_0.unlockedEpisodeModeDict = VersionActivity2_4DungeonController.instance:loadDictFromStr(var_29_1)

	local var_29_2 = VersionActivity2_4DungeonEnum.PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastSelectMode
	local var_29_3 = VersionActivity2_4DungeonController.instance:getPlayerPrefs(var_29_2, "")

	arg_29_0.lastEpisodeSelectModeDict = VersionActivity2_4DungeonController.instance:loadDictFromStr(var_29_3)
end

function var_0_0.onUpdateParam(arg_30_0)
	arg_30_0:onOpen()
	arg_30_0.animator:Play(UIAnimationName.Open, 0, 0)
end

function var_0_0.onOpen(arg_31_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_pagesopen)
	arg_31_0:initViewParam()
	arg_31_0:initMode()
	arg_31_0:markSelectEpisode()
	arg_31_0:refreshStoryIdList()
	arg_31_0:refreshBg()
	arg_31_0:refreshUI()
	arg_31_0.animator:Play(UIAnimationName.Open, 0, 0)
end

function var_0_0.initViewParam(arg_32_0)
	arg_32_0.originEpisodeId = arg_32_0.viewParam.episodeId
	arg_32_0.originEpisodeConfig = DungeonConfig.instance:getEpisodeCO(arg_32_0.originEpisodeId)
	arg_32_0.isFromJump = arg_32_0.viewParam.isJump
	arg_32_0.index = VersionActivity2_4DungeonConfig.instance:getEpisodeIndex(arg_32_0.originEpisodeId)

	arg_32_0.viewContainer:setOpenedEpisodeId(arg_32_0.originEpisodeId)

	arg_32_0.showEpisodeCo = DungeonConfig.instance:getEpisodeCO(arg_32_0.originEpisodeId)
	arg_32_0.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(arg_32_0.originEpisodeId)
end

function var_0_0.initMode(arg_33_0)
	arg_33_0.mode = ActivityConfig.instance:getChapterIdMode(arg_33_0.originEpisodeConfig.chapterId)
	arg_33_0.modeIndex = 1

	if arg_33_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		return
	end

	arg_33_0.modeList = {
		VersionActivityDungeonBaseEnum.DungeonMode.Story,
		VersionActivityDungeonBaseEnum.DungeonMode.Story2,
		VersionActivityDungeonBaseEnum.DungeonMode.Story3
	}

	local var_33_0 = DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(arg_33_0.originEpisodeConfig)

	arg_33_0.mode2EpisodeDict = {}

	for iter_33_0, iter_33_1 in ipairs(var_33_0) do
		local var_33_1 = ActivityConfig.instance:getChapterIdMode(iter_33_1.chapterId)

		arg_33_0.mode2EpisodeDict[var_33_1] = iter_33_1
	end

	arg_33_0.isSpecialEpisode = #var_33_0 > 1
	arg_33_0.specialEpisodeId = var_33_0[1].id

	if not arg_33_0.isSpecialEpisode then
		return
	end

	if arg_33_0.isFromJump then
		arg_33_0:checkNeedPlayModeUnLockAnimation()
	else
		local var_33_2

		for iter_33_2 = #var_33_0, 1, -1 do
			local var_33_3 = var_33_0[iter_33_2]

			if DungeonModel.instance:hasPassLevelAndStory(var_33_3.preEpisode) then
				arg_33_0.mode = arg_33_0.modeList[iter_33_2]

				break
			end
		end

		arg_33_0:checkNeedPlayModeUnLockAnimation()

		if not arg_33_0.needPlayUnlockModeAnimation then
			arg_33_0.mode = arg_33_0.lastEpisodeSelectModeDict[tostring(arg_33_0.specialEpisodeId)] or VersionActivityDungeonBaseEnum.DungeonMode.Story
		end
	end

	for iter_33_3, iter_33_4 in ipairs(arg_33_0.modeList) do
		if iter_33_4 == arg_33_0.mode then
			arg_33_0.modeIndex = iter_33_3

			break
		end
	end

	arg_33_0.showEpisodeCo = arg_33_0.mode2EpisodeDict[arg_33_0.mode]
	arg_33_0.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(arg_33_0.showEpisodeCo.id)

	if not arg_33_0.showEpisodeMo then
		arg_33_0.showEpisodeMo = UserDungeonMO.New()

		arg_33_0.showEpisodeMo:initFromManual(arg_33_0.showEpisodeCo.chapterId, arg_33_0.showEpisodeCo.id, 0, 0)
	end
end

function var_0_0.checkNeedPlayModeUnLockAnimation(arg_34_0)
	local var_34_0 = arg_34_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story

	if arg_34_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard or arg_34_0.mode == var_34_0 then
		arg_34_0.needPlayUnlockModeAnimation = false
	else
		arg_34_0.needPlayUnlockModeAnimation = (arg_34_0.unlockedEpisodeModeDict[tostring(arg_34_0.specialEpisodeId)] or VersionActivityDungeonBaseEnum.DungeonMode.Story) < arg_34_0.mode
	end
end

function var_0_0.markSelectEpisode(arg_35_0)
	if arg_35_0.originEpisodeConfig.type == DungeonEnum.EpisodeType.Normal then
		VersionActivityDungeonBaseController.instance:setChapterIdLastSelectEpisodeId(arg_35_0.originEpisodeConfig.chapterId, arg_35_0.originEpisodeId)
	end
end

function var_0_0.refreshStoryIdList(arg_36_0)
	local var_36_0 = arg_36_0.originEpisodeConfig.type == DungeonEnum.EpisodeType.Story
	local var_36_1 = arg_36_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard

	if arg_36_0.showEpisodeCo.id == VersionActivity2_4Enum.SudokuEpisodeId then
		arg_36_0.storyIdList = {}

		local var_36_2 = arg_36_0.originEpisodeConfig.beforeStory

		if var_36_2 > 0 and StoryModel.instance:isStoryHasPlayed(var_36_2) then
			table.insert(arg_36_0.storyIdList, var_36_2)
		end

		local var_36_3 = arg_36_0.originEpisodeConfig.afterStory

		if var_36_3 > 0 and StoryModel.instance:isStoryHasPlayed(var_36_3) then
			table.insert(arg_36_0.storyIdList, var_36_3)
		end
	elseif var_36_0 or var_36_1 then
		arg_36_0.storyIdList = nil

		return
	else
		local var_36_4 = arg_36_0.originEpisodeConfig
		local var_36_5 = VersionActivityDungeonBaseEnum.DungeonMode.Story
		local var_36_6 = arg_36_0.mode2EpisodeDict and arg_36_0.mode2EpisodeDict[var_36_5]

		if var_36_6 then
			var_36_4 = var_36_6
		end

		arg_36_0.storyIdList = {}

		local var_36_7 = var_36_4.beforeStory

		if var_36_7 > 0 and StoryModel.instance:isStoryHasPlayed(var_36_7) then
			table.insert(arg_36_0.storyIdList, var_36_7)
		end

		local var_36_8 = var_36_4.afterStory

		if var_36_8 > 0 and StoryModel.instance:isStoryHasPlayed(var_36_8) then
			table.insert(arg_36_0.storyIdList, var_36_8)
		end
	end
end

function var_0_0.refreshBg(arg_37_0)
	gohelper.setActive(arg_37_0._simageactivitynormalbg.gameObject, arg_37_0.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Hard)
	gohelper.setActive(arg_37_0._simageactivityhardbg.gameObject, arg_37_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard)
end

function var_0_0.refreshUI(arg_38_0)
	arg_38_0:refreshModeCanFight()
	arg_38_0:refreshEpisodeTextInfo()
	arg_38_0:refreshStar()
	arg_38_0:refreshMode()
	arg_38_0:refreshArrow()
	arg_38_0:refreshReward()
	arg_38_0:refreshStartBtn()
	arg_38_0:refreshEye()

	if arg_38_0.needPlayUnlockModeAnimation then
		TaskDispatcher.runDelay(arg_38_0.playModeUnlockAnimation, arg_38_0, var_0_3)
	end
end

function var_0_0.refreshModeCanFight(arg_39_0)
	if arg_39_0.showEpisodeCo.preEpisode == 0 then
		arg_39_0.modeCanFight = true

		return
	end

	arg_39_0.modeCanFight = DungeonModel.instance:hasPassLevelAndStory(arg_39_0.showEpisodeCo.preEpisode)
end

function var_0_0.refreshEpisodeTextInfo(arg_40_0)
	local var_40_0 = DungeonConfig.instance:getChapterCO(arg_40_0.showEpisodeCo.chapterId)
	local var_40_1

	if var_40_0.id == VersionActivity2_4DungeonEnum.DungeonChapterId.Story then
		var_40_1 = arg_40_0.showEpisodeCo
	else
		var_40_1 = VersionActivity2_4DungeonConfig.instance:getStoryEpisodeCo(arg_40_0.showEpisodeCo.id)
	end

	arg_40_0._txtmapName.text = arg_40_0:buildEpisodeName(var_40_1)

	local var_40_2 = arg_40_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard and "#cfccc9" or "#cfccc9"

	arg_40_0._txtmapNameEn.text = arg_40_0:buildColorText(var_40_1.name_En, var_40_2)
	arg_40_0._txtmapNum.text = arg_40_0:buildColorText(string.format("%02d", arg_40_0.index), var_40_2)
	arg_40_0._txtmapChapterIndex.text = arg_40_0:buildColorText(var_40_0.chapterIndex .. " .", var_40_2)
	arg_40_0._txtactivitydesc.text = var_40_1.desc

	local var_40_3 = DungeonHelper.getEpisodeRecommendLevel(arg_40_0.showEpisodeCo.id)

	gohelper.setActive(arg_40_0._gorecommend, var_40_3 > 0)

	if var_40_3 > 0 then
		arg_40_0._txtrecommendlv.text = HeroConfig.instance:getCommonLevelDisplay(var_40_3)
	end
end

function var_0_0.buildEpisodeName(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_1.name
	local var_41_1 = GameUtil.utf8sub(var_41_0, 1, 1)
	local var_41_2 = ""
	local var_41_3 = GameUtil.utf8len(var_41_0)

	if var_41_3 > 1 then
		var_41_2 = GameUtil.utf8sub(var_41_0, 2, var_41_3 - 1)
	end

	local var_41_4 = arg_41_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard and "#cfccc9" or "#cfccc9"

	return arg_41_0:buildColorText(arg_41_0:_buildEpisodeName_overseas(var_41_1, var_41_2), var_41_4)
end

function var_0_0.buildColorText(arg_42_0, arg_42_1, arg_42_2)
	return string.format("<color=%s>%s</color>", arg_42_2, arg_42_1)
end

function var_0_0.refreshStar(arg_43_0)
	local var_43_0 = arg_43_0.showEpisodeCo.id
	local var_43_1 = var_43_0 and DungeonModel.instance:hasPassLevelAndStory(var_43_0)
	local var_43_2 = DungeonConfig.instance:getEpisodeAdvancedConditionText(var_43_0)

	arg_43_0:setStarImage(arg_43_0._imagestar1, var_43_1, var_43_0)

	if string.nilorempty(var_43_2) then
		gohelper.setActive(arg_43_0._imagestar2.gameObject, false)
	else
		gohelper.setActive(arg_43_0._imagestar2.gameObject, true)
		arg_43_0:setStarImage(arg_43_0._imagestar2, var_43_1 and arg_43_0.showEpisodeMo.star >= DungeonEnum.StarType.Advanced, var_43_0)
	end
end

function var_0_0.setStarImage(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	local var_44_0 = DungeonConfig.instance:getEpisodeCO(arg_44_3)
	local var_44_1 = VersionActivity2_4DungeonEnum.EpisodeStarType[var_44_0.chapterId]

	if arg_44_2 then
		local var_44_2 = var_44_1.light

		UISpriteSetMgr.instance:setV2a4DungeonSprite(arg_44_1, var_44_2)
	else
		local var_44_3 = var_44_1.empty

		UISpriteSetMgr.instance:setV2a4DungeonSprite(arg_44_1, var_44_3)
	end
end

function var_0_0.refreshMode(arg_45_0)
	gohelper.setActive(arg_45_0._gotype1, arg_45_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story)
	gohelper.setActive(arg_45_0._gotype2, arg_45_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story2)
	gohelper.setActive(arg_45_0._gotype3, arg_45_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story3)
	gohelper.setActive(arg_45_0._gotype4, arg_45_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard)

	local var_45_0 = not arg_45_0.modeCanFight or arg_45_0.needPlayUnlockModeAnimation

	gohelper.setActive(arg_45_0._gotype0, var_45_0)

	if var_45_0 then
		arg_45_0.lockTypeAnimator.enabled = true
		arg_45_0.txtLockType.text = luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[arg_45_0.mode])

		if arg_45_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story2 then
			SLFramework.UGUI.GuiHelper.SetColor(arg_45_0.txtLockType, "#757563")
		elseif arg_45_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story3 then
			SLFramework.UGUI.GuiHelper.SetColor(arg_45_0.txtLockType, "#757563")
		end
	end

	gohelper.setActive(arg_45_0.lockTypeIconGo, var_45_0)
end

function var_0_0.refreshArrow(arg_46_0)
	local var_46_0 = arg_46_0.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Hard and arg_46_0.isSpecialEpisode

	gohelper.setActive(arg_46_0._btnleftarrow.gameObject, var_46_0)
	gohelper.setActive(arg_46_0._btnrightarrow.gameObject, var_46_0)

	if var_46_0 then
		gohelper.setActive(arg_46_0.leftArrowLight, arg_46_0.modeIndex ~= 1)
		gohelper.setActive(arg_46_0.leftArrowDisable, arg_46_0.modeIndex == 1)

		local var_46_1 = #arg_46_0.modeList == arg_46_0.modeIndex

		gohelper.setActive(arg_46_0.rightArrowLight, not var_46_1)
		gohelper.setActive(arg_46_0.rightArrowDisable, var_46_1)
	end
end

function var_0_0.refreshReward(arg_47_0)
	local var_47_0 = {}
	local var_47_1 = 0
	local var_47_2 = 0

	if arg_47_0.showEpisodeMo.star ~= DungeonEnum.StarType.Advanced then
		tabletool.addValues(var_47_0, DungeonModel.instance:getEpisodeAdvancedBonus(arg_47_0.showEpisodeCo.id))

		var_47_2 = #var_47_0
	end

	if arg_47_0.showEpisodeMo.star == DungeonEnum.StarType.None then
		tabletool.addValues(var_47_0, DungeonModel.instance:getEpisodeFirstBonus(arg_47_0.showEpisodeCo.id))

		var_47_1 = #var_47_0
	end

	tabletool.addValues(var_47_0, DungeonModel.instance:getEpisodeReward(arg_47_0.showEpisodeCo.id))
	tabletool.addValues(var_47_0, DungeonModel.instance:getEpisodeRewardDisplayList(arg_47_0.showEpisodeCo.id))

	local var_47_3 = #var_47_0

	gohelper.setActive(arg_47_0._gorewards, var_47_3 > 0)
	gohelper.setActive(arg_47_0._gonorewards, var_47_3 == 0)

	if var_47_3 == 0 then
		return
	end

	local var_47_4 = math.min(#var_47_0, 3)
	local var_47_5
	local var_47_6

	for iter_47_0 = 1, var_47_4 do
		local var_47_7 = arg_47_0.rewardItems[iter_47_0]

		if not var_47_7 then
			var_47_7 = arg_47_0:getUserDataTb_()
			var_47_7.go = gohelper.cloneInPlace(arg_47_0._goactivityrewarditem, "item" .. iter_47_0)
			var_47_7.iconItem = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(var_47_7.go, "itemicon"))
			var_47_7.gonormal = gohelper.findChild(var_47_7.go, "rare/#go_rare1")
			var_47_7.gofirst = gohelper.findChild(var_47_7.go, "rare/#go_rare2")
			var_47_7.goadvance = gohelper.findChild(var_47_7.go, "rare/#go_rare3")
			var_47_7.gofirsthard = gohelper.findChild(var_47_7.go, "rare/#go_rare4")
			var_47_7.txtnormal = gohelper.findChildText(var_47_7.go, "rare/#go_rare1/txt")

			table.insert(arg_47_0.rewardItems, var_47_7)
		end

		local var_47_8 = var_47_0[iter_47_0]

		gohelper.setActive(var_47_7.gonormal, false)
		gohelper.setActive(var_47_7.gofirst, false)
		gohelper.setActive(var_47_7.goadvance, false)
		gohelper.setActive(var_47_7.gofirsthard, false)

		local var_47_9
		local var_47_10
		local var_47_11 = var_47_8[3]
		local var_47_12 = true

		if arg_47_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
			var_47_9 = var_47_7.gofirsthard
			var_47_10 = var_47_7.goadvance
		else
			var_47_9 = var_47_7.gofirst
			var_47_10 = var_47_7.goadvance
		end

		if iter_47_0 <= var_47_2 then
			gohelper.setActive(var_47_10, true)
		elseif iter_47_0 <= var_47_1 then
			gohelper.setActive(var_47_9, true)
		else
			gohelper.setActive(var_47_7.gonormal, true)

			local var_47_13 = var_47_8[3]

			var_47_12 = true

			if var_47_8.tagType then
				var_47_13 = var_47_8.tagType
				var_47_12 = var_47_11 ~= 0
			elseif #var_47_8 >= 4 then
				var_47_11 = var_47_8[4]
			else
				var_47_12 = false
			end

			var_47_7.txtnormal.text = luaLang("dungeon_prob_flag" .. var_47_13)
		end

		var_47_7.iconItem:setMOValue(var_47_8[1], var_47_8[2], var_47_11, nil, true)
		var_47_7.iconItem:setCountFontSize(40)
		var_47_7.iconItem:setHideLvAndBreakFlag(true)
		var_47_7.iconItem:hideEquipLvAndBreak(true)
		var_47_7.iconItem:isShowCount(var_47_12)
		gohelper.setActive(var_47_7.go, true)
	end

	for iter_47_1 = var_47_4 + 1, #arg_47_0.rewardItems do
		gohelper.setActive(arg_47_0.rewardItems[iter_47_1].go, false)
	end
end

function var_0_0.refreshStartBtn(arg_48_0)
	arg_48_0:refreshCostPower()

	local var_48_0 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	local var_48_1 = ResUrl.getCurrencyItemIcon(var_48_0.icon .. "_btn")

	arg_48_0._simagepower:LoadImage(var_48_1)

	local var_48_2 = arg_48_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard
	local var_48_3 = not var_48_2

	gohelper.setActive(arg_48_0._btnnormalStart.gameObject, arg_48_0.modeCanFight and var_48_3)
	gohelper.setActive(arg_48_0._btnhardStart.gameObject, var_48_2)
	gohelper.setActive(arg_48_0._btnlockStart.gameObject, not arg_48_0.modeCanFight or arg_48_0.needPlayUnlockModeAnimation)

	local var_48_4 = arg_48_0.storyIdList and #arg_48_0.storyIdList > 0
	local var_48_5 = VersionActivityDungeonBaseEnum.DungeonMode.Story
	local var_48_6 = arg_48_0.mode2EpisodeDict and arg_48_0.mode2EpisodeDict[var_48_5]
	local var_48_7 = var_48_6 and var_48_6.id or arg_48_0.originEpisodeConfig.id
	local var_48_8 = DungeonModel.instance:hasPassLevelAndStory(var_48_7)

	gohelper.setActive(arg_48_0._btnreplayStory.gameObject, var_48_8 and var_48_4)

	if var_48_2 then
		return
	end

	if arg_48_0.modeCanFight then
		local var_48_9 = DungeonModel.instance:hasPassLevel(arg_48_0.showEpisodeCo.id)
		local var_48_10 = StoryModel.instance:isStoryFinished(arg_48_0.showEpisodeCo.afterStory)

		if var_48_9 and arg_48_0.showEpisodeCo.afterStory > 0 and not var_48_10 then
			arg_48_0._txtnorstarttext.text = luaLang("p_dungeonlevelview_continuestory")

			recthelper.setAnchorX(arg_48_0._txtnorstarttext.gameObject.transform, 0)
			recthelper.setAnchorX(arg_48_0._txtnorstarttexten.gameObject.transform, 0)
			gohelper.setActive(arg_48_0._txtusepowernormal.gameObject, false)
			gohelper.setActive(arg_48_0._simagepower.gameObject, false)
		else
			arg_48_0._txtnorstarttext.text = luaLang("p_dungeonlevelview_startfight")

			recthelper.setAnchorX(arg_48_0._txtnorstarttext.gameObject.transform, 121)
			recthelper.setAnchorX(arg_48_0._txtnorstarttexten.gameObject.transform, 121)
			gohelper.setActive(arg_48_0._txtusepowernormal.gameObject, true)
			gohelper.setActive(arg_48_0._simagepower.gameObject, true)
		end
	else
		gohelper.setActive(arg_48_0._simagepower.gameObject, false)
		gohelper.setActive(arg_48_0._txtusepowernormal.gameObject, false)
	end
end

function var_0_0.refreshCostPower(arg_49_0)
	local var_49_0 = 0

	if not string.nilorempty(arg_49_0.showEpisodeCo.cost) then
		var_49_0 = string.splitToNumber(arg_49_0.showEpisodeCo.cost, "#")[3]
	end

	arg_49_0._txtusepowernormal.text = "-" .. var_49_0
	arg_49_0._txtusepowerhard.text = "-" .. var_49_0

	if var_49_0 <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(arg_49_0._txtusepowernormal, "#070706")
		SLFramework.UGUI.GuiHelper.SetColor(arg_49_0._txtusepowerhard, "#FFEAEA")
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_49_0._txtusepowernormal, "#800015")
		SLFramework.UGUI.GuiHelper.SetColor(arg_49_0._txtusepowerhard, "#C44945")
	end
end

function var_0_0.refreshEye(arg_50_0)
	if not (arg_50_0.originEpisodeConfig.displayMark == 1) then
		gohelper.setActive(arg_50_0._gonormaleye, false)
		gohelper.setActive(arg_50_0._gohardeye, false)

		return
	end

	local var_50_0 = arg_50_0.originEpisodeConfig.chapterId == VersionActivity2_4DungeonEnum.DungeonChapterId.Hard

	gohelper.setActive(arg_50_0._gonormaleye, not var_50_0)
	gohelper.setActive(arg_50_0._gohardeye, var_50_0)
end

function var_0_0.playModeUnlockAnimation(arg_51_0)
	if not arg_51_0.needPlayUnlockModeAnimation then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_difficulty)
	arg_51_0:_playModeUnLockAnimation(UIAnimationName.Unlock)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity2_4DungeonEnum.BlockKey.MapLevelViewPlayUnlockAnim)
	TaskDispatcher.runDelay(arg_51_0.onModeUnlockAnimationPlayDone, arg_51_0, var_0_4)
end

function var_0_0._playModeUnLockAnimation(arg_52_0, arg_52_1)
	arg_52_0.lockTypeAnimator.enabled = true

	arg_52_0.lockTypeAnimator:Play(arg_52_1)
	arg_52_0.startBtnAnimator:Play(arg_52_1)
end

function var_0_0.onModeUnlockAnimationPlayDone(arg_53_0)
	arg_53_0:_playModeUnLockAnimation(UIAnimationName.Idle)

	arg_53_0.unlockedEpisodeModeDict[tostring(arg_53_0.specialEpisodeId)] = arg_53_0.mode

	local var_53_0 = VersionActivity2_4DungeonEnum.PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastUnLockMode
	local var_53_1 = cjson.encode(arg_53_0.unlockedEpisodeModeDict)

	VersionActivity2_4DungeonController.instance:savePlayerPrefs(var_53_0, var_53_1)

	arg_53_0.needPlayUnlockModeAnimation = false

	arg_53_0:refreshMode()
	arg_53_0:refreshStartBtn()
	UIBlockMgr.instance:endBlock(VersionActivity2_4DungeonEnum.BlockKey.MapLevelViewPlayUnlockAnim)
end

function var_0_0.onClose(arg_54_0)
	TaskDispatcher.cancelTask(arg_54_0.playModeUnlockAnimation, arg_54_0)
	TaskDispatcher.cancelTask(arg_54_0.onModeUnlockAnimationPlayDone, arg_54_0)
	UIBlockMgr.instance:endBlock(VersionActivity2_4DungeonEnum.BlockKey.MapLevelViewPlayUnlockAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.onDestroyView(arg_55_0)
	arg_55_0.rewardItems = nil

	arg_55_0._simagepower:UnLoadImage()
end

return var_0_0
