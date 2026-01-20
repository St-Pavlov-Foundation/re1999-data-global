-- chunkname: @modules/logic/activity/view/ActivityBeginnerView.lua

module("modules.logic.activity.view.ActivityBeginnerView", package.seeall)

local ActivityBeginnerView = class("ActivityBeginnerView", BaseView)

function ActivityBeginnerView:onInitView()
	self._gocategory = gohelper.findChild(self.viewGO, "#go_category")
	self._scrollitem = gohelper.findChildScrollRect(self.viewGO, "#go_category/#scroll_categoryitem")
	self._gosubview = gohelper.findChild(self.viewGO, "#go_subview")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityBeginnerView:addEvents()
	return
end

function ActivityBeginnerView:removeEvents()
	return
end

function ActivityBeginnerView:_editableInitView()
	return
end

local activitySubViewDict = {
	[ActivityEnum.Activity.GuestBind] = ViewName.ActivityGuestBindView,
	[ActivityEnum.Activity.RoleSignViewPart1] = ViewName.V1a5_Role_FullSignView_Part1,
	[ActivityEnum.Activity.RoleSignViewPart2] = ViewName.V1a5_Role_FullSignView_Part2,
	[VoyageConfig.instance:getActivityId()] = ViewName.ActivityGiftForTheVoyage,
	[ActivityEnum.Activity.HarvestSeasonView_1_5] = ViewName.V1a5_HarvestSeason_FullSignView,
	[ActivityEnum.Activity.V2a2_SpringFestival] = ViewName.V2a2_SpringFestival_FullView,
	[ShortenActConfig.instance:getActivityId()] = ViewName.ShortenAct_FullView,
	[ActivityEnum.Activity.V2a7_Labor_Sign] = ViewName.V2a7_Labor_FullSignView,
	[ActivityEnum.Activity.V3a0_SummerSign] = ViewName.V3a0_SummerSign_FullView,
	[ActivityEnum.Activity.V3a0_WarmUp] = ViewName.V3a0_WarmUp,
	[ActivityEnum.Activity.V3a1_AutumnSign] = ViewName.V3a1_AutumnSign_FullView,
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
	[ActivityEnum.Activity.V2a5_TurnBack_H5] = ViewName.TurnBackInvitationMainView,
	[ActivityEnum.Activity.V2a5_DecaLogPresent] = ViewName.V2a5DecalogPresentFullView,
	[ActivityEnum.Activity.V2a5_DecorateStore] = ViewName.V2a5_DecorateStoreFullView,
	[ActivityEnum.Activity.V2a5_GoldenMilletPresent] = ViewName.V2a5_GoldenMilletPresentFullView,
	[ActivityEnum.Activity.V2a5_WarmUp] = ViewName.V2a5_WarmUp,
	[ShortenActConfig.instance:getActivityId()] = ViewName.ShortenAct_FullView,
	[ActivityEnum.Activity.V2a6_WeekwalkHeart] = ViewName.V2a6_WeekwalkHeart_FullView,
	[ActivityEnum.Activity.V2a6_WarmUp] = ViewName.V2a6_WarmUp,
	[ActivityEnum.Activity.V2a7_Labor_Sign] = ViewName.V2a7_Labor_FullSignView,
	[ActivityEnum.Activity.V2a7_WarmUp] = ViewName.V2a7_WarmUp,
	[ActivityEnum.Activity.V2a7_SelfSelectSix1] = ViewName.V2a7_SelfSelectSix_FullView,
	[ActivityEnum.Activity.V2a7_TowerGift] = ViewName.TowerGiftFullView,
	[ActivityEnum.Activity.V2a9_VersionSummon_Part1] = ViewName.V2a9_VersionSummonFull_Part1,
	[ActivityEnum.Activity.V2a9_VersionSummon_Part2] = ViewName.V2a9_VersionSummonFull_Part2,
	[ActivityEnum.Activity.V2a9_TurnBackH5] = ViewName.TurnBackInvitationMainView,
	[ActivityEnum.Activity.V2a9_FreeMonthCard] = ViewName.V2a9_FreeMonthCard_FullView,
	[ActivityEnum.Activity.V2a9_NewCultivationGift] = ViewName.VersionActivity2_3NewCultivationGiftView,
	[ActivityEnum.Activity.V2a7_SelfSelectSix2] = ViewName.V2a7_SelfSelectSix_FullView,
	[ActivityEnum.Activity.V2a8_Matildagift] = ViewName.V1a9_ActivityShow_MatildagiftView,
	[ActivityEnum.Activity.V2a8_DecaLogPresent] = ViewName.V2a8DecalogPresentFullView,
	[ActivityEnum.Activity.V2a8_NewCultivationDestiny] = ViewName.VersionActivity2_3NewCultivationGiftView,
	[ActivityEnum.Activity.V2a8_DragonBoat] = ViewName.V2a8_DragonBoat_FullView,
	[ActivityEnum.Activity.V2a8_WuErLiXiGift] = ViewName.V2a8_WuErLiXiGiftFullView,
	[ActivityEnum.Activity.V3a0_NewCultivationGift] = ViewName.VersionActivity2_3NewCultivationGiftView,
	[ActivityEnum.Activity.V3a0_SummerSign] = ViewName.V3a0_SummerSign_FullView,
	[ActivityEnum.Activity.V2a9_WarmUp] = ViewName.V2a9_WarmUp,
	[ActivityEnum.Activity.V2a9_Act208] = ViewName.V2a9_Act208MainView,
	[VersionActivity3_1Enum.ActivityId.SurvivalOperAct] = ViewName.SurvivalOperActFullView,
	[VersionActivity3_1Enum.ActivityId.TowerDeep] = ViewName.TowerDeepOperActFullView,
	[BpModel.instance:getCurVersionOperActId()] = ViewName.V3a1_BpOperActShowView,
	[VersionActivity3_1Enum.ActivityId.NationalGift] = ViewName.NationalGiftFullView,
	[ActivityEnum.Activity.V3a1_AutumnSign] = ViewName.V3a1_AutumnSign_FullView,
	[ActivityEnum.Activity.V3a1_NewCultivationDestiny] = ViewName.VersionActivity2_3NewCultivationGiftView,
	[VersionActivity3_2Enum.ActivityId.CruiseTripleDrop] = ViewName.CruiseTripleDropFullView,
	[VersionActivity3_2Enum.ActivityId.ActivityCollect] = ViewName.V3A2ActivityCollectView
}
local actTypeSubViewDict = {
	[ActivityEnum.ActivityTypeID.Act201] = ViewName.TurnBackFullView,
	[ActivityEnum.ActivityTypeID.OpenTestWarmUp] = ViewName.ActivityWarmUpView,
	[ActivityEnum.ActivityTypeID.DoubleDrop] = ViewName.V1a7_DoubleDropView,
	[ActivityEnum.ActivityTypeID.Act171] = ViewName.TurnBackInvitationMainView,
	[ActivityEnum.ActivityTypeID.Act201] = ViewName.TurnBackFullView
}

function ActivityBeginnerView:onUpdateParam()
	return
end

function ActivityBeginnerView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_open)
	self:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, self._refreshView, self)
	self:addEventCb(ActivityController.instance, ActivityEvent.SetBannerViewCategoryListInteract, self.setCategoryListInteractable, self)
	self:_initRole_FullSignView()
	self:_initSpecial_FullSignView()
	self:_initLinkageActivity_FullView()
	self:_initWarmUp()
	self:_initWarmUpH5()
	self:_initSelfSelectCharacter()
	self:_initVersionSummon()
	self:_initCultivationDestiny()

	self._needSetSortInfos = true

	self:_refreshView()

	self._needSetSortInfos = false
end

function ActivityBeginnerView:_refreshView()
	local actCo = ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Beginner)

	if not actCo or not next(actCo) then
		self:closeThis()
	end

	ActivityModel.instance:removeFinishedCategory(actCo)

	self.data = {}

	local isIos = BootNativeUtil.isIOS()

	for _, v in pairs(actCo) do
		if isIos and ActivityEnum.IOSHideActIdMap[tonumber(v)] then
			logNormal("iOS临时屏蔽双端登录活动入口")
		else
			local o = {}

			o.id = v
			o.co = ActivityConfig.instance:getActivityCo(v)
			o.type = ActivityEnum.ActivityType.Beginner

			table.insert(self.data, o)
		end
	end

	if self._needSetSortInfos then
		self._needSetSortInfos = false

		ActivityBeginnerCategoryListModel.instance:setSortInfos(self.data)
		ActivityBeginnerCategoryListModel.instance:checkTargetCategory(self.data)
	end

	ActivityBeginnerCategoryListModel.instance:setOpenViewTime()
	ActivityBeginnerCategoryListModel.instance:setCategoryList(self.data)
	self:_openSubView()
end

function ActivityBeginnerView:_openSubView()
	if self._viewName then
		ViewMgr.instance:closeView(self._viewName, true)
	end

	local actId = ActivityModel.instance:getTargetActivityCategoryId(ActivityEnum.ActivityType.Beginner)

	self._viewName = activitySubViewDict[actId]

	if actId ~= 0 then
		self:setCategoryRedDotData(actId)
	end

	if not self._viewName then
		local co = ActivityConfig.instance:getActivityCo(actId)

		if co then
			if actTypeSubViewDict[co.typeId] then
				self._viewName = actTypeSubViewDict[co.typeId]
			end

			self.viewContainer:refreshHelp(co.typeId)
		else
			self.viewContainer:hideHelp()

			return
		end
	else
		self.viewContainer:hideHelp()
	end

	local viewParam = {
		parent = self._gosubview,
		actId = actId,
		root = self.viewGO
	}

	ViewMgr.instance:openView(self._viewName, viewParam, true)
end

function ActivityBeginnerView:setCategoryRedDotData(actId)
	local key = PlayerPrefsKey.FirstEnterActivityShow .. "#" .. tostring(actId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

	PlayerPrefsHelper.setString(key, "hasEnter")

	return key
end

function ActivityBeginnerView:closeSubView()
	if self._viewName then
		ViewMgr.instance:closeView(self._viewName, true)

		self._viewName = nil
	end
end

function ActivityBeginnerView:onClose()
	ActivityModel.instance:setTargetActivityCategoryId(0)
	self:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, self._refreshView, self)
	self:removeEventCb(ActivityController.instance, ActivityEvent.SetBannerViewCategoryListInteract, self.setCategoryListInteractable, self)
	self:closeSubView()
	ActivityModel.instance:setTargetActivityCategoryId(0)
	ActivityBeginnerCategoryListModel.instance:clear()
end

function ActivityBeginnerView:setCategoryListInteractable(isInteractable)
	if not self._categoryListCanvasGroup then
		self._categoryListCanvasGroup = gohelper.onceAddComponent(self._gocategory, typeof(UnityEngine.CanvasGroup))
	end

	self._categoryListCanvasGroup.interactable = isInteractable
	self._categoryListCanvasGroup.blocksRaycasts = isInteractable
	self._categoryListCanvasGroup.blocksRaycasts = isInteractable
end

function ActivityBeginnerView:onDestroyView()
	return
end

local s_Role_FullSignView = false

function ActivityBeginnerView:_initRole_FullSignView()
	if s_Role_FullSignView then
		return
	end

	s_Role_FullSignView = true

	local roleSignActIdList = ActivityType101Config.instance:getRoleSignActIdList()
	local key1 = GameBranchMgr.instance:Vxax_ActId("Role_SignView_Part1", roleSignActIdList[1])

	if key1 then
		local val1 = GameBranchMgr.instance:Vxax_ViewName("Role_FullSignView_Part1", ViewName.Role_FullSignView_Part1)

		activitySubViewDict[key1] = val1
	end

	local key2 = GameBranchMgr.instance:Vxax_ActId("Role_SignView_Part2", roleSignActIdList[2])

	if key2 then
		local val2 = GameBranchMgr.instance:Vxax_ViewName("Role_FullSignView_Part2", ViewName.Role_FullSignView_Part2)

		activitySubViewDict[key2] = val2
	end
end

local s_Special_FullSignView = false

function ActivityBeginnerView:_initSpecial_FullSignView()
	if s_Special_FullSignView then
		return
	end

	s_Special_FullSignView = true

	local key = GameBranchMgr.instance:Vxax_ActId("Special", ActivityEnum.Activity.V2a3_Special)
	local val = GameBranchMgr.instance:Vxax_ViewName("Special_FullSignView", ViewName.V2a3_Special_FullSignView)

	activitySubViewDict[key] = val
end

local s_LinkageActivity_FullView = false

function ActivityBeginnerView:_initLinkageActivity_FullView()
	if s_LinkageActivity_FullView then
		return
	end

	s_LinkageActivity_FullView = true

	local key = GameBranchMgr.instance:Vxax_ActId("LinkageActivity", ActivityEnum.Activity.LinkageActivity_FullView)
	local val = GameBranchMgr.instance:Vxax_ViewName("LinkageActivity_FullView", ViewName.LinkageActivity_FullView)

	activitySubViewDict[key] = val
end

local s_WarmUp = false

function ActivityBeginnerView:_initWarmUp()
	if s_WarmUp then
		return
	end

	s_WarmUp = true

	local key = GameBranchMgr.instance:Vxax_ActId("WarmUp", ActivityEnum.Activity.V2a8_WarmUp)
	local val = GameBranchMgr.instance:Vxax_ViewName("WarmUp", ViewName.V2a8_WarmUp)

	activitySubViewDict[key] = val
end

local s_WarmUpH5 = false

function ActivityBeginnerView:_initWarmUpH5()
	if s_WarmUpH5 then
		return
	end

	s_WarmUpH5 = true

	local actId = ActivityType100Config.instance:getWarmUpH5ActivityId()

	activitySubViewDict[actId] = ViewName.ActivityWarmUpH5FullView
end

local s_SelfSelectCharacter = false

function ActivityBeginnerView:_initSelfSelectCharacter()
	if s_SelfSelectCharacter then
		return
	end

	s_SelfSelectCharacter = true

	local actId = Activity136Controller.instance:actId()

	activitySubViewDict[actId] = ViewName.Activity136FullView
end

local s_VersionSummon = false

function ActivityBeginnerView:_initVersionSummon()
	if s_VersionSummon then
		return
	end

	s_VersionSummon = true

	local actIdList = ActivityType101Config.instance:getVersionSummonActIdList()
	local key1 = GameBranchMgr.instance:Vxax_ActId("VersionSummon_Part1", actIdList[1])

	if key1 then
		local val1 = GameBranchMgr.instance:Vxax_ViewName("VersionSummon_Part1", ViewName.VersionSummonFull_Part1)

		activitySubViewDict[key1] = val1
	end

	local key2 = GameBranchMgr.instance:Vxax_ActId("VersionSummon_Part2", actIdList[2])

	if key2 then
		local val2 = GameBranchMgr.instance:Vxax_ViewName("VersionSummonFull_Part2", ViewName.VersionSummonFull_Part2)

		activitySubViewDict[key2] = val2
	end
end

local s_CultivationDestiny = false

function ActivityBeginnerView:_initCultivationDestiny()
	if s_CultivationDestiny then
		return
	end

	s_CultivationDestiny = true

	local actId = Activity125Config.instance:getCultivationDestinyActId()

	if not activitySubViewDict[actId] then
		activitySubViewDict[actId] = ViewName.VersionActivity2_3NewCultivationGiftView
	end
end

local s_DoubleDan = false

function ActivityBeginnerView:_initDoubleDan()
	if s_DoubleDan then
		return
	end

	s_DoubleDan = true

	local actId = GameBranchMgr.instance:Vxax_ActId("DoubleDan", ActivityType101Config.instance:getDoubleDanActId())

	if actId then
		local viewName = GameBranchMgr.instance:Vxax_ViewName("DoubleDanActivity_FullView", ViewName.V3a3_DoubleDanActivity_FullView)

		activitySubViewDict[actId] = viewName
	end
end

return ActivityBeginnerView
