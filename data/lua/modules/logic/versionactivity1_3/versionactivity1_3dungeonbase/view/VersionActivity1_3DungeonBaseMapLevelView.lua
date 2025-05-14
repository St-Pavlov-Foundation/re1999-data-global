module("modules.logic.versionactivity1_3.versionactivity1_3dungeonbase.view.VersionActivity1_3DungeonBaseMapLevelView", package.seeall)

local var_0_0 = class("VersionActivity1_3DungeonBaseMapLevelView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btncloseview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeview")
	arg_1_0._simageactivitynormalbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/versionactivity/bgmask/#simage_activitynormalbg")
	arg_1_0._simageactivityhardbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/versionactivity/bgmask/#simage_activityhardbg")
	arg_1_0._txtmapName = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName")
	arg_1_0._txtmapNameEn = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNameEn")
	arg_1_0._txtmapNum = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum")
	arg_1_0._txtMapChapterIndex = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/#txt_mapChapterIndex")
	arg_1_0._gonormaleye = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/#image_normal")
	arg_1_0._gohardeye = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/#image_hard")
	arg_1_0._imagestar1 = gohelper.findChildImage(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/stars/starLayout/#image_star1")
	arg_1_0._imagestar2 = gohelper.findChildImage(arg_1_0.viewGO, "anim/versionactivity/right/title/#txt_mapName/#txt_mapNum/stars/starLayout/#image_star2")
	arg_1_0._goswitch = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch")
	arg_1_0._gotype0 = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type0")
	arg_1_0._gotype1 = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type1")
	arg_1_0._gotype2 = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type2")
	arg_1_0._gotype3 = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type3")
	arg_1_0._gotype4 = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type4")
	arg_1_0._btnleftarrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_leftarrow")
	arg_1_0._btnrightarrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_rightarrow")
	arg_1_0._gorecommond = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_recommend")
	arg_1_0._txtrecommondlv = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_recommend/txt/#txt_recommendlv")
	arg_1_0._txtactivitydesc = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/content/#txt_activitydesc")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/#go_rewards")
	arg_1_0._goactivityrewarditem = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/#go_rewards/rewardList/#go_activityrewarditem")
	arg_1_0._btnactivityreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/#go_rewards/#btn_activityreward")
	arg_1_0._gonorewards = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/#go_norewards")
	arg_1_0._btnnormalStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart")
	arg_1_0._txtusepowernormal = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/#txt_usepowernormal")
	arg_1_0._txtnorstarttext = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/#txt_norstarttext")
	arg_1_0._txtnorstarttexten = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart/#txt_norstarttexten")
	arg_1_0._btnhardStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_hardStart")
	arg_1_0._btnlockStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_lock")
	arg_1_0._txtusepowerhard = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_hardStart/#txt_usepowerhard")
	arg_1_0._simagepower = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#simage_power")
	arg_1_0._btnreplayStory = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_replayStory")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "anim/#go_righttop")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "anim/#go_lefttop")
	arg_1_0._goruledesc = gohelper.findChild(arg_1_0.viewGO, "anim/#go_ruledesc")
	arg_1_0._btncloserule = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/#go_ruledesc/#btn_closerule")
	arg_1_0._goruleitem = gohelper.findChild(arg_1_0.viewGO, "anim/#go_ruledesc/bg/#go_ruleitem")
	arg_1_0._goruleDescList = gohelper.findChild(arg_1_0.viewGO, "anim/#go_ruledesc/bg/#go_ruleDescList")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncloseview:AddClickListener(arg_2_0._btncloseviewOnClick, arg_2_0)
	arg_2_0._btnleftarrow:AddClickListener(arg_2_0._btnleftarrowOnClick, arg_2_0)
	arg_2_0._btnrightarrow:AddClickListener(arg_2_0._btnrightarrowOnClick, arg_2_0)
	arg_2_0._btnactivityreward:AddClickListener(arg_2_0._btnactivityrewardOnClick, arg_2_0)
	arg_2_0._btnnormalStart:AddClickListener(arg_2_0._btnnormalStartOnClick, arg_2_0)
	arg_2_0._btnhardStart:AddClickListener(arg_2_0._btnhardStartOnClick, arg_2_0)
	arg_2_0._btnlockStart:AddClickListener(arg_2_0._btnLockStartOnClick, arg_2_0)
	arg_2_0._btnreplayStory:AddClickListener(arg_2_0._btnreplayStoryOnClick, arg_2_0)
	arg_2_0._btncloserule:AddClickListener(arg_2_0._btncloseruleOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncloseview:RemoveClickListener()
	arg_3_0._btnleftarrow:RemoveClickListener()
	arg_3_0._btnrightarrow:RemoveClickListener()
	arg_3_0._btnactivityreward:RemoveClickListener()
	arg_3_0._btnnormalStart:RemoveClickListener()
	arg_3_0._btnlockStart:RemoveClickListener()
	arg_3_0._btnhardStart:RemoveClickListener()
	arg_3_0._btnreplayStory:RemoveClickListener()
	arg_3_0._btncloserule:RemoveClickListener()
end

function var_0_0._btnreplayStoryOnClick(arg_4_0)
	if not arg_4_0.storyIdList or #arg_4_0.storyIdList < 1 then
		return
	end

	StoryController.instance:playStories(arg_4_0.storyIdList)

	local var_4_0 = {}

	var_4_0.isLeiMiTeActivityStory = true

	StoryController.instance:resetStoryParam(var_4_0)
end

function var_0_0.refreshStoryIdList(arg_5_0)
	if arg_5_0.originEpisodeConfig.type == DungeonEnum.EpisodeType.Story then
		arg_5_0.storyIdList = nil

		return
	end

	if arg_5_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		arg_5_0.storyIdList = nil

		return
	end

	arg_5_0.storyIdList = {}

	if arg_5_0.normalConfig.beforeStory > 0 and StoryModel.instance:isStoryHasPlayed(arg_5_0.normalConfig.beforeStory) then
		table.insert(arg_5_0.storyIdList, arg_5_0.normalConfig.beforeStory)
	end

	if arg_5_0.normalConfig.afterStory > 0 and StoryModel.instance:isStoryHasPlayed(arg_5_0.normalConfig.afterStory) then
		table.insert(arg_5_0.storyIdList, arg_5_0.normalConfig.afterStory)
	end
end

function var_0_0._btncloseviewOnClick(arg_6_0)
	arg_6_0:startCloseTaskNextFrame()
end

function var_0_0.startCloseTaskNextFrame(arg_7_0)
	TaskDispatcher.runDelay(arg_7_0.reallyClose, arg_7_0, 0.01)
end

function var_0_0.cancelStartCloseTask(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.reallyClose, arg_8_0)
end

function var_0_0.reallyClose(arg_9_0)
	arg_9_0:closeThis()
end

function var_0_0._btnleftarrowOnClick(arg_10_0)
	if arg_10_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		return
	end

	if #arg_10_0.mode2EpisodeDict == 1 then
		return
	end

	if arg_10_0.modeIndex <= 1 then
		return
	end

	arg_10_0.modeIndex = arg_10_0.modeIndex - 1

	arg_10_0:refreshUIByMode(arg_10_0.modeList[arg_10_0.modeIndex])
end

function var_0_0._btnrightarrowOnClick(arg_11_0)
	if arg_11_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		return
	end

	if #arg_11_0.mode2EpisodeDict == 1 then
		return
	end

	if arg_11_0.modeIndex >= #arg_11_0.modeList then
		return
	end

	arg_11_0.modeIndex = arg_11_0.modeIndex + 1

	arg_11_0:refreshUIByMode(arg_11_0.modeList[arg_11_0.modeIndex])
end

function var_0_0.refreshUIByMode(arg_12_0, arg_12_1)
	if arg_12_0.mode == arg_12_1 then
		return
	end

	arg_12_0.animator:Play(UIAnimationName.Switch, 0, 0)

	arg_12_0.mode = arg_12_1
	arg_12_0.showEpisodeCo = arg_12_0.mode2EpisodeDict[arg_12_0.mode]
	arg_12_0.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(arg_12_0.showEpisodeCo.id)

	if not arg_12_0.showEpisodeMo then
		arg_12_0.showEpisodeMo = UserDungeonMO.New()

		arg_12_0.showEpisodeMo:initFromManual(arg_12_0.showEpisodeCo.chapterId, arg_12_0.showEpisodeCo.id, 0, 0)
	end
end

function var_0_0.startRefreshUI(arg_13_0)
	arg_13_0:refreshUI()
end

function var_0_0._btnactivityrewardOnClick(arg_14_0)
	DungeonController.instance:openDungeonRewardView(arg_14_0.showEpisodeCo)
end

function var_0_0._btnnormalStartOnClick(arg_15_0)
	if not arg_15_0.modeCanFight then
		GameFacade.showToast(ToastEnum.VersionActivityCanFight, arg_15_0:getPreModeName())

		return
	end

	arg_15_0:startBattle()
end

function var_0_0._btnhardStartOnClick(arg_16_0)
	arg_16_0:startBattle()
end

function var_0_0._btnLockStartOnClick(arg_17_0)
	GameFacade.showToast(ToastEnum.VersionActivityCanFight, arg_17_0:getPreModeName())
end

function var_0_0._btncloseruleOnClick(arg_18_0)
	return
end

function var_0_0.startBattle(arg_19_0)
	if arg_19_0.showEpisodeCo.type == DungeonEnum.EpisodeType.Story then
		if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SkipStroy) or arg_19_0.showEpisodeCo.beforeStory == 0 then
			arg_19_0:_playSkipMainStory()
		else
			arg_19_0:_playMainStory()
		end

		return
	end

	if arg_19_0.isSpecialEpisode then
		arg_19_0.lastEpisodeSelectModeDict[tostring(arg_19_0.specialEpisodeId)] = arg_19_0.mode

		arg_19_0:saveEpisodeLastSelectMode()
	end

	if DungeonModel.instance:hasPassLevelAndStory(arg_19_0.showEpisodeCo.id) then
		arg_19_0:_enterFight()

		return
	end

	if arg_19_0.showEpisodeCo.beforeStory > 0 then
		if not StoryModel.instance:isStoryFinished(arg_19_0.showEpisodeCo.beforeStory) then
			arg_19_0:_playStoryAndEnterFight(arg_19_0.showEpisodeCo.beforeStory)

			return
		end

		if arg_19_0.showEpisodeMo.star <= DungeonEnum.StarType.None then
			arg_19_0:_enterFight()

			return
		end

		if arg_19_0.showEpisodeCo.afterStory > 0 and not StoryModel.instance:isStoryFinished(arg_19_0.showEpisodeCo.afterStory) then
			arg_19_0:playAfterStory(arg_19_0.showEpisodeCo.afterStory)

			return
		end
	end

	arg_19_0:_enterFight()
end

function var_0_0._playMainStory(arg_20_0)
	DungeonRpc.instance:sendStartDungeonRequest(arg_20_0.showEpisodeCo.chapterId, arg_20_0.showEpisodeCo.id)

	local var_20_0 = {}

	var_20_0.mark = true
	var_20_0.episodeId = arg_20_0.showEpisodeCo.id

	StoryController.instance:playStory(arg_20_0.showEpisodeCo.beforeStory, var_20_0, arg_20_0.onStoryFinished, arg_20_0)
end

function var_0_0._playSkipMainStory(arg_21_0)
	DungeonRpc.instance:sendStartDungeonRequest(arg_21_0.showEpisodeCo.chapterId, arg_21_0.showEpisodeCo.id)
	arg_21_0:onStoryFinished()
end

function var_0_0.playAfterStory(arg_22_0, arg_22_1)
	local var_22_0 = {}

	var_22_0.mark = true
	var_22_0.episodeId = arg_22_0.showEpisodeCo.id

	StoryController.instance:playStory(arg_22_1, var_22_0, function()
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo, nil)

		DungeonMapModel.instance.playAfterStory = true

		arg_22_0:closeThis()
	end, arg_22_0)
end

function var_0_0._playStoryAndEnterFight(arg_24_0, arg_24_1)
	if StoryModel.instance:isStoryFinished(arg_24_1) then
		arg_24_0:_enterFight()

		return
	end

	local var_24_0 = {}

	var_24_0.mark = true
	var_24_0.episodeId = arg_24_0.showEpisodeCo.id

	StoryController.instance:playStory(arg_24_1, var_24_0, arg_24_0._enterFight, arg_24_0)
end

function var_0_0._enterFight(arg_25_0)
	DungeonFightController.instance:enterFight(arg_25_0.showEpisodeCo.chapterId, arg_25_0.showEpisodeCo.id, 1)
end

function var_0_0.onStoryFinished(arg_26_0)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(arg_26_0.showEpisodeCo.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
	arg_26_0:closeThis()
end

function var_0_0.initLocalEpisodeMode(arg_27_0)
	arg_27_0.unlockedEpisodeModeDict = arg_27_0:loadDict(VersionActivity1_3EnterController.GetActivityPrefsKey(PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastUnLockMode))
	arg_27_0.lastEpisodeSelectModeDict = arg_27_0:loadDict(VersionActivity1_3EnterController.GetActivityPrefsKey(PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastSelectMode))
end

function var_0_0._onCurrencyChange(arg_28_0, arg_28_1)
	if not arg_28_1[CurrencyEnum.CurrencyType.Power] then
		return
	end

	arg_28_0:refreshCostPower()
end

function var_0_0._showEye(arg_29_0)
	if not (arg_29_0.originEpisodeConfig.displayMark == 1) then
		gohelper.setActive(arg_29_0._gonormaleye, false)
		gohelper.setActive(arg_29_0._gohardeye, false)

		return
	end

	local var_29_0 = arg_29_0.originEpisodeConfig.chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBeiHard

	gohelper.setActive(arg_29_0._gonormaleye, not var_29_0)
	gohelper.setActive(arg_29_0._gohardeye, var_29_0)
end

function var_0_0._editableInitView(arg_30_0)
	gohelper.setActive(arg_30_0._goactivityrewarditem, false)
	gohelper.setActive(arg_30_0._gonormaleye, false)
	gohelper.setActive(arg_30_0._gohardeye, false)

	arg_30_0.lockGoType = arg_30_0._gotype0
	arg_30_0.storyGoType = arg_30_0._gotype1
	arg_30_0.story2GoType = arg_30_0._gotype2
	arg_30_0.story3GoType = arg_30_0._gotype3
	arg_30_0.hardGoType = arg_30_0._gotype4
	arg_30_0.rewardItems = {}

	arg_30_0._simageactivitynormalbg:LoadImage("singlebg/v1a3_dungeon_singlebg/v1a3_dungeon_normaldetailpanelbg.png")
	arg_30_0._simageactivityhardbg:LoadImage("singlebg/v1a3_dungeon_singlebg/v1a3_dungeon_harddetailpanelbg.png")

	arg_30_0.goVersionActivity = gohelper.findChild(arg_30_0.viewGO, "anim/versionactivity")
	arg_30_0.animator = arg_30_0.goVersionActivity:GetComponent(typeof(UnityEngine.Animator))
	arg_30_0.animationEventWrap = arg_30_0.goVersionActivity:GetComponent(typeof(ZProj.AnimationEventWrap))

	arg_30_0.animationEventWrap:AddEventListener("refresh", arg_30_0.startRefreshUI, arg_30_0)

	arg_30_0.txtLockType = gohelper.findChildText(arg_30_0.lockGoType, "txt")
	arg_30_0.leftArrowLight = gohelper.findChild(arg_30_0._btnleftarrow.gameObject, "left_arrow")
	arg_30_0.leftArrowDisable = gohelper.findChild(arg_30_0._btnleftarrow.gameObject, "left_arrow_disable")
	arg_30_0.rightArrowLight = gohelper.findChild(arg_30_0._btnrightarrow.gameObject, "right_arrow")
	arg_30_0.rightArrowDisable = gohelper.findChild(arg_30_0._btnrightarrow.gameObject, "right_arrow_disable")
	arg_30_0.userId = PlayerModel.instance:getMyUserId()

	arg_30_0:initLocalEpisodeMode()
	arg_30_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_30_0._onCurrencyChange, arg_30_0)
end

function var_0_0.initViewParam(arg_31_0)
	arg_31_0.originEpisodeId = arg_31_0.viewParam.episodeId
	arg_31_0.originEpisodeConfig = DungeonConfig.instance:getEpisodeCO(arg_31_0.originEpisodeId)
	arg_31_0.normalConfig = DungeonConfig.instance:getVersionActivityDungeonNormalEpisode(arg_31_0.originEpisodeId, VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBeiHard, VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei)
	arg_31_0.isFromJump = arg_31_0.viewParam.isJump
	arg_31_0.index = arg_31_0:getEpisodeIndex()

	arg_31_0.viewContainer:setOpenedEpisodeId(arg_31_0.originEpisodeId)

	arg_31_0.showEpisodeCo = DungeonConfig.instance:getEpisodeCO(arg_31_0.originEpisodeId)
	arg_31_0.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(arg_31_0.originEpisodeId)
end

function var_0_0.getEpisodeIndex(arg_32_0)
	return DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(arg_32_0.originEpisodeId)
end

function var_0_0.markSelectEpisode(arg_33_0)
	if arg_33_0.originEpisodeConfig.type == DungeonEnum.EpisodeType.Act1_3Dungeon or arg_33_0.originEpisodeConfig.type == DungeonEnum.EpisodeType.Boss then
		VersionActivityDungeonBaseController.instance:setChapterIdLastSelectEpisodeId(arg_33_0.originEpisodeConfig.chapterId, arg_33_0.originEpisodeId)
	end
end

function var_0_0.onUpdateParam(arg_34_0)
	arg_34_0:onOpen()
end

function var_0_0.onOpen(arg_35_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_pagesopen)
	arg_35_0:initViewParam()
	arg_35_0:initMode()
	arg_35_0:markSelectEpisode()
	arg_35_0:refreshStoryIdList()
	arg_35_0:refreshBg()
	arg_35_0:refreshUI()
	arg_35_0.animator:Play(UIAnimationName.Open, 0, 0)
	arg_35_0:_showEye()
end

function var_0_0.initMode(arg_36_0)
	arg_36_0.mode = ActivityConfig.instance:getChapterIdMode(arg_36_0.originEpisodeConfig.chapterId)
	arg_36_0.modeIndex = 1

	if arg_36_0.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		arg_36_0.modeList = {
			VersionActivityDungeonBaseEnum.DungeonMode.Story,
			VersionActivityDungeonBaseEnum.DungeonMode.Story2,
			VersionActivityDungeonBaseEnum.DungeonMode.Story3
		}

		local var_36_0 = DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(arg_36_0.originEpisodeConfig)

		arg_36_0.mode2EpisodeDict = {}

		for iter_36_0, iter_36_1 in ipairs(var_36_0) do
			arg_36_0.mode2EpisodeDict[ActivityConfig.instance:getChapterIdMode(iter_36_1.chapterId)] = iter_36_1
		end

		arg_36_0.isSpecialEpisode = #var_36_0 > 1
		arg_36_0.specialEpisodeId = var_36_0[1].id

		if arg_36_0.isSpecialEpisode then
			if not arg_36_0.isFromJump then
				local var_36_1

				for iter_36_2 = #var_36_0, 1, -1 do
					local var_36_2 = var_36_0[iter_36_2]

					if DungeonModel.instance:hasPassLevelAndStory(var_36_2.preEpisode) then
						arg_36_0.mode = arg_36_0.modeList[iter_36_2]

						break
					end
				end

				arg_36_0:checkNeedPlayModeUnLockAnimation()

				if not arg_36_0.needPlayUnlockModeAnimation then
					arg_36_0.mode = arg_36_0.lastEpisodeSelectModeDict[tostring(arg_36_0.specialEpisodeId)] or VersionActivityDungeonBaseEnum.DungeonMode.Story
				end
			else
				arg_36_0:checkNeedPlayModeUnLockAnimation()
			end

			for iter_36_3, iter_36_4 in ipairs(arg_36_0.modeList) do
				if iter_36_4 == arg_36_0.mode then
					arg_36_0.modeIndex = iter_36_3

					break
				end
			end

			arg_36_0.showEpisodeCo = arg_36_0.mode2EpisodeDict[arg_36_0.mode]
			arg_36_0.showEpisodeMo = DungeonModel.instance:getEpisodeInfo(arg_36_0.showEpisodeCo.id)

			if not arg_36_0.showEpisodeMo then
				arg_36_0.showEpisodeMo = UserDungeonMO.New()

				arg_36_0.showEpisodeMo:initFromManual(arg_36_0.showEpisodeCo.chapterId, arg_36_0.showEpisodeCo.id, 0, 0)
			end
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

	if arg_38_0.needPlayUnlockModeAnimation then
		TaskDispatcher.runDelay(arg_38_0.playModeUnlockAnimation, arg_38_0, 0.4)
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

	arg_40_0._txtmapName.text = arg_40_0:buildEpisodeName()

	local var_40_1 = arg_40_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard and "#cfccc9" or "#cfccc9"

	arg_40_0._txtmapNameEn.text = arg_40_0:buildColorText(arg_40_0.showEpisodeCo.name_En, var_40_1)
	arg_40_0._txtmapNum.text = arg_40_0:buildColorText(string.format("%02d", arg_40_0.index), var_40_1)

	if arg_40_0._txtmapName.preferredWidth < 445 then
		recthelper.setAnchorX(arg_40_0._txtmapNum.transform, -77)
	else
		recthelper.setAnchorX(arg_40_0._txtmapNum.transform, -172)
	end

	arg_40_0._txtMapChapterIndex.text = arg_40_0:buildColorText(var_40_0.chapterIndex .. " .", var_40_1)
	arg_40_0._txtactivitydesc.text = arg_40_0.showEpisodeCo.desc

	local var_40_2 = FightHelper.getEpisodeRecommendLevel(arg_40_0.showEpisodeCo.id)

	gohelper.setActive(arg_40_0._gorecommond, var_40_2 > 0)

	if var_40_2 > 0 then
		arg_40_0._txtrecommondlv.text = HeroConfig.instance:getCommonLevelDisplay(var_40_2)
	end
end

function var_0_0.refreshStar(arg_41_0)
	local var_41_0 = arg_41_0.showEpisodeCo.id
	local var_41_1 = var_41_0 and DungeonModel.instance:hasPassLevelAndStory(var_41_0)
	local var_41_2 = DungeonConfig.instance:getEpisodeAdvancedConditionText(var_41_0)

	arg_41_0:setImage(arg_41_0._imagestar1, var_41_1, var_41_0)

	if string.nilorempty(var_41_2) then
		gohelper.setActive(arg_41_0._imagestar2.gameObject, false)
	else
		gohelper.setActive(arg_41_0._imagestar2.gameObject, true)
		arg_41_0:setImage(arg_41_0._imagestar2, var_41_1 and arg_41_0.showEpisodeMo.star >= DungeonEnum.StarType.Advanced, var_41_0)
	end
end

function var_0_0.refreshMode(arg_42_0)
	gohelper.setActive(arg_42_0.storyGoType, arg_42_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story)
	gohelper.setActive(arg_42_0.story2GoType, arg_42_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story2)
	gohelper.setActive(arg_42_0.story3GoType, arg_42_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story3)
	gohelper.setActive(arg_42_0.hardGoType, arg_42_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard)

	local var_42_0 = not arg_42_0.modeCanFight or arg_42_0.needPlayUnlockModeAnimation

	gohelper.setActive(arg_42_0.lockGoType, var_42_0)

	if var_42_0 then
		arg_42_0.txtLockType.text = luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[arg_42_0.mode])

		if arg_42_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story2 then
			SLFramework.UGUI.GuiHelper.SetColor(arg_42_0.txtLockType, "#757563")
		elseif arg_42_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story3 then
			SLFramework.UGUI.GuiHelper.SetColor(arg_42_0.txtLockType, "#757563")
		end
	end

	local var_42_1 = gohelper.findChild(arg_42_0.txtLockType.gameObject, "icon")

	gohelper.setActive(var_42_1, var_42_0)
end

function var_0_0.refreshArrow(arg_43_0)
	local var_43_0 = arg_43_0.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Hard and arg_43_0.isSpecialEpisode

	gohelper.setActive(arg_43_0._btnleftarrow.gameObject, var_43_0)
	gohelper.setActive(arg_43_0._btnrightarrow.gameObject, var_43_0)

	if var_43_0 then
		gohelper.setActive(arg_43_0.leftArrowLight, arg_43_0.modeIndex ~= 1)
		gohelper.setActive(arg_43_0.leftArrowDisable, arg_43_0.modeIndex == 1)

		local var_43_1 = #arg_43_0.modeList == arg_43_0.modeIndex

		gohelper.setActive(arg_43_0.rightArrowLight, not var_43_1)
		gohelper.setActive(arg_43_0.rightArrowDisable, var_43_1)
	end
end

function var_0_0.refreshReward(arg_44_0)
	local var_44_0 = {}
	local var_44_1 = 0
	local var_44_2 = 0

	if arg_44_0.showEpisodeMo.star ~= DungeonEnum.StarType.Advanced then
		tabletool.addValues(var_44_0, DungeonModel.instance:getEpisodeAdvancedBonus(arg_44_0.showEpisodeCo.id))

		var_44_2 = #var_44_0
	end

	if arg_44_0.showEpisodeMo.star == DungeonEnum.StarType.None then
		tabletool.addValues(var_44_0, DungeonModel.instance:getEpisodeFirstBonus(arg_44_0.showEpisodeCo.id))

		var_44_1 = #var_44_0
	end

	tabletool.addValues(var_44_0, DungeonModel.instance:getEpisodeRewardDisplayList(arg_44_0.showEpisodeCo.id))

	local var_44_3 = #var_44_0

	gohelper.setActive(arg_44_0._gorewards, var_44_3 > 0)
	gohelper.setActive(arg_44_0._gonorewards, var_44_3 == 0)

	if var_44_3 == 0 then
		return
	end

	local var_44_4 = math.min(#var_44_0, 3)
	local var_44_5
	local var_44_6

	for iter_44_0 = 1, var_44_4 do
		local var_44_7 = arg_44_0.rewardItems[iter_44_0]

		if not var_44_7 then
			var_44_7 = arg_44_0:getUserDataTb_()
			var_44_7.go = gohelper.cloneInPlace(arg_44_0._goactivityrewarditem, "item" .. iter_44_0)
			var_44_7.iconItem = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(var_44_7.go, "itemicon"))
			var_44_7.gonormal = gohelper.findChild(var_44_7.go, "rare/#go_rare1")
			var_44_7.gofirst = gohelper.findChild(var_44_7.go, "rare/#go_rare2")
			var_44_7.goadvance = gohelper.findChild(var_44_7.go, "rare/#go_rare3")
			var_44_7.gofirsthard = gohelper.findChild(var_44_7.go, "rare/#go_rare4")
			var_44_7.txtnormal = gohelper.findChildText(var_44_7.go, "rare/#go_rare1/txt")

			table.insert(arg_44_0.rewardItems, var_44_7)
		end

		local var_44_8 = var_44_0[iter_44_0]

		gohelper.setActive(var_44_7.gonormal, false)
		gohelper.setActive(var_44_7.gofirst, false)
		gohelper.setActive(var_44_7.goadvance, false)
		gohelper.setActive(var_44_7.gofirsthard, false)

		local var_44_9
		local var_44_10
		local var_44_11 = var_44_8[3]
		local var_44_12 = true

		if arg_44_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
			var_44_9 = var_44_7.gofirsthard
			var_44_10 = var_44_7.goadvance
		else
			var_44_9 = var_44_7.gofirst
			var_44_10 = var_44_7.goadvance
		end

		if iter_44_0 <= var_44_2 then
			gohelper.setActive(var_44_10, true)
		elseif iter_44_0 <= var_44_1 then
			gohelper.setActive(var_44_9, true)
		else
			gohelper.setActive(var_44_7.gonormal, true)

			var_44_7.txtnormal.text = luaLang("dungeon_prob_flag" .. var_44_8[3])

			if #var_44_8 >= 4 then
				var_44_11 = var_44_8[4]
			else
				var_44_12 = false
			end
		end

		var_44_7.iconItem:setMOValue(var_44_8[1], var_44_8[2], var_44_11, nil, true)
		var_44_7.iconItem:setCountFontSize(40)
		var_44_7.iconItem:setHideLvAndBreakFlag(true)
		var_44_7.iconItem:hideEquipLvAndBreak(true)
		var_44_7.iconItem:isShowCount(var_44_12)
		gohelper.setActive(var_44_7.go, true)
	end

	for iter_44_1 = var_44_4 + 1, #arg_44_0.rewardItems do
		gohelper.setActive(arg_44_0.rewardItems[iter_44_1].go, false)
	end
end

function var_0_0.refreshStartBtn(arg_45_0)
	arg_45_0:refreshCostPower()

	local var_45_0 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	local var_45_1 = ResUrl.getCurrencyItemIcon(var_45_0.icon .. "_btn")

	arg_45_0._simagepower:LoadImage(var_45_1)
	gohelper.setActive(arg_45_0._btnnormalStart.gameObject, arg_45_0.modeCanFight and arg_45_0.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Hard)
	gohelper.setActive(arg_45_0._btnhardStart.gameObject, arg_45_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard)
	gohelper.setActive(arg_45_0._btnlockStart.gameObject, not arg_45_0.modeCanFight or arg_45_0.needPlayUnlockModeAnimation)

	local var_45_2 = DungeonModel.instance:hasPassLevelAndStory(arg_45_0.normalConfig.id) and arg_45_0.storyIdList and #arg_45_0.storyIdList > 0

	gohelper.setActive(arg_45_0._btnreplayStory, var_45_2)

	if arg_45_0.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		if arg_45_0.modeCanFight then
			if DungeonModel.instance:hasPassLevel(arg_45_0.showEpisodeCo.id) and arg_45_0.showEpisodeCo.afterStory > 0 and not StoryModel.instance:isStoryFinished(arg_45_0.showEpisodeCo.afterStory) then
				arg_45_0._txtnorstarttext.text = luaLang("p_dungeonlevelview_continuestory")

				recthelper.setAnchorX(arg_45_0._txtnorstarttext.gameObject.transform, 0)
				recthelper.setAnchorX(arg_45_0._txtnorstarttexten.gameObject.transform, 0)
				gohelper.setActive(arg_45_0._txtusepowernormal.gameObject, false)
				gohelper.setActive(arg_45_0._simagepower.gameObject, false)
			else
				arg_45_0._txtnorstarttext.text = luaLang("p_dungeonlevelview_startfight")

				recthelper.setAnchorX(arg_45_0._txtnorstarttext.gameObject.transform, 121)
				recthelper.setAnchorX(arg_45_0._txtnorstarttexten.gameObject.transform, 121)
				gohelper.setActive(arg_45_0._txtusepowernormal.gameObject, true)
				gohelper.setActive(arg_45_0._simagepower.gameObject, true)
			end
		else
			gohelper.setActive(arg_45_0._simagepower.gameObject, false)
			gohelper.setActive(arg_45_0._txtusepowernormal.gameObject, false)
		end
	end
end

function var_0_0.refreshCostPower(arg_46_0)
	local var_46_0 = 0

	if not string.nilorempty(arg_46_0.showEpisodeCo.cost) then
		var_46_0 = string.splitToNumber(arg_46_0.showEpisodeCo.cost, "#")[3]
	end

	arg_46_0._txtusepowernormal.text = "-" .. var_46_0
	arg_46_0._txtusepowerhard.text = "-" .. var_46_0

	if var_46_0 <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(arg_46_0._txtusepowernormal, "#070706")
		SLFramework.UGUI.GuiHelper.SetColor(arg_46_0._txtusepowerhard, "#FFEAEA")
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_46_0._txtusepowernormal, "#800015")
		SLFramework.UGUI.GuiHelper.SetColor(arg_46_0._txtusepowerhard, "#C44945")
	end
end

function var_0_0.checkNeedPlayModeUnLockAnimation(arg_47_0)
	if arg_47_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard or arg_47_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story then
		arg_47_0.needPlayUnlockModeAnimation = false

		return
	end

	arg_47_0.needPlayUnlockModeAnimation = (arg_47_0.unlockedEpisodeModeDict[tostring(arg_47_0.specialEpisodeId)] or VersionActivityDungeonBaseEnum.DungeonMode.Story) < arg_47_0.mode
end

function var_0_0._playModeUnLockAnimation(arg_48_0, arg_48_1)
	arg_48_0.lockGoType:GetComponent(typeof(UnityEngine.Animator)):Play(arg_48_1)
	gohelper.findChild(arg_48_0.viewGO, "anim/versionactivity/right/startBtn"):GetComponent(typeof(UnityEngine.Animator)):Play(arg_48_1)
end

function var_0_0.playModeUnlockAnimation(arg_49_0)
	if arg_49_0.needPlayUnlockModeAnimation then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_difficulty)
		arg_49_0:_playModeUnLockAnimation(UIAnimationName.Unlock)
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("playModeUnlockAnimation")
		TaskDispatcher.runDelay(arg_49_0.onModeUnlockAnimationPlayDone, arg_49_0, 2.7)
	end
end

function var_0_0.onModeUnlockAnimationPlayDone(arg_50_0)
	arg_50_0:_playModeUnLockAnimation(UIAnimationName.Idle)

	arg_50_0.unlockedEpisodeModeDict[tostring(arg_50_0.specialEpisodeId)] = arg_50_0.mode

	arg_50_0:saveEpisodeUnlockMode()
	UIBlockMgrExtend.setNeedCircleMv(true)

	arg_50_0.needPlayUnlockModeAnimation = false

	arg_50_0:refreshMode()
	arg_50_0:refreshStartBtn()
	UIBlockMgr.instance:endBlock("playModeUnlockAnimation")
end

function var_0_0.setImage(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
	if arg_51_2 then
		local var_51_0 = DungeonConfig.instance:getEpisodeCO(arg_51_3)
		local var_51_1 = VersionActivity1_3DungeonEnum.EpisodeStarType[var_51_0.chapterId]

		UISpriteSetMgr.instance:setVersionActivity1_3Sprite(arg_51_1, var_51_1)
	else
		local var_51_2 = DungeonConfig.instance:getEpisodeCO(arg_51_3)
		local var_51_3 = VersionActivity1_3DungeonEnum.EpisodeStarEmptyType[var_51_2.chapterId]

		UISpriteSetMgr.instance:setVersionActivity1_3Sprite(arg_51_1, var_51_3)
	end
end

function var_0_0.buildEpisodeName(arg_52_0)
	local var_52_0 = arg_52_0.showEpisodeCo.name
	local var_52_1 = GameUtil.utf8sub(var_52_0, 1, 1)
	local var_52_2 = ""
	local var_52_3 = GameUtil.utf8len(var_52_0)

	if var_52_3 > 1 then
		var_52_2 = GameUtil.utf8sub(var_52_0, 2, var_52_3 - 1)
	end

	local var_52_4 = arg_52_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard and "#cfccc9" or "#cfccc9"

	return arg_52_0:buildColorText(string.format("<size=112>%s</size>%s", var_52_1, var_52_2), var_52_4)
end

function var_0_0.buildColorText(arg_53_0, arg_53_1, arg_53_2)
	return string.format("<color=%s>%s</color>", arg_53_2, arg_53_1)
end

function var_0_0.getPreModeName(arg_54_0)
	local var_54_0 = arg_54_0.modeIndex - 1
	local var_54_1 = arg_54_0.modeList[var_54_0]

	if not var_54_1 then
		logWarn("not modeIndex mode : " .. var_54_0)

		return ""
	end

	return luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[var_54_1])
end

function var_0_0.getKey(arg_55_0, arg_55_1)
	return arg_55_1 .. arg_55_0.userId
end

function var_0_0.loadDict(arg_56_0, arg_56_1)
	arg_56_1 = arg_56_0:getKey(arg_56_1)

	local var_56_0 = PlayerPrefsHelper.getString(arg_56_1, "")

	if string.nilorempty(var_56_0) then
		return {}
	end

	return cjson.decode(var_56_0)
end

function var_0_0.saveEpisodeUnlockMode(arg_57_0)
	PlayerPrefsHelper.setString(arg_57_0:getKey(VersionActivity1_3EnterController.GetActivityPrefsKey(PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastUnLockMode)), cjson.encode(arg_57_0.unlockedEpisodeModeDict))
end

function var_0_0.saveEpisodeLastSelectMode(arg_58_0)
	PlayerPrefsHelper.setString(arg_58_0:getKey(VersionActivity1_3EnterController.GetActivityPrefsKey(PlayerPrefsKey.ActivityDungeonSpecialEpisodeLastSelectMode)), cjson.encode(arg_58_0.lastEpisodeSelectModeDict))
end

function var_0_0.onClose(arg_59_0)
	TaskDispatcher.cancelTask(arg_59_0.onModeUnlockAnimationPlayDone, arg_59_0)
	TaskDispatcher.cancelTask(arg_59_0.playModeUnlockAnimation, arg_59_0)
end

function var_0_0.onDestroyView(arg_60_0)
	arg_60_0.animationEventWrap:RemoveAllEventListener()

	arg_60_0.rewardItems = nil

	arg_60_0._simageactivitynormalbg:UnLoadImage()
	arg_60_0._simageactivityhardbg:UnLoadImage()
	arg_60_0._simagepower:UnLoadImage()
end

return var_0_0
