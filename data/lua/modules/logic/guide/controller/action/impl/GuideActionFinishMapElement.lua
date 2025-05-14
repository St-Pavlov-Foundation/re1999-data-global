module("modules.logic.guide.controller.action.impl.GuideActionFinishMapElement", package.seeall)

local var_0_0 = class("GuideActionFinishMapElement", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	DungeonRpc.instance:sendMapElementRequest(tonumber(arg_1_0.actionParam))
	arg_1_0:onDone(true)
end

return var_0_0
