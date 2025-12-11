module("modules.logic.jump.controller.JumpControllerHandleFunc", package.seeall)

local var_0_0 = JumpController

function var_0_0.V2a4_WuErLiXi(arg_1_0, arg_1_1, arg_1_2)
	VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		WuErLiXiController.instance:enterLevelView()
	end, nil, arg_1_1)

	return JumpEnum.JumpResult.Success
end

function var_0_0.V3a0_Reactivity(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = VersionActivity3_0EnterController.instance
	local var_3_1 = VersionActivity2_3DungeonController.instance
	local var_3_2 = arg_3_2[3]

	table.insert(arg_3_0.waitOpenViewNames, ViewName.VersionActivity3_0EnterView)
	table.insert(arg_3_0.closeViewNames, ViewName.VersionActivity2_3DungeonMapLevelView)
	VersionActivity2_3DungeonModel.instance:setMapNeedTweenState(true)

	if var_3_2 then
		VersionActivity3_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			var_3_1:openVersionActivityDungeonMapView(nil, var_3_2, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_3DungeonMapLevelView, {
					isJump = true,
					episodeId = var_3_2
				})
			end)
		end, nil, arg_3_1, true)
	else
		var_3_0:openVersionActivityEnterViewIfNotOpened(var_3_1.openVersionActivityDungeonMapView, var_3_1, arg_3_1, true)
	end

	return JumpEnum.JumpResult.Success
end

var_0_0.DefaultToastId = 0

function var_0_0.activateHandleFuncController()
	return
end

function var_0_0.defaultHandleFunc(arg_7_0, arg_7_1)
	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToRoleStoryActivity(arg_8_0, arg_8_1)
	local var_8_0 = string.splitToNumber(arg_8_1, "#")
	local var_8_1 = ViewName.RoleStoryDispatchMainView

	table.insert(arg_8_0.waitOpenViewNames, var_8_1)

	if RoleStoryController.instance:openRoleStoryDispatchMainView(var_8_0) then
		return JumpEnum.JumpResult.Success
	end

	tabletool.removeValue(arg_8_0.waitOpenViewNames, var_8_1)

	return JumpEnum.JumpResult.Fail
end

function var_0_0.jumpToStoreView(arg_9_0, arg_9_1)
	local var_9_0 = string.splitToNumber(arg_9_1, "#")

	table.insert(arg_9_0.waitOpenViewNames, ViewName.StoreView)
	table.insert(arg_9_0.closeViewNames, ViewName.NormalStoreGoodsView)
	table.insert(arg_9_0.closeViewNames, ViewName.ChargeStoreGoodsView)
	table.insert(arg_9_0.remainViewNames, ViewName.StoreView)

	if ViewMgr.instance:isOpen(ViewName.DungeonView) and DungeonModel.instance.curChapterType == DungeonEnum.ChapterType.WeekWalk then
		table.insert(arg_9_0.remainViewNames, ViewName.DungeonView)
	end

	if #var_9_0 >= 2 then
		local var_9_1 = var_9_0[2]
		local var_9_2 = var_9_0[3]
		local var_9_3 = var_9_0[4]

		if (var_9_1 == StoreEnum.StoreId.Package or var_9_1 == StoreEnum.StoreId.RecommendPackage or var_9_1 == StoreEnum.StoreId.NormalPackage or var_9_1 == StoreEnum.StoreId.OneTimePackage or var_9_1 == StoreEnum.StoreId.VersionPackage or var_9_1 == StoreEnum.StoreId.MediciPackage) and var_9_2 then
			table.insert(arg_9_0.remainViewNames, ViewName.PackageStoreGoodsView)
		end

		if (var_9_1 == StoreEnum.StoreId.NewDecorateStore or var_9_1 == StoreEnum.StoreId.OldDecorateStore) and var_9_2 then
			table.insert(arg_9_0.remainViewNames, ViewName.DecorateStoreGoodsView)
		end

		StoreController.instance:openStoreView(var_9_1, var_9_2, var_9_3)
	else
		StoreController.instance:openStoreView()
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToSummonView(arg_10_0, arg_10_1)
	local var_10_0 = string.splitToNumber(arg_10_1, "#")

	table.insert(arg_10_0.remainViewNames, ViewName.SummonADView)
	table.insert(arg_10_0.remainViewNames, ViewName.SummonView)

	if #var_10_0 >= 2 then
		local var_10_1 = var_10_0[2]

		SummonController.instance:jumpSummon(var_10_1)
	else
		SummonController.instance:jumpSummon()
	end

	ViewMgr.instance:closeAllPopupViews({
		ViewName.SummonADView,
		ViewName.SummonView
	})

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToSummonViewGroup(arg_11_0, arg_11_1)
	local var_11_0 = string.splitToNumber(arg_11_1, "#")

	table.insert(arg_11_0.remainViewNames, ViewName.SummonADView)
	table.insert(arg_11_0.remainViewNames, ViewName.SummonView)

	if #var_11_0 >= 2 then
		local var_11_1 = var_11_0[2]

		SummonController.instance:jumpSummonByGroup(var_11_1)
	else
		SummonController.instance:jumpSummon()
	end

	ViewMgr.instance:closeAllPopupViews({
		ViewName.SummonADView,
		ViewName.SummonView
	})

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToDungeonViewWithChapter(arg_12_0, arg_12_1)
	local var_12_0 = string.splitToNumber(arg_12_1, "#")

	table.insert(arg_12_0.waitOpenViewNames, ViewName.DungeonMapView)
	table.insert(arg_12_0.closeViewNames, ViewName.HeroInvitationView)
	table.insert(arg_12_0.closeViewNames, ViewName.HeroInvitationDungeonMapView)
	table.insert(arg_12_0.closeViewNames, ViewName.DungeonMapView)
	table.insert(arg_12_0.closeViewNames, ViewName.DungeonMapLevelView)
	table.insert(arg_12_0.closeViewNames, ViewName.VersionActivity1_5DungeonMapView)
	table.insert(arg_12_0.closeViewNames, ViewName.VersionActivity1_5DungeonMapLevelView)
	table.insert(arg_12_0.closeViewNames, ViewName.WeekWalkView)
	table.insert(arg_12_0.closeViewNames, ViewName.WeekWalkCharacterView)
	table.insert(arg_12_0.closeViewNames, ViewName.WeekWalkLayerView)
	table.insert(arg_12_0.closeViewNames, ViewName.WeekWalkLayerRewardView)
	table.insert(arg_12_0.closeViewNames, ViewName.StoryView)
	table.insert(arg_12_0.closeViewNames, ViewName.DungeonPuzzleChangeColorView)

	local var_12_1 = var_12_0[2]
	local var_12_2 = DungeonConfig.instance:getChapterCO(var_12_1)

	if var_12_2 then
		local var_12_3 = var_12_2.type
		local var_12_4 = {
			chapterType = var_12_3,
			chapterId = var_12_1
		}
		local var_12_5 = DungeonController.instance:jumpDungeon(var_12_4)

		if var_12_5 and #var_12_5 > 0 then
			for iter_12_0, iter_12_1 in ipairs(var_12_5) do
				table.insert(arg_12_0.remainViewNames, iter_12_1)
			end

			table.insert(arg_12_0.remainViewNames, ViewName.DungeonView)
		end

		return JumpEnum.JumpResult.Success
	else
		logError("找不到章节配置, chapterId: " .. tostring(var_12_1))

		return JumpEnum.JumpResult.Fail
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToDungeonViewWithEpisode(arg_13_0, arg_13_1)
	local var_13_0 = string.splitToNumber(arg_13_1, "#")

	table.insert(arg_13_0.waitOpenViewNames, ViewName.DungeonMapView)

	if var_13_0[3] ~= 1 then
		table.insert(arg_13_0.waitOpenViewNames, ViewName.DungeonMapLevelView)
	end

	table.insert(arg_13_0.closeViewNames, ViewName.HeroInvitationView)
	table.insert(arg_13_0.closeViewNames, ViewName.HeroInvitationDungeonMapView)
	table.insert(arg_13_0.closeViewNames, ViewName.DungeonMapView)
	table.insert(arg_13_0.closeViewNames, ViewName.DungeonMapLevelView)
	table.insert(arg_13_0.closeViewNames, ViewName.VersionActivity1_5DungeonMapView)
	table.insert(arg_13_0.closeViewNames, ViewName.VersionActivity1_5DungeonMapLevelView)
	table.insert(arg_13_0.closeViewNames, ViewName.WeekWalkView)
	table.insert(arg_13_0.closeViewNames, ViewName.WeekWalkCharacterView)
	table.insert(arg_13_0.closeViewNames, ViewName.WeekWalkLayerView)
	table.insert(arg_13_0.closeViewNames, ViewName.WeekWalkLayerRewardView)
	table.insert(arg_13_0.closeViewNames, ViewName.StoryView)
	table.insert(arg_13_0.closeViewNames, ViewName.DungeonPuzzleChangeColorView)
	table.insert(arg_13_0.closeViewNames, ViewName.InvestigateOpinionView)
	table.insert(arg_13_0.closeViewNames, ViewName.InvestigateView)

	for iter_13_0 in pairs(ActivityHelper.getJumpNeedCloseViewDict()) do
		table.insert(arg_13_0.closeViewNames, iter_13_0)
	end

	local var_13_1 = var_13_0[2]
	local var_13_2 = var_13_0[3] == 1
	local var_13_3 = DungeonConfig.instance:getEpisodeCO(var_13_1)

	if var_13_3 then
		local var_13_4 = var_13_3.chapterId
		local var_13_5 = DungeonConfig.instance:getChapterCO(var_13_4)

		if var_13_5 then
			local var_13_6 = var_13_5.type
			local var_13_7 = {
				chapterType = var_13_6,
				chapterId = var_13_4,
				episodeId = var_13_1,
				isNoShowMapLevel = var_13_2
			}
			local var_13_8 = DungeonController.instance:jumpDungeon(var_13_7)

			if var_13_8 and #var_13_8 > 0 then
				for iter_13_1, iter_13_2 in ipairs(var_13_8) do
					table.insert(arg_13_0.remainViewNames, iter_13_2)
				end

				table.insert(arg_13_0.remainViewNames, ViewName.DungeonView)
			else
				return JumpEnum.JumpResult.Fail
			end
		else
			logError("找不到章节配置, chapterId: " .. tostring(var_13_4))

			return JumpEnum.JumpResult.Fail
		end
	else
		logError("找不到关卡配置, episodeId: " .. tostring(var_13_1))

		return JumpEnum.JumpResult.Fail
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToDungeonViewWithType(arg_14_0, arg_14_1)
	local var_14_0 = string.splitToNumber(arg_14_1, "#")[2] or JumpEnum.DungeonChapterType.Story
	local var_14_1 = {}

	if var_14_0 == JumpEnum.DungeonChapterType.Story then
		var_14_1.chapterType = DungeonEnum.ChapterType.Normal
	elseif var_14_0 == JumpEnum.DungeonChapterType.Gold then
		var_14_1.chapterType = DungeonEnum.ChapterType.Gold
	elseif var_14_0 == JumpEnum.DungeonChapterType.Resource then
		var_14_1.chapterType = DungeonEnum.ChapterType.Break
	elseif var_14_0 == JumpEnum.DungeonChapterType.Explore then
		var_14_1.chapterType = DungeonEnum.ChapterType.Explore
	elseif var_14_0 == JumpEnum.DungeonChapterType.WeekWalk then
		var_14_1.chapterType = DungeonEnum.ChapterType.WeekWalk

		if ViewMgr.instance:isOpen(ViewName.WeekWalkView) or ViewMgr.instance:isOpen(ViewName.DungeonView) and DungeonModel.instance.curChapterType == DungeonEnum.ChapterType.WeekWalk then
			ViewMgr.instance:closeView(ViewName.TaskView)
			ViewMgr.instance:closeView(ViewName.StoreView)
			ViewMgr.instance:closeView(ViewName.BpView)

			return JumpEnum.JumpResult.Success
		end
	elseif var_14_0 == JumpEnum.DungeonChapterType.RoleStory then
		var_14_1.chapterType = DungeonEnum.ChapterType.RoleStory
	end

	table.insert(arg_14_0.closeViewNames, ViewName.HeroInvitationView)
	table.insert(arg_14_0.closeViewNames, ViewName.HeroInvitationDungeonMapView)
	table.insert(arg_14_0.closeViewNames, ViewName.DungeonMapView)
	table.insert(arg_14_0.closeViewNames, ViewName.DungeonMapLevelView)
	table.insert(arg_14_0.closeViewNames, ViewName.VersionActivity1_5DungeonMapView)
	table.insert(arg_14_0.closeViewNames, ViewName.VersionActivity1_5DungeonMapLevelView)
	table.insert(arg_14_0.closeViewNames, ViewName.WeekWalkView)
	table.insert(arg_14_0.closeViewNames, ViewName.WeekWalkCharacterView)
	table.insert(arg_14_0.closeViewNames, ViewName.WeekWalkLayerView)
	table.insert(arg_14_0.closeViewNames, ViewName.WeekWalkLayerRewardView)
	table.insert(arg_14_0.closeViewNames, ViewName.StoryView)
	table.insert(arg_14_0.closeViewNames, ViewName.DungeonPuzzleChangeColorView)

	local var_14_2 = DungeonController.instance:jumpDungeon(var_14_1)

	if var_14_2 and #var_14_2 > 0 then
		for iter_14_0, iter_14_1 in ipairs(var_14_2) do
			table.insert(arg_14_0.remainViewNames, iter_14_1)
		end

		table.insert(arg_14_0.remainViewNames, ViewName.DungeonView)
	else
		return JumpEnum.JumpResult.Fail
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToCharacterBackpackViewWithCharacter(arg_15_0, arg_15_1)
	table.insert(arg_15_0.waitOpenViewNames, ViewName.CharacterBackpackView)
	CharacterController.instance:enterCharacterBackpack(JumpEnum.CharacterBackpack.Character)
	table.insert(arg_15_0.remainViewNames, ViewName.CharacterBackpackView)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToCharacterBackpackViewWithEquip(arg_16_0, arg_16_1)
	table.insert(arg_16_0.waitOpenViewNames, ViewName.BackpackView)
	BackpackController.instance:enterItemBackpack(ItemEnum.CategoryType.Equip)
	table.insert(arg_16_0.remainViewNames, ViewName.BackpackView)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToHeroGroupView(arg_17_0, arg_17_1)
	local var_17_0 = string.splitToNumber(arg_17_1, "#")[2]
	local var_17_1 = DungeonConfig.instance:getEpisodeCO(var_17_0)

	DungeonFightController.instance:enterFight(var_17_1.chapterId, var_17_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToBackpackView(arg_18_0, arg_18_1)
	table.insert(arg_18_0.waitOpenViewNames, ViewName.BackpackView)
	BackpackController.instance:enterItemBackpack()
	table.insert(arg_18_0.remainViewNames, ViewName.BackpackView)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToPlayerClothView(arg_19_0, arg_19_1)
	logError("废弃跳转到主角技能界面")

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToMainView(arg_20_0, arg_20_1)
	local var_20_0 = string.splitToNumber(arg_20_1, "#")[2]

	ViewMgr.instance:closeAllPopupViews()
	MainController.instance:enterMainScene()

	if var_20_0 == 1 then
		ViewMgr.instance:openView(ViewName.MainView)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToTaskView(arg_21_0, arg_21_1)
	local var_21_0 = string.splitToNumber(arg_21_1, "#")

	table.insert(arg_21_0.waitOpenViewNames, ViewName.TaskView)
	table.insert(arg_21_0.closeViewNames, ViewName.WeekWalkView)
	table.insert(arg_21_0.closeViewNames, ViewName.WeekWalkCharacterView)
	table.insert(arg_21_0.closeViewNames, ViewName.WeekWalkLayerView)

	local var_21_1

	if #var_21_0 >= 2 then
		var_21_1 = var_21_0[2]
	end

	TaskController.instance:enterTaskView(var_21_1)
	table.insert(arg_21_0.remainViewNames, ViewName.TaskView)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToRoomView(arg_22_0, arg_22_1)
	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToRoomProductLineView(arg_23_0, arg_23_1)
	local var_23_0 = RoomController.instance:isRoomScene()

	if RoomController.instance:isEditMode() and var_23_0 then
		GameFacade.showToast(RoomEnum.Toast.RoomEditCanNotOpenProductionLevel)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(arg_23_0.waitOpenViewNames, ViewName.RoomInitBuildingView)

	if not ViewMgr.instance:isOpen(ViewName.RoomFormulaView) then
		if var_23_0 then
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

function var_0_0.jumpToTeachNoteView(arg_24_0, arg_24_1)
	table.insert(arg_24_0.waitOpenViewNames, ViewName.TeachNoteView)

	local var_24_0 = TeachNoteModel.instance:getJumpEpisodeId()

	TeachNoteController.instance:enterTeachNoteView(var_24_0, true)
	table.insert(arg_24_0.remainViewNames, ViewName.TeachNoteView)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToEquipView(arg_25_0, arg_25_1)
	local var_25_0 = string.splitToNumber(arg_25_1, "#")

	table.insert(arg_25_0.waitOpenViewNames, ViewName.EquipView)

	local var_25_1 = var_25_0[2]

	if var_25_1 then
		local var_25_2 = {
			equipId = var_25_1
		}

		EquipController.instance:openEquipView(var_25_2)
		table.insert(arg_25_0.remainViewNames, ViewName.EquipView)
		table.insert(arg_25_0.remainViewNames, ViewName.GiftMultipleChoiceView)
	else
		logError("equip id cant be null ...")

		return JumpEnum.JumpResult.Fail
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToHandbookView(arg_26_0, arg_26_1)
	local var_26_0 = string.splitToNumber(arg_26_1, "#")

	table.insert(arg_26_0.waitOpenViewNames, ViewName.HandbookView)
	table.insert(arg_26_0.closeViewNames, ViewName.HandBookCharacterSwitchView)
	table.insert(arg_26_0.closeViewNames, ViewName.HandbookEquipView)
	table.insert(arg_26_0.closeViewNames, ViewName.HandbookStoryView)
	table.insert(arg_26_0.closeViewNames, ViewName.HandbookCGDetailView)
	table.insert(arg_26_0.closeViewNames, ViewName.CharacterDataView)

	local var_26_1 = HandbookController.instance:jumpView(var_26_0)

	for iter_26_0, iter_26_1 in ipairs(var_26_1) do
		table.insert(arg_26_0.remainViewNames, iter_26_1)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToSocialView(arg_27_0, arg_27_1)
	local var_27_0 = string.splitToNumber(arg_27_1, "#")

	table.insert(arg_27_0.waitOpenViewNames, ViewName.SocialView)

	local var_27_1

	if var_27_0[2] then
		var_27_1 = {
			defaultTabIds = {
				[2] = var_27_0[2]
			}
		}
	end

	SocialController.instance:openSocialView(var_27_1)
	table.insert(arg_27_0.remainViewNames, ViewName.SocialView)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToNoticeView(arg_28_0, arg_28_1)
	table.insert(arg_28_0.waitOpenViewNames, ViewName.NoticeView)
	NoticeController.instance:openNoticeView()
	table.insert(arg_28_0.remainViewNames, ViewName.NoticeView)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToSignInView(arg_29_0, arg_29_1)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SignIn) then
		GameFacade.showToast(ToastEnum.JumpSignView)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(arg_29_0.waitOpenViewNames, ViewName.SignInView)

	local var_29_0 = {}

	var_29_0.isBirthday = false

	local var_29_1 = string.splitToNumber(arg_29_1, "#")

	var_29_0.isActiveLifeCicle = var_29_1[2] and var_29_1[2] == 1

	SignInController.instance:openSignInDetailView(var_29_0)
	table.insert(arg_29_0.remainViewNames, ViewName.SignInView)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToSignInViewWithBirthDay(arg_30_0, arg_30_1)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SignIn) then
		GameFacade.showToast(ToastEnum.JumpSignView)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(arg_30_0.waitOpenViewNames, ViewName.SignInView)

	local var_30_0 = {}

	var_30_0.isBirthday = true

	SignInController.instance:openSignInDetailView(var_30_0)
	table.insert(arg_30_0.remainViewNames, ViewName.SignInView)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToMailView(arg_31_0, arg_31_1)
	local var_31_0 = string.splitToNumber(arg_31_1, "#")[2]

	table.insert(arg_31_0.waitOpenViewNames, ViewName.MailView)
	MailController.instance:enterMailView(var_31_0)
	table.insert(arg_31_0.remainViewNames, ViewName.MailView)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToSeasonMainView(arg_32_0, arg_32_1)
	local var_32_0 = Activity104Model.instance:getCurSeasonId()
	local var_32_1, var_32_2, var_32_3 = ActivityHelper.getActivityStatusAndToast(var_32_0)

	if var_32_1 ~= ActivityEnum.ActivityStatus.Normal then
		if var_32_2 then
			GameFacade.showToastWithTableParam(var_32_2, var_32_3)
		end

		return JumpEnum.JumpResult.Fail
	end

	local var_32_4 = string.splitToNumber(arg_32_1, "#")
	local var_32_5 = var_32_4 and var_32_4[2]

	if var_32_5 == Activity104Enum.JumpId.Discount and not Activity104Model.instance:isSpecialOpen() then
		GameFacade.showToast(ToastEnum.SeasonSpecialNotOpen)

		return JumpEnum.JumpResult.Fail
	end

	VersionActivity3_0EnterController.instance:openVersionActivityEnterView(function()
		Activity104Controller.instance:openSeasonMainView({
			jumpId = var_32_5
		})
	end, nil, var_32_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToShow(arg_34_0, arg_34_1)
	return JumpEnum.JumpResult.Fail
end

function var_0_0.jumpToBpView(arg_35_0, arg_35_1)
	table.insert(arg_35_0.waitOpenViewNames, ViewName.BpView)

	local var_35_0 = string.splitToNumber(arg_35_1, "#")
	local var_35_1 = tonumber(var_35_0[2]) == 1
	local var_35_2 = tonumber(var_35_0[3]) == 1

	BpController.instance:openBattlePassView(var_35_1, nil, var_35_2)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToActivityView(arg_36_0, arg_36_1)
	local var_36_0 = string.splitToNumber(arg_36_1, "#")
	local var_36_1 = var_36_0[2]
	local var_36_2 = ActivityHelper.getActivityVersion(var_36_1)
	local var_36_3 = _G[string.format("VersionActivity%sJumpHandleFunc", var_36_2)]

	if var_36_3 and var_36_3["jumpTo" .. var_36_1] then
		return var_36_3["jumpTo" .. var_36_1](arg_36_0, var_36_0)
	end

	local var_36_4 = var_0_0.JumpActViewToHandleFunc[var_36_1]

	if var_36_4 then
		return var_36_4(arg_36_0, var_36_1, var_36_0)
	end

	local var_36_5 = ActivityConfig.instance:getActivityCo(var_36_1).typeId

	if var_36_1 == JumpEnum.ActIdEnum.Activity104 then
		table.insert(arg_36_0.waitOpenViewNames, ViewName.VersionActivityEnterView)
		table.insert(arg_36_0.waitOpenViewNames, ViewName.SeasonMainView)
		VersionActivityController.instance:openVersionActivityEnterViewIfNotOpened(function()
			Activity104Controller.instance:openSeasonMainView()
		end)
	elseif var_36_1 == JumpEnum.ActIdEnum.Act105 then
		table.insert(arg_36_0.waitOpenViewNames, ViewName.VersionActivityEnterView)
		VersionActivityController.instance:openVersionActivityEnterView()
	elseif var_36_1 == JumpEnum.ActIdEnum.Act106 then
		table.insert(arg_36_0.waitOpenViewNames, ViewName.ActivityBeginnerView)
		ActivityController.instance:openActivityBeginnerView(arg_36_1)
	elseif var_36_1 == JumpEnum.ActIdEnum.Act107 then
		table.insert(arg_36_0.waitOpenViewNames, ViewName.VersionActivityEnterView)
		table.insert(arg_36_0.waitOpenViewNames, ViewName.VersionActivityStoreView)
		VersionActivityController.instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivityController.instance:openLeiMiTeBeiStoreView()
		end)
	elseif var_36_1 == JumpEnum.ActIdEnum.Act108 then
		table.insert(arg_36_0.waitOpenViewNames, ViewName.VersionActivityEnterView)
		table.insert(arg_36_0.waitOpenViewNames, ViewName.MeilanniMainView)
		VersionActivityController.instance:openVersionActivityEnterViewIfNotOpened(function()
			MeilanniController.instance:openMeilanniMainView({
				checkStory = true
			})
		end)
	elseif var_36_1 == JumpEnum.ActIdEnum.Act109 then
		table.insert(arg_36_0.waitOpenViewNames, ViewName.VersionActivityEnterView)
		table.insert(arg_36_0.waitOpenViewNames, ViewName.Activity109ChessEntry)
		VersionActivityController.instance:openVersionActivityEnterViewIfNotOpened(function()
			Activity109ChessController.instance:openEntry(VersionActivityEnum.ActivityId.Act109)
		end)
	elseif var_36_1 == JumpEnum.ActIdEnum.Act111 then
		table.insert(arg_36_0.waitOpenViewNames, ViewName.VersionActivityPushBoxLevelView)
		PushBoxController.instance:enterPushBoxGame()
	elseif var_36_1 == JumpEnum.ActIdEnum.Act112 then
		table.insert(arg_36_0.waitOpenViewNames, ViewName.VersionActivityEnterView)
		table.insert(arg_36_0.waitOpenViewNames, ViewName.VersionActivityExchangeView)
		VersionActivityController.instance:openVersionActivityEnterViewIfNotOpened(function()
			ViewMgr.instance:openView(ViewName.VersionActivityExchangeView)
		end)
	elseif var_36_1 == JumpEnum.ActIdEnum.Act113 then
		table.insert(arg_36_0.waitOpenViewNames, ViewName.VersionActivityEnterView)
		VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			if #var_36_0 >= 3 then
				local var_42_0 = var_36_0[3]

				if var_42_0 == JumpEnum.LeiMiTeBeiSubJumpId.DungeonStoryMode then
					table.insert(arg_36_0.waitOpenViewNames, ViewName.VersionActivityDungeonMapView)
					VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(VersionActivityEnum.DungeonChapterId.LeiMiTeBei)
				elseif var_42_0 == JumpEnum.LeiMiTeBeiSubJumpId.DungeonHardMode then
					table.insert(arg_36_0.waitOpenViewNames, ViewName.VersionActivityDungeonMapView)

					if not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(JumpEnum.ActIdEnum.Act113) then
						VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(VersionActivityEnum.DungeonChapterId.LeiMiTeBei)
					else
						VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(VersionActivityEnum.DungeonChapterId.LeiMiTeBeiHard)
					end
				elseif var_42_0 == JumpEnum.LeiMiTeBeiSubJumpId.LeiMiTeBeiStore then
					table.insert(arg_36_0.waitOpenViewNames, ViewName.ReactivityStoreView)
					ReactivityController.instance:openReactivityStoreView(var_36_1)
				else
					logWarn("not support subJumpId : " .. arg_36_1)
				end
			else
				table.insert(arg_36_0.waitOpenViewNames, ViewName.VersionActivityDungeonMapView)
				VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(VersionActivityEnum.DungeonChapterId.LeiMiTeBei)
			end
		end, nil, var_36_1)
	elseif var_36_1 == ActivityEnum.Activity.Work_SignView_1_8 or var_36_1 == ActivityEnum.Activity.V3a0_SummerSign or var_36_1 == VersionActivity3_1Enum.ActivityId.NationalGift or var_36_1 == ActivityEnum.Activity.V2a0_SummerSign or var_36_1 == ActivityEnum.Activity.V2a1_MoonFestival or var_36_1 == ActivityEnum.Activity.V2a2_RedLeafFestival_PanelView or var_36_1 == VersionActivity2_2Enum.ActivityId.LimitDecorate or var_36_1 == ActivityEnum.Activity.V2a2_TurnBack_H5 or var_36_1 == ActivityEnum.Activity.V2a2_SummonCustomPickNew or var_36_1 == ActivityEnum.Activity.V2a3_NewCultivationGift or var_36_1 == ActivityEnum.Activity.V2a7_Labor_Sign or var_36_1 == ActivityEnum.Activity.V2a9_FreeMonthCard or var_36_1 == ActivityEnum.Activity.V2a8_DragonBoat or var_36_1 == ActivityEnum.Activity.V3a0_SummerSign or var_36_1 == ActivityEnum.Activity.V3a1_AutumnSign or var_36_1 == VersionActivity3_1Enum.ActivityId.BpOperAct or var_36_1 == VersionActivity3_1Enum.ActivityId.NationalGift then
		if ActivityHelper.getActivityStatus(var_36_1, true) ~= ActivityEnum.ActivityStatus.Normal then
			return JumpEnum.JumpResult.Fail
		end

		table.insert(arg_36_0.waitOpenViewNames, ViewName.ActivityBeginnerView)
		ActivityModel.instance:setTargetActivityCategoryId(var_36_1)
		ActivityController.instance:openActivityBeginnerView()
	elseif var_36_5 == ActivityEnum.ActivityTypeID.Act125 then
		if ActivityHelper.getActivityStatus(var_36_1, true) ~= ActivityEnum.ActivityStatus.Normal then
			return JumpEnum.JumpResult.Fail
		end

		table.insert(arg_36_0.waitOpenViewNames, ViewName.ActivityBeginnerView)
		Activity125Model.instance:setSelectEpisodeId(var_36_1, 1)
		ActivityModel.instance:setTargetActivityCategoryId(var_36_1)
		ActivityController.instance:openActivityBeginnerView()
	elseif var_36_5 == ActivityEnum.ActivityTypeID.NecrologistStory then
		if ActivityHelper.getActivityStatus(var_36_1, true) ~= ActivityEnum.ActivityStatus.Normal then
			return JumpEnum.JumpResult.Fail
		end

		local var_36_6 = RoleStoryModel.instance:getCurActStoryId()

		NecrologistStoryController.instance:openGameView(var_36_6)
	elseif var_36_5 == ActivityEnum.ActivityTypeID.Act210 then
		if ActivityHelper.getActivityStatus(var_36_1, true) ~= ActivityEnum.ActivityStatus.Normal then
			return JumpEnum.JumpResult.Fail
		end

		GaoSiNiaoController.instance:enterLevelView()
	else
		logWarn("not support actId : " .. arg_36_1)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToLeiMiTeBeiDungeonView(arg_43_0, arg_43_1)
	local var_43_0 = string.splitToNumber(arg_43_1, "#")[2]

	if not DungeonConfig.instance:getEpisodeCO(var_43_0) then
		logError("not found episode : " .. arg_43_1)

		return JumpEnum.JumpResult.Fail
	end

	if not DungeonModel.instance:getEpisodeInfo(var_43_0) then
		GameFacade.showToast(ToastEnum.WarmUpGotoOrder)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(arg_43_0.waitOpenViewNames, ViewName.VersionActivityDungeonMapLevelView)

	if ReactivityModel.instance:isReactivity(VersionActivityEnum.ActivityId.Act113) then
		VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(nil, var_43_0, function()
			ViewMgr.instance:openView(ViewName.VersionActivityDungeonMapLevelView, {
				isJump = true,
				episodeId = var_43_0
			})
		end)
	else
		VersionActivityController.instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(nil, var_43_0, function()
				ViewMgr.instance:openView(ViewName.VersionActivityDungeonMapLevelView, {
					isJump = true,
					episodeId = var_43_0
				})
			end)
		end)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToPushBox(arg_47_0, arg_47_1)
	return
end

function var_0_0.jumpToAct117(arg_48_0, arg_48_1, arg_48_2)
	table.insert(arg_48_0.waitOpenViewNames, ViewName.VersionActivity1_2EnterView)
	table.insert(arg_48_0.waitOpenViewNames, ViewName.ActivityTradeBargain)
	VersionActivity1_2EnterController.instance:directOpenVersionActivity1_2EnterView(Activity117Controller.openView, Activity117Controller.instance, arg_48_1)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct114(arg_49_0, arg_49_1, arg_49_2)
	if Activity114Model.instance.serverData.battleEventId > 0 then
		local var_49_0 = Activity114Config.instance:getEventCoById(Activity114Model.instance.id, Activity114Model.instance.serverData.battleEventId)

		Activity114Controller.instance:enterActivityFight(var_49_0.config.battleId)
	else
		table.insert(arg_49_0.waitOpenViewNames, ViewName.VersionActivity1_2EnterView)
		table.insert(arg_49_0.waitOpenViewNames, ViewName.Activity114View)
		VersionActivity1_2EnterController.instance:directOpenVersionActivity1_2EnterView(function()
			local var_50_0

			if Activity114Model.instance.serverData.isEnterSchool then
				var_50_0 = {
					defaultTabIds = {
						[2] = Activity114Enum.TabIndex.MainView
					}
				}
			end

			ViewMgr.instance:openView(ViewName.Activity114View, var_50_0)
		end)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct119(arg_51_0, arg_51_1, arg_51_2)
	if arg_51_1 == VersionActivity1_3Enum.ActivityId.Act307 then
		table.insert(arg_51_0.waitOpenViewNames, ViewName.VersionActivity1_3EnterView)
		table.insert(arg_51_0.waitOpenViewNames, ViewName.Activity1_3_119View)
		VersionActivity1_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			Activity1_3_119Controller.instance:openView()
		end)

		return JumpEnum.JumpResult.Success
	else
		table.insert(arg_51_0.waitOpenViewNames, ViewName.VersionActivity1_2EnterView)
		table.insert(arg_51_0.waitOpenViewNames, ViewName.Activity119View)
		VersionActivity1_2EnterController.instance:directOpenVersionActivity1_2EnterView(function()
			Activity119Controller.instance:openAct119View()
		end)

		return JumpEnum.JumpResult.Success
	end
end

function var_0_0.jumpToAct1_2Shop(arg_54_0)
	table.insert(arg_54_0.waitOpenViewNames, ViewName.VersionActivity1_2StoreView)
	ViewMgr.instance:openView(ViewName.VersionActivity1_2StoreView)

	return JumpEnum.JumpResult.Success
end

function var_0_0.ensureActStoryDone(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
	local var_55_0 = {}

	for iter_55_0, iter_55_1 in ipairs(arg_55_1) do
		if not VersionActivityBaseController.instance:isPlayedActivityVideo(iter_55_1) then
			local var_55_1 = ActivityConfig.instance:getActivityCo(iter_55_1).storyId

			if var_55_1 > 0 then
				table.insert(var_55_0, var_55_1)
			end
		end
	end

	if #var_55_0 > 0 then
		StoryController.instance:playStories(var_55_0, nil, arg_55_2, arg_55_3)
	else
		arg_55_2(arg_55_3)
	end
end

function var_0_0.jumpToAct1_2Dungeon(arg_56_0, arg_56_1, arg_56_2)
	table.insert(arg_56_0.waitOpenViewNames, ViewName.VersionActivity1_7EnterView)
	VersionActivity1_7EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_56_0.waitOpenViewNames, ViewName.VersionActivity1_2DungeonView)

		if #arg_56_2 >= 3 then
			local var_57_0 = arg_56_2[3]

			if var_57_0 == JumpEnum.Activity1_2DungeonJump.Shop then
				table.insert(arg_56_0.waitOpenViewNames, ViewName.ReactivityStoreView)
				VersionActivity1_2DungeonController.instance:openDungeonView(nil, nil, nil, nil, var_57_0)
			elseif var_57_0 == JumpEnum.Activity1_2DungeonJump.Normal then
				VersionActivity1_2DungeonController.instance:openDungeonView()
			elseif var_57_0 == JumpEnum.Activity1_2DungeonJump.Hard then
				VersionActivity1_2DungeonController.instance:openDungeonView(VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonHard)
			elseif var_57_0 == JumpEnum.Activity1_2DungeonJump.Task then
				table.insert(arg_56_0.waitOpenViewNames, ViewName.ReactivityTaskView)
				VersionActivity1_2DungeonController.instance:openDungeonView(nil, nil, nil, nil, var_57_0)
			elseif var_57_0 == JumpEnum.Activity1_2DungeonJump.Jump2Dungeon then
				VersionActivity1_2DungeonController.instance:openDungeonView(nil, arg_56_2[4], true)
			elseif var_57_0 == JumpEnum.Activity1_2DungeonJump.Jump2Camp then
				VersionActivity1_2DungeonController.instance:openDungeonView(nil, nil, nil, true)
			end
		else
			VersionActivity1_2DungeonController.instance:openDungeonView()
		end
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToEnterView1_2(arg_58_0, arg_58_1, arg_58_2)
	table.insert(arg_58_0.waitOpenViewNames, ViewName.VersionActivity1_2EnterView)
	VersionActivity1_2EnterController.instance:openVersionActivity1_2EnterView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToYaXianView(arg_59_0, arg_59_1, arg_59_2)
	table.insert(arg_59_0.waitOpenViewNames, ViewName.VersionActivity1_2EnterView)
	table.insert(arg_59_0.waitOpenViewNames, ViewName.YaXianMapView)
	arg_59_0:ensureActStoryDone({
		JumpEnum.ActIdEnum.EnterView1_2,
		arg_59_1
	}, function()
		VersionActivity1_2EnterController.instance:directOpenVersionActivity1_2EnterView()
		YaXianController.instance:openYaXianMapView()
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToEnterView1_3(arg_61_0, arg_61_1, arg_61_2)
	table.insert(arg_61_0.waitOpenViewNames, ViewName.VersionActivity1_3EnterView)
	VersionActivity1_3EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_3Shop(arg_62_0, arg_62_1, arg_62_2)
	table.insert(arg_62_0.waitOpenViewNames, ViewName.ReactivityStoreView)
	ReactivityController.instance:openReactivityStoreView(VersionActivity1_3Enum.ActivityId.Dungeon)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_3Dungeon(arg_63_0, arg_63_1, arg_63_2)
	table.insert(arg_63_0.closeViewNames, ViewName.VersionActivity1_3DungeonMapLevelView)
	table.insert(arg_63_0.waitOpenViewNames, ViewName.VersionActivity1_3EnterView)
	VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		if #arg_63_2 >= 3 then
			local var_64_0 = arg_63_2[3]

			if var_64_0 == JumpEnum.Activity1_3DungeonJump.Normal then
				table.insert(arg_63_0.closeViewNames, ViewName.VersionActivity1_3BuffView)
				table.insert(arg_63_0.waitOpenViewNames, ViewName.VersionActivity1_3DungeonMapView)
				VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei)
			elseif var_64_0 == JumpEnum.Activity1_3DungeonJump.Hard then
				table.insert(arg_63_0.waitOpenViewNames, ViewName.VersionActivity1_3DungeonMapView)
				table.insert(arg_63_0.closeViewNames, ViewName.VersionActivity1_3BuffView)

				if not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(JumpEnum.ActIdEnum.Act1_3Dungeon) then
					VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei)
				else
					VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBeiHard)
				end
			elseif var_64_0 == JumpEnum.Activity1_3DungeonJump.Daily then
				table.insert(arg_63_0.closeViewNames, ViewName.VersionActivity1_3AstrologyView)
				table.insert(arg_63_0.closeViewNames, ViewName.VersionActivity1_3BuffView)
				table.insert(arg_63_0.waitOpenViewNames, ViewName.VersionActivity1_3DungeonMapView)
				VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei, VersionActivity1_3DungeonEnum.DailyEpisodeId, nil, nil, {
					showDaily = true
				})
			elseif var_64_0 == JumpEnum.Activity1_3DungeonJump.Astrology then
				table.insert(arg_63_0.waitOpenViewNames, ViewName.VersionActivity1_3DungeonMapView)
				table.insert(arg_63_0.waitOpenViewNames, ViewName.VersionActivity1_3AstrologyView)
				table.insert(arg_63_0.closeViewNames, ViewName.VersionActivity1_3BuffView)

				if ViewMgr.instance:isOpen(ViewName.VersionActivity1_3DungeonMapView) then
					VersionActivity1_3AstrologyController.instance:openVersionActivity1_3AstrologyView()
				else
					VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei, nil, function()
						VersionActivity1_3AstrologyController.instance:openVersionActivity1_3AstrologyView()
					end)
				end
			elseif var_64_0 == JumpEnum.Activity1_3DungeonJump.Buff then
				table.insert(arg_63_0.waitOpenViewNames, ViewName.VersionActivity1_3DungeonMapView)
				table.insert(arg_63_0.waitOpenViewNames, ViewName.VersionActivity1_3BuffView)

				if ViewMgr.instance:isOpen(ViewName.VersionActivity1_3DungeonMapView) then
					VersionActivity1_3BuffController.instance:openBuffView()
				else
					VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei, nil, function()
						VersionActivity1_3BuffController.instance:openBuffView()
					end)
				end
			else
				logWarn("not support subJumpId:" .. tostring(var_64_0))

				return JumpEnum.JumpResult.Fail
			end
		else
			table.insert(arg_63_0.waitOpenViewNames, ViewName.VersionActivity1_3DungeonMapView)
			VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei)
		end
	end, nil, VersionActivity1_3Enum.ActivityId.Dungeon)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_3DungeonView(arg_67_0, arg_67_1)
	local var_67_0 = string.splitToNumber(arg_67_1, "#")[2]

	if not DungeonConfig.instance:getEpisodeCO(var_67_0) then
		logError("not found episode : " .. arg_67_1)

		return JumpEnum.JumpResult.Fail
	end

	if not DungeonModel.instance:getEpisodeInfo(var_67_0) then
		GameFacade.showToast(ToastEnum.WarmUpGotoOrder)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(arg_67_0.waitOpenViewNames, ViewName.VersionActivity1_3DungeonMapLevelView)
	VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(nil, var_67_0, function()
			ViewMgr.instance:openView(ViewName.VersionActivity1_3DungeonMapLevelView, {
				isJump = true,
				episodeId = var_67_0
			})
		end)
	end, nil, VersionActivity1_3Enum.ActivityId.Dungeon)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_3Act304(arg_70_0, arg_70_1, arg_70_2)
	table.insert(arg_70_0.waitOpenViewNames, ViewName.VersionActivity1_3EnterView)

	if arg_70_2 and #arg_70_2 >= 3 then
		Activity122Model.instance:setCurEpisodeId(#arg_70_2[3])
	end

	VersionActivity1_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_70_0.waitOpenViewNames, ViewName.Activity1_3ChessMapView)
		Activity1_3ChessController.instance:openMapView()
	end)
	ViewMgr.instance:closeAllPopupViews({
		ViewName.VersionActivity1_3EnterView,
		ViewName.Activity1_3ChessMapView
	})

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_3Act305(arg_72_0, arg_72_1, arg_72_2)
	table.insert(arg_72_0.waitOpenViewNames, ViewName.VersionActivity1_3EnterView)
	VersionActivity1_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_72_0.waitOpenViewNames, ViewName.ArmMainView)
		ArmPuzzlePipeController.instance:openMainView()
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_3Act306(arg_74_0, arg_74_1, arg_74_2)
	table.insert(arg_74_0.waitOpenViewNames, ViewName.VersionActivity1_3EnterView)

	if arg_74_2 and #arg_74_2 >= 3 then
		Activity120Model.instance:getCurEpisodeId(#arg_74_2[3])
	end

	VersionActivity1_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_74_0.waitOpenViewNames, ViewName.JiaLaBoNaMapView)
		JiaLaBoNaController.instance:openMapView()
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_3Act125(arg_76_0, arg_76_1, arg_76_2)
	if not ActivityModel.instance:isActOnLine(arg_76_1) then
		return JumpEnum.JumpResult.Fail
	end

	table.insert(arg_76_0.waitOpenViewNames, ViewName.ActivityBeginnerView)
	table.insert(arg_76_0.closeViewNames, ViewName.MainThumbnailView)
	ActivityModel.instance:setTargetActivityCategoryId(arg_76_1)
	ActivityController.instance:openActivityBeginnerView(arg_76_2)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToTurnback(arg_77_0, arg_77_1)
	if not TurnbackModel.instance:isNewType() then
		if not TurnbackModel.instance:canShowTurnbackPop() then
			return JumpEnum.JumpResult.Fail
		end

		local var_77_0 = string.splitToNumber(arg_77_1, "#")
		local var_77_1 = {
			turnbackId = tonumber(var_77_0[2]),
			subModuleId = tonumber(var_77_0[3])
		}

		table.insert(arg_77_0.waitOpenViewNames, ViewName.TurnbackBeginnerView)
		TurnbackModel.instance:setCurTurnbackId(var_77_1.turnbackId)
		TurnbackModel.instance:setTargetCategoryId(var_77_1.subModuleId)
		TurnbackController.instance:openTurnbackBeginnerView(var_77_1)

		return JumpEnum.JumpResult.Success
	elseif ViewMgr.instance:isOpen(ViewName.TurnbackNewBeginnerView) then
		local var_77_2 = string.splitToNumber(arg_77_1, "#")
		local var_77_3 = {
			subModuleId = tonumber(var_77_2[3])
		}

		TurnbackModel.instance:setTargetCategoryId(var_77_3.subModuleId)
		TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshBeginner)

		return JumpEnum.JumpResult.Success
	end
end

function var_0_0.jumpToEnterView1_4(arg_78_0, arg_78_1, arg_78_2)
	table.insert(arg_78_0.waitOpenViewNames, ViewName.VersionActivity1_4EnterView)
	VersionActivity1_4EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_4DungeonStore(arg_79_0, arg_79_1, arg_79_2)
	table.insert(arg_79_0.waitOpenViewNames, ViewName.VersionActivity1_4EnterView)
	VersionActivity1_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_79_0.waitOpenViewNames, ViewName.Activity129View)
		ViewMgr.instance:openView(ViewName.Activity129View, {
			actId = arg_79_1
		})
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_4Dungeon(arg_81_0, arg_81_1, arg_81_2)
	table.insert(arg_81_0.waitOpenViewNames, ViewName.VersionActivity1_4EnterView)
	VersionActivity1_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_81_0.waitOpenViewNames, ViewName.VersionActivity1_4DungeonView)
		ViewMgr.instance:openView(ViewName.VersionActivity1_4DungeonView, {
			actId = arg_81_1
		})
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_4Task(arg_83_0, arg_83_1, arg_83_2)
	table.insert(arg_83_0.waitOpenViewNames, ViewName.VersionActivity1_4EnterView)
	VersionActivity1_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_83_0.waitOpenViewNames, ViewName.VersionActivity1_4TaskView)
		ViewMgr.instance:openView(ViewName.VersionActivity1_4TaskView, {
			activityId = arg_83_1
		})
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_4Role37(arg_85_0, arg_85_1, arg_85_2)
	table.insert(arg_85_0.waitOpenViewNames, ViewName.VersionActivity1_4EnterView)
	VersionActivity1_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_85_0.waitOpenViewNames, ViewName.Activity130LevelView)
		Activity130Controller.instance:enterActivity130()
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_4Role6(arg_87_0, arg_87_1, arg_87_2)
	table.insert(arg_87_0.waitOpenViewNames, ViewName.VersionActivity1_4EnterView)
	VersionActivity1_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_87_0.waitOpenViewNames, ViewName.Activity131LevelView)
		Activity131Controller.instance:enterActivity131()
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_4Role37Game(arg_89_0, arg_89_1)
	local var_89_0 = string.splitToNumber(arg_89_1, "#")
	local var_89_1 = {
		episodeId = tonumber(var_89_0[2])
	}

	if ViewMgr.instance:isOpen(ViewName.Activity130LevelView) then
		if Activity130Model.instance:isEpisodeUnlock(var_89_1.episodeId) then
			Activity130Controller.instance:dispatchEvent(Activity130Event.EnterEpisode, var_89_1.episodeId)
		else
			GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

			return JumpEnum.JumpResult.Fail
		end
	else
		Activity130Controller.instance:openActivity130GameView(var_89_1)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_4Role6Game(arg_90_0, arg_90_1)
	local var_90_0 = string.splitToNumber(arg_90_1, "#")
	local var_90_1 = {
		episodeId = tonumber(var_90_0[2])
	}

	if ViewMgr.instance:isOpen(ViewName.Activity131LevelView) then
		if Activity131Model.instance:isEpisodeUnlock(var_90_1.episodeId) then
			Activity131Controller.instance:dispatchEvent(Activity131Event.EnterEpisode, var_90_1.episodeId)
		else
			GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

			return JumpEnum.JumpResult.Fail
		end
	else
		Activity131Controller.instance:openActivity131GameView(var_90_1)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAchievement(arg_91_0, arg_91_1)
	local var_91_0 = string.split(arg_91_1, "#")

	if #var_91_0 > 1 then
		AchievementJumpController.instance:jumpToAchievement(var_91_0)

		return JumpEnum.JumpResult.Success
	end

	return JumpEnum.JumpResult.Fail
end

function var_0_0.jumpToBossRush(arg_92_0, arg_92_1)
	local var_92_0 = string.splitToNumber(arg_92_1, "#")
	local var_92_1 = var_92_0[2]
	local var_92_2 = var_92_0[3]
	local var_92_3

	if var_92_1 then
		var_92_3 = {
			isOpenLevelDetail = true,
			stage = var_92_1,
			layer = var_92_2
		}
	end

	BossRushController.instance:openMainView(var_92_3)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_5EnterView(arg_93_0, arg_93_1, arg_93_2)
	table.insert(arg_93_0.waitOpenViewNames, ViewName.VersionActivity1_5EnterView)
	VersionActivity1_5EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_5Dungeon(arg_94_0, arg_94_1, arg_94_2)
	table.insert(arg_94_0.closeViewNames, ViewName.VersionActivity1_5DungeonMapLevelView)
	VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		if #arg_94_2 >= 3 then
			local var_95_0 = arg_94_2[3]

			if var_95_0 == JumpEnum.Activity1_3DungeonJump.Normal then
				table.insert(arg_94_0.waitOpenViewNames, ViewName.VersionActivity1_5DungeonMapView)
				VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_5DungeonEnum.DungeonChapterId.Story)
			elseif var_95_0 == JumpEnum.Activity1_3DungeonJump.Hard then
				table.insert(arg_94_0.waitOpenViewNames, ViewName.VersionActivity1_5DungeonMapView)

				if not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(JumpEnum.ActIdEnum.Act1_5Dungeon) then
					VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_5DungeonEnum.DungeonChapterId.Story)
				else
					VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_5DungeonEnum.DungeonChapterId.Hard)
				end
			else
				logWarn("not support subJumpId:" .. tostring(var_95_0))

				return JumpEnum.JumpResult.Fail
			end
		else
			table.insert(arg_94_0.waitOpenViewNames, ViewName.VersionActivity1_5DungeonMapView)
			VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_5DungeonEnum.DungeonChapterId.Story)
		end
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_5DungeonStore(arg_96_0, arg_96_1, arg_96_2)
	VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_96_0.waitOpenViewNames, ViewName.ReactivityStoreView)
		ReactivityController.instance:openReactivityStoreView(JumpEnum.ActIdEnum.Act1_5Dungeon)
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_5PeaceUluGame(arg_98_0, arg_98_1)
	table.insert(arg_98_0.waitOpenViewNames, ViewName.VersionActivity1_5EnterView)
	VersionActivity1_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_98_0.waitOpenViewNames, ViewName.PeaceUluView)
		PeaceUluController.instance:openPeaceUluView(arg_98_1)
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_5SportNews(arg_100_0, arg_100_1)
	table.insert(arg_100_0.waitOpenViewNames, ViewName.VersionActivity1_5EnterView)
	VersionActivity1_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_100_0.waitOpenViewNames, ViewName.SportsNewsView)
		SportsNewsController.instance:openSportsNewsMainView(arg_100_1)
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_5DungeonView(arg_102_0, arg_102_1)
	local var_102_0 = string.splitToNumber(arg_102_1, "#")[2]

	if not DungeonConfig.instance:getEpisodeCO(var_102_0) then
		logError("not found episode : " .. arg_102_1)

		return JumpEnum.JumpResult.Fail
	end

	if not DungeonModel.instance:getEpisodeInfo(var_102_0) then
		GameFacade.showToast(ToastEnum.WarmUpGotoOrder)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(arg_102_0.waitOpenViewNames, ViewName.VersionActivity1_5DungeonMapLevelView)
	VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView(nil, var_102_0, function()
			ViewMgr.instance:openView(ViewName.VersionActivity1_5DungeonMapLevelView, {
				isJump = true,
				episodeId = var_102_0
			})
		end)
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToActivity142(arg_105_0, arg_105_1)
	table.insert(arg_105_0.waitOpenViewNames, ViewName.VersionActivity1_5EnterView)
	VersionActivity1_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_105_0.waitOpenViewNames, ViewName.Activity142MapView)
		Activity142Controller.instance:openMapView()
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_5AiZiLa(arg_107_0, arg_107_1)
	table.insert(arg_107_0.waitOpenViewNames, ViewName.VersionActivity1_5EnterView)
	table.insert(arg_107_0.waitOpenViewNames, ViewName.AiZiLaMapView)
	AiZiLaController.instance:openMapView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_6EnterView(arg_108_0, arg_108_1, arg_108_2)
	table.insert(arg_108_0.waitOpenViewNames, ViewName.VersionActivity1_6EnterView)

	local var_108_0

	if #arg_108_2 >= 3 then
		var_108_0 = arg_108_2[3]
	end

	VersionActivity1_6EnterController.instance:openVersionActivityEnterView(nil, nil, var_108_0, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_6Dungeon(arg_109_0, arg_109_1, arg_109_2)
	table.insert(arg_109_0.closeViewNames, ViewName.VersionActivity1_6DungeonMapLevelView)
	table.insert(arg_109_0.waitOpenViewNames, ViewName.VersionActivity1_6EnterView)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		if #arg_109_2 >= 3 then
			local var_110_0 = arg_109_2[3]

			if var_110_0 == JumpEnum.Activity1_3DungeonJump.Normal then
				table.insert(arg_109_0.waitOpenViewNames, ViewName.VersionActivity1_6DungeonMapView)
				VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_6DungeonEnum.DungeonChapterId.Story)
			elseif var_110_0 == JumpEnum.Activity1_3DungeonJump.Hard then
				table.insert(arg_109_0.waitOpenViewNames, ViewName.VersionActivity1_6DungeonMapView)

				if not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(JumpEnum.ActIdEnum.Act1_6Dungeon) then
					VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_6DungeonEnum.DungeonChapterId.Story)
				else
					VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_6DungeonEnum.DungeonChapterId.Hard)
				end
			else
				logWarn("not support subJumpId:" .. tostring(var_110_0))

				return JumpEnum.JumpResult.Fail
			end
		else
			table.insert(arg_109_0.waitOpenViewNames, ViewName.VersionActivity1_6DungeonMapView)
			VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_6DungeonEnum.DungeonChapterId.Story)
		end
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_6DungeonView(arg_111_0, arg_111_1)
	local var_111_0 = string.splitToNumber(arg_111_1, "#")[2]

	if not DungeonConfig.instance:getEpisodeCO(var_111_0) then
		logError("not found episode : " .. arg_111_1)

		return JumpEnum.JumpResult.Fail
	end

	if not DungeonModel.instance:getEpisodeInfo(var_111_0) then
		GameFacade.showToast(ToastEnum.WarmUpGotoOrder)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(arg_111_0.waitOpenViewNames, ViewName.VersionActivity1_6DungeonMapLevelView)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(nil, var_111_0, function()
			ViewMgr.instance:openView(ViewName.VersionActivity1_6DungeonMapLevelView, {
				isJump = true,
				episodeId = var_111_0
			})
		end)
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_6DungeonStore(arg_114_0, arg_114_1, arg_114_2)
	table.insert(arg_114_0.waitOpenViewNames, ViewName.VersionActivity1_6EnterView)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_114_0.waitOpenViewNames, ViewName.VersionActivity1_6StoreView)
		VersionActivity1_6EnterController.instance:openStoreView()
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_6DungeonBoss(arg_116_0, arg_116_1, arg_116_2)
	table.insert(arg_116_0.waitOpenViewNames, ViewName.VersionActivity1_6EnterView)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView()
		VersionActivity1_6DungeonController.instance:openDungeonBossView()
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_6Rogue(arg_118_0, arg_118_1, arg_118_2)
	table.insert(arg_118_0.waitOpenViewNames, ViewName.VersionActivity1_6EnterView)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, arg_118_1, false)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_6QuNiang(arg_119_0, arg_119_1, arg_119_2)
	table.insert(arg_119_0.waitOpenViewNames, ViewName.VersionActivity1_6EnterView)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_119_0.waitOpenViewNames, ViewName.ActQuNiangLevelView)
		ActQuNiangController.instance:enterActivity()
	end, nil, arg_119_1, false)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAct1_6GeTian(arg_121_0, arg_121_1, arg_121_2)
	table.insert(arg_121_0.waitOpenViewNames, ViewName.VersionActivity1_6EnterView)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_121_0.waitOpenViewNames, ViewName.ActGeTianLevelView)
		ActGeTianController.instance:enterActivity()
	end, nil, arg_121_1, false)

	return JumpEnum.JumpResult.Fail
end

function var_0_0.jumpToAct1_9WarmUp(arg_123_0, arg_123_1, arg_123_2)
	table.insert(arg_123_0.waitOpenViewNames, ViewName.ActivityBeginnerView)

	local var_123_0 = arg_123_1

	ActivityModel.instance:setTargetActivityCategoryId(var_123_0)
	Activity125Model.instance:setSelectEpisodeId(var_123_0, 1)
	ActivityController.instance:openActivityBeginnerView(arg_123_1)
end

function var_0_0.jumpToVersionEnterView(arg_124_0, arg_124_1)
	local var_124_0 = string.splitToNumber(arg_124_1, "#")[2]

	if not var_124_0 then
		return JumpEnum.JumpResult.Fail
	end

	local var_124_1 = ActivityHelper.getActivityVersion(var_124_0)

	if not var_124_1 then
		return JumpEnum.JumpResult.Fail
	end

	local var_124_2 = string.format("VersionActivity%sEnterController", var_124_1)
	local var_124_3 = _G[var_124_2] or VersionActivityFixedEnterController

	if var_124_3 then
		var_124_3.instance:openVersionActivityEnterView(nil, nil, var_124_0)

		return JumpEnum.JumpResult.Success
	end

	return JumpEnum.JumpResult.Fail
end

function var_0_0.jumpToRougeMainView(arg_125_0, arg_125_1)
	RougeController.instance:openRougeMainView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToRougeRewardView(arg_126_0, arg_126_1)
	table.insert(arg_126_0.waitOpenViewNames, ViewName.RougeMainView)
	table.insert(arg_126_0.waitOpenViewNames, ViewName.RougeRewardView)

	local var_126_0 = string.splitToNumber(arg_126_1, "#")
	local var_126_1 = var_126_0[2]
	local var_126_2 = var_126_0[3]

	RougeController.instance:openRougeMainView(nil, nil, function()
		ViewMgr.instance:openView(ViewName.RougeRewardView, {
			version = var_126_1,
			stage = var_126_2
		})
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToSeason123(arg_128_0, arg_128_1)
	local var_128_0 = Season123Model.instance:getCurSeasonId()
	local var_128_1 = string.splitToNumber(arg_128_1, "#")
	local var_128_2 = string.format("VersionActivity%sEnterController", Activity123Enum.SeasonVersionPrefix[var_128_0])

	if #var_128_1 > 1 and var_128_1[2] == Activity123Enum.JumpType.Stage and #var_128_1 > 2 then
		local var_128_3 = var_128_1[3]

		_G[var_128_2].instance:openVersionActivityEnterView(Season123Controller.openSeasonEntryByJump, {
			actId = var_128_0,
			jumpId = Activity123Enum.JumpId.ForStage,
			jumpParam = {
				stage = var_128_3
			}
		}, var_128_0)

		return JumpEnum.JumpResult.Success
	end

	_G[var_128_2].instance:openVersionActivityEnterView(Season123Controller.openSeasonEntry, Season123Controller.instance, var_128_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToPermanentMainView(arg_129_0, arg_129_1)
	DungeonModel.instance:changeCategory(DungeonEnum.ChapterType.PermanentActivity)
	table.insert(arg_129_0.waitOpenViewNames, ViewName.DungeonView)
	DungeonController.instance:openDungeonView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToInvestigateView(arg_130_0, arg_130_1)
	table.insert(arg_130_0.waitOpenViewNames, ViewName.InvestigateView)
	table.insert(arg_130_0.closeViewNames, ViewName.InvestigateTaskView)
	InvestigateController.instance:openInvestigateView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToInvestigateOpinionTabView(arg_131_0, arg_131_1)
	local var_131_0 = string.splitToNumber(arg_131_1, "#")[2]
	local var_131_1 = lua_investigate_info.configDict[var_131_0]

	if not (var_131_1.episode == 0 or DungeonModel.instance:hasPassLevel(var_131_1.episode)) then
		GameFacade.showToast(ToastEnum.InvestigateTip1)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(arg_131_0.waitOpenViewNames, ViewName.InvestigateOpinionTabView)
	InvestigateController.instance:jumpToInvestigateOpinionTabView(var_131_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToDiceHeroLevelView(arg_132_0, arg_132_1)
	local var_132_0 = string.splitToNumber(arg_132_1, "#")[2]

	if not DiceHeroModel.instance.unlockChapterIds[var_132_0] then
		GameFacade.showToast(ToastEnum.DiceHeroLockChapter)

		return JumpEnum.JumpResult.Fail
	end

	local var_132_1 = DiceHeroConfig.instance:getLevelCo(var_132_0, 1)

	if not var_132_1 then
		return JumpEnum.JumpResult.Fail
	end

	table.insert(arg_132_0.waitOpenViewNames, ViewName.DiceHeroLevelView)
	ViewMgr.instance:openView(ViewName.DiceHeroLevelView, {
		chapterId = var_132_0,
		isInfinite = var_132_1.mode == 2
	})

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToRoomFishing(arg_133_0, arg_133_1)
	if string.splitToNumber(arg_133_1, "#")[2] == 1 then
		FishingController.instance:openFishingStoreView()
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToMainUISwitchInfoViewGiftSet(arg_134_0, arg_134_1)
	local var_134_0 = string.splitToNumber(arg_134_1, "#")
	local var_134_1 = var_134_0[2]
	local var_134_2 = var_134_0[3]

	MainUISwitchController.instance:openMainUISwitchInfoViewGiftSet(var_134_1, var_134_2)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToPackageStoreGoodsView(arg_135_0, arg_135_1)
	local var_135_0 = string.splitToNumber(arg_135_1, "#")

	if var_135_0 then
		local var_135_1 = var_135_0[2]
		local var_135_2 = StoreModel.instance:getGoodsMO(var_135_1)

		if var_135_2 and not var_135_2:isSoldOut() then
			if not arg_135_0._delayOpenPackageStoreGoodsView then
				function arg_135_0._delayOpenPackageStoreGoodsView(arg_136_0)
					StoreController.instance:openPackageStoreGoodsView(arg_136_0)
				end
			end

			TaskDispatcher.runDelay(arg_135_0._delayOpenPackageStoreGoodsView, var_135_2, 0.1)

			return JumpEnum.JumpResult.Success
		end
	end

	return JumpEnum.JumpResult.Fail
end

function var_0_0.jumpToShelterBuilding(arg_137_0, arg_137_1)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.SurvivalShelter then
		return JumpEnum.JumpResult.Fail
	end

	local var_137_0 = string.splitToNumber(arg_137_1, "#")[2]
	local var_137_1 = SurvivalShelterModel.instance:getWeekInfo():getBuildingInfoByBuildingId(var_137_0)

	if var_137_1 then
		SurvivalMapHelper.instance:gotoBuilding(var_137_1.id, nil, true)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToCommandStationTask(arg_138_0, arg_138_1)
	if ViewMgr.instance:isOpen(ViewName.CommandStationTaskView) then
		return JumpEnum.JumpResult.Success
	end

	CommandStationController.instance:openCommandStationPaperView(nil, true)
	CommandStationController.instance:openCommandStationTaskView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToTowerView(arg_139_0, arg_139_1)
	local var_139_0 = string.splitToNumber(arg_139_1, "#")
	local var_139_1 = var_139_0[2]
	local var_139_2 = var_139_0[3]
	local var_139_3 = {
		towerType = var_139_1,
		towerId = var_139_2
	}

	TowerController.instance:jumpView(var_139_3)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToOdyssey(arg_140_0, arg_140_1)
	local var_140_0 = string.splitToNumber(arg_140_1, "#")
	local var_140_1 = var_140_0[2]
	local var_140_2 = var_140_0[3]

	if var_140_1 == OdysseyEnum.JumpType.JumpToMainElement then
		local var_140_3, var_140_4 = OdysseyDungeonModel.instance:getCurMainElement()

		if var_140_4 then
			OdysseyDungeonController.instance:jumpToMapElement(var_140_4.id)
		else
			OdysseyDungeonController.instance:jumpToHeroPos()
		end
	elseif var_140_1 == OdysseyEnum.JumpType.JumpToElementAndOpen then
		OdysseyDungeonController.instance:jumpToMapElement(var_140_2)
	elseif var_140_1 == OdysseyEnum.JumpType.JumpToHeroPos then
		OdysseyDungeonController.instance:jumpToHeroPos()
	elseif var_140_1 == OdysseyEnum.JumpType.JumpToReligion then
		OdysseyDungeonController.instance:openMembersView()
	elseif var_140_1 == OdysseyEnum.JumpType.JumpToMyth then
		OdysseyDungeonController.instance:openMythView()
	elseif var_140_1 == OdysseyEnum.JumpType.JumpToLevelReward then
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Odyssey
		}, function()
			OdysseyTaskModel.instance:setTaskInfoList()
			OdysseyDungeonController.instance:openLevelRewardView()
		end)
	elseif var_140_1 == OdysseyEnum.JumpType.JumpToLibrary then
		OdysseyController.instance:openLibraryView(AssassinEnum.LibraryType.Hero)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpToAssassinLibraryView(arg_142_0, arg_142_1)
	local var_142_0 = string.splitToNumber(arg_142_1, "#")
	local var_142_1 = var_142_0[2]
	local var_142_2 = var_142_0[3]

	AssassinController.instance:openAssassinLibraryView(var_142_1, var_142_2)
end

var_0_0.JumpViewToHandleFunc = {
	[JumpEnum.JumpView.StoreView] = var_0_0.jumpToStoreView,
	[JumpEnum.JumpView.SummonView] = var_0_0.jumpToSummonView,
	[JumpEnum.JumpView.SummonViewGroup] = var_0_0.jumpToSummonViewGroup,
	[JumpEnum.JumpView.DungeonViewWithChapter] = var_0_0.jumpToDungeonViewWithChapter,
	[JumpEnum.JumpView.DungeonViewWithEpisode] = var_0_0.jumpToDungeonViewWithEpisode,
	[JumpEnum.JumpView.DungeonViewWithType] = var_0_0.jumpToDungeonViewWithType,
	[JumpEnum.JumpView.CharacterBackpackViewWithCharacter] = var_0_0.jumpToCharacterBackpackViewWithCharacter,
	[JumpEnum.JumpView.CharacterBackpackViewWithEquip] = var_0_0.jumpToCharacterBackpackViewWithEquip,
	[JumpEnum.JumpView.HeroGroupView] = var_0_0.jumpToHeroGroupView,
	[JumpEnum.JumpView.BackpackView] = var_0_0.jumpToBackpackView,
	[JumpEnum.JumpView.PlayerClothView] = var_0_0.jumpToPlayerClothView,
	[JumpEnum.JumpView.MainView] = var_0_0.jumpToMainView,
	[JumpEnum.JumpView.TaskView] = var_0_0.jumpToTaskView,
	[JumpEnum.JumpView.RoomView] = var_0_0.jumpToRoomView,
	[JumpEnum.JumpView.RoomProductLineView] = var_0_0.jumpToRoomProductLineView,
	[JumpEnum.JumpView.TeachNoteView] = var_0_0.jumpToTeachNoteView,
	[JumpEnum.JumpView.EquipView] = var_0_0.jumpToEquipView,
	[JumpEnum.JumpView.HandbookView] = var_0_0.jumpToHandbookView,
	[JumpEnum.JumpView.SocialView] = var_0_0.jumpToSocialView,
	[JumpEnum.JumpView.NoticeView] = var_0_0.jumpToNoticeView,
	[JumpEnum.JumpView.SignInView] = var_0_0.jumpToSignInView,
	[JumpEnum.JumpView.MailView] = var_0_0.jumpToMailView,
	[JumpEnum.JumpView.SignInViewWithBirthDay] = var_0_0.jumpToSignInViewWithBirthDay,
	[JumpEnum.JumpView.SeasonMainView] = var_0_0.jumpToSeasonMainView,
	[JumpEnum.JumpView.Show] = var_0_0.jumpToShow,
	[JumpEnum.JumpView.BpView] = var_0_0.jumpToBpView,
	[JumpEnum.JumpView.ActivityView] = var_0_0.jumpToActivityView,
	[JumpEnum.JumpView.LeiMiTeBeiDungeonView] = var_0_0.jumpToLeiMiTeBeiDungeonView,
	[JumpEnum.JumpView.Act1_3DungeonView] = var_0_0.jumpToAct1_3DungeonView,
	[JumpEnum.JumpView.PushBox] = var_0_0.jumpToPushBox,
	[JumpEnum.JumpView.Turnback] = var_0_0.jumpToTurnback,
	[JumpEnum.JumpView.Role37Game] = var_0_0.jumpToAct1_4Role37Game,
	[JumpEnum.JumpView.Role6Game] = var_0_0.jumpToAct1_4Role6Game,
	[JumpEnum.JumpView.Achievement] = var_0_0.jumpToAchievement,
	[JumpEnum.JumpView.RoleStoryActivity] = var_0_0.jumpToRoleStoryActivity,
	[JumpEnum.JumpView.BossRush] = var_0_0.jumpToBossRush,
	[JumpEnum.JumpView.Tower] = var_0_0.jumpToTowerView,
	[JumpEnum.JumpView.Odyssey] = var_0_0.jumpToOdyssey,
	[JumpEnum.JumpView.AssassinLibraryView] = var_0_0.jumpToAssassinLibraryView,
	[JumpEnum.JumpView.Challenge] = Act183JumpController.jumpToAct183,
	[JumpEnum.JumpView.V1a5Dungeon] = var_0_0.jumpToAct1_5DungeonView,
	[JumpEnum.JumpView.V1a6Dungeon] = var_0_0.jumpToAct1_6DungeonView,
	[JumpEnum.JumpView.Season123] = var_0_0.jumpToSeason123,
	[JumpEnum.JumpView.VersionEnterView] = var_0_0.jumpToVersionEnterView,
	[JumpEnum.JumpView.RougeMainView] = var_0_0.jumpToRougeMainView,
	[JumpEnum.JumpView.RougeRewardView] = var_0_0.jumpToRougeRewardView,
	[JumpEnum.JumpView.PermanentMainView] = var_0_0.jumpToPermanentMainView,
	[JumpEnum.JumpView.InvestigateView] = var_0_0.jumpToInvestigateView,
	[JumpEnum.JumpView.InvestigateOpinionTabView] = var_0_0.jumpToInvestigateOpinionTabView,
	[JumpEnum.JumpView.DiceHero] = var_0_0.jumpToDiceHeroLevelView,
	[JumpEnum.JumpView.RoomFishing] = var_0_0.jumpToRoomFishing,
	[JumpEnum.JumpView.MainUISwitchInfoViewGiftSet] = var_0_0.jumpToMainUISwitchInfoViewGiftSet,
	[JumpEnum.JumpView.PackageStoreGoodsView] = var_0_0.jumpToPackageStoreGoodsView,
	[JumpEnum.JumpView.ShelterBuilding] = var_0_0.jumpToShelterBuilding,
	[JumpEnum.JumpView.CommandStationTask] = var_0_0.jumpToCommandStationTask
}
var_0_0.JumpActViewToHandleFunc = {
	[JumpEnum.ActIdEnum.V2a4_WuErLiXi] = var_0_0.V2a4_WuErLiXi,
	[JumpEnum.ActIdEnum.V3a0_Reactivity] = var_0_0.V3a0_Reactivity,
	[JumpEnum.ActIdEnum.Act117] = var_0_0.jumpToAct117,
	[JumpEnum.ActIdEnum.Act114] = var_0_0.jumpToAct114,
	[JumpEnum.ActIdEnum.Act119] = var_0_0.jumpToAct119,
	[JumpEnum.ActIdEnum.Act1_2Dungeon] = var_0_0.jumpToAct1_2Dungeon,
	[JumpEnum.ActIdEnum.Act1_2Shop] = var_0_0.jumpToAct1_2Shop,
	[JumpEnum.ActIdEnum.EnterView1_2] = var_0_0.jumpToEnterView1_2,
	[JumpEnum.ActIdEnum.YaXian] = var_0_0.jumpToYaXianView,
	[JumpEnum.ActIdEnum.EnterView1_3] = var_0_0.jumpToEnterView1_3,
	[JumpEnum.ActIdEnum.Act1_3Dungeon] = var_0_0.jumpToAct1_3Dungeon,
	[JumpEnum.ActIdEnum.Act1_3Shop] = var_0_0.jumpToAct1_3Shop,
	[JumpEnum.ActIdEnum.Act1_3Act304] = var_0_0.jumpToAct1_3Act304,
	[JumpEnum.ActIdEnum.Act1_3Act305] = var_0_0.jumpToAct1_3Act305,
	[JumpEnum.ActIdEnum.Act1_3Act306] = var_0_0.jumpToAct1_3Act306,
	[JumpEnum.ActIdEnum.Act1_3Act307] = var_0_0.jumpToAct119,
	[JumpEnum.ActIdEnum.Act1_3Act125] = var_0_0.jumpToAct1_3Act125,
	[JumpEnum.ActIdEnum.EnterView1_4] = var_0_0.jumpToEnterView1_4,
	[JumpEnum.ActIdEnum.Act1_4DungeonStore] = var_0_0.jumpToAct1_4DungeonStore,
	[JumpEnum.ActIdEnum.Act1_4Dungeon] = var_0_0.jumpToAct1_4Dungeon,
	[JumpEnum.ActIdEnum.Act1_4Task] = var_0_0.jumpToAct1_4Task,
	[JumpEnum.ActIdEnum.Role37] = var_0_0.jumpToAct1_4Role37,
	[JumpEnum.ActIdEnum.Role6] = var_0_0.jumpToAct1_4Role6,
	[JumpEnum.ActIdEnum.EnterView1_5] = var_0_0.jumpToAct1_5EnterView,
	[JumpEnum.ActIdEnum.Act1_5Dungeon] = var_0_0.jumpToAct1_5Dungeon,
	[JumpEnum.ActIdEnum.Act1_5Shop] = var_0_0.jumpToAct1_5DungeonStore,
	[JumpEnum.ActIdEnum.Act1_5PeaceUlu] = var_0_0.jumpToAct1_5PeaceUluGame,
	[JumpEnum.ActIdEnum.Act1_5SportNews] = var_0_0.jumpToAct1_5SportNews,
	[JumpEnum.ActIdEnum.Activity142] = var_0_0.jumpToActivity142,
	[JumpEnum.ActIdEnum.Act1_5AiZiLa] = var_0_0.jumpToAct1_5AiZiLa,
	[JumpEnum.ActIdEnum.Act1_6EnterView] = var_0_0.jumpToAct1_6EnterView,
	[JumpEnum.ActIdEnum.Act1_6Dungeon] = var_0_0.jumpToAct1_6Dungeon,
	[JumpEnum.ActIdEnum.Act1_6DungeonStore] = var_0_0.jumpToAct1_6DungeonStore,
	[JumpEnum.ActIdEnum.Act1_6DungeonBossRush] = var_0_0.jumpToAct1_6DungeonBoss,
	[JumpEnum.ActIdEnum.Act1_6Rougue] = var_0_0.jumpToAct1_6Rogue,
	[JumpEnum.ActIdEnum.Act1_6QuNiang] = var_0_0.jumpToAct1_6QuNiang,
	[JumpEnum.ActIdEnum.Act1_6GeTian] = var_0_0.jumpToAct1_6GeTian,
	[JumpEnum.ActIdEnum.Act1_9WarmUp] = var_0_0.jumpToAct1_9WarmUp
}

return var_0_0
