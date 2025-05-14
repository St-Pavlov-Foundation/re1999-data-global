module("modules.logic.activity.controller.ActivityController", package.seeall)

local var_0_0 = class("ActivityController", BaseController)
local var_0_1 = string.format

function var_0_0.onInit(arg_1_0)
	arg_1_0._versionInfo = {}

	arg_1_0:_getLatestVersion(arg_1_0._versionInfo)

	if isDebugBuild then
		local var_1_0 = var_0_1("<color=#FFFF00>[ActivityController] 当前版本: %s</color>", arg_1_0:getV_a())

		logNormal(var_1_0)
	end

	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._getGroupSuccess = false
	arg_2_0._getActSuccess = false
end

function var_0_0.addConstEvents(arg_3_0)
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnGetHeroGroupList, arg_3_0._onGetHeroGroupSuccess, arg_3_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_3_0._onDailyRefresh, arg_3_0)
end

function var_0_0._onGetHeroGroupSuccess(arg_4_0)
	arg_4_0._getGroupSuccess = true

	local var_4_0 = Activity104Model.instance:getCurSeasonId()

	if arg_4_0._getActSuccess and ActivityModel.instance:isActOnLine(var_4_0) then
		Activity104Rpc.instance:sendGet104InfosRequest(var_4_0)
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Season
		})
	end
end

function var_0_0.openActivityNormalView(arg_5_0)
	if next(ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Normal)) then
		ViewMgr.instance:openView(ViewName.ActivityNormalView)
	else
		GameFacade.showToast(ToastEnum.ActivityNormalView)
	end
end

function var_0_0.openActivityBeginnerView(arg_6_0, arg_6_1)
	if next(ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Beginner)) then
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.ActivityShow
		}, function()
			ViewMgr.instance:openView(ViewName.ActivityBeginnerView, arg_6_1)
		end)
	else
		GameFacade.showToast(ToastEnum.ActivityNormalView)
	end
end

function var_0_0.openActivityWelfareView(arg_8_0)
	if next(ActivityModel.instance:getCenterActivities(ActivityEnum.ActivityType.Welfare)) then
		ViewMgr.instance:openView(ViewName.ActivityWelfareView)
	else
		GameFacade.showToast(ToastEnum.ActivityNormalView)
	end
end

local var_0_2 = {
	ActivityEnum.Activity.HarvestSeasonView_1_5,
	ActivityEnum.Activity.V2a0_SummerSign,
	ActivityEnum.Activity.V2a1_MoonFestival,
	ActivityEnum.Activity.LinkageActivity_FullView,
	ActivityEnum.Activity.V2a2_SpringFestival,
	ActivityEnum.Activity.V2a7_Labor_Sign,
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
	ActivityEnum.Activity.V2a5_Act186Sign
}
local var_0_3 = {
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
	ActivityEnum.Activity.V2a5_WarmUp
}

function var_0_0.checkGetActivityInfo(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(var_0_3) do
		Activity125Controller.instance:getAct125InfoFromServer(iter_9_1)
	end

	if ActivityModel.instance:isActOnLine(ActivityEnum.Activity.Activity1_5WarmUp) then
		Activity146Controller.instance:getAct146InfoFromServer(ActivityEnum.Activity.Activity1_5WarmUp)
	end

	arg_9_0._getActSuccess = true

	local var_9_0 = Activity104Model.instance:getCurSeasonId()

	if arg_9_0._getGroupSuccess and ActivityModel.instance:isActOnLine(var_9_0) then
		Activity104Rpc.instance:sendGet104InfosRequest(var_9_0)
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

	if ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NewInsight) then
		Activity172Rpc.instance:sendGetAct172InfoRequest(ActivityEnum.Activity.NewInsight)
	end

	if ActivityModel.instance:isActOnLine(ActivityEnum.Activity.V2a3_NewInsight) then
		Activity172Rpc.instance:sendGetAct172InfoRequest(ActivityEnum.Activity.V2a3_NewInsight)
	end

	if ActivityModel.instance:isActOnLine(ActivityEnum.Activity.V2a4_NewInsight) then
		Activity172Rpc.instance:sendGetAct172InfoRequest(ActivityEnum.Activity.V2a4_NewInsight)
	end

	if ActivityModel.instance:isActOnLine(ActivityEnum.Activity.V2a5_NewInsight) then
		Activity172Rpc.instance:sendGetAct172InfoRequest(ActivityEnum.Activity.V2a5_NewInsight)
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Tower) then
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Tower
		})
	end

	arg_9_0:requestAct186Info()
end

function var_0_0.requestAct186Info(arg_10_0)
	local var_10_0 = Activity186Model.instance:getActId()

	if var_10_0 and ActivityModel.instance:isActOnLine(var_10_0) then
		Activity186Rpc.instance:sendGetAct186InfoRequest(var_10_0)
	end

	if ActivityModel.instance:isActOnLine(ActivityEnum.Activity.V2a5_Act186Sign) and var_10_0 then
		Activity101Rpc.instance:sendGetAct186SpBonusInfoRequest(ActivityEnum.Activity.V2a5_Act186Sign, var_10_0)
	end
end

function var_0_0.updateAct101Infos(arg_11_0, arg_11_1)
	arg_11_0:_initLinkageActivity_kAct101RedList()

	if not arg_11_1 then
		for iter_11_0, iter_11_1 in ipairs(var_0_2) do
			if ActivityType101Model.instance:isOpen(iter_11_1) then
				Activity101Rpc.instance:sendGet101InfosRequest(iter_11_1)
			end
		end

		return
	end

	for iter_11_2, iter_11_3 in ipairs(var_0_2) do
		if arg_11_1 == iter_11_3 then
			Activity101Rpc.instance:sendGet101InfosRequest(iter_11_3)

			return
		end
	end
end

function var_0_0._onDailyRefresh(arg_12_0)
	arg_12_0:updateAct101Infos()
end

function var_0_0._getLatestVersion(arg_13_0, arg_13_1)
	local var_13_0 = "AudioEnum%s_%s"
	local var_13_1 = 1
	local var_13_2 = 5

	arg_13_1.V = var_13_1
	arg_13_1.A = var_13_2

	while var_13_1 < math.huge do
		while var_13_2 < 10 do
			local var_13_3 = var_0_1(var_13_0, var_13_1, var_13_2)
			local var_13_4 = _G[var_13_3]

			if not var_13_4 then
				local var_13_5 = var_13_2

				while var_13_2 < 10 do
					var_13_2 = var_13_2 + 1

					local var_13_6 = var_0_1(var_13_0, var_13_1, var_13_2)

					var_13_4 = _G[var_13_6]

					if var_13_4 then
						break
					end
				end

				if var_13_5 == 0 and not var_13_4 then
					return
				end

				if var_13_2 >= 10 then
					break
				end
			end

			if var_13_2 == 0 and not var_13_4 then
				return
			elseif not var_13_4 then
				break
			end

			arg_13_1.V = var_13_1
			arg_13_1.A = var_13_2
			var_13_2 = var_13_2 + 1
		end

		var_13_1 = var_13_1 + 1
		var_13_2 = 0
	end
end

function var_0_0.getMajorVer(arg_14_0)
	return arg_14_0._versionInfo.V
end

function var_0_0.getMinorVer(arg_15_0)
	return arg_15_0._versionInfo.A
end

function var_0_0.getVxax_(arg_16_0)
	return "V" .. arg_16_0:getMajorVer() .. "a" .. arg_16_0:getMinorVer() .. "_"
end

function var_0_0.getV_a(arg_17_0)
	return arg_17_0:getMajorVer() .. "_" .. arg_17_0:getMinorVer()
end

function var_0_0.Vxax_(arg_18_0, arg_18_1)
	return arg_18_0:getVxax_() .. arg_18_1
end

function var_0_0.V_a(arg_19_0, arg_19_1, arg_19_2)
	arg_19_1 = arg_19_1 or ""
	arg_19_2 = arg_19_2 or ""

	return arg_19_1 .. arg_19_0:getV_a() .. arg_19_2
end

function var_0_0.Vxax_ActId(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0:Vxax_(arg_20_1)

	return ActivityEnum.Activity[var_20_0] or arg_20_2
end

local var_0_4 = false

function var_0_0._initRoleSign_kAct101RedList(arg_21_0)
	if var_0_4 then
		return
	end

	var_0_4 = true

	local var_21_0 = GameBranchMgr.instance:Vxax_ActId("Role_SignView_Part1", ActivityEnum.Activity.V2a6_Role_SignView_Part1)
	local var_21_1 = GameBranchMgr.instance:Vxax_ActId("Role_SignView_Part2", ActivityEnum.Activity.V2a6_Role_SignView_Part2)

	table.insert(var_0_2, var_21_0)
	table.insert(var_0_2, var_21_1)
end

function var_0_0.onModuleViews(arg_22_0, arg_22_1, arg_22_2)
	ActivityType101Model.instance:onModuleViews(arg_22_1, arg_22_2)
end

local var_0_5 = false

function var_0_0._initSpecialSign_kAct101RedList(arg_23_0)
	if var_0_5 then
		return
	end

	var_0_5 = true

	local var_23_0 = GameBranchMgr.instance:Vxax_ActId("Special", ActivityEnum.Activity.V2a3_Special)

	table.insert(var_0_2, var_23_0)
end

local var_0_6 = false

function var_0_0._initLinkageActivity_kAct101RedList(arg_24_0)
	if var_0_6 then
		return
	end

	var_0_6 = true

	local var_24_0 = GameBranchMgr.instance:Vxax_ActId("LinkageActivity", ActivityEnum.Activity.V2a7_LinkageActivity)

	table.insert(var_0_2, var_24_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
