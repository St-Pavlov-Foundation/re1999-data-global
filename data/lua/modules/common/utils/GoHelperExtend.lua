module("modules.common.utils.GoHelperExtend", package.seeall)

slot0 = gohelper
slot0.Type_UIClickAudio = typeof(ZProj.UIClickAudio)
slot0.Type_CanvasGroup = typeof(UnityEngine.CanvasGroup)
slot0.Type_TMPInputField = typeof(TMPro.TMP_InputField)
slot0.Type_Animator = typeof(UnityEngine.Animator)
slot0.Type_LimitedScrollRect = typeof(ZProj.LimitedScrollRect)
slot0.Type_RectTransform = typeof(UnityEngine.RectTransform)
slot0.Type_Transform = typeof(UnityEngine.Transform)
slot0.Type_ParticleSystem = typeof(UnityEngine.ParticleSystem)
slot0.Type_AnimationEventWrap = typeof(ZProj.AnimationEventWrap)
slot0.Type_Animation = typeof(UnityEngine.Animation)
slot0.Type_TMP_SubMeshUI = typeof(TMPro.TMP_SubMeshUI)
slot0.Type_RectMask2D = typeof(UnityEngine.UI.RectMask2D)
slot0.Type_GridLayoutGroup = typeof(UnityEngine.UI.GridLayoutGroup)
slot0.Type_ContentSizeFitter = typeof(UnityEngine.UI.ContentSizeFitter)
slot0.Type_LangTextDynamicSize = typeof(ZProj.LangTextDynamicSize)
slot1 = SLFramework.UGUI.ButtonWrap
slot2 = SLFramework.UGUI.UIClickListener
slot3 = ZProj.GameHelper
slot4 = ZProj.LangTextDynamicSize

function slot0.addUIClickAudio(slot0, slot1)
	uv0.onceAddComponent(slot0, uv0.Type_UIClickAudio).audioId = slot1 or AudioEnum.UI.UI_Common_Click
end

function slot0.removeUIClickAudio(slot0)
	uv0.onceAddComponent(slot0, uv0.Type_UIClickAudio).audioId = 0
end

function slot0.findChildButtonWithAudio(slot0, slot1, slot2)
	if uv0.GetWithPath(slot0, slot1) then
		uv1.addUIClickAudio(slot3.gameObject, slot2)
	end

	return slot3
end

function slot0.findButtonWithAudio(slot0, slot1)
	if uv0.Get(slot0) then
		uv1.addUIClickAudio(slot2.gameObject, slot1)
	end

	return slot2
end

function slot0.findChildClickWithAudio(slot0, slot1, slot2)
	if uv0.GetWithPath(slot0, slot1) and slot2 then
		uv1.addUIClickAudio(slot3.gameObject, slot2)
	end

	return slot3
end

function slot0.findChildAnim(slot0, slot1)
	if uv0.findChild(slot0, slot1) then
		return slot2:GetComponent(uv0.Type_Animator)
	end
end

function slot0.getClickWithAudio(slot0, slot1)
	if uv0.Get(slot0) and slot1 then
		uv1.addUIClickAudio(slot2.gameObject, slot1)
	end

	return slot2
end

function slot0.getClickWithDefaultAudio(slot0)
	return uv0.getClickWithAudio(slot0, AudioEnum.UI.UI_Common_Click)
end

function slot0.findChildClickWithDefaultAudio(slot0, slot1)
	return uv0.findChildClickWithAudio(slot0, slot1, AudioEnum.UI.UI_Common_Click)
end

function slot0.findChildTextMeshInputField(slot0, slot1)
	return ZProj.TextMeshInputFieldWrap.GetWithPath(slot0, slot1)
end

function slot0.findChildDropdown(slot0, slot1)
	return ZProj.DropdownWrap.GetWithPath(slot0, slot1) or ZProj.TMPDropdownWrap.GetWithPath(slot0, slot1)
end

function slot0.findChildScrollbar(slot0, slot1)
	return ZProj.ScrollbarWrap.GetWithPath(slot0, slot1)
end

function slot0.findChildUIMesh(slot0, slot1)
	if string.nilorempty(slot1) then
		return slot0:GetComponent(typeof(UIMesh))
	end

	if uv0.findChild(slot0, slot1) then
		return slot2:GetComponent(typeof(UIMesh))
	end
end

function slot0.setActiveCanvasGroup(slot0, slot1)
	uv0.SetActiveCanvasGroup(slot0, slot1)
end

function slot0.getRichColorText(slot0, slot1)
	return string.format("<color=%s>%s</color>", slot1, slot0)
end

function slot0.getRemindFourNumberFloat(slot0)
	return slot0 - slot0 % 0.0001
end

function slot0.activateExtend()
end

function slot0.CreateObjList(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	if uv0.isNil(slot3) and not uv0.isNil(slot4) then
		slot3 = slot4.transform.parent.gameObject
	end

	slot8 = nil
	slot10 = slot3.transform
	slot7 = slot7 or #slot2
	slot11 = 0

	if (slot6 or 1) > 1 then
		for slot15 = 1, slot6 - 1 do
			slot16 = nil

			if slot2[slot15] and (slot10.childCount >= slot15 + slot11 and slot10:GetChild(slot15 - 1 + slot11).gameObject) == slot4 then
				uv0.setActive(slot16, false)

				slot11 = slot11 + 1
				slot8 = slot16

				break
			end
		end
	end

	for slot15 = slot6, slot7 do
		slot16 = nil

		if slot2[slot15] then
			if (slot10.childCount >= slot15 + slot11 and slot10:GetChild(slot15 - 1 + slot11).gameObject or uv0.clone(slot4, slot3, slot15)) == slot4 then
				uv0.setActive(slot16, false)

				slot8 = slot16
				slot16 = slot10.childCount >= slot15 + slot11 + 1 and slot10:GetChild(slot15 - 1 + slot11).gameObject or uv0.clone(slot4, slot3, slot15)
			end

			uv0.setActive(slot16, true)

			if slot1 then
				if slot5 then
					slot1(slot0, MonoHelper.addNoUpdateLuaComOnceToGo(slot16, slot5), slot2[slot15], slot15)
				else
					slot1(slot0, slot16, slot2[slot15], slot15)
				end
			end
		else
			slot7 = slot15 - 1

			break
		end
	end

	if slot7 + 1 + slot11 < 1 then
		slot6 = 1
	end

	for slot15 = slot6, slot10.childCount do
		if slot10:GetChild(slot15 - 1) and slot16.gameObject then
			uv0.setActive(slot17, false)
		end
	end

	if slot8 then
		slot8.transform:SetSiblingIndex(slot10.childCount - 1)
	end
end

function slot0.CreateNumObjList(slot0, slot1, slot2)
	for slot9 = 1, slot0.transform.childCount <= slot2 and slot2 or slot4 do
		slot10 = nil

		if slot9 <= slot2 then
			uv0.setActive(slot9 <= slot4 and slot3:GetChild(slot9 - 1).gameObject or uv0.clone(slot1, slot0, slot9), true)
		elseif slot9 <= slot4 and slot3:GetChild(slot9 - 1).gameObject then
			uv0.setActive(slot10, false)
		end
	end
end

function slot0.removeComponent(slot0, slot1)
	uv0.RemoveComponent(slot0, slot1)
end

function slot0.enableAkListener(slot0, slot1)
	if slot1 then
		ZProj.AudioHelper.EnableAkListener(slot0)
	else
		ZProj.AudioHelper.DisableAkListener(slot0)
	end
end

function slot0.addAkGameObject(slot0)
	ZProj.AudioHelper.AddAkGameObject(slot0)
end

function slot0.fitScreenOffset(slot0)
	ZProj.UGUIHelper.RebuildLayout(slot0)

	slot1 = ViewMgr.instance:getUIRoot().transform
	slot4 = recthelper.getWidth(slot1) / recthelper.getHeight(slot1) < 1.7777777777777777 and 1080 or slot3
	slot5, slot6, slot7, slot8 = nil

	if slot0.gameObject:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic)) then
		slot10 = slot9:GetEnumerator()

		while slot10:MoveNext() do
			slot11 = slot10.Current.gameObject:GetComponent(typeof(UnityEngine.RectTransform))
			slot12 = slot1:InverseTransformPoint(slot11.position)
			slot13 = slot12.x - slot11.pivot.x * recthelper.getWidth(slot11)
			slot14 = slot12.x + (1 - slot11.pivot.x) * recthelper.getWidth(slot11)
			slot15 = slot12.y + (1 - slot11.pivot.y) * recthelper.getHeight(slot11)
			slot16 = slot12.y - slot11.pivot.y * recthelper.getHeight(slot11)

			if slot13 < (slot5 or slot13) then
				slot5 = slot13
			end

			if (slot6 or slot14) < slot14 then
				slot6 = slot14
			end

			if slot16 < (slot7 or slot16) then
				slot7 = slot16
			end

			if (slot8 or slot15) < slot15 then
				slot8 = slot15
			end
		end
	end

	slot11 = slot4 / 2
	slot12 = false

	if slot5 < -(slot2 / 2) then
		slot12 = true

		recthelper.setAnchorX(slot0, recthelper.getAnchorX(slot0) - (slot5 + slot10))
	elseif slot10 < slot6 then
		slot12 = true

		recthelper.setAnchorX(slot0, recthelper.getAnchorX(slot0) - (slot6 - slot10))
	end

	if slot7 < -slot11 then
		slot12 = true

		recthelper.setAnchorY(slot0, recthelper.getAnchorY(slot0) - (slot7 + slot11))
	elseif slot11 < slot8 then
		slot12 = true

		recthelper.setAnchorY(slot0, recthelper.getAnchorY(slot0) - (slot8 - slot11))
	end

	return slot12
end

function slot0.addChildPosStay(slot0, slot1)
	if uv0.isNil(slot1) then
		return
	end

	if uv0.isNil(slot0) then
		slot1.transform:SetParent(nil, true)
	else
		slot1.transform:SetParent(slot0.transform, true)
	end
end

function slot0.addBoxCollider2D(slot0, slot1)
	uv0.onceAddComponent(slot0, typeof(UnityEngine.BoxCollider2D)).enabled = true
	slot2.size = slot1 or Vector2(1.5, 1.5)

	return slot2
end

function slot0.fitScrollItemOffset(slot0, slot1, slot2, slot3)
	slot5 = slot0:GetComponent(typeof(UnityEngine.RectTransform))
	slot6 = ViewMgr.instance:getUIRoot().transform:InverseTransformPoint(slot5.position)
	slot7 = transformhelper.getLocalScale(slot0.transform) * uv0.getTotalParentScale(slot0)
	slot8 = slot6.x - slot5.pivot.x * recthelper.getWidth(slot5) * slot7
	slot9 = slot6.x + (1 - slot5.pivot.x) * recthelper.getWidth(slot5) * slot7
	slot10 = slot6.y + (1 - slot5.pivot.y) * recthelper.getHeight(slot5) * slot7
	slot11 = slot6.y - slot5.pivot.y * recthelper.getHeight(slot5) * slot7
	slot12 = 100000
	slot13 = -100000
	slot14 = 100000
	slot15 = -100000
	slot16 = 0

	if slot2:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic)) then
		slot18 = slot17:GetEnumerator()

		while slot18:MoveNext() do
			if slot18.Current.gameObject:GetComponent(uv0.Type_ParticleSystem) == nil then
				slot20 = slot19:GetComponent(typeof(UnityEngine.RectTransform))
				slot21 = transformhelper.getLocalScale(slot19.transform) * uv0.getTotalParentScale(slot19)
				slot22 = slot4:InverseTransformPoint(slot20.position)
				slot12 = math.min(slot12, slot22.x - slot20.pivot.x * recthelper.getWidth(slot20) * slot21)
				slot13 = math.max(slot13, slot22.x + (1 - slot20.pivot.x) * recthelper.getWidth(slot20) * slot21)
				slot14 = math.min(slot14, slot22.y - slot20.pivot.y * recthelper.getHeight(slot20) * slot21)
				slot15 = math.max(slot15, slot22.y + (1 - slot20.pivot.y) * recthelper.getHeight(slot20) * slot21)
			end
		end
	end

	if slot3 == ScrollEnum.ScrollDirH then
		if slot12 < slot8 then
			slot16 = slot8 - slot12
		end

		if slot9 < slot13 then
			slot16 = slot9 - slot13
		end
	elseif slot3 == ScrollEnum.ScrollDirV then
		if slot14 < slot11 then
			slot16 = slot11 - slot14
		end

		if slot10 < slot15 then
			slot16 = slot10 - slot15
		end
	end

	return slot16 / uv0.getTotalParentScale(slot1)
end

function slot0.getTotalParentScale(slot0)
	slot2 = transformhelper.getLocalScale(slot0.transform.parent.gameObject.transform)

	while slot1.transform.parent.gameObject.name ~= "UIRoot" do
		slot2 = slot2 * transformhelper.getLocalScale(slot1.transform.parent.gameObject.transform)
	end

	return slot2
end

function slot0.isMouseOverGo(slot0, slot1)
	if not slot0 then
		return false
	end

	slot2 = slot0.transform
	slot4 = recthelper.getHeight(slot2)

	if recthelper.screenPosToAnchorPos(slot1 or GamepadController.instance:getMousePosition(), slot2).x >= -recthelper.getWidth(slot2) * slot2.pivot.x and slot5.x <= slot3 * (1 - slot6.x) and slot5.y <= slot4 * slot6.x and slot5.y >= -slot4 * (1 - slot6.x) then
		return true
	end

	return false
end

function slot0.removeEffectNode(slot0)
	if not slot0 then
		return
	end

	slot3 = slot1 == ModuleEnum.Performance.Low

	if GameGlobalMgr.instance:getScreenState():getLocalQuality() == ModuleEnum.Performance.Middle or slot1 == ModuleEnum.Performance.Low or slot3 then
		uv0._deleteLodNode(slot0.transform, slot2, slot3)
	end
end

function slot0._deleteLodNode(slot0, slot1, slot2)
	for slot7 = slot0.childCount - 1, 0, -1 do
		slot8 = slot0:GetChild(slot7)

		if slot1 and string.find(slot8.name, "^h_") then
			uv0.destroy(slot8.gameObject)
		elseif slot2 and string.find(slot8.name, "^m_") then
			uv0.destroy(slot8.gameObject)
		else
			uv0._deleteLodNode(slot8, slot1, slot2)
		end
	end
end

function slot0.getParent(slot0, slot1)
	slot2 = slot0

	for slot6 = 1, slot1 do
		if not slot2 then
			return
		end

		slot2 = slot2.parent
	end

	return slot2
end

function slot0.getChildDynamicSizeText(slot0, slot1)
	return uv1.Get(uv0.findChild(slot0, slot1))
end

function slot0.findChildDynamicSizeText(slot0, slot1)
	return uv0.findChildComponent(slot0, slot1, uv0.Type_LangTextDynamicSize)
end

function slot0.getDynamicSizeText(slot0)
	return slot0:GetComponent(uv0.Type_LangTextDynamicSize)
end

function slot0.getUIScreenWidth()
	if UnityEngine.GameObject.Find("UIRoot/POPUP_TOP") then
		return recthelper.getWidth(slot0.transform)
	end

	return math.floor(UnityEngine.Screen.width * 1080 / UnityEngine.Screen.height + 0.5)
end

return slot0
