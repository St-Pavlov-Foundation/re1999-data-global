module("modules.common.others.ViewHelper", package.seeall)

local var_0_0 = class("ViewHelper")

function var_0_0.checkViewNameDictInit(arg_1_0)
	if arg_1_0.viewNameDict then
		return
	end

	arg_1_0.viewNameDict = {}
end

function var_0_0.OpenViewAndWaitViewClose(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0:checkViewNameDictInit()

	if arg_2_0.viewNameDict[arg_2_1] then
		logWarn(arg_2_1 .. "close callback override!")
	end

	arg_2_0.viewNameDict[arg_2_1] = {
		arg_2_3,
		arg_2_4
	}

	ViewMgr.instance:openView(arg_2_1, arg_2_2)

	if not arg_2_0.registerEvent then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_2_0.onViewClose, arg_2_0)

		arg_2_0.registerEvent = true
	end
end

function var_0_0.onViewClose(arg_3_0, arg_3_1)
	if not arg_3_0.viewNameDict[arg_3_1] then
		return
	end

	local var_3_0 = arg_3_0.viewNameDict[arg_3_1][1]
	local var_3_1 = arg_3_0.viewNameDict[arg_3_1][2]

	arg_3_0.viewNameDict[arg_3_1] = nil

	if tabletool.len(arg_3_0.viewNameDict) == 0 then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_3_0.onViewClose, arg_3_0)

		arg_3_0.registerEvent = false
	end

	if var_3_0 then
		return var_3_0(var_3_1)
	end
end

function var_0_0.initGlobalIgnoreViewList(arg_4_0)
	if not arg_4_0.checkViewTopIgnoreViewList then
		arg_4_0.checkViewTopIgnoreViewList = {
			ViewName.ToastView
		}
	end

	return arg_4_0.checkViewTopIgnoreViewList
end

function var_0_0.checkIsGlobalIgnore(arg_5_0, arg_5_1)
	arg_5_0:initGlobalIgnoreViewList()

	return tabletool.indexOf(arg_5_0.checkViewTopIgnoreViewList, arg_5_1)
end

function var_0_0.checkViewOnTheTop(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:initGlobalIgnoreViewList()

	local var_6_0 = ViewMgr.instance:getOpenViewNameList()

	for iter_6_0 = #var_6_0, 1, -1 do
		local var_6_1 = var_6_0[iter_6_0]

		if not tabletool.indexOf(arg_6_0.checkViewTopIgnoreViewList, var_6_1) then
			if not arg_6_2 then
				return var_6_1 == arg_6_1
			end

			if not tabletool.indexOf(arg_6_2, var_6_1) then
				return var_6_1 == arg_6_1
			end
		end
	end

	return false
end

function var_0_0.checkAnyViewOnTheTop(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_1 or #arg_7_1 == 0 then
		return false
	end

	local var_7_0 = {}
	local var_7_1 = {}
	local var_7_2 = ViewMgr.instance:getOpenViewNameList()

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		var_7_0[iter_7_1] = true
	end

	if arg_7_2 then
		for iter_7_2, iter_7_3 in ipairs(arg_7_2) do
			var_7_1[iter_7_3] = true
		end
	end

	for iter_7_4 = #var_7_2, 1, -1 do
		local var_7_3 = var_7_2[iter_7_4]

		if ViewMgr.instance:getContainer(var_7_3) and not arg_7_0:checkIsGlobalIgnore(var_7_3) and not var_7_1[var_7_3] and var_7_0[var_7_3] then
			return true
		end
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
