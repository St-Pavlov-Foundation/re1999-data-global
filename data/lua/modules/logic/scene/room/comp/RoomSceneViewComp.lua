module("modules.logic.scene.room.comp.RoomSceneViewComp", package.seeall)

local var_0_0 = class("RoomSceneViewComp", BaseSceneComp)

var_0_0.OnOpenView = 1

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene = arg_2_0:getCurScene()

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_2_0._onOpenView, arg_2_0)

	arg_2_0._views = {
		[ViewName.RoomView] = false
	}

	for iter_2_0, iter_2_1 in pairs(arg_2_0._views) do
		ViewMgr.instance:openView(iter_2_0, true)
	end
end

function var_0_0._onOpenView(arg_3_0, arg_3_1)
	if arg_3_0._views[arg_3_1] ~= nil then
		arg_3_0._views[arg_3_1] = true

		arg_3_0:_check()
	end
end

function var_0_0._check(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0._views) do
		if iter_4_1 == false then
			return
		end
	end

	local var_4_0 = RoomController.instance:getOpenViews()

	for iter_4_2, iter_4_3 in ipairs(var_4_0) do
		if iter_4_3.viewName == ViewName.RoomInitBuildingView then
			RoomMapController.instance:openRoomInitBuildingView(0, iter_4_3.param)
		else
			ViewMgr.instance:openView(iter_4_3.viewName, iter_4_3.param)
		end
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_4_0._onOpenView, arg_4_0)
	arg_4_0:dispatchEvent(var_0_0.OnOpenView)
end

function var_0_0.onSceneClose(arg_5_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_5_0._onOpenView, arg_5_0)

	for iter_5_0, iter_5_1 in pairs(arg_5_0._views) do
		ViewMgr.instance:closeView(iter_5_0, true)
	end

	ViewMgr.instance:closeAllPopupViews()
end

return var_0_0
