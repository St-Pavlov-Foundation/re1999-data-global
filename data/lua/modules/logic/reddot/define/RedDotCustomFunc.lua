module("modules.logic.reddot.define.RedDotCustomFunc", package.seeall)

local var_0_0 = class("RedDotCustomFunc")

function var_0_0.isCustomShow(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.CustomRedHandleFunc[arg_1_0]

	if var_1_0 then
		return true, var_1_0(arg_1_0, arg_1_1)
	end
end

function var_0_0.isShowNecrologistStory(arg_2_0, arg_2_1)
	local var_2_0 = RoleStoryModel.instance:getCurActStoryId()

	return NecrologistStoryController.instance:getNecrologistStoryActivityRed(var_2_0)
end

var_0_0.CustomRedHandleFunc = {
	[RedDotEnum.DotNode.NecrologistStory] = var_0_0.isShowNecrologistStory
}

return var_0_0
