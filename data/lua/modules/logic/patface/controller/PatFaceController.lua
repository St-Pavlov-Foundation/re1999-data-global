module("modules.logic.patface.controller.PatFaceController", package.seeall)

local var_0_0 = class("PatFaceController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_3_0._onOpenViewFinish, arg_3_0)
end

function var_0_0.reInit(arg_4_0)
	arg_4_0:_destroyPopupFlow()
end

function var_0_0._onFinishAllPatFace(arg_5_0)
	if arg_5_0._skipBlurViewName then
		PostProcessingMgr.instance:setCloseSkipRefreshBlur(arg_5_0._skipBlurViewName, nil)

		arg_5_0._skipBlurViewName = nil

		PostProcessingMgr.instance:forceRefreshCloseBlur()
	end
end

function var_0_0._onOpenViewFinish(arg_6_0, arg_6_1)
	if not PatFaceModel.instance:getIsPatting() or not arg_6_0._patFaceViewNameMap or not arg_6_0._patFaceFlow then
		return
	end

	if arg_6_0._patFaceViewNameMap[arg_6_1] then
		arg_6_0._skipBlurViewName = arg_6_1

		PostProcessingMgr.instance:setCloseSkipRefreshBlur(arg_6_0._skipBlurViewName, true)
		arg_6_0:_checkAndCloseTryCallView(arg_6_1)
	end
end

function var_0_0._checkAndCloseTryCallView(arg_7_0, arg_7_1)
	if ViewMgr.instance:isOpenFinish(arg_7_1) then
		local var_7_0 = ViewMgr.instance:getContainer(arg_7_1)

		if var_7_0 and var_7_0.isHasTryCallFail and var_7_0:isHasTryCallFail() then
			logError(string.format("PatFace view open has error, try close . name:[%s] .", arg_7_1))
			ViewMgr.instance:closeView(arg_7_1)
		end
	end
end

function var_0_0._initPatFaceFlow(arg_8_0)
	arg_8_0:_destroyPopupFlow()

	arg_8_0._patFaceFlow = PatFaceFlowSequence.New()
	arg_8_0._patFaceViewNameMap = {}

	local var_8_0 = PatFaceConfig.instance:getPatFaceConfigList()

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		local var_8_1 = iter_8_1.id

		arg_8_0._patFaceViewNameMap[iter_8_1.config.patFaceViewName] = true

		local var_8_2 = (PatFaceEnum.patFaceCustomWork[var_8_1] or PatFaceWorkBase).New(var_8_1)

		arg_8_0._patFaceFlow:addWork(var_8_2)
	end

	arg_8_0._patFaceFlow:registerDoneListener(arg_8_0._finishAllPatFace, arg_8_0)
end

function var_0_0.startPatFace(arg_9_0, arg_9_1)
	if PatFaceModel.instance:getIsSkipPatFace() then
		return false
	end

	local var_9_0 = GuideModel.instance:isDoingClickGuide()
	local var_9_1 = GuideController.instance:isForbidGuides()

	if var_9_0 and not var_9_1 then
		return false
	end

	if PatFaceModel.instance:getIsPatting() then
		return false
	end

	if not arg_9_0._patFaceFlow then
		arg_9_0:_initPatFaceFlow()
	end

	PatFaceModel.instance:setIsPatting(true)
	arg_9_0._patFaceFlow:start({
		patFaceType = arg_9_1
	})

	return true
end

function var_0_0._finishAllPatFace(arg_10_0)
	PatFaceModel.instance:setIsPatting(false)

	if arg_10_0._patFaceFlow then
		arg_10_0._patFaceFlow:reset()
	end

	arg_10_0:_onFinishAllPatFace()
	arg_10_0:dispatchEvent(PatFaceEvent.FinishAllPatFace)
end

function var_0_0._destroyPopupFlow(arg_11_0)
	PatFaceModel.instance:setIsPatting(false)

	if not arg_11_0._patFaceFlow then
		return
	end

	arg_11_0._patFaceFlow:destroy()

	arg_11_0._patFaceFlow = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
