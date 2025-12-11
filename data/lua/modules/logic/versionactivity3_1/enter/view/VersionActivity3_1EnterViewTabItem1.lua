module("modules.logic.versionactivity3_1.enter.view.VersionActivity3_1EnterViewTabItem1", package.seeall)

local var_0_0 = class("VersionActivity3_1EnterViewTabItem1", VersionActivityFixedEnterViewTabItemBase)

function var_0_0.init(arg_1_0, arg_1_1)
	if gohelper.isNil(arg_1_1) then
		return
	end

	arg_1_0.go = arg_1_1
	arg_1_0.rectTr = arg_1_0.go:GetComponent(gohelper.Type_RectTransform)
	arg_1_0.clickCollider = ZProj.BoxColliderClickListener.Get(arg_1_1)

	arg_1_0.clickCollider:SetIgnoreUI(true)

	arg_1_0.click = gohelper.getClickWithDefaultAudio(arg_1_0.go)

	arg_1_0:_editableInitView()
	gohelper.setActive(arg_1_0.go, true)
end

function var_0_0._getTagPath(arg_2_0)
	return "#go_tag"
end

function var_0_0.addEventListeners(arg_3_0)
	var_0_0.super.addEventListeners(arg_3_0)
	arg_3_0.clickCollider:AddClickListener(arg_3_0.onClickCollider, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	var_0_0.super.removeEventListeners(arg_4_0)
	arg_4_0.clickCollider:RemoveClickListener()
end

function var_0_0.onClickCollider(arg_5_0)
	if arg_5_0:isRaycastScrollTab() then
		return
	end

	arg_5_0:onClick()
end

function var_0_0.isRaycastScrollTab(arg_6_0)
	if not arg_6_0._pointerEventData then
		arg_6_0._pointerEventData = UnityEngine.EventSystems.PointerEventData.New(UnityEngine.EventSystems.EventSystem.current)
		arg_6_0._raycastResults = System.Collections.Generic.List_UnityEngine_EventSystems_RaycastResult.New()
	end

	arg_6_0._pointerEventData.position = UnityEngine.Input.mousePosition

	UnityEngine.EventSystems.EventSystem.current:RaycastAll(arg_6_0._pointerEventData, arg_6_0._raycastResults)

	local var_6_0 = arg_6_0._raycastResults:GetEnumerator()

	while var_6_0:MoveNext() do
		if var_6_0.Current.gameObject.name == "#scroll_tab" then
			return true
		end
	end
end

return var_0_0
