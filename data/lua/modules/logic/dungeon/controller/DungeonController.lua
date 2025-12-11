module("modules.logic.dungeon.controller.DungeonController", package.seeall)

local var_0_0 = class("DungeonController", BaseController)

function var_0_0.checkFirstPass(arg_1_0, arg_1_1)
	local var_1_0 = DungeonModel.instance:getEpisodeInfo(arg_1_1.episodeId)

	if SDKMediaEventEnum.TrackEpisodePassMediaEvent[arg_1_1.episodeId] and arg_1_1.star > 0 and var_1_0 and var_1_0.star == 0 then
		SDKDataTrackMgr.instance:trackMediaEvent(SDKMediaEventEnum.TrackEpisodePassMediaEvent[arg_1_1.episodeId])
	end

	if arg_1_1.star > 0 and var_1_0 and var_1_0.star == 0 then
		SDKChannelEventModel.instance:episodePass(arg_1_1.episodeId)
	end
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onInitFinish(arg_3_0)
	return
end

function var_0_0.addConstEvents(arg_4_0)
	arg_4_0:registerCallback(DungeonEvent.OnFocusEpisode, arg_4_0._onFocusEpisode, arg_4_0)
	arg_4_0:registerCallback(DungeonEvent.OnSetResScrollPos, arg_4_0._onSetResScrollPos, arg_4_0)
	arg_4_0:registerCallback(DungeonEvent.OnGuideUnlockNewChapter, arg_4_0._onGuideUnlockNewChapter, arg_4_0)
	arg_4_0:registerCallback(DungeonEvent.OnGuideFocusNormalChapter, arg_4_0._onGuideFocusNormalChapter, arg_4_0)
	arg_4_0:registerCallback(DungeonEvent.OnHideCircleMv, arg_4_0._onHideCircleMv, arg_4_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_4_0._onDailyRefresh, arg_4_0)
	FightController.instance:registerCallback(FightEvent.PushEndFight, arg_4_0._pushEndFight, arg_4_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenFullViewFinish, arg_4_0._onOpenFullViewFinish, arg_4_0, LuaEventSystem.Low)
end

function var_0_0._onOpenFullViewFinish(arg_5_0, arg_5_1)
	if arg_5_1 ~= ViewName.StoryBackgroundView then
		return
	end

	local var_5_0 = ViewMgr.instance:getContainer(ViewName.DungeonMapLevelView)

	if not var_5_0 then
		return
	end

	if var_5_0._isVisible then
		local var_5_1 = ""
		local var_5_2 = ViewMgr.instance:getOpenViewNameList()

		for iter_5_0 = #var_5_2, 1, -1 do
			local var_5_3 = var_5_2[iter_5_0]

			var_5_1 = string.format("%s#%s", var_5_1, var_5_3)

			if arg_5_1 == var_5_3 then
				break
			end
		end

		logError(string.format("剧情没有隐藏副本界面 list:%s", var_5_1))
	end

	arg_5_0:_hideView(ViewName.DungeonMapLevelView)
	arg_5_0:_hideView(ViewName.DungeonMapView)
	arg_5_0:_hideView(ViewName.DungeonView)
	arg_5_0:_hideView(ViewName.MainView)
end

function var_0_0._hideView(arg_6_0, arg_6_1)
	local var_6_0 = ViewMgr.instance:getContainer(arg_6_1)

	if var_6_0 then
		var_6_0:setVisibleInternal(false)
	end
end

function var_0_0._pushEndFight(arg_7_0)
	local var_7_0 = FightModel.instance:getRecordMO()

	if not var_7_0 or var_7_0.fightResult == FightEnum.FightResult.Succ then
		return
	end

	local var_7_1 = FightModel.instance:getFightParam()
	local var_7_2 = var_7_1 and var_7_1.episodeId
	local var_7_3 = var_7_2 and lua_episode.configDict[var_7_2]

	if not var_7_3 then
		return
	end

	if DungeonConfig.instance:getChapterCO(var_7_3.chapterId).type ~= DungeonEnum.ChapterType.Normal then
		return
	end

	if DungeonModel.instance:hasPassLevel(var_7_2) then
		return
	end

	local var_7_4 = PlayerPrefsKey.DungeonFailure .. PlayerModel.instance:getPlayinfo().userId .. var_7_2
	local var_7_5 = PlayerPrefsHelper.getNumber(var_7_4, 0)

	PlayerPrefsHelper.setNumber(var_7_4, var_7_5 + 1)
end

function var_0_0.reInit(arg_8_0)
	return
end

function var_0_0.OnOpenNormalMapView(arg_9_0)
	var_0_0.instance:dispatchEvent(DungeonEvent.OnOpenNormalMapView)
end

function var_0_0._onDailyRefresh(arg_10_0)
	DungeonRpc.instance:sendGetDungeonRequest()
end

function var_0_0._onHideCircleMv(arg_11_0)
	UIBlockMgrExtend.setNeedCircleMv(false)
end

function var_0_0._onGuideFocusNormalChapter(arg_12_0, arg_12_1)
	local var_12_0 = tonumber(arg_12_1)

	if var_12_0 then
		DungeonMainStoryModel.instance:saveClickChapterId(var_12_0)
	end
end

function var_0_0._onGuideUnlockNewChapter(arg_13_0, arg_13_1)
	arg_13_1 = tonumber(arg_13_1)

	if arg_13_1 ~= 101 then
		DungeonModel.instance.unlockNewChapterId = arg_13_1
		DungeonModel.instance.chapterTriggerNewChapter = false

		return
	end

	local var_13_0 = PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.ChapterUnlockEffect)

	if not string.nilorempty(var_13_0) then
		TaskDispatcher.runDelay(function()
			var_0_0.instance:dispatchEvent(DungeonEvent.OnUnlockNewChapterAnimFinish)
		end, nil, 0)

		return
	end

	PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.ChapterUnlockEffect, "1")

	DungeonModel.instance.chapterTriggerNewChapter = true
	DungeonModel.instance.unlockNewChapterId = arg_13_1
end

function var_0_0._onSetResScrollPos(arg_15_0, arg_15_1)
	DungeonModel.instance.resScrollPosX = tonumber(arg_15_1)
end

function var_0_0._onFocusEpisode(arg_16_0, arg_16_1)
	DungeonModel.instance:setLastSendEpisodeId(tonumber(arg_16_1))
end

function var_0_0.enterDungeonView(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 then
		DungeonModel.instance:initModel()
	end

	local var_17_0 = {
		fromMainView = arg_17_2
	}

	return arg_17_0:openDungeonView(var_17_0, false)
end

function var_0_0.jumpDungeon(arg_18_0, arg_18_1)
	local var_18_0 = {}

	if not arg_18_1 then
		return var_18_0
	end

	local var_18_1 = arg_18_1.chapterType
	local var_18_2 = arg_18_1.chapterId
	local var_18_3 = arg_18_1.episodeId

	DungeonModel.instance.lastSendEpisodeId = var_18_3

	if not var_18_1 then
		return var_18_0
	end

	local var_18_4

	if var_18_1 == DungeonEnum.ChapterType.Hard then
		local var_18_5 = DungeonConfig.instance:getEpisodeCO(var_18_3)

		if not var_18_5 then
			logError("不能直接跳困难章节,可以配合困难关卡跳转")

			return var_18_0
		end

		local var_18_6 = DungeonConfig.instance:getEpisodeCO(var_18_5.preEpisode)

		if not var_18_6 then
			return var_18_0
		end

		var_18_1, var_18_2, var_18_3 = DungeonConfig.instance:getChapterCO(var_18_6.chapterId).type, var_18_6.chapterId, var_18_6.id
		var_18_4 = true
	end

	if var_18_1 == DungeonEnum.ChapterType.Newbie then
		logError("不能跳新手章节")

		return var_18_0
	end

	DungeonModel.instance:changeCategory(var_18_1)

	if not DungeonConfig.instance:getChapterCO(var_18_2) then
		table.insert(var_18_0, ViewName.DungeonView)
		arg_18_0:openDungeonView(nil)

		return var_18_0
	end

	if DungeonModel.instance:chapterIsLock(var_18_2) then
		table.insert(var_18_0, ViewName.DungeonView)
		arg_18_0:openDungeonView(nil)

		return var_18_0
	end

	local var_18_7 = {
		chapterId = var_18_2,
		episodeId = var_18_3
	}

	table.insert(var_18_0, arg_18_0:getDungeonChapterViewName(var_18_2))

	local var_18_8 = var_18_3 and DungeonConfig.instance:getEpisodeCO(var_18_3)

	if not var_18_8 then
		arg_18_0:openDungeonChapterView(var_18_7)

		return var_18_0
	end

	DungeonModel.instance.curLookChapterId = var_18_2

	local var_18_9 = arg_18_0:jumpChapterAndLevel(var_18_2, var_18_8, var_18_7, var_18_4, arg_18_1.isNoShowMapLevel)

	if var_18_9 then
		table.insert(var_18_0, var_18_9)
	end

	return var_18_0
end

function var_0_0.jumpChapterAndLevel(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	local var_19_0 = arg_19_0:generateLevelViewParam(arg_19_2, arg_19_4, true)
	local var_19_1 = {}
	local var_19_2 = {}

	arg_19_3 = arg_19_3 or {}
	arg_19_3.notOpenHelp = true
	DungeonModel.instance.jumpEpisodeId = arg_19_3.episodeId

	function var_19_2.openFunction()
		arg_19_0:openDungeonChapterView(arg_19_3, true)
	end

	var_19_2.waitOpenViewName = arg_19_0:getDungeonChapterViewName(arg_19_1)

	table.insert(var_19_1, var_19_2)

	if not arg_19_5 then
		local var_19_3 = {
			openFunction = function()
				arg_19_0:generateLevelViewParam(arg_19_2, arg_19_4)
			end
		}

		table.insert(var_19_1, var_19_3)
	end

	module_views_preloader.DungeonChapterAndLevelView(function()
		OpenMultiView.openView(var_19_1)
	end, arg_19_1, var_19_0)

	return var_19_0
end

function var_0_0.generateLevelViewParam(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0
	local var_23_1 = DungeonModel.instance:getEpisodeInfo(arg_23_1.id) or nil

	if not var_23_1 then
		return var_23_0
	end

	local var_23_2, var_23_3 = DungeonConfig.instance:getChapterIndex(DungeonModel.instance.curChapterType, DungeonModel.instance.curLookChapterId)
	local var_23_4 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(DungeonModel.instance.curLookChapterId, arg_23_1.id)

	return (arg_23_0:enterLevelView({
		arg_23_1,
		var_23_1,
		var_23_2,
		var_23_4,
		arg_23_2,
		true
	}, arg_23_3))
end

function var_0_0.enterLevelView(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0
	local var_24_1 = arg_24_1[1]

	if not var_24_1 then
		logError("找不到配置")

		return var_24_0
	end

	if DungeonModel.isBattleEpisode(var_24_1) then
		if not arg_24_2 then
			var_0_0.instance:openDungeonLevelView(arg_24_1)
		end

		var_24_0 = arg_24_0:getDungeonLevelViewName(var_24_1.chapterId)
	elseif var_24_1.type == DungeonEnum.EpisodeType.Story then
		if not arg_24_2 then
			var_0_0.instance:openDungeonLevelView(arg_24_1)
		end

		var_24_0 = arg_24_0:getDungeonLevelViewName(var_24_1.chapterId)
	elseif var_24_1.type == DungeonEnum.EpisodeType.Decrypt and (arg_24_2 or true) then
		var_24_0 = ViewName.DungeonPuzzleChangeColorView
	end

	return var_24_0
end

function var_0_0.canJumpDungeonType(arg_25_0, arg_25_1)
	local var_25_0 = true
	local var_25_1 = DungeonEnum.ChapterType.Normal

	if arg_25_1 == JumpEnum.DungeonChapterType.Gold then
		var_25_1 = DungeonEnum.ChapterType.Gold
		var_25_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.GainDungeon)
	elseif arg_25_1 == JumpEnum.DungeonChapterType.Resource then
		var_25_1 = DungeonEnum.ChapterType.Break
		var_25_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.ResDungeon)
	elseif arg_25_1 == JumpEnum.DungeonChapterType.WeekWalk then
		var_25_1 = DungeonEnum.ChapterType.WeekWalk
		var_25_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk)
	elseif arg_25_1 == JumpEnum.DungeonChapterType.Explore then
		var_25_1 = DungeonEnum.ChapterType.Explore
		var_25_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Explore)
	end

	if var_25_0 and DungeonModel.instance:getChapterListOpenTimeValid(var_25_1) then
		return true
	end

	return false
end

function var_0_0.canJumpDungeonChapter(arg_26_0, arg_26_1)
	local var_26_0 = DungeonConfig.instance:getChapterCO(arg_26_1)

	if not var_26_0 then
		return false
	end

	local var_26_1 = var_26_0.type
	local var_26_2 = JumpEnum.DungeonChapterType.Story
	local var_26_3 = true

	if var_26_1 == DungeonEnum.ChapterType.Gold or var_26_1 == DungeonEnum.ChapterType.Exp or var_26_1 == DungeonEnum.ChapterType.Equip then
		var_26_2 = JumpEnum.DungeonChapterType.Gold

		if var_26_1 == DungeonEnum.ChapterType.Gold then
			var_26_3 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.GoldDungeon)
		elseif var_26_1 == DungeonEnum.ChapterType.Exp then
			var_26_3 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.ExperienceDungeon)
		elseif var_26_1 == DungeonEnum.ChapterType.Equip then
			var_26_3 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.EquipDungeon)
		elseif var_26_1 == DungeonEnum.ChapterType.Buildings then
			var_26_3 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Buildings)
		end
	elseif var_26_1 == DungeonEnum.ChapterType.Break then
		var_26_2 = JumpEnum.DungeonChapterType.Resource
	end

	if arg_26_0:canJumpDungeonType(var_26_2) and var_26_3 and not DungeonModel.instance:chapterIsLock(arg_26_1) and DungeonModel.instance:getChapterOpenTimeValid(var_26_0) then
		return true
	end

	return false
end

function var_0_0.openDungeonEquipEntryView(arg_27_0, arg_27_1, arg_27_2)
	ViewMgr.instance:openView(ViewName.DungeonEquipEntryView, arg_27_1, arg_27_2)

	return ViewName.DungeonEquipEntryView
end

function var_0_0.openDungeonView(arg_28_0, arg_28_1, arg_28_2)
	ViewMgr.instance:openView(ViewName.DungeonView, arg_28_1, arg_28_2)

	return ViewName.DungeonView
end

function var_0_0.openDungeonMapTaskView(arg_29_0, arg_29_1, arg_29_2)
	ViewMgr.instance:openView(ViewName.DungeonMapTaskView, arg_29_1, arg_29_2)

	return ViewName.DungeonMapTaskView
end

function var_0_0.openDungeonChapterView(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_1 and arg_30_1.chapterId then
		DungeonModel.instance.curLookChapterId = arg_30_1.chapterId
	end

	local var_30_0 = DungeonConfig.instance:getChapterCO(arg_30_1.chapterId)

	if var_30_0.type == DungeonEnum.ChapterType.WeekWalk then
		WeekWalkController.instance:openWeekWalkView(arg_30_1, arg_30_2)

		return ViewName.WeekWalkView
	elseif var_30_0.type == DungeonEnum.ChapterType.WeekWalk_2 then
		WeekWalk_2Controller.instance:openWeekWalk_2HeartView(arg_30_1, arg_30_2)

		return ViewName.WeekWalk_2HeartView
	elseif var_30_0.type == DungeonEnum.ChapterType.Season or var_30_0.type == DungeonEnum.ChapterType.SeasonRetail or var_30_0.type == DungeonEnum.ChapterType.SeasonSpecial then
		Activity104Controller.instance:openSeasonMainView()

		return ViewName.SeasonMainView
	elseif var_30_0.type == DungeonEnum.ChapterType.Season123 or var_30_0.type == DungeonEnum.ChapterType.Season123Retail then
		Season123Controller.instance:openMainViewFromFightScene()

		return Season123Controller.instance:getEpisodeListViewName()
	elseif var_30_0.id == HeroInvitationEnum.ChapterId then
		arg_30_0._lastChapterId = arg_30_1.chapterId

		DungeonModel.instance:changeCategory(var_30_0.type, false)
		HeroInvitationRpc.instance:sendGetHeroInvitationInfoRequest()
		ViewMgr.instance:openView(ViewName.HeroInvitationDungeonMapView, arg_30_1, arg_30_2)

		return ViewName.HeroInvitationDungeonMapView
	end

	arg_30_0._lastChapterId = arg_30_1.chapterId

	if arg_30_1.chapterId and not arg_30_1.episodeId then
		arg_30_1.episodeId = CharacterRecommedModel.instance:getChapterTradeEpisodeId(arg_30_1.chapterId)
	end

	DungeonModel.instance:changeCategory(var_30_0.type, false)
	ViewMgr.instance:openView(ViewName.DungeonMapView, arg_30_1, arg_30_2)

	return ViewName.DungeonMapView
end

function var_0_0.getDungeonChapterViewName(arg_31_0, arg_31_1)
	if arg_31_1 == HeroInvitationEnum.ChapterId then
		return ViewName.HeroInvitationDungeonMapView
	end

	return ViewName.DungeonMapView
end

function var_0_0.getDungeonLevelViewName(arg_32_0, arg_32_1)
	return ViewName.DungeonMapLevelView
end

function var_0_0.openDungeonCumulativeRewardsView(arg_33_0, arg_33_1, arg_33_2)
	ViewMgr.instance:openView(ViewName.DungeonCumulativeRewardsView, arg_33_1, arg_33_2)
end

function var_0_0.openDungeonLevelView(arg_34_0, arg_34_1, arg_34_2)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SkipShowDungeonMapLevelView) then
		GuideModel.instance:setFlag(GuideModel.GuideFlag.SkipShowDungeonMapLevelView, nil)

		return
	end

	local var_34_0 = arg_34_1[1]

	DungeonModel.instance.curLookEpisodeId = var_34_0.id

	ViewMgr.instance:openView(ViewName.DungeonMapLevelView, arg_34_1, arg_34_2)
end

function var_0_0.openDungeonMonsterView(arg_35_0, arg_35_1, arg_35_2)
	ViewMgr.instance:openView(ViewName.DungeonMonsterView, arg_35_1, arg_35_2)
end

function var_0_0.openDungeonRewardView(arg_36_0, arg_36_1, arg_36_2)
	ViewMgr.instance:openView(ViewName.DungeonRewardView, arg_36_1, arg_36_2)
end

function var_0_0.openDungeonElementRewardView(arg_37_0, arg_37_1, arg_37_2)
	ViewMgr.instance:openView(ViewName.DungeonElementRewardView, arg_37_1, arg_37_2)
end

function var_0_0.openDungeonStoryView(arg_38_0, arg_38_1, arg_38_2)
	ViewMgr.instance:openView(ViewName.DungeonStoryView, arg_38_1, arg_38_2)
end

function var_0_0.onStartLevelOrStoryChange(arg_39_0)
	DungeonModel.instance:startCheckUnlockChapter()
	arg_39_0:_onStartCheckUnlockContent()
end

function var_0_0.onEndLevelOrStoryChange(arg_40_0)
	DungeonModel.instance:endCheckUnlockChapter()
	arg_40_0:_onEndCheckUnlockContent()
end

function var_0_0._onStartCheckUnlockContent(arg_41_0)
	if not DungeonModel.instance.curSendEpisodeId then
		return
	end

	arg_41_0._hasAllPass = DungeonModel.instance:hasPassLevelAndStory(DungeonModel.instance.curSendEpisodeId)
end

function var_0_0._onEndCheckUnlockContent(arg_42_0)
	if not DungeonModel.instance.curSendEpisodeId then
		return
	end

	local var_42_0 = DungeonModel.instance:hasPassLevelAndStory(DungeonModel.instance.curSendEpisodeId)

	if var_42_0 and var_42_0 ~= arg_42_0._hasAllPass then
		var_0_0.instance:showUnlockContentToast(DungeonModel.instance.curSendEpisodeId)
	end
end

function var_0_0.showUnlockContentToast(arg_43_0, arg_43_1)
	local var_43_0 = DungeonChapterUnlockItem.getUnlockContentList(arg_43_1, true)

	for iter_43_0, iter_43_1 in ipairs(var_43_0) do
		if DungeonConfig.instance:getChapterCO(lua_episode.configDict[arg_43_1].chapterId).type ~= DungeonEnum.ChapterType.TeachNote then
			GameFacade.showToast(ToastEnum.IconId, iter_43_1)
		end
	end
end

function var_0_0.needShowDungeonView(arg_44_0)
	if not DungeonModel.instance.curSendEpisodeId then
		return
	end

	local var_44_0 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if var_44_0 then
		local var_44_1 = DungeonConfig.instance:getChapterCO(var_44_0.chapterId)

		if var_44_1 and var_44_1.type == DungeonEnum.ChapterType.Newbie then
			return
		end

		if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightBackSkipDungeonView) then
			DungeonModel.instance.curSendEpisodeId = nil

			GuideModel.instance:setFlag(GuideModel.GuideFlag.FightBackSkipDungeonView, nil)

			return
		end

		if var_44_1.type == DungeonEnum.ChapterType.DreamTailNormal or var_44_1.type == DungeonEnum.ChapterType.DreamTailHard then
			return true
		end

		if TeachNoteModel.instance:isJumpEnter() then
			DungeonModel.instance.curSendEpisodeId = nil

			return
		end

		if var_44_0.type == DungeonEnum.EpisodeType.Dog then
			return
		end

		if var_44_0.type == DungeonEnum.EpisodeType.RoleStoryChallenge and not RoleStoryModel.instance:checkActStoryOpen() then
			return
		end

		return true
	end
end

function var_0_0.enterTeachNote(arg_45_0, arg_45_1)
	if not arg_45_1 then
		return nil
	end

	local var_45_0 = DungeonConfig.instance:getEpisodeCO(arg_45_1)

	if not var_45_0 then
		return nil
	end

	if DungeonConfig.instance:getChapterCO(var_45_0.chapterId).type ~= DungeonEnum.ChapterType.TeachNote then
		return nil
	end

	if not TeachNoteModel.instance:isTeachNoteEnterFight() then
		return
	else
		if TeachNoteModel.instance:isDetailEnter() and DungeonModel.instance:hasPassLevel(arg_45_1) then
			return
		end

		DungeonModel.instance.curLookChapterId = var_45_0.chapterId
	end

	arg_45_0:enterDungeonView(true)

	if TeachNoteModel.instance:isTeachNoteChapter(DungeonModel.instance.curLookChapterId) then
		DungeonModel.instance.curSendEpisodeId = DungeonModel.instance.curLookEpisodeIdId

		if TeachNoteModel.instance:isTeachNoteEnterFight() then
			arg_45_0:openDungeonChapterView({
				chapterId = arg_45_0._lastChapterId
			}, true)

			if TeachNoteModel.instance:isDetailEnter() then
				TeachNoteModel.instance:setTeachNoteEnterFight(false)

				return TeachNoteController.instance:enterTeachNoteDetailView(arg_45_1)
			else
				TeachNoteModel.instance:setTeachNoteEnterFight(false)

				return TeachNoteController.instance:enterTeachNoteView(arg_45_1)
			end
		else
			if not arg_45_0._lastChapterId then
				arg_45_0._lastChapterId = 101
			end

			return arg_45_0:openDungeonChapterView({
				chapterId = arg_45_0._lastChapterId
			}, true)
		end
	else
		return arg_45_0:openDungeonChapterView({
			chapterId = DungeonModel.instance.curLookChapterId
		}, true)
	end
end

function var_0_0.enterSpecialEquipEpisode(arg_46_0, arg_46_1)
	if not arg_46_1 then
		return nil
	end

	local var_46_0 = DungeonConfig.instance:getEpisodeCO(arg_46_1)

	if not var_46_0 then
		return nil
	end

	if var_46_0.type ~= DungeonEnum.EpisodeType.SpecialEquip then
		return nil
	end

	local var_46_1 = DungeonChapterListModel.instance:getOpenTimeValidEquipChapterId()
	local var_46_2 = DungeonConfig.instance:getChapterCO(var_46_1)
	local var_46_3 = var_46_2.type

	DungeonModel.instance:changeCategory(var_46_3, true)

	local var_46_4 = arg_46_0:enterDungeonView()

	if DungeonModel.instance:getChapterOpenTimeValid(var_46_2) then
		var_46_4 = arg_46_0:openDungeonChapterView({
			chapterId = var_46_1
		}, true)

		if DungeonMapModel.instance:isUnlockSpChapter(var_46_0.chapterId) then
			var_46_4 = arg_46_0:openDungeonEquipEntryView(var_46_0.chapterId)
		end
	end

	return var_46_4
end

function var_0_0.enterVerisonActivity(arg_47_0, arg_47_1)
	local var_47_0 = DungeonConfig.instance:getEpisodeCO(arg_47_1)

	if not var_47_0 then
		return nil
	end

	if var_47_0.type == DungeonEnum.EpisodeType.Meilanni then
		if MeilanniController.instance:activityIsEnd() then
			ViewMgr.instance:openView(ViewName.MainView)

			return ViewName.MainView
		end

		ViewMgr.instance:openView(ViewName.MainView)
		PermanentController.instance:jump2Activity(VersionActivityEnum.ActivityId.Act105)
		MeilanniController.instance:immediateOpenMeilanniMainView()
		MeilanniController.instance:openMeilanniView()

		return ViewName.MeilanniView
	end
end

function var_0_0.enterRoleStoryChallenge(arg_48_0, arg_48_1)
	local var_48_0 = DungeonConfig.instance:getEpisodeCO(arg_48_1)

	if not var_48_0 then
		return nil
	end

	if var_48_0.type == DungeonEnum.EpisodeType.RoleStoryChallenge then
		RoleStoryController.instance:openRoleStoryDispatchMainView({
			1
		})

		return ViewName.RoleStoryDispatchMainView
	end

	if DungeonConfig.instance:getChapterCO(var_48_0.chapterId).type == DungeonEnum.ChapterType.RoleStory then
		local var_48_1 = RoleStoryConfig.instance:getStoryIdByChapterId(var_48_0.chapterId)

		if not RoleStoryModel.instance:isInResident(var_48_1) then
			RoleStoryController.instance:openRoleStoryDispatchMainView({
				clickItem = true
			})

			return ViewName.DungeonMapView
		end
	end
end

function var_0_0.showDungeonView(arg_49_0)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId

	if not DungeonModel.instance.curSendEpisodeId then
		return
	end

	local var_49_0 = DungeonModel.instance.curSendEpisodeId

	DungeonModel.instance.curSendEpisodeId = nil

	local var_49_1 = arg_49_0:enterSpecialEquipEpisode(var_49_0)

	if var_49_1 then
		return var_49_1
	end

	local var_49_2 = arg_49_0:enterTeachNote(var_49_0)

	if var_49_2 then
		return var_49_2
	end

	local var_49_3 = arg_49_0:enterVerisonActivity(var_49_0)

	if var_49_3 then
		return var_49_3
	end

	local var_49_4 = arg_49_0:enterRoleStoryChallenge(var_49_0)

	if var_49_4 then
		return var_49_4
	end

	local var_49_5 = arg_49_0:enterFairyLandView(var_49_0)

	if var_49_5 then
		return var_49_5
	end

	local var_49_6 = arg_49_0:enterBossStoryView(var_49_0)

	if var_49_6 then
		return var_49_6
	end

	local var_49_7 = arg_49_0:enterTowerView(var_49_0)

	if var_49_7 then
		return var_49_7
	end

	local var_49_8 = var_49_0 and DungeonConfig.instance:getElementEpisode(var_49_0)
	local var_49_9 = false

	if var_49_8 then
		DungeonMapModel.instance.lastElementBattleId = var_49_0
		var_49_0 = var_49_8
		var_49_9 = true
	end

	DungeonModel.instance.lastSendEpisodeId = var_49_0

	local var_49_10 = DungeonConfig.instance:getEpisodeCO(var_49_0)

	if var_49_10 then
		local var_49_11 = DungeonConfig.instance:getChapterCO(var_49_10.chapterId)

		if var_49_11 and var_49_11.type == DungeonEnum.ChapterType.Newbie then
			return
		end

		if var_49_11.type == DungeonEnum.ChapterType.Explore then
			return arg_49_0:enterDungeonView()
		end

		local var_49_12 = var_49_11.type

		if var_49_12 == DungeonEnum.ChapterType.Hard then
			var_49_12 = DungeonEnum.ChapterType.Normal
		end

		DungeonModel.instance:changeCategory(var_49_12, true)

		local var_49_13 = arg_49_0:enterDungeonView()

		if DungeonModel.instance:getChapterOpenTimeValid(var_49_11) then
			var_49_13 = arg_49_0:openDungeonChapterView({
				chapterId = var_49_11.id
			}, true)

			if DungeonModel.instance.curSendEpisodePass or GuideController.instance:isGuiding() then
				-- block empty
			elseif not var_49_9 and arg_49_0:_showLevelView(var_49_12) then
				var_49_13 = var_0_0.instance:generateLevelViewParam(var_49_10, nil)
			end
		end

		return var_49_13
	end
end

function var_0_0._showLevelView(arg_50_0, arg_50_1)
	return arg_50_1 ~= DungeonEnum.ChapterType.WeekWalk and arg_50_1 ~= DungeonEnum.ChapterType.Season and arg_50_1 ~= DungeonEnum.ChapterType.WeekWalk_2
end

function var_0_0.onReceiveEndDungeonReply(arg_51_0, arg_51_1, arg_51_2)
	if arg_51_1 ~= 0 then
		return
	end

	local var_51_0 = {
		dataList = arg_51_2.firstBonus
	}

	if arg_51_0:isStoryDungeonType(arg_51_2.episodeId) and #arg_51_2.firstBonus > 0 then
		MaterialRpc.instance:onReceiveMaterialChangePush(arg_51_1, var_51_0)
	end
end

function var_0_0.isStoryDungeonType(arg_52_0, arg_52_1)
	local var_52_0 = DungeonConfig.instance:getEpisodeCO(arg_52_1)

	if var_52_0 and var_52_0.type == DungeonEnum.EpisodeType.Story then
		return true
	end

	return false
end

function var_0_0.getEpisodeName(arg_53_0)
	local var_53_0 = arg_53_0.chapterId
	local var_53_1 = lua_chapter.configDict[var_53_0]
	local var_53_2 = arg_53_0.id
	local var_53_3 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(var_53_0, var_53_2)

	if arg_53_0.type == DungeonEnum.EpisodeType.Sp then
		return "SP-" .. var_53_3
	else
		return (string.format("%s-%s", var_53_1.chapterIndex, var_53_3))
	end
end

function var_0_0.openDungeonChangeMapStatusView(arg_54_0, arg_54_1)
	ViewMgr.instance:openView(ViewName.DungeonChangeMapStatusView, arg_54_1)
end

function var_0_0.openPutCubeGameView(arg_55_0, arg_55_1)
	ViewMgr.instance:openView(ViewName.PutCubeGameView, arg_55_1)
end

function var_0_0.openOuijaGameView(arg_56_0, arg_56_1)
	ViewMgr.instance:openView(ViewName.DungeonPuzzleOuijaView, arg_56_1)
end

function var_0_0.queryBgm(arg_57_0, arg_57_1)
	local var_57_0, var_57_1, var_57_2, var_57_3, var_57_4 = DungeonModel.instance:getChapterListTypes()

	if var_57_3 then
		arg_57_1:setClearPauseBgm(true)

		return AudioBgmEnum.Layer.DungeonWeekWalk
	end

	arg_57_1:setClearPauseBgm(false)
	AudioBgmManager.instance:modifyBgm(AudioBgmEnum.Layer.Dungeon, AudioEnum.UI.Play_UI_Slippage_Music, AudioEnum.UI.Stop_UIMusic)

	return AudioBgmEnum.Layer.Dungeon
end

function var_0_0.enterFairyLandView(arg_58_0, arg_58_1)
	if DungeonModel.instance.curSendEpisodePass and (arg_58_1 == 10712 or arg_58_1 == 718) and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FairyLand) then
		if DungeonMapModel.instance:elementIsFinished(FairyLandEnum.ElementId) then
			return
		end

		arg_58_0:enterDungeonView()

		local var_58_0 = DungeonConfig.instance:getEpisodeCO(arg_58_1)
		local var_58_1 = DungeonConfig.instance:getChapterCO(var_58_0.chapterId)

		arg_58_0:openDungeonChapterView({
			chapterId = var_58_1.id
		}, true)
		FairyLandController.instance:openFairyLandView()

		if not FairyLandModel.instance:isFinishFairyLand() then
			return ViewName.FairyLandView
		end
	end
end

function var_0_0.enterBossStoryView(arg_59_0, arg_59_1)
	local var_59_0 = DungeonConfig.instance:getEpisodeCO(arg_59_1)

	if var_59_0 and var_59_0.chapterId == DungeonEnum.ChapterId.BossStory then
		local var_59_1 = 11023

		DungeonModel.instance.lastSendEpisodeId = var_59_1

		arg_59_0:enterDungeonView()

		local var_59_2 = DungeonConfig.instance:getEpisodeCO(var_59_1)
		local var_59_3 = DungeonConfig.instance:getChapterCO(var_59_2.chapterId)
		local var_59_4 = arg_59_0:openDungeonChapterView({
			chapterId = var_59_3.id
		}, true)

		if DungeonModel.instance:chapterIsPass(DungeonEnum.ChapterId.BossStory) then
			return var_59_4
		end

		return VersionActivity2_8DungeonBossController.instance:openVersionActivity2_8BossStoryEnterView()
	end
end

function var_0_0.enterTowerView(arg_60_0, arg_60_1)
	local var_60_0 = DungeonConfig.instance:getEpisodeCO(arg_60_1)

	if not var_60_0 then
		return nil
	end

	local var_60_1

	if var_60_0.type == DungeonEnum.EpisodeType.TowerPermanent or var_60_0.type == DungeonEnum.EpisodeType.TowerDeep then
		var_60_1 = {
			jumpId = TowerEnum.JumpId.TowerPermanent
		}
	end

	if var_60_0.type == DungeonEnum.EpisodeType.TowerBoss then
		var_60_1 = {
			jumpId = TowerEnum.JumpId.TowerBoss
		}

		local var_60_2 = TowerModel.instance:getRecordFightParam()

		var_60_1.towerId = var_60_2 and var_60_2.towerId

		local var_60_3 = TowerModel.instance:getFightFinishParam()

		if var_60_3 and var_60_3.towerType == TowerEnum.TowerType.Boss then
			var_60_1.passLayerId = var_60_3 and var_60_3.layerId
		end
	end

	if var_60_0.type == DungeonEnum.EpisodeType.TowerLimited then
		var_60_1 = {
			jumpId = TowerEnum.JumpId.TowerLimited
		}
	end

	if var_60_0.type == DungeonEnum.EpisodeType.TowerBossTeach then
		var_60_1 = {
			jumpId = TowerEnum.JumpId.TowerBossTeach
		}

		local var_60_4 = TowerModel.instance:getRecordFightParam()

		var_60_1.towerId = var_60_4 and var_60_4.towerId
	end

	if var_60_1 then
		TowerModel.instance:clearFightFinishParam()
		DungeonModel.instance:changeCategory(DungeonEnum.ChapterType.Normal)
		arg_60_0:enterDungeonView()
		TowerController.instance:openMainView(var_60_1)

		return ViewName.TowerMainView
	end
end

function var_0_0.closePreviewChapterDungeonMapViewActEnd(arg_61_0, arg_61_1)
	if arg_61_1 ~= ViewName.DungeonMapView then
		return true
	end

	local var_61_0 = DungeonModel.instance.curLookChapterId

	if not var_61_0 then
		return false
	end

	local var_61_1 = DungeonConfig.instance:getChapterCO(var_61_0)

	if var_61_1 and var_61_1.eaActivityId ~= 0 and not DungeonMainStoryModel.instance:isPreviewChapter(var_61_0) then
		return true
	end

	return false
end

function var_0_0.closePreviewChapterViewActEnd(arg_62_0, arg_62_1)
	local var_62_0 = DungeonConfig.instance:getChapterCO(arg_62_1)

	if not (var_62_0 and var_62_0.eaActivityId ~= 0) then
		return false
	end

	if var_62_0.eaActivityId ~= arg_62_0 then
		return false
	end

	if DungeonMainStoryModel.instance:isPreviewChapter(arg_62_1) then
		return false
	end

	return true
end

function var_0_0.checkEpisodeFiveHero(arg_63_0)
	local var_63_0 = DungeonConfig.instance:getEpisodeCO(arg_63_0)
	local var_63_1 = var_63_0 and lua_chapter.configDict[var_63_0.chapterId]

	if not (var_63_1 and (var_63_1.type == DungeonEnum.ChapterType.Normal or var_63_1.type == DungeonEnum.ChapterType.Hard or var_63_1.type == DungeonEnum.ChapterType.Simple)) then
		return false
	end

	local var_63_2 = var_63_0 and lua_battle.configDict[var_63_0.battleId]

	if var_63_2 and var_63_2.roleNum == ModuleEnum.FiveHeroEnum.MaxHeroNum then
		return true
	end

	return false
end

function var_0_0.saveFiveHeroGroupData(arg_64_0, arg_64_1, arg_64_2, arg_64_3, arg_64_4)
	local var_64_0 = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()

	FightParam.initFightGroup(var_64_0.fightGroup, arg_64_0.clothId, arg_64_0:getMainList(), arg_64_0:getSubList(), arg_64_0:getAllHeroEquips(), arg_64_0:getAllHeroActivity104Equips())

	local var_64_1 = ModuleEnum.HeroGroupSnapshotType.FiveHero
	local var_64_2 = 1

	if arg_64_1 == ModuleEnum.HeroGroupType.General then
		var_64_1 = HeroGroupSnapshotModel.instance:getCurSnapshotId()
		var_64_2 = HeroGroupSnapshotModel.instance:getCurGroupId()
	end

	if var_64_1 and var_64_2 then
		HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(var_64_1, var_64_2, var_64_0, arg_64_3, arg_64_4)
	else
		logError(string.format("未设置快照id, 无法保存, snapshotId:%s, snapshotSubId:%s", var_64_1, var_64_2))
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
