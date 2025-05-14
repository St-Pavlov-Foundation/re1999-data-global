module("framework.mvc.view.scroll.LuaMixScrollView", package.seeall)

local var_0_0 = class("LuaMixScrollView", BaseScrollView)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.ctor(arg_1_0, arg_1_1, arg_1_2.emptyScrollParam)

	arg_1_0._csMixScroll = nil
	arg_1_0._model = arg_1_1
	arg_1_0._param = arg_1_2
	arg_1_0._cellCompDict = {}
end

function var_0_0.onInitView(arg_2_0)
	var_0_0.super.onInitView(arg_2_0)

	if arg_2_0._param.prefabType == ScrollEnum.ScrollPrefabFromView then
		arg_2_0._cellSourceGO = gohelper.findChild(arg_2_0.viewGO, arg_2_0._param.prefabUrl)

		gohelper.setActive(arg_2_0._cellSourceGO, false)
	end

	local var_2_0 = gohelper.findChild(arg_2_0.viewGO, arg_2_0._param.scrollGOPath)

	arg_2_0._csMixScroll = SLFramework.UGUI.MixScrollView.Get(var_2_0)

	arg_2_0._csMixScroll:Init(arg_2_0._param.scrollDir, arg_2_0._param.startSpace or 0, arg_2_0._param.endSpace or 0, arg_2_0._model:getInfoList(), arg_2_0._onUpdateCell, arg_2_0)
end

function var_0_0.clear(arg_3_0)
	if arg_3_0._csMixScroll then
		arg_3_0._csMixScroll:Clear()
	end
end

function var_0_0.onDestroyView(arg_4_0)
	var_0_0.super.onDestroyView(arg_4_0)
	arg_4_0._csMixScroll:Clear()

	arg_4_0._csMixScroll = nil
	arg_4_0._model = nil
	arg_4_0._param = nil
	arg_4_0._cellCompDict = nil
end

function var_0_0.getCsScroll(arg_5_0)
	return arg_5_0._csMixScroll
end

function var_0_0.refreshScroll(arg_6_0)
	var_0_0.super.refreshScroll(arg_6_0)
	arg_6_0._csMixScroll:UpdateInfo(arg_6_0._model:getInfoList(arg_6_0._csMixScroll.gameObject), true, false)
	arg_6_0:updateEmptyGO(arg_6_0._model:getCount())
end

function var_0_0._onUpdateCell(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = gohelper.findChild(arg_7_1, LuaListScrollView.PrefabInstName)
	local var_7_1

	if var_7_0 then
		var_7_1 = MonoHelper.getLuaComFromGo(var_7_0, arg_7_0._param.cellClass)
	else
		if arg_7_0._param.prefabType == ScrollEnum.ScrollPrefabFromRes then
			var_7_0 = arg_7_0:getResInst(arg_7_0._param.prefabUrl, arg_7_1, LuaListScrollView.PrefabInstName)
		elseif arg_7_0._param.prefabType == ScrollEnum.ScrollPrefabFromView then
			var_7_0 = gohelper.clone(arg_7_0._cellSourceGO, arg_7_1, LuaListScrollView.PrefabInstName)

			gohelper.setActive(var_7_0, true)
		else
			logError("LuaMixScrollView prefabType not support: " .. arg_7_0._param.prefabType)
		end

		var_7_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_0, arg_7_0._param.cellClass)

		var_7_1:initInternal(var_7_0, arg_7_0)

		arg_7_0._cellCompDict[var_7_1] = true
	end

	local var_7_2 = arg_7_0._model:getByIndex(arg_7_2 + 1)

	var_7_1._index = arg_7_2 + 1

	var_7_1:onUpdateMO(var_7_2, arg_7_3, arg_7_4)
end

return var_0_0
