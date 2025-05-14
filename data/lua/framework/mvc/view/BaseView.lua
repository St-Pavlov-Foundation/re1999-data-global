module("framework.mvc.view.BaseView", package.seeall)

local var_0_0 = class("BaseView", UserDataDispose)

function var_0_0.ctor(arg_1_0)
	arg_1_0.viewGO = nil
	arg_1_0.viewContainer = nil
	arg_1_0.viewParam = nil
	arg_1_0.viewName = nil
	arg_1_0.tabContainer = nil
	arg_1_0.rootGO = nil
	arg_1_0._childViews = nil
	arg_1_0._tryCallResultDict = nil
end

function var_0_0.onInitViewInternal(arg_2_0)
	arg_2_0._has_onInitView = true

	if arg_2_0._childViews then
		for iter_2_0, iter_2_1 in ipairs(arg_2_0._childViews) do
			iter_2_1.viewGO = arg_2_0.viewGO
			iter_2_1.viewContainer = arg_2_0.viewContainer
			iter_2_1.viewName = arg_2_0.viewName
		end
	end

	arg_2_0:_internalCall("onInitView")
end

function var_0_0.addEventsInternal(arg_3_0)
	arg_3_0._has_addEvents = true

	arg_3_0:_internalCall("addEvents")
end

function var_0_0.onOpenInternal(arg_4_0)
	arg_4_0._has_onOpen = true

	arg_4_0:_internalCall("onOpen")
end

function var_0_0.onOpenFinishInternal(arg_5_0)
	arg_5_0._has_onOpenFinish = true

	arg_5_0:_internalCall("onOpenFinish")
end

function var_0_0.onUpdateParamInternal(arg_6_0)
	arg_6_0:_internalCall("onUpdateParam")
end

function var_0_0.onClickModalMaskInternal(arg_7_0)
	arg_7_0:_internalCall("onClickModalMask")
end

function var_0_0.onCloseInternal(arg_8_0)
	arg_8_0._has_onOpen = false
	arg_8_0._has_onOpenFinish = false

	arg_8_0:_internalCall("onClose")
end

function var_0_0.onCloseFinishInternal(arg_9_0)
	arg_9_0:_internalCall("onCloseFinish")
end

function var_0_0.removeEventsInternal(arg_10_0)
	arg_10_0._has_addEvents = false

	arg_10_0:_internalCall("removeEvents")
end

function var_0_0.onDestroyViewInternal(arg_11_0)
	arg_11_0._has_onInitView = false

	arg_11_0:_internalCall("onDestroyView")

	arg_11_0._childViews = nil

	arg_11_0:tryCallMethodName("__onDispose")
end

function var_0_0._internalCall(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._childViews and tabletool.copy(arg_12_0._childViews)

	if var_12_0 then
		for iter_12_0, iter_12_1 in ipairs(var_12_0) do
			iter_12_1[arg_12_1 .. "Internal"](iter_12_1)
		end
	end

	arg_12_0:tryCallMethodName(arg_12_1)
end

function var_0_0.tryCallMethodName(arg_13_0, arg_13_1)
	local var_13_0, var_13_1 = xpcall(arg_13_0[arg_13_1], __G__TRACKBACK__, arg_13_0)

	arg_13_0._tryCallResultDict = arg_13_0._tryCallResultDict or {}
	arg_13_0._tryCallResultDict[arg_13_1] = var_13_0

	return var_13_0, var_13_1
end

function var_0_0.isHasTryCallFail(arg_14_0)
	if arg_14_0._tryCallResultDict then
		for iter_14_0, iter_14_1 in pairs(arg_14_0._tryCallResultDict) do
			if iter_14_1 == false then
				return true
			end
		end
	end

	local var_14_0 = arg_14_0._childViews

	if var_14_0 then
		local var_14_1 = #var_14_0

		for iter_14_2 = 1, var_14_1 do
			local var_14_2 = var_14_0[iter_14_2]

			if var_14_2 and var_14_2:isHasTryCallFail() then
				return true
			end
		end
	end

	return false
end

function var_0_0.onInitView(arg_15_0)
	return
end

function var_0_0.addEvents(arg_16_0)
	return
end

function var_0_0.onOpen(arg_17_0)
	return
end

function var_0_0.onOpenFinish(arg_18_0)
	return
end

function var_0_0.onUpdateParam(arg_19_0)
	return
end

function var_0_0.onClickModalMask(arg_20_0)
	return
end

function var_0_0.onClose(arg_21_0)
	return
end

function var_0_0.onCloseFinish(arg_22_0)
	return
end

function var_0_0.removeEvents(arg_23_0)
	return
end

function var_0_0.onDestroyView(arg_24_0)
	return
end

function var_0_0.getResInst(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	return arg_25_0.viewContainer:getResInst(arg_25_1, arg_25_2, arg_25_3)
end

function var_0_0.closeThis(arg_26_0)
	ViewMgr.instance:closeView(arg_26_0.viewName, nil, true)
end

function var_0_0.addChildView(arg_27_0, arg_27_1)
	if not arg_27_1 then
		return
	end

	if not isTypeOf(arg_27_1, var_0_0) then
		logError("addChildView fail, view must inherited from BaseView: " .. (arg_27_1.__cname or "nil"))

		return
	end

	arg_27_0._childViews = arg_27_0._childViews or {}

	if not tabletool.indexOf(arg_27_0._childViews, arg_27_1) then
		table.insert(arg_27_0._childViews, arg_27_1)
		arg_27_1:__onInit()

		arg_27_1.viewGO = arg_27_0.viewGO
		arg_27_1.viewContainer = arg_27_0.viewContainer
		arg_27_1.viewName = arg_27_0.viewName

		if arg_27_0._has_onInitView then
			arg_27_1:onInitViewInternal()
		end

		if arg_27_0._has_addEvents then
			arg_27_1:addEventsInternal()
		end

		if arg_27_0._has_onOpen then
			arg_27_1:onOpenInternal()
		end

		if arg_27_0._has_onOpenFinish then
			arg_27_1:onOpenFinishInternal()
		end
	end
end

return var_0_0
