module("modules.logic.story.view.StoryFrontItem", package.seeall)

local var_0_0 = class("StoryFrontItem")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._frontGO = arg_1_1
	arg_1_0._txtscreentext = gohelper.findChildText(arg_1_1, "txt_screentext")
	arg_1_0._imagefulltop = gohelper.findChildImage(arg_1_1, "image_fulltop")
	arg_1_0._imageupfade = gohelper.findChildImage(arg_1_1, "go_upfade")
	arg_1_0._imageblock = gohelper.findChildImage(arg_1_1, "#go_block")
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
		arg_4_0._fadeOutCallback = nil
		arg_4_0._fadeOutCallbackObj = nil

		ZProj.TweenHelper.KillByObj(arg_4_0._txtscreentext)
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

function var_0_0.enableFrontRayCast(arg_6_0, arg_6_1)
	arg_6_0._txtscreentext.raycastTarget = arg_6_1
	arg_6_0._imagefulltop.raycastTarget = arg_6_1
	arg_6_0._imageblock.raycastTarget = arg_6_1
	arg_6_0._imageupfade.raycastTarget = arg_6_1
end

function var_0_0._showGlitch(arg_7_0, arg_7_1)
	if arg_7_1 then
		if not arg_7_0._goGlitch then
			arg_7_0._glitchPath = ResUrl.getEffect("story/v2a6_fontglitch")
			arg_7_0._effLoader = MultiAbLoader.New()

			arg_7_0._effLoader:addPath(arg_7_0._glitchPath)
			arg_7_0._effLoader:startLoad(arg_7_0._glitchEffLoaded, arg_7_0)
		else
			local var_7_0 = arg_7_0._txtscreentext.gameObject:GetComponent(typeof(UnityEngine.UI.CustomText))

			var_7_0.isSetParticleShapeMesh = true
			var_7_0.isSetParticleCount = true

			gohelper.setLayer(arg_7_0._txtscreentext.gameObject, UnityLayer.UISecond, true)
			gohelper.setActive(arg_7_0._goGlitch, true)
		end
	else
		gohelper.setLayer(arg_7_0._txtscreentext.gameObject, UnityLayer.UITop, true)

		if arg_7_0._goGlitch then
			gohelper.setActive(arg_7_0._goGlitch, false)
		end

		local var_7_1 = arg_7_0._txtscreentext.gameObject:GetComponent(typeof(UnityEngine.UI.CustomText))

		var_7_1.isSetParticleShapeMesh = false
		var_7_1.isSetParticleCount = false
	end
end

function var_0_0.playGlitch(arg_8_0)
	StoryTool.enablePostProcess(true)
	gohelper.setActive(arg_8_0._txtscreentext.gameObject, true)
	arg_8_0:_showGlitch(true)
end

function var_0_0._glitchEffLoaded(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getAssetItem(arg_9_0._glitchPath)

	arg_9_0._goGlitch = gohelper.clone(var_9_0:GetResource(arg_9_0._glitchPath), arg_9_0._txtscreentext.gameObject)

	gohelper.setActive(arg_9_0._goGlitch, true)

	for iter_9_0 = 1, 4 do
		local var_9_1 = gohelper.findChild(arg_9_0._goGlitch, "part_" .. tostring(iter_9_0))

		gohelper.setActive(var_9_1, false)
	end

	local var_9_2 = gohelper.findChild(arg_9_0._goGlitch, "part_screen")

	gohelper.setActive(var_9_2, true)

	local var_9_3 = arg_9_0._txtscreentext.gameObject:GetComponent(typeof(UnityEngine.UI.CustomText))

	var_9_3.isSetParticleShapeMesh = true
	var_9_3.isSetParticleCount = true
	var_9_3.particle = var_9_2:GetComponent(typeof(UnityEngine.ParticleSystem))

	gohelper.setLayer(arg_9_0._txtscreentext.gameObject, UnityLayer.UISecond, true)
end

function var_0_0._getFadeTime(arg_10_0)
	return not StoryModel.instance.skipFade and 1 or 0
end

function var_0_0.setFullTopShow(arg_11_0)
	gohelper.setActive(arg_11_0._imagefulltop.gameObject, not StoryModel.instance.skipFade and true or false)
end

function var_0_0.playStoryViewIn(arg_12_0)
	local var_12_0 = StoryModel.instance:isTypeSkip(StoryEnum.SkipType.InDarkFade, StoryController.instance._curStoryId)

	StoryModel.instance.skipFade = var_12_0

	ZProj.TweenHelper.KillByObj(arg_12_0._imagefulltop)

	arg_12_0._imagefulltop.color.a = 1

	arg_12_0:setFullTopShow()

	if not var_12_0 then
		TaskDispatcher.runDelay(arg_12_0._startStoryViewIn, arg_12_0, 0.5)
	end
end

function var_0_0._startStoryViewIn(arg_13_0)
	local var_13_0 = arg_13_0._imagefulltop.color.a

	ZProj.TweenHelper.DoFade(arg_13_0._imagefulltop, var_13_0, 0, arg_13_0:_getFadeTime(), function()
		gohelper.setActive(arg_13_0._imagefulltop.gameObject, false)
	end, nil, nil, EaseType.Linear)
end

function var_0_0.playStoryViewOut(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = StoryModel.instance:isTypeSkip(StoryEnum.SkipType.OutDarkFade, StoryController.instance._curStoryId)

	StoryModel.instance.skipFade = var_15_0

	arg_15_0:setFullTopShow()

	arg_15_0._imagefulltop.color.a = 0
	arg_15_0._finishCallback = nil
	arg_15_0._finishCallbackObj = nil
	arg_15_0._fadeOutCallback = nil
	arg_15_0._fadeOutCallbackObj = nil

	ZProj.TweenHelper.KillByObj(arg_15_0._txtscreentext)
	arg_15_0:_killFloatTween()
	ZProj.TweenHelper.KillByObj(arg_15_0._copyText)

	if arg_15_0._copyText then
		gohelper.destroy(arg_15_0._copyText.gameObject)

		arg_15_0._copyText = nil
	end

	arg_15_0._outCallback = arg_15_1
	arg_15_0._outCallbackObj = arg_15_2

	ZProj.TweenHelper.KillByObj(arg_15_0._imagefulltop)
	ZProj.TweenHelper.DoFade(arg_15_0._imagefulltop, 0, 1, arg_15_0:_getFadeTime(), arg_15_0.enterStoryFinish, arg_15_0, nil, EaseType.Linear)
end

function var_0_0.enterStoryFinish(arg_16_0)
	gohelper.setActive(arg_16_0._txtscreentext.gameObject, false)
	gohelper.setActive(arg_16_0._txtscreentextmesh.gameObject, false)
	StoryController.instance:dispatchEvent(StoryEvent.Hide)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenFullView, arg_16_0._onOpenView, arg_16_0)
	TaskDispatcher.runDelay(arg_16_0._viewFadeOut, arg_16_0, 0.5)
	StoryController.instance:finished()
end

function var_0_0._onOpenView(arg_17_0, arg_17_1)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenFullView, arg_17_0._onOpenView, arg_17_0)

	if arg_17_1 == ViewName.StoryView or arg_17_1 == ViewName.StoryBackgroundView then
		TaskDispatcher.cancelTask(arg_17_0._viewFadeOut, arg_17_0)

		return
	end

	local var_17_0 = StoryController.instance._curStoryId

	if StoryModel.instance:isStoryFinished(var_17_0) then
		StoryController.instance:closeStoryView()
	end
end

function var_0_0.cancelViewFadeOut(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._viewFadeOut, arg_18_0)
end

function var_0_0._viewFadeOut(arg_19_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenFullView, arg_19_0._onOpenView, arg_19_0)
	StoryController.instance:closeStoryView()
	TaskDispatcher.runDelay(arg_19_0._viewFadeOutFinished, arg_19_0, 0.1)
	StoryController.instance:dispatchEvent(StoryEvent.FrontItemFadeOut)
end

function var_0_0._viewFadeOutFinished(arg_20_0)
	gohelper.setActive(arg_20_0._imagefulltop.gameObject, false)

	if arg_20_0._outCallback then
		arg_20_0._outCallback(arg_20_0._outCallbackObj)
	end
end

function var_0_0._playDarkUpFade(arg_21_0)
	gohelper.setActive(arg_21_0._goupfade, true)
	transformhelper.setLocalPosXY(arg_21_0._goupfade.transform, 0, 390)
	ZProj.TweenHelper.DOLocalMove(arg_21_0._goupfade.transform, 0, 2800, 0, 1.5, function()
		gohelper.setActive(arg_21_0._goupfade, false)
	end)
end

function var_0_0._playDarkFade(arg_23_0)
	StoryModel.instance.skipFade = false

	arg_23_0:setFullTopShow()

	arg_23_0._imagefulltop.color.a = 0
	arg_23_0._imagefulltop.color = Color.black

	ZProj.TweenHelper.DoFade(arg_23_0._imagefulltop, 0, 1, 1.5, arg_23_0._playDarkFadeFinished, arg_23_0, nil, EaseType.Linear)
end

function var_0_0._playDarkFadeFinished(arg_24_0)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshView)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshBackground)
	ZProj.TweenHelper.KillByObj(arg_24_0._imagefulltop)
	TaskDispatcher.runDelay(arg_24_0._playDarkFadeInFinished, arg_24_0, 0.5)
end

function var_0_0._playDarkFadeInFinished(arg_25_0)
	ZProj.TweenHelper.DoFade(arg_25_0._imagefulltop, 1, 0, 1.5, arg_25_0._hideImageFullTop, arg_25_0, nil, EaseType.Linear)
end

function var_0_0._hideImageFullTop(arg_26_0)
	arg_26_0._imagefulltop.color = Color.black

	gohelper.setActive(arg_26_0._imagefulltop.gameObject, false)
end

function var_0_0._playWhiteFade(arg_27_0)
	StoryModel.instance.skipFade = false

	arg_27_0:setFullTopShow()

	arg_27_0._imagefulltop.color.a = 0
	arg_27_0._imagefulltop.color = Color.white

	ZProj.TweenHelper.DoFade(arg_27_0._imagefulltop, 0, 1, 1.5, arg_27_0._playWhiteFadeFinished, arg_27_0, nil, EaseType.Linear)
end

function var_0_0._playWhiteFadeFinished(arg_28_0)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshView)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshBackground)
	ZProj.TweenHelper.KillByObj(arg_28_0._imagefulltop)
	TaskDispatcher.runDelay(arg_28_0._playDarkFadeInFinished, arg_28_0, 0.5)
end

function var_0_0._playWhiteFadeInFinished(arg_29_0)
	ZProj.TweenHelper.DoFade(arg_29_0._imagefulltop, 1, 0, 1.5, arg_29_0._hideImageFullTop, arg_29_0, nil, EaseType.Linear)
end

function var_0_0.playIrregularShakeText(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	arg_30_0._stepCo = arg_30_1

	gohelper.setActive(arg_30_0._goirregularshake, true)

	arg_30_0._shakefinishCallback = arg_30_2
	arg_30_0._shakefinishCallbackObj = arg_30_3

	if not arg_30_0._goshake then
		local var_30_0 = ViewMgr.instance:getContainer(ViewName.StoryFrontView)

		arg_30_0._goshake = var_30_0:getResInst(var_30_0:getSetting().otherRes[1], arg_30_0._goirregularshake)
	end

	local var_30_1 = gohelper.findChildText(arg_30_0._goshake, "tex_ani/#tex").gameObject

	arg_30_0._tmpMarkTopText = MonoHelper.addNoUpdateLuaComOnceToGo(var_30_1, TMPMarkTopText)

	arg_30_0._tmpMarkTopText:registerRebuildLayout(var_30_1.transform.parent)

	arg_30_0._shakeAni = arg_30_0._goshake:GetComponent(typeof(UnityEngine.Animator))

	arg_30_0._tmpMarkTopText:setData(arg_30_0._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

	local var_30_2 = arg_30_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] - 0.17

	if var_30_2 < 0.1 then
		if arg_30_0._shakefinishCallback then
			arg_30_0._shakefinishCallback(arg_30_0._shakefinishCallbackObj)

			arg_30_0._shakefinishCallback = nil
			arg_30_0._shakefinishCallbackObj = nil
		end

		return
	end

	TaskDispatcher.runDelay(arg_30_0._onShakeEnd, arg_30_0, var_30_2)
end

function var_0_0._onShakeEnd(arg_31_0)
	arg_31_0._shakeAni:Play("close", 0, 0)
	TaskDispatcher.runDelay(function()
		gohelper.setActive(arg_31_0._goirregularshake, false)

		if arg_31_0._shakefinishCallback then
			arg_31_0._shakefinishCallback(arg_31_0._shakefinishCallbackObj)

			arg_31_0._shakefinishCallback = nil
			arg_31_0._shakefinishCallbackObj = nil
		end
	end, nil, 0.17)
end

function var_0_0.wordByWord(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	arg_33_0._stepCo = arg_33_1

	gohelper.setActive(arg_33_0._txtscreentext.gameObject, true)

	arg_33_0._finishCallback = arg_33_2
	arg_33_0._finishCallbackObj = arg_33_3

	ZProj.UGUIHelper.SetColorAlpha(arg_33_0._txtscreentext, 1)

	if arg_33_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		if arg_33_0._finishCallback then
			arg_33_0._finishCallback(arg_33_0._finishCallbackObj)

			arg_33_0._finishCallback = nil
			arg_33_0._finishCallbackObj = nil
		end

		return
	end

	arg_33_0:_startWordByWord()
end

function var_0_0._startWordByWord(arg_34_0)
	arg_34_0:_killFloatTween()

	arg_34_0._txtscreentext.text = ""

	local var_34_0 = StoryTool.getTxtAlignment(arg_34_0._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

	arg_34_0._txtscreentext.alignment = var_34_0

	local var_34_1 = StoryTool.getFilterAlignTxt(arg_34_0._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

	ZProj.TweenHelper.DOText(arg_34_0._txtscreentext, var_34_1, arg_34_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], function()
		if arg_34_0._finishCallback then
			arg_34_0._finishCallback(arg_34_0._finishCallbackObj)

			arg_34_0._finishCallback = nil
			arg_34_0._finishCallbackObj = nil
		end
	end)
end

function var_0_0.lineShow(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	arg_36_0._stepCo = arg_36_2

	gohelper.setActive(arg_36_0._markScreenText.gameObject, true)

	arg_36_0._finishCallback = arg_36_3
	arg_36_0._finishCallbackObj = arg_36_4

	ZProj.UGUIHelper.SetColorAlpha(arg_36_0._markScreenText, 1)

	if arg_36_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_36_0:_lineWordShowFinished()

		if arg_36_0._finishCallback then
			arg_36_0._finishCallback(arg_36_0._finishCallbackObj)

			arg_36_0._finishCallback = nil
			arg_36_0._finishCallbackObj = nil
		end

		return
	end

	arg_36_0:_startShowLine(arg_36_1)
end

function var_0_0._startShowLine(arg_37_0, arg_37_1)
	local var_37_0 = gohelper.Type_Text

	arg_37_0._conCopyMark = nil

	if not arg_37_0._copyText then
		local var_37_1 = gohelper.cloneInPlace(arg_37_0._markScreenText.gameObject, "copytext")

		gohelper.destroyAllChildren(var_37_1)

		local var_37_2 = var_37_1:GetComponent(gohelper.Type_TextMesh)

		var_37_0 = var_37_2 and gohelper.Type_TextMesh or var_37_0
		arg_37_0._copyText = var_37_1:GetComponent(var_37_0)

		if var_37_2 then
			arg_37_0._conMark:SetMarksTop({})

			arg_37_0._txtcopymarktop = IconMgr.instance:getCommonTextMarkTop(arg_37_0._copyText.gameObject):GetComponent(gohelper.Type_TextMesh)
			arg_37_0._conCopyMark = gohelper.onceAddComponent(arg_37_0._copyText.gameObject, typeof(ZProj.TMPMark))

			arg_37_0._conCopyMark:SetMarkTopGo(arg_37_0._txtcopymarktop.gameObject)
			arg_37_0._conCopyMark:SetMarksTop({})
		end

		arg_37_0._copyCanvasGroup = gohelper.onceAddComponent(arg_37_0._copyText.gameObject, typeof(UnityEngine.CanvasGroup))
	end

	arg_37_0._copyText.alignment = StoryTool.getTxtAlignment(arg_37_0._diatxt, var_37_0)
	arg_37_0._diatxt = StoryTool.getFilterAlignTxt(arg_37_0._diatxt)
	arg_37_0._diatxt = StoryModel.instance:getStoryTxtByVoiceType(arg_37_0._diatxt, arg_37_0._stepCo.conversation.audio or 0)

	gohelper.setActive(arg_37_0._copyText.gameObject, true)

	local var_37_3 = arg_37_0:_getLineWord(arg_37_1)
	local var_37_4 = #var_37_3 == 0 and arg_37_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] or arg_37_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] / #var_37_3
	local var_37_5 = 1

	local function var_37_6(arg_38_0)
		local var_38_0 = " "
		local var_38_1 = ""
		local var_38_2 = #string.split(var_38_1, "\n")

		if var_38_2 > 1 then
			for iter_38_0 = 2, var_38_2 do
				var_38_0 = string.format("%s\n%s", var_38_0, " ")
			end
		end

		if #var_37_3 >= 1 then
			for iter_38_1 = 1, #var_37_3 do
				local var_38_3 = #string.split(var_37_3[iter_38_1], "\n") or 1

				if iter_38_1 < arg_38_0 then
					var_38_1 = string.format("%s\n%s", var_38_1, var_37_3[iter_38_1])

					for iter_38_2 = 1, var_38_3 do
						local var_38_4, var_38_5, var_38_6, var_38_7 = string.match(string.split(var_37_3[iter_38_1], "\n")[iter_38_2], "(.*)<size=(%d+)>(.*)</size>(%s*)")

						if var_38_5 and tonumber(var_38_5) then
							var_38_0 = string.format("%s\n%s", var_38_0, string.format("<size=%s> </size>", var_38_5))
						else
							var_38_0 = string.format("%s\n%s", var_38_0, " ")
						end
					end
				elseif iter_38_1 == arg_38_0 then
					for iter_38_3 = 1, var_38_3 do
						var_38_1 = string.format("%s\n%s", var_38_1, " ")
					end

					var_38_0 = string.format("%s\n%s", var_38_0, var_37_3[iter_38_1])
				else
					for iter_38_4 = 1, var_38_3 do
						var_38_1 = string.format("%s\n%s", var_38_1, " ")
						var_38_0 = string.format("%s\n%s", var_38_0, " ")
					end
				end
			end
		end

		local var_38_8 = StoryTool.getMarkTopTextList(var_38_1)
		local var_38_9 = StoryTool.filterMarkTop(var_38_1)

		arg_37_0._markScreenText.text = StoryTool.filterSpTag(var_38_9)

		TaskDispatcher.runDelay(function()
			if arg_37_0._conMark and arg_37_0._txtscreentextmesh.gameObject.activeSelf then
				arg_37_0._conMark:SetMarksTop(var_38_8)
			end
		end, nil, 0.01)

		local var_38_10 = StoryTool.getMarkTopTextList(var_38_0)
		local var_38_11 = StoryTool.filterMarkTop(var_38_0)
		local var_38_12 = StoryTool.filterSpTag(var_38_11)

		arg_37_0._copyText.text = var_38_12

		TaskDispatcher.runDelay(function()
			if arg_37_0._conCopyMark then
				arg_37_0._conCopyMark:SetMarksTop(var_38_10)
			end
		end, nil, 0.01)
		ZProj.TweenHelper.KillByObj(arg_37_0._markScreenText)
		ZProj.TweenHelper.KillByObj(arg_37_0._copyText)
		ZProj.UGUIHelper.SetColorAlpha(arg_37_0._markScreenText, 1)
		ZProj.TweenHelper.DOFadeCanvasGroup(arg_37_0._copyText.gameObject, 0, 1, var_37_4, function()
			if arg_38_0 - #var_37_3 >= 0 then
				arg_37_0:_lineWordShowFinished()
			else
				arg_38_0 = arg_38_0 + 1

				var_37_6(arg_38_0)
			end
		end, nil, nil, EaseType.Linear)
	end

	var_37_6(var_37_5)
end

function var_0_0._getLineWord(arg_42_0, arg_42_1)
	local var_42_0 = string.split(arg_42_0._diatxt, "\n")
	local var_42_1 = {}
	local var_42_2 = math.floor(#var_42_0 / arg_42_1)

	for iter_42_0 = 0, var_42_2 - 1 do
		local var_42_3 = var_42_0[iter_42_0 * arg_42_1 + 1]

		for iter_42_1 = 2, arg_42_1 do
			var_42_3 = string.format("%s\n%s", var_42_3, var_42_0[iter_42_0 * arg_42_1 + iter_42_1])
		end

		table.insert(var_42_1, var_42_3)
	end

	if var_42_2 * arg_42_1 < #var_42_0 then
		local var_42_4 = var_42_0[var_42_2 * arg_42_1 + 1]

		if #var_42_0 - var_42_2 * arg_42_1 > 1 then
			for iter_42_2 = 2, #var_42_0 - var_42_2 * arg_42_1 do
				var_42_4 = string.format("%s\n%s", var_42_4, var_42_0[arg_42_1 * var_42_2 + iter_42_2])
			end
		end

		table.insert(var_42_1, var_42_4)
	end

	return var_42_1
end

function var_0_0._lineWordShowFinished(arg_43_0)
	arg_43_0._txtscreentext.text = "\n" .. arg_43_0._diatxt

	gohelper.setActive(arg_43_0._copyText.gameObject, false)

	if arg_43_0._finishCallback then
		arg_43_0._finishCallback(arg_43_0._finishCallbackObj)

		arg_43_0._finishCallback = nil
		arg_43_0._finishCallback = nil
	end

	local var_43_0 = StoryTool.getFilterAlignTxt(arg_43_0._diatxt)
	local var_43_1 = StoryTool.getMarkTopTextList(var_43_0)
	local var_43_2 = StoryTool.filterMarkTop(var_43_0)

	arg_43_0._markScreenText.text = "\n" .. StoryTool.filterSpTag(var_43_2)

	if arg_43_0._copyText then
		arg_43_0._copyText.text = ""
	end

	TaskDispatcher.runDelay(function()
		if arg_43_0._conMark and arg_43_0._txtscreentextmesh.gameObject.activeSelf then
			arg_43_0._conMark:SetMarksTop(var_43_1)
		end

		if arg_43_0._copyText then
			gohelper.destroyAllChildren(arg_43_0._copyText.gameObject)
			gohelper.destroy(arg_43_0._copyText.gameObject)

			arg_43_0._copyText = nil
		end

		if arg_43_0._finishCallback then
			arg_43_0._finishCallback(arg_43_0._finishCallbackObj)
		end
	end, nil, 0.01)
end

function var_0_0.playFullTextFadeOut(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	local var_45_0 = arg_45_1 or 0.5

	arg_45_0._fadeOutCallback = arg_45_2
	arg_45_0._fadeOutCallbackObj = arg_45_3

	ZProj.TweenHelper.KillByObj(arg_45_0._txtscreentext)
	ZProj.TweenHelper.DoFade(arg_45_0._txtscreentext, 1, 0, var_45_0, arg_45_0._hideScreenTxt, arg_45_0, nil, EaseType.Linear)
end

function var_0_0._hideScreenTxt(arg_46_0)
	arg_46_0:_killFloatTween()
	gohelper.setActive(arg_46_0._txtscreentext.gameObject, false)

	if arg_46_0._fadeOutCallback then
		arg_46_0._fadeOutCallback(arg_46_0._fadeOutCallbackObj)

		arg_46_0._fadeOutCallback = nil
		arg_46_0._fadeOutCallbackObj = nil
	end
end

function var_0_0.playTextFadeIn(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	arg_47_0._stepCo = arg_47_1

	gohelper.setActive(arg_47_0._markScreenText.gameObject, true)

	arg_47_0._finishCallback = arg_47_2
	arg_47_0._finishCallbackObj = arg_47_3

	ZProj.TweenHelper.KillByObj(arg_47_0._markScreenText)

	if arg_47_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_47_0:_fadeFinished()
	else
		local var_47_0 = arg_47_0._markScreenText.text

		if string.match(var_47_0, "<color=#%x+>") then
			var_47_0 = string.gsub(var_47_0, "<color=#(%x%x%x%x%x%x)(%x-)>", "<color=#%100>")
		end

		local var_47_1 = StoryTool.getMarkTopTextList(var_47_0)
		local var_47_2 = StoryTool.filterMarkTop(var_47_0)

		arg_47_0._markScreenText.text = StoryTool.filterSpTag(var_47_2)

		TaskDispatcher.runDelay(function()
			if arg_47_0._conMark and var_47_1 and #var_47_1 > 0 then
				arg_47_0._conMark:SetMarksTop(var_47_1)
			end
		end, nil, 0.01)

		arg_47_0._floatTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, arg_47_0._stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], arg_47_0._fadeUpdate, arg_47_0._fadeFinished, arg_47_0, nil, EaseType.Linear)
	end
end

function var_0_0._fadeUpdate(arg_49_0, arg_49_1)
	local var_49_0 = arg_49_0._markScreenText.text
	local var_49_1 = math.ceil(255 * arg_49_1)
	local var_49_2 = string.format("%02x", var_49_1)

	if string.match(var_49_0, "<color=#%x+>") then
		local var_49_3 = string.gsub(var_49_0, "<color=#(%x%x%x%x%x%x)(%x+)>", "<color=#%1" .. var_49_2 .. ">")

		arg_49_0._markScreenText.text = var_49_3

		return
	end

	if not arg_49_0._txtCanvasGroup then
		arg_49_0._txtCanvasGroup = gohelper.onceAddComponent(arg_49_0._markScreenText, typeof(UnityEngine.CanvasGroup))
	end

	arg_49_0._txtCanvasGroup.alpha = arg_49_1
end

function var_0_0._fadeFinished(arg_50_0)
	if arg_50_0._txtCanvasGroup then
		arg_50_0._txtCanvasGroup.alpha = 1
	end

	if arg_50_0._finishCallback then
		arg_50_0._finishCallback(arg_50_0._finishCallbackObj)

		arg_50_0._finishCallback = nil
		arg_50_0._finishCallbackObj = nil
	end
end

function var_0_0._killFloatTween(arg_51_0)
	if arg_51_0._floatTweenId then
		ZProj.TweenHelper.KillById(arg_51_0._floatTweenId)

		arg_51_0._floatTweenId = nil
	end
end

function var_0_0.destroy(arg_52_0)
	arg_52_0:_removeEvent()

	arg_52_0._finishCallback = nil
	arg_52_0._finishCallbackObj = nil
	arg_52_0._outCallback = nil
	arg_52_0._outCallbackObj = nil
	arg_52_0._fadeOutCallback = nil
	arg_52_0._fadeOutCallbackObj = nil

	arg_52_0:_killFloatTween()
	TaskDispatcher.cancelTask(arg_52_0._viewFadeOutFinished, arg_52_0)
	TaskDispatcher.cancelTask(arg_52_0._startStoryViewIn, arg_52_0)
	TaskDispatcher.cancelTask(arg_52_0._viewFadeOut, arg_52_0)
	TaskDispatcher.cancelTask(arg_52_0._onShakeEnd, arg_52_0)
	ZProj.TweenHelper.KillByObj(arg_52_0._imagefulltop)
	ZProj.TweenHelper.KillByObj(arg_52_0._goupfade.transform)
end

return var_0_0
