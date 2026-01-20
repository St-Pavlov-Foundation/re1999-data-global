-- chunkname: @modules/logic/activity/controller/ActivityController.lua

module("modules.logic.activity.controller.ActivityController", package.seeall)

local ActivityController = class("ActivityController", BaseController)

function ActivityController:onInit()
	self:reInit()
end

function ActivityController:reInit()
	self._getGroupSuccess = false
	self._getActSuccess = false
end

function ActivityController:addConstEvents()
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnGetHeroGroupList, self._onGetHeroGroupSuccess, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function ActivityController:_onGetHeroGroupSuccess()
	self._getGroupSuccess = true

	local seasonId = Activity104Model.instance:getCurSeasonId()

	if self._getActSuccess and ActivityModel.instance:isActOnLine(seasonId) then
		Activity104Rpc.instance:sendGet104InfosRequest(seasonId)
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Season
		})
	end
end

function ActivityController:openActivityNormalView()
	if next(ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Normal)) then
		ViewMgr.instance:openView(ViewName.ActivityNormalView)
	else
		GameFacade.showToast(ToastEnum.ActivityNormalView)
	end
end

function ActivityController:openActivityBeginnerView(param)
	if next(ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Beginner)) then
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.ActivityShow
		}, function()
			ViewMgr.instance:openView(ViewName.ActivityBeginnerView, param)
		end)
	else
		GameFacade.showToast(ToastEnum.ActivityNormalView)
	end
end

function ActivityController:openActivityWelfareView()
	if next(ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Welfare)) then
		ViewMgr.instance:openView(ViewName.ActivityWelfareView)
	else
		GameFacade.showToast(ToastEnum.ActivityNormalView)
	end
end

local kAct101RedList = {
	ActivityEnum.Activity.HarvestSeasonView_1_5,
	ActivityEnum.Activity.V2a2_SpringFestival,
	ActivityEnum.Activity.V3a0_SummerSign,
	ActivityEnum.Activity.NorSign,
	ActivityEnum.Activity.NoviceSign,
	ActivityEnum.Activity.SummerSignPart1_1_2,
	ActivityEnum.Activity.SummerSignPart2_1_2,
	ActivityEnum.Activity.DoubleFestivalSign_1_3,
	ActivityEnum.Activity.StarLightSignPart1_1_3,
	ActivityEnum.Activity.StarLightSignPart2_1_3,
	ActivityEnum.Activity.RoleSignViewPart1_1_5,
	ActivityEnum.Activity.RoleSignViewPart2_1_5,
	ActivityEnum.Activity.DoubleFestivalSign_1_5,
	ActivityEnum.Activity.DecalogPresent,
	ActivityEnum.Activity.GoldenMilletPresent,
	ActivityEnum.Activity.RoleSignViewPart1_1_7,
	ActivityEnum.Activity.RoleSignViewPart2_1_7,
	ActivityEnum.Activity.RoleSignViewPart1_1_8,
	ActivityEnum.Activity.RoleSignViewPart2_1_8,
	ActivityEnum.Activity.Work_SignView_1_8,
	ActivityEnum.Activity.RoleSignViewPart1_1_9,
	ActivityEnum.Activity.RoleSignViewPart2_1_9,
	ActivityEnum.Activity.DragonBoatFestival,
	ActivityEnum.Activity.AnniversarySignView_1_9,
	ActivityEnum.Activity.V2a0_SummerSign,
	ActivityEnum.Activity.V2a0_Role_SignView_Part1,
	ActivityEnum.Activity.V2a0_Role_SignView_Part2,
	ActivityEnum.Activity.V2a1_Role_SignView_Part1,
	ActivityEnum.Activity.V2a1_Role_SignView_Part2,
	ActivityEnum.Activity.V2a1_MoonFestival,
	ActivityEnum.Activity.V2a2_Role_SignView_Part1,
	ActivityEnum.Activity.V2a2_Role_SignView_Part2,
	ActivityEnum.Activity.v2a2_RedLeafFestival,
	ActivityEnum.Activity.V2a3_Role_SignView_Part1,
	ActivityEnum.Activity.V2a3_Role_SignView_Part2,
	ActivityEnum.Activity.LinkageActivity_FullView,
	ActivityEnum.Activity.V2a3_Special,
	ActivityEnum.Activity.V2a4_Role_SignView_Part1,
	ActivityEnum.Activity.V2a4_Role_SignView_Part2,
	ActivityEnum.Activity.V2a5_Role_SignView_Part1,
	ActivityEnum.Activity.V2a5_Role_SignView_Part2,
	ActivityEnum.Activity.V2a5_DecorateStore,
	ActivityEnum.Activity.V2a5_Act186Sign,
	ActivityEnum.Activity.V2a7_Labor_Sign,
	ActivityEnum.Activity.V2a7_SelfSelectSix1,
	ActivityEnum.Activity.V2a7_SelfSelectSix2,
	ActivityEnum.Activity.V2a8_DragonBoat,
	ActivityEnum.Activity.V2a8_WuErLiXiGift,
	ActivityEnum.Activity.V2a9_VersionSummon_Part1,
	ActivityEnum.Activity.V2a9_VersionSummon_Part2,
	ActivityEnum.Activity.V2a9_FreeMonthCard,
	ActivityEnum.Activity.V3a0_SummerSign,
	ActivityEnum.Activity.V3a1_AutumnSign,
	ActivityEnum.Activity.V3a2_ActivityCollect
}
local kAct125List = {
	ActivityEnum.Activity.V3a0_WarmUp,
	ActivityEnum.Activity.VersionActivity1_3Radio,
	ActivityEnum.Activity.Activity1_6WarmUp,
	ActivityEnum.Activity.Activity1_7WarmUp,
	ActivityEnum.Activity.Activity1_8WarmUp,
	ActivityEnum.Activity.Activity1_9WarmUp,
	ActivityEnum.Activity.V2a0_WarmUp,
	ActivityEnum.Activity.V2a1_WarmUp,
	ActivityEnum.Activity.RoomSign,
	ActivityEnum.Activity.V2a3_WarmUp,
	ActivityEnum.Activity.V2a4_WarmUp,
	ActivityEnum.Activity.V2a5_WarmUp,
	ActivityEnum.Activity.V2a7_WarmUp
}

function ActivityController:checkGetActivityInfo()
	local COListAct125 = ActivityConfig.instance:typeId2ActivityCOList(ActivityEnum.ActivityTypeID.Act125)

	for _, CO in ipairs(COListAct125) do
		local actId = CO.id

		Activity125Controller.instance:getAct125InfoFromServer(actId)
	end

	if ActivityModel.instance:isActOnLine(ActivityEnum.Activity.Activity1_5WarmUp) then
		Activity146Controller.instance:getAct146InfoFromServer(ActivityEnum.Activity.Activity1_5WarmUp)
	end

	self._getActSuccess = true

	local seasonId = Activity104Model.instance:getCurSeasonId()

	if self._getGroupSuccess and ActivityModel.instance:isActOnLine(seasonId) then
		Activity104Rpc.instance:sendGet104InfosRequest(seasonId)
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Season
		})
	end

	if ActivityModel.instance:isActOnLine(VersionActivityEnum.ActivityId.Act109) then
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Activity109
		})
	end

	if ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NewWelfare) then
		Activity160Rpc.instance:sendGetAct160InfoRequest(ActivityEnum.Activity.NewWelfare)
	end

	if ActivityModel.instance:isActOnLine(ActivityEnum.Activity.V2a7_NewInsight) then
		Activity172Rpc.instance:sendGetAct172InfoRequest(ActivityEnum.Activity.V2a7_NewInsight)
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Tower) then
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Tower
		})
	end

	self:requestAct186Info()
	self:requestAct165Info()
	self:requestRouge2Info()
end

function ActivityController:requestAct186Info()
	local act186Id = Activity186Model.instance:getActId()

	if act186Id and ActivityModel.instance:isActOnLine(act186Id) then
		Activity186Rpc.instance:sendGetAct186InfoRequest(act186Id)
	end

	if ActivityModel.instance:isActOnLine(ActivityEnum.Activity.V2a5_Act186Sign) and act186Id then
		Activity101Rpc.instance:sendGetAct186SpBonusInfoRequest(ActivityEnum.Activity.V2a5_Act186Sign, act186Id)
	end
end

function ActivityController:requestRouge2Info()
	if not Rouge2_Controller:isFirstGetInfo() and Rouge2_Controller.instance:checkIsOpen(false) then
		Rouge2OutsideRpc.instance:sendGetRouge2OutsideInfoRequest()
		Rouge2OutsideRpc.instance:sendRouge2GetUnlockCollectionsRequest()
		Rouge2_Rpc.instance:sendGetRouge2InfoRequest()
	end
end

function ActivityController:updateAct101Infos(targetActId)
	self:_initRoleSign_kAct101RedList()
	self:_initSpecialSign_kAct101RedList()
	self:_initLinkageActivity_kAct101RedList()
	self:_initVersionSummon_kAct101RedList()

	if not targetActId then
		for _, actId in ipairs(kAct101RedList) do
			if ActivityType101Model.instance:isOpen(actId) then
				Activity101Rpc.instance:sendGet101InfosRequest(actId)
			end
		end

		return
	end

	for _, actId in ipairs(kAct101RedList) do
		if targetActId == actId then
			Activity101Rpc.instance:sendGet101InfosRequest(actId)

			return
		end
	end
end

function ActivityController:_onDailyRefresh()
	self:updateAct101Infos()
end

local s_RoleSign = false

function ActivityController:_initRoleSign_kAct101RedList()
	if s_RoleSign then
		return
	end

	s_RoleSign = true

	local roleSignActIdList = ActivityType101Config.instance:getRoleSignActIdList()

	for _, actId in ipairs(roleSignActIdList) do
		table.insert(kAct101RedList, actId)
	end
end

function ActivityController:onModuleViews(versionFullInfo, module_views)
	ActivityType101Model.instance:onModuleViews(versionFullInfo, module_views)
end

local s_SpecialSign = false

function ActivityController:_initSpecialSign_kAct101RedList()
	if s_SpecialSign then
		return
	end

	s_SpecialSign = true

	local actId = GameBranchMgr.instance:Vxax_ActId("Special", ActivityEnum.Activity.V2a3_Special)

	table.insert(kAct101RedList, actId)
end

local s_LinkageActivity = false

function ActivityController:_initLinkageActivity_kAct101RedList()
	if s_LinkageActivity then
		return
	end

	s_LinkageActivity = true

	local actId = GameBranchMgr.instance:Vxax_ActId("LinkageActivity", ActivityEnum.Activity.LinkageActivity_FullView)

	table.insert(kAct101RedList, actId)
end

function ActivityController:requestAct165Info()
	Activity165Model.instance:onInitInfo()
end

local s_VersionSummon = false

function ActivityController:_initVersionSummon_kAct101RedList()
	if s_VersionSummon then
		return
	end

	s_VersionSummon = true

	local actIdList = ActivityType101Config.instance:getVersionSummonActIdList()

	for _, actId in ipairs(actIdList) do
		table.insert(kAct101RedList, actId)
	end
end

local s_DoubleDan = false

function ActivityController:_initDoubleDan_kAct101RedList()
	if s_DoubleDan then
		return
	end

	s_DoubleDan = true

	local actId = GameBranchMgr.instance:Vxax_ActId("DoubleDan", ActivityType101Config.instance:getDoubleDanActId())

	if actId then
		table.insert(kAct101RedList, actId)
	end
end

ActivityController.instance = ActivityController.New()

return ActivityController
