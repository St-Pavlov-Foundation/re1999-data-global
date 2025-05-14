module("modules.logic.story.view.StoryFrontItem", package.seeall)

local var_0_0 = class("StoryFrontItem")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._frontGO = arg_1_1
	arg_1_0._txtscreentext = gohelper.findChildText(arg_1_1, "txt_screentext")
	arg_1_0._txtscreentextmesh = gohelper.findChildText(arg_1_1, "txt_screentextmesh")
	arg_1_0._imagefulltop = gohelper.findChildImage(arg_1_1, "image_fulltop")
	arg_1_0._goupfade = gohelper.findChild(arg_1_1, "go_upfade")
	arg_1_0._goirregularshake = gohelper.findChild(arg_1_1.transform.parent.gameObject, "#go_irregularshake")

	arg_1_0:setFullTopShow()
	gohelper.setActive(arg_1_0._txtscreentext.gameObject, false)

	arg_1_0._imagefulltop.color.a = 1
	arg_1_0._imagefulltop.color = Color.black

	arg_1_0:_addEvent()
end

function var_0_0._addEvent(arg_2_0)
	StoryController.instance:registerCallback(StoryEvent.PlayDarkFadeUp, arg_2_0._playDarkUpFade, arg_2_0)
	StoryController.instance:registerCallback(StoryEvent.PlayDarkFade, arg_2_0._playDarkFade, arg_2_0)
	StoryController.instance:registerCallback(StoryEvent.PlayWhiteFade, arg_2_0._playWhiteFade, arg_2_0)
end

function var_0_0._removeEvent(arg_3_0)
	StoryController.instance:unregisterCallback(StoryEvent.PlayDarkFadeUp, arg_3_0._playDarkUpFade, arg_3_0)
	StoryController.instance:unregisterCallback(StoryEvent.PlayDarkFade, arg_3_0._playDarkFade, arg_3_0)
	StoryController.instance:unregisterCallback(StoryEvent.PlayWhiteFade, arg_3_0._playWhiteFade, arg_3_0)
end

function var_0_0.showFullScreenText(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_1 then
		arg_4_0._finishCallback = nil
		arg_4_0._finishCallbackObj = nil

		ZProj.TweenHelper.KillByObj(arg_4_0._txtscreentext)
		ZProj.TweenHelper.KillByObj(arg_4_0._copyText)

		if arg_4_0._copyText then
			gohelper.destroy(arg_4_0._copyText.gameObject)

			arg_4_0._copyText = nil
		end
	end

	arg_4_0._diatxt = string.gsub(arg_4_2, "<notShowInLog>", "")
	arg_4_0._markScreenText = arg_4_0._txtscreentext

	if string.match(arg_4_2, "marktop") then
		arg_4_0._markScreenText = arg_4_0._txtscreentextmesh

		gohelper.setActive(arg_4_0._txtscreentext.gameObject, false)
		gohelper.setActive(arg_4_0._txtscreentextmesh.gameObject, arg_4_1)

		arg_4_0._markScreenText.alignment = StoryTool.getTxtAlignment(arg_4_0._diatxt, gohelper.Type_TextMesh)
		arg_4_0._txtmarktop = IconMgr.instance:getCommonTextMarkTop(arg_4_0._markScreenText.gameObject):GetComponent(gohelper.Type_TextMesh)
		arg_4_0._conMark = gohelper.onceAddComponent(arg_4_0._markScreenText.gameObject, typeof(ZProj.TMPMark))

		arg_4_0._conMark:SetMarkTopGo(arg_4_0._txtmarktop.gameObject)
		arg_4_0:_setFullScreenItem()
	else
		gohelper.setActive(arg_4_0._txtscreentext.gameObject, arg_4_1)
		gohelper.setActive(arg_4_0._txtscreentextmesh.gameObject, false)

		arg_4_0._txtscreentext.alignment = StoryTool.getTxtAlignment(arg_4_0._diatxt, gohelper.Type_Text)

		arg_4_0:_setFullScreenItem()
	end
end

function var_0_0._setFullScreenItem(arg_5_0)
	local var_5_0 = StoryController.instance._curStepId
	local var_5_1 = StoryStepModel.instance:getStepListById(var_5_0)

	arg_5_0._diatxt = StoryModel.instance:getStoryTxtByVoiceType(arg_5_0._diatxt, var_5_1.conversation.audios[1] or 0)
	arg_5_0._markScreenText.text = StoryTool.getFilterAlignTxt(arg_5_0._diatxt)
end

function var_0_0._getFadeTime(arg_6_0)
	return not StoryModel.instance.skipFade and 1 or 0
end

function var_0_0.setFullTopShow(arg_7_0)
	gohelper.setActive(arg_7_0._imagefulltop.gameObject, not StoryModel.instance.skipFade and true or false)
end

function var_0_0.playStoryViewIn(arg_8_0)
	local var_8_0 = StoryModel.instance:isTypeSkip(StoryEnum.SkipType.InDarkFade, StoryController.instance._curStoryId)

	StoryModel.instance.skipFade = var_8_0

	ZProj.TweenHelper.KillByObj(arg_8_0._imagefulltop)

	arg_8_0._imagefulltop.color.a = 1

	arg_8_0:setFullTopShow()

	if not var_8_0 then
		TaskDispatcher.runDelay(arg_8_0._startStoryViewIn, arg_8_0, 0.5)
	end
end

function var_0_0._startStoryViewIn(arg_9_0)
	local var_9_0 = arg_9_0._imagefulltop.color.a

	ZProj.TweenHelper.DoFade(arg_9_0._imagefulltop, var_9_0, 0, arg_9_0:_getFadeTime(), function()
		gohelper.setActive(arg_9_0._imagefulltop.gameObject, false)
	end, nil, nil, EaseType.Linear)
end

function var_0_0.playStoryViewOut(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = StoryModel.instance:isTypeSkip(StoryEnum.SkipType.OutDarkFade, StoryController.instance._curStoryId)

	StoryModel.instance.skipFade = var_11_0

	arg_11_0:setFullTopShow()

	arg_11_0._imagefulltop.color.a = 0
	arg_11_0._finishCallback = nil
	arg_11_0._finishCallbackObj = nil

	ZProj.TweenHelper.KillByObj(arg_11_0._txtscreentext)
	ZProj.TweenHelper.KillByObj(arg_11_0._copyText)

	if arg_11_0._copyText then
		gohelper.destroy(arg_11_0._copyText.gameObject)

		arg_11_0._copyText = nil
	end

	arg_11_0._outCallback = arg_11_1
	arg_11_0._outCallbackObj = arg_11_2

	ZProj.TweenHelper.KillByObj(arg_11_0._imagefulltop)
	ZProj.TweenHelper.DoFade(arg_11_0._imagefulltop, 0, 1, arg_11_0:_getFadeTime(), arg_11_0.enterStoryFinish, arg_11_0, nil, EaseType.Linear)
end

function var_0_0.enterStoryFinish(arg_12_0)
	gohelper.setActive(arg_12_0._txtscreentext.gameObject, false)
	gohelper.setActive(arg_12_0._txtscreentextmesh.gameObject, false)
	StoryController.instance:dispatchEvent(StoryEvent.Hide)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenFullView, arg_12_0._onOpenView, arg_12_0)
	TaskDispatcher.runDelay(arg_12_0._viewFadeOut, arg_12_0, 0.5)
	StoryController.instance:finished()
end

function var_0_0._onOpenView(arg_13_0, arg_13_1)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenFullView, arg_13_0._onOpenView, arg_13_0)

	if arg_13_1 == ViewName.StoryView or arg_13_1 == ViewName.StoryBackgroundView then
		TaskDispatcher.cancelTask(arg_13_0._viewFadeOut, arg_13_0)

		return
	end

	local var_13_0 = StoryController.instance._curStoryId

	if StoryModel.instance:isStoryFinished(var_13_0) then
		StoryController.instance:closeStoryView()
	end
end

function var_0_0.cancelViewFadeOut(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._viewFadeOut, arg_14_0)
end

function var_0_0._viewFadeOut(arg_15_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenFullView, arg_15_0._onOpenView, arg_15_0)
	StoryController.instance:closeStoryView()
	TaskDispatcher.runDelay(arg_15_0._viewFadeOutFinished, arg_15_0, 0.1)
	StoryController.instance:dispatchEvent(StoryEvent.FrontItemFadeOut)
end

function var_0_0._viewFadeOutFinished(arg_16_0)
	gohelper.setActive(arg_16_0._imagefulltop.gameObject, false)

	if arg_16_0._outCallback then
		arg_16_0._outCallback(arg_16_0._outCallbackObj)
	end
end

function var_0_0._playDarkUpFade(arg_17_0)
	gohelper.setActive(arg_17_0._goupfade, true)
	transformhelper.setLocalPosXY(arg_17_0._goupfade.transform, 0, 390)
	ZProj.TweenHelper.DOLocalMove(arg_17_0._goupfade.transform, 0, 2800, 0, 1.5, function()
		gohelper.setActive(arg_17_0._goupfade, false)
	end)
end

function var_0_0._playDarkFade(arg_19_0)
	StoryModel.instance.skipFade = false

	arg_19_0:setFullTopShow()

	arg_19_0._imagefulltop.color.a = 0
	arg_19_0._imagefulltop.color = Color.black

	ZProj.TweenHelper.DoFade(arg_19_0._imagefulltop, 0, 1, 1.5, arg_19_0._playDarkFadeFinished, arg_19_0, nil, EaseType.Linear)
end

function var_0_0._playDarkFadeFinished(arg_20_0)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshView)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshBackground)
	ZProj.TweenHelper.KillByObj(arg_20_0._imagefulltop)
	TaskDispatcher.runDelay(arg_20_0._playDarkFadeInFinished, arg_20_0, 0.5)
end

function var_0_0._playDarkFadeInFinished(arg_21_0)
	ZProj.TweenHelper.DoFade(arg_21_0._imagefulltop, 1, 0, 1.5, arg_21_0._hideImageFullTop, arg_21_0, nil, EaseType.Linear)
end

function var_0_0._hideImageFullTop(arg_22_0)
	arg_22_0._imagefulltop.color = Color.black

	gohelper.setActive(arg_22_0._imagefulltop.gameObject, false)
end

function var_0_0._playWhiteFade(arg_23_0)
	StoryModel.instance.skipFade = false

	arg_23_0:setFullTopShow()

	arg_23_0._imagefulltop.color.a = 0
	arg_23_0._imagefulltop.color = Color.white

	ZProj.TweenHelper.DoFade(arg_23_0._imagefulltop, 0, 1, 1.5, arg_23_0._playWhiteFadeFinished, arg_23_0, nil, EaseType.Linear)
end

function var_0_0._playWhiteFadeFinished(arg_24_0)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshView)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshBackground)
	ZProj.TweenHelper.KillByObj(arg_24_0._imagefulltop)
	TaskDispatcher.runDelay(arg_24_0._playDarkFadeInFinished, arg_24_0, 0.5)
end

function var_0_0._playWhiteFadeInFinished(arg_25_0)
	ZProj.TweenHelper.DoFade(arg_25_0._imagefulltop, 1, 0, 1.5, arg_25_0._hideImageFullTop, arg_25_0, nil, EaseType.Linear)
end

function var_0_0.playIrregularShakeText(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	arg_26_0._stepCo = arg_26_1

	gohelper.setActive(arg_26_0._goirregularshake, true)

	arg_26_0._shakefinishCallback = arg_26_2
	arg_26_0._shakefinishCallbackObj = arg_26_3

	if not arg_26_0._goshake then
		local var_26_0 = ViewMgr.instance:getContainer(ViewName.StoryFrontView)

		arg_26_0._goshake = var_26_0:getResInst(var_26_0:getSetting().otherRes[1], arg_26_0._goirregularshake)
	end

	local var_26_1 = gohelper.findChildText(arg_26_0._goshake, "tex_ani/#tex").gameObject

	arg_26_0._tmpMarkTopText = MonoHelper.addNoUpdateLuaComOnceToGo(var_26_1, TMPMarkTopText)

	arg_26_0._tmpMarkTopText:registerRebuildLayout(var_26_1.transform.parent)

	arg_26_0._shakeAni = arg_26_0._goshake:GetComponent(typeof(UnityEngine.Animator))

	arg_26_0._tmpMarkTopText:setData(arg_26_0._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

	local var_26_2 = arg_26_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] - 0.17

	if var_26_2 < 0.1 then
		if arg_26_0._shakefinishCallback then
			arg_26_0._shakefinishCallback(arg_26_0._shakefinishCallbackObj)

			arg_26_0._shakefinishCallback = nil
			arg_26_0._shakefinishCallbackObj = nil
		end

		return
	end

	TaskDispatcher.runDelay(arg_26_0._onShakeEnd, arg_26_0, var_26_2)
end

function var_0_0._onShakeEnd(arg_27_0)
	arg_27_0._shakeAni:Play("close", 0, 0)
	TaskDispatcher.runDelay(function()
		gohelper.setActive(arg_27_0._goirregularshake, false)

		if arg_27_0._shakefinishCallback then
			arg_27_0._shakefinishCallback(arg_27_0._shakefinishCallbackObj)

			arg_27_0._shakefinishCallback = nil
			arg_27_0._shakefinishCallbackObj = nil
		end
	end, nil, 0.17)
end

function var_0_0.wordByWord(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	arg_29_0._stepCo = arg_29_1

	gohelper.setActive(arg_29_0._txtscreentext.gameObject, true)

	arg_29_0._finishCallback = arg_29_2
	arg_29_0._finishCallbackObj = arg_29_3

	ZProj.UGUIHelper.SetColorAlpha(arg_29_0._txtscreentext, 1)

	if arg_29_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		if arg_29_0._finishCallback then
			arg_29_0._finishCallback(arg_29_0._finishCallbackObj)

			arg_29_0._finishCallback = nil
			arg_29_0._finishCallbackObj = nil
		end

		return
	end

	arg_29_0:_startWordByWord()
end

function var_0_0._startWordByWord(arg_30_0)
	ZProj.TweenHelper.KillByObj(arg_30_0._txtscreentext)

	arg_30_0._txtscreentext.text = ""

	local var_30_0 = StoryTool.getTxtAlignment(arg_30_0._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

	arg_30_0._txtscreentext.alignment = var_30_0

	local var_30_1 = StoryTool.getFilterAlignTxt(arg_30_0._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

	ZProj.TweenHelper.DOText(arg_30_0._txtscreentext, var_30_1, arg_30_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], function()
		if arg_30_0._finishCallback then
			arg_30_0._finishCallback(arg_30_0._finishCallbackObj)
		end
	end)
end

function var_0_0.lineShow(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4)
	arg_32_0._stepCo = arg_32_2

	gohelper.setActive(arg_32_0._markScreenText.gameObject, true)

	arg_32_0._finishCallback = arg_32_3
	arg_32_0._finishCallbackObj = arg_32_4

	ZProj.UGUIHelper.SetColorAlpha(arg_32_0._markScreenText, 1)

	if arg_32_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_32_0:_lineWordShowFinished()

		if arg_32_0._finishCallback then
			arg_32_0._finishCallback(arg_32_0._finishCallbackObj)
		end

		return
	end

	arg_32_0:_startShowLine(arg_32_1)
end

function var_0_0._startShowLine(arg_33_0, arg_33_1)
	local var_33_0 = gohelper.Type_Text

	if not arg_33_0._copyText then
		local var_33_1 = gohelper.cloneInPlace(arg_33_0._markScreenText.gameObject, "copytext")

		gohelper.destroyAllChildren(var_33_1)

		local var_33_2 = var_33_1:GetComponent(gohelper.Type_TextMesh)

		var_33_0 = var_33_2 and gohelper.Type_TextMesh or var_33_0
		arg_33_0._copyText = var_33_1:GetComponent(var_33_0)

		if var_33_2 then
			arg_33_0._conMark:SetMarksTop({})

			arg_33_0._txtcopymarktop = IconMgr.instance:getCommonTextMarkTop(arg_33_0._copyText.gameObject):GetComponent(gohelper.Type_TextMesh)
			arg_33_0._conCopyMark = gohelper.onceAddComponent(arg_33_0._copyText.gameObject, typeof(ZProj.TMPMark))

			arg_33_0._conCopyMark:SetMarkTopGo(arg_33_0._txtcopymarktop.gameObject)
			arg_33_0._conCopyMark:SetMarksTop({})
		end

		arg_33_0._copyCanvasGroup = gohelper.onceAddComponent(arg_33_0._copyText.gameObject, typeof(UnityEngine.CanvasGroup))
	end

	arg_33_0._copyText.alignment = StoryTool.getTxtAlignment(arg_33_0._diatxt, var_33_0)
	arg_33_0._diatxt = StoryTool.getFilterAlignTxt(arg_33_0._diatxt)
	arg_33_0._diatxt = StoryModel.instance:getStoryTxtByVoiceType(arg_33_0._diatxt, arg_33_0._stepCo.conversation.audio or 0)

	gohelper.setActive(arg_33_0._copyText.gameObject, true)

	local var_33_3 = arg_33_0:_getLineWord(arg_33_1)
	local var_33_4 = #var_33_3 == 0 and arg_33_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] or arg_33_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] / #var_33_3
	local var_33_5 = 1

	local function var_33_6(arg_34_0)
		local var_34_0 = " "
		local var_34_1 = ""
		local var_34_2 = #string.split(var_34_1, "\n")

		if var_34_2 > 1 then
			for iter_34_0 = 2, var_34_2 do
				var_34_0 = string.format("%s\n%s", var_34_0, " ")
			end
		end

		if #var_33_3 > 1 then
			for iter_34_1 = 1, #var_33_3 do
				local var_34_3 = #string.split(var_33_3[iter_34_1], "\n") or 1

				if iter_34_1 < arg_34_0 then
					var_34_1 = string.format("%s\n%s", var_34_1, var_33_3[iter_34_1])

					for iter_34_2 = 1, var_34_3 do
						local var_34_4, var_34_5, var_34_6, var_34_7 = string.match(string.split(var_33_3[iter_34_1], "\n")[iter_34_2], "(.*)<size=(%d+)>(.*)</size>(%s*)")

						if var_34_5 and tonumber(var_34_5) then
							var_34_0 = string.format("%s\n%s", var_34_0, string.format("<size=%s> </size>", var_34_5))
						else
							var_34_0 = string.format("%s\n%s", var_34_0, " ")
						end
					end
				elseif iter_34_1 == arg_34_0 then
					for iter_34_3 = 1, var_34_3 do
						var_34_1 = string.format("%s\n%s", var_34_1, " ")
					end

					var_34_0 = string.format("%s\n%s", var_34_0, var_33_3[iter_34_1])
				else
					for iter_34_4 = 1, var_34_3 do
						var_34_1 = string.format("%s\n%s", var_34_1, " ")
						var_34_0 = string.format("%s\n%s", var_34_0, " ")
					end
				end
			end
		end

		local var_34_8 = StoryTool.getMarkTopTextList(var_34_1)
		local var_34_9 = StoryTool.filterMarkTop(var_34_1)

		arg_33_0._markScreenText.text = StoryTool.filterSpTag(var_34_9)

		TaskDispatcher.runDelay(function()
			if arg_33_0._conMark and arg_33_0._txtscreentextmesh.gameObject.activeSelf then
				arg_33_0._conMark:SetMarksTop(var_34_8)
			end
		end, nil, 0.01)

		local var_34_10 = StoryTool.getMarkTopTextList(var_34_0)
		local var_34_11 = StoryTool.filterMarkTop(var_34_0)
		local var_34_12 = StoryTool.filterSpTag(var_34_11)

		arg_33_0._copyText.text = var_34_12

		TaskDispatcher.runDelay(function()
			if arg_33_0._conCopyMark then
				arg_33_0._conCopyMark:SetMarksTop(var_34_10)
			end
		end, nil, 0.01)
		ZProj.TweenHelper.KillByObj(arg_33_0._markScreenText)
		ZProj.TweenHelper.KillByObj(arg_33_0._copyText)
		ZProj.UGUIHelper.SetColorAlpha(arg_33_0._markScreenText, 1)
		ZProj.TweenHelper.DOFadeCanvasGroup(arg_33_0._copyText.gameObject, 0, 1, var_33_4, function()
			if arg_34_0 - #var_33_3 >= 0 then
				arg_33_0:_lineWordShowFinished()
			else
				arg_34_0 = arg_34_0 + 1

				var_33_6(arg_34_0)
			end
		end, nil, nil, EaseType.Linear)
	end

	var_33_6(var_33_5)
end

function var_0_0._getLineWord(arg_38_0, arg_38_1)
	local var_38_0 = string.split(arg_38_0._diatxt, "\n")
	local var_38_1 = {}
	local var_38_2 = math.floor(#var_38_0 / arg_38_1)

	for iter_38_0 = 0, var_38_2 - 1 do
		local var_38_3 = var_38_0[iter_38_0 * arg_38_1 + 1]

		for iter_38_1 = 2, arg_38_1 do
			var_38_3 = string.format("%s\n%s", var_38_3, var_38_0[iter_38_0 * arg_38_1 + iter_38_1])
		end

		table.insert(var_38_1, var_38_3)
	end

	if var_38_2 * arg_38_1 < #var_38_0 then
		local var_38_4 = var_38_0[var_38_2 * arg_38_1 + 1]

		if #var_38_0 - var_38_2 * arg_38_1 > 1 then
			for iter_38_2 = 2, #var_38_0 - var_38_2 * arg_38_1 do
				var_38_4 = string.format("%s\n%s", var_38_4, var_38_0[arg_38_1 * var_38_2 + iter_38_2])
			end
		end

		table.insert(var_38_1, var_38_4)
	end

	return var_38_1
end

function var_0_0._lineWordShowFinished(arg_39_0)
	local var_39_0 = StoryTool.getFilterAlignTxt(arg_39_0._diatxt)
	local var_39_1 = StoryTool.getMarkTopTextList(var_39_0)
	local var_39_2 = StoryTool.filterMarkTop(var_39_0)

	arg_39_0._markScreenText.text = "\n" .. StoryTool.filterSpTag(var_39_2)

	if arg_39_0._copyText then
		arg_39_0._copyText.text = ""
	end

	TaskDispatcher.runDelay(function()
		if arg_39_0._conMark and arg_39_0._txtscreentextmesh.gameObject.activeSelf then
			arg_39_0._conMark:SetMarksTop(var_39_1)
		end

		if arg_39_0._copyText then
			gohelper.destroyAllChildren(arg_39_0._copyText.gameObject)
			gohelper.destroy(arg_39_0._copyText.gameObject)

			arg_39_0._copyText = nil
		end

		if arg_39_0._finishCallback then
			arg_39_0._finishCallback(arg_39_0._finishCallbackObj)
		end
	end, nil, 0.01)
end

function var_0_0.playFullTextFadeOut(arg_41_0)
	ZProj.TweenHelper.KillByObj(arg_41_0._txtscreentext)
	ZProj.TweenHelper.DoFade(arg_41_0._txtscreentext, 1, 0, 0.5, arg_41_0._hideScreenTxt, arg_41_0, nil, EaseType.Linear)
end

function var_0_0._hideScreenTxt(arg_42_0)
	ZProj.TweenHelper.KillByObj(arg_42_0._txtscreentext)
	gohelper.setActive(arg_42_0._txtscreentext.gameObject, false)
end

function var_0_0.playTextFadeIn(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	arg_43_0._stepCo = arg_43_1

	gohelper.setActive(arg_43_0._markScreenText.gameObject, true)

	arg_43_0._finishCallback = arg_43_2
	arg_43_0._finishCallbackObj = arg_43_3

	ZProj.TweenHelper.KillByObj(arg_43_0._markScreenText)

	arg_43_0._txtCanvasGroup = gohelper.onceAddComponent(arg_43_0._markScreenText, typeof(UnityEngine.CanvasGroup))

	if arg_43_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_43_0:_fadeFinished()
	else
		local var_43_0 = arg_43_0._markScreenText.text

		if string.match(var_43_0, "<color=#%x+>") then
			var_43_0 = string.gsub(var_43_0, "<color=#(%x%x%x%x%x%x)(%x-)>", "<color=#%100>")
		end

		local var_43_1 = StoryTool.getMarkTopTextList(var_43_0)
		local var_43_2 = StoryTool.filterMarkTop(var_43_0)

		arg_43_0._markScreenText.text = StoryTool.filterSpTag(var_43_2)

		TaskDispatcher.runDelay(function()
			if arg_43_0._conMark and var_43_1 and #var_43_1 > 0 then
				arg_43_0._conMark:SetMarksTop(var_43_1)
			end
		end, nil, 0.01)

		arg_43_0._floatTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, arg_43_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_43_0._fadeUpdate, arg_43_0._fadeFinished, arg_43_0, nil, EaseType.Linear)
	end
end

function var_0_0._fadeUpdate(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_0._markScreenText.text
	local var_45_1 = math.ceil(255 * arg_45_1)
	local var_45_2 = string.format("%02x", var_45_1)

	if string.match(var_45_0, "<color=#%x+>") then
		local var_45_3 = string.gsub(var_45_0, "<color=#(%x%x%x%x%x%x)(%x+)>", "<color=#%1" .. var_45_2 .. ">")

		arg_45_0._markScreenText.text = var_45_3

		return
	end

	arg_45_0._txtCanvasGroup.alpha = arg_45_1
end

function var_0_0._fadeFinished(arg_46_0)
	arg_46_0._txtCanvasGroup.alpha = 1

	if arg_46_0._finishCallback then
		arg_46_0._finishCallback(arg_46_0._finishCallbackObj)
	end
end

function var_0_0.destroy(arg_47_0)
	arg_47_0:_removeEvent()
	TaskDispatcher.cancelTask(arg_47_0._viewFadeOutFinished, arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0._startStoryViewIn, arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0._viewFadeOut, arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0._onShakeEnd, arg_47_0)

	if arg_47_0._floatTweenId then
		ZProj.TweenHelper.KillById(arg_47_0._floatTweenId)

		arg_47_0._floatTweenId = nil
	end

	ZProj.TweenHelper.KillByObj(arg_47_0._imagefulltop)
	ZProj.TweenHelper.KillByObj(arg_47_0._goupfade.transform)
	ZProj.TweenHelper.KillByObj(arg_47_0._txtscreentext)
end

return var_0_0
