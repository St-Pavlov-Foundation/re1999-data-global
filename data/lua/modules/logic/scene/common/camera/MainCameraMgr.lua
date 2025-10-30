module("modules.logic.scene.common.camera.MainCameraMgr", package.seeall)

local var_0_0 = class("MainCameraMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._viewList = {}

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_1_0._onOpenView, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_1_0._onCloseView, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_1_0._onCloseViewFinish, arg_1_0)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, arg_1_0._onScreenResize, arg_1_0)
end

function var_0_0._onOpenView(arg_2_0, arg_2_1)
	arg_2_0:_checkCamera()
end

function var_0_0._onCloseView(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._viewList[arg_3_1]

	if var_3_0 and var_3_0._resetCallbackOnCloseViewFinish then
		return
	end

	arg_3_0:_setCamera(arg_3_1, false)

	arg_3_0._viewList[arg_3_1] = nil

	arg_3_0:_checkCamera()
end

function var_0_0._onCloseViewFinish(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._viewList[arg_4_1]

	if var_4_0 and var_4_0._resetCallbackOnCloseViewFinish ~= true then
		return
	end

	arg_4_0:_setCamera(arg_4_1, false)

	arg_4_0._viewList[arg_4_1] = nil

	arg_4_0:_checkCamera()
end

function var_0_0._onScreenResize(arg_5_0)
	arg_5_0:_checkCamera()
end

function var_0_0.setCloseViewFinishReset(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._viewList[arg_6_1]

	if var_6_0 then
		var_6_0._resetCallbackOnCloseViewFinish = true
	end
end

function var_0_0.addView(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	arg_7_0._viewList[arg_7_1] = {
		setCallback = arg_7_2,
		resetCallback = arg_7_3,
		target = arg_7_4
	}

	arg_7_0:_checkCamera()
end

function var_0_0._checkCamera(arg_8_0)
	local var_8_0 = arg_8_0:_getTopViewCamera()

	if var_8_0 then
		arg_8_0:_setCamera(var_8_0, true)
	end
end

function var_0_0._setCamera(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0._isLock then
		return
	end

	local var_9_0 = arg_9_0._viewList[arg_9_1]

	if not var_9_0 then
		return
	end

	if arg_9_2 then
		if var_9_0.setCallback then
			var_9_0.setCallback(var_9_0.target)
		end
	else
		arg_9_0:_resetCamera()

		if var_9_0.resetCallback then
			var_9_0.resetCallback(var_9_0.target)
		end
	end
end

function var_0_0._resetCamera(arg_10_0)
	local var_10_0 = CameraMgr.instance:getMainCamera()

	var_10_0.orthographicSize = 5
	var_10_0.orthographic = false

	transformhelper.setLocalPos(var_10_0.transform, 0, 0, 0)
end

function var_0_0._getTopViewCamera(arg_11_0)
	local var_11_0 = ViewMgr.instance:getOpenViewNameList()

	for iter_11_0 = #var_11_0, 1, -1 do
		local var_11_1 = var_11_0[iter_11_0]

		if arg_11_0._viewList[var_11_1] then
			return var_11_1
		end
	end
end

function var_0_0.setLock(arg_12_0, arg_12_1)
	arg_12_0._isLock = arg_12_1

	if not arg_12_1 then
		arg_12_0:_checkCamera()
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
