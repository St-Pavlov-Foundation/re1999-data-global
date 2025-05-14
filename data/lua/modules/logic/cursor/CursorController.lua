module("modules.logic.cursor.CursorController", package.seeall)

local var_0_0 = class("CursorController", BaseController)

function var_0_0.onInit(arg_1_0)
	if BootNativeUtil.isWindows() then
		-- block empty
	end
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.setUp(arg_5_0)
	local var_5_0 = gohelper.create2d(ViewMgr.instance:getUILayer(UILayerName.IDCanvasPopUp), "CursorItem")

	arg_5_0._cursor = MonoHelper.addLuaComOnceToGo(var_5_0, CursorItem)
end

var_0_0.instance = var_0_0.New()

return var_0_0
