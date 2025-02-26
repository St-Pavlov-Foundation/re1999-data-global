module("modules.ugui.textmeshpro.TMPFadeInWithScroll", package.seeall)

slot0 = class("TMPFadeInWithScroll", LuaCompBase)
slot1 = 0.03

function slot0.init(slot0, slot1)
	slot0._txtcontentcn = gohelper.findChildText(slot1, "")
	slot0._norDiaGO = slot0._txtcontentcn.transform.parent.gameObject
	slot0._conMat = slot0._txtcontentcn.fontMaterial
	slot0._parentHeight = recthelper.getHeight(slot0._norDiaGO.transform)
	slot0._defaultTxtX, slot0._defaultTxtY = transformhelper.getLocalPos(slot0._txtcontentcn.transform)
	slot2 = UnityEngine.Shader
	slot0._LineMinYId = slot2.PropertyToID("_LineMinY")
	slot0._LineMaxYId = slot2.PropertyToID("_LineMaxY")
end

function slot0.hideDialog(slot0)
	if slot0._conTweenId then
		ZProj.TweenHelper.KillById(slot0._conTweenId)

		slot0._conTweenId = nil
	end

	gohelper.setActive(slot0._norDiaGO, false)

	slot1, slot2, slot3 = transformhelper.getLocalPos(slot0._txtcontentcn.transform)

	transformhelper.setLocalPos(slot0._txtcontentcn.transform, slot1, slot2, 1)
end

function slot0.playNormalText(slot0, slot1, slot2, slot3)
	slot0._conMat:EnableKeyword("_GRADUAL_ON")
	transformhelper.setLocalPosXY(slot0._txtcontentcn.transform, slot0._defaultTxtX, slot0._defaultTxtY)

	slot0._nowPlayHeight = 0
	slot4 = UnityEngine.Screen.height

	slot0._conMat:SetFloat(slot0._LineMinYId, slot4)
	slot0._conMat:SetFloat(slot0._LineMaxYId, slot4)
	gohelper.setActive(slot0._norDiaGO, true)

	slot0._txt = slot1
	slot0._finishCallback = slot2
	slot0._finishCallbackObj = slot3
	slot5, slot6, slot7 = transformhelper.getLocalPos(slot0._txtcontentcn.transform)

	transformhelper.setLocalPos(slot0._txtcontentcn.transform, slot5, slot6, 1)

	slot0._txtcontentcn.text = slot0._txt

	TaskDispatcher.runDelay(slot0._delayShow, slot0, 0)
end

function slot0._delayShow(slot0)
	slot1 = CameraMgr.instance:getUICamera()
	slot2 = slot0._txtcontentcn:GetTextInfo(slot0._txt)
	slot0._textInfo = slot2
	slot0._lineInfoList = {}
	slot3 = 0
	slot4 = slot0._txtcontentcn.transform

	for slot8 = 1, slot2.lineCount do
		slot9 = slot2.lineInfo[slot8 - 1]
		slot10 = slot3 + 1
		slot3 = slot3 + slot9.visibleCharacterCount
		slot11 = slot0._textInfo.characterInfo
		slot12 = slot11[slot9.firstVisibleCharacterIndex]
		slot13 = slot11[slot9.lastVisibleCharacterIndex]
		slot17 = slot1:WorldToScreenPoint(slot4:TransformPoint(slot12.topLeft)).y

		for slot21 = slot9.firstVisibleCharacterIndex, slot9.lastVisibleCharacterIndex do
			if slot1:WorldToScreenPoint(slot4:TransformPoint(slot11[slot21].bottomLeft)).y < slot1:WorldToScreenPoint(slot4:TransformPoint(slot12.bottomLeft)).y then
				slot16 = slot23.y
			end

			if slot17 < slot1:WorldToScreenPoint(slot4:TransformPoint(slot22.topLeft)).y then
				slot17 = slot24.y
			end
		end

		slot14.y = slot16
		slot15.y = slot17

		table.insert(slot0._lineInfoList, {
			slot9,
			slot10,
			slot3,
			slot14,
			slot15,
			slot1:WorldToScreenPoint(slot4:TransformPoint(slot13.bottomRight))
		})
	end

	slot0._curLine = nil
	slot5 = uv0 * slot3

	if slot0._conTweenId then
		ZProj.TweenHelper.KillById(slot0._conTweenId)

		slot0._conTweenId = nil
	end

	slot0._conTweenId = ZProj.TweenHelper.DOTweenFloat(1, slot3, slot5, slot0._conUpdate, slot0.conFinished, slot0, nil, EaseType.Linear)
end

function slot0._conUpdate(slot0, slot1)
	slot2 = UnityEngine.Screen.width
	slot3 = UnityEngine.Screen.height

	for slot7, slot8 in ipairs(slot0._lineInfoList) do
		slot9 = slot8[1]
		slot11 = slot8[3]

		if slot8[2] <= slot1 and slot1 <= slot11 and slot10 ~= slot11 then
			slot12 = slot8[4]
			slot13 = slot8[5]
			slot14 = slot8[6]

			if slot0._curLine ~= slot7 then
				slot0._curLine = slot7
				slot0._nowPlayHeight = recthelper.getHeight(slot0._txtcontentcn.transform) / #slot0._lineInfoList * slot7
				slot15 = 0

				if slot0._parentHeight < slot0._nowPlayHeight then
					slot15 = slot0._nowPlayHeight - slot0._parentHeight
				end

				slot15 = slot15 * slot3 / 1080

				slot0._conMat:SetFloat(slot0._LineMinYId, slot12.y + slot15)
				slot0._conMat:SetFloat(slot0._LineMaxYId, slot13.y + slot15)

				slot16 = slot0._txtcontentcn.gameObject

				gohelper.setActive(slot16, false)
				gohelper.setActive(slot16, true)
			end

			slot16 = Mathf.Lerp(slot12.x, slot14.x, (slot1 - slot10) / (slot11 - slot10))
			slot17 = 0

			if slot0._parentHeight < slot0._nowPlayHeight then
				slot17 = slot0._nowPlayHeight - slot0._parentHeight
			end

			transformhelper.setLocalPos(slot0._txtcontentcn.transform, slot0._defaultTxtX, slot0._defaultTxtY + slot17, 1 - slot16 / slot2)
		end
	end
end

function slot0.isPlaying(slot0)
	return slot0._conTweenId and true or false
end

function slot0.conFinished(slot0)
	if slot0._conTweenId then
		ZProj.TweenHelper.KillById(slot0._conTweenId)

		slot0._conTweenId = nil
	end

	slot0:_disable_GRADUAL_ON()

	slot1, slot2, slot3 = transformhelper.getLocalPos(slot0._txtcontentcn.transform)

	transformhelper.setLocalPos(slot0._txtcontentcn.transform, slot1, slot2, 0)

	if slot0._finishCallback then
		slot0._finishCallback(slot0._finishCallbackObj)
	end
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._delayShow, slot0)

	if slot0._conTweenId then
		ZProj.TweenHelper.KillById(slot0._conTweenId)

		slot0._conTweenId = nil
	end
end

function slot0._disable_GRADUAL_ON(slot0)
	if slot0._txtcontentcn.gameObject:GetComponentsInChildren(gohelper.Type_TMP_SubMeshUI, true) then
		for slot6 = 0, slot1.Length - 1 do
			if not gohelper.isNil(slot1[slot6].sharedMaterial) then
				slot8:DisableKeyword("_GRADUAL_ON")
				slot8:SetFloat(slot0._LineMinYId, 0)
				slot8:SetFloat(slot0._LineMaxYId, 0)
			end
		end
	end

	slot0._conMat:DisableKeyword("_GRADUAL_ON")
	slot0._conMat:SetFloat(slot0._LineMinYId, 0)
	slot0._conMat:SetFloat(slot0._LineMaxYId, 0)
end

return slot0
