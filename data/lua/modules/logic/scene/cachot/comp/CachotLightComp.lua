module("modules.logic.scene.cachot.comp.CachotLightComp", package.seeall)

local var_0_0 = class("CachotLightComp", BaseSceneComp)

function var_0_0.onScenePrepared(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._scene = arg_1_0:getCurScene()
	arg_1_0._preloadComp = arg_1_0._scene.preloader
	arg_1_0._lightGo = gohelper.create3d(arg_1_0._scene:getSceneContainerGO(), "Light")
	arg_1_0._lightAnim = arg_1_0._preloadComp:getResInst(CachotScenePreloader.LightPath, arg_1_0._lightGo):GetComponent(typeof(UnityEngine.Animator))

	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.BeginTriggerEvent, arg_1_0._playClickAnim, arg_1_0)
end

function var_0_0._playClickAnim(arg_2_0)
	arg_2_0._lightAnim:Play("open", 0, 0)
end

function var_0_0.onSceneClose(arg_3_0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.BeginTriggerEvent, arg_3_0._playClickAnim, arg_3_0)

	if arg_3_0._lightGo then
		gohelper.destroy(arg_3_0._lightGo)

		arg_3_0._lightGo = nil
	end

	arg_3_0._preloadComp = nil
	arg_3_0._scene = nil
	arg_3_0._lightAnim = nil
end

return var_0_0
