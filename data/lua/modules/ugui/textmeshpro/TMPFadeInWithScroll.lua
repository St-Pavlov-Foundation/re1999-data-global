module("modules.ugui.textmeshpro.TMPFadeInWithScroll", package.seeall)

local var_0_0 = class("TMPFadeInWithScroll", LuaCompBase)

function var_0_0.clear(arg_1_0)
	TaskDispatcher.cancelTask(arg_1_0._delayShow, arg_1_0)
	GameUtil.onDestroyViewMember_TweenId(arg_1_0, "_conTweenId")

	arg_1_0._lastBottomLeft = 0
	arg_1_0._lineSpace = 0
	arg_1_0._hasUnderline = false
	arg_1_0._markTopList = {}
	arg_1_0._originalLineSpacing = arg_1_0._txtcontentcn.lineSpacing
	arg_1_0._lineSpacing = arg_1_0._originalLineSpacing

	arg_1_0:_disable_GRADUAL_ON()

	arg_1_0._defaultTxtX, arg_1_0._defaultTxtY = transformhelper.getLocalPos(arg_1_0._txtcontentcn.transform)
	arg_1_0._txt = ""
	arg_1_0._txtcontentcn.text = ""
end

local var_0_1 = 0.03

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._txtcontentcn = gohelper.findChildText(arg_2_1, "")
	arg_2_0._norDiaGO = arg_2_0._txtcontentcn.transform.parent.gameObject
	arg_2_0._conMat = arg_2_0._txtcontentcn.fontMaterial
	arg_2_0._parentHeight = recthelper.getHeight(arg_2_0._norDiaGO.transform)
	arg_2_0._defaultTxtX, arg_2_0._defaultTxtY = transformhelper.getLocalPos(arg_2_0._txtcontentcn.transform)

	local var_2_0 = UnityEngine.Shader

	arg_2_0._LineMinYId = var_2_0.PropertyToID("_LineMinY")
	arg_2_0._LineMaxYId = var_2_0.PropertyToID("_LineMaxY")
	arg_2_0._lastBottomLeft = 0
	arg_2_0._lineSpace = 0
	arg_2_0._hasUnderline = false
	arg_2_0._markTopList = {}
	arg_2_0._originalLineSpacing = arg_2_0._txtcontentcn.lineSpacing
	arg_2_0._lineSpacing = arg_2_0._originalLineSpacing
end

function var_0_0.hideDialog(arg_3_0)
	if arg_3_0._conTweenId then
		ZProj.TweenHelper.KillById(arg_3_0._conTweenId)

		arg_3_0._conTweenId = nil
	end

	gohelper.setActive(arg_3_0._norDiaGO, false)

	local var_3_0, var_3_1, var_3_2 = transformhelper.getLocalPos(arg_3_0._txtcontentcn.transform)

	transformhelper.setLocalPos(arg_3_0._txtcontentcn.transform, var_3_0, var_3_1, 1)
end

function var_0_0.playNormalText(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0:clear()
	arg_4_0._conMat:EnableKeyword("_GRADUAL_ON")
	transformhelper.setLocalPosXY(arg_4_0._txtcontentcn.transform, arg_4_0._defaultTxtX, arg_4_0._defaultTxtY)

	arg_4_0._nowPlayHeight = 0

	local var_4_0 = UnityEngine.Screen.height

	arg_4_0._conMat:SetFloat(arg_4_0._LineMinYId, var_4_0)
	arg_4_0._conMat:SetFloat(arg_4_0._LineMaxYId, var_4_0)
	gohelper.setActive(arg_4_0._norDiaGO, true)

	arg_4_0._txt = arg_4_1
	arg_4_0._finishCallback = arg_4_2
	arg_4_0._finishCallbackObj = arg_4_3

	arg_4_0:_setLineSpacing(arg_4_0:getLineSpacing())

	local var_4_1, var_4_2, var_4_3 = transformhelper.getLocalPos(arg_4_0._txtcontentcn.transform)

	transformhelper.setLocalPos(arg_4_0._txtcontentcn.transform, var_4_1, var_4_2, 1)

	arg_4_0._txtcontentcn.text = arg_4_0._txt

	TaskDispatcher.runDelay(arg_4_0._delayShow, arg_4_0, 0)
end

function var_0_0._delayShow(arg_5_0)
	arg_5_0._lastBottomLeft = 0
	arg_5_0._lineSpace = 0
	arg_5_0._hasUnderline = string.find(arg_5_0._txt, "<u>") and string.find(arg_5_0._txt, "</u>")

	local var_5_0 = CameraMgr.instance:getUICamera()
	local var_5_1 = arg_5_0._txtcontentcn:GetTextInfo(arg_5_0._txt)

	arg_5_0._textInfo = var_5_1
	arg_5_0._lineInfoList = {}

	local var_5_2 = 0
	local var_5_3 = arg_5_0._txtcontentcn.transform

	for iter_5_0 = 1, var_5_1.lineCount do
		local var_5_4 = var_5_1.lineInfo[iter_5_0 - 1]
		local var_5_5 = var_5_2 + 1

		var_5_2 = var_5_2 + var_5_4.visibleCharacterCount

		local var_5_6 = arg_5_0._textInfo.characterInfo
		local var_5_7 = var_5_6[var_5_4.firstVisibleCharacterIndex]
		local var_5_8 = var_5_6[var_5_4.lastVisibleCharacterIndex]
		local var_5_9 = var_5_0:WorldToScreenPoint(var_5_3:TransformPoint(var_5_7.bottomLeft))
		local var_5_10 = var_5_0:WorldToScreenPoint(var_5_3:TransformPoint(var_5_7.topLeft))
		local var_5_11 = var_5_9.y
		local var_5_12 = var_5_10.y

		for iter_5_1 = var_5_4.firstVisibleCharacterIndex, var_5_4.lastVisibleCharacterIndex do
			local var_5_13 = var_5_6[iter_5_1]
			local var_5_14 = var_5_0:WorldToScreenPoint(var_5_3:TransformPoint(var_5_13.bottomLeft))

			if var_5_11 > var_5_14.y then
				var_5_11 = var_5_14.y
			end

			local var_5_15 = var_5_0:WorldToScreenPoint(var_5_3:TransformPoint(var_5_13.topLeft))

			if var_5_12 < var_5_15.y then
				var_5_12 = var_5_15.y
			end
		end

		var_5_9.y = var_5_11
		var_5_10.y = var_5_12

		local var_5_16 = var_5_0:WorldToScreenPoint(var_5_3:TransformPoint(var_5_8.bottomRight))

		table.insert(arg_5_0._lineInfoList, {
			var_5_4,
			var_5_5,
			var_5_2,
			var_5_9,
			var_5_10,
			var_5_16
		})
	end

	arg_5_0._curLine = nil

	local var_5_17 = var_0_1 * var_5_2

	if arg_5_0._conTweenId then
		ZProj.TweenHelper.KillById(arg_5_0._conTweenId)

		arg_5_0._conTweenId = nil
	end

	arg_5_0._conTweenId = ZProj.TweenHelper.DOTweenFloat(1, var_5_2, var_5_17, arg_5_0._conUpdate, arg_5_0.conFinished, arg_5_0, nil, EaseType.Linear)
end

function var_0_0._conUpdate(arg_6_0, arg_6_1)
	local var_6_0 = UnityEngine.Screen.width
	local var_6_1 = UnityEngine.Screen.height

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._lineInfoList) do
		local var_6_2 = iter_6_1[1]
		local var_6_3 = iter_6_1[2]
		local var_6_4 = iter_6_1[3]

		if var_6_3 <= arg_6_1 and arg_6_1 <= var_6_4 and var_6_3 ~= var_6_4 then
			local var_6_5 = iter_6_1[4]
			local var_6_6 = iter_6_1[5]
			local var_6_7 = iter_6_1[6]

			if arg_6_0._curLine ~= iter_6_0 then
				arg_6_0._curLine = iter_6_0
				arg_6_0._nowPlayHeight = recthelper.getHeight(arg_6_0._txtcontentcn.transform) / #arg_6_0._lineInfoList * iter_6_0

				local var_6_8 = 0

				if arg_6_0._nowPlayHeight > arg_6_0._parentHeight then
					var_6_8 = arg_6_0._nowPlayHeight - arg_6_0._parentHeight
				end

				local var_6_9 = var_6_8 * var_6_1 / 1080

				arg_6_0._conMat:SetFloat(arg_6_0._LineMinYId, var_6_5.y + var_6_9)
				arg_6_0._conMat:SetFloat(arg_6_0._LineMaxYId, var_6_6.y + var_6_9)

				local var_6_10 = arg_6_0._txtcontentcn.gameObject

				gohelper.setActive(var_6_10, false)
				gohelper.setActive(var_6_10, true)
			end

			local var_6_11 = (arg_6_1 - var_6_3) / (var_6_4 - var_6_3)
			local var_6_12 = Mathf.Lerp(var_6_5.x, var_6_7.x, var_6_11)
			local var_6_13 = 0

			if arg_6_0._nowPlayHeight > arg_6_0._parentHeight then
				var_6_13 = arg_6_0._nowPlayHeight - arg_6_0._parentHeight
			end

			transformhelper.setLocalPos(arg_6_0._txtcontentcn.transform, arg_6_0._defaultTxtX, arg_6_0._defaultTxtY + var_6_13, 1 - var_6_12 / var_6_0)
		end
	end
end

function var_0_0.isPlaying(arg_7_0)
	return arg_7_0._conTweenId and true or false
end

function var_0_0.conFinished(arg_8_0)
	if arg_8_0._conTweenId then
		ZProj.TweenHelper.KillById(arg_8_0._conTweenId)

		arg_8_0._conTweenId = nil
	end

	arg_8_0:_disable_GRADUAL_ON()

	local var_8_0, var_8_1, var_8_2 = transformhelper.getLocalPos(arg_8_0._txtcontentcn.transform)

	transformhelper.setLocalPos(arg_8_0._txtcontentcn.transform, var_8_0, var_8_1, 0)

	if arg_8_0._finishCallback then
		arg_8_0._finishCallback(arg_8_0._finishCallbackObj)
	end
end

function var_0_0._disable_GRADUAL_ON(arg_9_0)
	local var_9_0 = arg_9_0._txtcontentcn.gameObject:GetComponentsInChildren(gohelper.Type_TMP_SubMeshUI, true)

	if var_9_0 then
		local var_9_1 = var_9_0.Length

		for iter_9_0 = 0, var_9_1 - 1 do
			local var_9_2 = var_9_0[iter_9_0].sharedMaterial

			if not gohelper.isNil(var_9_2) then
				var_9_2:DisableKeyword("_GRADUAL_ON")
				var_9_2:SetFloat(arg_9_0._LineMinYId, 0)
				var_9_2:SetFloat(arg_9_0._LineMaxYId, 0)
			end
		end
	end

	arg_9_0._conMat:DisableKeyword("_GRADUAL_ON")
	arg_9_0._conMat:SetFloat(arg_9_0._LineMinYId, 0)
	arg_9_0._conMat:SetFloat(arg_9_0._LineMaxYId, 0)
end

function var_0_0.onDestroy(arg_10_0)
	arg_10_0:onDestroyView()
end

function var_0_0.onDestroyView(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._delayShow, arg_11_0)
	GameUtil.onDestroyViewMember_TweenId(arg_11_0, "_conTweenId")
end

function var_0_0.setTopOffset(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._conMark:SetTopOffset(arg_12_1 or 0, arg_12_2 or 0)
end

function var_0_0.setLineSpacing(arg_13_0, arg_13_1)
	arg_13_0._lineSpacing = arg_13_1 or 0
end

function var_0_0.getLineSpacing(arg_14_0)
	return #arg_14_0._markTopList > 0 and arg_14_0._lineSpacing or arg_14_0._originalLineSpacing
end

function var_0_0._setLineSpacing(arg_15_0, arg_15_1)
	arg_15_0._txtcontentcn.lineSpacing = arg_15_1 or 0
end

function var_0_0._disable_GRADUAL_ON(arg_16_0)
	local var_16_0 = arg_16_0._txtcontentcn.gameObject:GetComponentsInChildren(gohelper.Type_TMP_SubMeshUI, true)

	if var_16_0 then
		local var_16_1 = var_16_0.Length

		for iter_16_0 = 0, var_16_1 - 1 do
			local var_16_2 = var_16_0[iter_16_0].sharedMaterial

			if not gohelper.isNil(var_16_2) then
				var_16_2:DisableKeyword("_GRADUAL_ON")
				var_16_2:SetFloat(arg_16_0._LineMinYId, 0)
				var_16_2:SetFloat(arg_16_0._LineMaxYId, 0)
			end
		end
	end

	arg_16_0._conMat:DisableKeyword("_GRADUAL_ON")
	arg_16_0._conMat:SetFloat(arg_16_0._LineMinYId, 0)
	arg_16_0._conMat:SetFloat(arg_16_0._LineMaxYId, 0)
end

return var_0_0
