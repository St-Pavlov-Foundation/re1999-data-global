module("modules.logic.seasonver.act166.view.information.Season166InformationAnalyDetailItemBase", package.seeall)

local var_0_0 = class("Season166InformationAnalyDetailItemBase", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.itemType = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0:__onInit()

	arg_2_0.go = arg_2_1

	arg_2_0:onInit()
end

function var_0_0.onInit(arg_3_0)
	return
end

function var_0_0.setData(arg_4_0, arg_4_1)
	arg_4_0.data = arg_4_1

	if not arg_4_1 then
		gohelper.setActive(arg_4_0.go, false)

		return
	end

	gohelper.setActive(arg_4_0.go, true)
	gohelper.setAsLastSibling(arg_4_0.go)
	gohelper.setActive(arg_4_0.goLine, not arg_4_1.isEnd)
	arg_4_0:onUpdate()
end

function var_0_0.onUpdate(arg_5_0)
	return
end

function var_0_0.playTxtFadeInByStage(arg_6_0, arg_6_1)
	if not arg_6_0.data then
		return
	end

	local var_6_0 = arg_6_0.data.config

	if var_6_0 and var_6_0.stage == arg_6_1 then
		arg_6_0:playFadeIn()
	end
end

function var_0_0.playFadeIn(arg_7_0)
	return
end

function var_0_0.getPosY(arg_8_0)
	return recthelper.getAnchorY(arg_8_0.go.transform)
end

function var_0_0.onRecycle(arg_9_0)
	gohelper.setActive(arg_9_0.go, false)
end

function var_0_0.onDestroy(arg_10_0)
	arg_10_0:__onDispose()
end

return var_0_0
