module("modules.logic.versionactivity2_1.aergusi.model.AergusiEvidenceMo", package.seeall)

local var_0_0 = class("AergusiEvidenceMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.clueInfos = {}
	arg_1_0.hp = 0
	arg_1_0.tipCount = 0
	arg_1_0.success = false
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.clueInfos = arg_2_0:_buildClues(arg_2_1.cluesInfo)
	arg_2_0.hp = arg_2_1.hp
	arg_2_0.tipCount = arg_2_1.tipCount
	arg_2_0.success = arg_2_1.success
end

function var_0_0.update(arg_3_0, arg_3_1)
	arg_3_0:init(arg_3_1)
end

function var_0_0._buildClues(arg_4_0, arg_4_1)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_1 = AergusiClueMo.New()

		var_4_1:init(iter_4_1)
		table.insert(var_4_0, var_4_1)
	end

	return var_4_0
end

return var_0_0
