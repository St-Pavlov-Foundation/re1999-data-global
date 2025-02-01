module("modules.spine.SpineVoiceText", package.seeall)

slot0 = class("SpineVoiceText")

function slot0.onDestroy(slot0)
	slot0:removeTaskActions()

	slot0._spineVoice = nil
	slot0._voiceConfig = nil
	slot0._txtContent = nil
	slot0._txtEnContent = nil
	slot0._showBg = nil
end

function slot0.init(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0._spineVoice = slot1
	slot0._voiceConfig = slot2
	slot0._txtContent = slot3
	slot0._txtmarktop = IconMgr.instance:getCommonTextMarkTop(slot0._txtContent.gameObject):GetComponent(gohelper.Type_TextMesh)
	slot0._conMark = gohelper.onceAddComponent(slot0._txtContent.gameObject, typeof(ZProj.TMPMark))

	slot0._conMark:SetMarkTopGo(slot0._txtmarktop.gameObject)
	slot0._conMark:SetTopOffset(0, -2)

	slot0._txtEnContent = slot4
	slot0._showBg = slot5
	slot0._hasAudio = AudioConfig.instance:getAudioCOById(slot2.audio)
	slot0._showEnContent = GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.CN or slot6 == LanguageEnum.LanguageStoryType.TW

	if slot0._txtContent then
		slot0._contentStart = Time.time
		slot0._contentList = {}

		slot0:_initContent(slot0._contentList, slot0:getContent(slot2))
	end

	if slot0._txtEnContent then
		slot0._enContentStart = Time.time
		slot0._enContentList = {}

		slot0:_initContent(slot0._enContentList, slot0:getContent(slot2, LanguageEnum.LanguageStoryType.EN))
		gohelper.setActive(slot0._txtEnContent.gameObject, slot0._showEnContent)
	end

	if slot0:_contentListEmpty() then
		slot0._spineVoice:setBgVisible(false)
	end

	if not slot0._voiceConfig.displayTime then
		return
	end

	TaskDispatcher.runRepeat(slot0._showContent, slot0, 0.1)
end

function slot0.getContent(slot0, slot1, slot2)
	return SpineVoiceTextHelper.getSeparateContent(slot1, slot2 or GameLanguageMgr.instance:getLanguageTypeStoryIndex(), GameLanguageMgr.instance:getStoryIndexByShortCut(slot0._spineVoice:getVoiceLang()))
end

function slot0._showContent(slot0)
	slot0:_showOneLang(slot0._contentList, slot0._contentStart, slot0._txtContent)
	slot0:_showOneLang(slot0._enContentList, slot0._enContentStart, slot0._txtEnContent)
	slot0:_checkEnd()
end

function slot0._checkEnd(slot0)
	if slot0._hasAudio then
		return
	end

	if slot0:_contentListEmpty() and slot0._voiceConfig.displayTime > 0 then
		TaskDispatcher.cancelTask(slot0._showContent, slot0)
		TaskDispatcher.runDelay(slot0._onEnd, slot0, slot0._voiceConfig.displayTime)
	end
end

function slot0._contentListEmpty(slot0)
	return (not slot0._contentList or #slot0._contentList == 0) and (not slot0._enContentList or #slot0._enContentList == 0)
end

function slot0._onEnd(slot0)
	TaskDispatcher.cancelTask(slot0._onEnd, slot0)
	slot0:onVoiceStop()
end

function slot0._showOneLang(slot0, slot1, slot2, slot3)
	if slot1 then
		if not slot1[1] then
			return
		end

		slot5 = slot4[2] or 0

		if slot4 and not slot4[2] then
			logError("没有配置时间 audio:" .. slot0._voiceConfig.audio)
		end

		if slot5 <= Time.time - slot2 then
			slot3.text = StoryTool.filterMarkTop(slot4[1])

			TaskDispatcher.runDelay(function ()
				if not gohelper.isNil(uv0._txtContent) and uv0._txtContent.text ~= "" and uv0._txtContent.name == uv1.name then
					uv0._conMark:SetMarksTop(StoryTool.getMarkTopTextList(uv2))
				end
			end, nil, 0.01)
			table.remove(slot1, 1)
		end
	end
end

function slot0._initContent(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(string.split(slot2, "|")) do
		if slot8 ~= "" then
			slot9 = string.split(slot8, "#")
			slot9[2] = tonumber(slot9[2])

			table.insert(slot1, slot9)
		end
	end
end

function slot0.removeTaskActions(slot0)
	TaskDispatcher.cancelTask(slot0._showContent, slot0)
	TaskDispatcher.cancelTask(slot0._onEnd, slot0)
end

function slot0.onVoiceStop(slot0)
	slot0:removeTaskActions()

	if slot0._showBg then
		return
	end

	if not gohelper.isNil(slot0._txtContent) then
		slot0._txtContent.text = ""

		slot0._conMark:Destroy()
	end

	if not gohelper.isNil(slot0._txtEnContent) then
		slot0._txtEnContent.text = ""
	end

	if slot0._spineVoice then
		slot0._spineVoice:setBgVisible(false)
	end
end

return slot0
