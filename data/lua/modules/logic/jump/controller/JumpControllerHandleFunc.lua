module("modules.logic.jump.controller.JumpControllerHandleFunc", package.seeall)

slot0 = JumpController
slot0.DefaultToastId = 0

function slot0.activateHandleFuncController()
end

function slot0.defaultHandleFunc(slot0, slot1)
	return JumpEnum.JumpResult.Success
end

function slot0.jumpToRoleStoryActivity(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.RoleStoryDispatchMainView)

	if RoleStoryController.instance:openRoleStoryDispatchMainView(string.splitToNumber(slot1, "#")) then
		return JumpEnum.JumpResult.Success
	end

	tabletool.removeValue(slot0.waitOpenViewNames, slot3)

	return JumpEnum.JumpResult.Fail
end

function slot0.jumpToStoreView(slot0, slot1)
	slot2 = string.splitToNumber(slot1, "#")

	table.insert(slot0.waitOpenViewNames, ViewName.StoreView)
	table.insert(slot0.closeViewNames, ViewName.NormalStoreGoodsView)
	table.insert(slot0.closeViewNames, ViewName.ChargeStoreGoodsView)
	table.insert(slot0.remainViewNames, ViewName.StoreView)

	if ViewMgr.instance:isOpen(ViewName.DungeonView) and DungeonModel.instance.curChapterType == DungeonEnum.ChapterType.WeekWalk then
		table.insert(slot0.remainViewNames, ViewName.DungeonView)
	end

	if #slot2 >= 2 then
		slot4 = slot2[3]

		if (slot2[2] == StoreEnum.StoreId.Package or slot3 == StoreEnum.StoreId.RecommendPackage or slot3 == StoreEnum.StoreId.NormalPackage or slot3 == StoreEnum.StoreId.OneTimePackage or slot3 == StoreEnum.StoreId.VersionPackage) and slot4 then
			table.insert(slot0.remainViewNames, ViewName.PackageStoreGoodsView)
		end

		StoreController.instance:openStoreView(slot3, slot4)
	else
		StoreController.instance:openStoreView()
	end

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToSummonView(slot0, slot1)
	table.insert(slot0.remainViewNames, ViewName.SummonADView)
	table.insert(slot0.remainViewNames, ViewName.SummonView)

	if #string.splitToNumber(slot1, "#") >= 2 then
		SummonController.instance:jumpSummon(slot2[2])
	else
		SummonController.instance:jumpSummon()
	end

	ViewMgr.instance:closeAllPopupViews({
		ViewName.SummonADView,
		ViewName.SummonView
	})

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToSummonViewGroup(slot0, slot1)
	table.insert(slot0.remainViewNames, ViewName.SummonADView)
	table.insert(slot0.remainViewNames, ViewName.SummonView)

	if #string.splitToNumber(slot1, "#") >= 2 then
		SummonController.instance:jumpSummonByGroup(slot2[2])
	else
		SummonController.instance:jumpSummon()
	end

	ViewMgr.instance:closeAllPopupViews({
		ViewName.SummonADView,
		ViewName.SummonView
	})

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToDungeonViewWithChapter(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.DungeonMapView)
	table.insert(slot0.closeViewNames, ViewName.HeroInvitationView)
	table.insert(slot0.closeViewNames, ViewName.HeroInvitationDungeonMapView)
	table.insert(slot0.closeViewNames, ViewName.DungeonMapView)
	table.insert(slot0.closeViewNames, ViewName.DungeonMapLevelView)
	table.insert(slot0.closeViewNames, ViewName.VersionActivity1_5DungeonMapView)
	table.insert(slot0.closeViewNames, ViewName.VersionActivity1_5DungeonMapLevelView)
	table.insert(slot0.closeViewNames, ViewName.WeekWalkView)
	table.insert(slot0.closeViewNames, ViewName.WeekWalkCharacterView)
	table.insert(slot0.closeViewNames, ViewName.WeekWalkLayerView)
	table.insert(slot0.closeViewNames, ViewName.WeekWalkLayerRewardView)
	table.insert(slot0.closeViewNames, ViewName.StoryView)
	table.insert(slot0.closeViewNames, ViewName.DungeonPuzzleChangeColorView)

	if DungeonConfig.instance:getChapterCO(string.splitToNumber(slot1, "#")[2]) then
		if DungeonController.instance:jumpDungeon({
			chapterType = slot4.type,
			chapterId = slot3
		}) and #slot7 > 0 then
			for slot11, slot12 in ipairs(slot7) do
				table.insert(slot0.remainViewNames, slot12)
			end

			table.insert(slot0.remainViewNames, ViewName.DungeonView)
		end

		return JumpEnum.JumpResult.Success
	else
		logError("找不到章节配置, chapterId: " .. tostring(slot3))

		return JumpEnum.JumpResult.Fail
	end

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToDungeonViewWithEpisode(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.DungeonMapView)

	if string.splitToNumber(slot1, "#")[3] ~= 1 then
		table.insert(slot0.waitOpenViewNames, ViewName.DungeonMapLevelView)
	end

	table.insert(slot0.closeViewNames, ViewName.HeroInvitationView)
	table.insert(slot0.closeViewNames, ViewName.HeroInvitationDungeonMapView)
	table.insert(slot0.closeViewNames, ViewName.DungeonMapView)
	table.insert(slot0.closeViewNames, ViewName.DungeonMapLevelView)
	table.insert(slot0.closeViewNames, ViewName.VersionActivity1_5DungeonMapView)
	table.insert(slot0.closeViewNames, ViewName.VersionActivity1_5DungeonMapLevelView)
	table.insert(slot0.closeViewNames, ViewName.WeekWalkView)
	table.insert(slot0.closeViewNames, ViewName.WeekWalkCharacterView)
	table.insert(slot0.closeViewNames, ViewName.WeekWalkLayerView)
	table.insert(slot0.closeViewNames, ViewName.WeekWalkLayerRewardView)
	table.insert(slot0.closeViewNames, ViewName.StoryView)
	table.insert(slot0.closeViewNames, ViewName.DungeonPuzzleChangeColorView)
	table.insert(slot0.closeViewNames, ViewName.InvestigateOpinionView)
	table.insert(slot0.closeViewNames, ViewName.InvestigateView)

	for slot6 in pairs(ActivityHelper.getJumpNeedCloseViewDict()) do
		table.insert(slot0.closeViewNames, slot6)
	end

	if DungeonConfig.instance:getEpisodeCO(slot2[2]) then
		if DungeonConfig.instance:getChapterCO(slot5.chapterId) then
			if DungeonController.instance:jumpDungeon({
				chapterType = slot7.type,
				chapterId = slot6,
				episodeId = slot3,
				isNoShowMapLevel = slot2[3] == 1
			}) and #slot10 > 0 then
				for slot14, slot15 in ipairs(slot10) do
					table.insert(slot0.remainViewNames, slot15)
				end

				table.insert(slot0.remainViewNames, ViewName.DungeonView)
			else
				return JumpEnum.JumpResult.Fail
			end
		else
			logError("找不到章节配置, chapterId: " .. tostring(slot6))

			return JumpEnum.JumpResult.Fail
		end
	else
		logError("找不到关卡配置, episodeId: " .. tostring(slot3))

		return JumpEnum.JumpResult.Fail
	end

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToDungeonViewWithType(slot0, slot1)
	if (string.splitToNumber(slot1, "#")[2] or JumpEnum.DungeonChapterType.Story) == JumpEnum.DungeonChapterType.Story then
		-- Nothing
	elseif slot3 == JumpEnum.DungeonChapterType.Gold then
		slot4.chapterType = DungeonEnum.ChapterType.Gold
	elseif slot3 == JumpEnum.DungeonChapterType.Resource then
		slot4.chapterType = DungeonEnum.ChapterType.Break
	elseif slot3 == JumpEnum.DungeonChapterType.Explore then
		slot4.chapterType = DungeonEnum.ChapterType.Explore
	elseif slot3 == JumpEnum.DungeonChapterType.WeekWalk then
		slot4.chapterType = DungeonEnum.ChapterType.WeekWalk

		if ViewMgr.instance:isOpen(ViewName.WeekWalkView) or ViewMgr.instance:isOpen(ViewName.DungeonView) and DungeonModel.instance.curChapterType == DungeonEnum.ChapterType.WeekWalk then
			ViewMgr.instance:closeView(ViewName.TaskView)
			ViewMgr.instance:closeView(ViewName.StoreView)
			ViewMgr.instance:closeView(ViewName.BpView)

			return JumpEnum.JumpResult.Success
		end
	elseif slot3 == JumpEnum.DungeonChapterType.RoleStory then
		slot4.chapterType = DungeonEnum.ChapterType.RoleStory
	end

	table.insert(slot0.closeViewNames, ViewName.HeroInvitationView)
	table.insert(slot0.closeViewNames, ViewName.HeroInvitationDungeonMapView)
	table.insert(slot0.closeViewNames, ViewName.DungeonMapView)
	table.insert(slot0.closeViewNames, ViewName.DungeonMapLevelView)
	table.insert(slot0.closeViewNames, ViewName.VersionActivity1_5DungeonMapView)
	table.insert(slot0.closeViewNames, ViewName.VersionActivity1_5DungeonMapLevelView)
	table.insert(slot0.closeViewNames, ViewName.WeekWalkView)
	table.insert(slot0.closeViewNames, ViewName.WeekWalkCharacterView)
	table.insert(slot0.closeViewNames, ViewName.WeekWalkLayerView)
	table.insert(slot0.closeViewNames, ViewName.WeekWalkLayerRewardView)
	table.insert(slot0.closeViewNames, ViewName.StoryView)
	table.insert(slot0.closeViewNames, ViewName.DungeonPuzzleChangeColorView)

	if DungeonController.instance:jumpDungeon({
		chapterType = DungeonEnum.ChapterType.Normal
	}) and #slot5 > 0 then
		for slot9, slot10 in ipairs(slot5) do
			table.insert(slot0.remainViewNames, slot10)
		end

		table.insert(slot0.remainViewNames, ViewName.DungeonView)
	else
		return JumpEnum.JumpResult.Fail
	end

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToCharacterBackpackViewWithCharacter(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.CharacterBackpackView)
	CharacterController.instance:enterCharacterBackpack(JumpEnum.CharacterBackpack.Character)
	table.insert(slot0.remainViewNames, ViewName.CharacterBackpackView)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToCharacterBackpackViewWithEquip(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.BackpackView)
	BackpackController.instance:enterItemBackpack(ItemEnum.CategoryType.Equip)
	table.insert(slot0.remainViewNames, ViewName.BackpackView)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToHeroGroupView(slot0, slot1)
	slot3 = string.splitToNumber(slot1, "#")[2]

	DungeonFightController.instance:enterFight(DungeonConfig.instance:getEpisodeCO(slot3).chapterId, slot3)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToBackpackView(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.BackpackView)
	BackpackController.instance:enterItemBackpack()
	table.insert(slot0.remainViewNames, ViewName.BackpackView)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToPlayerClothView(slot0, slot1)
	logError("废弃跳转到主角技能界面")

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToMainView(slot0, slot1)
	ViewMgr.instance:closeAllPopupViews()
	MainController.instance:enterMainScene()

	if string.splitToNumber(slot1, "#")[2] == 1 then
		ViewMgr.instance:openView(ViewName.MainView)
	end

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToTaskView(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.TaskView)
	table.insert(slot0.closeViewNames, ViewName.WeekWalkView)
	table.insert(slot0.closeViewNames, ViewName.WeekWalkCharacterView)
	table.insert(slot0.closeViewNames, ViewName.WeekWalkLayerView)

	slot3 = nil

	if #string.splitToNumber(slot1, "#") >= 2 then
		slot3 = slot2[2]
	end

	TaskController.instance:enterTaskView(slot3)
	table.insert(slot0.remainViewNames, ViewName.TaskView)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToRoomView(slot0, slot1)
	return JumpEnum.JumpResult.Success
end

function slot0.jumpToRoomProductLineView(slot0, slot1)
	if RoomController.instance:isEditMode() and RoomController.instance:isRoomScene() then
		GameFacade.showToast(RoomEnum.Toast.RoomEditCanNotOpenProductionLevel)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(slot0.waitOpenViewNames, ViewName.RoomInitBuildingView)

	if not ViewMgr.instance:isOpen(ViewName.RoomFormulaView) then
		if slot2 then
			RoomMapController.instance:openRoomInitBuildingView(0, {
				partId = 3
			})
			ViewMgr.instance:closeAllPopupViews({
				ViewName.RoomInitBuildingView,
				ViewName.RoomFormulaView,
				ViewName.RoomInventorySelectView
			})
		else
			RoomMapController.instance:openFormulaItemBuildingViewOutSide()
		end
	end

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToTeachNoteView(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.TeachNoteView)
	TeachNoteController.instance:enterTeachNoteView(TeachNoteModel.instance:getJumpEpisodeId(), true)
	table.insert(slot0.remainViewNames, ViewName.TeachNoteView)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToEquipView(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.EquipView)

	if string.splitToNumber(slot1, "#")[2] then
		EquipController.instance:openEquipView({
			equipId = slot3
		})
		table.insert(slot0.remainViewNames, ViewName.EquipView)
		table.insert(slot0.remainViewNames, ViewName.GiftMultipleChoiceView)
	else
		logError("equip id cant be null ...")

		return JumpEnum.JumpResult.Fail
	end

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToHandbookView(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.HandbookView)
	table.insert(slot0.closeViewNames, ViewName.HandBookCharacterSwitchView)
	table.insert(slot0.closeViewNames, ViewName.HandbookEquipView)
	table.insert(slot0.closeViewNames, ViewName.HandbookStoryView)
	table.insert(slot0.closeViewNames, ViewName.HandbookCGDetailView)
	table.insert(slot0.closeViewNames, ViewName.CharacterDataView)

	for slot7, slot8 in ipairs(HandbookController.instance:jumpView(string.splitToNumber(slot1, "#"))) do
		table.insert(slot0.remainViewNames, slot8)
	end

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToSocialView(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.SocialView)

	slot3 = nil

	if string.splitToNumber(slot1, "#")[2] then
		slot3 = {
			defaultTabIds = {
				[2] = slot2[2]
			}
		}
	end

	SocialController.instance:openSocialView(slot3)
	table.insert(slot0.remainViewNames, ViewName.SocialView)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToNoticeView(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.NoticeView)
	NoticeController.instance:openNoticeView()
	table.insert(slot0.remainViewNames, ViewName.NoticeView)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToSignInView(slot0, slot1)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SignIn) then
		GameFacade.showToast(ToastEnum.JumpSignView)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(slot0.waitOpenViewNames, ViewName.SignInView)
	SignInController.instance:openSignInDetailView({
		isBirthday = false
	})
	table.insert(slot0.remainViewNames, ViewName.SignInView)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToSignInViewWithBirthDay(slot0, slot1)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SignIn) then
		GameFacade.showToast(ToastEnum.JumpSignView)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(slot0.waitOpenViewNames, ViewName.SignInView)
	SignInController.instance:openSignInDetailView({
		isBirthday = true
	})
	table.insert(slot0.remainViewNames, ViewName.SignInView)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToMailView(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.MailView)
	MailController.instance:enterMailView(string.splitToNumber(slot1, "#")[2])
	table.insert(slot0.remainViewNames, ViewName.MailView)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToSeasonMainView(slot0, slot1)
	slot3, slot4, slot5 = ActivityHelper.getActivityStatusAndToast(Activity104Model.instance:getCurSeasonId())

	if slot3 ~= ActivityEnum.ActivityStatus.Normal then
		if slot4 then
			GameFacade.showToastWithTableParam(slot4, slot5)
		end

		return JumpEnum.JumpResult.Fail
	end

	if (string.splitToNumber(slot1, "#") and slot6[2]) == Activity104Enum.JumpId.Discount and not Activity104Model.instance:isSpecialOpen() then
		GameFacade.showToast(ToastEnum.SeasonDiscountOpen)

		return JumpEnum.JumpResult.Fail
	end

	VersionActivity1_6EnterController.instance:openVersionActivityEnterView(function ()
		Activity104Controller.instance:openSeasonMainView({
			jumpId = uv0
		})
	end, nil, slot2)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToShow(slot0, slot1)
	return JumpEnum.JumpResult.Fail
end

function slot0.jumpToBpView(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.BpView)
	BpController.instance:openBattlePassView(tonumber(string.splitToNumber(slot1, "#")[2]) == 1, nil, tonumber(slot2[3]) == 1)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToActivityView(slot0, slot1)
	if _G[string.format("VersionActivity%sJumpHandleFunc", ActivityHelper.getActivityVersion(string.splitToNumber(slot1, "#")[2]))] and slot5["jumpTo" .. slot3] then
		return slot5["jumpTo" .. slot3](slot0, slot2)
	end

	if uv0.JumpActViewToHandleFunc[slot3] then
		return slot6(slot0, slot3, slot2)
	end

	if slot3 == JumpEnum.ActIdEnum.Activity104 then
		table.insert(slot0.waitOpenViewNames, ViewName.VersionActivityEnterView)
		table.insert(slot0.waitOpenViewNames, ViewName.SeasonMainView)
		VersionActivityController.instance:openVersionActivityEnterViewIfNotOpened(function ()
			Activity104Controller.instance:openSeasonMainView()
		end)
	elseif slot3 == JumpEnum.ActIdEnum.Act105 then
		table.insert(slot0.waitOpenViewNames, ViewName.VersionActivityEnterView)
		VersionActivityController.instance:openVersionActivityEnterView()
	elseif slot3 == JumpEnum.ActIdEnum.Act106 then
		table.insert(slot0.waitOpenViewNames, ViewName.ActivityBeginnerView)
		ActivityController.instance:openActivityBeginnerView(slot1)
	elseif slot3 == JumpEnum.ActIdEnum.Act107 then
		table.insert(slot0.waitOpenViewNames, ViewName.VersionActivityEnterView)
		table.insert(slot0.waitOpenViewNames, ViewName.VersionActivityStoreView)
		VersionActivityController.instance:openVersionActivityEnterViewIfNotOpened(function ()
			VersionActivityController.instance:openLeiMiTeBeiStoreView()
		end)
	elseif slot3 == JumpEnum.ActIdEnum.Act108 then
		table.insert(slot0.waitOpenViewNames, ViewName.VersionActivityEnterView)
		table.insert(slot0.waitOpenViewNames, ViewName.MeilanniMainView)
		VersionActivityController.instance:openVersionActivityEnterViewIfNotOpened(function ()
			MeilanniController.instance:openMeilanniMainView({
				checkStory = true
			})
		end)
	elseif slot3 == JumpEnum.ActIdEnum.Act109 then
		table.insert(slot0.waitOpenViewNames, ViewName.VersionActivityEnterView)
		table.insert(slot0.waitOpenViewNames, ViewName.Activity109ChessEntry)
		VersionActivityController.instance:openVersionActivityEnterViewIfNotOpened(function ()
			Activity109ChessController.instance:openEntry(VersionActivityEnum.ActivityId.Act109)
		end)
	elseif slot3 == JumpEnum.ActIdEnum.Act111 then
		table.insert(slot0.waitOpenViewNames, ViewName.VersionActivityPushBoxLevelView)
		PushBoxController.instance:enterPushBoxGame()
	elseif slot3 == JumpEnum.ActIdEnum.Act112 then
		table.insert(slot0.waitOpenViewNames, ViewName.VersionActivityEnterView)
		table.insert(slot0.waitOpenViewNames, ViewName.VersionActivityExchangeView)
		VersionActivityController.instance:openVersionActivityEnterViewIfNotOpened(function ()
			ViewMgr.instance:openView(ViewName.VersionActivityExchangeView)
		end)
	elseif slot3 == JumpEnum.ActIdEnum.Act113 then
		table.insert(slot0.waitOpenViewNames, ViewName.VersionActivityEnterView)
		VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
			if #uv0 >= 3 then
				if uv0[3] == JumpEnum.LeiMiTeBeiSubJumpId.DungeonStoryMode then
					table.insert(uv1.waitOpenViewNames, ViewName.VersionActivityDungeonMapView)
					VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(VersionActivityEnum.DungeonChapterId.LeiMiTeBei)
				elseif slot0 == JumpEnum.LeiMiTeBeiSubJumpId.DungeonHardMode then
					table.insert(uv1.waitOpenViewNames, ViewName.VersionActivityDungeonMapView)

					if not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(JumpEnum.ActIdEnum.Act113) then
						VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(VersionActivityEnum.DungeonChapterId.LeiMiTeBei)
					else
						VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(VersionActivityEnum.DungeonChapterId.LeiMiTeBeiHard)
					end
				elseif slot0 == JumpEnum.LeiMiTeBeiSubJumpId.LeiMiTeBeiStore then
					table.insert(uv1.waitOpenViewNames, ViewName.ReactivityStoreView)
					ReactivityController.instance:openReactivityStoreView(uv2)
				else
					logWarn("not support subJumpId : " .. uv3)
				end
			else
				table.insert(uv1.waitOpenViewNames, ViewName.VersionActivityDungeonMapView)
				VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(VersionActivityEnum.DungeonChapterId.LeiMiTeBei)
			end
		end, nil, slot3)
	elseif slot3 == ActivityEnum.Activity.Work_SignView_1_8 or slot3 == ActivityEnum.Activity.V2a0_SummerSign or slot3 == ActivityEnum.Activity.V2a1_MoonFestival or slot3 == ActivityEnum.Activity.V2a2_RedLeafFestival_PanelView or slot3 == VersionActivity2_2Enum.ActivityId.LimitDecorate or slot3 == ActivityEnum.Activity.V2a2_TurnBack_H5 or slot3 == ActivityEnum.Activity.V2a2_SummonCustomPickNew or slot3 == ActivityEnum.Activity.V2a3_NewCultivationGift then
		if ActivityHelper.getActivityStatus(slot3, true) ~= ActivityEnum.ActivityStatus.Normal then
			return JumpEnum.JumpResult.Fail
		end

		table.insert(slot0.waitOpenViewNames, ViewName.ActivityBeginnerView)
		ActivityModel.instance:setTargetActivityCategoryId(slot3)
		ActivityController.instance:openActivityBeginnerView()
	elseif slot3 == ActivityEnum.Activity.VersionActivity1_3Radio or slot3 == ActivityEnum.Activity.Activity1_9WarmUp or slot3 == ActivityEnum.Activity.V2a0_WarmUp or slot3 == ActivityEnum.Activity.V2a1_WarmUp or slot3 == ActivityEnum.Activity.V2a2_WarmUp or slot3 == ActivityEnum.Activity.V2a3_WarmUp then
		if ActivityHelper.getActivityStatus(slot3, true) ~= ActivityEnum.ActivityStatus.Normal then
			return JumpEnum.JumpResult.Fail
		end

		table.insert(slot0.waitOpenViewNames, ViewName.ActivityBeginnerView)
		Activity125Model.instance:setSelectEpisodeId(slot3, 1)
		ActivityModel.instance:setTargetActivityCategoryId(slot3)
		ActivityController.instance:openActivityBeginnerView()
	else
		logWarn("not support actId : " .. slot1)
	end

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToLeiMiTeBeiDungeonView(slot0, slot1)
	if not DungeonConfig.instance:getEpisodeCO(string.splitToNumber(slot1, "#")[2]) then
		logError("not found episode : " .. slot1)

		return JumpEnum.JumpResult.Fail
	end

	if not DungeonModel.instance:getEpisodeInfo(slot3) then
		GameFacade.showToast(ToastEnum.WarmUpGotoOrder)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivityDungeonMapLevelView)

	if ReactivityModel.instance:isReactivity(VersionActivityEnum.ActivityId.Act113) then
		VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(nil, slot3, function ()
			ViewMgr.instance:openView(ViewName.VersionActivityDungeonMapLevelView, {
				isJump = true,
				episodeId = uv0
			})
		end)
	else
		VersionActivityController.instance:openVersionActivityEnterViewIfNotOpened(function ()
			VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(nil, uv0, function ()
				ViewMgr.instance:openView(ViewName.VersionActivityDungeonMapLevelView, {
					isJump = true,
					episodeId = uv0
				})
			end)
		end)
	end

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToPushBox(slot0, slot1)
end

function slot0.jumpToAct117(slot0, slot1, slot2)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_2EnterView)
	table.insert(slot0.waitOpenViewNames, ViewName.ActivityTradeBargain)
	VersionActivity1_2EnterController.instance:directOpenVersionActivity1_2EnterView(Activity117Controller.openView, Activity117Controller.instance, slot1)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct114(slot0, slot1, slot2)
	if Activity114Model.instance.serverData.battleEventId > 0 then
		Activity114Controller.instance:enterActivityFight(Activity114Config.instance:getEventCoById(Activity114Model.instance.id, Activity114Model.instance.serverData.battleEventId).config.battleId)
	else
		table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_2EnterView)
		table.insert(slot0.waitOpenViewNames, ViewName.Activity114View)
		VersionActivity1_2EnterController.instance:directOpenVersionActivity1_2EnterView(function ()
			slot0 = nil

			if Activity114Model.instance.serverData.isEnterSchool then
				slot0 = {
					defaultTabIds = {
						[2] = Activity114Enum.TabIndex.MainView
					}
				}
			end

			ViewMgr.instance:openView(ViewName.Activity114View, slot0)
		end)
	end

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct119(slot0, slot1, slot2)
	if slot1 == VersionActivity1_3Enum.ActivityId.Act307 then
		table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_3EnterView)
		table.insert(slot0.waitOpenViewNames, ViewName.Activity1_3_119View)
		VersionActivity1_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
			Activity1_3_119Controller.instance:openView()
		end)

		return JumpEnum.JumpResult.Success
	else
		table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_2EnterView)
		table.insert(slot0.waitOpenViewNames, ViewName.Activity119View)
		VersionActivity1_2EnterController.instance:directOpenVersionActivity1_2EnterView(function ()
			Activity119Controller.instance:openAct119View()
		end)

		return JumpEnum.JumpResult.Success
	end
end

function slot0.jumpToAct1_2Shop(slot0)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_2StoreView)
	ViewMgr.instance:openView(ViewName.VersionActivity1_2StoreView)

	return JumpEnum.JumpResult.Success
end

function slot0.ensureActStoryDone(slot0, slot1, slot2, slot3)
	slot4 = {}

	for slot8, slot9 in ipairs(slot1) do
		if not VersionActivityBaseController.instance:isPlayedActivityVideo(slot9) and ActivityConfig.instance:getActivityCo(slot9).storyId > 0 then
			table.insert(slot4, slot11)
		end
	end

	if #slot4 > 0 then
		StoryController.instance:playStories(slot4, nil, slot2, slot3)
	else
		slot2(slot3)
	end
end

function slot0.jumpToAct1_2Dungeon(slot0, slot1, slot2)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_7EnterView)
	VersionActivity1_7EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		table.insert(uv0.waitOpenViewNames, ViewName.VersionActivity1_2DungeonView)

		if #uv1 >= 3 then
			if uv1[3] == JumpEnum.Activity1_2DungeonJump.Shop then
				table.insert(uv0.waitOpenViewNames, ViewName.ReactivityStoreView)
				VersionActivity1_2DungeonController.instance:openDungeonView(nil, , , , slot0)
			elseif slot0 == JumpEnum.Activity1_2DungeonJump.Normal then
				VersionActivity1_2DungeonController.instance:openDungeonView()
			elseif slot0 == JumpEnum.Activity1_2DungeonJump.Hard then
				VersionActivity1_2DungeonController.instance:openDungeonView(VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonHard)
			elseif slot0 == JumpEnum.Activity1_2DungeonJump.Task then
				table.insert(uv0.waitOpenViewNames, ViewName.ReactivityTaskView)
				VersionActivity1_2DungeonController.instance:openDungeonView(nil, , , , slot0)
			elseif slot0 == JumpEnum.Activity1_2DungeonJump.Jump2Dungeon then
				VersionActivity1_2DungeonController.instance:openDungeonView(nil, uv1[4], true)
			elseif slot0 == JumpEnum.Activity1_2DungeonJump.Jump2Camp then
				VersionActivity1_2DungeonController.instance:openDungeonView(nil, , , true)
			end
		else
			VersionActivity1_2DungeonController.instance:openDungeonView()
		end
	end)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToEnterView1_2(slot0, slot1, slot2)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_2EnterView)
	VersionActivity1_2EnterController.instance:openVersionActivity1_2EnterView()

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToYaXianView(slot0, slot1, slot2)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_2EnterView)
	table.insert(slot0.waitOpenViewNames, ViewName.YaXianMapView)
	slot0:ensureActStoryDone({
		JumpEnum.ActIdEnum.EnterView1_2,
		slot1
	}, function ()
		VersionActivity1_2EnterController.instance:directOpenVersionActivity1_2EnterView()
		YaXianController.instance:openYaXianMapView()
	end)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToEnterView1_3(slot0, slot1, slot2)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_3EnterView)
	VersionActivity1_3EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct1_3Shop(slot0, slot1, slot2)
	table.insert(slot0.waitOpenViewNames, ViewName.ReactivityStoreView)
	ReactivityController.instance:openReactivityStoreView(VersionActivity1_3Enum.ActivityId.Dungeon)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct1_3Dungeon(slot0, slot1, slot2)
	table.insert(slot0.closeViewNames, ViewName.VersionActivity1_3DungeonMapLevelView)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_3EnterView)
	VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		if #uv0 >= 3 then
			if uv0[3] == JumpEnum.Activity1_3DungeonJump.Normal then
				table.insert(uv1.closeViewNames, ViewName.VersionActivity1_3BuffView)
				table.insert(uv1.waitOpenViewNames, ViewName.VersionActivity1_3DungeonMapView)
				VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei)
			elseif slot0 == JumpEnum.Activity1_3DungeonJump.Hard then
				table.insert(uv1.waitOpenViewNames, ViewName.VersionActivity1_3DungeonMapView)
				table.insert(uv1.closeViewNames, ViewName.VersionActivity1_3BuffView)

				if not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(JumpEnum.ActIdEnum.Act1_3Dungeon) then
					VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei)
				else
					VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBeiHard)
				end
			elseif slot0 == JumpEnum.Activity1_3DungeonJump.Daily then
				table.insert(uv1.closeViewNames, ViewName.VersionActivity1_3AstrologyView)
				table.insert(uv1.closeViewNames, ViewName.VersionActivity1_3BuffView)
				table.insert(uv1.waitOpenViewNames, ViewName.VersionActivity1_3DungeonMapView)
				VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei, VersionActivity1_3DungeonEnum.DailyEpisodeId, nil, , {
					showDaily = true
				})
			elseif slot0 == JumpEnum.Activity1_3DungeonJump.Astrology then
				table.insert(uv1.waitOpenViewNames, ViewName.VersionActivity1_3DungeonMapView)
				table.insert(uv1.waitOpenViewNames, ViewName.VersionActivity1_3AstrologyView)
				table.insert(uv1.closeViewNames, ViewName.VersionActivity1_3BuffView)

				if ViewMgr.instance:isOpen(ViewName.VersionActivity1_3DungeonMapView) then
					VersionActivity1_3AstrologyController.instance:openVersionActivity1_3AstrologyView()
				else
					VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei, nil, function ()
						VersionActivity1_3AstrologyController.instance:openVersionActivity1_3AstrologyView()
					end)
				end
			elseif slot0 == JumpEnum.Activity1_3DungeonJump.Buff then
				table.insert(uv1.waitOpenViewNames, ViewName.VersionActivity1_3DungeonMapView)
				table.insert(uv1.waitOpenViewNames, ViewName.VersionActivity1_3BuffView)

				if ViewMgr.instance:isOpen(ViewName.VersionActivity1_3DungeonMapView) then
					VersionActivity1_3BuffController.instance:openBuffView()
				else
					VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei, nil, function ()
						VersionActivity1_3BuffController.instance:openBuffView()
					end)
				end
			else
				logWarn("not support subJumpId:" .. tostring(slot0))

				return JumpEnum.JumpResult.Fail
			end
		else
			table.insert(uv1.waitOpenViewNames, ViewName.VersionActivity1_3DungeonMapView)
			VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei)
		end
	end, nil, VersionActivity1_3Enum.ActivityId.Dungeon)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct1_3DungeonView(slot0, slot1)
	if not DungeonConfig.instance:getEpisodeCO(string.splitToNumber(slot1, "#")[2]) then
		logError("not found episode : " .. slot1)

		return JumpEnum.JumpResult.Fail
	end

	if not DungeonModel.instance:getEpisodeInfo(slot3) then
		GameFacade.showToast(ToastEnum.WarmUpGotoOrder)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_3DungeonMapLevelView)
	VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(nil, uv0, function ()
			ViewMgr.instance:openView(ViewName.VersionActivity1_3DungeonMapLevelView, {
				isJump = true,
				episodeId = uv0
			})
		end)
	end, nil, VersionActivity1_3Enum.ActivityId.Dungeon)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct1_3Act304(slot0, slot1, slot2)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_3EnterView)

	if slot2 and #slot2 >= 3 then
		Activity122Model.instance:setCurEpisodeId(#slot2[3])
	end

	VersionActivity1_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		table.insert(uv0.waitOpenViewNames, ViewName.Activity1_3ChessMapView)
		Activity1_3ChessController.instance:openMapView()
	end)
	ViewMgr.instance:closeAllPopupViews({
		ViewName.VersionActivity1_3EnterView,
		ViewName.Activity1_3ChessMapView
	})

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct1_3Act305(slot0, slot1, slot2)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_3EnterView)
	VersionActivity1_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		table.insert(uv0.waitOpenViewNames, ViewName.ArmMainView)
		ArmPuzzlePipeController.instance:openMainView()
	end)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct1_3Act306(slot0, slot1, slot2)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_3EnterView)

	if slot2 and #slot2 >= 3 then
		Activity120Model.instance:getCurEpisodeId(#slot2[3])
	end

	VersionActivity1_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		table.insert(uv0.waitOpenViewNames, ViewName.JiaLaBoNaMapView)
		JiaLaBoNaController.instance:openMapView()
	end)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct1_3Act125(slot0, slot1, slot2)
	if not ActivityModel.instance:isActOnLine(slot1) then
		return JumpEnum.JumpResult.Fail
	end

	table.insert(slot0.waitOpenViewNames, ViewName.ActivityBeginnerView)
	table.insert(slot0.closeViewNames, ViewName.MainThumbnailView)
	ActivityModel.instance:setTargetActivityCategoryId(slot1)
	ActivityController.instance:openActivityBeginnerView(slot2)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToTurnback(slot0, slot1)
	if not TurnbackModel.instance:canShowTurnbackPop() then
		return JumpEnum.JumpResult.Fail
	end

	slot2 = string.splitToNumber(slot1, "#")
	slot3 = {
		turnbackId = tonumber(slot2[2]),
		subModuleId = tonumber(slot2[3])
	}

	table.insert(slot0.waitOpenViewNames, ViewName.TurnbackBeginnerView)
	TurnbackModel.instance:setCurTurnbackId(slot3.turnbackId)
	TurnbackModel.instance:setTargetCategoryId(slot3.subModuleId)
	TurnbackController.instance:openTurnbackBeginnerView(slot3)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToEnterView1_4(slot0, slot1, slot2)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_4EnterView)
	VersionActivity1_4EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct1_4DungeonStore(slot0, slot1, slot2)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_4EnterView)
	VersionActivity1_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		table.insert(uv0.waitOpenViewNames, ViewName.Activity129View)
		ViewMgr.instance:openView(ViewName.Activity129View, {
			actId = uv1
		})
	end)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct1_4Dungeon(slot0, slot1, slot2)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_4EnterView)
	VersionActivity1_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		table.insert(uv0.waitOpenViewNames, ViewName.VersionActivity1_4DungeonView)
		ViewMgr.instance:openView(ViewName.VersionActivity1_4DungeonView, {
			actId = uv1
		})
	end)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct1_4Task(slot0, slot1, slot2)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_4EnterView)
	VersionActivity1_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		table.insert(uv0.waitOpenViewNames, ViewName.VersionActivity1_4TaskView)
		ViewMgr.instance:openView(ViewName.VersionActivity1_4TaskView, {
			activityId = uv1
		})
	end)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct1_4Role37(slot0, slot1, slot2)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_4EnterView)
	VersionActivity1_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		table.insert(uv0.waitOpenViewNames, ViewName.Activity130LevelView)
		Activity130Controller.instance:enterActivity130()
	end)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct1_4Role6(slot0, slot1, slot2)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_4EnterView)
	VersionActivity1_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		table.insert(uv0.waitOpenViewNames, ViewName.Activity131LevelView)
		Activity131Controller.instance:enterActivity131()
	end)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct1_4Role37Game(slot0, slot1)
	slot3 = {
		episodeId = tonumber(string.splitToNumber(slot1, "#")[2])
	}

	if ViewMgr.instance:isOpen(ViewName.Activity130LevelView) then
		if Activity130Model.instance:isEpisodeUnlock(slot3.episodeId) then
			Activity130Controller.instance:dispatchEvent(Activity130Event.EnterEpisode, slot3.episodeId)
		else
			GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

			return JumpEnum.JumpResult.Fail
		end
	else
		Activity130Controller.instance:openActivity130GameView(slot3)
	end

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct1_4Role6Game(slot0, slot1)
	slot3 = {
		episodeId = tonumber(string.splitToNumber(slot1, "#")[2])
	}

	if ViewMgr.instance:isOpen(ViewName.Activity131LevelView) then
		if Activity131Model.instance:isEpisodeUnlock(slot3.episodeId) then
			Activity131Controller.instance:dispatchEvent(Activity131Event.EnterEpisode, slot3.episodeId)
		else
			GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

			return JumpEnum.JumpResult.Fail
		end
	else
		Activity131Controller.instance:openActivity131GameView(slot3)
	end

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAchievement(slot0, slot1)
	if #string.split(slot1, "#") > 1 then
		AchievementJumpController.instance:jumpToAchievement(slot2)

		return JumpEnum.JumpResult.Success
	end

	return JumpEnum.JumpResult.Fail
end

function slot0.jumpToBossRush(slot0, slot1)
	slot2 = string.splitToNumber(slot1, "#")
	slot5 = nil

	if slot2[2] then
		slot5 = {
			isOpenLevelDetail = true,
			stage = slot3,
			layer = slot2[3]
		}
	end

	BossRushController.instance:openMainView(slot5)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct1_5EnterView(slot0, slot1, slot2)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_5EnterView)
	VersionActivity1_5EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct1_5Dungeon(slot0, slot1, slot2)
	table.insert(slot0.closeViewNames, ViewName.VersionActivity1_5DungeonMapLevelView)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity2_0EnterView)
	VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		if #uv0 >= 3 then
			if uv0[3] == JumpEnum.Activity1_3DungeonJump.Normal then
				table.insert(uv1.waitOpenViewNames, ViewName.VersionActivity1_5DungeonMapView)
				VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_5DungeonEnum.DungeonChapterId.Story)
			elseif slot0 == JumpEnum.Activity1_3DungeonJump.Hard then
				table.insert(uv1.waitOpenViewNames, ViewName.VersionActivity1_5DungeonMapView)

				if not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(JumpEnum.ActIdEnum.Act1_5Dungeon) then
					VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_5DungeonEnum.DungeonChapterId.Story)
				else
					VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_5DungeonEnum.DungeonChapterId.Hard)
				end
			else
				logWarn("not support subJumpId:" .. tostring(slot0))

				return JumpEnum.JumpResult.Fail
			end
		else
			table.insert(uv1.waitOpenViewNames, ViewName.VersionActivity1_5DungeonMapView)
			VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_5DungeonEnum.DungeonChapterId.Story)
		end
	end)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct1_5DungeonStore(slot0, slot1, slot2)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity2_0EnterView)
	VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		table.insert(uv0.waitOpenViewNames, ViewName.ReactivityStoreView)
		ReactivityController.instance:openReactivityStoreView(JumpEnum.ActIdEnum.Act1_5Dungeon)
	end)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct1_5PeaceUluGame(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_5EnterView)
	VersionActivity1_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		table.insert(uv0.waitOpenViewNames, ViewName.PeaceUluView)
		PeaceUluController.instance:openPeaceUluView(uv1)
	end)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct1_5SportNews(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_5EnterView)
	VersionActivity1_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		table.insert(uv0.waitOpenViewNames, ViewName.SportsNewsView)
		SportsNewsController.instance:openSportsNewsMainView(uv1)
	end)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct1_5DungeonView(slot0, slot1)
	if not DungeonConfig.instance:getEpisodeCO(string.splitToNumber(slot1, "#")[2]) then
		logError("not found episode : " .. slot1)

		return JumpEnum.JumpResult.Fail
	end

	if not DungeonModel.instance:getEpisodeInfo(slot3) then
		GameFacade.showToast(ToastEnum.WarmUpGotoOrder)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_5DungeonMapLevelView)
	VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView(nil, uv0, function ()
			ViewMgr.instance:openView(ViewName.VersionActivity1_5DungeonMapLevelView, {
				isJump = true,
				episodeId = uv0
			})
		end)
	end)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToActivity142(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_5EnterView)
	VersionActivity1_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		table.insert(uv0.waitOpenViewNames, ViewName.Activity142MapView)
		Activity142Controller.instance:openMapView()
	end)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct1_5AiZiLa(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_5EnterView)
	table.insert(slot0.waitOpenViewNames, ViewName.AiZiLaMapView)
	AiZiLaController.instance:openMapView()

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct1_6EnterView(slot0, slot1, slot2)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_6EnterView)

	slot3 = nil

	if #slot2 >= 3 then
		slot3 = slot2[3]
	end

	VersionActivity1_6EnterController.instance:openVersionActivityEnterView(nil, , slot3, true)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct1_6Dungeon(slot0, slot1, slot2)
	table.insert(slot0.closeViewNames, ViewName.VersionActivity1_6DungeonMapLevelView)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_6EnterView)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		if #uv0 >= 3 then
			if uv0[3] == JumpEnum.Activity1_3DungeonJump.Normal then
				table.insert(uv1.waitOpenViewNames, ViewName.VersionActivity1_6DungeonMapView)
				VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_6DungeonEnum.DungeonChapterId.Story)
			elseif slot0 == JumpEnum.Activity1_3DungeonJump.Hard then
				table.insert(uv1.waitOpenViewNames, ViewName.VersionActivity1_6DungeonMapView)

				if not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(JumpEnum.ActIdEnum.Act1_6Dungeon) then
					VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_6DungeonEnum.DungeonChapterId.Story)
				else
					VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_6DungeonEnum.DungeonChapterId.Hard)
				end
			else
				logWarn("not support subJumpId:" .. tostring(slot0))

				return JumpEnum.JumpResult.Fail
			end
		else
			table.insert(uv1.waitOpenViewNames, ViewName.VersionActivity1_6DungeonMapView)
			VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_6DungeonEnum.DungeonChapterId.Story)
		end
	end)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct1_6DungeonView(slot0, slot1)
	if not DungeonConfig.instance:getEpisodeCO(string.splitToNumber(slot1, "#")[2]) then
		logError("not found episode : " .. slot1)

		return JumpEnum.JumpResult.Fail
	end

	if not DungeonModel.instance:getEpisodeInfo(slot3) then
		GameFacade.showToast(ToastEnum.WarmUpGotoOrder)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_6DungeonMapLevelView)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(nil, uv0, function ()
			ViewMgr.instance:openView(ViewName.VersionActivity1_6DungeonMapLevelView, {
				isJump = true,
				episodeId = uv0
			})
		end)
	end)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct1_6DungeonStore(slot0, slot1, slot2)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_6EnterView)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		table.insert(uv0.waitOpenViewNames, ViewName.VersionActivity1_6StoreView)
		VersionActivity1_6EnterController.instance:openStoreView()
	end)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct1_6DungeonBoss(slot0, slot1, slot2)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_6EnterView)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView()
		VersionActivity1_6DungeonController.instance:openDungeonBossView()
	end)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct1_6Rogue(slot0, slot1, slot2)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_6EnterView)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, , slot1, false)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct1_6QuNiang(slot0, slot1, slot2)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_6EnterView)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		table.insert(uv0.waitOpenViewNames, ViewName.ActQuNiangLevelView)
		ActQuNiangController.instance:enterActivity()
	end, nil, slot1, false)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToAct1_6GeTian(slot0, slot1, slot2)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_6EnterView)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		table.insert(uv0.waitOpenViewNames, ViewName.ActGeTianLevelView)
		ActGeTianController.instance:enterActivity()
	end, nil, slot1, false)

	return JumpEnum.JumpResult.Fail
end

function slot0.jumpToAct1_9WarmUp(slot0, slot1, slot2)
	table.insert(slot0.waitOpenViewNames, ViewName.ActivityBeginnerView)

	slot3 = slot1

	ActivityModel.instance:setTargetActivityCategoryId(slot3)
	Activity125Model.instance:setSelectEpisodeId(slot3, 1)
	ActivityController.instance:openActivityBeginnerView(slot1)
end

function slot0.jumpToVersionEnterView(slot0, slot1)
	if not string.splitToNumber(slot1, "#")[2] then
		return JumpEnum.JumpResult.Fail
	end

	if not ActivityHelper.getActivityVersion(slot3) then
		return JumpEnum.JumpResult.Fail
	end

	if _G[string.format("VersionActivity%sEnterController", slot4)] then
		slot6.instance:openVersionActivityEnterView(nil, , slot3)

		return JumpEnum.JumpResult.Success
	end

	return JumpEnum.JumpResult.Fail
end

function slot0.jumpToRougeMainView(slot0, slot1)
	RougeController.instance:openRougeMainView()

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToRougeRewardView(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.RougeMainView)
	table.insert(slot0.waitOpenViewNames, ViewName.RougeRewardView)

	slot2 = string.splitToNumber(slot1, "#")
	slot3 = slot2[2]
	slot4 = slot2[3]

	RougeController.instance:openRougeMainView(nil, , function ()
		ViewMgr.instance:openView(ViewName.RougeRewardView, {
			version = uv0,
			stage = uv1
		})
	end)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToSeason123(slot0, slot1)
	slot4 = string.format("VersionActivity%sEnterController", Activity123Enum.SeasonVersionPrefix[Season123Model.instance:getCurSeasonId()])

	if #string.splitToNumber(slot1, "#") > 1 and slot3[2] == Activity123Enum.JumpType.Stage and #slot3 > 2 then
		_G[slot4].instance:openVersionActivityEnterView(Season123Controller.openSeasonEntryByJump, {
			actId = slot2,
			jumpId = Activity123Enum.JumpId.ForStage,
			jumpParam = {
				stage = slot3[3]
			}
		}, slot2)

		return JumpEnum.JumpResult.Success
	end

	_G[slot4].instance:openVersionActivityEnterView(Season123Controller.openSeasonEntry, Season123Controller.instance, slot2)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToPermanentMainView(slot0, slot1)
	DungeonModel.instance:changeCategory(DungeonEnum.ChapterType.PermanentActivity)
	table.insert(slot0.waitOpenViewNames, ViewName.DungeonView)
	DungeonController.instance:openDungeonView()

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToInvestigateView(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.InvestigateView)
	table.insert(slot0.closeViewNames, ViewName.InvestigateTaskView)
	InvestigateController.instance:openInvestigateView()

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToInvestigateOpinionTabView(slot0, slot1)
	if not (lua_investigate_info.configDict[string.splitToNumber(slot1, "#")[2]].episode == 0 or DungeonModel.instance:hasPassLevel(slot4.episode)) then
		GameFacade.showToast(ToastEnum.InvestigateTip1)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(slot0.waitOpenViewNames, ViewName.InvestigateOpinionTabView)
	InvestigateController.instance:jumpToInvestigateOpinionTabView(slot3)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpToTowerView(slot0, slot1)
	slot2 = string.splitToNumber(slot1, "#")

	TowerController.instance:jumpView({
		towerType = slot2[2],
		towerId = slot2[3]
	})

	return JumpEnum.JumpResult.Success
end

slot0.JumpViewToHandleFunc = {
	[JumpEnum.JumpView.StoreView] = slot0.jumpToStoreView,
	[JumpEnum.JumpView.SummonView] = slot0.jumpToSummonView,
	[JumpEnum.JumpView.SummonViewGroup] = slot0.jumpToSummonViewGroup,
	[JumpEnum.JumpView.DungeonViewWithChapter] = slot0.jumpToDungeonViewWithChapter,
	[JumpEnum.JumpView.DungeonViewWithEpisode] = slot0.jumpToDungeonViewWithEpisode,
	[JumpEnum.JumpView.DungeonViewWithType] = slot0.jumpToDungeonViewWithType,
	[JumpEnum.JumpView.CharacterBackpackViewWithCharacter] = slot0.jumpToCharacterBackpackViewWithCharacter,
	[JumpEnum.JumpView.CharacterBackpackViewWithEquip] = slot0.jumpToCharacterBackpackViewWithEquip,
	[JumpEnum.JumpView.HeroGroupView] = slot0.jumpToHeroGroupView,
	[JumpEnum.JumpView.BackpackView] = slot0.jumpToBackpackView,
	[JumpEnum.JumpView.PlayerClothView] = slot0.jumpToPlayerClothView,
	[JumpEnum.JumpView.MainView] = slot0.jumpToMainView,
	[JumpEnum.JumpView.TaskView] = slot0.jumpToTaskView,
	[JumpEnum.JumpView.RoomView] = slot0.jumpToRoomView,
	[JumpEnum.JumpView.RoomProductLineView] = slot0.jumpToRoomProductLineView,
	[JumpEnum.JumpView.TeachNoteView] = slot0.jumpToTeachNoteView,
	[JumpEnum.JumpView.EquipView] = slot0.jumpToEquipView,
	[JumpEnum.JumpView.HandbookView] = slot0.jumpToHandbookView,
	[JumpEnum.JumpView.SocialView] = slot0.jumpToSocialView,
	[JumpEnum.JumpView.NoticeView] = slot0.jumpToNoticeView,
	[JumpEnum.JumpView.SignInView] = slot0.jumpToSignInView,
	[JumpEnum.JumpView.MailView] = slot0.jumpToMailView,
	[JumpEnum.JumpView.SignInViewWithBirthDay] = slot0.jumpToSignInViewWithBirthDay,
	[JumpEnum.JumpView.SeasonMainView] = slot0.jumpToSeasonMainView,
	[JumpEnum.JumpView.Show] = slot0.jumpToShow,
	[JumpEnum.JumpView.BpView] = slot0.jumpToBpView,
	[JumpEnum.JumpView.ActivityView] = slot0.jumpToActivityView,
	[JumpEnum.JumpView.LeiMiTeBeiDungeonView] = slot0.jumpToLeiMiTeBeiDungeonView,
	[JumpEnum.JumpView.Act1_3DungeonView] = slot0.jumpToAct1_3DungeonView,
	[JumpEnum.JumpView.PushBox] = slot0.jumpToPushBox,
	[JumpEnum.JumpView.Turnback] = slot0.jumpToTurnback,
	[JumpEnum.JumpView.Role37Game] = slot0.jumpToAct1_4Role37Game,
	[JumpEnum.JumpView.Role6Game] = slot0.jumpToAct1_4Role6Game,
	[JumpEnum.JumpView.Achievement] = slot0.jumpToAchievement,
	[JumpEnum.JumpView.RoleStoryActivity] = slot0.jumpToRoleStoryActivity,
	[JumpEnum.JumpView.BossRush] = slot0.jumpToBossRush,
	[JumpEnum.JumpView.Tower] = slot0.jumpToTowerView,
	[JumpEnum.JumpView.V1a5Dungeon] = slot0.jumpToAct1_5DungeonView,
	[JumpEnum.JumpView.V1a6Dungeon] = slot0.jumpToAct1_6DungeonView,
	[JumpEnum.JumpView.Season123] = slot0.jumpToSeason123,
	[JumpEnum.JumpView.VersionEnterView] = slot0.jumpToVersionEnterView,
	[JumpEnum.JumpView.RougeMainView] = slot0.jumpToRougeMainView,
	[JumpEnum.JumpView.RougeRewardView] = slot0.jumpToRougeRewardView,
	[JumpEnum.JumpView.PermanentMainView] = slot0.jumpToPermanentMainView,
	[JumpEnum.JumpView.InvestigateView] = slot0.jumpToInvestigateView,
	[JumpEnum.JumpView.InvestigateOpinionTabView] = slot0.jumpToInvestigateOpinionTabView
}
slot0.JumpActViewToHandleFunc = {
	[JumpEnum.ActIdEnum.Act117] = slot0.jumpToAct117,
	[JumpEnum.ActIdEnum.Act114] = slot0.jumpToAct114,
	[JumpEnum.ActIdEnum.Act119] = slot0.jumpToAct119,
	[JumpEnum.ActIdEnum.Act1_2Dungeon] = slot0.jumpToAct1_2Dungeon,
	[JumpEnum.ActIdEnum.Act1_2Shop] = slot0.jumpToAct1_2Shop,
	[JumpEnum.ActIdEnum.EnterView1_2] = slot0.jumpToEnterView1_2,
	[JumpEnum.ActIdEnum.YaXian] = slot0.jumpToYaXianView,
	[JumpEnum.ActIdEnum.EnterView1_3] = slot0.jumpToEnterView1_3,
	[JumpEnum.ActIdEnum.Act1_3Dungeon] = slot0.jumpToAct1_3Dungeon,
	[JumpEnum.ActIdEnum.Act1_3Shop] = slot0.jumpToAct1_3Shop,
	[JumpEnum.ActIdEnum.Act1_3Act304] = slot0.jumpToAct1_3Act304,
	[JumpEnum.ActIdEnum.Act1_3Act305] = slot0.jumpToAct1_3Act305,
	[JumpEnum.ActIdEnum.Act1_3Act306] = slot0.jumpToAct1_3Act306,
	[JumpEnum.ActIdEnum.Act1_3Act307] = slot0.jumpToAct119,
	[JumpEnum.ActIdEnum.Act1_3Act125] = slot0.jumpToAct1_3Act125,
	[JumpEnum.ActIdEnum.EnterView1_4] = slot0.jumpToEnterView1_4,
	[JumpEnum.ActIdEnum.Act1_4DungeonStore] = slot0.jumpToAct1_4DungeonStore,
	[JumpEnum.ActIdEnum.Act1_4Dungeon] = slot0.jumpToAct1_4Dungeon,
	[JumpEnum.ActIdEnum.Act1_4Task] = slot0.jumpToAct1_4Task,
	[JumpEnum.ActIdEnum.Role37] = slot0.jumpToAct1_4Role37,
	[JumpEnum.ActIdEnum.Role6] = slot0.jumpToAct1_4Role6,
	[JumpEnum.ActIdEnum.EnterView1_5] = slot0.jumpToAct1_5EnterView,
	[JumpEnum.ActIdEnum.Act1_5Dungeon] = slot0.jumpToAct1_5Dungeon,
	[JumpEnum.ActIdEnum.Act1_5Shop] = slot0.jumpToAct1_5DungeonStore,
	[JumpEnum.ActIdEnum.Act1_5PeaceUlu] = slot0.jumpToAct1_5PeaceUluGame,
	[JumpEnum.ActIdEnum.Act1_5SportNews] = slot0.jumpToAct1_5SportNews,
	[JumpEnum.ActIdEnum.Activity142] = slot0.jumpToActivity142,
	[JumpEnum.ActIdEnum.Act1_5AiZiLa] = slot0.jumpToAct1_5AiZiLa,
	[JumpEnum.ActIdEnum.Act1_6EnterView] = slot0.jumpToAct1_6EnterView,
	[JumpEnum.ActIdEnum.Act1_6Dungeon] = slot0.jumpToAct1_6Dungeon,
	[JumpEnum.ActIdEnum.Act1_6DungeonStore] = slot0.jumpToAct1_6DungeonStore,
	[JumpEnum.ActIdEnum.Act1_6DungeonBossRush] = slot0.jumpToAct1_6DungeonBoss,
	[JumpEnum.ActIdEnum.Act1_6Rougue] = slot0.jumpToAct1_6Rogue,
	[JumpEnum.ActIdEnum.Act1_6QuNiang] = slot0.jumpToAct1_6QuNiang,
	[JumpEnum.ActIdEnum.Act1_6GeTian] = slot0.jumpToAct1_6GeTian,
	[JumpEnum.ActIdEnum.Act1_9WarmUp] = slot0.jumpToAct1_9WarmUp
}

return slot0
