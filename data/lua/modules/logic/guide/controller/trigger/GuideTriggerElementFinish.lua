module("modules.logic.guide.controller.trigger.GuideTriggerElementFinish", package.seeall)

local var_0_0 = class("GuideTriggerElementFinish", BaseGuideTrigger)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateMapElementState, arg_1_0._OnUpdateMapElementState, arg_1_0)
end

function var_0_0.assertGuideSatisfy(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = tonumber(arg_2_2)
	local var_2_1 = tonumber(arg_2_1)
	local var_2_2 = DungeonConfig.instance:getChapterMapElement(var_2_0)

	if var_2_2 and var_2_2.mapId == var_2_1 and DungeonMapModel.instance:elementIsFinished(var_2_0) then
		return true
	end

	return false
end

function var_0_0._OnUpdateMapElementState(arg_3_0, arg_3_1)
	arg_3_0:checkStartGuide(arg_3_1)
end

return var_0_0
