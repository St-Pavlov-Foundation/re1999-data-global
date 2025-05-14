module("modules.logic.popup.controller.PopupCacheController", package.seeall)

local var_0_0 = class("PopupCacheController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_3_0._onOpenViewFinish, arg_3_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_3_0._viewChangeCheckIsInMainView, arg_3_0)
end

function var_0_0._onOpenViewFinish(arg_4_0, arg_4_1)
	if arg_4_1 ~= ViewName.MainView then
		return
	end

	arg_4_0:_viewChangeCheckIsInMainView()
end

function var_0_0._viewChangeCheckIsInMainView(arg_5_0)
	local var_5_0 = PopupCacheModel.instance:getCount()

	if not var_5_0 or var_5_0 <= 0 then
		return
	end

	if not MainController.instance:isInMainView() then
		return
	end

	if PopupHelper.checkInGuide() then
		return
	end

	arg_5_0:showCachePopupView()
end

function var_0_0.showCachePopupView(arg_6_0)
	local var_6_0 = PopupCacheModel.instance:popNextPopupParam()

	if not var_6_0 then
		return
	end

	local var_6_1 = var_6_0.customPopupFunc

	if var_6_1 then
		var_6_1(var_6_0)
	else
		arg_6_0:defaultShowCommonPropView(var_6_0)
	end
end

function var_0_0.defaultShowCommonPropView(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1 and arg_7_1.materialDataMOList

	if not var_7_0 then
		return
	end

	RoomController.instance:popUpRoomBlockPackageView(var_7_0)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, var_7_0)
end

function var_0_0.tryCacheGetPropView(arg_8_0, arg_8_1, arg_8_2)
	if type(arg_8_2) ~= "table" then
		logError(string.format("PopupCacheController:tryCacheGetPropView error, need table param"))

		return false
	end

	local var_8_0 = false
	local var_8_1 = arg_8_1 and PopupEnum.CheckCacheGetApproach[arg_8_1] or {}

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		local var_8_2 = PopupEnum.CheckCacheHandler[iter_8_1]

		if var_8_2 and var_8_2() or false then
			arg_8_2.cacheType = iter_8_1

			PopupCacheModel.instance:recordCachePopupParam(arg_8_2)

			var_8_0 = true

			break
		end
	end

	return var_8_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
