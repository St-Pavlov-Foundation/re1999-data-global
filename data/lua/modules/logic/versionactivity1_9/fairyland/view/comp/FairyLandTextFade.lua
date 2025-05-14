module("modules.logic.versionactivity1_9.fairyland.view.comp.FairyLandTextFade", package.seeall)

local var_0_0 = class("FairyLandTextFade", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.transform = arg_1_1.transform
	arg_1_0.gameObject = arg_1_1
	arg_1_0.parent = arg_1_0.transform.parent
	arg_1_0.text = arg_1_1:GetComponent(gohelper.Type_TextMesh)
	arg_1_0.canvasGroup = gohelper.onceAddComponent(arg_1_0.text.gameObject, typeof(UnityEngine.CanvasGroup))
end

function var_0_0.setScrollContent(arg_2_0, arg_2_1)
	arg_2_0.scrollContent = arg_2_1
end

function var_0_0.setText(arg_3_0, arg_3_1)
	arg_3_0:killTween()

	arg_3_0.layoutCallback = arg_3_1.layoutCallback
	arg_3_0.callback = arg_3_1.callback
	arg_3_0.callbackObj = arg_3_1.callbackObj
	arg_3_0.content = arg_3_1.content
	arg_3_0.text.text = arg_3_0.content

	local var_3_0 = arg_3_0.text.preferredHeight

	if arg_3_0.layoutCallback then
		arg_3_0.layoutCallback(arg_3_0.callbackObj, var_3_0)
	end

	if arg_3_1.tween then
		arg_3_0.canvasGroup.alpha = 0

		TaskDispatcher.runDelay(arg_3_0._delayShow, arg_3_0, 0.05)
	else
		arg_3_0:onTextFinished()
	end
end

function var_0_0._delayShow(arg_4_0)
	arg_4_0:initText()

	arg_4_0.canvasGroup.alpha = 1
	arg_4_0.tweenId = ZProj.TweenHelper.DOTweenFloat(1, arg_4_0.characterCount, arg_4_0.delayTime, arg_4_0.frameCallback, arg_4_0.onTextFinished, arg_4_0, nil, EaseType.Linear)

	arg_4_0:moveContent()
end

function var_0_0.moveContent(arg_5_0)
	if gohelper.isNil(arg_5_0.scrollContent) then
		return
	end

	local var_5_0 = arg_5_0.scrollContent.transform
	local var_5_1 = recthelper.getHeight(var_5_0.parent)
	local var_5_2 = recthelper.getHeight(var_5_0)
	local var_5_3 = math.max(var_5_2 - var_5_1, 0)
	local var_5_4 = recthelper.getAnchorY(arg_5_0.transform.parent) + recthelper.getHeight(arg_5_0.transform.parent)
	local var_5_5 = math.max(var_5_3, var_5_4 - var_5_1)

	arg_5_0.moveId = ZProj.TweenHelper.DOAnchorPosY(var_5_0, var_5_5, arg_5_0.delayTime * 0.8, nil, nil, nil, EaseType.Linear)
end

function var_0_0._doCallback(arg_6_0)
	local var_6_0 = arg_6_0.callback
	local var_6_1 = arg_6_0.callbackObj

	arg_6_0.callback = nil
	arg_6_0.callbackObj = nil

	if var_6_0 then
		var_6_0(var_6_1)
	end
end

function var_0_0.frameCallback(arg_7_0, arg_7_1)
	local var_7_0 = UnityEngine.Screen.width
	local var_7_1 = CameraMgr.instance:getUICamera()
	local var_7_2 = 0

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.lineInfoList) do
		local var_7_3 = iter_7_1[1]
		local var_7_4 = iter_7_1[2]
		local var_7_5 = iter_7_1[3]

		if var_7_4 <= arg_7_1 and arg_7_1 <= var_7_5 then
			local var_7_6 = arg_7_0.textInfo.characterInfo
			local var_7_7 = var_7_6[var_7_3.firstVisibleCharacterIndex]
			local var_7_8 = var_7_6[var_7_3.lastVisibleCharacterIndex]
			local var_7_9 = var_7_1:WorldToScreenPoint(arg_7_0.transform:TransformPoint(var_7_7.bottomLeft))
			local var_7_10 = var_7_9
			local var_7_11 = var_7_9.y

			for iter_7_2 = var_7_3.firstVisibleCharacterIndex, var_7_3.lastVisibleCharacterIndex do
				local var_7_12 = var_7_6[iter_7_2]
				local var_7_13 = var_7_1:WorldToScreenPoint(arg_7_0.transform:TransformPoint(var_7_12.bottomLeft))

				if var_7_11 > var_7_13.y then
					var_7_11 = var_7_13.y
				end
			end

			var_7_10.y = var_7_11

			local var_7_14 = var_7_1:WorldToScreenPoint(arg_7_0.transform:TransformPoint(var_7_7.topLeft))
			local var_7_15 = var_7_14
			local var_7_16 = var_7_14.y

			for iter_7_3 = var_7_3.firstVisibleCharacterIndex, var_7_3.lastVisibleCharacterIndex do
				local var_7_17 = var_7_6[iter_7_3]
				local var_7_18 = var_7_1:WorldToScreenPoint(arg_7_0.transform:TransformPoint(var_7_17.topLeft))

				if var_7_16 < var_7_18.y then
					var_7_16 = var_7_18.y
				end
			end

			var_7_15.y = var_7_16

			local var_7_19 = var_7_1:WorldToScreenPoint(arg_7_0.transform:TransformPoint(var_7_8.bottomRight))

			if iter_7_0 == 1 then
				arg_7_0._conMat:SetFloat(arg_7_0._LineMinYId, var_7_10.y)
				arg_7_0._conMat:SetFloat(arg_7_0._LineMaxYId, var_7_15.y + 10)

				for iter_7_4, iter_7_5 in pairs(arg_7_0._subMeshs) do
					if iter_7_5.materialForRendering then
						iter_7_5.materialForRendering:SetFloat(arg_7_0._LineMinYId, var_7_10.y)
						iter_7_5.materialForRendering:SetFloat(arg_7_0._LineMaxYId, var_7_15.y + 10)
						iter_7_5.materialForRendering:EnableKeyword("_GRADUAL_ON")
					end
				end
			else
				arg_7_0._conMat:SetFloat(arg_7_0._LineMinYId, var_7_10.y)
				arg_7_0._conMat:SetFloat(arg_7_0._LineMaxYId, var_7_15.y)

				for iter_7_6, iter_7_7 in pairs(arg_7_0._subMeshs) do
					if iter_7_7.materialForRendering then
						iter_7_7.materialForRendering:SetFloat(arg_7_0._LineMinYId, var_7_10.y)
						iter_7_7.materialForRendering:SetFloat(arg_7_0._LineMaxYId, var_7_15.y)
						iter_7_7.materialForRendering:EnableKeyword("_GRADUAL_ON")
					end
				end
			end

			local var_7_20 = arg_7_0.gameObject

			gohelper.setActive(var_7_20, false)
			gohelper.setActive(var_7_20, true)

			local var_7_21 = var_7_4 == var_7_5 and 1 or (arg_7_1 - var_7_4) / (var_7_5 - var_7_4)
			local var_7_22 = 1 - Mathf.Lerp(var_7_10.x - 10, var_7_19.x + 10, var_7_21) / var_7_0

			transformhelper.setLocalPos(arg_7_0.transform, arg_7_0._contentX, arg_7_0._contentY, var_7_22)
		end
	end
end

function var_0_0.onTextFinished(arg_8_0)
	arg_8_0:killTween()

	arg_8_0.canvasGroup.alpha = 1

	if arg_8_0.characterCount then
		arg_8_0:frameCallback(arg_8_0.characterCount)
	end

	local var_8_0, var_8_1, var_8_2 = transformhelper.getLocalPos(arg_8_0.transform)

	transformhelper.setLocalPos(arg_8_0.transform, var_8_0, var_8_1, 0)

	if arg_8_0._conMat then
		arg_8_0._conMat:DisableKeyword("_GRADUAL_ON")
	end

	if arg_8_0._subMeshs then
		for iter_8_0, iter_8_1 in pairs(arg_8_0._subMeshs) do
			if iter_8_1.materialForRendering then
				iter_8_1.materialForRendering:DisableKeyword("_GRADUAL_ON")
			end
		end
	end

	arg_8_0:_doCallback()
end

function var_0_0.initText(arg_9_0)
	arg_9_0._subMeshs = {}
	arg_9_0._conMat = arg_9_0.text.fontMaterial

	arg_9_0._conMat:EnableKeyword("_GRADUAL_ON")
	arg_9_0._conMat:DisableKeyword("_DISSOLVE_ON")

	local var_9_0 = UnityEngine.Shader

	arg_9_0._LineMinYId = var_9_0.PropertyToID("_LineMinY")
	arg_9_0._LineMaxYId = var_9_0.PropertyToID("_LineMaxY")
	arg_9_0._contentX, arg_9_0._contentY, _ = transformhelper.getLocalPos(arg_9_0.transform)

	local var_9_1 = arg_9_0.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

	if var_9_1 then
		local var_9_2 = var_9_1:GetEnumerator()

		while var_9_2:MoveNext() do
			local var_9_3 = var_9_2.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI))

			table.insert(arg_9_0._subMeshs, var_9_3)
		end
	end

	arg_9_0.textInfo = arg_9_0.text:GetTextInfo(arg_9_0.content)
	arg_9_0.lineInfoList = {}

	local var_9_4 = 0

	for iter_9_0 = 1, arg_9_0.textInfo.lineCount do
		local var_9_5 = arg_9_0.textInfo.lineInfo[iter_9_0 - 1]
		local var_9_6 = var_9_4 + 1

		var_9_4 = var_9_4 + var_9_5.visibleCharacterCount

		table.insert(arg_9_0.lineInfoList, {
			var_9_5,
			var_9_6,
			var_9_4
		})
	end

	arg_9_0.characterCount = var_9_4
	arg_9_0.delayTime = arg_9_0:getDelayTime(var_9_4)
end

function var_0_0.getDelayTime(arg_10_0, arg_10_1)
	local var_10_0 = 4

	return 0.08 * arg_10_1 / var_10_0
end

function var_0_0.killTween(arg_11_0)
	if arg_11_0.tweenId then
		ZProj.TweenHelper.KillById(arg_11_0.tweenId)

		arg_11_0.tweenId = nil
	end

	if arg_11_0.moveId then
		ZProj.TweenHelper.KillById(arg_11_0.moveId)

		arg_11_0.moveId = nil
	end

	TaskDispatcher.cancelTask(arg_11_0._delayShow, arg_11_0)
end

function var_0_0.onDestroy(arg_12_0)
	arg_12_0:killTween()
end

return var_0_0
