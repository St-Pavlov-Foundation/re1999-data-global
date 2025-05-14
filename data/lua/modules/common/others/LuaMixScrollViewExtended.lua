module("modules.common.others.LuaMixScrollViewExtended", package.seeall)

local var_0_0 = LuaMixScrollView

var_0_0.__onUpdateCell = var_0_0._onUpdateCell

function var_0_0.setDynamicGetItem(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._dynamicGetCallback = arg_1_1
	arg_1_0._dynamicGetCallbackObj = arg_1_2
	arg_1_0._useDynamicGetItem = true
end

function var_0_0._onUpdateCell(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if not arg_2_0._useDynamicGetItem then
		var_0_0.__onUpdateCell(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)

		return
	end

	local var_2_0 = arg_2_0._model:getByIndex(arg_2_2 + 1)
	local var_2_1, var_2_2, var_2_3 = arg_2_0._dynamicGetCallback(arg_2_0._dynamicGetCallbackObj, var_2_0)

	var_2_1 = var_2_1 or LuaListScrollView.PrefabInstName
	var_2_2 = var_2_2 or arg_2_0._param.cellClass
	var_2_3 = var_2_3 or arg_2_0._param.prefabUrl

	local var_2_4 = arg_2_1.transform
	local var_2_5 = var_2_4.childCount

	for iter_2_0 = 1, var_2_5 do
		local var_2_6 = var_2_4:GetChild(iter_2_0 - 1)

		gohelper.setActive(var_2_6, var_2_6.name == var_2_1)
	end

	local var_2_7 = arg_2_0:_getLuaCellComp(arg_2_1, var_2_1, var_2_2, var_2_3)

	var_2_7._index = arg_2_2 + 1

	var_2_7:onUpdateMO(var_2_0, arg_2_3, arg_2_4)
end

function var_0_0._getLuaCellComp(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = gohelper.findChild(arg_3_1, arg_3_2)
	local var_3_1

	if var_3_0 then
		var_3_1 = MonoHelper.getLuaComFromGo(var_3_0, arg_3_3)
	else
		if arg_3_0._param.prefabType == ScrollEnum.ScrollPrefabFromRes then
			var_3_0 = arg_3_0:getResInst(arg_3_4, arg_3_1, arg_3_2)
		elseif arg_3_0._param.prefabType == ScrollEnum.ScrollPrefabFromView then
			var_3_0 = gohelper.clone(arg_3_0._cellSourceGO, arg_3_1, arg_3_2)

			gohelper.setActive(var_3_0, true)
		else
			logError("LuaMixScrollView prefabType not support: " .. arg_3_0._param.prefabType)
		end

		var_3_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_3_0, arg_3_3)

		var_3_1:initInternal(var_3_0, arg_3_0)

		arg_3_0._cellCompDict[var_3_1] = true
	end

	return var_3_1
end

function var_0_0.activateExtend()
	return
end

return var_0_0
