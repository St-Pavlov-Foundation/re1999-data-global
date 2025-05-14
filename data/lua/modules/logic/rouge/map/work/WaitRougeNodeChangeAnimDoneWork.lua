module("modules.logic.rouge.map.work.WaitRougeNodeChangeAnimDoneWork", package.seeall)

local var_0_0 = class("WaitRougeNodeChangeAnimDoneWork", BaseWork)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = RougeMapModel.instance:getFinalMapInfo()

	if not var_2_0 then
		return arg_2_0:onDone(true)
	end

	RougeMapModel.instance:updateMapInfo(var_2_0)
	RougeMapModel.instance:setFinalMapInfo(nil)

	return arg_2_0:onDone(true)
end

return var_0_0
