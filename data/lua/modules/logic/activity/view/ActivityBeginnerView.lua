module("modules.logic.activity.view.ActivityBeginnerView", package.seeall)

local var_0_0 = class("ActivityBeginnerView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocategory = gohelper.findChild(arg_1_0.viewGO, "#go_category")
	arg_1_0._scrollitem = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_category/#scroll_categoryitem")
	arg_1_0._gosubview = gohelper.findChild(arg_1_0.viewGO, "#go_subview")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

local var_0_1 = {
	[ActivityEnum.Activity.GuestBind] = ViewName.ActivityGuestBindView,
	[ActivityEnum.Activity.RoleSignViewPart1] = ViewName.V1a5_Role_FullSignView_Part1,
	[ActivityEnum.Activity.RoleSignViewPart2] = ViewName.V1a5_Role_FullSignView_Part2,
	[VoyageConfig.instance:getActivityId()] = ViewName.ActivityGiftForTheVoyage,
	[ActivityEnum.Activity.HarvestSeasonView_1_5] = ViewName.V1a5_HarvestSeason_FullSignView,
	[ActivityEnum.Activity.V2a2_SpringFestival] = ViewName.V2a2_SpringFestival_FullView,
	[ShortenActConfig.instance:getActivityId()] = ViewName.ShortenAct_FullView,
	[ActivityEnum.Activity.V2a7_Labor_Sign] = ViewName.V2a7_Labor_FullSignView,
	[ActivityEnum.Activity.NoviceSign] = ViewName.ActivityNoviceSignView,
	[ActivityEnum.Activity.NorSign] = ViewName.ActivityNorSignView,
	[ActivityEnum.Activity.NoviceInsight] = ViewName.ActivityNoviceInsightView,
	[ActivityEnum.Activity.StoryShow] = ViewName.ActivityStoryShowView,
	[ActivityEnum.Activity.DreamShow] = ViewName.ActivityDreamShowView,
	[ActivityEnum.Activity.ClassShow] = ViewName.ActivityClassShowView,
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
	[ActivityEnum.Activity.V2a3_NewCultivationGift] = ViewName.VersionActivity2_3NewCultivationGiftView,
	[ActivityEnum.Activity.V2a3_Role_SignView_Part1] = ViewName.V2a3_Role_FullSignView_Part1,
	[ActivityEnum.Activity.V2a3_Role_SignView_Part2] = ViewName.V2a3_Role_FullSignView_Part2,
	[ActivityEnum.Activity.LinkageActivity_FullView] = ViewName.LinkageActivity_FullView,
	[ActivityEnum.Activity.V2a3_WarmUp] = ViewName.V2a3_WarmUp,
	[ActivityEnum.Activity.V2a3_Special] = ViewName.V2a3_Special_FullSignView,
	[ActivityEnum.Activity.V2a4_Blind_Box_Draw] = ViewName.Activity181MainView,
	[ActivityEnum.Activity.V2a4_Role_SignView_Part1] = ViewName.V2a4_Role_FullSignView_Part1,
	[ActivityEnum.Activity.V2a4_Role_SignView_Part2] = ViewName.V2a4_Role_FullSignView_Part2,
	[ActivityEnum.Activity.V2a4_WarmUp] = ViewName.V2a4_WarmUp,
	[ActivityEnum.Activity.V2a5_Role_SignView_Part1] = ViewName.V2a5_Role_FullSignView_Part1,
	[ActivityEnum.Activity.V2a5_Role_SignView_Part2] = ViewName.V2a5_Role_FullSignView_Part2,
	[ActivityEnum.Activity.V2a5_DecaLogPresent] = ViewName.V2a5DecalogPresentFullView,
	[ActivityEnum.Activity.V2a5_DecorateStore] = ViewName.V2a5_DecorateStoreFullView,
	[ActivityEnum.Activity.V2a5_GoldenMilletPresent] = ViewName.V2a5_GoldenMilletPresentFullView,
	[ActivityEnum.Activity.V2a5_WarmUp] = ViewName.V2a5_WarmUp
}
local var_0_2 = {
	[ActivityEnum.ActivityTypeID.Act201] = ViewName.TurnBackFullView,
	[ActivityEnum.ActivityTypeID.OpenTestWarmUp] = ViewName.ActivityWarmUpView,
	[ActivityEnum.ActivityTypeID.DoubleDrop] = ViewName.V1a7_DoubleDropView
}

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_open)
	arg_6_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_6_0._refreshView, arg_6_0)
	arg_6_0:addEventCb(ActivityController.instance, ActivityEvent.SetBannerViewCategoryListInteract, arg_6_0.setCategoryListInteractable, arg_6_0)
	arg_6_0:_initLinkageActivity_FullView()

	arg_6_0._needSetSortInfos = true

	arg_6_0:_refreshView()

	arg_6_0._needSetSortInfos = false
end

function var_0_0._refreshView(arg_7_0)
	local var_7_0 = ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Beginner)

	if not var_7_0 or not next(var_7_0) then
		arg_7_0:closeThis()
	end

	ActivityModel.instance:removeFinishedCategory(var_7_0)

	arg_7_0.data = {}

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		local var_7_1 = {
			id = iter_7_1,
			co = ActivityConfig.instance:getActivityCo(iter_7_1),
			type = ActivityEnum.ActivityType.Beginner
		}

		table.insert(arg_7_0.data, var_7_1)
	end

	if arg_7_0._needSetSortInfos then
		arg_7_0._needSetSortInfos = false

		ActivityBeginnerCategoryListModel.instance:setSortInfos(arg_7_0.data)
		ActivityBeginnerCategoryListModel.instance:checkTargetCategory(arg_7_0.data)
	end

	ActivityBeginnerCategoryListModel.instance:setOpenViewTime()
	ActivityBeginnerCategoryListModel.instance:setCategoryList(arg_7_0.data)
	arg_7_0:_openSubView()
end

function var_0_0._openSubView(arg_8_0)
	if arg_8_0._viewName then
		ViewMgr.instance:closeView(arg_8_0._viewName, true)
	end

	local var_8_0 = ActivityModel.instance:getTargetActivityCategoryId(ActivityEnum.ActivityType.Beginner)

	arg_8_0._viewName = var_0_1[var_8_0]

	if var_8_0 ~= 0 then
		arg_8_0:setCategoryRedDotData(var_8_0)
	end

	if not arg_8_0._viewName then
		local var_8_1 = ActivityConfig.instance:getActivityCo(var_8_0)

		if var_8_1 then
			if var_0_2[var_8_1.typeId] then
				arg_8_0._viewName = var_0_2[var_8_1.typeId]
			end

			arg_8_0.viewContainer:refreshHelp(var_8_1.typeId)
		else
			arg_8_0.viewContainer:hideHelp()

			return
		end
	else
		arg_8_0.viewContainer:hideHelp()
	end

	local var_8_2 = {
		parent = arg_8_0._gosubview,
		actId = var_8_0,
		root = arg_8_0.viewGO
	}

	ViewMgr.instance:openView(arg_8_0._viewName, var_8_2, true)
end

function var_0_0.setCategoryRedDotData(arg_9_0, arg_9_1)
	local var_9_0 = PlayerPrefsKey.FirstEnterActivityShow .. "#" .. tostring(arg_9_1) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

	PlayerPrefsHelper.setString(var_9_0, "hasEnter")

	return var_9_0
end

function var_0_0.closeSubView(arg_10_0)
	if arg_10_0._viewName then
		ViewMgr.instance:closeView(arg_10_0._viewName, true)

		arg_10_0._viewName = nil
	end
end

function var_0_0.onClose(arg_11_0)
	ActivityModel.instance:setTargetActivityCategoryId(0)
	arg_11_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_11_0._refreshView, arg_11_0)
	arg_11_0:removeEventCb(ActivityController.instance, ActivityEvent.SetBannerViewCategoryListInteract, arg_11_0.setCategoryListInteractable, arg_11_0)
	arg_11_0:closeSubView()
	ActivityModel.instance:setTargetActivityCategoryId(0)
	ActivityBeginnerCategoryListModel.instance:clear()
end

function var_0_0.setCategoryListInteractable(arg_12_0, arg_12_1)
	if not arg_12_0._categoryListCanvasGroup then
		arg_12_0._categoryListCanvasGroup = gohelper.onceAddComponent(arg_12_0._gocategory, typeof(UnityEngine.CanvasGroup))
	end

	arg_12_0._categoryListCanvasGroup.interactable = arg_12_1
	arg_12_0._categoryListCanvasGroup.blocksRaycasts = arg_12_1
	arg_12_0._categoryListCanvasGroup.blocksRaycasts = arg_12_1
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

local var_0_3 = false

function var_0_0._initRole_FullSignView(arg_14_0)
	if var_0_3 then
		return
	end

	var_0_3 = true

	local var_14_0 = GameBranchMgr.instance:Vxax_ActId("Role_SignView_Part1", ActivityEnum.Activity.V2a6_Role_SignView_Part1)
	local var_14_1 = GameBranchMgr.instance:Vxax_ViewName("Role_FullSignView_Part1", ViewName.V2a5_Role_FullSignView_Part1)

	var_0_1[var_14_0] = var_14_1

	local var_14_2 = GameBranchMgr.instance:Vxax_ActId("Role_SignView_Part2", ActivityEnum.Activity.V2a6_Role_SignView_Part2)
	local var_14_3 = GameBranchMgr.instance:Vxax_ViewName("Role_FullSignView_Part2", ViewName.V2a5_Role_FullSignView_Part2)

	var_0_1[var_14_2] = var_14_3
end

local var_0_4 = false

function var_0_0._initSpecial_FullSignView(arg_15_0)
	if var_0_4 then
		return
	end

	var_0_4 = true

	local var_15_0 = GameBranchMgr.instance:Vxax_ActId("Special", ActivityEnum.Activity.V2a3_Special)
	local var_15_1 = GameBranchMgr.instance:Vxax_ViewName("Special_FullSignView", ViewName.V2a3_Special_FullSignView)

	var_0_1[var_15_0] = var_15_1
end

local var_0_5 = false

function var_0_0._initLinkageActivity_FullView(arg_16_0)
	if var_0_5 then
		return
	end

	var_0_5 = true

	local var_16_0 = GameBranchMgr.instance:Vxax_ActId("LinkageActivity", ActivityEnum.Activity.V2a7_LinkageActivity)
	local var_16_1 = GameBranchMgr.instance:Vxax_ViewName("LinkageActivity_FullView", ViewName.V2a7_LinkageActivity_FullView)

	var_0_1[var_16_0] = var_16_1
end

return var_0_0
