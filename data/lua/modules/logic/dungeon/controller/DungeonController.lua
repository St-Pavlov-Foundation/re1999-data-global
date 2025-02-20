module("modules.logic.dungeon.controller.DungeonController", package.seeall)

slot0 = class("DungeonController", BaseController)

function slot0.checkFirstPass(slot0, slot1)
	slot2 = DungeonModel.instance:getEpisodeInfo(slot1.episodeId)

	if SDKMediaEventEnum.TrackEpisodePassMediaEvent[slot1.episodeId] and slot1.star > 0 and slot2 and slot2.star == 0 then
		SDKDataTrackMgr.instance:trackMediaEvent(SDKMediaEventEnum.TrackEpisodePassMediaEvent[slot1.episodeId])
	end

	if slot1.star > 0 and slot2 and slot2.star == 0 then
		SDKChannelEventModel.instance:episodePass(slot1.episodeId)
	end
end

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
	slot0:registerCallback(DungeonEvent.OnFocusEpisode, slot0._onFocusEpisode, slot0)
	slot0:registerCallback(DungeonEvent.OnSetResScrollPos, slot0._onSetResScrollPos, slot0)
	slot0:registerCallback(DungeonEvent.OnGuideUnlockNewChapter, slot0._onGuideUnlockNewChapter, slot0)
	slot0:registerCallback(DungeonEvent.OnHideCircleMv, slot0._onHideCircleMv, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
	FightController.instance:registerCallback(FightEvent.PushEndFight, slot0._pushEndFight, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenFullViewFinish, slot0._onOpenFullViewFinish, slot0, LuaEventSystem.Low)
end

function slot0._onOpenFullViewFinish(slot0, slot1)
	if slot1 ~= ViewName.StoryBackgroundView then
		return
	end

	if not ViewMgr.instance:getContainer(ViewName.DungeonMapLevelView) then
		return
	end

	if slot2._isVisible then
		for slot8 = #ViewMgr.instance:getOpenViewNameList(), 1, -1 do
			slot9 = slot4[slot8]
			slot3 = string.format("%s#%s", "", slot9)

			if slot1 == slot9 then
				break
			end
		end

		logError(string.format("剧情没有隐藏副本界面 list:%s", slot3))
	end

	slot0:_hideView(ViewName.DungeonMapLevelView)
	slot0:_hideView(ViewName.DungeonMapView)
	slot0:_hideView(ViewName.DungeonView)
	slot0:_hideView(ViewName.MainView)
end

function slot0._hideView(slot0, slot1)
	if ViewMgr.instance:getContainer(slot1) then
		slot2:setVisibleInternal(false)
	end
end

function slot0._pushEndFight(slot0)
	if not FightModel.instance:getRecordMO() or slot1.fightResult == FightEnum.FightResult.Succ then
		return
	end

	slot3 = FightModel.instance:getFightParam() and slot2.episodeId

	if not (slot3 and lua_episode.configDict[slot3]) then
		return
	end

	if DungeonConfig.instance:getChapterCO(slot4.chapterId).type ~= DungeonEnum.ChapterType.Normal then
		return
	end

	if DungeonModel.instance:hasPassLevel(slot3) then
		return
	end

	slot6 = PlayerPrefsKey.DungeonFailure .. PlayerModel.instance:getPlayinfo().userId .. slot3

	PlayerPrefsHelper.setNumber(slot6, PlayerPrefsHelper.getNumber(slot6, 0) + 1)
end

function slot0.reInit(slot0)
end

function slot0.OnOpenNormalMapView(slot0)
	uv0.instance:dispatchEvent(DungeonEvent.OnOpenNormalMapView)
end

function slot0._onDailyRefresh(slot0)
	DungeonRpc.instance:sendGetDungeonRequest()
end

function slot0._onHideCircleMv(slot0)
	UIBlockMgrExtend.setNeedCircleMv(false)
end

function slot0._onGuideUnlockNewChapter(slot0, slot1)
	if tonumber(slot1) ~= 101 then
		DungeonModel.instance.unlockNewChapterId = slot1
		DungeonModel.instance.chapterTriggerNewChapter = false

		return
	end

	if not string.nilorempty(PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.ChapterUnlockEffect)) then
		TaskDispatcher.runDelay(function ()
			uv0.instance:dispatchEvent(DungeonEvent.OnUnlockNewChapterAnimFinish)
		end, nil, 0)

		return
	end

	PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.ChapterUnlockEffect, "1")

	DungeonModel.instance.chapterTriggerNewChapter = true
	DungeonModel.instance.unlockNewChapterId = slot1
end

function slot0._onSetResScrollPos(slot0, slot1)
	DungeonModel.instance.resScrollPosX = tonumber(slot1)
end

function slot0._onFocusEpisode(slot0, slot1)
	DungeonModel.instance:setLastSendEpisodeId(tonumber(slot1))
end

function slot0.enterDungeonView(slot0, slot1, slot2)
	if slot1 then
		DungeonModel.instance:initModel()
	end

	return slot0:openDungeonView({
		fromMainView = slot2
	}, false)
end

function slot0.jumpDungeon(slot0, slot1)
	if not slot1 then
		return {}
	end

	slot4 = slot1.chapterId
	DungeonModel.instance.lastSendEpisodeId = slot1.episodeId

	if not slot1.chapterType then
		return slot2
	end

	slot6 = nil

	if slot3 == DungeonEnum.ChapterType.Hard then
		if not DungeonConfig.instance:getEpisodeCO(slot5) then
			logError("不能直接跳困难章节,可以配合困难关卡跳转")

			return slot2
		end

		if not DungeonConfig.instance:getEpisodeCO(slot7.preEpisode) then
			return slot2
		end

		slot5 = slot8.id
		slot4 = slot8.chapterId
		slot3 = DungeonConfig.instance:getChapterCO(slot8.chapterId).type
		slot6 = true
	end

	if slot3 == DungeonEnum.ChapterType.Newbie then
		logError("不能跳新手章节")

		return slot2
	end

	DungeonModel.instance:changeCategory(slot3)

	if not DungeonConfig.instance:getChapterCO(slot4) then
		table.insert(slot2, ViewName.DungeonView)
		slot0:openDungeonView(nil)

		return slot2
	end

	if DungeonModel.instance:chapterIsLock(slot4) then
		table.insert(slot2, ViewName.DungeonView)
		slot0:openDungeonView(nil)

		return slot2
	end

	slot8 = {
		chapterId = slot4,
		episodeId = slot5
	}

	table.insert(slot2, slot0:getDungeonChapterViewName(slot4))

	if not (slot5 and DungeonConfig.instance:getEpisodeCO(slot5)) then
		slot0:openDungeonChapterView(slot8)

		return slot2
	end

	DungeonModel.instance.curLookChapterId = slot4

	if slot0:jumpChapterAndLevel(slot4, slot9, slot8, slot6, slot1.isNoShowMapLevel) then
		table.insert(slot2, slot10)
	end

	return slot2
end

function slot0.jumpChapterAndLevel(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = slot0:generateLevelViewParam(slot2, slot4, true)
	slot3 = slot3 or {}
	slot3.notOpenHelp = true
	DungeonModel.instance.jumpEpisodeId = slot3.episodeId

	table.insert({}, {
		openFunction = function ()
			uv0:openDungeonChapterView(uv1, true)
		end,
		waitOpenViewName = slot0:getDungeonChapterViewName(slot1)
	})

	if not slot5 then
		table.insert(slot7, {
			openFunction = function ()
				uv0:generateLevelViewParam(uv1, uv2)
			end
		})
	end

	module_views_preloader.DungeonChapterAndLevelView(function ()
		OpenMultiView.openView(uv0)
	end, slot1, slot6)

	return slot6
end

function slot0.generateLevelViewParam(slot0, slot1, slot2, slot3)
	if not (DungeonModel.instance:getEpisodeInfo(slot1.id) or nil) then
		return nil
	end

	slot6, slot7 = DungeonConfig.instance:getChapterIndex(DungeonModel.instance.curChapterType, DungeonModel.instance.curLookChapterId)

	return slot0:enterLevelView({
		slot1,
		slot5,
		slot6,
		DungeonConfig.instance:getChapterEpisodeIndexWithSP(DungeonModel.instance.curLookChapterId, slot1.id),
		slot2,
		true
	}, slot3)
end

function slot0.enterLevelView(slot0, slot1, slot2)
	if not slot1[1] then
		logError("找不到配置")

		return nil
	end

	if DungeonModel.isBattleEpisode(slot4) then
		if not slot2 then
			uv0.instance:openDungeonLevelView(slot1)
		end

		slot3 = slot0:getDungeonLevelViewName(slot4.chapterId)
	elseif slot4.type == DungeonEnum.EpisodeType.Story then
		if not slot2 then
			uv0.instance:openDungeonLevelView(slot1)
		end

		slot3 = slot0:getDungeonLevelViewName(slot4.chapterId)
	elseif slot4.type == DungeonEnum.EpisodeType.Decrypt then
		if not slot2 then
			-- Nothing
		end

		slot3 = ViewName.DungeonPuzzleChangeColorView
	end

	return slot3
end

function slot0.canJumpDungeonType(slot0, slot1)
	slot2 = true
	slot3 = DungeonEnum.ChapterType.Normal

	if slot1 == JumpEnum.DungeonChapterType.Gold then
		slot3 = DungeonEnum.ChapterType.Gold
		slot2 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.GainDungeon)
	elseif slot1 == JumpEnum.DungeonChapterType.Resource then
		slot3 = DungeonEnum.ChapterType.Break
		slot2 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.ResDungeon)
	elseif slot1 == JumpEnum.DungeonChapterType.WeekWalk then
		slot3 = DungeonEnum.ChapterType.WeekWalk
		slot2 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk)
	elseif slot1 == JumpEnum.DungeonChapterType.Explore then
		slot3 = DungeonEnum.ChapterType.Explore
		slot2 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Explore)
	end

	if slot2 and DungeonModel.instance:getChapterListOpenTimeValid(slot3) then
		return true
	end

	return false
end

function slot0.canJumpDungeonChapter(slot0, slot1)
	if not DungeonConfig.instance:getChapterCO(slot1) then
		return false
	end

	slot4 = JumpEnum.DungeonChapterType.Story
	slot5 = true

	if slot2.type == DungeonEnum.ChapterType.Gold or slot3 == DungeonEnum.ChapterType.Exp or slot3 == DungeonEnum.ChapterType.Equip then
		slot4 = JumpEnum.DungeonChapterType.Gold

		if slot3 == DungeonEnum.ChapterType.Gold then
			slot5 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.GoldDungeon)
		elseif slot3 == DungeonEnum.ChapterType.Exp then
			slot5 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.ExperienceDungeon)
		elseif slot3 == DungeonEnum.ChapterType.Equip then
			slot5 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.EquipDungeon)
		elseif slot3 == DungeonEnum.ChapterType.Buildings then
			slot5 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Buildings)
		end
	elseif slot3 == DungeonEnum.ChapterType.Break then
		slot4 = JumpEnum.DungeonChapterType.Resource
	end

	if slot0:canJumpDungeonType(slot4) and slot5 and not DungeonModel.instance:chapterIsLock(slot1) and DungeonModel.instance:getChapterOpenTimeValid(slot2) then
		return true
	end

	return false
end

function slot0.openDungeonEquipEntryView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.DungeonEquipEntryView, slot1, slot2)

	return ViewName.DungeonEquipEntryView
end

function slot0.openDungeonView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.DungeonView, slot1, slot2)

	return ViewName.DungeonView
end

function slot0.openDungeonMapTaskView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.DungeonMapTaskView, slot1, slot2)

	return ViewName.DungeonMapTaskView
end

function slot0.openDungeonChapterView(slot0, slot1, slot2)
	if slot1 and slot1.chapterId then
		DungeonModel.instance.curLookChapterId = slot1.chapterId
	end

	if DungeonConfig.instance:getChapterCO(slot1.chapterId).type == DungeonEnum.ChapterType.WeekWalk then
		WeekWalkController.instance:openWeekWalkView(slot1, slot2)

		return ViewName.WeekWalkView
	elseif slot3.type == DungeonEnum.ChapterType.Season or slot3.type == DungeonEnum.ChapterType.SeasonRetail or slot3.type == DungeonEnum.ChapterType.SeasonSpecial then
		Activity104Controller.instance:openSeasonMainView()

		return ViewName.SeasonMainView
	elseif slot3.type == DungeonEnum.ChapterType.Season123 or slot3.type == DungeonEnum.ChapterType.Season123Retail then
		Season123Controller.instance:openMainViewFromFightScene()

		return Season123Controller.instance:getEpisodeListViewName()
	elseif slot3.id == HeroInvitationEnum.ChapterId then
		slot0._lastChapterId = slot1.chapterId

		DungeonModel.instance:changeCategory(slot3.type, false)
		HeroInvitationRpc.instance:sendGetHeroInvitationInfoRequest()
		ViewMgr.instance:openView(ViewName.HeroInvitationDungeonMapView, slot1, slot2)

		return ViewName.HeroInvitationDungeonMapView
	end

	slot0._lastChapterId = slot1.chapterId

	DungeonModel.instance:changeCategory(slot3.type, false)
	ViewMgr.instance:openView(ViewName.DungeonMapView, slot1, slot2)

	return ViewName.DungeonMapView
end

function slot0.getDungeonChapterViewName(slot0, slot1)
	if slot1 == HeroInvitationEnum.ChapterId then
		return ViewName.HeroInvitationDungeonMapView
	end

	return ViewName.DungeonMapView
end

function slot0.getDungeonLevelViewName(slot0, slot1)
	return ViewName.DungeonMapLevelView
end

function slot0.openDungeonCumulativeRewardsView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.DungeonCumulativeRewardsView, slot1, slot2)
end

function slot0.openDungeonLevelView(slot0, slot1, slot2)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SkipShowDungeonMapLevelView) then
		GuideModel.instance:setFlag(GuideModel.GuideFlag.SkipShowDungeonMapLevelView, nil)

		return
	end

	DungeonModel.instance.curLookEpisodeId = slot1[1].id

	ViewMgr.instance:openView(ViewName.DungeonMapLevelView, slot1, slot2)
end

function slot0.openDungeonMonsterView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.DungeonMonsterView, slot1, slot2)
end

function slot0.openDungeonRewardView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.DungeonRewardView, slot1, slot2)
end

function slot0.openDungeonElementRewardView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.DungeonElementRewardView, slot1, slot2)
end

function slot0.openDungeonStoryView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.DungeonStoryView, slot1, slot2)
end

function slot0.onStartLevelOrStoryChange(slot0)
	DungeonModel.instance:startCheckUnlockChapter()
	slot0:_onStartCheckUnlockContent()
end

function slot0.onEndLevelOrStoryChange(slot0)
	DungeonModel.instance:endCheckUnlockChapter()
	slot0:_onEndCheckUnlockContent()
end

function slot0._onStartCheckUnlockContent(slot0)
	if not DungeonModel.instance.curSendEpisodeId then
		return
	end

	slot0._hasAllPass = DungeonModel.instance:hasPassLevelAndStory(DungeonModel.instance.curSendEpisodeId)
end

function slot0._onEndCheckUnlockContent(slot0)
	if not DungeonModel.instance.curSendEpisodeId then
		return
	end

	if DungeonModel.instance:hasPassLevelAndStory(DungeonModel.instance.curSendEpisodeId) and slot1 ~= slot0._hasAllPass then
		uv0.instance:showUnlockContentToast(DungeonModel.instance.curSendEpisodeId)
	end
end

function slot0.showUnlockContentToast(slot0, slot1)
	for slot6, slot7 in ipairs(DungeonChapterUnlockItem.getUnlockContentList(slot1, true)) do
		if DungeonConfig.instance:getChapterCO(lua_episode.configDict[slot1].chapterId).type ~= DungeonEnum.ChapterType.TeachNote then
			GameFacade.showToast(ToastEnum.IconId, slot7)
		end
	end
end

function slot0.needShowDungeonView(slot0)
	if not DungeonModel.instance.curSendEpisodeId then
		return
	end

	if DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId) then
		if DungeonConfig.instance:getChapterCO(slot1.chapterId) and slot2.type == DungeonEnum.ChapterType.Newbie then
			return
		end

		if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightBackSkipDungeonView) then
			DungeonModel.instance.curSendEpisodeId = nil

			GuideModel.instance:setFlag(GuideModel.GuideFlag.FightBackSkipDungeonView, nil)

			return
		end

		if slot2.type == DungeonEnum.ChapterType.DreamTailNormal or slot2.type == DungeonEnum.ChapterType.DreamTailHard then
			return true
		end

		if TeachNoteModel.instance:isJumpEnter() then
			DungeonModel.instance.curSendEpisodeId = nil

			return
		end

		if slot1.type == DungeonEnum.EpisodeType.Dog then
			return
		end

		if slot1.type == DungeonEnum.EpisodeType.RoleStoryChallenge and not RoleStoryModel.instance:checkActStoryOpen() then
			return
		end

		return true
	end
end

function slot0.enterTeachNote(slot0, slot1)
	if not slot1 then
		return nil
	end

	if not DungeonConfig.instance:getEpisodeCO(slot1) then
		return nil
	end

	if DungeonConfig.instance:getChapterCO(slot2.chapterId).type ~= DungeonEnum.ChapterType.TeachNote then
		return nil
	end

	if not TeachNoteModel.instance:isTeachNoteEnterFight() then
		return
	else
		if TeachNoteModel.instance:isDetailEnter() and DungeonModel.instance:hasPassLevel(slot1) then
			return
		end

		DungeonModel.instance.curLookChapterId = slot2.chapterId
	end

	slot0:enterDungeonView(true)

	if TeachNoteModel.instance:isTeachNoteChapter(DungeonModel.instance.curLookChapterId) then
		DungeonModel.instance.curSendEpisodeId = DungeonModel.instance.curLookEpisodeIdId

		if TeachNoteModel.instance:isTeachNoteEnterFight() then
			slot0:openDungeonChapterView({
				chapterId = slot0._lastChapterId
			}, true)

			if TeachNoteModel.instance:isDetailEnter() then
				TeachNoteModel.instance:setTeachNoteEnterFight(false)

				return TeachNoteController.instance:enterTeachNoteDetailView(slot1)
			else
				TeachNoteModel.instance:setTeachNoteEnterFight(false)

				return TeachNoteController.instance:enterTeachNoteView(slot1)
			end
		else
			if not slot0._lastChapterId then
				slot0._lastChapterId = 101
			end

			return slot0:openDungeonChapterView({
				chapterId = slot0._lastChapterId
			}, true)
		end
	else
		return slot0:openDungeonChapterView({
			chapterId = DungeonModel.instance.curLookChapterId
		}, true)
	end
end

function slot0.enterSpecialEquipEpisode(slot0, slot1)
	if not slot1 then
		return nil
	end

	if not DungeonConfig.instance:getEpisodeCO(slot1) then
		return nil
	end

	if slot2.type ~= DungeonEnum.EpisodeType.SpecialEquip then
		return nil
	end

	slot4 = DungeonConfig.instance:getChapterCO(DungeonChapterListModel.instance:getOpenTimeValidEquipChapterId())

	DungeonModel.instance:changeCategory(slot4.type, true)

	slot6 = slot0:enterDungeonView()

	if DungeonModel.instance:getChapterOpenTimeValid(slot4) then
		slot6 = slot0:openDungeonChapterView({
			chapterId = slot3
		}, true)

		if DungeonMapModel.instance:isUnlockSpChapter(slot2.chapterId) then
			slot6 = slot0:openDungeonEquipEntryView(slot2.chapterId)
		end
	end

	return slot6
end

function slot0.enterVerisonActivity(slot0, slot1)
	if not DungeonConfig.instance:getEpisodeCO(slot1) then
		return nil
	end

	if slot2.type == DungeonEnum.EpisodeType.Meilanni then
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

function slot0.enterRoleStoryChallenge(slot0, slot1)
	if not DungeonConfig.instance:getEpisodeCO(slot1) then
		return nil
	end

	if slot2.type == DungeonEnum.EpisodeType.RoleStoryChallenge then
		RoleStoryController.instance:openRoleStoryDispatchMainView({
			1
		})

		return ViewName.RoleStoryDispatchMainView
	end

	if DungeonConfig.instance:getChapterCO(slot2.chapterId).type == DungeonEnum.ChapterType.RoleStory and not RoleStoryModel.instance:isInResident(RoleStoryConfig.instance:getStoryIdByChapterId(slot2.chapterId)) then
		RoleStoryController.instance:openRoleStoryDispatchMainView({
			clickItem = true
		})

		return ViewName.DungeonMapView
	end
end

function slot0.showDungeonView(slot0)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId

	if not DungeonModel.instance.curSendEpisodeId then
		return
	end

	DungeonModel.instance.curSendEpisodeId = nil

	if slot0:enterSpecialEquipEpisode(DungeonModel.instance.curSendEpisodeId) then
		return slot2
	end

	if slot0:enterTeachNote(slot1) then
		return slot2
	end

	if slot0:enterVerisonActivity(slot1) then
		return slot2
	end

	if slot0:enterRoleStoryChallenge(slot1) then
		return slot2
	end

	if slot0:enterFairyLandView(slot1) then
		return slot2
	end

	if slot0:enterTowerView(slot1) then
		return slot2
	end

	slot4 = false

	if slot1 and DungeonConfig.instance:getElementEpisode(slot1) then
		DungeonMapModel.instance.lastElementBattleId = slot1
		slot1 = slot3
		slot4 = true
	end

	DungeonModel.instance.lastSendEpisodeId = slot1

	if DungeonConfig.instance:getEpisodeCO(slot1) then
		if DungeonConfig.instance:getChapterCO(slot5.chapterId) and slot6.type == DungeonEnum.ChapterType.Newbie then
			return
		end

		if slot6.type == DungeonEnum.ChapterType.Explore then
			return slot0:enterDungeonView()
		end

		if slot6.type == DungeonEnum.ChapterType.Hard then
			slot7 = DungeonEnum.ChapterType.Normal
		end

		DungeonModel.instance:changeCategory(slot7, true)

		slot2 = slot0:enterDungeonView()

		if DungeonModel.instance:getChapterOpenTimeValid(slot6) then
			slot2 = slot0:openDungeonChapterView({
				chapterId = slot6.id
			}, true)

			if not DungeonModel.instance.curSendEpisodePass then
				if GuideController.instance:isGuiding() then
					-- Nothing
				elseif not slot4 and slot0:_showLevelView(slot7) then
					slot2 = uv0.instance:generateLevelViewParam(slot5, nil)
				end
			end
		end

		return slot2
	end
end

function slot0._showLevelView(slot0, slot1)
	return slot1 ~= DungeonEnum.ChapterType.WeekWalk and slot1 ~= DungeonEnum.ChapterType.Season
end

function slot0.onReceiveEndDungeonReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	if slot0:isStoryDungeonType(slot2.episodeId) and #slot2.firstBonus > 0 then
		MaterialRpc.instance:onReceiveMaterialChangePush(slot1, {
			dataList = slot2.firstBonus
		})
	end
end

function slot0.isStoryDungeonType(slot0, slot1)
	if DungeonConfig.instance:getEpisodeCO(slot1) and slot2.type == DungeonEnum.EpisodeType.Story then
		return true
	end

	return false
end

function slot0.getEpisodeName(slot0)
	slot1 = slot0.chapterId
	slot2 = lua_chapter.configDict[slot1]

	if slot0.type == DungeonEnum.EpisodeType.Sp then
		return "SP-" .. DungeonConfig.instance:getChapterEpisodeIndexWithSP(slot1, slot0.id)
	else
		return string.format("%s-%s", slot2.chapterIndex, slot4)
	end
end

function slot0.openDungeonChangeMapStatusView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.DungeonChangeMapStatusView, slot1)
end

function slot0.openPutCubeGameView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.PutCubeGameView, slot1)
end

function slot0.openOuijaGameView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.DungeonPuzzleOuijaView, slot1)
end

function slot0.queryBgm(slot0, slot1)
	slot2, slot3, slot4, slot5, slot6 = DungeonModel.instance:getChapterListTypes()

	if slot5 then
		slot1:setClearPauseBgm(true)

		return AudioBgmEnum.Layer.DungeonWeekWalk
	end

	slot1:setClearPauseBgm(false)

	return AudioBgmEnum.Layer.Dungeon
end

function slot0.enterFairyLandView(slot0, slot1)
	if DungeonModel.instance.curSendEpisodePass and (slot1 == 10712 or slot1 == 718) and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FairyLand) then
		if DungeonMapModel.instance:elementIsFinished(FairyLandEnum.ElementId) then
			return
		end

		slot0:enterDungeonView()
		slot0:openDungeonChapterView({
			chapterId = DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(slot1).chapterId).id
		}, true)
		FairyLandController.instance:openFairyLandView()

		if not FairyLandModel.instance:isFinishFairyLand() then
			return ViewName.FairyLandView
		end
	end
end

function slot0.enterTowerView(slot0, slot1)
	if not DungeonConfig.instance:getEpisodeCO(slot1) then
		return nil
	end

	slot3 = nil

	if slot2.type == DungeonEnum.EpisodeType.TowerPermanent then
		slot3 = {
			jumpId = TowerEnum.JumpId.TowerPermanent
		}
	end

	if slot2.type == DungeonEnum.EpisodeType.TowerBoss then
		slot3 = {
			jumpId = TowerEnum.JumpId.TowerBoss,
			towerId = TowerModel.instance:getRecordFightParam() and slot4.towerId,
			passLayerId = slot5 and slot5.layerId
		}

		if TowerModel.instance:getFightFinishParam() and slot5.towerType == TowerEnum.TowerType.Boss then
			-- Nothing
		end
	end

	if slot2.type == DungeonEnum.EpisodeType.TowerLimited then
		slot3 = {
			jumpId = TowerEnum.JumpId.TowerLimited
		}
	end

	if slot3 then
		TowerModel.instance:clearFightFinishParam()
		DungeonModel.instance:changeCategory(DungeonEnum.ChapterType.Normal)
		slot0:enterDungeonView()
		TowerController.instance:openMainView(slot3)

		return ViewName.TowerMainView
	end
end

slot0.instance = slot0.New()

return slot0
