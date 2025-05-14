module("modules.logic.versionactivity1_6.act152.model.Activity152Model", package.seeall)

local var_0_0 = class("Activity152Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._act152Presents = {}
end

function var_0_0.setActivity152Infos(arg_3_0, arg_3_1)
	arg_3_0._act152Presents = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		table.insert(arg_3_0._act152Presents, iter_3_1)
	end
end

function var_0_0.setActivity152PresentGet(arg_4_0, arg_4_1)
	table.insert(arg_4_0._act152Presents, arg_4_1)
end

function var_0_0.getActivity152Presents(arg_5_0)
	return arg_5_0._act152Presents
end

function var_0_0.isPresentAccepted(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_0._act152Presents) do
		if iter_6_1 == arg_6_1 then
			return true
		end
	end

	local var_6_0 = AntiqueModel.instance:getAntiqueList()
	local var_6_1 = Activity152Config.instance:getAct152Co(arg_6_1)
	local var_6_2 = string.split(var_6_1.bonus, "|")

	for iter_6_2, iter_6_3 in ipairs(var_6_2) do
		local var_6_3 = string.splitToNumber(iter_6_3, "#")

		if var_6_3[1] == MaterialEnum.MaterialType.Antique and var_6_3[2] == arg_6_1 then
			return true
		end
	end

	return false
end

function var_0_0.getPresentUnaccepted(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = arg_7_0:getAllUnlockPresents()

	for iter_7_0, iter_7_1 in pairs(var_7_1) do
		if not arg_7_0:isPresentAccepted(iter_7_1) then
			table.insert(var_7_0, iter_7_1)
		end
	end

	return var_7_0
end

function var_0_0.getAllUnlockPresents(arg_8_0)
	local var_8_0 = Activity152Config.instance:getAct152Cos()
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		if TimeUtil.stringToTimestamp(iter_8_1.acceptDate) <= ServerTime.now() then
			table.insert(var_8_1, iter_8_1.presentId)
		end
	end

	return var_8_1
end

function var_0_0.hasPresentAccepted(arg_9_0)
	local var_9_0 = arg_9_0:getAllUnlockPresents()

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		if arg_9_0:isPresentAccepted(iter_9_1) then
			return true
		end
	end

	return false
end

function var_0_0.getNextUnlockLimitTime(arg_10_0)
	local var_10_0 = Activity152Config.instance:getAct152Cos()
	local var_10_1 = -1

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		local var_10_2 = TimeUtil.stringToTimestamp(iter_10_1.acceptDate)

		if var_10_2 >= ServerTime.now() and (var_10_1 == -1 or var_10_1 > var_10_2 - ServerTime.now()) then
			var_10_1 = var_10_2 - ServerTime.now()
		end
	end

	return var_10_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
