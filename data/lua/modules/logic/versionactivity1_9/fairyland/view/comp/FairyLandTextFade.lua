module("modules.logic.versionactivity1_9.fairyland.view.comp.FairyLandTextFade", package.seeall)

slot0 = class("FairyLandTextFade", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.transform = slot1.transform
	slot0.gameObject = slot1
	slot0.parent = slot0.transform.parent
	slot0.text = slot1:GetComponent(gohelper.Type_TextMesh)
	slot0.canvasGroup = gohelper.onceAddComponent(slot0.text.gameObject, typeof(UnityEngine.CanvasGroup))
end

function slot0.setScrollContent(slot0, slot1)
	slot0.scrollContent = slot1
end

function slot0.setText(slot0, slot1)
	slot0:killTween()

	slot0.layoutCallback = slot1.layoutCallback
	slot0.callback = slot1.callback
	slot0.callbackObj = slot1.callbackObj
	slot0.content = slot1.content
	slot0.text.text = slot0.content

	if slot0.layoutCallback then
		slot0.layoutCallback(slot0.callbackObj, slot0.text.preferredHeight)
	end

	if slot1.tween then
		slot0.canvasGroup.alpha = 0

		TaskDispatcher.runDelay(slot0._delayShow, slot0, 0.05)
	else
		slot0:onTextFinished()
	end
end

function slot0._delayShow(slot0)
	slot0:initText()

	slot0.canvasGroup.alpha = 1
	slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(1, slot0.characterCount, slot0.delayTime, slot0.frameCallback, slot0.onTextFinished, slot0, nil, EaseType.Linear)

	slot0:moveContent()
end

function slot0.moveContent(slot0)
	if gohelper.isNil(slot0.scrollContent) then
		return
	end

	slot1 = slot0.scrollContent.transform
	slot2 = recthelper.getHeight(slot1.parent)
	slot0.moveId = ZProj.TweenHelper.DOAnchorPosY(slot1, math.max(math.max(recthelper.getHeight(slot1) - slot2, 0), recthelper.getAnchorY(slot0.transform.parent) + recthelper.getHeight(slot0.transform.parent) - slot2), slot0.delayTime * 0.8, nil, , , EaseType.Linear)
end

function slot0._doCallback(slot0)
	slot0.callback = nil
	slot0.callbackObj = nil

	if slot0.callback then
		slot1(slot0.callbackObj)
	end
end

function slot0.frameCallback(slot0, slot1)
	slot2 = UnityEngine.Screen.width
	slot3 = CameraMgr.instance:getUICamera()
	slot4 = 0

	for slot8, slot9 in ipairs(slot0.lineInfoList) do
		slot10 = slot9[1]
		slot12 = slot9[3]

		if slot9[2] <= slot1 and slot1 <= slot12 then
			slot13 = slot0.textInfo.characterInfo
			slot15 = slot13[slot10.lastVisibleCharacterIndex]
			slot16 = slot3:WorldToScreenPoint(slot0.transform:TransformPoint(slot13[slot10.firstVisibleCharacterIndex].bottomLeft))
			slot17 = slot16

			for slot22 = slot10.firstVisibleCharacterIndex, slot10.lastVisibleCharacterIndex do
				if slot3:WorldToScreenPoint(slot0.transform:TransformPoint(slot13[slot22].bottomLeft)).y < slot16.y then
					slot18 = slot24.y
				end
			end

			slot17.y = slot18
			slot19 = slot3:WorldToScreenPoint(slot0.transform:TransformPoint(slot14.topLeft))
			slot20 = slot19

			for slot25 = slot10.firstVisibleCharacterIndex, slot10.lastVisibleCharacterIndex do
				if slot19.y < slot3:WorldToScreenPoint(slot0.transform:TransformPoint(slot13[slot25].topLeft)).y then
					slot21 = slot27.y
				end
			end

			slot20.y = slot21
			slot22 = slot3:WorldToScreenPoint(slot0.transform:TransformPoint(slot15.bottomRight))

			if slot8 == 1 then
				slot0._conMat:SetFloat(slot0._LineMinYId, slot17.y)

				slot26 = slot20.y + 10

				slot0._conMat:SetFloat(slot0._LineMaxYId, slot26)

				for slot26, slot27 in pairs(slot0._subMeshs) do
					if slot27.materialForRendering then
						slot27.materialForRendering:SetFloat(slot0._LineMinYId, slot17.y)
						slot27.materialForRendering:SetFloat(slot0._LineMaxYId, slot20.y + 10)
						slot27.materialForRendering:EnableKeyword("_GRADUAL_ON")
					end
				end
			else
				slot0._conMat:SetFloat(slot0._LineMinYId, slot17.y)

				slot26 = slot20.y

				slot0._conMat:SetFloat(slot0._LineMaxYId, slot26)

				for slot26, slot27 in pairs(slot0._subMeshs) do
					if slot27.materialForRendering then
						slot27.materialForRendering:SetFloat(slot0._LineMinYId, slot17.y)
						slot27.materialForRendering:SetFloat(slot0._LineMaxYId, slot20.y)
						slot27.materialForRendering:EnableKeyword("_GRADUAL_ON")
					end
				end
			end

			slot23 = slot0.gameObject

			gohelper.setActive(slot23, false)
			gohelper.setActive(slot23, true)
			transformhelper.setLocalPos(slot0.transform, slot0._contentX, slot0._contentY, 1 - Mathf.Lerp(slot17.x - 10, slot22.x + 10, slot11 == slot12 and 1 or (slot1 - slot11) / (slot12 - slot11)) / slot2)
		end
	end
end

function slot0.onTextFinished(slot0)
	slot0:killTween()

	slot0.canvasGroup.alpha = 1

	if slot0.characterCount then
		slot0:frameCallback(slot0.characterCount)
	end

	slot1, slot2, slot3 = transformhelper.getLocalPos(slot0.transform)

	transformhelper.setLocalPos(slot0.transform, slot1, slot2, 0)

	if slot0._conMat then
		slot0._conMat:DisableKeyword("_GRADUAL_ON")
	end

	if slot0._subMeshs then
		for slot7, slot8 in pairs(slot0._subMeshs) do
			if slot8.materialForRendering then
				slot8.materialForRendering:DisableKeyword("_GRADUAL_ON")
			end
		end
	end

	slot0:_doCallback()
end

function slot0.initText(slot0)
	slot0._subMeshs = {}
	slot0._conMat = slot0.text.fontMaterial

	slot0._conMat:EnableKeyword("_GRADUAL_ON")
	slot0._conMat:DisableKeyword("_DISSOLVE_ON")

	slot1 = UnityEngine.Shader
	slot0._LineMinYId = slot1.PropertyToID("_LineMinY")
	slot0._LineMaxYId = slot1.PropertyToID("_LineMaxY")
	slot0._contentX, slot0._contentY, _ = transformhelper.getLocalPos(slot0.transform)

	if slot0.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true) then
		slot3 = slot2:GetEnumerator()

		while slot3:MoveNext() do
			table.insert(slot0._subMeshs, slot3.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI)))
		end
	end

	slot0.textInfo = slot0.text:GetTextInfo(slot0.content)
	slot0.lineInfoList = {}
	slot3 = 0

	for slot7 = 1, slot0.textInfo.lineCount do
		slot8 = slot0.textInfo.lineInfo[slot7 - 1]

		table.insert(slot0.lineInfoList, {
			slot8,
			slot3 + 1,
			slot3 + slot8.visibleCharacterCount
		})
	end

	slot0.characterCount = slot3
	slot0.delayTime = slot0:getDelayTime(slot3)
end

function slot0.getDelayTime(slot0, slot1)
	return 0.08 * slot1 / 4
end

function slot0.killTween(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end

	if slot0.moveId then
		ZProj.TweenHelper.KillById(slot0.moveId)

		slot0.moveId = nil
	end

	TaskDispatcher.cancelTask(slot0._delayShow, slot0)
end

function slot0.onDestroy(slot0)
	slot0:killTween()
end

return slot0
