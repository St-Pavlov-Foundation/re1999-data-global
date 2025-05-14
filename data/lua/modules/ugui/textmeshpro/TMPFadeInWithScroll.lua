module("modules.ugui.textmeshpro.TMPFadeInWithScroll", package.seeall)

local var_0_0 = class("TMPFadeInWithScroll", LuaCompBase)
local var_0_1 = 0.03

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._txtcontentcn = gohelper.findChildText(arg_1_1, "")
	arg_1_0._norDiaGO = arg_1_0._txtcontentcn.transform.parent.gameObject
	arg_1_0._conMat = arg_1_0._txtcontentcn.fontMaterial
	arg_1_0._parentHeight = recthelper.getHeight(arg_1_0._norDiaGO.transform)
	arg_1_0._defaultTxtX, arg_1_0._defaultTxtY = transformhelper.getLocalPos(arg_1_0._txtcontentcn.transform)

	local var_1_0 = UnityEngine.Shader

	arg_1_0._LineMinYId = var_1_0.PropertyToID("_LineMinY")
	arg_1_0._LineMaxYId = var_1_0.PropertyToID("_LineMaxY")
	arg_1_0._lastBottomLeft = 0
	arg_1_0._lineSpace = 0
	arg_1_0._hasUnderline = false
	arg_1_0._markTopList = {}
	arg_1_0._originalLineSpacing = arg_1_0._txtcontentcn.lineSpacing
	arg_1_0._lineSpacing = arg_1_0._originalLineSpacing
end

function var_0_0.hideDialog(arg_2_0)
	if arg_2_0._conTweenId then
		ZProj.TweenHelper.KillById(arg_2_0._conTweenId)

		arg_2_0._conTweenId = nil
	end

	gohelper.setActive(arg_2_0._norDiaGO, false)

	local var_2_0, var_2_1, var_2_2 = transformhelper.getLocalPos(arg_2_0._txtcontentcn.transform)

	transformhelper.setLocalPos(arg_2_0._txtcontentcn.transform, var_2_0, var_2_1, 1)
end

function var_0_0.playNormalText(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0._conMat:EnableKeyword("_GRADUAL_ON")
	transformhelper.setLocalPosXY(arg_3_0._txtcontentcn.transform, arg_3_0._defaultTxtX, arg_3_0._defaultTxtY)

	arg_3_0._nowPlayHeight = 0

	local var_3_0 = UnityEngine.Screen.height

	arg_3_0._conMat:SetFloat(arg_3_0._LineMinYId, var_3_0)
	arg_3_0._conMat:SetFloat(arg_3_0._LineMaxYId, var_3_0)
	gohelper.setActive(arg_3_0._norDiaGO, true)

	arg_3_0._txt = arg_3_1
	arg_3_0._finishCallback = arg_3_2
	arg_3_0._finishCallbackObj = arg_3_3

	arg_3_0:_setLineSpacing(arg_3_0:getLineSpacing())

	local var_3_1, var_3_2, var_3_3 = transformhelper.getLocalPos(arg_3_0._txtcontentcn.transform)

	transformhelper.setLocalPos(arg_3_0._txtcontentcn.transform, var_3_1, var_3_2, 1)

	arg_3_0._txtcontentcn.text = arg_3_0._txt

	TaskDispatcher.runDelay(arg_3_0._delayShow, arg_3_0, 0)
end

function var_0_0._delayShow(arg_4_0)
	arg_4_0._lastBottomLeft = 0
	arg_4_0._lineSpace = 0
	arg_4_0._hasUnderline = string.find(arg_4_0._txt, "<u>") and string.find(arg_4_0._txt, "</u>")

	local var_4_0 = CameraMgr.instance:getUICamera()
	local var_4_1 = arg_4_0._txtcontentcn:GetTextInfo(arg_4_0._txt)

	arg_4_0._textInfo = var_4_1
	arg_4_0._lineInfoList = {}

	local var_4_2 = 0
	local var_4_3 = arg_4_0._txtcontentcn.transform

	for iter_4_0 = 1, var_4_1.lineCount do
		local var_4_4 = var_4_1.lineInfo[iter_4_0 - 1]
		local var_4_5 = var_4_2 + 1

		var_4_2 = var_4_2 + var_4_4.visibleCharacterCount

		local var_4_6 = arg_4_0._textInfo.characterInfo
		local var_4_7 = var_4_6[var_4_4.firstVisibleCharacterIndex]
		local var_4_8 = var_4_6[var_4_4.lastVisibleCharacterIndex]
		local var_4_9 = var_4_0:WorldToScreenPoint(var_4_3:TransformPoint(var_4_7.bottomLeft))
		local var_4_10 = var_4_0:WorldToScreenPoint(var_4_3:TransformPoint(var_4_7.topLeft))
		local var_4_11 = var_4_9.y
		local var_4_12 = var_4_10.y

		for iter_4_1 = var_4_4.firstVisibleCharacterIndex, var_4_4.lastVisibleCharacterIndex do
			local var_4_13 = var_4_6[iter_4_1]
			local var_4_14 = var_4_0:WorldToScreenPoint(var_4_3:TransformPoint(var_4_13.bottomLeft))

			if var_4_11 > var_4_14.y then
				var_4_11 = var_4_14.y
			end

			local var_4_15 = var_4_0:WorldToScreenPoint(var_4_3:TransformPoint(var_4_13.topLeft))

			if var_4_12 < var_4_15.y then
				var_4_12 = var_4_15.y
			end
		end

		var_4_9.y = var_4_11
		var_4_10.y = var_4_12

		local var_4_16 = var_4_0:WorldToScreenPoint(var_4_3:TransformPoint(var_4_8.bottomRight))

		table.insert(arg_4_0._lineInfoList, {
			var_4_4,
			var_4_5,
			var_4_2,
			var_4_9,
			var_4_10,
			var_4_16
		})
	end

	arg_4_0._curLine = nil

	local var_4_17 = var_0_1 * var_4_2

	if arg_4_0._conTweenId then
		ZProj.TweenHelper.KillById(arg_4_0._conTweenId)

		arg_4_0._conTweenId = nil
	end

	arg_4_0._conTweenId = ZProj.TweenHelper.DOTweenFloat(1, var_4_2, var_4_17, arg_4_0._conUpdate, arg_4_0.conFinished, arg_4_0, nil, EaseType.Linear)
end

function var_0_0._conUpdate(arg_5_0, arg_5_1)
	local var_5_0 = UnityEngine.Screen.width
	local var_5_1 = UnityEngine.Screen.height

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._lineInfoList) do
		local var_5_2 = iter_5_1[1]
		local var_5_3 = iter_5_1[2]
		local var_5_4 = iter_5_1[3]

		if var_5_3 <= arg_5_1 and arg_5_1 <= var_5_4 and var_5_3 ~= var_5_4 then
			local var_5_5 = iter_5_1[4]
			local var_5_6 = iter_5_1[5]
			local var_5_7 = iter_5_1[6]

			if arg_5_0._curLine ~= iter_5_0 then
				arg_5_0._curLine = iter_5_0
				arg_5_0._nowPlayHeight = recthelper.getHeight(arg_5_0._txtcontentcn.transform) / #arg_5_0._lineInfoList * iter_5_0

				local var_5_8 = 0

				if arg_5_0._nowPlayHeight > arg_5_0._parentHeight then
					var_5_8 = arg_5_0._nowPlayHeight - arg_5_0._parentHeight
				end

				local var_5_9 = var_5_8 * var_5_1 / 1080

				arg_5_0._conMat:SetFloat(arg_5_0._LineMinYId, var_5_5.y + var_5_9)
				arg_5_0._conMat:SetFloat(arg_5_0._LineMaxYId, var_5_6.y + var_5_9)

				local var_5_10 = arg_5_0._txtcontentcn.gameObject

				gohelper.setActive(var_5_10, false)
				gohelper.setActive(var_5_10, true)
			end

			local var_5_11 = (arg_5_1 - var_5_3) / (var_5_4 - var_5_3)
			local var_5_12 = Mathf.Lerp(var_5_5.x, var_5_7.x, var_5_11)
			local var_5_13 = 0

			if arg_5_0._nowPlayHeight > arg_5_0._parentHeight then
				var_5_13 = arg_5_0._nowPlayHeight - arg_5_0._parentHeight
			end

			transformhelper.setLocalPos(arg_5_0._txtcontentcn.transform, arg_5_0._defaultTxtX, arg_5_0._defaultTxtY + var_5_13, 1 - var_5_12 / var_5_0)
		end
	end
end

function var_0_0.isPlaying(arg_6_0)
	return arg_6_0._conTweenId and true or false
end

function var_0_0.conFinished(arg_7_0)
	if arg_7_0._conTweenId then
		ZProj.TweenHelper.KillById(arg_7_0._conTweenId)

		arg_7_0._conTweenId = nil
	end

	arg_7_0:_disable_GRADUAL_ON()

	local var_7_0, var_7_1, var_7_2 = transformhelper.getLocalPos(arg_7_0._txtcontentcn.transform)

	transformhelper.setLocalPos(arg_7_0._txtcontentcn.transform, var_7_0, var_7_1, 0)

	if arg_7_0._finishCallback then
		arg_7_0._finishCallback(arg_7_0._finishCallbackObj)
	end
end

function var_0_0._disable_GRADUAL_ON(arg_8_0)
	local var_8_0 = arg_8_0._txtcontentcn.gameObject:GetComponentsInChildren(gohelper.Type_TMP_SubMeshUI, true)

	if var_8_0 then
		local var_8_1 = var_8_0.Length

		for iter_8_0 = 0, var_8_1 - 1 do
			local var_8_2 = var_8_0[iter_8_0].sharedMaterial

			if not gohelper.isNil(var_8_2) then
				var_8_2:DisableKeyword("_GRADUAL_ON")
				var_8_2:SetFloat(arg_8_0._LineMinYId, 0)
				var_8_2:SetFloat(arg_8_0._LineMaxYId, 0)
			end
		end
	end

	arg_8_0._conMat:DisableKeyword("_GRADUAL_ON")
	arg_8_0._conMat:SetFloat(arg_8_0._LineMinYId, 0)
	arg_8_0._conMat:SetFloat(arg_8_0._LineMaxYId, 0)
end

function var_0_0.onDestroy(arg_9_0)
	arg_9_0:onDestroyView()
end

function var_0_0.onDestroyView(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._delayShow, arg_10_0)
	GameUtil.onDestroyViewMember_TweenId(arg_10_0, "_conTweenId")
end

function var_0_0.setTopOffset(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._conMark:SetTopOffset(arg_11_1 or 0, arg_11_2 or 0)
end

function var_0_0.setLineSpacing(arg_12_0, arg_12_1)
	arg_12_0._lineSpacing = arg_12_1 or 0
end

function var_0_0.getLineSpacing(arg_13_0)
	return #arg_13_0._markTopList > 0 and arg_13_0._lineSpacing or arg_13_0._originalLineSpacing
end

function var_0_0._setLineSpacing(arg_14_0, arg_14_1)
	arg_14_0._txtcontentcn.lineSpacing = arg_14_1 or 0
end

function var_0_0._disable_GRADUAL_ON(arg_15_0)
	local var_15_0 = arg_15_0._txtcontentcn.gameObject:GetComponentsInChildren(gohelper.Type_TMP_SubMeshUI, true)

	if var_15_0 then
		local var_15_1 = var_15_0.Length

		for iter_15_0 = 0, var_15_1 - 1 do
			local var_15_2 = var_15_0[iter_15_0].sharedMaterial

			if not gohelper.isNil(var_15_2) then
				var_15_2:DisableKeyword("_GRADUAL_ON")
				var_15_2:SetFloat(arg_15_0._LineMinYId, 0)
				var_15_2:SetFloat(arg_15_0._LineMaxYId, 0)
			end
		end
	end

	arg_15_0._conMat:DisableKeyword("_GRADUAL_ON")
	arg_15_0._conMat:SetFloat(arg_15_0._LineMinYId, 0)
	arg_15_0._conMat:SetFloat(arg_15_0._LineMaxYId, 0)
end

return var_0_0
