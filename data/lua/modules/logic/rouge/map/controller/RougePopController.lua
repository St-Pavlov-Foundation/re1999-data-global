module("modules.logic.rouge.map.controller.RougePopController", package.seeall)

local var_0_0 = class("RougePopController")

function var_0_0._init(arg_1_0)
	if arg_1_0._inited then
		return
	end

	arg_1_0._inited = true
	arg_1_0.waitPopViewList = {}
	arg_1_0.dataPool = {}
	arg_1_0.showingViewName = nil

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_1_0.onCloseView, arg_1_0)
end

function var_0_0.getViewData(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0

	if #arg_2_0.dataPool > 1 then
		var_2_0 = table.remove(arg_2_0.dataPool)
	else
		var_2_0 = {}
	end

	var_2_0.type = RougeEnum.PopType.ViewName
	var_2_0.viewName = arg_2_1
	var_2_0.param = arg_2_2

	return var_2_0
end

function var_0_0.getViewDataByFunc(arg_3_0, arg_3_1, arg_3_2, arg_3_3, ...)
	local var_3_0

	if #arg_3_0.dataPool > 1 then
		var_3_0 = table.remove(arg_3_0.dataPool)
	else
		var_3_0 = {}
	end

	var_3_0.type = RougeEnum.PopType.Func
	var_3_0.viewName = arg_3_1
	var_3_0.openFunc = arg_3_2
	var_3_0.openFuncObj = arg_3_3
	var_3_0.funcParam = {
		...
	}

	return var_3_0
end

function var_0_0.recycleData(arg_4_0, arg_4_1)
	tabletool.clear(arg_4_1)
	table.insert(arg_4_0.dataPool, arg_4_1)
end

function var_0_0.onCloseView(arg_5_0, arg_5_1)
	if arg_5_0.showingViewName ~= arg_5_1 then
		return
	end

	arg_5_0:recycleData(arg_5_0.data)

	arg_5_0.data = nil
	arg_5_0.showingViewName = nil

	if arg_5_0:hadPopView() then
		arg_5_0:_popNextView()
	else
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onPopViewDone)
	end
end

function var_0_0.popViewData(arg_6_0)
	return table.remove(arg_6_0.waitPopViewList, 1)
end

function var_0_0.hadPopView(arg_7_0)
	return arg_7_0.showingViewName ~= nil or arg_7_0.waitPopViewList and #arg_7_0.waitPopViewList > 0
end

function var_0_0.addPopViewWithViewName(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:_init()

	local var_8_0 = arg_8_0:getViewData(arg_8_1, arg_8_2)

	logNormal("add pop view : " .. arg_8_1)
	table.insert(arg_8_0.waitPopViewList, var_8_0)
	arg_8_0:_popNextView()
end

function var_0_0.addPopViewWithOpenFunc(arg_9_0, arg_9_1, arg_9_2, arg_9_3, ...)
	arg_9_0:_init()

	local var_9_0 = arg_9_0:getViewDataByFunc(arg_9_1, arg_9_2, arg_9_3, ...)

	logNormal("add pop view : " .. arg_9_1)
	table.insert(arg_9_0.waitPopViewList, var_9_0)
	arg_9_0:_popNextView()
end

function var_0_0._popNextView(arg_10_0)
	if RougeMapModel.instance:getMapState() <= RougeMapEnum.MapState.LoadingMap then
		return
	end

	if arg_10_0.showingViewName then
		return
	end

	arg_10_0.data = arg_10_0:popViewData()

	if not arg_10_0.data then
		return
	end

	arg_10_0.showingViewName = arg_10_0.data.viewName

	if arg_10_0.data.type == RougeEnum.PopType.ViewName then
		ViewMgr.instance:openView(arg_10_0.data.viewName, arg_10_0.data.param)
	else
		arg_10_0.data.openFunc(arg_10_0.data.openFuncObj, unpack(arg_10_0.data.funcParam))
	end
end

function var_0_0.tryPopView(arg_11_0)
	arg_11_0:_popNextView()
end

function var_0_0.isPopping(arg_12_0)
	return arg_12_0.showingViewName ~= nil
end

function var_0_0.clearAllPopView(arg_13_0)
	if arg_13_0.waitPopViewList then
		for iter_13_0 = 1, #arg_13_0.waitPopViewList do
			arg_13_0:recycleData(table.remove(arg_13_0.waitPopViewList))
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
