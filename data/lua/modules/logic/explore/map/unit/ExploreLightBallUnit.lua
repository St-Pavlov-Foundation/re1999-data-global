module("modules.logic.explore.map.unit.ExploreLightBallUnit", package.seeall)

local var_0_0 = class("ExploreLightBallUnit", ExploreItemUnit)

function var_0_0.onEnter(arg_1_0)
	arg_1_0:updateRoundPrism(arg_1_0.nodePos)
	var_0_0.super.onEnter(arg_1_0)
	ExploreController.instance:dispatchEvent(ExploreEvent.ExploreLightBallEnterExit)
end

function var_0_0.onExit(arg_2_0)
	arg_2_0:updateRoundPrism(arg_2_0.nodePos)
	ExploreController.instance:dispatchEvent(ExploreEvent.ExploreLightBallEnterExit)
end

function var_0_0.onNodeChange(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 then
		arg_3_0:updateRoundPrism(arg_3_1)
		arg_3_0:updateRoundPrism(arg_3_2)
	end
end

function var_0_0.updateRoundPrism(arg_4_0, arg_4_1)
	local var_4_0 = ExploreController.instance:getMapLight()

	if not var_4_0:isInitDone() then
		return
	end

	local var_4_1 = {
		x = 0,
		y = 0
	}

	var_4_0:beginCheckStatusChange()

	for iter_4_0 = 0, 270, 90 do
		local var_4_2 = ExploreHelper.dirToXY(iter_4_0)

		var_4_1.x = arg_4_1.x + var_4_2.x
		var_4_1.y = arg_4_1.y + var_4_2.y

		local var_4_3 = ExploreController.instance:getMap():getUnitByPos(var_4_1)

		for iter_4_1, iter_4_2 in pairs(var_4_3) do
			if iter_4_2.mo:isInteractEnabled() and ExploreEnum.PrismTypes[iter_4_2:getUnitType()] then
				iter_4_2:onBallLightChange()
			end
		end
	end

	var_4_0:endCheckStatus()
end

return var_0_0
