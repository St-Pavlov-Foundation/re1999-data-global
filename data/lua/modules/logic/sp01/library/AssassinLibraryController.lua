module("modules.logic.sp01.library.AssassinLibraryController", package.seeall)

local var_0_0 = class("AssassinLibraryController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._waitLibraryIdList = {}
	arg_1_0._waitLibraryIdMap = {}
	arg_1_0._toastLibraryIdMap = {}
	arg_1_0._isEnableToast = true
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.addConstEvents(arg_3_0)
	arg_3_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_3_0._onOpenViewFinish, arg_3_0)
	arg_3_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
	arg_3_0:addEventCb(AssassinController.instance, AssassinEvent.EnableLibraryToast, arg_3_0._onEnableLibraryToast, arg_3_0)
end

function var_0_0._onOpenViewFinish(arg_4_0, arg_4_1)
	arg_4_0:tryToast()
end

function var_0_0._onCloseViewFinish(arg_5_0, arg_5_1)
	arg_5_0:tryToast()
end

function var_0_0.tryToast(arg_6_0)
	if not arg_6_0:checkCanToast() then
		return
	end

	local var_6_0 = arg_6_0._waitLibraryIdList and #arg_6_0._waitLibraryIdList or 0

	if var_6_0 <= 0 then
		return
	end

	local var_6_1 = {}
	local var_6_2 = {}

	for iter_6_0 = var_6_0, 1, -1 do
		local var_6_3 = arg_6_0._waitLibraryIdList[iter_6_0]
		local var_6_4 = AssassinConfig.instance:getLibrarConfig(var_6_3)

		if var_6_4.activityId == VersionActivity2_9Enum.ActivityId.Outside then
			table.insert(var_6_1, 1, var_6_3)
		elseif var_6_4.activityId == VersionActivity2_9Enum.ActivityId.Dungeon2 then
			table.insert(var_6_2, 1, var_6_3)
		else
			logError(string.format("资料库飘字未定义行为 libraryId = %s", var_6_3))
		end

		arg_6_0:onLibraryToast(var_6_3)
	end

	if #var_6_2 > 0 then
		ViewMgr.instance:openView(ViewName.OdysseyLibraryToastView, var_6_2)

		for iter_6_1, iter_6_2 in ipairs(var_6_2) do
			if OdysseyConfig.instance:checkIsOptionDataBase(iter_6_2) then
				AssassinController.instance:openAssassinLibraryDetailView(iter_6_2)

				break
			end
		end
	end

	if #var_6_1 > 0 then
		ViewMgr.instance:openView(ViewName.AssassinLibraryToastView, var_6_1)
	end
end

function var_0_0.checkCanToast(arg_7_0)
	if not arg_7_0._isEnableToast then
		return
	end

	arg_7_0:_buildForbidenViewNameMap()

	local var_7_0 = ViewMgr.instance:getOpenViewNameList()

	for iter_7_0 = #var_7_0, 1, -1 do
		local var_7_1 = var_7_0[iter_7_0]

		if arg_7_0._fobidenViewNameMap[var_7_1] then
			return false
		end

		return true
	end

	return true
end

function var_0_0._buildForbidenViewNameMap(arg_8_0)
	if not arg_8_0._fobidenViewNameMap then
		arg_8_0._fobidenViewNameMap = {}
	end
end

function var_0_0.addNeedToastLibraryIds(arg_9_0, arg_9_1)
	arg_9_0._toastLibraryIdMap = arg_9_0._toastLibraryIdMap or {}
	arg_9_0._waitLibraryIdList = arg_9_0._waitLibraryIdList or {}
	arg_9_0._waitLibraryIdMap = arg_9_0._waitLibraryIdMap or {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if not arg_9_0._waitLibraryIdMap[iter_9_1] and not arg_9_0._toastLibraryIdMap[iter_9_1] then
			arg_9_0._waitLibraryIdMap[iter_9_1] = true

			table.insert(arg_9_0._waitLibraryIdList, iter_9_1)
		end
	end

	arg_9_0:tryToast()
end

function var_0_0.onLibraryToast(arg_10_0, arg_10_1)
	if not arg_10_0._waitLibraryIdMap[arg_10_1] then
		return
	end

	arg_10_0._toastLibraryIdMap[arg_10_1] = true
	arg_10_0._waitLibraryIdMap[arg_10_1] = nil

	tabletool.removeValue(arg_10_0._waitLibraryIdList, arg_10_1)
end

function var_0_0.onUnlockLibraryIds(arg_11_0, arg_11_1)
	arg_11_0:addNeedToastLibraryIds(arg_11_1)
	AssassinLibraryModel.instance:updateLibraryInfos(arg_11_1)
	AssassinController.instance:dispatchEvent(AssassinEvent.OnUnlockLibrarys, arg_11_1)
	AssassinController.instance:dispatchEvent(AssassinEvent.UpdateLibraryReddot)
end

function var_0_0._onEnableLibraryToast(arg_12_0, arg_12_1)
	arg_12_0._isEnableToast = arg_12_1

	if arg_12_1 then
		arg_12_0:tryToast()
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
