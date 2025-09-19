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

		arg_4_0:_killFloatTween()
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

	arg_5_0._diatxt = StoryModel.instance:getStoryTxtByVoiceType(arg_5_0._diatxt, var_5_1.conversation.audio or 0)
	arg_5_0._txtscreentext.alignment = StoryTool.getTxtAlignment(arg_5_0._diatxt)
	arg_5_0._txtscreentext.text = StoryTool.getFilterAlignTxt(arg_5_0._diatxt)

	arg_5_0:_showGlitch(var_5_1.conversation.effType == StoryEnum.ConversationEffectType.Glitch)

	arg_5_0._diatxt = StoryModel.instance:getStoryTxtByVoiceType(arg_5_0._diatxt, var_5_1.conversation.audios[1] or 0)
	arg_5_0._markScreenText.text = StoryTool.getFilterAlignTxt(arg_5_0._diatxt)
end

function var_0_0._showGlitch(arg_6_0, arg_6_1)
	if arg_6_1 then
		if not arg_6_0._goGlitch then
			arg_6_0._glitchPath = ResUrl.getEffect("story/v2a6_fontglitch")
			arg_6_0._effLoader = MultiAbLoader.New()

			arg_6_0._effLoader:addPath(arg_6_0._glitchPath)
			arg_6_0._effLoader:startLoad(arg_6_0._glitchEffLoaded, arg_6_0)
		else
			local var_6_0 = arg_6_0._txtscreentext.gameObject:GetComponent(typeof(UnityEngine.UI.CustomText))

			var_6_0.isSetParticleShapeMesh = true
			var_6_0.isSetParticleCount = true

			gohelper.setLayer(arg_6_0._txtscreentext.gameObject, UnityLayer.UISecond, true)
			gohelper.setActive(arg_6_0._goGlitch, true)
		end
	else
		gohelper.setLayer(arg_6_0._txtscreentext.gameObject, UnityLayer.UITop, true)

		if arg_6_0._goGlitch then
			gohelper.setActive(arg_6_0._goGlitch, false)
		end

		local var_6_1 = arg_6_0._txtscreentext.gameObject:GetComponent(typeof(UnityEngine.UI.CustomText))

		var_6_1.isSetParticleShapeMesh = false
		var_6_1.isSetParticleCount = false
	end
end

function var_0_0.playGlitch(arg_7_0)
	StoryTool.enablePostProcess(true)
	gohelper.setActive(arg_7_0._txtscreentext.gameObject, true)
	arg_7_0:_showGlitch(true)
end

function var_0_0._glitchEffLoaded(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getAssetItem(arg_8_0._glitchPath)

	arg_8_0._goGlitch = gohelper.clone(var_8_0:GetResource(arg_8_0._glitchPath), arg_8_0._txtscreentext.gameObject)

	gohelper.setActive(arg_8_0._goGlitch, true)

	for iter_8_0 = 1, 4 do
		local var_8_1 = gohelper.findChild(arg_8_0._goGlitch, "part_" .. tostring(iter_8_0))

		gohelper.setActive(var_8_1, false)
	end

	local var_8_2 = gohelper.findChild(arg_8_0._goGlitch, "part_screen")

	gohelper.setActive(var_8_2, true)

	local var_8_3 = arg_8_0._txtscreentext.gameObject:GetComponent(typeof(UnityEngine.UI.CustomText))

	var_8_3.isSetParticleShapeMesh = true
	var_8_3.isSetParticleCount = true
	var_8_3.particle = var_8_2:GetComponent(typeof(UnityEngine.ParticleSystem))

	gohelper.setLayer(arg_8_0._txtscreentext.gameObject, UnityLayer.UISecond, true)
end

function var_0_0._getFadeTime(arg_9_0)
	return not StoryModel.instance.skipFade and 1 or 0
end

function var_0_0.setFullTopShow(arg_10_0)
	gohelper.setActive(arg_10_0._imagefulltop.gameObject, not StoryModel.instance.skipFade and true or false)
end

function var_0_0.playStoryViewIn(arg_11_0)
	local var_11_0 = StoryModel.instance:isTypeSkip(StoryEnum.SkipType.InDarkFade, StoryController.instance._curStoryId)

	StoryModel.instance.skipFade = var_11_0

	ZProj.TweenHelper.KillByObj(arg_11_0._imagefulltop)

	arg_11_0._imagefulltop.color.a = 1

	arg_11_0:setFullTopShow()

	if not var_11_0 then
		TaskDispatcher.runDelay(arg_11_0._startStoryViewIn, arg_11_0, 0.5)
	end
end

function var_0_0._startStoryViewIn(arg_12_0)
	local var_12_0 = arg_12_0._imagefulltop.color.a

	ZProj.TweenHelper.DoFade(arg_12_0._imagefulltop, var_12_0, 0, arg_12_0:_getFadeTime(), function()
		gohelper.setActive(arg_12_0._imagefulltop.gameObject, false)
	end, nil, nil, EaseType.Linear)
end

function var_0_0.playStoryViewOut(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = StoryModel.instance:isTypeSkip(StoryEnum.SkipType.OutDarkFade, StoryController.instance._curStoryId)

	StoryModel.instance.skipFade = var_14_0

	arg_14_0:setFullTopShow()

	arg_14_0._imagefulltop.color.a = 0
	arg_14_0._finishCallback = nil
	arg_14_0._finishCallbackObj = nil

	arg_14_0:_killFloatTween()
	ZProj.TweenHelper.KillByObj(arg_14_0._copyText)

	if arg_14_0._copyText then
		gohelper.destroy(arg_14_0._copyText.gameObject)

		arg_14_0._copyText = nil
	end

	arg_14_0._outCallback = arg_14_1
	arg_14_0._outCallbackObj = arg_14_2

	ZProj.TweenHelper.KillByObj(arg_14_0._imagefulltop)
	ZProj.TweenHelper.DoFade(arg_14_0._imagefulltop, 0, 1, arg_14_0:_getFadeTime(), arg_14_0.enterStoryFinish, arg_14_0, nil, EaseType.Linear)
end

function var_0_0.enterStoryFinish(arg_15_0)
	gohelper.setActive(arg_15_0._txtscreentext.gameObject, false)
	gohelper.setActive(arg_15_0._txtscreentextmesh.gameObject, false)
	StoryController.instance:dispatchEvent(StoryEvent.Hide)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenFullView, arg_15_0._onOpenView, arg_15_0)
	TaskDispatcher.runDelay(arg_15_0._viewFadeOut, arg_15_0, 0.5)
	StoryController.instance:finished()
end

function var_0_0._onOpenView(arg_16_0, arg_16_1)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenFullView, arg_16_0._onOpenView, arg_16_0)

	if arg_16_1 == ViewName.StoryView or arg_16_1 == ViewName.StoryBackgroundView then
		TaskDispatcher.cancelTask(arg_16_0._viewFadeOut, arg_16_0)

		return
	end

	local var_16_0 = StoryController.instance._curStoryId

	if StoryModel.instance:isStoryFinished(var_16_0) then
		StoryController.instance:closeStoryView()
	end
end

function var_0_0.cancelViewFadeOut(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._viewFadeOut, arg_17_0)
end

function var_0_0._viewFadeOut(arg_18_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenFullView, arg_18_0._onOpenView, arg_18_0)
	StoryController.instance:closeStoryView()
	TaskDispatcher.runDelay(arg_18_0._viewFadeOutFinished, arg_18_0, 0.1)
	StoryController.instance:dispatchEvent(StoryEvent.FrontItemFadeOut)
end

function var_0_0._viewFadeOutFinished(arg_19_0)
	gohelper.setActive(arg_19_0._imagefulltop.gameObject, false)

	if arg_19_0._outCallback then
		arg_19_0._outCallback(arg_19_0._outCallbackObj)
	end
end

function var_0_0._playDarkUpFade(arg_20_0)
	gohelper.setActive(arg_20_0._goupfade, true)
	transformhelper.setLocalPosXY(arg_20_0._goupfade.transform, 0, 390)
	ZProj.TweenHelper.DOLocalMove(arg_20_0._goupfade.transform, 0, 2800, 0, 1.5, function()
		gohelper.setActive(arg_20_0._goupfade, false)
	end)
end

function var_0_0._playDarkFade(arg_22_0)
	StoryModel.instance.skipFade = false

	arg_22_0:setFullTopShow()

	arg_22_0._imagefulltop.color.a = 0
	arg_22_0._imagefulltop.color = Color.black

	ZProj.TweenHelper.DoFade(arg_22_0._imagefulltop, 0, 1, 1.5, arg_22_0._playDarkFadeFinished, arg_22_0, nil, EaseType.Linear)
end

function var_0_0._playDarkFadeFinished(arg_23_0)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshView)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshBackground)
	ZProj.TweenHelper.KillByObj(arg_23_0._imagefulltop)
	TaskDispatcher.runDelay(arg_23_0._playDarkFadeInFinished, arg_23_0, 0.5)
end

function var_0_0._playDarkFadeInFinished(arg_24_0)
	ZProj.TweenHelper.DoFade(arg_24_0._imagefulltop, 1, 0, 1.5, arg_24_0._hideImageFullTop, arg_24_0, nil, EaseType.Linear)
end

function var_0_0._hideImageFullTop(arg_25_0)
	arg_25_0._imagefulltop.color = Color.black

	gohelper.setActive(arg_25_0._imagefulltop.gameObject, false)
end

function var_0_0._playWhiteFade(arg_26_0)
	StoryModel.instance.skipFade = false

	arg_26_0:setFullTopShow()

	arg_26_0._imagefulltop.color.a = 0
	arg_26_0._imagefulltop.color = Color.white

	ZProj.TweenHelper.DoFade(arg_26_0._imagefulltop, 0, 1, 1.5, arg_26_0._playWhiteFadeFinished, arg_26_0, nil, EaseType.Linear)
end

function var_0_0._playWhiteFadeFinished(arg_27_0)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshView)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshBackground)
	ZProj.TweenHelper.KillByObj(arg_27_0._imagefulltop)
	TaskDispatcher.runDelay(arg_27_0._playDarkFadeInFinished, arg_27_0, 0.5)
end

function var_0_0._playWhiteFadeInFinished(arg_28_0)
	ZProj.TweenHelper.DoFade(arg_28_0._imagefulltop, 1, 0, 1.5, arg_28_0._hideImageFullTop, arg_28_0, nil, EaseType.Linear)
end

function var_0_0.playIrregularShakeText(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	arg_29_0._stepCo = arg_29_1

	gohelper.setActive(arg_29_0._goirregularshake, true)

	arg_29_0._shakefinishCallback = arg_29_2
	arg_29_0._shakefinishCallbackObj = arg_29_3

	if not arg_29_0._goshake then
		local var_29_0 = ViewMgr.instance:getContainer(ViewName.StoryFrontView)

		arg_29_0._goshake = var_29_0:getResInst(var_29_0:getSetting().otherRes[1], arg_29_0._goirregularshake)
	end

	local var_29_1 = gohelper.findChildText(arg_29_0._goshake, "tex_ani/#tex").gameObject

	arg_29_0._tmpMarkTopText = MonoHelper.addNoUpdateLuaComOnceToGo(var_29_1, TMPMarkTopText)

	arg_29_0._tmpMarkTopText:registerRebuildLayout(var_29_1.transform.parent)

	arg_29_0._shakeAni = arg_29_0._goshake:GetComponent(typeof(UnityEngine.Animator))

	arg_29_0._tmpMarkTopText:setData(arg_29_0._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

	local var_29_2 = arg_29_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] - 0.17

	if var_29_2 < 0.1 then
		if arg_29_0._shakefinishCallback then
			arg_29_0._shakefinishCallback(arg_29_0._shakefinishCallbackObj)

			arg_29_0._shakefinishCallback = nil
			arg_29_0._shakefinishCallbackObj = nil
		end

		return
	end

	TaskDispatcher.runDelay(arg_29_0._onShakeEnd, arg_29_0, var_29_2)
end

function var_0_0._onShakeEnd(arg_30_0)
	arg_30_0._shakeAni:Play("close", 0, 0)
	TaskDispatcher.runDelay(function()
		gohelper.setActive(arg_30_0._goirregularshake, false)

		if arg_30_0._shakefinishCallback then
			arg_30_0._shakefinishCallback(arg_30_0._shakefinishCallbackObj)

			arg_30_0._shakefinishCallback = nil
			arg_30_0._shakefinishCallbackObj = nil
		end
	end, nil, 0.17)
end

function var_0_0.wordByWord(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	arg_32_0._stepCo = arg_32_1

	gohelper.setActive(arg_32_0._txtscreentext.gameObject, true)

	arg_32_0._finishCallback = arg_32_2
	arg_32_0._finishCallbackObj = arg_32_3

	ZProj.UGUIHelper.SetColorAlpha(arg_32_0._txtscreentext, 1)

	if arg_32_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		if arg_32_0._finishCallback then
			arg_32_0._finishCallback(arg_32_0._finishCallbackObj)

			arg_32_0._finishCallback = nil
			arg_32_0._finishCallbackObj = nil
		end

		return
	end

	arg_32_0:_startWordByWord()
end

function var_0_0._startWordByWord(arg_33_0)
	arg_33_0:_killFloatTween()

	arg_33_0._txtscreentext.text = ""

	local var_33_0 = StoryTool.getTxtAlignment(arg_33_0._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

	arg_33_0._txtscreentext.alignment = var_33_0

	local var_33_1 = StoryTool.getFilterAlignTxt(arg_33_0._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

	ZProj.TweenHelper.DOText(arg_33_0._txtscreentext, var_33_1, arg_33_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], function()
		if arg_33_0._finishCallback then
			arg_33_0._finishCallback(arg_33_0._finishCallbackObj)
		end
	end)
end

function var_0_0.lineShow(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	arg_35_0._stepCo = arg_35_2

	gohelper.setActive(arg_35_0._markScreenText.gameObject, true)

	arg_35_0._finishCallback = arg_35_3
	arg_35_0._finishCallbackObj = arg_35_4

	ZProj.UGUIHelper.SetColorAlpha(arg_35_0._markScreenText, 1)

	if arg_35_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_35_0:_lineWordShowFinished()

		if arg_35_0._finishCallback then
			arg_35_0._finishCallback(arg_35_0._finishCallbackObj)
		end

		return
	end

	arg_35_0:_startShowLine(arg_35_1)
end

function var_0_0._startShowLine(arg_36_0, arg_36_1)
	local var_36_0 = gohelper.Type_Text

	arg_36_0._conCopyMark = nil

	if not arg_36_0._copyText then
		local var_36_1 = gohelper.cloneInPlace(arg_36_0._markScreenText.gameObject, "copytext")

		gohelper.destroyAllChildren(var_36_1)

		local var_36_2 = var_36_1:GetComponent(gohelper.Type_TextMesh)

		var_36_0 = var_36_2 and gohelper.Type_TextMesh or var_36_0
		arg_36_0._copyText = var_36_1:GetComponent(var_36_0)

		if var_36_2 then
			arg_36_0._conMark:SetMarksTop({})

			arg_36_0._txtcopymarktop = IconMgr.instance:getCommonTextMarkTop(arg_36_0._copyText.gameObject):GetComponent(gohelper.Type_TextMesh)
			arg_36_0._conCopyMark = gohelper.onceAddComponent(arg_36_0._copyText.gameObject, typeof(ZProj.TMPMark))

			arg_36_0._conCopyMark:SetMarkTopGo(arg_36_0._txtcopymarktop.gameObject)
			arg_36_0._conCopyMark:SetMarksTop({})
		end

		arg_36_0._copyCanvasGroup = gohelper.onceAddComponent(arg_36_0._copyText.gameObject, typeof(UnityEngine.CanvasGroup))
	end

	arg_36_0._copyText.alignment = StoryTool.getTxtAlignment(arg_36_0._diatxt, var_36_0)
	arg_36_0._diatxt = StoryTool.getFilterAlignTxt(arg_36_0._diatxt)
	arg_36_0._diatxt = StoryModel.instance:getStoryTxtByVoiceType(arg_36_0._diatxt, arg_36_0._stepCo.conversation.audio or 0)

	gohelper.setActive(arg_36_0._copyText.gameObject, true)

	local var_36_3 = arg_36_0:_getLineWord(arg_36_1)
	local var_36_4 = #var_36_3 == 0 and arg_36_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] or arg_36_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] / #var_36_3
	local var_36_5 = 1

	local function var_36_6(arg_37_0)
		local var_37_0 = " "
		local var_37_1 = ""
		local var_37_2 = #string.split(var_37_1, "\n")

		if var_37_2 > 1 then
			for iter_37_0 = 2, var_37_2 do
				var_37_0 = string.format("%s\n%s", var_37_0, " ")
			end
		end

		if #var_36_3 >= 1 then
			for iter_37_1 = 1, #var_36_3 do
				local var_37_3 = #string.split(var_36_3[iter_37_1], "\n") or 1

				if iter_37_1 < arg_37_0 then
					var_37_1 = string.format("%s\n%s", var_37_1, var_36_3[iter_37_1])

					for iter_37_2 = 1, var_37_3 do
						local var_37_4, var_37_5, var_37_6, var_37_7 = string.match(string.split(var_36_3[iter_37_1], "\n")[iter_37_2], "(.*)<size=(%d+)>(.*)</size>(%s*)")

						if var_37_5 and tonumber(var_37_5) then
							var_37_0 = string.format("%s\n%s", var_37_0, string.format("<size=%s> </size>", var_37_5))
						else
							var_37_0 = string.format("%s\n%s", var_37_0, " ")
						end
					end
				elseif iter_37_1 == arg_37_0 then
					for iter_37_3 = 1, var_37_3 do
						var_37_1 = string.format("%s\n%s", var_37_1, " ")
					end

					var_37_0 = string.format("%s\n%s", var_37_0, var_36_3[iter_37_1])
				else
					for iter_37_4 = 1, var_37_3 do
						var_37_1 = string.format("%s\n%s", var_37_1, " ")
						var_37_0 = string.format("%s\n%s", var_37_0, " ")
					end
				end
			end
		end

		local var_37_8 = StoryTool.getMarkTopTextList(var_37_1)
		local var_37_9 = StoryTool.filterMarkTop(var_37_1)

		arg_36_0._markScreenText.text = StoryTool.filterSpTag(var_37_9)

		TaskDispatcher.runDelay(function()
			if arg_36_0._conMark and arg_36_0._txtscreentextmesh.gameObject.activeSelf then
				arg_36_0._conMark:SetMarksTop(var_37_8)
			end
		end, nil, 0.01)

		local var_37_10 = StoryTool.getMarkTopTextList(var_37_0)
		local var_37_11 = StoryTool.filterMarkTop(var_37_0)
		local var_37_12 = StoryTool.filterSpTag(var_37_11)

		arg_36_0._copyText.text = var_37_12

		TaskDispatcher.runDelay(function()
			if arg_36_0._conCopyMark then
				arg_36_0._conCopyMark:SetMarksTop(var_37_10)
			end
		end, nil, 0.01)
		ZProj.TweenHelper.KillByObj(arg_36_0._markScreenText)
		ZProj.TweenHelper.KillByObj(arg_36_0._copyText)
		ZProj.UGUIHelper.SetColorAlpha(arg_36_0._markScreenText, 1)
		ZProj.TweenHelper.DOFadeCanvasGroup(arg_36_0._copyText.gameObject, 0, 1, var_36_4, function()
			if arg_37_0 - #var_36_3 >= 0 then
				arg_36_0:_lineWordShowFinished()
			else
				arg_37_0 = arg_37_0 + 1

				var_36_6(arg_37_0)
			end
		end, nil, nil, EaseType.Linear)
	end

	var_36_6(var_36_5)
end

function var_0_0._getLineWord(arg_41_0, arg_41_1)
	local var_41_0 = string.split(arg_41_0._diatxt, "\n")
	local var_41_1 = {}
	local var_41_2 = math.floor(#var_41_0 / arg_41_1)

	for iter_41_0 = 0, var_41_2 - 1 do
		local var_41_3 = var_41_0[iter_41_0 * arg_41_1 + 1]

		for iter_41_1 = 2, arg_41_1 do
			var_41_3 = string.format("%s\n%s", var_41_3, var_41_0[iter_41_0 * arg_41_1 + iter_41_1])
		end

		table.insert(var_41_1, var_41_3)
	end

	if var_41_2 * arg_41_1 < #var_41_0 then
		local var_41_4 = var_41_0[var_41_2 * arg_41_1 + 1]

		if #var_41_0 - var_41_2 * arg_41_1 > 1 then
			for iter_41_2 = 2, #var_41_0 - var_41_2 * arg_41_1 do
				var_41_4 = string.format("%s\n%s", var_41_4, var_41_0[arg_41_1 * var_41_2 + iter_41_2])
			end
		end

		table.insert(var_41_1, var_41_4)
	end

	return var_41_1
end

function var_0_0._lineWordShowFinished(arg_42_0)
	local var_42_0 = StoryTool.getFilterAlignTxt(arg_42_0._diatxt)
	local var_42_1 = StoryTool.getMarkTopTextList(var_42_0)
	local var_42_2 = StoryTool.filterMarkTop(var_42_0)

	arg_42_0._markScreenText.text = "\n" .. StoryTool.filterSpTag(var_42_2)

	if arg_42_0._copyText then
		arg_42_0._copyText.text = ""
	end

	TaskDispatcher.runDelay(function()
		if arg_42_0._conMark and arg_42_0._txtscreentextmesh.gameObject.activeSelf then
			arg_42_0._conMark:SetMarksTop(var_42_1)
		end

		if arg_42_0._copyText then
			gohelper.destroyAllChildren(arg_42_0._copyText.gameObject)
			gohelper.destroy(arg_42_0._copyText.gameObject)

			arg_42_0._copyText = nil
		end

		if arg_42_0._finishCallback then
			arg_42_0._finishCallback(arg_42_0._finishCallbackObj)
		end
	end, nil, 0.01)
end

function var_0_0.playFullTextFadeOut(arg_44_0)
	arg_44_0:_killFloatTween()

	arg_44_0._floatTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.5, arg_44_0._fadeUpdate, arg_44_0._hideScreenTxt, arg_44_0, nil, EaseType.Linear)
end

function var_0_0._hideScreenTxt(arg_45_0)
	arg_45_0:_killFloatTween()
	gohelper.setActive(arg_45_0._txtscreentext.gameObject, false)
end

function var_0_0.playTextFadeIn(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	arg_46_0._stepCo = arg_46_1

	gohelper.setActive(arg_46_0._markScreenText.gameObject, true)

	arg_46_0._finishCallback = arg_46_2
	arg_46_0._finishCallbackObj = arg_46_3

	ZProj.TweenHelper.KillByObj(arg_46_0._markScreenText)

	if arg_46_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_46_0:_fadeFinished()
	else
		local var_46_0 = arg_46_0._markScreenText.text

		if string.match(var_46_0, "<color=#%x+>") then
			var_46_0 = string.gsub(var_46_0, "<color=#(%x%x%x%x%x%x)(%x-)>", "<color=#%100>")
		end

		local var_46_1 = StoryTool.getMarkTopTextList(var_46_0)
		local var_46_2 = StoryTool.filterMarkTop(var_46_0)

		arg_46_0._markScreenText.text = StoryTool.filterSpTag(var_46_2)

		TaskDispatcher.runDelay(function()
			if arg_46_0._conMark and var_46_1 and #var_46_1 > 0 then
				arg_46_0._conMark:SetMarksTop(var_46_1)
			end
		end, nil, 0.01)

		arg_46_0._floatTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, arg_46_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_46_0._fadeUpdate, arg_46_0._fadeFinished, arg_46_0, nil, EaseType.Linear)
	end
end

function var_0_0._fadeUpdate(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_0._markScreenText.text
	local var_48_1 = math.ceil(255 * arg_48_1)
	local var_48_2 = string.format("%02x", var_48_1)

	if string.match(var_48_0, "<color=#%x+>") then
		local var_48_3 = string.gsub(var_48_0, "<color=#(%x%x%x%x%x%x)(%x+)>", "<color=#%1" .. var_48_2 .. ">")

		arg_48_0._markScreenText.text = var_48_3

		return
	end

	if not arg_48_0._txtCanvasGroup then
		arg_48_0._txtCanvasGroup = gohelper.onceAddComponent(arg_48_0._markScreenText, typeof(UnityEngine.CanvasGroup))
	end

	arg_48_0._txtCanvasGroup.alpha = arg_48_1
end

function var_0_0._fadeFinished(arg_49_0)
	if arg_49_0._txtCanvasGroup then
		arg_49_0._txtCanvasGroup.alpha = 1
	end

	if arg_49_0._finishCallback then
		arg_49_0._finishCallback(arg_49_0._finishCallbackObj)
	end
end

function var_0_0._killFloatTween(arg_50_0)
	if arg_50_0._floatTweenId then
		ZProj.TweenHelper.KillById(arg_50_0._floatTweenId)

		arg_50_0._floatTweenId = nil
	end
end

function var_0_0.destroy(arg_51_0)
	arg_51_0:_removeEvent()
	arg_51_0:_killFloatTween()
	TaskDispatcher.cancelTask(arg_51_0._viewFadeOutFinished, arg_51_0)
	TaskDispatcher.cancelTask(arg_51_0._startStoryViewIn, arg_51_0)
	TaskDispatcher.cancelTask(arg_51_0._viewFadeOut, arg_51_0)
	TaskDispatcher.cancelTask(arg_51_0._onShakeEnd, arg_51_0)
	ZProj.TweenHelper.KillByObj(arg_51_0._imagefulltop)
	ZProj.TweenHelper.KillByObj(arg_51_0._goupfade.transform)
end

return var_0_0
