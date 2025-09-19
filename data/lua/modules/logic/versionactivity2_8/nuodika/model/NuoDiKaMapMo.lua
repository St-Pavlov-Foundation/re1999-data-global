module("modules.logic.versionactivity2_8.nuodika.model.NuoDiKaMapMo", package.seeall)

local var_0_0 = pureTable("NuoDiKaMapMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.mapId = 0
	arg_1_0.lineCount = 0
	arg_1_0.rowCount = 0
	arg_1_0.passType = NuoDiKaEnum.MapPassType.ClearEnemy
	arg_1_0.mapBg = ""
	arg_1_0.nodeDict = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.mapId = arg_2_1[1]
	arg_2_0.lineCount = arg_2_1[2]
	arg_2_0.rowCount = arg_2_1[3]
	arg_2_0.taskValue = arg_2_1[4]
	arg_2_0.passType = arg_2_1[5]
	arg_2_0.mapBg = arg_2_1[6]
	arg_2_0.nodeDict = arg_2_0._toNodes(arg_2_1[7])
end

function var_0_0._toNodes(arg_3_0)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
		local var_3_1 = NuoDiKaMapNodeMo.New()

		var_3_1:init(iter_3_1)

		var_3_0[var_3_1.id] = var_3_1
	end

	table.sort(var_3_0, function(arg_4_0, arg_4_1)
		return arg_4_0.id < arg_4_1.id
	end)

	return var_3_0
end

function var_0_0.getNodeMo(arg_5_0, arg_5_1)
	if not arg_5_0.nodeDict[arg_5_1] then
		return
	end

	return arg_5_0.nodeDict[arg_5_1]
end

return var_0_0
