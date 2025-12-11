module("modules.logic.versionactivity3_1.enter.view.VersionActivity3_1EnterViewTabItem2", package.seeall)

local var_0_0 = class("VersionActivity3_1EnterViewTabItem2", VersionActivityFixedEnterViewTabItemBase)

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

function var_0_0._editableInitView(arg_2_0)
	var_0_0.super._editableInitView(arg_2_0)

	arg_2_0.txtName = gohelper.findChildText(arg_2_0.go, "#txt_name")
	arg_2_0.txtNameEn = gohelper.findChildText(arg_2_0.go, "#txt_name/#txt_nameen")
end

function var_0_0.addEventListeners(arg_3_0)
	var_0_0.super.addEventListeners(arg_3_0)
	arg_3_0.clickCollider:AddClickListener(arg_3_0.onClickCollider, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	var_0_0.super.removeEventListeners(arg_4_0)
	arg_4_0.clickCollider:RemoveClickListener()
end

function var_0_0._getTagPath(arg_5_0)
	return "#go_tag"
end

function var_0_0.afterSetData(arg_6_0)
	var_0_0.super.afterSetData(arg_6_0)

	arg_6_0.txtName.text = arg_6_0.activityCo and arg_6_0.activityCo.name or ""
	arg_6_0.txtNameEn.text = arg_6_0.activityCo and arg_6_0.activityCo.nameEn or ""
end

function var_0_0.childRefreshSelect(arg_7_0, arg_7_1)
	var_0_0.super.childRefreshSelect(arg_7_0, arg_7_1)

	local var_7_0 = VersionActivityFixedHelper.getVersionActivityEnum().TabSetting.unselect

	if arg_7_0.isSelect then
		var_7_0 = VersionActivityFixedHelper.getVersionActivityEnum().TabSetting.select
	end

	arg_7_0.txtName.color = GameUtil.parseColor(var_7_0.cnColor)
	arg_7_0.txtNameEn.color = GameUtil.parseColor(var_7_0.enColor)
	arg_7_0.txtName.fontSize = var_7_0.fontSize
	arg_7_0.txtNameEn.fontSize = var_7_0.enFontSize
	arg_7_0.txtName.alpha = var_7_0.cnAlpha or 1
	arg_7_0.txtNameEn.alpha = var_7_0.enAlpha or 1
end

function var_0_0.onClickCollider(arg_8_0)
	if arg_8_0:isRaycastScrollTab() then
		return
	end

	arg_8_0:onClick()
end

function var_0_0.isRaycastScrollTab(arg_9_0)
	if not arg_9_0._pointerEventData then
		arg_9_0._pointerEventData = UnityEngine.EventSystems.PointerEventData.New(UnityEngine.EventSystems.EventSystem.current)
		arg_9_0._raycastResults = System.Collections.Generic.List_UnityEngine_EventSystems_RaycastResult.New()
	end

	arg_9_0._pointerEventData.position = UnityEngine.Input.mousePosition

	UnityEngine.EventSystems.EventSystem.current:RaycastAll(arg_9_0._pointerEventData, arg_9_0._raycastResults)

	local var_9_0 = arg_9_0._raycastResults:GetEnumerator()

	while var_9_0:MoveNext() do
		if var_9_0.Current.gameObject.name == "#scroll_tab" then
			return true
		end
	end
end

return var_0_0
