module("modules.logic.currency.view.PowerItemFlyGroup", package.seeall)

local var_0_0 = class("PowerItemFlyGroup", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._itemPrefab = gohelper.findChild(arg_1_1, "item")

	gohelper.setActive(arg_1_0._itemPrefab, false)

	arg_1_0._items = arg_1_0:getUserDataTb_()
end

function var_0_0.flyItems(arg_2_0, arg_2_1)
	TaskDispatcher.cancelTask(arg_2_0._delayPlayAudio, arg_2_0)

	if arg_2_1 and arg_2_1 > 0 then
		gohelper.setActive(arg_2_0.go, true)

		for iter_2_0 = 1, arg_2_1 do
			arg_2_0:_getCanFlyItem(iter_2_0):fly((iter_2_0 - 1) * 0.13)
		end

		TaskDispatcher.runDelay(arg_2_0._delayPlayAudio, arg_2_0, 0.5)
	end
end

function var_0_0._delayPlayAudio(arg_3_0)
	AudioMgr.instance:trigger(AudioEnum3_1.Power.play_ui_tili_candy)
end

function var_0_0._getCanFlyItem(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0._items) do
		if iter_4_1:isCanfly() then
			return iter_4_1
		end
	end

	local var_4_0 = gohelper.cloneInPlace(arg_4_0._itemPrefab, #arg_4_0._items + 1)
	local var_4_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_0, PowerItemFlyItem)

	table.insert(arg_4_0._items, var_4_1)

	return var_4_1
end

function var_0_0.onDestroy(arg_5_0)
	arg_5_0:cancelTask()
end

function var_0_0.cancelTask(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._delayPlayAudio, arg_6_0)
end

return var_0_0
