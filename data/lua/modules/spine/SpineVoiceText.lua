-- chunkname: @modules/spine/SpineVoiceText.lua

module("modules.spine.SpineVoiceText", package.seeall)

local SpineVoiceText = class("SpineVoiceText")

function SpineVoiceText:onDestroy()
	self:removeTaskActions()

	self._spineVoice = nil
	self._voiceConfig = nil
	self._txtContent = nil
	self._txtEnContent = nil
	self._showBg = nil
end

function SpineVoiceText:init(spineVoice, voiceConfig, txtContent, txtEnContent, showBg)
	self._spineVoice = spineVoice
	self._voiceConfig = voiceConfig
	self._txtContent = txtContent
	self._txtmarktop = IconMgr.instance:getCommonTextMarkTop(self._txtContent.gameObject):GetComponent(gohelper.Type_TextMesh)
	self._conMark = gohelper.onceAddComponent(self._txtContent.gameObject, typeof(ZProj.TMPMark))

	self._conMark:SetMarkTopGo(self._txtmarktop.gameObject)
	self._conMark:SetTopOffset(0, -2)

	self._txtEnContent = txtEnContent
	self._showBg = showBg
	self._hasAudio = AudioConfig.instance:getAudioCOById(voiceConfig.audio)

	local storyIndex = GameLanguageMgr.instance:getLanguageTypeStoryIndex()

	self._showEnContent = storyIndex == LanguageEnum.LanguageStoryType.CN or storyIndex == LanguageEnum.LanguageStoryType.TW

	if self._txtContent then
		self._contentStart = Time.time
		self._contentList = {}

		self:_initContent(self._contentList, self:getContent(voiceConfig))
	end

	if self._txtEnContent then
		self._enContentStart = Time.time
		self._enContentList = {}

		self:_initContent(self._enContentList, self:getContent(voiceConfig, LanguageEnum.LanguageStoryType.EN))
		gohelper.setActive(self._txtEnContent.gameObject, self._showEnContent)
	end

	if self:_contentListEmpty() then
		self._spineVoice:setBgVisible(false)
	end

	if not self._voiceConfig.displayTime then
		return
	end

	TaskDispatcher.runRepeat(self._showContent, self, 0.1)
end

function SpineVoiceText:getContent(voiceCo, type)
	local languageType = type or GameLanguageMgr.instance:getLanguageTypeStoryIndex()
	local curLanVoice = self._spineVoice:getVoiceLang()
	local targetIndex = GameLanguageMgr.instance:getStoryIndexByShortCut(curLanVoice)
	local separateContent = SpineVoiceTextHelper.getSeparateContent(voiceCo, languageType, targetIndex)

	return separateContent
end

function SpineVoiceText:_showContent()
	self:_showOneLang(self._contentList, self._contentStart, self._txtContent)
	self:_showOneLang(self._enContentList, self._enContentStart, self._txtEnContent)
	self:_checkEnd()
end

function SpineVoiceText:_checkEnd()
	if self._hasAudio then
		return
	end

	if self:_contentListEmpty() and self._voiceConfig.displayTime > 0 then
		TaskDispatcher.cancelTask(self._showContent, self)
		TaskDispatcher.runDelay(self._onEnd, self, self._voiceConfig.displayTime)
	end
end

function SpineVoiceText:_contentListEmpty()
	return (not self._contentList or #self._contentList == 0) and (not self._enContentList or #self._enContentList == 0)
end

function SpineVoiceText:_onEnd()
	TaskDispatcher.cancelTask(self._onEnd, self)
	self:onVoiceStop()
end

function SpineVoiceText:_showOneLang(contentList, startTime, txtContent)
	if contentList then
		local contentParam = contentList[1]

		if not contentParam then
			return
		end

		local txtStartTime = contentParam[2] or 0

		if contentParam and not contentParam[2] then
			logError("没有配置时间 audio:" .. self._voiceConfig.audio)
		end

		if txtStartTime <= Time.time - startTime then
			local content = contentParam[1]
			local filterResult = StoryTool.filterMarkTop(content)

			txtContent.text = filterResult

			TaskDispatcher.runDelay(function()
				if not gohelper.isNil(self._txtContent) and self._txtContent.text ~= "" and self._txtContent.name == txtContent.name then
					local markTopList = StoryTool.getMarkTopTextList(content)

					self._conMark:SetMarksTop(markTopList)
				end
			end, nil, 0.01)
			table.remove(contentList, 1)
		end
	end
end

function SpineVoiceText:_initContent(contentList, content)
	local list = string.split(content, "|")

	for i, v in ipairs(list) do
		if v ~= "" then
			local param = string.split(v, "#")

			param[2] = tonumber(param[2])

			table.insert(contentList, param)
		end
	end
end

function SpineVoiceText:removeTaskActions()
	TaskDispatcher.cancelTask(self._showContent, self)
	TaskDispatcher.cancelTask(self._onEnd, self)
end

function SpineVoiceText:onVoiceStop()
	self:removeTaskActions()

	if self._showBg then
		return
	end

	if not gohelper.isNil(self._txtContent) then
		self._txtContent.text = ""

		self._conMark:Destroy()
	end

	if not gohelper.isNil(self._txtEnContent) then
		self._txtEnContent.text = ""
	end

	if self._spineVoice then
		self._spineVoice:setBgVisible(false)
	end
end

return SpineVoiceText
