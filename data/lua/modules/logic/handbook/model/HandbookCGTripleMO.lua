module("modules.logic.handbook.model.HandbookCGTripleMO", package.seeall)

local var_0_0 = pureTable("HandbookCGTripleMO")

function var_0_0.init(arg_1_0, arg_1_1)
	if arg_1_1.isTitle then
		arg_1_0.storyChapterId = arg_1_1.storyChapterId
		arg_1_0.isTitle = true
	else
		arg_1_0.cgList = arg_1_1.cgList
		arg_1_0.cgType = arg_1_1.cgType
		arg_1_0.isTitle = false
	end
end

return var_0_0
