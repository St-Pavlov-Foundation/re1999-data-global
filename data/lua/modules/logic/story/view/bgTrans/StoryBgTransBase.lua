module("modules.logic.story.view.bgTrans.StoryBgTransBase", package.seeall)

local var_0_0 = class("StoryBgTransBase", LuaCompBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0._resList = {}
	arg_1_0._transInTime = 0
	arg_1_0._transOutTime = 0
	arg_1_0._loader = MultiAbLoader.New()
end

function var_0_0.init(arg_2_0)
	return
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

function var_0_0.onSwitchBg(arg_6_0)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshBackground)
end

function var_0_0.onTransFinished(arg_7_0)
	return
end

function var_0_0.destroy(arg_8_0)
	if arg_8_0._loader then
		arg_8_0._loader:dispose()

		arg_8_0._loader = nil
	end

	arg_8_0._resList = nil
end

return var_0_0
