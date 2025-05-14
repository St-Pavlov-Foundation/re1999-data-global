module("modules.logic.scene.common.camera.MainCameraMgr", package.seeall)

local var_0_0 = class("MainCameraMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._viewList = {}

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_1_0._onOpenView, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_1_0._onCloseView, arg_1_0)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, arg_1_0._onScreenResize, arg_1_0)
end

function var_0_0._onOpenView(arg_2_0, arg_2_1)
	arg_2_0:_checkCamera()
end

function var_0_0._onCloseView(arg_3_0, arg_3_1)
	arg_3_0:_setCamera(arg_3_1, false)

	arg_3_0._viewList[arg_3_1] = nil

	arg_3_0:_checkCamera()
end

function var_0_0._onScreenResize(arg_4_0)
	arg_4_0:_checkCamera()
end

function var_0_0.addView(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0._viewList[arg_5_1] = {
		setCallback = arg_5_2,
		resetCallback = arg_5_3,
		target = arg_5_4
	}

	arg_5_0:_checkCamera()
end

function var_0_0._checkCamera(arg_6_0)
	local var_6_0 = arg_6_0:_getTopViewCamera()

	if var_6_0 then
		arg_6_0:_setCamera(var_6_0, true)
	end
end

function var_0_0._setCamera(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0._isLock then
		return
	end

	local var_7_0 = arg_7_0._viewList[arg_7_1]

	if not var_7_0 then
		return
	end

	if arg_7_2 then
		if var_7_0.setCallback then
			var_7_0.setCallback(var_7_0.target)
		end
	else
		arg_7_0:_resetCamera()

		if var_7_0.resetCallback then
			var_7_0.resetCallback(var_7_0.target)
		end
	end
end

function var_0_0._resetCamera(arg_8_0)
	local var_8_0 = CameraMgr.instance:getMainCamera()

	var_8_0.orthographicSize = 5
	var_8_0.orthographic = false

	transformhelper.setLocalPos(var_8_0.transform, 0, 0, 0)
end

function var_0_0._getTopViewCamera(arg_9_0)
	local var_9_0 = ViewMgr.instance:getOpenViewNameList()

	for iter_9_0 = #var_9_0, 1, -1 do
		local var_9_1 = var_9_0[iter_9_0]

		if arg_9_0._viewList[var_9_1] then
			return var_9_1
		end
	end
end

function var_0_0.setLock(arg_10_0, arg_10_1)
	arg_10_0._isLock = arg_10_1

	if not arg_10_1 then
		arg_10_0:_checkCamera()
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
