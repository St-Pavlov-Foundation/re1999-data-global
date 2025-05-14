module("modules.logic.versionactivity1_3.armpipe.model.Activity124RewardListModel", package.seeall)

local var_0_0 = class("Activity124RewardListModel", ListScrollModel)

function var_0_0.init(arg_1_0, arg_1_1)
	local var_1_0 = {}
	local var_1_1 = Activity124Config.instance:getEpisodeList(arg_1_1)

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		local var_1_2 = Activity124RewardMO.New()

		var_1_2:init(iter_1_1)
		table.insert(var_1_0, var_1_2)
	end

	table.sort(var_1_0, var_0_0.sortMO)
	arg_1_0:setList(var_1_0)
end

function var_0_0.sortMO(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:isHasReard()

	if var_2_0 ~= arg_2_1:isHasReard() then
		return var_2_0
	end

	local var_2_1 = arg_2_0:isReceived()
	local var_2_2 = arg_2_1:isReceived()

	if var_2_1 ~= var_2_2 then
		return var_2_2
	end

	if arg_2_0.id ~= arg_2_1.id then
		return arg_2_0.id < arg_2_1.id
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
