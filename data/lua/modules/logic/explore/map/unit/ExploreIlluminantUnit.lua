module("modules.logic.explore.map.unit.ExploreIlluminantUnit", package.seeall)

local var_0_0 = class("ExploreIlluminantUnit", ExploreBaseDisplayUnit)

function var_0_0.onEnter(arg_1_0)
	arg_1_0:updatePrism()
	var_0_0.super.onEnter(arg_1_0)
end

function var_0_0.onExit(arg_2_0)
	arg_2_0:updatePrism()
end

function var_0_0.updatePrism(arg_3_0)
	local var_3_0 = ExploreController.instance:getMapLight()

	if not var_3_0:isInitDone() then
		return
	end

	var_3_0:beginCheckStatusChange()

	local var_3_1 = ExploreController.instance:getMap():getUnitByPos(arg_3_0.nodePos)

	for iter_3_0, iter_3_1 in pairs(var_3_1) do
		if iter_3_1.mo:isInteractEnabled() and ExploreEnum.PrismTypes[iter_3_1:getUnitType()] then
			iter_3_1:onBallLightChange()
		end
	end

	var_3_0:endCheckStatus()
end

return var_0_0
