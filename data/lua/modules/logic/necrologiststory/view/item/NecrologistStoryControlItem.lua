module("modules.logic.necrologiststory.view.item.NecrologistStoryControlItem", package.seeall)

local var_0_0 = class("NecrologistStoryControlItem", NecrologistStoryBaseItem)

function var_0_0.playControl(arg_1_0, arg_1_1, ...)
	arg_1_0._controlParam = arg_1_1

	arg_1_0:setCallback(...)
	arg_1_0:onPlayStory()
	arg_1_0:refreshHeight()
end

function var_0_0.getItemType(arg_2_0)
	return nil
end

return var_0_0
