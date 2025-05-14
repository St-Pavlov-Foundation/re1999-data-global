module("modules.logic.explore.controller.trigger.ExploreTriggerCatchUnit", package.seeall)

local var_0_0 = class("ExploreTriggerCatchUnit", ExploreTriggerBase)
local var_0_1 = ExploreEnum.TriggerEvent.CatchUnit .. "#1"
local var_0_2 = ExploreEnum.TriggerEvent.CatchUnit .. "#0"

function var_0_0.handle(arg_1_0, arg_1_1, arg_1_2)
	if ExploreModel.instance:hasUseItemOrUnit() then
		arg_1_0:onDone(false)
		logError("catchUnit fail inusing id:" .. ExploreModel.instance:getUseItemUid())

		return
	end

	arg_1_0:sendTriggerRequest(var_0_1)
end

function var_0_0.cancel(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = ExploreController.instance:getMap():getHero()
	local var_2_1 = ExploreHelper.dirToXY(var_2_0.dir)
	local var_2_2 = var_2_0.nodePos
	local var_2_3 = var_0_2 .. "#" .. var_2_2.x + var_2_1.x .. "#" .. var_2_2.y + var_2_1.y

	arg_2_0:sendTriggerRequest(var_2_3)
end

function var_0_0.onReply(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_2 == 0 then
		local var_3_0 = string.splitToNumber(arg_3_3.params, "#")
		local var_3_1 = 0

		if var_3_0[2] == 1 then
			var_3_1 = arg_3_0.unitId
		end

		ExploreModel.instance:setUseItemUid(var_3_1)
		arg_3_0:onStepDone(true)
	else
		arg_3_0:onDone(false)
	end
end

return var_0_0
