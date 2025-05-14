module("modules.common.activity.ActivityStageHelper", package.seeall)

local var_0_0 = class("ActivityStageHelper")
local var_0_1 = {}
local var_0_2 = false

function var_0_0.initActivityStage()
	var_0_2 = true

	local var_1_0 = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityStageKey), "")

	if not string.nilorempty(var_1_0) then
		local var_1_1 = string.split(var_1_0, ";")
		local var_1_2

		for iter_1_0, iter_1_1 in ipairs(var_1_1) do
			if not string.nilorempty(iter_1_1) then
				local var_1_3 = string.splitToNumber(iter_1_1, "#")

				var_0_1[var_1_3[1]] = var_1_3
			end
		end
	end
end

function var_0_0.checkActivityStageHasChange(arg_2_0)
	if not var_0_2 then
		var_0_0.initActivityStage()
	end

	for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
		if var_0_0.checkOneActivityStageHasChange(iter_2_1) then
			return true
		end
	end
end

function var_0_0.checkOneActivityStageHasChange(arg_3_0)
	if not var_0_2 then
		var_0_0.initActivityStage()
	end

	if ActivityHelper.getActivityStatus(arg_3_0) ~= ActivityEnum.ActivityStatus.Normal then
		return false
	end

	local var_3_0 = var_0_1[arg_3_0]

	if not var_3_0 then
		return true
	end

	local var_3_1 = ActivityModel.instance:getActivityInfo()[arg_3_0]

	if not var_3_1 then
		return false
	end

	local var_3_2 = var_3_1:isOpen() and 1 or 0
	local var_3_3 = var_3_1:getCurrentStage()
	local var_3_4 = var_3_1:isUnlock() and 1 or 0

	return var_3_0[2] ~= var_3_2 or var_3_0[3] ~= var_3_3 or var_3_0[4] ~= var_3_4
end

function var_0_0.recordActivityStage(arg_4_0)
	if not var_0_2 then
		var_0_0.initActivityStage()
	end

	for iter_4_0, iter_4_1 in ipairs(arg_4_0) do
		var_0_0.recordOneActivityStage(iter_4_1)
	end
end

function var_0_0.recordOneActivityStage(arg_5_0)
	if not var_0_2 then
		var_0_0.initActivityStage()
	end

	if not var_0_0.checkOneActivityStageHasChange(arg_5_0) then
		return
	end

	local var_5_0 = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityStageKey), "")
	local var_5_1 = false
	local var_5_2 = {}
	local var_5_3 = string.split(var_5_0, ";")
	local var_5_4
	local var_5_5

	for iter_5_0, iter_5_1 in ipairs(var_5_3) do
		if not string.nilorempty(iter_5_1) then
			local var_5_6 = string.splitToNumber(iter_5_1, "#")

			if var_5_6 and var_5_6[1] == arg_5_0 then
				var_5_1 = true
				var_5_5 = var_0_0._buildActPlayerPrefsString(arg_5_0)

				table.insert(var_5_2, var_5_5)
			else
				table.insert(var_5_2, iter_5_1)
			end
		end
	end

	if not var_5_1 then
		var_5_5 = var_0_0._buildActPlayerPrefsString(arg_5_0)

		table.insert(var_5_2, var_5_5)
	end

	var_0_1[arg_5_0] = string.splitToNumber(var_5_5, "#")

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityStageKey), table.concat(var_5_2, ";"))
	ActivityController.instance:dispatchEvent(ActivityEvent.ChangeActivityStage)
end

function var_0_0._buildActPlayerPrefsString(arg_6_0)
	local var_6_0 = ActivityModel.instance:getActivityInfo()[arg_6_0]

	if not var_6_0 then
		return
	end

	return string.format("%s#%s#%s#%s", arg_6_0, var_6_0:isOpen() and 1 or 0, var_6_0:getCurrentStage(), var_6_0:isUnlock() and 1 or 0)
end

function var_0_0.clear()
	var_0_1 = {}
	var_0_2 = false
end

return var_0_0
