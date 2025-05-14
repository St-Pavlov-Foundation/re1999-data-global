module("modules.logic.ressplit.model.VersionResSplitData", package.seeall)

local var_0_0 = class("VersionResSplitData")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._id = arg_1_1
	arg_1_0._allResDict = {}
	arg_1_0._resType2PathsDict = {}
end

function var_0_0.addResSplitInfo(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if not arg_2_3 then
		return
	end

	arg_2_0._allResDict[arg_2_1] = arg_2_0._allResDict[arg_2_1] or {}
	arg_2_0._resType2PathsDict[arg_2_2] = arg_2_0._resType2PathsDict[arg_2_2] or {}

	if not arg_2_0._allResDict[arg_2_1][arg_2_3] then
		arg_2_0._resType2PathsDict[arg_2_2][arg_2_3] = true
		arg_2_0._allResDict[arg_2_1][arg_2_3] = true
	end
end

function var_0_0.checkResSplitInfo(arg_3_0, arg_3_1, arg_3_2)
	return arg_3_0._allResDict[arg_3_1] and arg_3_0._allResDict[arg_3_1][arg_3_2]
end

function var_0_0.checkResTypeSplitInfo(arg_4_0, arg_4_1, arg_4_2)
	return arg_4_0._resType2PathsDict[arg_4_1] and arg_4_0._resType2PathsDict[arg_4_1][arg_4_2]
end

function var_0_0.deleteResSplitInfo(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_1 and arg_5_0._allResDict[arg_5_1] and arg_5_0._allResDict[arg_5_1][arg_5_3] then
		arg_5_0._allResDict[arg_5_1][arg_5_3] = false
	end

	if arg_5_2 and arg_5_0._resType2PathsDict[arg_5_2] and arg_5_0._resType2PathsDict[arg_5_2][arg_5_3] then
		arg_5_0._resType2PathsDict[arg_5_2][arg_5_3] = false
	end
end

function var_0_0.getAllResDict(arg_6_0)
	return arg_6_0._allResDict
end

function var_0_0.getAllResTypeDict(arg_7_0)
	return arg_7_0._resType2PathsDict
end

function var_0_0.getResSplitMap(arg_8_0)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(arg_8_0._allResDict) do
		var_8_0[iter_8_0] = var_8_0[iter_8_0] or {}

		for iter_8_2, iter_8_3 in pairs(iter_8_1) do
			if iter_8_3 then
				local var_8_1 = var_8_0[iter_8_0]

				var_8_1[#var_8_1 + 1] = iter_8_2
			end
		end
	end

	return var_8_0
end

function var_0_0.getResTypeSplitMap(arg_9_0)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_0._resType2PathsDict) do
		var_9_0[iter_9_0] = var_9_0[iter_9_0] or {}

		for iter_9_2, iter_9_3 in pairs(iter_9_1) do
			if iter_9_3 then
				local var_9_1 = var_9_0[iter_9_0]

				var_9_1[#var_9_1 + 1] = iter_9_2
			end
		end
	end

	return var_9_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
