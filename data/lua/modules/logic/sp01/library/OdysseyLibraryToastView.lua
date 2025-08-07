module("modules.logic.sp01.library.OdysseyLibraryToastView", package.seeall)

local var_0_0 = class("OdysseyLibraryToastView", AssassinLibraryToastView)

function var_0_0._showToast(arg_1_0)
	local var_1_0 = table.remove(arg_1_0._cacheMsgList, 1)

	if not var_1_0 then
		TaskDispatcher.cancelTask(arg_1_0._showToast, arg_1_0)

		arg_1_0.hadTask = false

		return
	end

	AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_unlock)

	local var_1_1 = table.remove(arg_1_0._freeList, 1)

	if not var_1_1 then
		local var_1_2 = gohelper.clone(arg_1_0._gotemplate, arg_1_0._gopoint)

		var_1_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_1_2, OdysseyLibraryToastItem)
	end

	local var_1_3

	if #arg_1_0._usingList >= arg_1_0._maxCount then
		local var_1_4 = arg_1_0._usingList[1]

		arg_1_0:_doRecycleAnimation(var_1_4, true)
	end

	table.insert(arg_1_0._usingList, var_1_1)
	var_1_1:setMsg(var_1_0)
	var_1_1:appearAnimation(var_1_0)
	arg_1_0:_refreshAllItemsAnimation()
end

return var_0_0
