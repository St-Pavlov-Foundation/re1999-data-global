module("modules.logic.story.model.StoryBgZoneModel", package.seeall)

local var_0_0 = class("StoryBgZoneModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._zoneList = {}
end

function var_0_0.setZoneList(arg_2_0, arg_2_1)
	arg_2_0._zoneList = {}

	if arg_2_1 then
		for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
			local var_2_0 = StoryBgZoneMo.New()

			var_2_0:init(iter_2_1)
			table.insert(arg_2_0._zoneList, var_2_0)
		end
	end

	arg_2_0:setList(arg_2_0._zoneList)
end

function var_0_0.getZoneList(arg_3_0)
	return arg_3_0._zoneList
end

function var_0_0.getBgZoneByPath(arg_4_0, arg_4_1)
	local var_4_0 = string.gsub(arg_4_1, "_zone", "")
	local var_4_1 = string.gsub(var_4_0, ".png", "")
	local var_4_2 = string.gsub(var_4_1, ".jpg", "") .. "_zone.png"

	for iter_4_0, iter_4_1 in pairs(arg_4_0._zoneList) do
		if iter_4_1.path == var_4_2 then
			return iter_4_1
		end
	end

	return nil
end

function var_0_0.getRightBgZonePath(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getBgZoneByPath(arg_5_1)

	if var_5_0 then
		return var_5_0.path
	end

	return arg_5_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
