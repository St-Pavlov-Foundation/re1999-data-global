module("modules.logic.story.view.StoryDialogItem", package.seeall)

local var_0_0 = class("StoryDialogItem")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._conGo = arg_1_1
	arg_1_0._gonexticon = gohelper.findChild(arg_1_1, "nexticon")
	arg_1_0._goconversation = gohelper.findChild(arg_1_1, "#go_conversation")
	arg_1_0._goblackbottom = gohelper.findChild(arg_1_1, "#go_conversation/blackBottom")

	if arg_1_0._goblackbottom == nil then
		arg_1_0._goblackbottom = gohelper.findChild(arg_1_1, "#go_conversation/#go_contents/content/blackBottom")
	end

	if arg_1_0._goblackbottom == nil then
		arg_1_0._goblackbottom = gohelper.findChild(arg_1_1, "#go_conversation/#go_contents/blackBottom")
	end

	arg_1_0._contentGO = gohelper.findChild(arg_1_1, "#go_conversation/#go_contents")
	arg_1_0._goline = gohelper.findChild(arg_1_0._contentGO, "content/line")

	if arg_1_0._goline == nil then
		arg_1_0._goline = gohelper.findChild(arg_1_0._contentGO, "line")
	end

	arg_1_0._norDiaGO = gohelper.findChild(arg_1_0._contentGO, "content/go_normalcontent")

	if arg_1_0._norDiaGO == nil then
		arg_1_0._norDiaGO = gohelper.findChild(arg_1_0._contentGO, "go_normalcontent")
	end

	arg_1_0._norDiaLayoutElement = gohelper.onceAddComponent(arg_1_0._norDiaGO, typeof(UnityEngine.UI.LayoutElement))
	arg_1_0._txtcontentcn = gohelper.findChildText(arg_1_0._norDiaGO, "txt_contentcn")
	arg_1_0._conMat = arg_1_0._txtcontentcn.fontSharedMaterial

	local var_1_0 = UnityEngine.Shader

	arg_1_0._LineMinYId = var_1_0.PropertyToID("_LineMinY")
	arg_1_0._LineMaxYId = var_1_0.PropertyToID("_LineMaxY")
	arg_1_0._goDot = IconMgr.instance:getCommonTextDotBottom(arg_1_0._txtcontentcn.gameObject)
	arg_1_0._dotMat = arg_1_0._goDot.transform:GetComponent(gohelper.Type_Image).material
	arg_1_0._txtmarktop = IconMgr.instance:getCommonTextMarkTop(arg_1_0._txtcontentcn.gameObject):GetComponent(gohelper.Type_TextMesh)
	arg_1_0._conMark = gohelper.onceAddComponent(arg_1_0._txtcontentcn.gameObject, typeof(ZProj.TMPMark))

	arg_1_0._conMark:SetMarkGo(arg_1_0._goDot)
	arg_1_0._conMark:SetMarkTopAlpha(0.6)
	arg_1_0._conMark:SetTopOffset(0, -2.60056)
	arg_1_0._conMark:SetMarkTopGo(arg_1_0._txtmarktop.gameObject)

	arg_1_0._magicDiaGO = gohelper.findChild(arg_1_0._contentGO, "content/go_magiccontent")

	if arg_1_0._magicDiaGO == nil then
		arg_1_0._magicDiaGO = gohelper.findChild(arg_1_0._contentGO, "go_magiccontent")
	end

	arg_1_0._txtcontentmagic = gohelper.findChildText(arg_1_0._magicDiaGO, "txt_contentmagic")
	arg_1_0._gofirework = gohelper.findChild(arg_1_0._magicDiaGO, "txt_contentmagic/go_firework")
	arg_1_0._txtcontentreshapemagic = gohelper.findChildText(arg_1_0._magicDiaGO, "txt_contentreshapemagic")
	arg_1_0._goreshapefirework = gohelper.findChild(arg_1_0._magicDiaGO, "txt_contentreshapemagic/go_reshapefirework")

	arg_1_0:_showMagicItem(false)

	arg_1_0._goslidecontent = gohelper.findChild(arg_1_1, "#go_slidecontent")
	arg_1_0._slideItem = StoryDialogSlideItem.New()

	arg_1_0._slideItem:init(arg_1_0._goslidecontent)
	arg_1_0._slideItem:hideDialog()

	local var_1_1 = ViewMgr.instance:getContainer(ViewName.StoryView).viewGO

	arg_1_0._roleAudioGo = gohelper.findChild(var_1_1, "go_roleaudio")
	arg_1_0._roleLeftAudioGo = gohelper.findChild(arg_1_0._roleAudioGo, "left")
	arg_1_0._roleMidAudioGo = gohelper.findChild(arg_1_0._roleAudioGo, "middle")
	arg_1_0._roleRightAudioGo = gohelper.findChild(arg_1_0._roleAudioGo, "right")
	arg_1_0._fontNormalMat = arg_1_0._txtcontentcn.fontSharedMaterial

	arg_1_0:_loadRes()
	arg_1_0:_addEvent()
end

function var_0_0._loadRes(arg_2_0)
	arg_2_0._magicFirePath = ResUrl.getEffect("story/story_magicfont_particle")
	arg_2_0._reshapeMagicFirePath = ResUrl.getEffect("story/story_magicfont_particle_dark")
	arg_2_0._glitchPath = ResUrl.getEffect("story/v2a6_fontglitch")
	arg_2_0._effLoader = MultiAbLoader.New()

	arg_2_0._effLoader:addPath(arg_2_0._magicFirePath)
	arg_2_0._effLoader:addPath(arg_2_0._reshapeMagicFirePath)
	arg_2_0._effLoader:addPath(arg_2_0._glitchPath)
	arg_2_0._effLoader:startLoad(arg_2_0._magicFireEffectLoaded, arg_2_0)
end

function var_0_0._magicFireEffectLoaded(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getAssetItem(arg_3_0._magicFirePath)

	arg_3_0._magicFireGo = gohelper.clone(var_3_0:GetResource(arg_3_0._magicFirePath), arg_3_0._gofirework)

	gohelper.setActive(arg_3_0._magicFireGo, false)

	arg_3_0._magicFireAnim = arg_3_0._magicFireGo:GetComponent(typeof(UnityEngine.Animator))

	local var_3_1 = arg_3_1:getAssetItem(arg_3_0._reshapeMagicFirePath)

	arg_3_0._reshapeMagicFireGo = gohelper.clone(var_3_1:GetResource(arg_3_0._reshapeMagicFirePath), arg_3_0._goreshapefirework)

	gohelper.setActive(arg_3_0._reshapeMagicFireGo, false)

	arg_3_0._reshapeMagicFireAnim = arg_3_0._reshapeMagicFireGo:GetComponent(typeof(UnityEngine.Animator))

	local var_3_2 = arg_3_1:getAssetItem(arg_3_0._glitchPath)

	arg_3_0._glitchGo = gohelper.clone(var_3_2:GetResource(arg_3_0._glitchPath), arg_3_0._norDiaGO)

	gohelper.setActive(arg_3_0._glitchGo, false)
end

function var_0_0._addEvent(arg_4_0)
	StoryController.instance:registerCallback(StoryEvent.LogSelected, arg_4_0._btnlogOnClick, arg_4_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_4_0._checkCloseView, arg_4_0)
end

function var_0_0._removeEvent(arg_5_0)
	StoryController.instance:unregisterCallback(StoryEvent.LogSelected, arg_5_0._btnlogOnClick, arg_5_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_5_0._checkCloseView, arg_5_0)
end

function var_0_0._checkCloseView(arg_6_0, arg_6_1)
	if arg_6_1 == ViewName.StoryLogView then
		arg_6_0._isLogStop = false
	end
end

function var_0_0._btnlogOnClick(arg_7_0, arg_7_1)
	arg_7_0._isLogStop = true

	if arg_7_1 == arg_7_0._conAudioId then
		return
	end

	arg_7_0._playingAudioId = 0

	if arg_7_0._conAudioId ~= 0 and arg_7_0._conAudioId then
		AudioEffectMgr.instance:stopAudio(arg_7_0._conAudioId, 0)
	end
end

function var_0_0.hideDialog(arg_8_0)
	if arg_8_0._conTweenId then
		ZProj.TweenHelper.KillById(arg_8_0._conTweenId)

		arg_8_0._conTweenId = nil
	end

	if arg_8_0._magicConTweenId then
		ZProj.TweenHelper.KillById(arg_8_0._magicConTweenId)

		arg_8_0._magicConTweenId = nil
	end

	gohelper.setActive(arg_8_0._norDiaGO, false)

	local var_8_0, var_8_1, var_8_2 = transformhelper.getLocalPos(arg_8_0._txtcontentcn.transform)

	transformhelper.setLocalPos(arg_8_0._txtcontentcn.transform, var_8_0, var_8_1, 1)

	arg_8_0._txtcontentcn.text = ""

	arg_8_0._conMark:SetMarksTop({})
	arg_8_0._conMat:DisableKeyword("_GRADUAL_ON")
	TaskDispatcher.cancelTask(arg_8_0._delayShow, arg_8_0)
	arg_8_0:_showMagicItem(false)

	arg_8_0._finishCallback = nil
	arg_8_0._finishCallbackObj = nil

	local var_8_3, var_8_4, var_8_5 = transformhelper.getLocalPos(arg_8_0._txtcontentmagic.transform)

	transformhelper.setLocalPos(arg_8_0._txtcontentmagic.transform, var_8_3, var_8_4, 1)
	transformhelper.setLocalPos(arg_8_0._txtcontentreshapemagic.transform, var_8_3, var_8_4, 1)

	arg_8_0._txtcontentmagic.text = ""
	arg_8_0._txtcontentreshapemagic.text = ""
end

function var_0_0.playDialog(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	arg_9_0._stepCo = arg_9_2

	local var_9_0 = arg_9_0._stepCo.conversation.audios[1] or 0
	local var_9_1 = StoryModel.instance:getStoryTxtByVoiceType(arg_9_1, var_9_0)

	arg_9_0:clearSlideDialog()

	if arg_9_0._stepCo.conversation.type == StoryEnum.ConversationType.SlideDialog then
		arg_9_0:playSlideDialog(var_9_1, arg_9_3, arg_9_4)

		return
	end

	arg_9_0._slideItem:hideDialog()
	gohelper.setActive(arg_9_0._goconversation, true)
	gohelper.setActive(arg_9_0._gonexticon, true)

	if arg_9_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic or arg_9_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic then
		arg_9_0:playMagicText(var_9_1, arg_9_3, arg_9_4)
	else
		arg_9_0:playNormalText(var_9_1, arg_9_3, arg_9_4)
	end
end

function var_0_0.clearSlideDialog(arg_10_0)
	if arg_10_0._slideItem then
		arg_10_0._slideItem:clearSlideDialog()
	end
end

function var_0_0.playSlideDialog(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = string.split(arg_11_1, "#")

	if #var_11_0 ~= 3 then
		logError("配置异常，请检查配置[示例：gundongzimu_1#1.0#10.0](图片名#速度#时间)")

		return
	end

	gohelper.setActive(arg_11_0._goconversation, false)
	gohelper.setActive(arg_11_0._gonexticon, false)

	local var_11_1 = {
		img = var_11_0[1],
		speed = tonumber(var_11_0[2]),
		showTime = tonumber(var_11_0[3])
	}

	arg_11_0._slideItem:startShowDialog(var_11_1, arg_11_2, arg_11_3)
end

function var_0_0.playMagicText(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	gohelper.setActive(arg_12_0._goline, true)
	arg_12_0:_showMagicItem(true)
	TaskDispatcher.cancelTask(arg_12_0._playConAudio, arg_12_0)
	gohelper.setActive(arg_12_0._norDiaGO, false)

	arg_12_0._txt = StoryTool.filterSpTag(arg_12_1)
	arg_12_0._textShowFinished = false
	arg_12_0._playingAudioId = 0
	arg_12_0._finishCallback = arg_12_2
	arg_12_0._finishCallbackObj = arg_12_3
	arg_12_0._txtcontentmagic.text = arg_12_0._txt
	arg_12_0._txtcontentreshapemagic.text = arg_12_0._txt

	local var_12_0, var_12_1, var_12_2 = transformhelper.getLocalPos(arg_12_0._txtcontentmagic.transform)

	transformhelper.setLocalPos(arg_12_0._txtcontentmagic.transform, var_12_0, var_12_1, 1)
	transformhelper.setLocalPos(arg_12_0._txtcontentreshapemagic.transform, var_12_0, var_12_1, 1)

	local var_12_3 = arg_12_0:_getMagicWordShowTime(arg_12_1)

	arg_12_0._magicConTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, var_12_3, arg_12_0._magicConUpdate, arg_12_0._onMagicTextFinished, arg_12_0, nil, EaseType.Linear)

	arg_12_0._magicFireAnim:Play("story_magicfont_particle")
	arg_12_0._reshapeMagicFireAnim:Play("story_magicfont_particle")
	gohelper.setActive(arg_12_0._magicFireGo, arg_12_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic)
	gohelper.setActive(arg_12_0._reshapeMagicFireGo, arg_12_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic)
	gohelper.setActive(arg_12_0._txtcontentmagic.gameObject, arg_12_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic)
	gohelper.setActive(arg_12_0._txtcontentreshapemagic, arg_12_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic)

	if arg_12_0._stepCo.conversation.audioDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_12_0:_playConAudio()
	else
		TaskDispatcher.runDelay(arg_12_0._playConAudio, arg_12_0, arg_12_0._stepCo.conversation.audioDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end

	if var_12_3 > 0 then
		arg_12_0._magicFireAnim.speed = 1 / var_12_3
		arg_12_0._reshapeMagicFireAnim.speed = 1 / var_12_3
	end
end

function var_0_0._getMagicWordShowTime(arg_13_0, arg_13_1)
	local var_13_0 = string.gsub(arg_13_1, "%%", "--------")
	local var_13_1 = string.gsub(var_13_0, "%&", "--------")
	local var_13_2 = LuaUtil.getCharNum(var_13_1)
	local var_13_3 = 0.1

	if var_13_2 < 30 then
		var_13_3 = 0.2
	end

	if var_13_2 < 15 then
		var_13_3 = 0.5
	end

	if var_13_1 and string.find(var_13_1, "<speed=%d[%d.]*>") then
		local var_13_4 = string.sub(var_13_1, string.find(var_13_1, "<speed=%d[%d.]*>"))

		var_13_3 = var_13_4 and tonumber(string.match(var_13_4, "%d[%d.]*")) or 1
	end

	return var_13_3 * var_13_2
end

function var_0_0._magicConUpdate(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic and recthelper.getWidth(arg_14_0._txtcontentmagic.gameObject.transform) or recthelper.getWidth(arg_14_0._txtcontentreshapemagic.gameObject.transform)

	if arg_14_1 > (var_14_0 + 100) / 2215 and var_14_0 > 1 then
		if arg_14_0._magicConTweenId then
			ZProj.TweenHelper.KillById(arg_14_0._magicConTweenId)

			arg_14_0._magicConTweenId = nil
		end

		arg_14_0:_onMagicTextFinished()

		return
	end

	local var_14_1 = 1107.5
	local var_14_2, var_14_3, var_14_4 = transformhelper.getLocalPos(arg_14_0._txtcontentmagic.transform)

	if arg_14_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic then
		local var_14_5

		var_14_2, var_14_3, var_14_5 = transformhelper.getLocalPos(arg_14_0._txtcontentreshapemagic.transform)
	end

	local var_14_6 = UnityEngine.Screen.width
	local var_14_7 = UnityEngine.Screen.height
	local var_14_8 = 0
	local var_14_9 = 1920
	local var_14_10 = transformhelper.getLocalPos(arg_14_0._contentGO.transform)
	local var_14_11 = 1920 * (1080 * var_14_6 / (1920 * var_14_7))

	if var_14_6 / var_14_7 >= 1.7777777777777777 then
		var_14_8 = 0.5 * (1080 * var_14_6 / var_14_7 - 1920) + (960 + var_14_10)
	else
		var_14_8 = 960 - 0.5 * (1920 - 1080 * var_14_6 / var_14_7) + var_14_10
	end

	local var_14_12 = (var_14_8 + arg_14_1 * (var_14_1 + 10)) / var_14_11
	local var_14_13 = arg_14_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic and recthelper.uiPosToScreenPos(arg_14_0._txtcontentmagic.gameObject.transform, ViewMgr.instance:getUICanvas()).y or recthelper.uiPosToScreenPos(arg_14_0._txtcontentreshapemagic.gameObject.transform, ViewMgr.instance:getUICanvas()).y
	local var_14_14 = arg_14_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic and recthelper.screenPosToAnchorPos(Vector2(var_14_12 * var_14_6, var_14_13), arg_14_0._gofirework.transform) or recthelper.screenPosToAnchorPos(Vector2(var_14_12 * var_14_6, var_14_13), arg_14_0._goreshapefirework.transform)

	if arg_14_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic then
		transformhelper.setLocalPos(arg_14_0._txtcontentmagic.transform, var_14_2, var_14_3, 1 - var_14_12)
		transformhelper.setLocalPos(arg_14_0._magicFireGo.transform, var_14_14.x, var_14_14.y, 0)
	else
		transformhelper.setLocalPos(arg_14_0._txtcontentreshapemagic.transform, var_14_2, var_14_3, 1 - var_14_12)
		transformhelper.setLocalPos(arg_14_0._reshapeMagicFireGo.transform, var_14_14.x, var_14_14.y, 0)
	end
end

function var_0_0._magicConFinished(arg_15_0)
	local var_15_0, var_15_1, var_15_2 = transformhelper.getLocalPos(arg_15_0._txtcontentmagic.transform)

	transformhelper.setLocalPos(arg_15_0._txtcontentmagic.transform, var_15_0, var_15_1, 0)
	transformhelper.setLocalPos(arg_15_0._txtcontentreshapemagic.transform, var_15_0, var_15_1, 0)
	gohelper.setActive(arg_15_0._magicFireGo, false)
	gohelper.setActive(arg_15_0._reshapeMagicFireGo, false)

	arg_15_0._magicFireAnim.speed = 1
	arg_15_0._reshapeMagicFireAnim.speed = 1

	if arg_15_0._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract or arg_15_0._stepCo.conversation.type == StoryEnum.ConversationType.None then
		return
	end

	if arg_15_0._finishCallback then
		arg_15_0._finishCallback(arg_15_0._finishCallbackObj)
	end
end

function var_0_0.playNormalText(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if SDKModel.instance:isDmm() and LangSettings.instance:isJp() then
		local var_16_0 = StoryController.instance._curStoryId
		local var_16_1 = StoryController.instance._curStepId

		if var_16_0 == 100601 and var_16_1 == 36 then
			arg_16_1 = "はっ！　正気の沙汰じゃない。一家そろって◯◯◯だぞ！"
		elseif var_16_0 == 100602 and var_16_1 == 30 then
			arg_16_1 = "あんたらがマヌス・ヴェンデッタの仮面を研究したおかげで、その副作用が徹底的に分かったぜ！　おかげで、ラプラスの廊下は身体のあちこちから石油を垂らす◯◯◯で埋まっちまったがな。"
		elseif var_16_0 == 100726 and var_16_1 == 32 then
			arg_16_1 = "ははは！　死ね、無様な◯◯◯どもが！！"
		end
	end

	arg_16_0._txt = arg_16_1
	arg_16_0._textShowFinished = false

	TaskDispatcher.cancelTask(arg_16_0._playConAudio, arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._waitSecondFinished, arg_16_0)

	arg_16_0._playingAudioId = 0
	arg_16_0._finishCallback = arg_16_2
	arg_16_0._finishCallbackObj = arg_16_3
	arg_16_0._markIndexs = StoryTool.getMarkTextIndexs(arg_16_0._txt)
	arg_16_0._subemtext = StoryTool.filterSpTag(arg_16_0._txt)
	arg_16_0._markTopList = StoryTool.getMarkTopTextList(arg_16_0._subemtext)
	arg_16_0._subemtext = StoryTool.filterMarkTop(arg_16_0._subemtext)
	arg_16_0._txtcontentcn.text = string.gsub(arg_16_0._subemtext, "(<sprite=%d>)", "")
	arg_16_0._txtcontentmagic.text = ""
	arg_16_0._txtcontentreshapemagic.text = ""
	arg_16_0._txtcontentTmp = arg_16_0._txtcontentcn:GetComponent(typeof(TMPro.TextMeshProUGUI))

	if arg_16_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.SoftLight then
		arg_16_0._txtcontentcn.alignment = TMPro.TextAlignmentOptions.Center

		if arg_16_0._txtcontentcn.fontSharedMaterial:IsKeywordEnabled("UNDERLAY_ON") == false then
			arg_16_0._txtcontentcn.fontSharedMaterial:EnableKeyword("UNDERLAY_ON")
			arg_16_0._txtcontentcn.fontSharedMaterial:SetFloat("_BloomFactor", 2.5)

			arg_16_0._txtcontentcn.fontSharedMaterial.renderQueue = 4995

			local var_16_2 = Color.New(0, 0, 0, 0.75)

			arg_16_0._txtcontentcn.fontSharedMaterial:SetColor("_UnderlayColor", var_16_2)
			arg_16_0._txtcontentcn.fontSharedMaterial:SetFloat("_UnderlayOffsetX", 0.143)
			arg_16_0._txtcontentcn.fontSharedMaterial:SetFloat("_UnderlayOffsetY", -0.1)
			arg_16_0._txtcontentcn.fontSharedMaterial:SetFloat("_UnderlayDilate", 0.107)
			arg_16_0._txtcontentcn.fontSharedMaterial:SetFloat("_UnderlaySoftness", 0.447)

			arg_16_0._txtcontentcn.fontSharedMaterial = arg_16_0._txtcontentcn.fontMaterial
		end

		StoryTool.enablePostProcess(true)
		PostProcessingMgr.instance:setUIPPValue("localBloomActive", true)
		PostProcessingMgr.instance:setUIPPValue("bloomDiffusion", 5)
		gohelper.setActive(arg_16_0._goline, false)
		gohelper.setActive(arg_16_0._goblackbottom, false)
		gohelper.setActive(arg_16_0._gonexticon, false)

		arg_16_0._norDiaLayoutElement.ignoreLayout = true
		arg_16_0._norDiaLayoutElement.transform.anchorMax = Vector2.New(0, 0)
		arg_16_0._norDiaLayoutElement.transform.anchorMin = Vector2.New(0, 0)

		recthelper.setHeight(arg_16_0._norDiaGO.transform, 0)

		if BootNativeUtil.isIOS() then
			transformhelper.setLocalPosXY(arg_16_0._norDiaGO.transform, -351, 120)
			recthelper.setWidth(arg_16_0._norDiaGO.transform, 1800)
			recthelper.setWidth(arg_16_0._txtcontentcn.transform, 1800)

			arg_16_0._txtcontentTmp.enableAutoSizing = true
			arg_16_0._txtcontentTmp.fontSizeMax = 32
			arg_16_0._txtcontentTmp.fontSizeMin = 10
		else
			transformhelper.setLocalPosXY(arg_16_0._norDiaGO.transform, -351, 100)
			recthelper.setWidth(arg_16_0._norDiaGO.transform, 1800)
			recthelper.setWidth(arg_16_0._txtcontentcn.transform, 1800)

			arg_16_0._txtcontentTmp.enableAutoSizing = false
		end
	else
		arg_16_0._txtcontentcn.fontSharedMaterial:DisableKeyword("UNDERLAY_ON")

		arg_16_0._txtcontentcn.alignment = TMPro.TextAlignmentOptions.TopLeft
		arg_16_0._txtcontentcn.fontSharedMaterial = arg_16_0._fontNormalMat

		arg_16_0._txtcontentcn.fontSharedMaterial:SetFloat("_BloomFactor", 0)
		PostProcessingMgr.instance:setUIPPValue("localBloomActive", false)
		PostProcessingMgr.instance:setUIPPValue("bloomDiffusion", 7)

		local var_16_3 = arg_16_0._stepCo.conversation.type ~= StoryEnum.ConversationType.IrregularShake

		gohelper.setActive(arg_16_0._goline, var_16_3)
		gohelper.setActive(arg_16_0._goblackbottom, var_16_3)
		gohelper.setActive(arg_16_0._gonexticon, var_16_3)

		arg_16_0._norDiaLayoutElement.ignoreLayout = false

		transformhelper.setLocalPosXY(arg_16_0._norDiaGO.transform, 550, 0)
		recthelper.setWidth(arg_16_0._norDiaGO.transform, 1200)
		recthelper.setWidth(arg_16_0._txtcontentcn.transform, 1200)

		arg_16_0._txtcontentTmp.enableAutoSizing = false
	end

	arg_16_0._dialogTextShowFinishedCallback = nil
	arg_16_0._dialogTextShowFinishedCallbackObj = nil

	local var_16_4 = string.match(arg_16_0._txt, "<glitch>")

	if arg_16_0._glitchGo then
		gohelper.setActive(arg_16_0._glitchGo, var_16_4)
	end

	if var_16_4 then
		arg_16_0._glitchTxt = string.gsub(arg_16_0._txt, "<glitch>", "<i><b>")
		arg_16_0._glitchTxt = string.gsub(arg_16_0._glitchTxt, "</glitch>", "</i></b>")
		arg_16_0._dialogTextShowFinishedCallback = arg_16_0._onDialogTextShowFinished
		arg_16_0._dialogTextShowFinishedCallbackObj = arg_16_0

		if GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.EN then
			arg_16_0._subemtext = string.gsub(arg_16_0._subemtext, "<glitch>", "")
			arg_16_0._subemtext = string.gsub(arg_16_0._subemtext, "</glitch>", "")
		else
			arg_16_0._subemtext = string.gsub(arg_16_0._subemtext, "<glitch>", "<i><b>")
			arg_16_0._subemtext = string.gsub(arg_16_0._subemtext, "</glitch>", "</i></b>")
		end
	end

	if arg_16_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Hard then
		arg_16_0:_playHardIn()
	else
		arg_16_0:_playGradualIn()
	end
end

function var_0_0._onDialogTextShowFinished(arg_17_0)
	local var_17_0 = string.match(arg_17_0._txt, "<glitch>")

	gohelper.setActive(arg_17_0._glitchGo, var_17_0)

	if var_17_0 then
		arg_17_0:_checkPlayGlitch(arg_17_0._glitchTxt)
	end
end

function var_0_0._checkPlayGlitch(arg_18_0, arg_18_1)
	StoryTool.enablePostProcess(true)

	local var_18_0 = arg_18_1

	if GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.EN then
		var_18_0 = string.gsub(var_18_0, "<i><b>", "")
		var_18_0 = string.gsub(var_18_0, "</i></b>", "")
	end

	local var_18_1 = arg_18_0._txtcontentcn:GetTextInfo(var_18_0)
	local var_18_2 = {}

	for iter_18_0 = 1, 4 do
		local var_18_3 = gohelper.findChild(arg_18_0._glitchGo, "part_" .. tostring(iter_18_0)):GetComponent(typeof(UnityEngine.ParticleSystem))

		table.insert(var_18_2, var_18_3)
		gohelper.setActive(var_18_3.gameObject, false)
	end

	local var_18_4 = CameraMgr.instance:getUICamera()
	local var_18_5 = var_18_1.characterInfo
	local var_18_6 = recthelper.getWidth(arg_18_0._txtcontentcn.transform) + 121.8684
	local var_18_7 = {}
	local var_18_8 = string.split(arg_18_1, "\n")

	if #var_18_8 > 1 then
		for iter_18_1 = 1, #var_18_8 do
			local var_18_9 = var_18_8[iter_18_1]
			local var_18_10 = string.find(var_18_9, "<i><b>")
			local var_18_11 = {}

			if not var_18_10 then
				var_18_11.hasGlitch = false
				var_18_11.startIndex = 0
				var_18_11.endIndex = 0
				var_18_11.lineTxt = var_18_9

				table.insert(var_18_7, var_18_11)
			else
				local var_18_12 = string.find(var_18_9, "<i><b>")
				local var_18_13 = string.sub(var_18_9, 1, var_18_12 - 1)
				local var_18_14 = string.gsub(var_18_9, "<i><b>", "")
				local var_18_15 = string.find(var_18_14, "</i></b>")
				local var_18_16 = string.sub(var_18_14, 1, var_18_15 - 1)
				local var_18_17 = string.gsub(var_18_14, "</i></b>", "")

				var_18_11.hasGlitch = true
				var_18_11.startIndex = utf8.len(var_18_13)
				var_18_11.endIndex = utf8.len(var_18_16)
				var_18_11.lineTxt = var_18_17

				table.insert(var_18_7, var_18_11)
			end
		end
	else
		for iter_18_2 = 1, var_18_1.lineCount do
			local var_18_18 = var_18_1.lineInfo[iter_18_2 - 1]
			local var_18_19 = LuaUtil.subString(arg_18_1, var_18_18.firstCharacterIndex + 1, var_18_18.firstCharacterIndex + var_18_18.characterCount)
			local var_18_20 = string.find(var_18_19, "<i><b>")

			if var_18_20 then
				var_18_19 = LuaUtil.subString(arg_18_1, var_18_18.firstCharacterIndex + 1, var_18_18.firstCharacterIndex + var_18_18.characterCount + string.len("<i><b>") + string.len("</i></b>"))
			end

			local var_18_21 = {}

			if not var_18_20 then
				var_18_21.hasGlitch = false
				var_18_21.startIndex = 0
				var_18_21.endIndex = 0
				var_18_21.lineText = var_18_19

				table.insert(var_18_7, var_18_21)
			else
				local var_18_22 = string.find(var_18_19, "<i><b>")
				local var_18_23 = string.sub(var_18_19, 1, var_18_22 - 1)
				local var_18_24 = string.gsub(var_18_19, "<i><b>", "")
				local var_18_25 = string.find(var_18_24, "</i></b>")
				local var_18_26 = string.sub(var_18_24, 1, var_18_25 - 1)
				local var_18_27 = string.gsub(var_18_24, "</i></b>", "")

				var_18_21.hasGlitch = true
				var_18_21.startIndex = utf8.len(var_18_23)
				var_18_21.endIndex = utf8.len(var_18_26)
				var_18_21.lineTxt = var_18_27

				table.insert(var_18_7, var_18_21)
			end
		end
	end

	for iter_18_3 = 1, #var_18_7 do
		local var_18_28, var_18_29, var_18_30 = transformhelper.getLocalPos(var_18_2[iter_18_3].transform)

		if not var_18_7[iter_18_3].hasGlitch then
			gohelper.setActive(var_18_2[iter_18_3].gameObject, false)
		else
			gohelper.setActive(var_18_2[iter_18_3].gameObject, true)

			local var_18_31 = var_18_5[0]
			local var_18_32 = var_18_1.lineInfo[iter_18_3 - 1]
			local var_18_33 = var_18_5[var_18_32.firstCharacterIndex + var_18_7[iter_18_3].startIndex]
			local var_18_34 = var_18_5[var_18_32.firstCharacterIndex + var_18_7[iter_18_3].endIndex - 1]
			local var_18_35 = var_18_4:WorldToScreenPoint(arg_18_0._txtcontentcn.transform:TransformPoint(var_18_31.bottomLeft))
			local var_18_36 = var_18_4:WorldToScreenPoint(arg_18_0._txtcontentcn.transform:TransformPoint(var_18_33.bottomLeft))
			local var_18_37 = var_18_4:WorldToScreenPoint(arg_18_0._txtcontentcn.transform:TransformPoint(var_18_34.bottomRight))
			local var_18_38 = UnityEngine.Screen.width
			local var_18_39 = UnityEngine.Screen.height
			local var_18_40 = math.min(1, 0.9 * var_18_38 / (1.6 * var_18_39))
			local var_18_41 = 1080 * (var_18_36.x - var_18_35.x) / (var_18_39 * var_18_40)
			local var_18_42 = 1144.8 * (var_18_37.x - var_18_36.x) / (var_18_39 * var_18_40)
			local var_18_43 = var_18_41 / var_18_6
			local var_18_44 = var_18_42 / var_18_6
			local var_18_45 = 647 * (2 * var_18_43 + var_18_44)
			local var_18_46, var_18_47, var_18_48 = transformhelper.getLocalPos(var_18_2[iter_18_3].transform)

			transformhelper.setLocalPos(var_18_2[iter_18_3].transform, var_18_45, var_18_47, var_18_48)

			local var_18_49 = 12 * var_18_44 * var_18_40
			local var_18_50 = 0.4 * var_18_40

			var_18_2[iter_18_3].shape.scale = Vector3(var_18_49, var_18_50, 0)

			ZProj.ParticleSystemHelper.SetMaxParticles(var_18_2[iter_18_3], math.floor(30 * var_18_44))
		end
	end
end

function var_0_0._playHardIn(arg_19_0)
	arg_19_0:_showMagicItem(false)
	gohelper.setActive(arg_19_0._norDiaGO, true)
	arg_19_0:conFinished()
end

function var_0_0._playGradualIn(arg_20_0)
	arg_20_0:_showMagicItem(false)
	gohelper.setActive(arg_20_0._norDiaGO, true)

	local var_20_0 = UnityEngine.Screen.height

	arg_20_0._conMat:SetFloat(arg_20_0._LineMinYId, var_20_0)
	arg_20_0._conMat:SetFloat(arg_20_0._LineMaxYId, var_20_0)
	arg_20_0._conMat:EnableKeyword("_GRADUAL_ON")
	arg_20_0._conMat:DisableKeyword("_DISSOLVE_ON")

	local var_20_1, var_20_2, var_20_3 = transformhelper.getLocalPos(arg_20_0._txtcontentcn.transform)

	transformhelper.setLocalPos(arg_20_0._txtcontentcn.transform, var_20_1, var_20_2, 1)
	TaskDispatcher.cancelTask(arg_20_0._delayShow, arg_20_0)
	TaskDispatcher.runDelay(arg_20_0._delayShow, arg_20_0, 0.05)
end

function var_0_0._showMagicItem(arg_21_0, arg_21_1)
	if arg_21_1 then
		if arg_21_0._magicFireGo then
			StoryTool.enablePostProcess(true)
			gohelper.setActive(arg_21_0._reshapeMagicFireGo, arg_21_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic)
		end

		if arg_21_0._reshapeMagicFireGo then
			StoryTool.enablePostProcess(true)
			gohelper.setActive(arg_21_0._reshapeMagicFireGo, arg_21_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic)
		end
	else
		arg_21_0._txtcontentmagic.text = ""
		arg_21_0._txtcontentreshapemagic.text = ""

		gohelper.setActive(arg_21_0._magicFireGo, false)
		gohelper.setActive(arg_21_0._reshapeMagicFireGo, false)
	end
end

function var_0_0._delayShow(arg_22_0)
	local var_22_0 = UnityEngine.Screen.height

	arg_22_0._dotMat:SetFloat(arg_22_0._LineMinYId, var_22_0)
	arg_22_0._dotMat:SetFloat(arg_22_0._LineMaxYId, var_22_0)

	if arg_22_0._stepCo.conversation.type ~= StoryEnum.ConversationType.ScreenDialog then
		arg_22_0._conMark:SetMarksTop(arg_22_0._markTopList)
	end

	arg_22_0._textInfo = arg_22_0._txtcontentcn:GetTextInfo(arg_22_0._subemtext)
	arg_22_0._lineInfoList = {}

	local var_22_1 = 0

	for iter_22_0 = 1, arg_22_0._textInfo.lineCount do
		local var_22_2 = arg_22_0._textInfo.lineInfo[iter_22_0 - 1]
		local var_22_3 = var_22_1 + 1

		var_22_1 = var_22_1 + var_22_2.visibleCharacterCount

		table.insert(arg_22_0._lineInfoList, {
			var_22_2,
			var_22_3,
			var_22_1
		})
	end

	arg_22_0._contentX, arg_22_0._contentY, _ = transformhelper.getLocalPos(arg_22_0._txtcontentcn.transform)
	arg_22_0._curLine = nil

	local var_22_4 = arg_22_0:_getDelayTime(var_22_1)

	if GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LangSettings.en then
		var_22_4 = var_22_4 * 0.67
	end

	if arg_22_0._conTweenId then
		ZProj.TweenHelper.KillById(arg_22_0._conTweenId)

		arg_22_0._conTweenId = nil
	end

	if arg_22_0._stepCo.conversation.audioDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_22_0:_playConAudio()
	else
		TaskDispatcher.runDelay(arg_22_0._playConAudio, arg_22_0, arg_22_0._stepCo.conversation.audioDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end

	arg_22_0._lastBottomLeft = 0
	arg_22_0._lineSpace = 0
	arg_22_0._hasUnderline = string.find(arg_22_0._subemtext, "<u>") and string.find(arg_22_0._subemtext, "</u>")
	arg_22_0._conTweenId = ZProj.TweenHelper.DOTweenFloat(1, var_22_1, var_22_4, arg_22_0._conUpdate, arg_22_0._onTextFinished, arg_22_0, nil, EaseType.Linear)
end

function var_0_0._getDelayTime(arg_23_0, arg_23_1)
	local var_23_0 = 1

	if arg_23_0._txt and string.find(arg_23_0._txt, "<speed=%d[%d.]*>") then
		local var_23_1 = string.sub(arg_23_0._txt, string.find(arg_23_0._txt, "<speed=%d[%d.]*>"))

		var_23_0 = var_23_1 and tonumber(string.match(var_23_1, "%d[%d.]*")) or 1
	end

	local var_23_2 = 0.08 * arg_23_1

	if GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.EN then
		var_23_2 = var_23_2 * 0.67
	end

	return var_23_2 / var_23_0
end

function var_0_0._playConAudio(arg_24_0)
	if arg_24_0._isLogStop then
		return
	end

	arg_24_0:stopConAudio()

	if StoryModel.instance:isSpecialVideoPlaying() then
		return
	end

	arg_24_0._conAudioId = arg_24_0._stepCo.conversation.audios[1] or 0

	if arg_24_0._conAudioId ~= 0 then
		local var_24_0 = {}

		var_24_0.loopNum = 1
		var_24_0.fadeInTime = 0
		var_24_0.fadeOutTime = 0
		var_24_0.volume = 100
		var_24_0.audioGo = arg_24_0:_getDialogGo()
		var_24_0.callback = arg_24_0._onConAudioFinished
		var_24_0.callbackTarget = arg_24_0
		arg_24_0._playingAudioId = arg_24_0._conAudioId

		AudioEffectMgr.instance:playAudio(arg_24_0._conAudioId, var_24_0)
	else
		arg_24_0._playingAudioId = 0
	end

	arg_24_0._hasLowPassAudio = false

	if #arg_24_0._stepCo.conversation.audios > 1 then
		for iter_24_0, iter_24_1 in pairs(arg_24_0._stepCo.conversation.audios) do
			if iter_24_1 == AudioEnum.Story.Play_Lowpass then
				arg_24_0._hasLowPassAudio = true

				AudioMgr.instance:trigger(AudioEnum.Story.Play_Lowpass)

				return
			end
		end
	end
end

function var_0_0._getDialogGo(arg_25_0)
	local var_25_0 = arg_25_0._roleMidAudioGo

	if #arg_25_0._stepCo.heroList > 0 and arg_25_0._stepCo.conversation.showList[1] then
		if not arg_25_0._stepCo.heroList[arg_25_0._stepCo.conversation.showList[1] + 1] then
			return var_25_0
		end

		local var_25_1 = arg_25_0._stepCo.heroList[arg_25_0._stepCo.conversation.showList[1] + 1].heroDir

		if var_25_1 and var_25_1 == 0 then
			var_25_0 = arg_25_0._roleLeftAudioGo
		end

		if var_25_1 and var_25_1 == 2 then
			var_25_0 = arg_25_0._roleRightAudioGo
		end
	end

	return var_25_0
end

function var_0_0._onTextFinished(arg_26_0)
	TaskDispatcher.cancelTask(arg_26_0._delayShow, arg_26_0)

	if arg_26_0._dialogTextShowFinishedCallback then
		arg_26_0._dialogTextShowFinishedCallback(arg_26_0._dialogTextShowFinishedCallbackObj)

		arg_26_0._dialogTextShowFinishedCallback = nil
		arg_26_0._dialogTextShowFinishedCallbackObj = nil
	end

	if arg_26_0._magicConTweenId then
		ZProj.TweenHelper.KillById(arg_26_0._magicConTweenId)
		gohelper.setActive(arg_26_0._magicFireGo, false)
		gohelper.setActive(arg_26_0._reshapeMagicFireGo, false)

		arg_26_0._magicFireAnim.speed = 1
		arg_26_0._reshapeMagicFireAnim.speed = 1
		arg_26_0._magicConTweenId = nil
	end

	if arg_26_0._conTweenId then
		ZProj.TweenHelper.KillById(arg_26_0._conTweenId)

		arg_26_0._conTweenId = nil
	end

	local var_26_0, var_26_1, var_26_2 = transformhelper.getLocalPos(arg_26_0._txtcontentcn.transform)

	transformhelper.setLocalPos(arg_26_0._txtcontentcn.transform, var_26_0, var_26_1, 0)

	local var_26_3, var_26_4, var_26_5 = transformhelper.getLocalPos(arg_26_0._txtcontentmagic.transform)

	transformhelper.setLocalPos(arg_26_0._txtcontentmagic.transform, var_26_3, var_26_4, 0)
	transformhelper.setLocalPos(arg_26_0._txtcontentreshapemagic.transform, var_26_3, var_26_4, 0)
	arg_26_0._conMat:DisableKeyword("_GRADUAL_ON")
	arg_26_0._conMat:SetFloat(arg_26_0._LineMinYId, 0)
	arg_26_0._conMat:SetFloat(arg_26_0._LineMaxYId, 0)

	arg_26_0._subMeshs = {}

	local var_26_6 = arg_26_0._txtcontentcn.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

	if var_26_6 then
		local var_26_7 = var_26_6:GetEnumerator()

		while var_26_7:MoveNext() do
			local var_26_8 = var_26_7.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI))

			table.insert(arg_26_0._subMeshs, var_26_8)
		end
	end

	for iter_26_0, iter_26_1 in pairs(arg_26_0._subMeshs) do
		if iter_26_1.sharedMaterial then
			iter_26_1.sharedMaterial = arg_26_0._fontNormalMat

			iter_26_1.sharedMaterial:DisableKeyword("_GRADUAL_ON")
		end
	end

	arg_26_0._textShowFinished = true

	local var_26_9 = StoryModel.instance:isStoryAuto()

	if arg_26_0._stepCo.conversation.type ~= StoryEnum.ConversationType.NoInteract and arg_26_0._stepCo.conversation.type ~= StoryEnum.ConversationType.None then
		var_26_9 = var_26_9 or arg_26_0._stepCo.conversation.isAuto
	end

	if not var_26_9 or arg_26_0._playingAudioId == 0 then
		arg_26_0:conFinished()
	end
end

function var_0_0._onMagicTextFinished(arg_27_0)
	arg_27_0._textShowFinished = true

	arg_27_0:_magicConFinished()
end

function var_0_0._onConAudioFinished(arg_28_0, arg_28_1)
	if arg_28_0._textShowFinished then
		if arg_28_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic or arg_28_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic then
			arg_28_0:_magicConFinished()
		else
			arg_28_0:conFinished()
		end
	end

	if arg_28_0._playingAudioId == arg_28_1 then
		arg_28_0._playingAudioId = 0
	end
end

function var_0_0.stopConAudio(arg_29_0)
	if arg_29_0._hasLowPassAudio then
		AudioMgr.instance:trigger(AudioEnum.Story.Stop_Lowpass)
	end

	if arg_29_0._isLogStop then
		return
	end

	arg_29_0._playingAudioId = 0

	if arg_29_0._conAudioId ~= 0 and arg_29_0._conAudioId then
		AudioEffectMgr.instance:stopAudio(arg_29_0._conAudioId, 0)
	end
end

function var_0_0._conUpdate(arg_30_0, arg_30_1)
	local var_30_0 = UnityEngine.Screen.width
	local var_30_1 = arg_30_0._txtcontentcn.transform
	local var_30_2 = CameraMgr.instance:getUICamera()

	arg_30_0._subMeshs = {}

	local var_30_3 = arg_30_0._txtcontentcn.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

	if var_30_3 then
		local var_30_4 = var_30_3:GetEnumerator()

		while var_30_4:MoveNext() do
			local var_30_5 = var_30_4.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI))

			table.insert(arg_30_0._subMeshs, var_30_5)
		end
	end

	for iter_30_0, iter_30_1 in ipairs(arg_30_0._lineInfoList) do
		local var_30_6 = iter_30_1[1]
		local var_30_7 = iter_30_1[2]
		local var_30_8 = iter_30_1[3]

		if var_30_7 <= arg_30_1 and arg_30_1 <= var_30_8 then
			local var_30_9 = arg_30_0._textInfo.characterInfo
			local var_30_10 = var_30_9[var_30_6.firstVisibleCharacterIndex]
			local var_30_11 = var_30_9[var_30_6.lastVisibleCharacterIndex]
			local var_30_12 = var_30_2:WorldToScreenPoint(var_30_1:TransformPoint(var_30_10.bottomLeft))
			local var_30_13 = var_30_12
			local var_30_14 = var_30_12.y

			for iter_30_2 = var_30_6.firstVisibleCharacterIndex, var_30_6.lastVisibleCharacterIndex do
				local var_30_15 = var_30_9[iter_30_2]
				local var_30_16 = var_30_2:WorldToScreenPoint(var_30_1:TransformPoint(var_30_15.bottomLeft))

				if var_30_14 > var_30_16.y then
					var_30_14 = var_30_16.y
				end
			end

			var_30_13.y = var_30_14

			local var_30_17 = var_30_2:WorldToScreenPoint(var_30_1:TransformPoint(var_30_10.topLeft))
			local var_30_18 = var_30_17
			local var_30_19 = var_30_17.y

			for iter_30_3 = var_30_6.firstVisibleCharacterIndex, var_30_6.lastVisibleCharacterIndex do
				local var_30_20 = var_30_9[iter_30_3]
				local var_30_21 = var_30_2:WorldToScreenPoint(var_30_1:TransformPoint(var_30_20.topLeft))

				if var_30_19 < var_30_21.y then
					var_30_19 = var_30_21.y
				end
			end

			var_30_18.y = var_30_19

			local var_30_22 = var_30_2:WorldToScreenPoint(var_30_1:TransformPoint(var_30_11.bottomRight))

			for iter_30_4, iter_30_5 in pairs(arg_30_0._subMeshs) do
				if iter_30_5.sharedMaterial then
					if arg_30_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.SoftLight then
						break
					end

					iter_30_5.sharedMaterial = arg_30_0._fontNormalMat
				end
			end

			if iter_30_0 == 1 then
				if arg_30_0._hasUnderline then
					arg_30_0._conMat:SetFloat(arg_30_0._LineMinYId, var_30_13.y - 4)
				else
					arg_30_0._conMat:SetFloat(arg_30_0._LineMinYId, var_30_13.y)
				end

				arg_30_0._conMat:SetFloat(arg_30_0._LineMaxYId, var_30_18.y + 20)
				arg_30_0._dotMat:SetFloat(arg_30_0._LineMinYId, var_30_13.y - 10)
				arg_30_0._dotMat:SetFloat(arg_30_0._LineMaxYId, var_30_18.y)
			else
				arg_30_0._lineSpace = arg_30_0._lastBottomLeft - var_30_18.y > 0 and arg_30_0._lastBottomLeft - var_30_18.y or arg_30_0._lineSpace

				arg_30_0._conMat:SetFloat(arg_30_0._LineMinYId, var_30_13.y)
				arg_30_0._conMat:SetFloat(arg_30_0._LineMaxYId, var_30_18.y + arg_30_0._lineSpace)
				arg_30_0._dotMat:SetFloat(arg_30_0._LineMinYId, var_30_13.y - 10)
				arg_30_0._dotMat:SetFloat(arg_30_0._LineMaxYId, var_30_18.y)
			end

			arg_30_0._lastBottomLeft = var_30_13.y

			local var_30_23 = arg_30_0._txtcontentcn.gameObject

			gohelper.setActive(var_30_23, false)
			gohelper.setActive(var_30_23, true)

			local var_30_24 = var_30_7 == var_30_8 and 1 or (arg_30_1 - var_30_7) / (var_30_8 - var_30_7)
			local var_30_25 = Mathf.Lerp(var_30_13.x - 10, var_30_22.x + 10, var_30_24)
			local var_30_26 = arg_30_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.SoftLight and 0 or 1 - var_30_25 / var_30_0

			transformhelper.setLocalPos(arg_30_0._txtcontentcn.transform, arg_30_0._contentX, arg_30_0._contentY, var_30_26)

			if arg_30_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.SoftLight then
				arg_30_0._conMat:SetFloat(arg_30_0._LineMinYId, 0)
				arg_30_0._conMat:SetFloat(arg_30_0._LineMaxYId, 0)

				if #arg_30_0._lineInfoList > 1 then
					if BootNativeUtil.isIOS() then
						transformhelper.setLocalPosXY(arg_30_0._norDiaGO.transform, -351, 120 + 50 * (#arg_30_0._lineInfoList - 2))
					else
						transformhelper.setLocalPosXY(arg_30_0._norDiaGO.transform, -351, 100 + 50 * (#arg_30_0._lineInfoList - 2))
					end
				end
			end
		end
	end
end

function var_0_0.conFinished(arg_31_0)
	arg_31_0._textShowFinished = true

	if arg_31_0._dialogTextShowFinishedCallback then
		arg_31_0._dialogTextShowFinishedCallback(arg_31_0._dialogTextShowFinishedCallbackObj)

		arg_31_0._dialogTextShowFinishedCallback = nil
		arg_31_0._dialogTextShowFinishedCallbackObj = nil
	end

	if arg_31_0._stepCo and (arg_31_0._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract or arg_31_0._stepCo.conversation.type == StoryEnum.ConversationType.None) then
		return
	end

	if arg_31_0._magicConTweenId then
		ZProj.TweenHelper.KillById(arg_31_0._magicConTweenId)
		gohelper.setActive(arg_31_0._magicFireGo, false)
		gohelper.setActive(arg_31_0._reshapeMagicFireGo, false)

		arg_31_0._magicFireAnim.speed = 1
		arg_31_0._reshapeMagicFireAnim.speed = 1
		arg_31_0._magicConTweenId = nil
	end

	if arg_31_0._conTweenId then
		ZProj.TweenHelper.KillById(arg_31_0._conTweenId)

		arg_31_0._conTweenId = nil
	end

	arg_31_0._conMat:SetFloat(arg_31_0._LineMinYId, 0)
	arg_31_0._conMat:SetFloat(arg_31_0._LineMaxYId, 0)

	local var_31_0, var_31_1, var_31_2 = transformhelper.getLocalPos(arg_31_0._txtcontentcn.transform)

	transformhelper.setLocalPos(arg_31_0._txtcontentcn.transform, var_31_0, var_31_1, 0)

	local var_31_3, var_31_4, var_31_5 = transformhelper.getLocalPos(arg_31_0._txtcontentmagic.transform)

	transformhelper.setLocalPos(arg_31_0._txtcontentmagic.transform, var_31_3, var_31_4, 0)

	arg_31_0._subMeshs = {}

	local var_31_6 = arg_31_0._txtcontentcn.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

	if var_31_6 then
		local var_31_7 = var_31_6:GetEnumerator()

		while var_31_7:MoveNext() do
			local var_31_8 = var_31_7.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI))

			table.insert(arg_31_0._subMeshs, var_31_8)
		end
	end

	for iter_31_0, iter_31_1 in pairs(arg_31_0._subMeshs) do
		if iter_31_1.sharedMaterial then
			iter_31_1.sharedMaterial:DisableKeyword("_GRADUAL_ON")
		end
	end

	transformhelper.setLocalPos(arg_31_0._txtcontentreshapemagic.transform, var_31_3, var_31_4, 0)
	arg_31_0._conMat:DisableKeyword("_GRADUAL_ON")

	if arg_31_0._finishCallback then
		arg_31_0._finishCallback(arg_31_0._finishCallbackObj)
	end
end

function var_0_0.playNorDialogFadeIn(arg_32_0, arg_32_1, arg_32_2)
	ZProj.TweenHelper.DoFade(arg_32_0._txtcontentcn, 0, 1, 2, function()
		if arg_32_1 then
			arg_32_1(arg_32_2)
		end
	end, nil, nil, EaseType.Linear)
end

function var_0_0.playWordByWord(arg_34_0, arg_34_1, arg_34_2)
	arg_34_0._txtcontentcn.text = ""

	ZProj.TweenHelper.DOText(arg_34_0._txtcontentcn, arg_34_0._diatxt, 2, function()
		if arg_34_1 then
			arg_34_1(arg_34_2)
		end
	end)
end

function var_0_0.startAutoEnterNext(arg_36_0)
	if arg_36_0._playingAudioId == 0 and arg_36_0._textShowFinished then
		if arg_36_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic or arg_36_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic then
			arg_36_0:_magicConFinished()
		else
			arg_36_0:conFinished()
		end
	end
end

function var_0_0.checkAutoEnterNext(arg_37_0, arg_37_1, arg_37_2)
	arg_37_0._diaFinishedCallback = arg_37_1
	arg_37_0._diaFinishedCallbackObj = arg_37_2

	TaskDispatcher.cancelTask(arg_37_0._onSecond, arg_37_0)
	TaskDispatcher.cancelTask(arg_37_0._waitSecondFinished, arg_37_0)
	TaskDispatcher.runRepeat(arg_37_0._onSecond, arg_37_0, 0.1)
end

function var_0_0._onSecond(arg_38_0)
	if arg_38_0._playingAudioId == 0 and arg_38_0._textShowFinished then
		TaskDispatcher.cancelTask(arg_38_0._onSecond, arg_38_0)
		TaskDispatcher.cancelTask(arg_38_0._waitSecondFinished, arg_38_0)
		TaskDispatcher.runDelay(arg_38_0._waitSecondFinished, arg_38_0, 2)
	end
end

function var_0_0.isAudioPlaying(arg_39_0)
	return arg_39_0._playingAudioId ~= 0
end

function var_0_0._waitSecondFinished(arg_40_0)
	if arg_40_0._diaFinishedCallback then
		arg_40_0._diaFinishedCallback(arg_40_0._diaFinishedCallbackObj)
	end
end

function var_0_0.storyFinished(arg_41_0)
	arg_41_0._finishCallback = nil
	arg_41_0._finishCallbackObj = nil
end

function var_0_0.destroy(arg_42_0)
	arg_42_0._txtcontentcn.fontSharedMaterial = arg_42_0._fontNormalMat

	arg_42_0:_removeEvent()
	TaskDispatcher.cancelTask(arg_42_0._playConAudio, arg_42_0)
	TaskDispatcher.cancelTask(arg_42_0._onSecond, arg_42_0)
	TaskDispatcher.cancelTask(arg_42_0._waitSecondFinished, arg_42_0)
	arg_42_0:stopConAudio()

	if arg_42_0._slideItem then
		arg_42_0._slideItem:destroy()

		arg_42_0._slideItem = nil
	end

	if arg_42_0._conTweenId then
		ZProj.TweenHelper.KillById(arg_42_0._conTweenId)

		arg_42_0._conTweenId = nil
	end

	if arg_42_0._magicConTweenId then
		ZProj.TweenHelper.KillById(arg_42_0._magicConTweenId)

		arg_42_0._magicConTweenId = nil
	end

	if arg_42_0._effLoader then
		arg_42_0._effLoader:dispose()

		arg_42_0._effLoader = nil
	end

	TaskDispatcher.cancelTask(arg_42_0._delayShow, arg_42_0)

	arg_42_0._finishCallback = nil
	arg_42_0._finishCallbackObj = nil

	arg_42_0._conMat:DisableKeyword("_GRADUAL_ON")
	arg_42_0:_removeEvent()

	if arg_42_0._matLoader then
		arg_42_0._matLoader:dispose()

		arg_42_0._matLoader = nil
	end
end

return var_0_0
