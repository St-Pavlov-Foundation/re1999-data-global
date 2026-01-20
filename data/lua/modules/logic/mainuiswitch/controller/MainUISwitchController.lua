-- chunkname: @modules/logic/mainuiswitch/controller/MainUISwitchController.lua

module("modules.logic.mainuiswitch.controller.MainUISwitchController", package.seeall)

local MainUISwitchController = class("MainUISwitchController", BaseController)

function MainUISwitchController:onInit()
	self:reInit()
end

function MainUISwitchController:onInitFinish()
	return
end

function MainUISwitchController:addConstEvents()
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, self._onGetInfoFinish, self)
end

function MainUISwitchController:reInit()
	return
end

function MainUISwitchController:_onGetInfoFinish()
	MainUISwitchModel.instance:initMainUI()
end

function MainUISwitchController:openMainUISwitchInfoView(skinId, noInfoEffect, isPreview)
	ViewMgr.instance:openView(ViewName.MainUISwitchInfoBlurMaskView, {
		SkinId = skinId,
		noInfoEffect = noInfoEffect,
		isPreview = isPreview
	})
end

function MainUISwitchController:openMainUISwitchInfoViewGiftSet(skinId, sceneId)
	ViewMgr.instance:openView(ViewName.MainUISwitchInfoBlurMaskView, {
		isPreview = true,
		isNotShowLeft = true,
		isNotShowHero = true,
		noInfoEffect = true,
		SkinId = skinId,
		sceneId = sceneId
	})
end

function MainUISwitchController:setCurMainUIStyle(id, callback, callbackObj)
	local co = lua_scene_ui.configDict[id]

	if not co then
		return
	end

	local itemId = co.defaultUnlock == 1 and 0 or co.itemId

	MainUISwitchModel.instance:setCurUseUI(id)
	PlayerRpc.instance:sendSetUiStyleSkinRequest(itemId, callback, callbackObj)
	MainUISwitchController.instance:dispatchEvent(MainUISwitchEvent.UseMainUI, id)
end

function MainUISwitchController.hasReddot(id)
	return false
end

function MainUISwitchController.closeReddot(id)
	return
end

function MainUISwitchController:isClickEagle()
	if not self._pointerEventData then
		self._pointerEventData = UnityEngine.EventSystems.PointerEventData.New(UnityEngine.EventSystems.EventSystem.current)
		self._raycastResults = System.Collections.Generic.List_UnityEngine_EventSystems_RaycastResult.New()
	end

	self._pointerEventData.position = UnityEngine.Input.mousePosition

	UnityEngine.EventSystems.EventSystem.current:RaycastAll(self._pointerEventData, self._raycastResults)

	local iter = self._raycastResults:GetEnumerator()

	while iter:MoveNext() do
		local raycastResult = iter.Current

		if raycastResult.gameObject.name == "#go_eagleclick" then
			return true
		end
	end
end

MainUISwitchController.instance = MainUISwitchController.New()

return MainUISwitchController
