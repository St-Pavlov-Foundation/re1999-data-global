module("modules.logic.activity.view.ActivityBeginnerView", package.seeall)

slot0 = class("ActivityBeginnerView", BaseView)

function slot0.onInitView(slot0)
	slot0._gocategory = gohelper.findChild(slot0.viewGO, "#go_category")
	slot0._scrollitem = gohelper.findChildScrollRect(slot0.viewGO, "#go_category/#scroll_categoryitem")
	slot0._gosubview = gohelper.findChild(slot0.viewGO, "#go_subview")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

slot1 = {
	[ActivityEnum.Activity.GuestBind] = ViewName.ActivityGuestBindView,
	[ActivityEnum.Activity.RoleSignViewPart1] = ViewName.V1a5_Role_FullSignView_Part1,
	[ActivityEnum.Activity.RoleSignViewPart2] = ViewName.V1a5_Role_FullSignView_Part2,
	[slot2:getActivityId()] = ViewName.ActivityGiftForTheVoyage,
	[ActivityEnum.Activity.HarvestSeasonView_1_5] = ViewName.V1a5_HarvestSeason_FullSignView,
	[ActivityEnum.Activity.V2a0_SummerSign] = ViewName.V2a0_SummerSign_FullView,
	[ActivityEnum.Activity.V2a1_MoonFestival] = ViewName.V2a1_MoonFestival_FullView,
	[ActivityEnum.Activity.LinkageActivity_FullView] = ViewName.LinkageActivity_FullView,
	[ActivityEnum.Activity.V2a2_SpringFestival] = ViewName.V2a2_SpringFestival_FullView,
	[ActivityEnum.Activity.NoviceSign] = ViewName.ActivityNoviceSignView,
	[ActivityEnum.Activity.NorSign] = ViewName.ActivityNorSignView,
	[ActivityEnum.Activity.NoviceInsight] = ViewName.ActivityNoviceInsightView,
	[ActivityEnum.Activity.StoryShow] = ViewName.ActivityStoryShowView,
	[ActivityEnum.Activity.DreamShow] = ViewName.ActivityDreamShowView,
	[ActivityEnum.Activity.ClassShow] = ViewName.ActivityClassShowView,
	[ActivityEnum.Activity.WeekWalkDeepShow] = ViewName.ActivityWeekWalkDeepShowView,
	[ActivityEnum.Activity.VersionActivity1_3Radio] = ViewName.VersionActivity1_3RadioView,
	[ActivityEnum.Activity.SummerSignPart1_1_2] = ViewName.SummerSignPart1View_1_2,
	[ActivityEnum.Activity.SummerSignPart2_1_2] = ViewName.SummerSignPart2View_1_2,
	[ActivityEnum.Activity.DoubleFestivalSign_1_3] = ViewName.ActivityDoubleFestivalSignView_1_3,
	[ActivityEnum.Activity.StarLightSignPart1_1_3] = ViewName.ActivityStarLightSignPart1View_1_3,
	[ActivityEnum.Activity.StarLightSignPart2_1_3] = ViewName.ActivityStarLightSignPart2View_1_3,
	[ActivityEnum.Activity.DailyAllowance] = ViewName.DailyAllowanceView,
	[ActivityEnum.Activity.Activity1_5WarmUp] = ViewName.VersionActivity1_5WarmUpView,
	[ActivityEnum.Activity.RoleSignViewPart1_1_5] = ViewName.V1a5_Role_FullSignView_Part1,
	[ActivityEnum.Activity.RoleSignViewPart2_1_5] = ViewName.V1a5_Role_FullSignView_Part2,
	[ActivityEnum.Activity.DoubleFestivalSign_1_5] = ViewName.V1a5_DoubleFestival_FullSignView,
	[ActivityEnum.Activity.FurnaceTreasure] = ViewName.FurnaceTreasureView,
	[ActivityEnum.Activity.NewYearEve] = ViewName.NewYearEveActivityView,
	[ActivityEnum.Activity.Activity1_6WarmUp] = ViewName.VersionActivity1_6WarmUpView,
	[ActivityEnum.Activity.RoleSignViewPart1_1_7] = ViewName.V1a7_Role_FullSignView_Part1,
	[ActivityEnum.Activity.RoleSignViewPart2_1_7] = ViewName.V1a7_Role_FullSignView_Part2,
	[ActivityEnum.Activity.LanternFestival] = ViewName.LanternFestivalActivityView,
	[ActivityEnum.Activity.Activity1_7WarmUp] = ViewName.VersionActivity1_7WarmUpView,
	[ActivityEnum.Activity.RoleSignViewPart1_1_8] = ViewName.V1a8_Role_FullSignView_Part1,
	[ActivityEnum.Activity.RoleSignViewPart2_1_8] = ViewName.V1a8_Role_FullSignView_Part2,
	[ActivityEnum.Activity.Activity1_8WarmUp] = ViewName.VersionActivity1_8WarmUpView,
	[ActivityEnum.Activity.Work_SignView_1_8] = ViewName.V1a8_Work_FullSignView,
	[ActivityEnum.Activity.V1a9_Matildagift] = ViewName.V1a9_ActivityShow_MatildagiftView,
	[ActivityEnum.Activity.RoleSignViewPart1_1_9] = ViewName.V1a9_Role_FullSignView_Part1,
	[ActivityEnum.Activity.RoleSignViewPart2_1_9] = ViewName.V1a9_Role_FullSignView_Part2,
	[ActivityEnum.Activity.DragonBoatFestival] = ViewName.DragonBoatFestivalActivityView,
	[ActivityEnum.Activity.AnniversarySignView_1_9] = ViewName.V1a9_AnniversarySign_FullSignView,
	[ActivityEnum.Activity.RoomGift] = ViewName.RoomGiftView,
	[ActivityEnum.Activity.Activity1_9WarmUp] = ViewName.VersionActivity1_9WarmUpView,
	[ActivityEnum.Activity.V2a2_DecalogPresent] = ViewName.V1a9DecalogPresentFullView,
	[ActivityEnum.Activity.SelfSelectCharacter] = ViewName.Activity136FullView,
	[ActivityEnum.Activity.V1a9_SemmelWeisGift] = ViewName.SemmelWeisGiftFullView,
	[ActivityEnum.Activity.V2a0_SummerSign] = ViewName.V2a0_SummerSign_FullView,
	[ActivityEnum.Activity.V2a0_Role_SignView_Part1] = ViewName.V2a0_Role_FullSignView_Part1,
	[ActivityEnum.Activity.V2a0_Role_SignView_Part2] = ViewName.V2a0_Role_FullSignView_Part2,
	[ActivityEnum.Activity.V2a0_WarmUp] = ViewName.V2a0_WarmUp,
	[ActivityEnum.Activity.V2a1_Role_SignView_Part1] = ViewName.V2a1_Role_FullSignView_Part1,
	[ActivityEnum.Activity.V2a1_Role_SignView_Part2] = ViewName.V2a1_Role_FullSignView_Part2,
	[ActivityEnum.Activity.V2a1_MoonFestival] = ViewName.V2a1_MoonFestival_FullView,
	[ActivityEnum.Activity.V2a1_WarmUp] = ViewName.V2a1_WarmUp,
	[ActivityEnum.Activity.V2a2_Role_SignView_Part1] = ViewName.V2a2_Role_FullSignView_Part1,
	[ActivityEnum.Activity.V2a2_Role_SignView_Part2] = ViewName.V2a2_Role_FullSignView_Part2,
	[ActivityEnum.Activity.V2a2_TurnBack_H5] = ViewName.TurnBackInvitationMainView,
	[ActivityEnum.Activity.V2a2_SummonCustomPickNew] = ViewName.SummonNewCustomPickView,
	[ActivityEnum.Activity.v2a2_RedLeafFestival] = ViewName.V2a2_RedLeafFestival_FullView,
	[VersionActivity2_2Enum.ActivityId.LimitDecorate] = ViewName.Activity173PanelView,
	[ActivityEnum.Activity.V2a2_WarmUp] = ViewName.V2a2_WarmUp,
	[ActivityEnum.Activity.RoomSign] = ViewName.VersionActivity2_2RoomSignView,
	[ActivityEnum.Activity.V2a4_Blind_Box_Draw] = ViewName.Activity181MainView
}
slot2 = VoyageConfig.instance
slot2 = {
	[ActivityEnum.ActivityTypeID.OpenTestWarmUp] = ViewName.ActivityWarmUpView,
	[ActivityEnum.ActivityTypeID.DoubleDrop] = ViewName.V1a7_DoubleDropView
}

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_open)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0._refreshView, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.SetBannerViewCategoryListInteract, slot0.setCategoryListInteractable, slot0)

	slot0._needSetSortInfos = true

	slot0:_refreshView()

	slot0._needSetSortInfos = false
end

function slot0._refreshView(slot0)
	if not ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Beginner) or not next(slot1) then
		slot0:closeThis()
	end

	ActivityModel.instance:removeFinishedCategory(slot1)

	slot0.data = {}

	for slot5, slot6 in pairs(slot1) do
		table.insert(slot0.data, {
			id = slot6,
			co = ActivityConfig.instance:getActivityCo(slot6),
			type = ActivityEnum.ActivityType.Beginner
		})
	end

	if slot0._needSetSortInfos then
		slot0._needSetSortInfos = false

		ActivityBeginnerCategoryListModel.instance:setSortInfos(slot0.data)
		ActivityBeginnerCategoryListModel.instance:checkTargetCategory(slot0.data)
	end

	ActivityBeginnerCategoryListModel.instance:setOpenViewTime()
	ActivityBeginnerCategoryListModel.instance:setCategoryList(slot0.data)
	slot0:_openSubView()
end

function slot0._openSubView(slot0)
	if slot0._viewName then
		ViewMgr.instance:closeView(slot0._viewName, true)
	end

	slot1 = ActivityModel.instance:getTargetActivityCategoryId(ActivityEnum.ActivityType.Beginner)
	slot0._viewName = uv0[slot1]

	if slot1 ~= 0 then
		slot0:setCategoryRedDotData(slot1)
	end

	if not slot0._viewName then
		if ActivityConfig.instance:getActivityCo(slot1) then
			if uv1[slot2.typeId] then
				slot0._viewName = uv1[slot2.typeId]
			end

			slot0.viewContainer:refreshHelp(slot2.typeId)
		else
			slot0.viewContainer:hideHelp()

			return
		end
	else
		slot0.viewContainer:hideHelp()
	end

	ViewMgr.instance:openView(slot0._viewName, {
		parent = slot0._gosubview,
		actId = slot1,
		root = slot0.viewGO
	}, true)
end

function slot0.setCategoryRedDotData(slot0, slot1)
	slot2 = PlayerPrefsKey.FirstEnterActivityShow .. "#" .. tostring(slot1) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

	PlayerPrefsHelper.setString(slot2, "hasEnter")

	return slot2
end

function slot0.closeSubView(slot0)
	if slot0._viewName then
		ViewMgr.instance:closeView(slot0._viewName, true)

		slot0._viewName = nil
	end
end

function slot0.onClose(slot0)
	ActivityModel.instance:setTargetActivityCategoryId(0)
	slot0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0._refreshView, slot0)
	slot0:removeEventCb(ActivityController.instance, ActivityEvent.SetBannerViewCategoryListInteract, slot0.setCategoryListInteractable, slot0)
	slot0:closeSubView()
	ActivityModel.instance:setTargetActivityCategoryId(0)
	ActivityBeginnerCategoryListModel.instance:clear()
end

function slot0.setCategoryListInteractable(slot0, slot1)
	if not slot0._categoryListCanvasGroup then
		slot0._categoryListCanvasGroup = gohelper.onceAddComponent(slot0._gocategory, typeof(UnityEngine.CanvasGroup))
	end

	slot0._categoryListCanvasGroup.interactable = slot1
	slot0._categoryListCanvasGroup.blocksRaycasts = slot1
	slot0._categoryListCanvasGroup.blocksRaycasts = slot1
end

function slot0.onDestroyView(slot0)
end

return slot0
