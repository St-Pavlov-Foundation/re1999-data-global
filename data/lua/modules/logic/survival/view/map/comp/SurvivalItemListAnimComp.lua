module("modules.logic.survival.view.map.comp.SurvivalItemListAnimComp", package.seeall)

local var_0_0 = class("SurvivalItemListAnimComp", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
end

function var_0_0.playListOpenAnim(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.itemList = arg_2_1
	arg_2_0.delay = arg_2_2 or 0.1
	arg_2_0.animName = arg_2_3 or UIAnimationName.Open
	arg_2_0._index = 0

	if not arg_2_0.itemList then
		return
	end

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.itemList) do
		gohelper.setActive(iter_2_1.go, false)
	end

	TaskDispatcher.cancelTask(arg_2_0._playNext, arg_2_0)
	TaskDispatcher.runRepeat(arg_2_0._playNext, arg_2_0, arg_2_0.delay)
end

function var_0_0._playNext(arg_3_0)
	arg_3_0._index = arg_3_0._index + 1

	local var_3_0 = arg_3_0.itemList[arg_3_0._index]

	if not var_3_0 then
		TaskDispatcher.cancelTask(arg_3_0._playNext, arg_3_0)

		return
	end

	gohelper.setActive(var_3_0.go, true)
	var_3_0.anim:Play(arg_3_0.animName, 0, 0)
end

function var_0_0.onDestroy(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._playNext, arg_4_0)
end

return var_0_0
