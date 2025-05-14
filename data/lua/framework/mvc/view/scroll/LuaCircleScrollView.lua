module("framework.mvc.view.scroll.LuaCircleScrollView", package.seeall)

local var_0_0 = class("LuaCircleScrollView", BaseScrollView)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.ctor(arg_1_0, arg_1_1, arg_1_2.emptyScrollParam)

	arg_1_0._csCircleScroll = nil
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

	arg_2_0._csCircleScroll = SLFramework.UGUI.CircleScrollView.Get(var_2_0)

	arg_2_0._csCircleScroll:Init(arg_2_0._param.scrollDir, arg_2_0._param.rotateDir, arg_2_0._param.circleCellCount, arg_2_0._param.scrollRadius, arg_2_0._param.cellRadius, arg_2_0._param.firstDegree, arg_2_0._param.isLoop, arg_2_0._onUpdateCell, arg_2_0._onSelectCell, arg_2_0)
end

function var_0_0.getCsScroll(arg_3_0)
	return arg_3_0._csCircleScroll
end

function var_0_0._onUpdateCell(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	return
end

function var_0_0._onSelectCell(arg_5_0, arg_5_1, arg_5_2)
	return
end

return var_0_0
