module("modules.logic.story.view.bgEffs.StoryBgEffsBase", package.seeall)

local var_0_0 = class("StoryBgEffsBase", LuaCompBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0._resList = {}
	arg_1_0._effInTime = 0
	arg_1_0._effKeepTime = 0
	arg_1_0._effOutTime = 0
	arg_1_0._loader = MultiAbLoader.New()
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._bgCo = arg_2_1
end

function var_0_0.start(arg_3_0)
	return
end

function var_0_0.loadRes(arg_4_0)
	arg_4_0._loader:setPathList(arg_4_0._resList)
	arg_4_0._loader:startLoad(arg_4_0.onLoadFinished, arg_4_0)
end

function var_0_0.onLoadFinished(arg_5_0)
	return
end

function var_0_0.onEffInFinished(arg_6_0)
	return
end

function var_0_0.onEffKeepFinished(arg_7_0)
	return
end

function var_0_0.onEffOutFinished(arg_8_0)
	return
end

function var_0_0.destroy(arg_9_0)
	if arg_9_0._loader then
		arg_9_0._loader:dispose()

		arg_9_0._loader = nil
	end

	arg_9_0._resList = nil
end

return var_0_0
