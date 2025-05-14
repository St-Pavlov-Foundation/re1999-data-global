module("modules.logic.scene.pushbox.comp.PushBoxSceneDirector", package.seeall)

local var_0_0 = class("PushBoxSceneDirector", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	arg_1_0._scene = arg_1_0:getCurScene()
end

function var_0_0.onSceneStart(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene.preloader:startPreload()
end

function var_0_0.onPushBoxAssetLoadFinish(arg_3_0)
	arg_3_0:_onRefreshActivityData()
end

function var_0_0._onRefreshActivityData(arg_4_0)
	arg_4_0._scene:onPrepared()
end

function var_0_0.onSceneClose(arg_5_0)
	return
end

return var_0_0
