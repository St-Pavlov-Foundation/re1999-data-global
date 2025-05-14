module("modules.logic.versionactivity1_4.act132.model.Activity132ClueMo", package.seeall)

local var_0_0 = class("Activity132ClueMo")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.activityId = arg_1_1.activityId
	arg_1_0.clueId = arg_1_1.clueId
	arg_1_0.name = arg_1_1.name
	arg_1_0.contentDict = {}

	local var_1_0 = string.splitToNumber(arg_1_1.pos, "#")

	arg_1_0.posX = var_1_0[1] or 0
	arg_1_0.posY = var_1_0[2] or 0

	local var_1_1 = string.splitToNumber(arg_1_1.contents, "#")

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		local var_1_2 = Activity132Config.instance:getContentConfig(arg_1_0.activityId, iter_1_1)

		if var_1_2 then
			arg_1_0.contentDict[iter_1_1] = Activity132ContentMo.New(var_1_2)
		end
	end

	arg_1_0._cfg = arg_1_1
end

function var_0_0.getContentList(arg_2_0)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_0.contentDict) do
		table.insert(var_2_0, iter_2_1)
	end

	if #var_2_0 > 1 then
		table.sort(var_2_0, SortUtil.keyLower("contentId"))
	end

	return var_2_0
end

function var_0_0.getPos(arg_3_0)
	return arg_3_0.posX, arg_3_0.posY
end

function var_0_0.getName(arg_4_0)
	return arg_4_0._cfg.name
end

return var_0_0
