module("modules.ugui.textmeshpro.TMPFadeIn", package.seeall)

local var_0_0 = class("TMPFadeIn", LuaCompBase)

function var_0_0.setTopOffset(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._conMark:SetTopOffset(arg_1_1 or 0, arg_1_2 or 0)
end

function var_0_0.setLineSpacing(arg_2_0, arg_2_1)
	arg_2_0._lineSpacing = arg_2_1 or 0
end

function var_0_0.getLineSpacing(arg_3_0)
	return #arg_3_0._markTopList > 0 and arg_3_0._lineSpacing or arg_3_0._originalLineSpacing
end

function var_0_0._setLineSpacing(arg_4_0, arg_4_1)
	arg_4_0._txtcontentcn.lineSpacing = arg_4_1 or 0
end

function var_0_0.onDestroyView(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._delayShow, arg_5_0)
	GameUtil.onDestroyViewMember_TweenId(arg_5_0, "_conTweenId")
end

local var_0_1 = 0.03

function var_0_0.init(arg_6_0, arg_6_1)
	arg_6_0._lastBottomLeft = 0
	arg_6_0._lineSpace = 0
	arg_6_0._hasUnderline = false
	arg_6_0._markTopList = {}
	arg_6_0._contentGO = arg_6_1
	arg_6_0._norDiaGO = gohelper.findChild(arg_6_1, "go_normalcontent")
	arg_6_0._txtcontentcn = gohelper.findChildText(arg_6_0._norDiaGO, "txt_contentcn")
	arg_6_0._conMat = arg_6_0._txtcontentcn.fontMaterial
	arg_6_0._txtmarktop = IconMgr.instance:getCommonTextMarkTop(arg_6_0._txtcontentcn.gameObject):GetComponent(gohelper.Type_TextMesh)
	arg_6_0._conMark = gohelper.onceAddComponent(arg_6_0._txtcontentcn.gameObject, typeof(ZProj.TMPMark))

	arg_6_0._conMark:SetMarkTopGo(arg_6_0._txtmarktop.gameObject)

	local var_6_0 = UnityEngine.Shader

	arg_6_0._LineMinYId = var_6_0.PropertyToID("_LineMinY")
	arg_6_0._LineMaxYId = var_6_0.PropertyToID("_LineMaxY")
	arg_6_0._originalLineSpacing = arg_6_0._txtcontentcn.lineSpacing
	arg_6_0._lineSpacing = arg_6_0._originalLineSpacing
end

function var_0_0.hideDialog(arg_7_0)
	if arg_7_0._conTweenId then
		ZProj.TweenHelper.KillById(arg_7_0._conTweenId)

		arg_7_0._conTweenId = nil
	end

	gohelper.setActive(arg_7_0._norDiaGO, false)

	local var_7_0, var_7_1, var_7_2 = transformhelper.getLocalPos(arg_7_0._txtcontentcn.transform)

	transformhelper.setLocalPos(arg_7_0._txtcontentcn.transform, var_7_0, var_7_1, 1)
end

function var_0_0.playNormalText(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0._conMat:EnableKeyword("_GRADUAL_ON")

	local var_8_0 = UnityEngine.Screen.height

	arg_8_0._conMat:SetFloat(arg_8_0._LineMinYId, var_8_0)
	arg_8_0._conMat:SetFloat(arg_8_0._LineMaxYId, var_8_0)
	gohelper.setActive(arg_8_0._norDiaGO, true)

	arg_8_0._markTopList = StoryTool.getMarkTopTextList(arg_8_1)
	arg_8_0._txt = StoryTool.filterMarkTop(arg_8_1)
	arg_8_0._finishCallback = arg_8_2
	arg_8_0._finishCallbackObj = arg_8_3

	arg_8_0:_setLineSpacing(arg_8_0:getLineSpacing())

	local var_8_1, var_8_2, var_8_3 = transformhelper.getLocalPos(arg_8_0._txtcontentcn.transform)

	transformhelper.setLocalPos(arg_8_0._txtcontentcn.transform, var_8_1, var_8_2, 1)

	arg_8_0._txtcontentcn.text = arg_8_0._txt

	TaskDispatcher.cancelTask(arg_8_0._delayShow, arg_8_0)
	TaskDispatcher.runDelay(arg_8_0._delayShow, arg_8_0, 0.01)
end

function var_0_0._delayShow(arg_9_0)
	arg_9_0._lastBottomLeft = 0
	arg_9_0._lineSpace = 0
	arg_9_0._hasUnderline = string.find(arg_9_0._txt, "<u>") and string.find(arg_9_0._txt, "</u>")

	arg_9_0._conMark:SetMarksTop(arg_9_0._markTopList)

	local var_9_0 = CameraMgr.instance:getUICamera()
	local var_9_1 = arg_9_0._txtcontentcn:GetTextInfo(arg_9_0._txt)

	arg_9_0._textInfo = var_9_1
	arg_9_0._lineInfoList = {}

	local var_9_2 = 0
	local var_9_3 = arg_9_0._txtcontentcn.transform

	for iter_9_0 = 1, var_9_1.lineCount do
		local var_9_4 = var_9_1.lineInfo[iter_9_0 - 1]
		local var_9_5 = var_9_2 + 1

		var_9_2 = var_9_2 + var_9_4.visibleCharacterCount

		local var_9_6 = arg_9_0._textInfo.characterInfo
		local var_9_7 = var_9_6[var_9_4.firstVisibleCharacterIndex]
		local var_9_8 = var_9_6[var_9_4.lastVisibleCharacterIndex]
		local var_9_9 = var_9_0:WorldToScreenPoint(var_9_3:TransformPoint(var_9_7.bottomLeft))
		local var_9_10 = var_9_0:WorldToScreenPoint(var_9_3:TransformPoint(var_9_7.topLeft))
		local var_9_11 = var_9_9.y
		local var_9_12 = var_9_10.y

		for iter_9_1 = var_9_4.firstVisibleCharacterIndex, var_9_4.lastVisibleCharacterIndex do
			local var_9_13 = var_9_6[iter_9_1]
			local var_9_14 = var_9_0:WorldToScreenPoint(var_9_3:TransformPoint(var_9_13.bottomLeft))

			if var_9_11 > var_9_14.y then
				var_9_11 = var_9_14.y
			end

			local var_9_15 = var_9_0:WorldToScreenPoint(var_9_3:TransformPoint(var_9_13.topLeft))

			if var_9_12 < var_9_15.y then
				var_9_12 = var_9_15.y
			end
		end

		var_9_9.y = var_9_11
		var_9_10.y = var_9_12

		local var_9_16 = var_9_0:WorldToScreenPoint(var_9_3:TransformPoint(var_9_8.bottomRight))

		table.insert(arg_9_0._lineInfoList, {
			var_9_4,
			var_9_5,
			var_9_2,
			var_9_9,
			var_9_10,
			var_9_16
		})
	end

	arg_9_0._contentX, arg_9_0._contentY, _ = transformhelper.getLocalPos(arg_9_0._txtcontentcn.transform)
	arg_9_0._curLine = nil

	local var_9_17 = var_0_1 * var_9_2

	if arg_9_0._conTweenId then
		ZProj.TweenHelper.KillById(arg_9_0._conTweenId)

		arg_9_0._conTweenId = nil
	end

	arg_9_0._conTweenId = ZProj.TweenHelper.DOTweenFloat(1, var_9_2, var_9_17, arg_9_0._conUpdate, arg_9_0.conFinished, arg_9_0)
end

function var_0_0._conUpdate(arg_10_0, arg_10_1)
	local var_10_0 = UnityEngine.Screen.width

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._lineInfoList) do
		local var_10_1 = iter_10_1[1]
		local var_10_2 = iter_10_1[2]
		local var_10_3 = iter_10_1[3]

		if var_10_2 <= arg_10_1 and arg_10_1 <= var_10_3 and var_10_2 ~= var_10_3 then
			local var_10_4 = iter_10_1[4]
			local var_10_5 = iter_10_1[5]
			local var_10_6 = iter_10_1[6]

			if arg_10_0._curLine ~= iter_10_0 then
				arg_10_0._curLine = iter_10_0

				local var_10_7 = var_10_4
				local var_10_8 = var_10_5

				if iter_10_0 == 1 then
					if arg_10_0._hasUnderline then
						arg_10_0._conMat:SetFloat(arg_10_0._LineMinYId, var_10_7.y - 4)
					else
						arg_10_0._conMat:SetFloat(arg_10_0._LineMinYId, var_10_7.y)
					end

					arg_10_0._conMat:SetFloat(arg_10_0._LineMaxYId, var_10_8.y + 20)
				else
					arg_10_0._lineSpace = arg_10_0._lastBottomLeft - var_10_8.y > 0 and arg_10_0._lastBottomLeft - var_10_8.y or arg_10_0._lineSpace

					arg_10_0._conMat:SetFloat(arg_10_0._LineMinYId, var_10_7.y)
					arg_10_0._conMat:SetFloat(arg_10_0._LineMaxYId, var_10_8.y + arg_10_0._lineSpace)
				end

				arg_10_0._lastBottomLeft = var_10_7.y

				local var_10_9 = arg_10_0._txtcontentcn.gameObject

				gohelper.setActive(var_10_9, false)
				gohelper.setActive(var_10_9, true)
			end

			local var_10_10 = (arg_10_1 - var_10_2) / (var_10_3 - var_10_2)
			local var_10_11 = Mathf.Lerp(var_10_4.x, var_10_6.x, var_10_10)

			transformhelper.setLocalPos(arg_10_0._txtcontentcn.transform, arg_10_0._contentX, arg_10_0._contentY, 1 - var_10_11 / var_10_0)
		end
	end
end

function var_0_0.isPlaying(arg_11_0)
	return arg_11_0._conTweenId and true or false
end

function var_0_0.conFinished(arg_12_0)
	if arg_12_0._conTweenId then
		ZProj.TweenHelper.KillById(arg_12_0._conTweenId)

		arg_12_0._conTweenId = nil
	end

	arg_12_0:_disable_GRADUAL_ON()

	local var_12_0, var_12_1, var_12_2 = transformhelper.getLocalPos(arg_12_0._txtcontentcn.transform)

	transformhelper.setLocalPos(arg_12_0._txtcontentcn.transform, var_12_0, var_12_1, 0)

	if arg_12_0._finishCallback then
		arg_12_0._finishCallback(arg_12_0._finishCallbackObj)
	end
end

function var_0_0._disable_GRADUAL_ON(arg_13_0)
	local var_13_0 = arg_13_0._txtcontentcn.gameObject:GetComponentsInChildren(gohelper.Type_TMP_SubMeshUI, true)

	if var_13_0 then
		local var_13_1 = var_13_0.Length

		for iter_13_0 = 0, var_13_1 - 1 do
			local var_13_2 = var_13_0[iter_13_0].sharedMaterial

			if not gohelper.isNil(var_13_2) then
				var_13_2:DisableKeyword("_GRADUAL_ON")
				var_13_2:SetFloat(arg_13_0._LineMinYId, 0)
				var_13_2:SetFloat(arg_13_0._LineMaxYId, 0)
			end
		end
	end

	arg_13_0._conMat:DisableKeyword("_GRADUAL_ON")
	arg_13_0._conMat:SetFloat(arg_13_0._LineMinYId, 0)
	arg_13_0._conMat:SetFloat(arg_13_0._LineMaxYId, 0)
end

function var_0_0.onDestroy(arg_14_0)
	arg_14_0:onDestroyView()
end

function var_0_0.onDestroyView(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._delayShow, arg_15_0)
	GameUtil.onDestroyViewMember_TweenId(arg_15_0, "_conTweenId")
end

return var_0_0
