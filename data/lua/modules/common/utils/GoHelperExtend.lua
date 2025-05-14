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

function var_0_0.getRichColorText(arg_15_0, arg_15_1)
	return string.format("<color=%s>%s</color>", arg_15_1, arg_15_0)
end

function var_0_0.getRemindFourNumberFloat(arg_16_0)
	return arg_16_0 - arg_16_0 % 0.0001
end

function var_0_0.activateExtend()
	return
end

function var_0_0.CreateObjList(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5, arg_18_6, arg_18_7)
	if var_0_0.isNil(arg_18_3) and not var_0_0.isNil(arg_18_4) then
		arg_18_3 = arg_18_4.transform.parent.gameObject
	end

	local var_18_0
	local var_18_1 = #arg_18_2
	local var_18_2 = arg_18_3.transform

	arg_18_6 = arg_18_6 or 1
	arg_18_7 = arg_18_7 or var_18_1

	local var_18_3 = 0

	if arg_18_6 > 1 then
		for iter_18_0 = 1, arg_18_6 - 1 do
			local var_18_4

			if arg_18_2[iter_18_0] then
				local var_18_5 = var_18_2.childCount >= iter_18_0 + var_18_3 and var_18_2:GetChild(iter_18_0 - 1 + var_18_3).gameObject

				if var_18_5 == arg_18_4 then
					var_0_0.setActive(var_18_5, false)

					var_18_3 = var_18_3 + 1
					var_18_0 = var_18_5

					break
				end
			end
		end
	end

	for iter_18_1 = arg_18_6, arg_18_7 do
		local var_18_6

		if arg_18_2[iter_18_1] then
			local var_18_7 = var_18_2.childCount >= iter_18_1 + var_18_3 and var_18_2:GetChild(iter_18_1 - 1 + var_18_3).gameObject or var_0_0.clone(arg_18_4, arg_18_3, iter_18_1)

			if var_18_7 == arg_18_4 then
				var_0_0.setActive(var_18_7, false)

				var_18_3 = var_18_3 + 1
				var_18_0 = var_18_7
				var_18_7 = var_18_2.childCount >= iter_18_1 + var_18_3 and var_18_2:GetChild(iter_18_1 - 1 + var_18_3).gameObject or var_0_0.clone(arg_18_4, arg_18_3, iter_18_1)
			end

			var_0_0.setActive(var_18_7, true)

			if arg_18_1 then
				if arg_18_5 then
					arg_18_1(arg_18_0, MonoHelper.addNoUpdateLuaComOnceToGo(var_18_7, arg_18_5), arg_18_2[iter_18_1], iter_18_1)
				else
					arg_18_1(arg_18_0, var_18_7, arg_18_2[iter_18_1], iter_18_1)
				end
			end
		else
			arg_18_7 = iter_18_1 - 1

			break
		end
	end

	arg_18_6 = arg_18_7 + 1 + var_18_3
	arg_18_6 = arg_18_6 < 1 and 1 or arg_18_6

	for iter_18_2 = arg_18_6, var_18_2.childCount do
		local var_18_8 = var_18_2:GetChild(iter_18_2 - 1)
		local var_18_9 = var_18_8 and var_18_8.gameObject

		if var_18_9 then
			var_0_0.setActive(var_18_9, false)
		end
	end

	if var_18_0 then
		var_18_0.transform:SetSiblingIndex(var_18_2.childCount - 1)
	end
end

function var_0_0.CreateNumObjList(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.transform
	local var_19_1 = var_19_0.childCount
	local var_19_2 = var_19_1 <= arg_19_2 and arg_19_2 or var_19_1

	for iter_19_0 = 1, var_19_2 do
		local var_19_3

		if iter_19_0 <= arg_19_2 then
			local var_19_4 = iter_19_0 <= var_19_1 and var_19_0:GetChild(iter_19_0 - 1).gameObject or var_0_0.clone(arg_19_1, arg_19_0, iter_19_0)

			var_0_0.setActive(var_19_4, true)
		else
			local var_19_5 = iter_19_0 <= var_19_1 and var_19_0:GetChild(iter_19_0 - 1).gameObject

			if var_19_5 then
				var_0_0.setActive(var_19_5, false)
			end
		end
	end
end

function var_0_0.removeComponent(arg_20_0, arg_20_1)
	var_0_3.RemoveComponent(arg_20_0, arg_20_1)
end

function var_0_0.enableAkListener(arg_21_0, arg_21_1)
	if arg_21_1 then
		ZProj.AudioHelper.EnableAkListener(arg_21_0)
	else
		ZProj.AudioHelper.DisableAkListener(arg_21_0)
	end
end

function var_0_0.addAkGameObject(arg_22_0)
	ZProj.AudioHelper.AddAkGameObject(arg_22_0)
end

function var_0_0.fitScreenOffset(arg_23_0)
	ZProj.UGUIHelper.RebuildLayout(arg_23_0)

	local var_23_0 = ViewMgr.instance:getUIRoot().transform
	local var_23_1 = recthelper.getWidth(var_23_0)
	local var_23_2 = recthelper.getHeight(var_23_0)
	local var_23_3 = var_23_1 / var_23_2 < 1.7777777777777777 and 1080 or var_23_2
	local var_23_4
	local var_23_5
	local var_23_6
	local var_23_7
	local var_23_8 = arg_23_0.gameObject:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic))

	if var_23_8 then
		local var_23_9 = var_23_8:GetEnumerator()

		while var_23_9:MoveNext() do
			local var_23_10 = var_23_9.Current.gameObject:GetComponent(typeof(UnityEngine.RectTransform))
			local var_23_11 = var_23_0:InverseTransformPoint(var_23_10.position)
			local var_23_12 = var_23_11.x - var_23_10.pivot.x * recthelper.getWidth(var_23_10)
			local var_23_13 = var_23_11.x + (1 - var_23_10.pivot.x) * recthelper.getWidth(var_23_10)
			local var_23_14 = var_23_11.y + (1 - var_23_10.pivot.y) * recthelper.getHeight(var_23_10)
			local var_23_15 = var_23_11.y - var_23_10.pivot.y * recthelper.getHeight(var_23_10)

			var_23_4 = var_23_4 or var_23_12

			if var_23_12 < var_23_4 then
				var_23_4 = var_23_12
			end

			var_23_5 = var_23_5 or var_23_13

			if var_23_5 < var_23_13 then
				var_23_5 = var_23_13
			end

			var_23_6 = var_23_6 or var_23_15

			if var_23_15 < var_23_6 then
				var_23_6 = var_23_15
			end

			var_23_7 = var_23_7 or var_23_14

			if var_23_7 < var_23_14 then
				var_23_7 = var_23_14
			end
		end
	end

	local var_23_16 = var_23_1 / 2
	local var_23_17 = var_23_3 / 2
	local var_23_18 = false

	if var_23_4 < -var_23_16 then
		var_23_18 = true

		recthelper.setAnchorX(arg_23_0, recthelper.getAnchorX(arg_23_0) - (var_23_4 + var_23_16))
	elseif var_23_16 < var_23_5 then
		var_23_18 = true

		recthelper.setAnchorX(arg_23_0, recthelper.getAnchorX(arg_23_0) - (var_23_5 - var_23_16))
	end

	if var_23_6 < -var_23_17 then
		var_23_18 = true

		recthelper.setAnchorY(arg_23_0, recthelper.getAnchorY(arg_23_0) - (var_23_6 + var_23_17))
	elseif var_23_17 < var_23_7 then
		var_23_18 = true

		recthelper.setAnchorY(arg_23_0, recthelper.getAnchorY(arg_23_0) - (var_23_7 - var_23_17))
	end

	return var_23_18
end

function var_0_0.addChildPosStay(arg_24_0, arg_24_1)
	if var_0_0.isNil(arg_24_1) then
		return
	end

	if var_0_0.isNil(arg_24_0) then
		arg_24_1.transform:SetParent(nil, true)
	else
		arg_24_1.transform:SetParent(arg_24_0.transform, true)
	end
end

function var_0_0.addBoxCollider2D(arg_25_0, arg_25_1)
	local var_25_0 = var_0_0.onceAddComponent(arg_25_0, typeof(UnityEngine.BoxCollider2D))

	var_25_0.enabled = true
	var_25_0.size = arg_25_1 or Vector2(1.5, 1.5)

	return var_25_0
end

function var_0_0.fitScrollItemOffset(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = ViewMgr.instance:getUIRoot().transform
	local var_26_1 = arg_26_0:GetComponent(typeof(UnityEngine.RectTransform))
	local var_26_2 = var_26_0:InverseTransformPoint(var_26_1.position)
	local var_26_3 = transformhelper.getLocalScale(arg_26_0.transform) * var_0_0.getTotalParentScale(arg_26_0)
	local var_26_4 = var_26_2.x - var_26_1.pivot.x * recthelper.getWidth(var_26_1) * var_26_3
	local var_26_5 = var_26_2.x + (1 - var_26_1.pivot.x) * recthelper.getWidth(var_26_1) * var_26_3
	local var_26_6 = var_26_2.y + (1 - var_26_1.pivot.y) * recthelper.getHeight(var_26_1) * var_26_3
	local var_26_7 = var_26_2.y - var_26_1.pivot.y * recthelper.getHeight(var_26_1) * var_26_3
	local var_26_8 = 100000
	local var_26_9 = -100000
	local var_26_10 = 100000
	local var_26_11 = -100000
	local var_26_12 = 0
	local var_26_13 = arg_26_2:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic))

	if var_26_13 then
		local var_26_14 = var_26_13:GetEnumerator()

		while var_26_14:MoveNext() do
			local var_26_15 = var_26_14.Current.gameObject

			if var_26_15:GetComponent(var_0_0.Type_ParticleSystem) == nil then
				local var_26_16 = var_26_15:GetComponent(typeof(UnityEngine.RectTransform))
				local var_26_17 = transformhelper.getLocalScale(var_26_15.transform) * var_0_0.getTotalParentScale(var_26_15)
				local var_26_18 = var_26_0:InverseTransformPoint(var_26_16.position)
				local var_26_19 = var_26_18.x - var_26_16.pivot.x * recthelper.getWidth(var_26_16) * var_26_17
				local var_26_20 = var_26_18.x + (1 - var_26_16.pivot.x) * recthelper.getWidth(var_26_16) * var_26_17
				local var_26_21 = var_26_18.y + (1 - var_26_16.pivot.y) * recthelper.getHeight(var_26_16) * var_26_17
				local var_26_22 = var_26_18.y - var_26_16.pivot.y * recthelper.getHeight(var_26_16) * var_26_17

				var_26_8 = math.min(var_26_8, var_26_19)
				var_26_9 = math.max(var_26_9, var_26_20)
				var_26_10 = math.min(var_26_10, var_26_22)
				var_26_11 = math.max(var_26_11, var_26_21)
			end
		end
	end

	if arg_26_3 == ScrollEnum.ScrollDirH then
		if var_26_8 < var_26_4 then
			var_26_12 = var_26_4 - var_26_8
		end

		if var_26_5 < var_26_9 then
			var_26_12 = var_26_5 - var_26_9
		end
	elseif arg_26_3 == ScrollEnum.ScrollDirV then
		if var_26_10 < var_26_7 then
			var_26_12 = var_26_7 - var_26_10
		end

		if var_26_6 < var_26_11 then
			var_26_12 = var_26_6 - var_26_11
		end
	end

	return var_26_12 / var_0_0.getTotalParentScale(arg_26_1)
end

function var_0_0.getTotalParentScale(arg_27_0)
	local var_27_0 = arg_27_0.transform.parent.gameObject
	local var_27_1 = transformhelper.getLocalScale(var_27_0.transform)

	while var_27_0.transform.parent.gameObject.name ~= "UIRoot" do
		var_27_0 = var_27_0.transform.parent.gameObject
		var_27_1 = var_27_1 * transformhelper.getLocalScale(var_27_0.transform)
	end

	return var_27_1
end

function var_0_0.isMouseOverGo(arg_28_0, arg_28_1)
	if not arg_28_0 then
		return false
	end

	local var_28_0 = arg_28_0.transform
	local var_28_1 = recthelper.getWidth(var_28_0)
	local var_28_2 = recthelper.getHeight(var_28_0)

	arg_28_1 = arg_28_1 or GamepadController.instance:getMousePosition()

	local var_28_3 = recthelper.screenPosToAnchorPos(arg_28_1, var_28_0)
	local var_28_4 = var_28_0.pivot

	if var_28_3.x >= -var_28_1 * var_28_4.x and var_28_3.x <= var_28_1 * (1 - var_28_4.x) and var_28_3.y <= var_28_2 * var_28_4.x and var_28_3.y >= -var_28_2 * (1 - var_28_4.x) then
		return true
	end

	return false
end

function var_0_0.removeEffectNode(arg_29_0)
	if not arg_29_0 then
		return
	end

	local var_29_0 = GameGlobalMgr.instance:getScreenState():getLocalQuality()
	local var_29_1 = var_29_0 == ModuleEnum.Performance.Middle or var_29_0 == ModuleEnum.Performance.Low
	local var_29_2 = var_29_0 == ModuleEnum.Performance.Low

	if var_29_1 or var_29_2 then
		var_0_0._deleteLodNode(arg_29_0.transform, var_29_1, var_29_2)
	end
end

function var_0_0._deleteLodNode(arg_30_0, arg_30_1, arg_30_2)
	for iter_30_0 = arg_30_0.childCount - 1, 0, -1 do
		local var_30_0 = arg_30_0:GetChild(iter_30_0)

		if arg_30_1 and string.find(var_30_0.name, "^h_") then
			var_0_0.destroy(var_30_0.gameObject)
		elseif arg_30_2 and string.find(var_30_0.name, "^m_") then
			var_0_0.destroy(var_30_0.gameObject)
		else
			var_0_0._deleteLodNode(var_30_0, arg_30_1, arg_30_2)
		end
	end
end

function var_0_0.getParent(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0

	for iter_31_0 = 1, arg_31_1 do
		if not var_31_0 then
			return
		end

		var_31_0 = var_31_0.parent
	end

	return var_31_0
end

function var_0_0.getChildDynamicSizeText(arg_32_0, arg_32_1)
	local var_32_0 = var_0_0.findChild(arg_32_0, arg_32_1)

	return var_0_4.Get(var_32_0)
end

function var_0_0.findChildDynamicSizeText(arg_33_0, arg_33_1)
	return var_0_0.findChildComponent(arg_33_0, arg_33_1, var_0_0.Type_LangTextDynamicSize)
end

function var_0_0.getDynamicSizeText(arg_34_0)
	return arg_34_0:GetComponent(var_0_0.Type_LangTextDynamicSize)
end

function var_0_0.getUIScreenWidth()
	local var_35_0 = UnityEngine.GameObject.Find("UIRoot/POPUP_TOP")

	if var_35_0 then
		return recthelper.getWidth(var_35_0.transform)
	end

	local var_35_1 = 1080 / UnityEngine.Screen.height

	return (math.floor(UnityEngine.Screen.width * var_35_1 + 0.5))
end

return var_0_0
