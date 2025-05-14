module("modules.logic.versionactivity2_5.act186.model.Activity186TaskListModel", package.seeall)

local var_0_0 = class("Activity186TaskListModel", MixScrollModel)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._activityId = arg_1_1
end

function var_0_0.refresh(arg_2_0)
	local var_2_0 = Activity186Model.instance:getById(arg_2_0._activityId)

	if not var_2_0 then
		return
	end

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

var_0_0.instance = var_0_0.New()

return var_0_0
