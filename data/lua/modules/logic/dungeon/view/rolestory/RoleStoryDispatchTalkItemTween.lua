module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchTalkItemTween", package.seeall)

local var_0_0 = class("RoleStoryDispatchTalkItemTween", UserDataDispose)

function var_0_0._playTween_overseas(arg_1_0)
	arg_1_0.text:GetPreferredValues()

	arg_1_0._lastBottomLeft = 0
	arg_1_0._lineSpace = 0
	arg_1_0.transform = arg_1_0.text.transform
	arg_1_0.gameObject = arg_1_0.text.gameObject
	arg_1_0.canvasGroup = arg_1_0.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))

	local var_1_0 = UnityEngine.Shader

	arg_1_0._LineMinYId = var_1_0.PropertyToID("_LineMinY")
	arg_1_0._LineMaxYId = var_1_0.PropertyToID("_LineMaxY")

	local var_1_1 = UnityEngine.Screen.height

	arg_1_0._conMat = arg_1_0.text.fontMaterial

	arg_1_0._conMat:EnableKeyword("_GRADUAL_ON")
	arg_1_0._conMat:SetFloat(arg_1_0._LineMinYId, var_1_1)
	arg_1_0._conMat:SetFloat(arg_1_0._LineMaxYId, var_1_1)

	arg_1_0._contentX, arg_1_0._contentY, _ = transformhelper.getLocalPos(arg_1_0.transform)

	transformhelper.setLocalPos(arg_1_0.transform, arg_1_0._contentX, arg_1_0._contentY, 1)

	arg_1_0._fontNormalMat = arg_1_0.text.fontSharedMaterial
	arg_1_0._hasUnderline = string.find(arg_1_0.content, "<u>") and string.find(arg_1_0.content, "</u>")
	arg_1_0._lineSpacing = arg_1_0.text.lineSpacing

	TaskDispatcher.cancelTask(arg_1_0._delayShow, arg_1_0)
end

function var_0_0._initText_overseas(arg_2_0)
	arg_2_0._lastBottomLeft = 0
	arg_2_0._lineSpace = 0
	arg_2_0._subMeshs = {}

	local var_2_0 = arg_2_0.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

	if var_2_0 then
		local var_2_1 = var_2_0:GetEnumerator()

		while var_2_1:MoveNext() do
			local var_2_2 = var_2_1.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI))

			table.insert(arg_2_0._subMeshs, var_2_2)
		end
	end

	local var_2_3 = arg_2_0.text:GetTextInfo(arg_2_0.content)
	local var_2_4 = 0
	local var_2_5 = CameraMgr.instance:getUICamera()
	local var_2_6 = arg_2_0.transform

	arg_2_0.textInfo = var_2_3
	arg_2_0.lineInfoList = {}

	for iter_2_0 = 1, var_2_3.lineCount do
		local var_2_7 = var_2_3.lineInfo[iter_2_0 - 1]
		local var_2_8 = var_2_4 + 1

		var_2_4 = var_2_4 + var_2_7.visibleCharacterCount

		local var_2_9 = var_2_3.characterInfo
		local var_2_10 = var_2_9[var_2_7.firstVisibleCharacterIndex]
		local var_2_11 = var_2_9[var_2_7.lastVisibleCharacterIndex]
		local var_2_12 = var_2_5:WorldToScreenPoint(var_2_6:TransformPoint(var_2_10.bottomLeft))
		local var_2_13 = var_2_5:WorldToScreenPoint(var_2_6:TransformPoint(var_2_10.topLeft))
		local var_2_14 = var_2_12.y
		local var_2_15 = var_2_13.y

		for iter_2_1 = var_2_7.firstVisibleCharacterIndex, var_2_7.lastVisibleCharacterIndex do
			local var_2_16 = var_2_9[iter_2_1]
			local var_2_17 = var_2_5:WorldToScreenPoint(var_2_6:TransformPoint(var_2_16.bottomLeft))

			if var_2_14 > var_2_17.y then
				var_2_14 = var_2_17.y
			end

			local var_2_18 = var_2_5:WorldToScreenPoint(var_2_6:TransformPoint(var_2_16.topLeft))

			if var_2_15 < var_2_18.y then
				var_2_15 = var_2_18.y
			end
		end

		var_2_12.y = var_2_14
		var_2_13.y = var_2_15

		local var_2_19 = var_2_5:WorldToScreenPoint(var_2_6:TransformPoint(var_2_11.bottomRight))

		table.insert(arg_2_0.lineInfoList, {
			var_2_7,
			var_2_8,
			var_2_4,
			var_2_12,
			var_2_13,
			var_2_19
		})
	end

	arg_2_0.characterCount = var_2_4
	arg_2_0.delayTime = arg_2_0:getDelayTime(var_2_4)
	arg_2_0._curLine = nil

	GameUtil.onDestroyViewMember_TweenId(arg_2_0, "tweenId")
end

function var_0_0._frameCallback_overseas(arg_3_0, arg_3_1)
	local var_3_0 = UnityEngine.Screen.width

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.lineInfoList) do
		local var_3_1 = iter_3_1[1]
		local var_3_2 = iter_3_1[2]
		local var_3_3 = iter_3_1[3]

		if var_3_2 <= arg_3_1 and arg_3_1 <= var_3_3 and var_3_2 ~= var_3_3 then
			local var_3_4 = iter_3_1[4]
			local var_3_5 = iter_3_1[5]
			local var_3_6 = iter_3_1[6]

			if arg_3_0._curLine ~= iter_3_0 then
				arg_3_0._curLine = iter_3_0

				local var_3_7 = var_3_4.y
				local var_3_8 = var_3_5

				for iter_3_2, iter_3_3 in pairs(arg_3_0._subMeshs) do
					if iter_3_3.sharedMaterial then
						iter_3_3.sharedMaterial = arg_3_0._fontNormalMat
					end
				end

				if iter_3_0 == 1 then
					if arg_3_0._hasUnderline then
						arg_3_0._conMat:SetFloat(arg_3_0._LineMinYId, var_3_7 - 4)
					else
						arg_3_0._conMat:SetFloat(arg_3_0._LineMinYId, var_3_7)
					end

					arg_3_0._conMat:SetFloat(arg_3_0._LineMaxYId, var_3_8.y)
				else
					arg_3_0._lineSpace = arg_3_0._lastBottomLeft - var_3_8.y > 0 and arg_3_0._lastBottomLeft - var_3_8.y or arg_3_0._lineSpace

					arg_3_0._conMat:SetFloat(arg_3_0._LineMinYId, var_3_7)
					arg_3_0._conMat:SetFloat(arg_3_0._LineMaxYId, var_3_8.y + arg_3_0._lineSpace)
				end

				arg_3_0._lastBottomLeft = var_3_7

				local var_3_9 = arg_3_0.gameObject

				gohelper.setActive(var_3_9, false)
				gohelper.setActive(var_3_9, true)
			end

			local var_3_10 = var_3_2 == var_3_3 and 1 or (arg_3_1 - var_3_2) / (var_3_3 - var_3_2)
			local var_3_11 = 1 - Mathf.Lerp(var_3_4.x - 10, var_3_6.x + 10, var_3_10) / var_3_0
			local var_3_12, var_3_13, var_3_14 = transformhelper.getLocalPos(arg_3_0.transform)

			transformhelper.setLocalPos(arg_3_0.transform, var_3_12, var_3_13, var_3_11)
		end
	end
end

function var_0_0._onTextFinished_overseas(arg_4_0)
	arg_4_0:killTween()
	arg_4_0:_disable_GRADUAL_ON()

	local var_4_0, var_4_1, var_4_2 = transformhelper.getLocalPos(arg_4_0.transform)

	transformhelper.setLocalPos(arg_4_0.transform, var_4_0, var_4_1, 0)
	arg_4_0:_doCallback()
end

function var_0_0._disable_GRADUAL_ON(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._subMeshs or {}) do
		local var_5_0 = iter_5_1.sharedMaterial

		if not gohelper.isNil(var_5_0) then
			var_5_0:DisableKeyword("_GRADUAL_ON")
			var_5_0:SetFloat(arg_5_0._LineMinYId, 0)
			var_5_0:SetFloat(arg_5_0._LineMaxYId, 0)
		end
	end

	arg_5_0._conMat:DisableKeyword("_GRADUAL_ON")
	arg_5_0._conMat:SetFloat(arg_5_0._LineMinYId, 0)
	arg_5_0._conMat:SetFloat(arg_5_0._LineMaxYId, 0)
end

function var_0_0.ctor(arg_6_0)
	arg_6_0:__onInit()
end

function var_0_0.playTween(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	arg_7_0:killTween()

	arg_7_0.callback = arg_7_3
	arg_7_0.callbackObj = arg_7_4
	arg_7_0.text = arg_7_1
	arg_7_0.content = arg_7_2
	arg_7_0.scrollContent = arg_7_5

	arg_7_0:_playTween_overseas()
	TaskDispatcher.runDelay(arg_7_0._delayShow, arg_7_0, 0.05)
end

function var_0_0._delayShow(arg_8_0)
	arg_8_0:_initText_overseas()

	arg_8_0.canvasGroup.alpha = 1
	arg_8_0.tweenId = ZProj.TweenHelper.DOTweenFloat(1, arg_8_0.characterCount, arg_8_0.delayTime, arg_8_0.frameCallback, arg_8_0.onTextFinished, arg_8_0, nil, EaseType.Linear)

	arg_8_0:moveContent()
end

function var_0_0.moveContent(arg_9_0)
	local var_9_0 = arg_9_0.scrollContent.transform
	local var_9_1 = recthelper.getHeight(var_9_0.parent)
	local var_9_2 = recthelper.getHeight(var_9_0)
	local var_9_3 = math.max(var_9_2 - var_9_1, 0)
	local var_9_4 = recthelper.getAnchorY(arg_9_0.transform.parent) + recthelper.getHeight(arg_9_0.transform.parent)
	local var_9_5 = math.max(var_9_3, var_9_4 - var_9_1)

	arg_9_0.moveId = ZProj.TweenHelper.DOAnchorPosY(var_9_0, var_9_5, arg_9_0.delayTime * 0.8, nil, nil, nil, EaseType.Linear)
end

function var_0_0._doCallback(arg_10_0)
	local var_10_0 = arg_10_0.callback
	local var_10_1 = arg_10_0.callbackObj

	arg_10_0.callback = nil
	arg_10_0.callbackObj = nil

	if var_10_0 then
		var_10_0(var_10_1)
	end
end

function var_0_0.frameCallback(arg_11_0, arg_11_1)
	do return arg_11_0:_frameCallback_overseas(arg_11_1) end

	local var_11_0 = UnityEngine.Screen.width
	local var_11_1 = CameraMgr.instance:getUICamera()

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.lineInfoList) do
		local var_11_2 = iter_11_1[1]
		local var_11_3 = iter_11_1[2]
		local var_11_4 = iter_11_1[3]

		if var_11_3 <= arg_11_1 and arg_11_1 <= var_11_4 then
			local var_11_5 = arg_11_0.textInfo.characterInfo
			local var_11_6 = var_11_5[var_11_2.firstVisibleCharacterIndex]
			local var_11_7 = var_11_5[var_11_2.lastVisibleCharacterIndex]
			local var_11_8 = var_11_1:WorldToScreenPoint(arg_11_0.transform:TransformPoint(var_11_6.bottomLeft))
			local var_11_9 = var_11_8
			local var_11_10 = var_11_8.y

			for iter_11_2 = var_11_2.firstVisibleCharacterIndex, var_11_2.lastVisibleCharacterIndex do
				local var_11_11 = var_11_5[iter_11_2]
				local var_11_12 = var_11_1:WorldToScreenPoint(arg_11_0.transform:TransformPoint(var_11_11.bottomLeft))

				if var_11_10 > var_11_12.y then
					var_11_10 = var_11_12.y
				end
			end

			var_11_9.y = var_11_10

			local var_11_13 = var_11_1:WorldToScreenPoint(arg_11_0.transform:TransformPoint(var_11_6.topLeft))
			local var_11_14 = var_11_13
			local var_11_15 = var_11_13.y

			for iter_11_3 = var_11_2.firstVisibleCharacterIndex, var_11_2.lastVisibleCharacterIndex do
				local var_11_16 = var_11_5[iter_11_3]
				local var_11_17 = var_11_1:WorldToScreenPoint(arg_11_0.transform:TransformPoint(var_11_16.topLeft))

				if var_11_15 < var_11_17.y then
					var_11_15 = var_11_17.y
				end
			end

			var_11_14.y = var_11_15

			local var_11_18 = var_11_1:WorldToScreenPoint(arg_11_0.transform:TransformPoint(var_11_7.bottomRight))

			if iter_11_0 == 1 then
				arg_11_0._conMat:SetFloat(arg_11_0._LineMinYId, var_11_9.y)
				arg_11_0._conMat:SetFloat(arg_11_0._LineMaxYId, var_11_14.y + 10)

				for iter_11_4, iter_11_5 in pairs(arg_11_0._subMeshs) do
					if iter_11_5.materialForRendering then
						iter_11_5.materialForRendering:SetFloat(arg_11_0._LineMinYId, var_11_9.y)
						iter_11_5.materialForRendering:SetFloat(arg_11_0._LineMaxYId, var_11_14.y + 10)
						iter_11_5.materialForRendering:EnableKeyword("_GRADUAL_ON")
					end
				end
			else
				arg_11_0._conMat:SetFloat(arg_11_0._LineMinYId, var_11_9.y)
				arg_11_0._conMat:SetFloat(arg_11_0._LineMaxYId, var_11_14.y)

				for iter_11_6, iter_11_7 in pairs(arg_11_0._subMeshs) do
					if iter_11_7.materialForRendering then
						iter_11_7.materialForRendering:SetFloat(arg_11_0._LineMinYId, var_11_9.y)
						iter_11_7.materialForRendering:SetFloat(arg_11_0._LineMaxYId, var_11_14.y)
						iter_11_7.materialForRendering:EnableKeyword("_GRADUAL_ON")
					end
				end
			end

			local var_11_19 = arg_11_0.gameObject

			gohelper.setActive(var_11_19, false)
			gohelper.setActive(var_11_19, true)

			local var_11_20 = var_11_3 == var_11_4 and 1 or (arg_11_1 - var_11_3) / (var_11_4 - var_11_3)
			local var_11_21 = 1 - Mathf.Lerp(var_11_9.x - 10, var_11_18.x + 10, var_11_20) / var_11_0

			transformhelper.setLocalPos(arg_11_0.transform, arg_11_0._contentX, arg_11_0._contentY, var_11_21)
		end
	end
end

function var_0_0.onTextFinished(arg_12_0)
	do return arg_12_0:_onTextFinished_overseas() end

	arg_12_0:killTween()

	local var_12_0, var_12_1, var_12_2 = transformhelper.getLocalPos(arg_12_0.transform)

	transformhelper.setLocalPos(arg_12_0.transform, var_12_0, var_12_1, 0)
	arg_12_0._conMat:DisableKeyword("_GRADUAL_ON")

	for iter_12_0, iter_12_1 in pairs(arg_12_0._subMeshs) do
		if iter_12_1.materialForRendering then
			iter_12_1.materialForRendering:DisableKeyword("_GRADUAL_ON")
		end
	end

	arg_12_0:_doCallback()
end

function var_0_0.initText(arg_13_0)
	arg_13_0.transform = arg_13_0.text.transform
	arg_13_0.gameObject = arg_13_0.text.gameObject
	arg_13_0.canvasGroup = arg_13_0.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_13_0._subMeshs = {}
	arg_13_0._conMat = arg_13_0.text.fontMaterial

	arg_13_0._conMat:EnableKeyword("_GRADUAL_ON")
	arg_13_0._conMat:DisableKeyword("_DISSOLVE_ON")

	local var_13_0 = UnityEngine.Shader

	arg_13_0._LineMinYId = var_13_0.PropertyToID("_LineMinY")
	arg_13_0._LineMaxYId = var_13_0.PropertyToID("_LineMaxY")
	arg_13_0._contentX, arg_13_0._contentY, _ = transformhelper.getLocalPos(arg_13_0.transform)

	local var_13_1 = arg_13_0.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

	if var_13_1 then
		local var_13_2 = var_13_1:GetEnumerator()

		while var_13_2:MoveNext() do
			local var_13_3 = var_13_2.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI))

			table.insert(arg_13_0._subMeshs, var_13_3)
		end
	end

	arg_13_0.textInfo = arg_13_0.text:GetTextInfo(arg_13_0.content)
	arg_13_0.lineInfoList = {}

	local var_13_4 = 0

	for iter_13_0 = 1, arg_13_0.textInfo.lineCount do
		local var_13_5 = arg_13_0.textInfo.lineInfo[iter_13_0 - 1]
		local var_13_6 = var_13_4 + 1

		var_13_4 = var_13_4 + var_13_5.visibleCharacterCount

		table.insert(arg_13_0.lineInfoList, {
			var_13_5,
			var_13_6,
			var_13_4
		})
	end

	arg_13_0.characterCount = var_13_4
	arg_13_0.delayTime = arg_13_0:getDelayTime(var_13_4)
end

function var_0_0.getDelayTime(arg_14_0, arg_14_1)
	local var_14_0 = 4

	return 0.08 * arg_14_1 / var_14_0
end

function var_0_0.killTween(arg_15_0)
	if arg_15_0.tweenId then
		ZProj.TweenHelper.KillById(arg_15_0.tweenId)

		arg_15_0.tweenId = nil
	end

	if arg_15_0.moveId then
		ZProj.TweenHelper.KillById(arg_15_0.moveId)

		arg_15_0.moveId = nil
	end

	TaskDispatcher.cancelTask(arg_15_0._delayShow, arg_15_0)
end

function var_0_0.destroy(arg_16_0)
	arg_16_0:killTween()
	arg_16_0:__onDispose()
end

return var_0_0
