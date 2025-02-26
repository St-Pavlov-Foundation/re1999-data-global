module("modules.logic.story.view.StoryDialogItem", package.seeall)

slot0 = class("StoryDialogItem")

function slot0.init(slot0, slot1)
	slot0._conGo = slot1
	slot0._gonexticon = gohelper.findChild(slot1, "nexticon")
	slot0._goconversation = gohelper.findChild(slot1, "#go_conversation")
	slot0._goblackbottom = gohelper.findChild(slot1, "#go_conversation/blackBottom")

	if slot0._goblackbottom == nil then
		slot0._goblackbottom = gohelper.findChild(slot1, "#go_conversation/#go_contents/content/blackBottom")
	end

	if slot0._goblackbottom == nil then
		slot0._goblackbottom = gohelper.findChild(slot1, "#go_conversation/#go_contents/blackBottom")
	end

	slot0._contentGO = gohelper.findChild(slot1, "#go_conversation/#go_contents")
	slot0._goline = gohelper.findChild(slot0._contentGO, "content/line")

	if slot0._goline == nil then
		slot0._goline = gohelper.findChild(slot0._contentGO, "line")
	end

	slot0._norDiaGO = gohelper.findChild(slot0._contentGO, "content/go_normalcontent")

	if slot0._norDiaGO == nil then
		slot0._norDiaGO = gohelper.findChild(slot0._contentGO, "go_normalcontent")
	end

	slot0._norDiaLayoutElement = gohelper.onceAddComponent(slot0._norDiaGO, typeof(UnityEngine.UI.LayoutElement))
	slot0._txtcontentcn = gohelper.findChildText(slot0._norDiaGO, "txt_contentcn")
	slot0._conMat = slot0._txtcontentcn.fontSharedMaterial
	slot2 = UnityEngine.Shader
	slot0._LineMinYId = slot2.PropertyToID("_LineMinY")
	slot0._LineMaxYId = slot2.PropertyToID("_LineMaxY")
	slot0._goDot = IconMgr.instance:getCommonTextDotBottom(slot0._txtcontentcn.gameObject)
	slot0._dotMat = slot0._goDot.transform:GetComponent(gohelper.Type_Image).material
	slot0._txtmarktop = IconMgr.instance:getCommonTextMarkTop(slot0._txtcontentcn.gameObject):GetComponent(gohelper.Type_TextMesh)
	slot0._conMark = gohelper.onceAddComponent(slot0._txtcontentcn.gameObject, typeof(ZProj.TMPMark))

	slot0._conMark:SetMarkGo(slot0._goDot)
	slot0._conMark:SetMarkTopAlpha(0.6)
	slot0._conMark:SetTopOffset(0, -2.60056)
	slot0._conMark:SetMarkTopGo(slot0._txtmarktop.gameObject)

	slot0._magicDiaGO = gohelper.findChild(slot0._contentGO, "content/go_magiccontent")

	if slot0._magicDiaGO == nil then
		slot0._magicDiaGO = gohelper.findChild(slot0._contentGO, "go_magiccontent")
	end

	slot0._txtcontentmagic = gohelper.findChildText(slot0._magicDiaGO, "txt_contentmagic")
	slot0._gofirework = gohelper.findChild(slot0._magicDiaGO, "txt_contentmagic/go_firework")
	slot0._txtcontentreshapemagic = gohelper.findChildText(slot0._magicDiaGO, "txt_contentreshapemagic")
	slot0._goreshapefirework = gohelper.findChild(slot0._magicDiaGO, "txt_contentreshapemagic/go_reshapefirework")

	slot0:_showMagicItem(false)

	slot0._goslidecontent = gohelper.findChild(slot1, "#go_slidecontent")
	slot0._slideItem = StoryDialogSlideItem.New()

	slot0._slideItem:init(slot0._goslidecontent)
	slot0._slideItem:hideDialog()

	slot0._roleAudioGo = gohelper.findChild(ViewMgr.instance:getContainer(ViewName.StoryView).viewGO, "go_roleaudio")
	slot0._roleLeftAudioGo = gohelper.findChild(slot0._roleAudioGo, "left")
	slot0._roleMidAudioGo = gohelper.findChild(slot0._roleAudioGo, "middle")
	slot0._roleRightAudioGo = gohelper.findChild(slot0._roleAudioGo, "right")
	slot0._fontNormalMat = slot0._txtcontentcn.fontSharedMaterial

	slot0:_loadRes()
	slot0:_addEvent()
end

function slot0._loadRes(slot0)
	slot0._magicFirePath = ResUrl.getEffect("story/story_magicfont_particle")
	slot0._reshapeMagicFirePath = ResUrl.getEffect("story/story_magicfont_particle_dark")
	slot0._effLoader = MultiAbLoader.New()

	slot0._effLoader:addPath(slot0._magicFirePath)
	slot0._effLoader:addPath(slot0._reshapeMagicFirePath)
	slot0._effLoader:startLoad(slot0._magicFireEffectLoaded, slot0)
end

function slot0._magicFireEffectLoaded(slot0, slot1)
	slot0._magicFireGo = gohelper.clone(slot1:getAssetItem(slot0._magicFirePath):GetResource(slot0._magicFirePath), slot0._gofirework)

	gohelper.setActive(slot0._magicFireGo, false)

	slot0._magicFireAnim = slot0._magicFireGo:GetComponent(typeof(UnityEngine.Animator))
	slot0._reshapeMagicFireGo = gohelper.clone(slot1:getAssetItem(slot0._reshapeMagicFirePath):GetResource(slot0._reshapeMagicFirePath), slot0._goreshapefirework)

	gohelper.setActive(slot0._reshapeMagicFireGo, false)

	slot0._reshapeMagicFireAnim = slot0._reshapeMagicFireGo:GetComponent(typeof(UnityEngine.Animator))
end

function slot0._addEvent(slot0)
	StoryController.instance:registerCallback(StoryEvent.LogSelected, slot0._btnlogOnClick, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._checkCloseView, slot0)
end

function slot0._removeEvent(slot0)
	StoryController.instance:unregisterCallback(StoryEvent.LogSelected, slot0._btnlogOnClick, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0._checkCloseView, slot0)
end

function slot0._checkCloseView(slot0, slot1)
	if slot1 == ViewName.StoryLogView then
		slot0._isLogStop = false
	end
end

function slot0._btnlogOnClick(slot0, slot1)
	slot0._isLogStop = true

	if slot1 == slot0._conAudioId then
		return
	end

	slot0._playingAudioId = 0

	if slot0._conAudioId ~= 0 and slot0._conAudioId then
		AudioEffectMgr.instance:stopAudio(slot0._conAudioId, 0)
	end
end

function slot0.hideDialog(slot0)
	if slot0._conTweenId then
		ZProj.TweenHelper.KillById(slot0._conTweenId)

		slot0._conTweenId = nil
	end

	if slot0._magicConTweenId then
		ZProj.TweenHelper.KillById(slot0._magicConTweenId)

		slot0._magicConTweenId = nil
	end

	gohelper.setActive(slot0._norDiaGO, false)

	slot1, slot2, slot3 = transformhelper.getLocalPos(slot0._txtcontentcn.transform)

	transformhelper.setLocalPos(slot0._txtcontentcn.transform, slot1, slot2, 1)

	slot0._txtcontentcn.text = ""

	slot0._conMark:SetMarksTop({})
	slot0._conMat:DisableKeyword("_GRADUAL_ON")
	TaskDispatcher.cancelTask(slot0._delayShow, slot0)
	slot0:_showMagicItem(false)

	slot0._finishCallback = nil
	slot0._finishCallbackObj = nil
	slot4, slot5, slot6 = transformhelper.getLocalPos(slot0._txtcontentmagic.transform)

	transformhelper.setLocalPos(slot0._txtcontentmagic.transform, slot4, slot5, 1)
	transformhelper.setLocalPos(slot0._txtcontentreshapemagic.transform, slot4, slot5, 1)

	slot0._txtcontentmagic.text = ""
	slot0._txtcontentreshapemagic.text = ""
end

function slot0.playDialog(slot0, slot1, slot2, slot3, slot4)
	slot0._stepCo = slot2

	slot0:clearSlideDialog()

	if slot0._stepCo.conversation.type == StoryEnum.ConversationType.SlideDialog then
		slot0:playSlideDialog(StoryModel.instance:getStoryTxtByVoiceType(slot1, slot0._stepCo.conversation.audios[1] or 0), slot3, slot4)

		return
	end

	slot0._slideItem:hideDialog()
	gohelper.setActive(slot0._goconversation, true)
	gohelper.setActive(slot0._gonexticon, true)

	if slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic or slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic then
		slot0:playMagicText(slot6, slot3, slot4)
	else
		slot0:playNormalText(slot6, slot3, slot4)
	end
end

function slot0.clearSlideDialog(slot0)
	if slot0._slideItem then
		slot0._slideItem:clearSlideDialog()
	end
end

function slot0.playSlideDialog(slot0, slot1, slot2, slot3)
	if #string.split(slot1, "#") ~= 3 then
		logError("配置异常，请检查配置[示例：gundongzimu_1#1.0#10.0](图片名#速度#时间)")

		return
	end

	gohelper.setActive(slot0._goconversation, false)
	gohelper.setActive(slot0._gonexticon, false)
	slot0._slideItem:startShowDialog({
		img = slot4[1],
		speed = tonumber(slot4[2]),
		showTime = tonumber(slot4[3])
	}, slot2, slot3)
end

function slot0.playMagicText(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot0._goline, true)
	slot0:_showMagicItem(true)
	TaskDispatcher.cancelTask(slot0._playConAudio, slot0)
	gohelper.setActive(slot0._norDiaGO, false)

	slot0._txt = StoryTool.filterSpTag(slot1)
	slot0._textShowFinished = false
	slot0._playingAudioId = 0
	slot0._finishCallback = slot2
	slot0._finishCallbackObj = slot3
	slot0._txtcontentmagic.text = slot0._txt
	slot0._txtcontentreshapemagic.text = slot0._txt
	slot4, slot5, slot6 = transformhelper.getLocalPos(slot0._txtcontentmagic.transform)

	transformhelper.setLocalPos(slot0._txtcontentmagic.transform, slot4, slot5, 1)
	transformhelper.setLocalPos(slot0._txtcontentreshapemagic.transform, slot4, slot5, 1)

	slot0._magicConTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, slot0:_getMagicWordShowTime(slot1), slot0._magicConUpdate, slot0._onMagicTextFinished, slot0, nil, EaseType.Linear)

	slot0._magicFireAnim:Play("story_magicfont_particle")
	slot0._reshapeMagicFireAnim:Play("story_magicfont_particle")
	gohelper.setActive(slot0._magicFireGo, slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic)
	gohelper.setActive(slot0._reshapeMagicFireGo, slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic)
	gohelper.setActive(slot0._txtcontentmagic.gameObject, slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic)
	gohelper.setActive(slot0._txtcontentreshapemagic, slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic)

	if slot0._stepCo.conversation.audioDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		slot0:_playConAudio()
	else
		TaskDispatcher.runDelay(slot0._playConAudio, slot0, slot0._stepCo.conversation.audioDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end

	if slot7 > 0 then
		slot0._magicFireAnim.speed = 1 / slot7
		slot0._reshapeMagicFireAnim.speed = 1 / slot7
	end
end

function slot0._getMagicWordShowTime(slot0, slot1)
	slot4 = 0.1

	if LuaUtil.getCharNum(string.gsub(string.gsub(slot1, "%%", "--------"), "%&", "--------")) < 30 then
		slot4 = 0.2
	end

	if slot3 < 15 then
		slot4 = 0.5
	end

	if slot2 and string.find(slot2, "<speed=%d[%d.]*>") then
		slot4 = string.sub(slot2, string.find(slot2, "<speed=%d[%d.]*>")) and tonumber(string.match(slot5, "%d[%d.]*")) or 1
	end

	return slot4 * slot3
end

function slot0._magicConUpdate(slot0, slot1)
	if slot1 > ((slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic and recthelper.getWidth(slot0._txtcontentmagic.gameObject.transform) or recthelper.getWidth(slot0._txtcontentreshapemagic.gameObject.transform)) + 100) / 2215 and slot2 > 1 then
		if slot0._magicConTweenId then
			ZProj.TweenHelper.KillById(slot0._magicConTweenId)

			slot0._magicConTweenId = nil
		end

		slot0:_onMagicTextFinished()

		return
	end

	slot3 = 1107.5
	slot4, slot5, slot6 = transformhelper.getLocalPos(slot0._txtcontentmagic.transform)

	if slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic then
		slot4, slot5, slot6 = transformhelper.getLocalPos(slot0._txtcontentreshapemagic.transform)
	end

	slot7 = UnityEngine.Screen.width
	slot8 = UnityEngine.Screen.height
	slot9 = 0
	slot10 = 1920
	slot11 = transformhelper.getLocalPos(slot0._contentGO.transform)
	slot12 = ((slot7 / slot8 >= 1.7777777777777777 and 0.5 * (1080 * slot7 / slot8 - 1920) + 960 + slot11 or 960 - 0.5 * (1920 - 1080 * slot7 / slot8) + slot11) + slot1 * (slot3 + 10)) / (1920 * 1080 * slot7 / (1920 * slot8))
	slot13 = slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic and recthelper.uiPosToScreenPos(slot0._txtcontentmagic.gameObject.transform, ViewMgr.instance:getUICanvas()).y or recthelper.uiPosToScreenPos(slot0._txtcontentreshapemagic.gameObject.transform, ViewMgr.instance:getUICanvas()).y
	slot14 = slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic and recthelper.screenPosToAnchorPos(Vector2(slot12 * slot7, slot13), slot0._gofirework.transform) or recthelper.screenPosToAnchorPos(Vector2(slot12 * slot7, slot13), slot0._goreshapefirework.transform)

	if slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic then
		transformhelper.setLocalPos(slot0._txtcontentmagic.transform, slot4, slot5, 1 - slot12)
		transformhelper.setLocalPos(slot0._magicFireGo.transform, slot14.x, slot14.y, 0)
	else
		transformhelper.setLocalPos(slot0._txtcontentreshapemagic.transform, slot4, slot5, 1 - slot12)
		transformhelper.setLocalPos(slot0._reshapeMagicFireGo.transform, slot14.x, slot14.y, 0)
	end
end

function slot0._magicConFinished(slot0)
	slot1, slot2, slot3 = transformhelper.getLocalPos(slot0._txtcontentmagic.transform)

	transformhelper.setLocalPos(slot0._txtcontentmagic.transform, slot1, slot2, 0)
	transformhelper.setLocalPos(slot0._txtcontentreshapemagic.transform, slot1, slot2, 0)
	gohelper.setActive(slot0._magicFireGo, false)
	gohelper.setActive(slot0._reshapeMagicFireGo, false)

	slot0._magicFireAnim.speed = 1
	slot0._reshapeMagicFireAnim.speed = 1

	if slot0._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract or slot0._stepCo.conversation.type == StoryEnum.ConversationType.None then
		return
	end

	if slot0._finishCallback then
		slot0._finishCallback(slot0._finishCallbackObj)
	end
end

function slot0.playNormalText(slot0, slot1, slot2, slot3)
	if SDKModel.instance:isDmm() and LangSettings.instance:isJp() then
		if StoryController.instance._curStoryId == 100601 and StoryController.instance._curStepId == 36 then
			slot1 = "はっ！　正気の沙汰じゃない。一家そろって◯◯◯だぞ！"
		elseif slot4 == 100602 and slot5 == 30 then
			slot1 = "あんたらがマヌス・ヴェンデッタの仮面を研究したおかげで、その副作用が徹底的に分かったぜ！　おかげで、ラプラスの廊下は身体のあちこちから石油を垂らす◯◯◯で埋まっちまったがな。"
		elseif slot4 == 100726 and slot5 == 32 then
			slot1 = "ははは！　死ね、無様な◯◯◯どもが！！"
		end
	end

	slot0._txt = slot1
	slot0._textShowFinished = false

	TaskDispatcher.cancelTask(slot0._playConAudio, slot0)
	TaskDispatcher.cancelTask(slot0._waitSecondFinished, slot0)

	slot0._playingAudioId = 0
	slot0._finishCallback = slot2
	slot0._finishCallbackObj = slot3
	slot0._markIndexs = StoryTool.getMarkTextIndexs(slot0._txt)
	slot0._subemtext = StoryTool.filterSpTag(slot0._txt)
	slot0._markTopList = StoryTool.getMarkTopTextList(slot0._subemtext)
	slot0._subemtext = StoryTool.filterMarkTop(slot0._subemtext)
	slot0._txtcontentcn.text = string.gsub(slot0._subemtext, "(<sprite=%d>)", "")
	slot0._txtcontentmagic.text = ""
	slot0._txtcontentreshapemagic.text = ""
	slot0._txtcontentTmp = slot0._txtcontentcn:GetComponent(typeof(TMPro.TextMeshProUGUI))

	if slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.SoftLight then
		slot0._txtcontentcn.alignment = TMPro.TextAlignmentOptions.Center

		if slot0._txtcontentcn.fontSharedMaterial:IsKeywordEnabled("UNDERLAY_ON") == false then
			slot0._txtcontentcn.fontSharedMaterial:EnableKeyword("UNDERLAY_ON")
			slot0._txtcontentcn.fontSharedMaterial:SetFloat("_BloomFactor", 2.5)

			slot0._txtcontentcn.fontSharedMaterial.renderQueue = 4995

			slot0._txtcontentcn.fontSharedMaterial:SetColor("_UnderlayColor", Color.New(0, 0, 0, 0.75))
			slot0._txtcontentcn.fontSharedMaterial:SetFloat("_UnderlayOffsetX", 0.143)
			slot0._txtcontentcn.fontSharedMaterial:SetFloat("_UnderlayOffsetY", -0.1)
			slot0._txtcontentcn.fontSharedMaterial:SetFloat("_UnderlayDilate", 0.107)
			slot0._txtcontentcn.fontSharedMaterial:SetFloat("_UnderlaySoftness", 0.447)

			slot0._txtcontentcn.fontSharedMaterial = slot0._txtcontentcn.fontMaterial
		end

		StoryTool.enablePostProcess(true)
		PostProcessingMgr.instance:setUIPPValue("localBloomActive", true)
		PostProcessingMgr.instance:setUIPPValue("bloomDiffusion", 5)
		gohelper.setActive(slot0._goline, false)
		gohelper.setActive(slot0._goblackbottom, false)
		gohelper.setActive(slot0._gonexticon, false)

		slot0._norDiaLayoutElement.ignoreLayout = true
		slot0._norDiaLayoutElement.transform.anchorMax = Vector2.New(0, 0)
		slot0._norDiaLayoutElement.transform.anchorMin = Vector2.New(0, 0)

		recthelper.setHeight(slot0._norDiaGO.transform, 0)

		if BootNativeUtil.isIOS() then
			transformhelper.setLocalPosXY(slot0._norDiaGO.transform, -351, 120)
			recthelper.setWidth(slot0._norDiaGO.transform, 1800)
			recthelper.setWidth(slot0._txtcontentcn.transform, 1800)

			slot0._txtcontentTmp.enableAutoSizing = true
			slot0._txtcontentTmp.fontSizeMax = 32
			slot0._txtcontentTmp.fontSizeMin = 10
		else
			transformhelper.setLocalPosXY(slot0._norDiaGO.transform, -351, 100)
			recthelper.setWidth(slot0._norDiaGO.transform, 1800)
			recthelper.setWidth(slot0._txtcontentcn.transform, 1800)

			slot0._txtcontentTmp.enableAutoSizing = false
		end
	else
		slot0._txtcontentcn.fontSharedMaterial:DisableKeyword("UNDERLAY_ON")

		slot0._txtcontentcn.alignment = TMPro.TextAlignmentOptions.TopLeft
		slot0._txtcontentcn.fontSharedMaterial = slot0._fontNormalMat

		slot0._txtcontentcn.fontSharedMaterial:SetFloat("_BloomFactor", 0)
		PostProcessingMgr.instance:setUIPPValue("localBloomActive", false)
		PostProcessingMgr.instance:setUIPPValue("bloomDiffusion", 7)
		gohelper.setActive(slot0._goline, true)
		gohelper.setActive(slot0._goblackbottom, true)
		gohelper.setActive(slot0._gonexticon, true)

		slot0._norDiaLayoutElement.ignoreLayout = false

		transformhelper.setLocalPosXY(slot0._norDiaGO.transform, 550, 0)
		recthelper.setWidth(slot0._norDiaGO.transform, 1200)
		recthelper.setWidth(slot0._txtcontentcn.transform, 1200)

		slot0._txtcontentTmp.enableAutoSizing = false
	end

	if slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Hard then
		slot0:_playHardIn()
	else
		slot0:_playGradualIn()
	end
end

function slot0._playHardIn(slot0)
	slot0:_showMagicItem(false)
	gohelper.setActive(slot0._norDiaGO, true)
	slot0:conFinished()
end

function slot0._playGradualIn(slot0)
	slot0:_showMagicItem(false)
	gohelper.setActive(slot0._norDiaGO, true)

	slot1 = UnityEngine.Screen.height

	slot0._conMat:SetFloat(slot0._LineMinYId, slot1)
	slot0._conMat:SetFloat(slot0._LineMaxYId, slot1)
	slot0._conMat:EnableKeyword("_GRADUAL_ON")
	slot0._conMat:DisableKeyword("_DISSOLVE_ON")

	slot2, slot3, slot4 = transformhelper.getLocalPos(slot0._txtcontentcn.transform)

	transformhelper.setLocalPos(slot0._txtcontentcn.transform, slot2, slot3, 1)
	TaskDispatcher.cancelTask(slot0._delayShow, slot0)
	TaskDispatcher.runDelay(slot0._delayShow, slot0, 0.05)
end

function slot0._showMagicItem(slot0, slot1)
	if slot1 then
		if slot0._magicFireGo then
			StoryTool.enablePostProcess(true)
			gohelper.setActive(slot0._reshapeMagicFireGo, slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic)
		end

		if slot0._reshapeMagicFireGo then
			StoryTool.enablePostProcess(true)
			gohelper.setActive(slot0._reshapeMagicFireGo, slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic)
		end
	else
		slot0._txtcontentmagic.text = ""
		slot0._txtcontentreshapemagic.text = ""

		gohelper.setActive(slot0._magicFireGo, false)
		gohelper.setActive(slot0._reshapeMagicFireGo, false)
	end
end

function slot0._delayShow(slot0)
	slot1 = UnityEngine.Screen.height

	slot0._dotMat:SetFloat(slot0._LineMinYId, slot1)
	slot0._dotMat:SetFloat(slot0._LineMaxYId, slot1)

	if slot0._stepCo.conversation.type ~= StoryEnum.ConversationType.ScreenDialog then
		slot0._conMark:SetMarksTop(slot0._markTopList)
	end

	slot0._textInfo = slot0._txtcontentcn:GetTextInfo(slot0._subemtext)
	slot0._lineInfoList = {}
	slot2 = 0

	for slot6 = 1, slot0._textInfo.lineCount do
		slot7 = slot0._textInfo.lineInfo[slot6 - 1]

		table.insert(slot0._lineInfoList, {
			slot7,
			slot2 + 1,
			slot2 + slot7.visibleCharacterCount
		})
	end

	slot0._contentX, slot0._contentY, _ = transformhelper.getLocalPos(slot0._txtcontentcn.transform)
	slot0._curLine = nil

	if GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LangSettings.en then
		slot3 = slot0:_getDelayTime(slot2) * 0.67
	end

	if slot0._conTweenId then
		ZProj.TweenHelper.KillById(slot0._conTweenId)

		slot0._conTweenId = nil
	end

	if slot0._stepCo.conversation.audioDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		slot0:_playConAudio()
	else
		TaskDispatcher.runDelay(slot0._playConAudio, slot0, slot0._stepCo.conversation.audioDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end

	slot0._lastBottomLeft = 0
	slot0._lineSpace = 0
	slot0._hasUnderline = string.find(slot0._subemtext, "<u>") and string.find(slot0._subemtext, "</u>")
	slot0._conTweenId = ZProj.TweenHelper.DOTweenFloat(1, slot2, slot3, slot0._conUpdate, slot0._onTextFinished, slot0, nil, EaseType.Linear)
end

function slot0._getDelayTime(slot0, slot1)
	slot2 = 1

	if slot0._txt and string.find(slot0._txt, "<speed=%d[%d.]*>") then
		slot2 = string.sub(slot0._txt, string.find(slot0._txt, "<speed=%d[%d.]*>")) and tonumber(string.match(slot3, "%d[%d.]*")) or 1
	end

	if GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.EN then
		slot3 = 0.08 * slot1 * 0.67
	end

	return slot3 / slot2
end

function slot0._playConAudio(slot0)
	if slot0._isLogStop then
		return
	end

	slot0:stopConAudio()

	if StoryModel.instance:isSpecialVideoPlaying() then
		return
	end

	slot0._conAudioId = slot0._stepCo.conversation.audios[1] or 0

	if slot0._conAudioId ~= 0 then
		slot0._playingAudioId = slot0._conAudioId

		AudioEffectMgr.instance:playAudio(slot0._conAudioId, {
			loopNum = 1,
			fadeInTime = 0,
			fadeOutTime = 0,
			volume = 100,
			audioGo = slot0:_getDialogGo(),
			callback = slot0._onConAudioFinished,
			callbackTarget = slot0
		})
	else
		slot0._playingAudioId = 0
	end

	slot0._hasLowPassAudio = false

	if #slot0._stepCo.conversation.audios > 1 then
		for slot4, slot5 in pairs(slot0._stepCo.conversation.audios) do
			if slot5 == AudioEnum.Story.Play_Lowpass then
				slot0._hasLowPassAudio = true

				AudioMgr.instance:trigger(AudioEnum.Story.Play_Lowpass)

				return
			end
		end
	end
end

function slot0._getDialogGo(slot0)
	if #slot0._stepCo.heroList > 0 and slot0._stepCo.conversation.showList[1] then
		if not slot0._stepCo.heroList[slot0._stepCo.conversation.showList[1] + 1] then
			return slot0._roleMidAudioGo
		end

		if slot0._stepCo.heroList[slot0._stepCo.conversation.showList[1] + 1].heroDir and slot2 == 0 then
			slot1 = slot0._roleLeftAudioGo
		end

		if slot2 and slot2 == 2 then
			slot1 = slot0._roleRightAudioGo
		end
	end

	return slot1
end

function slot0._onTextFinished(slot0)
	TaskDispatcher.cancelTask(slot0._delayShow, slot0)

	if slot0._magicConTweenId then
		ZProj.TweenHelper.KillById(slot0._magicConTweenId)
		gohelper.setActive(slot0._magicFireGo, false)
		gohelper.setActive(slot0._reshapeMagicFireGo, false)

		slot0._magicFireAnim.speed = 1
		slot0._reshapeMagicFireAnim.speed = 1
		slot0._magicConTweenId = nil
	end

	if slot0._conTweenId then
		ZProj.TweenHelper.KillById(slot0._conTweenId)

		slot0._conTweenId = nil
	end

	slot1, slot2, slot3 = transformhelper.getLocalPos(slot0._txtcontentcn.transform)

	transformhelper.setLocalPos(slot0._txtcontentcn.transform, slot1, slot2, 0)

	slot4, slot5, slot6 = transformhelper.getLocalPos(slot0._txtcontentmagic.transform)

	transformhelper.setLocalPos(slot0._txtcontentmagic.transform, slot4, slot5, 0)
	transformhelper.setLocalPos(slot0._txtcontentreshapemagic.transform, slot4, slot5, 0)
	slot0._conMat:DisableKeyword("_GRADUAL_ON")
	slot0._conMat:SetFloat(slot0._LineMinYId, 0)
	slot0._conMat:SetFloat(slot0._LineMaxYId, 0)

	slot0._subMeshs = {}

	if slot0._txtcontentcn.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true) then
		slot8 = slot7:GetEnumerator()

		while slot8:MoveNext() do
			table.insert(slot0._subMeshs, slot8.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI)))
		end
	end

	for slot11, slot12 in pairs(slot0._subMeshs) do
		if slot12.sharedMaterial then
			slot12.sharedMaterial = slot0._fontNormalMat

			slot12.sharedMaterial:DisableKeyword("_GRADUAL_ON")
		end
	end

	slot0._textShowFinished = true

	if slot0._stepCo.conversation.type ~= StoryEnum.ConversationType.NoInteract and slot0._stepCo.conversation.type ~= StoryEnum.ConversationType.None then
		slot8 = StoryModel.instance:isStoryAuto() or slot0._stepCo.conversation.isAuto
	end

	if not slot8 or slot0._playingAudioId == 0 then
		slot0:conFinished()
	end
end

function slot0._onMagicTextFinished(slot0)
	slot0._textShowFinished = true

	slot0:_magicConFinished()
end

function slot0._onConAudioFinished(slot0, slot1)
	if slot0._textShowFinished then
		if slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic or slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic then
			slot0:_magicConFinished()
		else
			slot0:conFinished()
		end
	end

	if slot0._playingAudioId == slot1 then
		slot0._playingAudioId = 0
	end
end

function slot0.stopConAudio(slot0)
	if slot0._hasLowPassAudio then
		AudioMgr.instance:trigger(AudioEnum.Story.Stop_Lowpass)
	end

	if slot0._isLogStop then
		return
	end

	slot0._playingAudioId = 0

	if slot0._conAudioId ~= 0 and slot0._conAudioId then
		AudioEffectMgr.instance:stopAudio(slot0._conAudioId, 0)
	end
end

function slot0._conUpdate(slot0, slot1)
	slot2 = UnityEngine.Screen.width
	slot3 = slot0._txtcontentcn.transform
	slot4 = CameraMgr.instance:getUICamera()
	slot0._subMeshs = {}

	if slot0._txtcontentcn.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true) then
		slot6 = slot5:GetEnumerator()

		while slot6:MoveNext() do
			table.insert(slot0._subMeshs, slot6.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI)))
		end
	end

	for slot9, slot10 in ipairs(slot0._lineInfoList) do
		slot11 = slot10[1]
		slot13 = slot10[3]

		if slot10[2] <= slot1 and slot1 <= slot13 then
			slot14 = slot0._textInfo.characterInfo
			slot16 = slot14[slot11.lastVisibleCharacterIndex]
			slot17 = slot4:WorldToScreenPoint(slot3:TransformPoint(slot14[slot11.firstVisibleCharacterIndex].bottomLeft))
			slot18 = slot17

			for slot23 = slot11.firstVisibleCharacterIndex, slot11.lastVisibleCharacterIndex do
				if slot4:WorldToScreenPoint(slot3:TransformPoint(slot14[slot23].bottomLeft)).y < slot17.y then
					slot19 = slot25.y
				end
			end

			slot18.y = slot19
			slot20 = slot4:WorldToScreenPoint(slot3:TransformPoint(slot15.topLeft))
			slot21 = slot20

			for slot26 = slot11.firstVisibleCharacterIndex, slot11.lastVisibleCharacterIndex do
				if slot20.y < slot4:WorldToScreenPoint(slot3:TransformPoint(slot14[slot26].topLeft)).y then
					slot22 = slot28.y
				end
			end

			slot21.y = slot22
			slot27 = slot16.bottomRight
			slot23 = slot4:WorldToScreenPoint(slot3:TransformPoint(slot27))

			for slot27, slot28 in pairs(slot0._subMeshs) do
				if slot28.sharedMaterial then
					if slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.SoftLight then
						break
					end

					slot28.sharedMaterial = slot0._fontNormalMat
				end
			end

			if slot9 == 1 then
				if slot0._hasUnderline then
					slot0._conMat:SetFloat(slot0._LineMinYId, slot18.y - 4)
				else
					slot0._conMat:SetFloat(slot0._LineMinYId, slot18.y)
				end

				slot0._conMat:SetFloat(slot0._LineMaxYId, slot21.y + 20)
				slot0._dotMat:SetFloat(slot0._LineMinYId, slot18.y - 10)
				slot0._dotMat:SetFloat(slot0._LineMaxYId, slot21.y)
			else
				slot0._lineSpace = slot0._lastBottomLeft - slot21.y > 0 and slot0._lastBottomLeft - slot21.y or slot0._lineSpace

				slot0._conMat:SetFloat(slot0._LineMinYId, slot18.y)
				slot0._conMat:SetFloat(slot0._LineMaxYId, slot21.y + slot0._lineSpace)
				slot0._dotMat:SetFloat(slot0._LineMinYId, slot18.y - 10)
				slot0._dotMat:SetFloat(slot0._LineMaxYId, slot21.y)
			end

			slot0._lastBottomLeft = slot18.y
			slot24 = slot0._txtcontentcn.gameObject

			gohelper.setActive(slot24, false)
			gohelper.setActive(slot24, true)
			transformhelper.setLocalPos(slot0._txtcontentcn.transform, slot0._contentX, slot0._contentY, slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.SoftLight and 0 or 1 - Mathf.Lerp(slot18.x - 10, slot23.x + 10, slot12 == slot13 and 1 or (slot1 - slot12) / (slot13 - slot12)) / slot2)

			if slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.SoftLight then
				slot0._conMat:SetFloat(slot0._LineMinYId, 0)
				slot0._conMat:SetFloat(slot0._LineMaxYId, 0)

				if #slot0._lineInfoList > 1 then
					if BootNativeUtil.isIOS() then
						transformhelper.setLocalPosXY(slot0._norDiaGO.transform, -351, 120 + 50 * (#slot0._lineInfoList - 2))
					else
						transformhelper.setLocalPosXY(slot0._norDiaGO.transform, -351, 100 + 50 * (#slot0._lineInfoList - 2))
					end
				end
			end
		end
	end
end

function slot0.conFinished(slot0)
	slot0._textShowFinished = true

	if slot0._stepCo and (slot0._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract or slot0._stepCo.conversation.type == StoryEnum.ConversationType.None) then
		return
	end

	if slot0._magicConTweenId then
		ZProj.TweenHelper.KillById(slot0._magicConTweenId)
		gohelper.setActive(slot0._magicFireGo, false)
		gohelper.setActive(slot0._reshapeMagicFireGo, false)

		slot0._magicFireAnim.speed = 1
		slot0._reshapeMagicFireAnim.speed = 1
		slot0._magicConTweenId = nil
	end

	if slot0._conTweenId then
		ZProj.TweenHelper.KillById(slot0._conTweenId)

		slot0._conTweenId = nil
	end

	slot0._conMat:SetFloat(slot0._LineMinYId, 0)
	slot0._conMat:SetFloat(slot0._LineMaxYId, 0)

	slot1, slot2, slot3 = transformhelper.getLocalPos(slot0._txtcontentcn.transform)

	transformhelper.setLocalPos(slot0._txtcontentcn.transform, slot1, slot2, 0)

	slot4, slot5, slot6 = transformhelper.getLocalPos(slot0._txtcontentmagic.transform)

	transformhelper.setLocalPos(slot0._txtcontentmagic.transform, slot4, slot5, 0)

	slot0._subMeshs = {}

	if slot0._txtcontentcn.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true) then
		slot8 = slot7:GetEnumerator()

		while slot8:MoveNext() do
			table.insert(slot0._subMeshs, slot8.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI)))
		end
	end

	for slot11, slot12 in pairs(slot0._subMeshs) do
		if slot12.sharedMaterial then
			slot12.sharedMaterial:DisableKeyword("_GRADUAL_ON")
		end
	end

	transformhelper.setLocalPos(slot0._txtcontentreshapemagic.transform, slot4, slot5, 0)
	slot0._conMat:DisableKeyword("_GRADUAL_ON")

	if slot0._finishCallback then
		slot0._finishCallback(slot0._finishCallbackObj)
	end
end

function slot0.playNorDialogFadeIn(slot0, slot1, slot2)
	ZProj.TweenHelper.DoFade(slot0._txtcontentcn, 0, 1, 2, function ()
		if uv0 then
			uv0(uv1)
		end
	end, nil, , EaseType.Linear)
end

function slot0.playWordByWord(slot0, slot1, slot2)
	slot0._txtcontentcn.text = ""

	ZProj.TweenHelper.DOText(slot0._txtcontentcn, slot0._diatxt, 2, function ()
		if uv0 then
			uv0(uv1)
		end
	end)
end

function slot0.startAutoEnterNext(slot0)
	if slot0._playingAudioId == 0 and slot0._textShowFinished then
		if slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Magic or slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.ReshapeMagic then
			slot0:_magicConFinished()
		else
			slot0:conFinished()
		end
	end
end

function slot0.checkAutoEnterNext(slot0, slot1, slot2)
	slot0._diaFinishedCallback = slot1
	slot0._diaFinishedCallbackObj = slot2

	TaskDispatcher.cancelTask(slot0._onSecond, slot0)
	TaskDispatcher.cancelTask(slot0._waitSecondFinished, slot0)
	TaskDispatcher.runRepeat(slot0._onSecond, slot0, 0.1)
end

function slot0._onSecond(slot0)
	if slot0._playingAudioId == 0 and slot0._textShowFinished then
		TaskDispatcher.cancelTask(slot0._onSecond, slot0)
		TaskDispatcher.cancelTask(slot0._waitSecondFinished, slot0)
		TaskDispatcher.runDelay(slot0._waitSecondFinished, slot0, 2)
	end
end

function slot0.isAudioPlaying(slot0)
	return slot0._playingAudioId ~= 0
end

function slot0._waitSecondFinished(slot0)
	if slot0._diaFinishedCallback then
		slot0._diaFinishedCallback(slot0._diaFinishedCallbackObj)
	end
end

function slot0.storyFinished(slot0)
	slot0._finishCallback = nil
	slot0._finishCallbackObj = nil
end

function slot0.destroy(slot0)
	slot0._txtcontentcn.fontSharedMaterial = slot0._fontNormalMat

	slot0:_removeEvent()
	TaskDispatcher.cancelTask(slot0._playConAudio, slot0)
	TaskDispatcher.cancelTask(slot0._onSecond, slot0)
	TaskDispatcher.cancelTask(slot0._waitSecondFinished, slot0)
	slot0:stopConAudio()

	if slot0._slideItem then
		slot0._slideItem:destroy()

		slot0._slideItem = nil
	end

	if slot0._conTweenId then
		ZProj.TweenHelper.KillById(slot0._conTweenId)

		slot0._conTweenId = nil
	end

	if slot0._magicConTweenId then
		ZProj.TweenHelper.KillById(slot0._magicConTweenId)

		slot0._magicConTweenId = nil
	end

	if slot0._effLoader then
		slot0._effLoader:dispose()

		slot0._effLoader = nil
	end

	TaskDispatcher.cancelTask(slot0._delayShow, slot0)

	slot0._finishCallback = nil
	slot0._finishCallbackObj = nil

	slot0._conMat:DisableKeyword("_GRADUAL_ON")
	slot0:_removeEvent()

	if slot0._matLoader then
		slot0._matLoader:dispose()

		slot0._matLoader = nil
	end
end

return slot0
