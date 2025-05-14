module("modules.logic.scene.rouge.comp.RougeSceneDirector", package.seeall)

local var_0_0 = class("RougeSceneDirector", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onSceneStart(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene = arg_2_0:getCurScene()

	RougeMapController.instance:registerCallback(RougeMapEvent.onLoadMapDone, arg_2_0.onMapLoadDone, arg_2_0)
end

function var_0_0.onMapLoadDone(arg_3_0)
	arg_3_0._scene:onPrepared()
end

function var_0_0.onSceneClose(arg_4_0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onLoadMapDone, arg_4_0.onMapLoadDone, arg_4_0)
end

return var_0_0
