module("modules.logic.versionactivity2_2.eliminate.model.mo.EliminateTipMO", package.seeall)

local var_0_0 = class("EliminateTipMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0.from = {}
	arg_1_0.to = {}
	arg_1_0.eliminate = {}
end

function var_0_0.updateInfoByServer(arg_2_0, arg_2_1)
	if arg_2_1 == nil or arg_2_1.from == nil then
		return
	end

	arg_2_0.from.x = arg_2_1.from.x + 1
	arg_2_0.from.y = arg_2_1.from.y + 1
	arg_2_0.to.x = arg_2_1.to.x + 1
	arg_2_0.to.y = arg_2_1.to.y + 1

	tabletool.clear(arg_2_0.eliminate)

	local var_2_0 = arg_2_1.eliminate

	if var_2_0 then
		for iter_2_0, iter_2_1 in ipairs(var_2_0.coordinate) do
			arg_2_0.eliminate[#arg_2_0.eliminate + 1] = iter_2_1.x + 1
			arg_2_0.eliminate[#arg_2_0.eliminate + 1] = iter_2_1.y + 1
		end
	end
end

function var_0_0.getEliminateCount(arg_3_0)
	return tabletool.len(arg_3_0.eliminate)
end

return var_0_0
