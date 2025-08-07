module("modules.logic.sp01.act204.model.Activity204TaskListModel", package.seeall)

local var_0_0 = class("Activity204TaskListModel", MixScrollModel)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._activityId = arg_1_1
end

function var_0_0.refresh(arg_2_0)
	local var_2_0 = Activity204Model.instance:getById(arg_2_0._activityId)

	if not var_2_0 then
		return
	end

	arg_2_0._nextRefreshTime = nil

	local var_2_1 = var_2_0:getTaskList()
	local var_2_2 = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_1) do
		local var_2_3 = iter_2_1.config

		if var_2_3 then
			if not string.nilorempty(var_2_3.prepose) then
				local var_2_4 = true
				local var_2_5 = string.splitToNumber(var_2_3.prepose, "#")

				for iter_2_2, iter_2_3 in ipairs(var_2_5) do
					local var_2_6 = var_2_0:getTaskInfo(iter_2_3)

					if not var_2_6 or not var_2_6.hasGetBonus then
						var_2_4 = false

						break
					end
				end

				if var_2_4 then
					table.insert(var_2_2, iter_2_1)
				end
			else
				table.insert(var_2_2, iter_2_1)
			end

			arg_2_0:_updateNextRefreshTime(iter_2_1)
		end
	end

	if #var_2_2 > 1 then
		table.sort(var_2_2, SortUtil.tableKeyLower({
			"status",
			"missionorder",
			"id"
		}))
	end

	for iter_2_4, iter_2_5 in ipairs(var_2_2) do
		iter_2_5.index = iter_2_4
	end

	arg_2_0:setList(var_2_2)
end

function var_0_0._updateNextRefreshTime(arg_3_0, arg_3_1)
	if not arg_3_1 or not arg_3_1.config or arg_3_1.hasGetBonus then
		return
	end

	if arg_3_1.config.durationHour == 0 then
		return
	end

	if not arg_3_1.expireTime or arg_3_1.expireTime <= ServerTime.now() then
		return
	end

	if not arg_3_0._nextRefreshTime or arg_3_1.expireTime < arg_3_0._nextRefreshTime then
		arg_3_0._nextRefreshTime = arg_3_1.expireTime
	end
end

function var_0_0.getNextRefreshTime(arg_4_0)
	return arg_4_0._nextRefreshTime
end

var_0_0.instance = var_0_0.New()

return var_0_0
