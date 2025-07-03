module("modules.versionactivitybase.enterview.controller.VersionActivityEnterHelper", package.seeall)

local var_0_0 = class("VersionActivityEnterHelper")

function var_0_0.getTabIndex(arg_1_0, arg_1_1)
	if arg_1_1 and arg_1_1 > 0 then
		for iter_1_0, iter_1_1 in ipairs(arg_1_0) do
			if var_0_0.checkIsSameAct(iter_1_1, arg_1_1) then
				return iter_1_0
			end
		end
	end

	return 1
end

function var_0_0.checkIsSameAct(arg_2_0, arg_2_1)
	if arg_2_0.actType == VersionActivityEnterViewEnum.ActType.Single then
		return arg_2_0.actId == arg_2_1
	end

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.actId) do
		if iter_2_1 == arg_2_1 then
			return true
		end
	end

	return false
end

function var_0_0.getActId(arg_3_0)
	if arg_3_0.actType == VersionActivityEnterViewEnum.ActType.Single then
		return arg_3_0.actId
	end

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.actId) do
		local var_3_0 = ActivityHelper.getActivityStatus(iter_3_1)

		if var_3_0 ~= ActivityEnum.ActivityStatus.Expired and var_3_0 ~= ActivityEnum.ActivityStatus.NotOnLine then
			return iter_3_1
		end
	end

	return arg_3_0.actId[1]
end

function var_0_0.getActIdList(arg_4_0)
	local var_4_0 = {}

	if arg_4_0 then
		for iter_4_0, iter_4_1 in ipairs(arg_4_0) do
			local var_4_1 = var_0_0.getActId(iter_4_1)

			if var_4_1 then
				var_4_0[#var_4_0 + 1] = var_4_1
			end
		end
	end

	return var_4_0
end

local function var_0_1(arg_5_0)
	local var_5_0 = ActivityHelper.getActivityStatus(arg_5_0)

	return var_5_0 == ActivityEnum.ActivityStatus.Expired or var_5_0 == ActivityEnum.ActivityStatus.NotOnLine
end

function var_0_0.isActTabCanRemove(arg_6_0)
	if not arg_6_0 then
		return true
	end

	if arg_6_0.actType == VersionActivityEnterViewEnum.ActType.Single then
		if arg_6_0.storeId then
			if not var_0_1(arg_6_0.actId) then
				return false
			end

			if not var_0_1(arg_6_0.storeId) then
				return false
			end

			return true
		else
			return var_0_1(arg_6_0.actId)
		end
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.actId) do
		if not var_0_1(iter_6_1) then
			return false
		end
	end

	return true
end

function var_0_0.checkCanOpen(arg_7_0)
	local var_7_0 = true
	local var_7_1, var_7_2, var_7_3 = ActivityHelper.getActivityStatusAndToast(arg_7_0)

	if var_7_1 ~= ActivityEnum.ActivityStatus.Normal then
		if var_7_2 then
			GameFacade.showToastWithTableParam(var_7_2, var_7_3)
		end

		var_7_0 = false
	end

	return var_7_0
end

return var_0_0
