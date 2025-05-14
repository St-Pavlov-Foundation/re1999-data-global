module("modules.live2d.controller.Live2dMaskController", package.seeall)

local var_0_0 = class("Live2dMaskController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._goList = {}
end

function var_0_0.addConstEvents(arg_3_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_3_0._onOpenViewFinsh, arg_3_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
end

function var_0_0._onOpenViewFinsh(arg_4_0)
	arg_4_0:_checkMask()
end

function var_0_0._onCloseViewFinish(arg_5_0)
	arg_5_0:_checkMask()
end

function var_0_0.addLive2dGo(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return
	end

	if gohelper.isNil(arg_6_1) then
		return
	end

	arg_6_0._goList[arg_6_1] = true

	arg_6_0:_checkMask()
end

function var_0_0.removeLive2dGo(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	arg_7_0._goList[arg_7_1] = nil

	arg_7_0:_checkMask()
end

function var_0_0._checkMask(arg_8_0)
	local var_8_0 = arg_8_0:_needMask()

	RenderPipelineSetting.SetCubisMaskCommandBufferLateUpdateEnable(var_8_0)
end

function var_0_0._needMask(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0._goList) do
		if not gohelper.isNil(iter_9_0) then
			return true
		else
			rawset(arg_9_0._goList, iter_9_0, nil)
		end
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
