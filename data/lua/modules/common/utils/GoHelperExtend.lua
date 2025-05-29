module("modules.common.utils.GoHelperExtend", package.seeall)

local var_0_0 = gohelper

var_0_0.Type_UIClickAudio = typeof(ZProj.UIClickAudio)
var_0_0.Type_CanvasGroup = typeof(UnityEngine.CanvasGroup)
var_0_0.Type_TMPInputField = typeof(TMPro.TMP_InputField)
var_0_0.Type_Animator = typeof(UnityEngine.Animator)
var_0_0.Type_LimitedScrollRect = typeof(ZProj.LimitedScrollRect)
var_0_0.Type_RectTransform = typeof(UnityEngine.RectTransform)
var_0_0.Type_Transform = typeof(UnityEngine.Transform)
var_0_0.Type_ParticleSystem = typeof(UnityEngine.ParticleSystem)
var_0_0.Type_AnimationEventWrap = typeof(ZProj.AnimationEventWrap)
var_0_0.Type_Animation = typeof(UnityEngine.Animation)
var_0_0.Type_TMP_SubMeshUI = typeof(TMPro.TMP_SubMeshUI)
var_0_0.Type_RectMask2D = typeof(UnityEngine.UI.RectMask2D)
var_0_0.Type_GridLayoutGroup = typeof(UnityEngine.UI.GridLayoutGroup)
var_0_0.Type_ContentSizeFitter = typeof(UnityEngine.UI.ContentSizeFitter)
var_0_0.Type_MeshRender = typeof(UnityEngine.MeshRenderer)
var_0_0.Type_Render = typeof(UnityEngine.Renderer)
var_0_0.Type_LangTextDynamicSize = typeof(ZProj.LangTextDynamicSize)

local var_0_1 = SLFramework.UGUI.ButtonWrap
local var_0_2 = SLFramework.UGUI.UIClickListener
local var_0_3 = ZProj.GameHelper
local var_0_4 = ZProj.LangTextDynamicSize

function var_0_0.addUIClickAudio(arg_1_0, arg_1_1)
	arg_1_1 = arg_1_1 or AudioEnum.UI.UI_Common_Click
	var_0_0.onceAddComponent(arg_1_0, var_0_0.Type_UIClickAudio).audioId = arg_1_1
end

function var_0_0.removeUIClickAudio(arg_2_0)
	var_0_0.onceAddComponent(arg_2_0, var_0_0.Type_UIClickAudio).audioId = 0
end

function var_0_0.findChildButtonWithAudio(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = var_0_1.GetWithPath(arg_3_0, arg_3_1)

	if var_3_0 then
		var_0_0.addUIClickAudio(var_3_0.gameObject, arg_3_2)
	end

	return var_3_0
end

function var_0_0.findButtonWithAudio(arg_4_0, arg_4_1)
	local var_4_0 = var_0_1.Get(arg_4_0)

	if var_4_0 then
		var_0_0.addUIClickAudio(var_4_0.gameObject, arg_4_1)
	end

	return var_4_0
end

function var_0_0.findChildClickWithAudio(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = var_0_2.GetWithPath(arg_5_0, arg_5_1)

	if var_5_0 and arg_5_2 then
		var_0_0.addUIClickAudio(var_5_0.gameObject, arg_5_2)
	end

	return var_5_0
end

function var_0_0.findChildAnim(arg_6_0, arg_6_1)
	local var_6_0 = var_0_0.findChild(arg_6_0, arg_6_1)

	if var_6_0 then
		return var_6_0:GetComponent(var_0_0.Type_Animator)
	end
end

function var_0_0.getClickWithAudio(arg_7_0, arg_7_1)
	local var_7_0 = var_0_2.Get(arg_7_0)

	if var_7_0 and arg_7_1 then
		var_0_0.addUIClickAudio(var_7_0.gameObject, arg_7_1)
	end

	return var_7_0
end

function var_0_0.getClickWithDefaultAudio(arg_8_0)
	return var_0_0.getClickWithAudio(arg_8_0, AudioEnum.UI.UI_Common_Click)
end

function var_0_0.findChildClickWithDefaultAudio(arg_9_0, arg_9_1)
	return var_0_0.findChildClickWithAudio(arg_9_0, arg_9_1, AudioEnum.UI.UI_Common_Click)
end

function var_0_0.findChildTextMeshInputField(arg_10_0, arg_10_1)
	return ZProj.TextMeshInputFieldWrap.GetWithPath(arg_10_0, arg_10_1)
end

function var_0_0.findChildDropdown(arg_11_0, arg_11_1)
	return ZProj.DropdownWrap.GetWithPath(arg_11_0, arg_11_1) or ZProj.TMPDropdownWrap.GetWithPath(arg_11_0, arg_11_1)
end

function var_0_0.findChildScrollbar(arg_12_0, arg_12_1)
	return ZProj.ScrollbarWrap.GetWithPath(arg_12_0, arg_12_1)
end

function var_0_0.findChildUIMesh(arg_13_0, arg_13_1)
	if string.nilorempty(arg_13_1) then
		return arg_13_0:GetComponent(typeof(UIMesh))
	end

	local var_13_0 = var_0_0.findChild(arg_13_0, arg_13_1)

	if var_13_0 then
		return var_13_0:GetComponent(typeof(UIMesh))
	end
end

function var_0_0.setActiveCanvasGroup(arg_14_0, arg_14_1)
	var_0_3.SetActiveCanvasGroup(arg_14_0, arg_14_1)
end

function var_0_0.setActiveCanvasGroupNoAnchor(arg_15_0, arg_15_1)
	if var_0_0.isNil(arg_15_0) then
		return
	end

	arg_15_0.alpha = arg_15_1 and 1 or 0
	arg_15_0.interactable = arg_15_1 and true or false
	arg_15_0.blocksRaycasts = arg_15_1 and true or false
end

function var_0_0.getRichColorText(arg_16_0, arg_16_1)
	return string.format("<color=%s>%s</color>", arg_16_1, arg_16_0)
end

function var_0_0.getRemindFourNumberFloat(arg_17_0)
	return arg_17_0 - arg_17_0 % 0.0001
end

function var_0_0.activateExtend()
	return
end

function var_0_0.CreateObjList(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5, arg_19_6, arg_19_7, arg_19_8)
	if var_0_0.isNil(arg_19_3) and not var_0_0.isNil(arg_19_4) then
		arg_19_3 = arg_19_4.transform.parent.gameObject
	end

	local var_19_0
	local var_19_1 = #arg_19_2
	local var_19_2 = arg_19_3.transform

	arg_19_6 = arg_19_6 or 1
	arg_19_7 = arg_19_7 or var_19_1
	arg_19_8 = arg_19_8 or 0

	if arg_19_6 > 1 then
		for iter_19_0 = 1, arg_19_6 - 1 do
			local var_19_3

			if arg_19_2[iter_19_0] then
				local var_19_4 = var_19_2.childCount >= iter_19_0 + arg_19_8 and var_19_2:GetChild(iter_19_0 - 1 + arg_19_8).gameObject

				if var_19_4 == arg_19_4 then
					var_0_0.setActive(var_19_4, false)

					arg_19_8 = arg_19_8 + 1
					var_19_0 = var_19_4

					break
				end
			end
		end
	end

	for iter_19_1 = arg_19_6, arg_19_7 do
		local var_19_5

		if arg_19_2[iter_19_1] then
			local var_19_6 = var_19_2.childCount >= iter_19_1 + arg_19_8 and var_19_2:GetChild(iter_19_1 - 1 + arg_19_8).gameObject or var_0_0.clone(arg_19_4, arg_19_3, iter_19_1)

			if var_19_6 == arg_19_4 then
				var_0_0.setActive(var_19_6, false)

				arg_19_8 = arg_19_8 + 1
				var_19_0 = var_19_6
				var_19_6 = var_19_2.childCount >= iter_19_1 + arg_19_8 and var_19_2:GetChild(iter_19_1 - 1 + arg_19_8).gameObject or var_0_0.clone(arg_19_4, arg_19_3, iter_19_1)
			end

			var_0_0.setActive(var_19_6, true)

			if arg_19_1 then
				if arg_19_5 then
					arg_19_1(arg_19_0, MonoHelper.addNoUpdateLuaComOnceToGo(var_19_6, arg_19_5), arg_19_2[iter_19_1], iter_19_1)
				else
					arg_19_1(arg_19_0, var_19_6, arg_19_2[iter_19_1], iter_19_1)
				end
			end
		else
			arg_19_7 = iter_19_1 - 1

			break
		end
	end

	arg_19_6 = arg_19_7 + 1 + arg_19_8
	arg_19_6 = arg_19_6 < 1 and 1 or arg_19_6

	for iter_19_2 = arg_19_6, var_19_2.childCount do
		local var_19_7 = var_19_2:GetChild(iter_19_2 - 1)
		local var_19_8 = var_19_7 and var_19_7.gameObject

		if var_19_8 then
			var_0_0.setActive(var_19_8, false)
		end
	end

	if var_19_0 then
		var_19_0.transform:SetSiblingIndex(var_19_2.childCount - 1)
	end
end

function var_0_0.CreateNumObjList(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0.transform
	local var_20_1 = var_20_0.childCount
	local var_20_2 = var_20_1 <= arg_20_2 and arg_20_2 or var_20_1

	for iter_20_0 = 1, var_20_2 do
		local var_20_3

		if iter_20_0 <= arg_20_2 then
			local var_20_4 = iter_20_0 <= var_20_1 and var_20_0:GetChild(iter_20_0 - 1).gameObject or var_0_0.clone(arg_20_1, arg_20_0, iter_20_0)

			var_0_0.setActive(var_20_4, true)
		else
			local var_20_5 = iter_20_0 <= var_20_1 and var_20_0:GetChild(iter_20_0 - 1).gameObject

			if var_20_5 then
				var_0_0.setActive(var_20_5, false)
			end
		end
	end
end

function var_0_0.removeComponent(arg_21_0, arg_21_1)
	var_0_3.RemoveComponent(arg_21_0, arg_21_1)
end

function var_0_0.enableAkListener(arg_22_0, arg_22_1)
	if arg_22_1 then
		ZProj.AudioHelper.EnableAkListener(arg_22_0)
	else
		ZProj.AudioHelper.DisableAkListener(arg_22_0)
	end
end

function var_0_0.addAkGameObject(arg_23_0)
	ZProj.AudioHelper.AddAkGameObject(arg_23_0)
end

function var_0_0.fitScreenOffset(arg_24_0)
	ZProj.UGUIHelper.RebuildLayout(arg_24_0)

	local var_24_0 = ViewMgr.instance:getUIRoot().transform
	local var_24_1 = recthelper.getWidth(var_24_0)
	local var_24_2 = recthelper.getHeight(var_24_0)
	local var_24_3 = var_24_1 / var_24_2 < 1.7777777777777777 and 1080 or var_24_2
	local var_24_4
	local var_24_5
	local var_24_6
	local var_24_7
	local var_24_8 = arg_24_0.gameObject:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic))

	if var_24_8 then
		local var_24_9 = var_24_8:GetEnumerator()

		while var_24_9:MoveNext() do
			local var_24_10 = var_24_9.Current.gameObject:GetComponent(typeof(UnityEngine.RectTransform))
			local var_24_11 = var_24_0:InverseTransformPoint(var_24_10.position)
			local var_24_12 = var_24_11.x - var_24_10.pivot.x * recthelper.getWidth(var_24_10)
			local var_24_13 = var_24_11.x + (1 - var_24_10.pivot.x) * recthelper.getWidth(var_24_10)
			local var_24_14 = var_24_11.y + (1 - var_24_10.pivot.y) * recthelper.getHeight(var_24_10)
			local var_24_15 = var_24_11.y - var_24_10.pivot.y * recthelper.getHeight(var_24_10)

			var_24_4 = var_24_4 or var_24_12

			if var_24_12 < var_24_4 then
				var_24_4 = var_24_12
			end

			var_24_5 = var_24_5 or var_24_13

			if var_24_5 < var_24_13 then
				var_24_5 = var_24_13
			end

			var_24_6 = var_24_6 or var_24_15

			if var_24_15 < var_24_6 then
				var_24_6 = var_24_15
			end

			var_24_7 = var_24_7 or var_24_14

			if var_24_7 < var_24_14 then
				var_24_7 = var_24_14
			end
		end
	end

	local var_24_16 = var_24_1 / 2
	local var_24_17 = var_24_3 / 2
	local var_24_18 = false

	if var_24_4 < -var_24_16 then
		var_24_18 = true

		recthelper.setAnchorX(arg_24_0, recthelper.getAnchorX(arg_24_0) - (var_24_4 + var_24_16))
	elseif var_24_16 < var_24_5 then
		var_24_18 = true

		recthelper.setAnchorX(arg_24_0, recthelper.getAnchorX(arg_24_0) - (var_24_5 - var_24_16))
	end

	if var_24_6 < -var_24_17 then
		var_24_18 = true

		recthelper.setAnchorY(arg_24_0, recthelper.getAnchorY(arg_24_0) - (var_24_6 + var_24_17))
	elseif var_24_17 < var_24_7 then
		var_24_18 = true

		recthelper.setAnchorY(arg_24_0, recthelper.getAnchorY(arg_24_0) - (var_24_7 - var_24_17))
	end

	return var_24_18
end

function var_0_0.addChildPosStay(arg_25_0, arg_25_1)
	if var_0_0.isNil(arg_25_1) then
		return
	end

	if var_0_0.isNil(arg_25_0) then
		arg_25_1.transform:SetParent(nil, true)
	else
		arg_25_1.transform:SetParent(arg_25_0.transform, true)
	end
end

function var_0_0.addBoxCollider2D(arg_26_0, arg_26_1)
	local var_26_0 = var_0_0.onceAddComponent(arg_26_0, typeof(UnityEngine.BoxCollider2D))

	var_26_0.enabled = true
	var_26_0.size = arg_26_1 or Vector2(1.5, 1.5)

	return var_26_0
end

function var_0_0.fitScrollItemOffset(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = ViewMgr.instance:getUIRoot().transform
	local var_27_1 = arg_27_0:GetComponent(typeof(UnityEngine.RectTransform))
	local var_27_2 = var_27_0:InverseTransformPoint(var_27_1.position)
	local var_27_3 = transformhelper.getLocalScale(arg_27_0.transform) * var_0_0.getTotalParentScale(arg_27_0)
	local var_27_4 = var_27_2.x - var_27_1.pivot.x * recthelper.getWidth(var_27_1) * var_27_3
	local var_27_5 = var_27_2.x + (1 - var_27_1.pivot.x) * recthelper.getWidth(var_27_1) * var_27_3
	local var_27_6 = var_27_2.y + (1 - var_27_1.pivot.y) * recthelper.getHeight(var_27_1) * var_27_3
	local var_27_7 = var_27_2.y - var_27_1.pivot.y * recthelper.getHeight(var_27_1) * var_27_3
	local var_27_8 = 100000
	local var_27_9 = -100000
	local var_27_10 = 100000
	local var_27_11 = -100000
	local var_27_12 = 0
	local var_27_13 = arg_27_2:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic))

	if var_27_13 then
		local var_27_14 = var_27_13:GetEnumerator()

		while var_27_14:MoveNext() do
			local var_27_15 = var_27_14.Current.gameObject

			if var_27_15:GetComponent(var_0_0.Type_ParticleSystem) == nil then
				local var_27_16 = var_27_15:GetComponent(typeof(UnityEngine.RectTransform))
				local var_27_17 = transformhelper.getLocalScale(var_27_15.transform) * var_0_0.getTotalParentScale(var_27_15)
				local var_27_18 = var_27_0:InverseTransformPoint(var_27_16.position)
				local var_27_19 = var_27_18.x - var_27_16.pivot.x * recthelper.getWidth(var_27_16) * var_27_17
				local var_27_20 = var_27_18.x + (1 - var_27_16.pivot.x) * recthelper.getWidth(var_27_16) * var_27_17
				local var_27_21 = var_27_18.y + (1 - var_27_16.pivot.y) * recthelper.getHeight(var_27_16) * var_27_17
				local var_27_22 = var_27_18.y - var_27_16.pivot.y * recthelper.getHeight(var_27_16) * var_27_17

				var_27_8 = math.min(var_27_8, var_27_19)
				var_27_9 = math.max(var_27_9, var_27_20)
				var_27_10 = math.min(var_27_10, var_27_22)
				var_27_11 = math.max(var_27_11, var_27_21)
			end
		end
	end

	if arg_27_3 == ScrollEnum.ScrollDirH then
		if var_27_8 < var_27_4 then
			var_27_12 = var_27_4 - var_27_8
		end

		if var_27_5 < var_27_9 then
			var_27_12 = var_27_5 - var_27_9
		end
	elseif arg_27_3 == ScrollEnum.ScrollDirV then
		if var_27_10 < var_27_7 then
			var_27_12 = var_27_7 - var_27_10
		end

		if var_27_6 < var_27_11 then
			var_27_12 = var_27_6 - var_27_11
		end
	end

	return var_27_12 / var_0_0.getTotalParentScale(arg_27_1)
end

function var_0_0.getTotalParentScale(arg_28_0)
	local var_28_0 = arg_28_0.transform.parent.gameObject
	local var_28_1 = transformhelper.getLocalScale(var_28_0.transform)

	while var_28_0.transform.parent.gameObject.name ~= "UIRoot" do
		var_28_0 = var_28_0.transform.parent.gameObject
		var_28_1 = var_28_1 * transformhelper.getLocalScale(var_28_0.transform)
	end

	return var_28_1
end

function var_0_0.isMouseOverGo(arg_29_0, arg_29_1)
	if not arg_29_0 then
		return false
	end

	local var_29_0 = arg_29_0.transform
	local var_29_1 = recthelper.getWidth(var_29_0)
	local var_29_2 = recthelper.getHeight(var_29_0)

	arg_29_1 = arg_29_1 or GamepadController.instance:getMousePosition()

	local var_29_3 = recthelper.screenPosToAnchorPos(arg_29_1, var_29_0)
	local var_29_4 = var_29_0.pivot

	if var_29_3.x >= -var_29_1 * var_29_4.x and var_29_3.x <= var_29_1 * (1 - var_29_4.x) and var_29_3.y <= var_29_2 * (1 - var_29_4.y) and var_29_3.y >= -var_29_2 * var_29_4.y then
		return true
	end

	return false
end

function var_0_0.removeEffectNode(arg_30_0)
	if not arg_30_0 then
		return
	end

	local var_30_0 = GameGlobalMgr.instance:getScreenState():getLocalQuality()
	local var_30_1 = var_30_0 == ModuleEnum.Performance.Middle or var_30_0 == ModuleEnum.Performance.Low
	local var_30_2 = var_30_0 == ModuleEnum.Performance.Low

	if var_30_1 or var_30_2 then
		var_0_0._deleteLodNode(arg_30_0.transform, var_30_1, var_30_2)
	end
end

function var_0_0._deleteLodNode(arg_31_0, arg_31_1, arg_31_2)
	for iter_31_0 = arg_31_0.childCount - 1, 0, -1 do
		local var_31_0 = arg_31_0:GetChild(iter_31_0)

		if arg_31_1 and string.find(var_31_0.name, "^h_") then
			var_0_0.destroy(var_31_0.gameObject)
		elseif arg_31_2 and string.find(var_31_0.name, "^m_") then
			var_0_0.destroy(var_31_0.gameObject)
		else
			var_0_0._deleteLodNode(var_31_0, arg_31_1, arg_31_2)
		end
	end
end

function var_0_0.getParent(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0

	for iter_32_0 = 1, arg_32_1 do
		if not var_32_0 then
			return
		end

		var_32_0 = var_32_0.parent
	end

	return var_32_0
end

function var_0_0.getChildDynamicSizeText(arg_33_0, arg_33_1)
	local var_33_0 = var_0_0.findChild(arg_33_0, arg_33_1)

	return var_0_4.Get(var_33_0)
end

function var_0_0.findChildDynamicSizeText(arg_34_0, arg_34_1)
	return var_0_0.findChildComponent(arg_34_0, arg_34_1, var_0_0.Type_LangTextDynamicSize)
end

function var_0_0.getDynamicSizeText(arg_35_0)
	return arg_35_0:GetComponent(var_0_0.Type_LangTextDynamicSize)
end

function var_0_0.getUIScreenWidth()
	local var_36_0 = UnityEngine.GameObject.Find("UIRoot/POPUP_TOP")

	if var_36_0 then
		return recthelper.getWidth(var_36_0.transform)
	end

	local var_36_1 = 1080 / UnityEngine.Screen.height

	return (math.floor(UnityEngine.Screen.width * var_36_1 + 0.5))
end

return var_0_0
