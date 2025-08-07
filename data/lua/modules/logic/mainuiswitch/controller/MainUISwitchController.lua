module("modules.logic.mainuiswitch.controller.MainUISwitchController", package.seeall)

local var_0_0 = class("MainUISwitchController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, arg_3_0._onGetInfoFinish, arg_3_0)
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0._onGetInfoFinish(arg_5_0)
	MainUISwitchModel.instance:initMainUI()
end

function var_0_0.openMainUISwitchInfoView(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	ViewMgr.instance:openView(ViewName.MainUISwitchInfoBlurMaskView, {
		SkinId = arg_6_1,
		noInfoEffect = arg_6_2,
		isPreview = arg_6_3
	})
end

function var_0_0.openMainUISwitchInfoViewGiftSet(arg_7_0, arg_7_1, arg_7_2)
	ViewMgr.instance:openView(ViewName.MainUISwitchInfoBlurMaskView, {
		isPreview = true,
		isNotShowLeft = true,
		isNotShowHero = true,
		noInfoEffect = true,
		SkinId = arg_7_1,
		sceneId = arg_7_2
	})
end

function var_0_0.setCurMainUIStyle(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = lua_scene_ui.configDict[arg_8_1]

	if not var_8_0 then
		return
	end

	local var_8_1 = var_8_0.defaultUnlock == 1 and 0 or var_8_0.itemId

	MainUISwitchModel.instance:setCurUseUI(arg_8_1)
	PlayerRpc.instance:sendSetUiStyleSkinRequest(var_8_1, arg_8_2, arg_8_3)
	var_0_0.instance:dispatchEvent(MainUISwitchEvent.UseMainUI, arg_8_1)
end

function var_0_0.hasReddot(arg_9_0)
	return false
end

function var_0_0.closeReddot(arg_10_0)
	return
end

function var_0_0.isClickEagle(arg_11_0)
	if not arg_11_0._pointerEventData then
		arg_11_0._pointerEventData = UnityEngine.EventSystems.PointerEventData.New(UnityEngine.EventSystems.EventSystem.current)
		arg_11_0._raycastResults = System.Collections.Generic.List_UnityEngine_EventSystems_RaycastResult.New()
	end

	arg_11_0._pointerEventData.position = UnityEngine.Input.mousePosition

	UnityEngine.EventSystems.EventSystem.current:RaycastAll(arg_11_0._pointerEventData, arg_11_0._raycastResults)

	local var_11_0 = arg_11_0._raycastResults:GetEnumerator()

	while var_11_0:MoveNext() do
		if var_11_0.Current.gameObject.name == "#go_eagleclick" then
			return true
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
