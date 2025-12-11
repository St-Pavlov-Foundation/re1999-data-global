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
var_0_0.Type_Spine_SkeletonAnimation = typeof(Spine.Unity.SkeletonAnimation)
var_0_0.Type_Spine_SkeletonGraphic = typeof(Spine.Unity.SkeletonGraphic)
var_0_0.Type_UIFollower = typeof(ZProj.UIFollower)

local var_0_1 = SLFramework.UGUI.ButtonWrap
local var_0_2 = SLFramework.UGUI.UIClickListener
local var_0_3 = ZProj.GameHelper
local var_0_4 = ZProj.LangTextDynamicSize
local var_0_5 = SLFramework.UGUI.UIDragListener
local var_0_6 = ZProj.TextMeshInputFieldWrap
local var_0_7 = ZProj.ScrollbarWrap
local var_0_8 = ZProj.DropdownWrap
local var_0_9 = ZProj.TMPDropdownWrap

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

function var_0_0.findComponentAnim(arg_7_0)
	if var_0_0.isNil(arg_7_0) then
		logError("gohelper.findComponentAnimator: go is nil")

		return nil
	end

	return arg_7_0:GetComponent(var_0_0.Type_Animator)
end

function var_0_0.getClickWithAudio(arg_8_0, arg_8_1)
	local var_8_0 = var_0_2.Get(arg_8_0)

	if var_8_0 and arg_8_1 then
		var_0_0.addUIClickAudio(var_8_0.gameObject, arg_8_1)
	end

	return var_8_0
end

function var_0_0.getClickWithDefaultAudio(arg_9_0)
	return var_0_0.getClickWithAudio(arg_9_0, AudioEnum.UI.UI_Common_Click)
end

function var_0_0.findChildClickWithDefaultAudio(arg_10_0, arg_10_1)
	return var_0_0.findChildClickWithAudio(arg_10_0, arg_10_1, AudioEnum.UI.UI_Common_Click)
end

function var_0_0.findChildTextMeshInputField(arg_11_0, arg_11_1)
	return var_0_6.GetWithPath(arg_11_0, arg_11_1)
end

function var_0_0.findChildDropdown(arg_12_0, arg_12_1)
	return var_0_8.GetWithPath(arg_12_0, arg_12_1) or var_0_9.GetWithPath(arg_12_0, arg_12_1)
end

function var_0_0.findChildScrollbar(arg_13_0, arg_13_1)
	return var_0_7.GetWithPath(arg_13_0, arg_13_1)
end

function var_0_0.findChildUIMesh(arg_14_0, arg_14_1)
	if string.nilorempty(arg_14_1) then
		return arg_14_0:GetComponent(typeof(UIMesh))
	end

	local var_14_0 = var_0_0.findChild(arg_14_0, arg_14_1)

	if var_14_0 then
		return var_14_0:GetComponent(typeof(UIMesh))
	end
end

function var_0_0.findChildUIDragListener(arg_15_0, arg_15_1)
	if string.nilorempty(arg_15_1) then
		return var_0_5.Get(arg_15_0)
	else
		return var_0_5.GetWithPath(arg_15_0, arg_15_1)
	end
end

function var_0_0.setActiveCanvasGroup(arg_16_0, arg_16_1)
	var_0_3.SetActiveCanvasGroup(arg_16_0, arg_16_1)
end

function var_0_0.setActiveCanvasGroupNoAnchor(arg_17_0, arg_17_1)
	if var_0_0.isNil(arg_17_0) then
		return
	end

	arg_17_0.alpha = arg_17_1 and 1 or 0
	arg_17_0.interactable = arg_17_1 and true or false
	arg_17_0.blocksRaycasts = arg_17_1 and true or false
end

function var_0_0.getRichColorText(arg_18_0, arg_18_1)
	return string.format("<color=%s>%s</color>", arg_18_1, arg_18_0)
end

function var_0_0.getRemindFourNumberFloat(arg_19_0)
	return arg_19_0 - arg_19_0 % 0.0001
end

function var_0_0.activateExtend()
	return
end

function var_0_0.CreateObjList(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5, arg_21_6, arg_21_7, arg_21_8)
	if var_0_0.isNil(arg_21_3) and not var_0_0.isNil(arg_21_4) then
		arg_21_3 = arg_21_4.transform.parent.gameObject
	end

	local var_21_0
	local var_21_1 = #arg_21_2
	local var_21_2 = arg_21_3.transform

	arg_21_6 = arg_21_6 or 1
	arg_21_7 = arg_21_7 or var_21_1
	arg_21_8 = arg_21_8 or 0

	if arg_21_6 > 1 then
		for iter_21_0 = 1, arg_21_6 - 1 do
			local var_21_3

			if arg_21_2[iter_21_0] then
				local var_21_4 = var_21_2.childCount >= iter_21_0 + arg_21_8 and var_21_2:GetChild(iter_21_0 - 1 + arg_21_8).gameObject

				if var_21_4 == arg_21_4 then
					var_0_0.setActive(var_21_4, false)

					arg_21_8 = arg_21_8 + 1
					var_21_0 = var_21_4

					break
				end
			end
		end
	end

	for iter_21_1 = arg_21_6, arg_21_7 do
		local var_21_5

		if arg_21_2[iter_21_1] then
			local var_21_6 = var_21_2.childCount >= iter_21_1 + arg_21_8 and var_21_2:GetChild(iter_21_1 - 1 + arg_21_8).gameObject or var_0_0.clone(arg_21_4, arg_21_3, iter_21_1)

			if var_21_6 == arg_21_4 then
				var_0_0.setActive(var_21_6, false)

				arg_21_8 = arg_21_8 + 1
				var_21_0 = var_21_6
				var_21_6 = var_21_2.childCount >= iter_21_1 + arg_21_8 and var_21_2:GetChild(iter_21_1 - 1 + arg_21_8).gameObject or var_0_0.clone(arg_21_4, arg_21_3, iter_21_1)
			end

			var_0_0.setActive(var_21_6, true)

			if arg_21_1 then
				if arg_21_5 then
					arg_21_1(arg_21_0, MonoHelper.addNoUpdateLuaComOnceToGo(var_21_6, arg_21_5), arg_21_2[iter_21_1], iter_21_1)
				else
					arg_21_1(arg_21_0, var_21_6, arg_21_2[iter_21_1], iter_21_1)
				end
			end
		else
			arg_21_7 = iter_21_1 - 1

			break
		end
	end

	arg_21_6 = arg_21_7 + 1 + arg_21_8
	arg_21_6 = arg_21_6 < 1 and 1 or arg_21_6

	for iter_21_2 = arg_21_6, var_21_2.childCount do
		local var_21_7 = var_21_2:GetChild(iter_21_2 - 1)
		local var_21_8 = var_21_7 and var_21_7.gameObject

		if var_21_8 then
			var_0_0.setActive(var_21_8, false)
		end
	end

	if var_21_0 then
		var_21_0.transform:SetSiblingIndex(var_21_2.childCount - 1)
	end
end

function var_0_0.CreateNumObjList(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0.transform
	local var_22_1 = var_22_0.childCount
	local var_22_2 = var_22_1 <= arg_22_2 and arg_22_2 or var_22_1

	for iter_22_0 = 1, var_22_2 do
		local var_22_3

		if iter_22_0 <= arg_22_2 then
			local var_22_4 = iter_22_0 <= var_22_1 and var_22_0:GetChild(iter_22_0 - 1).gameObject or var_0_0.clone(arg_22_1, arg_22_0, iter_22_0)

			var_0_0.setActive(var_22_4, true)
		else
			local var_22_5 = iter_22_0 <= var_22_1 and var_22_0:GetChild(iter_22_0 - 1).gameObject

			if var_22_5 then
				var_0_0.setActive(var_22_5, false)
			end
		end
	end
end

function var_0_0.removeComponent(arg_23_0, arg_23_1)
	var_0_3.RemoveComponent(arg_23_0, arg_23_1)
end

function var_0_0.enableAkListener(arg_24_0, arg_24_1)
	if arg_24_1 then
		ZProj.AudioHelper.EnableAkListener(arg_24_0)
	else
		ZProj.AudioHelper.DisableAkListener(arg_24_0)
	end
end

function var_0_0.addAkGameObject(arg_25_0)
	ZProj.AudioHelper.AddAkGameObject(arg_25_0)
end

function var_0_0.fitScreenOffset(arg_26_0)
	ZProj.UGUIHelper.RebuildLayout(arg_26_0)

	local var_26_0 = ViewMgr.instance:getUIRoot().transform
	local var_26_1 = recthelper.getWidth(var_26_0)
	local var_26_2 = recthelper.getHeight(var_26_0)
	local var_26_3 = var_26_1 / var_26_2 < 1.7777777777777777 and 1080 or var_26_2
	local var_26_4
	local var_26_5
	local var_26_6
	local var_26_7
	local var_26_8 = arg_26_0.gameObject:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic))

	if var_26_8 then
		local var_26_9 = var_26_8:GetEnumerator()

		while var_26_9:MoveNext() do
			local var_26_10 = var_26_9.Current.gameObject:GetComponent(typeof(UnityEngine.RectTransform))
			local var_26_11 = var_26_0:InverseTransformPoint(var_26_10.position)
			local var_26_12 = var_26_11.x - var_26_10.pivot.x * recthelper.getWidth(var_26_10)
			local var_26_13 = var_26_11.x + (1 - var_26_10.pivot.x) * recthelper.getWidth(var_26_10)
			local var_26_14 = var_26_11.y + (1 - var_26_10.pivot.y) * recthelper.getHeight(var_26_10)
			local var_26_15 = var_26_11.y - var_26_10.pivot.y * recthelper.getHeight(var_26_10)

			var_26_4 = var_26_4 or var_26_12

			if var_26_12 < var_26_4 then
				var_26_4 = var_26_12
			end

			var_26_5 = var_26_5 or var_26_13

			if var_26_5 < var_26_13 then
				var_26_5 = var_26_13
			end

			var_26_6 = var_26_6 or var_26_15

			if var_26_15 < var_26_6 then
				var_26_6 = var_26_15
			end

			var_26_7 = var_26_7 or var_26_14

			if var_26_7 < var_26_14 then
				var_26_7 = var_26_14
			end
		end
	end

	local var_26_16 = var_26_1 / 2
	local var_26_17 = var_26_3 / 2
	local var_26_18 = false

	if var_26_4 < -var_26_16 then
		var_26_18 = true

		recthelper.setAnchorX(arg_26_0, recthelper.getAnchorX(arg_26_0) - (var_26_4 + var_26_16))
	elseif var_26_16 < var_26_5 then
		var_26_18 = true

		recthelper.setAnchorX(arg_26_0, recthelper.getAnchorX(arg_26_0) - (var_26_5 - var_26_16))
	end

	if var_26_6 < -var_26_17 then
		var_26_18 = true

		recthelper.setAnchorY(arg_26_0, recthelper.getAnchorY(arg_26_0) - (var_26_6 + var_26_17))
	elseif var_26_17 < var_26_7 then
		var_26_18 = true

		recthelper.setAnchorY(arg_26_0, recthelper.getAnchorY(arg_26_0) - (var_26_7 - var_26_17))
	end

	return var_26_18
end

function var_0_0.addChildPosStay(arg_27_0, arg_27_1)
	if var_0_0.isNil(arg_27_1) then
		return
	end

	if var_0_0.isNil(arg_27_0) then
		arg_27_1.transform:SetParent(nil, true)
	else
		arg_27_1.transform:SetParent(arg_27_0.transform, true)
	end
end

function var_0_0.addBoxCollider2D(arg_28_0, arg_28_1)
	local var_28_0 = var_0_0.onceAddComponent(arg_28_0, typeof(UnityEngine.BoxCollider2D))

	var_28_0.enabled = true
	var_28_0.size = arg_28_1 or Vector2(1.5, 1.5)

	return var_28_0
end

function var_0_0.fitScrollItemOffset(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = ViewMgr.instance:getUIRoot().transform
	local var_29_1 = arg_29_0:GetComponent(typeof(UnityEngine.RectTransform))
	local var_29_2 = var_29_0:InverseTransformPoint(var_29_1.position)
	local var_29_3 = transformhelper.getLocalScale(arg_29_0.transform) * var_0_0.getTotalParentScale(arg_29_0)
	local var_29_4 = var_29_2.x - var_29_1.pivot.x * recthelper.getWidth(var_29_1) * var_29_3
	local var_29_5 = var_29_2.x + (1 - var_29_1.pivot.x) * recthelper.getWidth(var_29_1) * var_29_3
	local var_29_6 = var_29_2.y + (1 - var_29_1.pivot.y) * recthelper.getHeight(var_29_1) * var_29_3
	local var_29_7 = var_29_2.y - var_29_1.pivot.y * recthelper.getHeight(var_29_1) * var_29_3
	local var_29_8 = 100000
	local var_29_9 = -100000
	local var_29_10 = 100000
	local var_29_11 = -100000
	local var_29_12 = 0
	local var_29_13 = arg_29_2:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic))

	if var_29_13 then
		local var_29_14 = var_29_13:GetEnumerator()

		while var_29_14:MoveNext() do
			local var_29_15 = var_29_14.Current.gameObject

			if var_29_15:GetComponent(var_0_0.Type_ParticleSystem) == nil then
				local var_29_16 = var_29_15:GetComponent(typeof(UnityEngine.RectTransform))
				local var_29_17 = transformhelper.getLocalScale(var_29_15.transform) * var_0_0.getTotalParentScale(var_29_15)
				local var_29_18 = var_29_0:InverseTransformPoint(var_29_16.position)
				local var_29_19 = var_29_18.x - var_29_16.pivot.x * recthelper.getWidth(var_29_16) * var_29_17
				local var_29_20 = var_29_18.x + (1 - var_29_16.pivot.x) * recthelper.getWidth(var_29_16) * var_29_17
				local var_29_21 = var_29_18.y + (1 - var_29_16.pivot.y) * recthelper.getHeight(var_29_16) * var_29_17
				local var_29_22 = var_29_18.y - var_29_16.pivot.y * recthelper.getHeight(var_29_16) * var_29_17

				var_29_8 = math.min(var_29_8, var_29_19)
				var_29_9 = math.max(var_29_9, var_29_20)
				var_29_10 = math.min(var_29_10, var_29_22)
				var_29_11 = math.max(var_29_11, var_29_21)
			end
		end
	end

	if arg_29_3 == ScrollEnum.ScrollDirH then
		if var_29_8 < var_29_4 then
			var_29_12 = var_29_4 - var_29_8
		end

		if var_29_5 < var_29_9 then
			var_29_12 = var_29_5 - var_29_9
		end
	elseif arg_29_3 == ScrollEnum.ScrollDirV then
		if var_29_10 < var_29_7 then
			var_29_12 = var_29_7 - var_29_10
		end

		if var_29_6 < var_29_11 then
			var_29_12 = var_29_6 - var_29_11
		end
	end

	return var_29_12 / var_0_0.getTotalParentScale(arg_29_1)
end

function var_0_0.getTotalParentScale(arg_30_0)
	local var_30_0 = arg_30_0.transform.parent.gameObject
	local var_30_1 = transformhelper.getLocalScale(var_30_0.transform)

	while var_30_0.transform.parent.gameObject.name ~= "UIRoot" do
		var_30_0 = var_30_0.transform.parent.gameObject
		var_30_1 = var_30_1 * transformhelper.getLocalScale(var_30_0.transform)
	end

	return var_30_1
end

function var_0_0.isMouseOverGo(arg_31_0, arg_31_1)
	if not arg_31_0 then
		return false
	end

	local var_31_0 = arg_31_0.transform
	local var_31_1 = recthelper.getWidth(var_31_0)
	local var_31_2 = recthelper.getHeight(var_31_0)

	arg_31_1 = arg_31_1 or GamepadController.instance:getMousePosition()

	local var_31_3 = recthelper.screenPosToAnchorPos(arg_31_1, var_31_0)
	local var_31_4 = var_31_0.pivot

	if var_31_3.x >= -var_31_1 * var_31_4.x and var_31_3.x <= var_31_1 * (1 - var_31_4.x) and var_31_3.y <= var_31_2 * (1 - var_31_4.y) and var_31_3.y >= -var_31_2 * var_31_4.y then
		return true
	end

	return false
end

function var_0_0.removeEffectNode(arg_32_0)
	if not arg_32_0 then
		return
	end

	local var_32_0 = GameGlobalMgr.instance:getScreenState():getLocalQuality()
	local var_32_1 = var_32_0 == ModuleEnum.Performance.Middle or var_32_0 == ModuleEnum.Performance.Low
	local var_32_2 = var_32_0 == ModuleEnum.Performance.Low

	if var_32_1 or var_32_2 then
		var_0_0._deleteLodNode(arg_32_0.transform, var_32_1, var_32_2)
	end
end

function var_0_0._deleteLodNode(arg_33_0, arg_33_1, arg_33_2)
	for iter_33_0 = arg_33_0.childCount - 1, 0, -1 do
		local var_33_0 = arg_33_0:GetChild(iter_33_0)

		if arg_33_1 and string.find(var_33_0.name, "^h_") then
			var_0_0.destroy(var_33_0.gameObject)
		elseif arg_33_2 and string.find(var_33_0.name, "^m_") then
			var_0_0.destroy(var_33_0.gameObject)
		else
			var_0_0._deleteLodNode(var_33_0, arg_33_1, arg_33_2)
		end
	end
end

function var_0_0.getParent(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0

	for iter_34_0 = 1, arg_34_1 do
		if not var_34_0 then
			return
		end

		var_34_0 = var_34_0.parent
	end

	return var_34_0
end

function var_0_0.getChildDynamicSizeText(arg_35_0, arg_35_1)
	local var_35_0 = var_0_0.findChild(arg_35_0, arg_35_1)

	return var_0_4.Get(var_35_0)
end

function var_0_0.findChildDynamicSizeText(arg_36_0, arg_36_1)
	return var_0_0.findChildComponent(arg_36_0, arg_36_1, var_0_0.Type_LangTextDynamicSize)
end

function var_0_0.getDynamicSizeText(arg_37_0)
	return arg_37_0:GetComponent(var_0_0.Type_LangTextDynamicSize)
end

function var_0_0.getUIScreenWidth()
	local var_38_0 = UnityEngine.GameObject.Find("UIRoot/POPUP_TOP")

	if var_38_0 then
		return recthelper.getWidth(var_38_0.transform)
	end

	local var_38_1 = 1080 / UnityEngine.Screen.height

	return (math.floor(UnityEngine.Screen.width * var_38_1 + 0.5))
end

return var_0_0
