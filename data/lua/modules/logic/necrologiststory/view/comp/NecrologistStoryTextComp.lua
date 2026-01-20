-- chunkname: @modules/logic/necrologiststory/view/comp/NecrologistStoryTextComp.lua

module("modules.logic.necrologiststory.view.comp.NecrologistStoryTextComp", package.seeall)

local NecrologistStoryTextComp = class("NecrologistStoryTextComp", LuaCompBase)

function NecrologistStoryTextComp:_onSetMarksTop()
	if self._txtmarktop and not gohelper.isNil(self._txtmarktopGo) then
		self._txtConMark:SetMarksTop(self._markTopList)
	end
end

function NecrologistStoryTextComp:_setMarksTop(isClear)
	FrameTimerController.instance:unregister(self._fTimer)

	if isClear or #self._markTopList == 0 then
		gohelper.setActive(self._txtmarktopGo, false)
	else
		self._fTimer = FrameTimerController.instance:register(function()
			self:_onSetMarksTop()
		end, nil, 2)

		self._fTimer:Start()
	end
end

function NecrologistStoryTextComp:init(go)
	self._markTopList = {}
	self._txtmarktopGo = IconMgr.instance:getCommonTextMarkTop(go)
	self._txtmarktop = self._txtmarktopGo:GetComponent(gohelper.Type_TextMesh)
	self._txtConMark = gohelper.onceAddComponent(go, typeof(ZProj.TMPMark))

	self._txtConMark:SetMarkTopGo(self._txtmarktopGo)
	self._txtConMark:SetTopOffset(0, -2)

	self.txtGO = go
	self.transform = go.transform
	self.textComponent = gohelper.findChildTextMesh(go, "")
	self.txtHyperLink = NecrologistStoryHelper.addHyperLinkClick(self.textComponent)
	self.typewriterSpeed = 30
	self.typewriterTime = 1 / self.typewriterSpeed
end

function NecrologistStoryTextComp:setTextNormal(text, finishCallback, callbackObj)
	self._markTopList = StoryTool.getMarkTopTextList(text) or {}
	self.metaText = StoryTool.filterMarkTop(text)
	self.finishCallback = finishCallback
	self.callbackObj = callbackObj

	self:onTextFinish()
end

function NecrologistStoryTextComp:setTextWithTypewriter(text, frameCallback, finishCallback, callbackObj)
	self._markTopList = StoryTool.getMarkTopTextList(text) or {}

	self:clearTextTimer()

	self.metaText = StoryTool.filterMarkTop(text)
	self.charList = self:getUCharArr(self.metaText)
	self.charIndex = 1
	self.charCount = #self.charList
	self.tagStack = {}
	self.tagCount = 0
	self.frameCallback = frameCallback
	self.finishCallback = finishCallback
	self.callbackObj = callbackObj

	self:setText(LuaUtil.emptyStr)
	TaskDispatcher.runRepeat(self._showTypewriterText, self, self.typewriterTime)
end

function NecrologistStoryTextComp:_showTypewriterText()
	if self:isDone() then
		self:onTextFinish()

		return
	end

	local text = self:getTypewriterShowText()

	if text then
		self.curText = text
		self.textComponent.text = text

		if self.frameCallback then
			self.frameCallback(self.callbackObj)
		end
	else
		self:_showTypewriterText()
	end
end

function NecrologistStoryTextComp:setText(text)
	self.curText = text
	self.textComponent.text = text
end

function NecrologistStoryTextComp:isDone()
	return self.charIndex > self.charCount
end

function NecrologistStoryTextComp:onTextFinish()
	self:clearTextTimer()

	if not self.charCount then
		self.charCount = 0
	end

	self.charIndex = self.charCount + 1

	self:setText(self.metaText)
	self:_setMarksTop()
	self:doFinishCallback()
end

function NecrologistStoryTextComp:doFinishCallback()
	local callback = self.finishCallback
	local callbackObj = self.callbackObj

	if callback then
		callback(callbackObj)
	end
end

function NecrologistStoryTextComp:getTypewriterShowText()
	if self:isDone() then
		return self.metaText
	end

	local retText
	local index = self.charIndex
	local char = self.charList[index]
	local tagStackCount = #self.tagStack

	if string.sub(char, 1, 1) == "<" then
		if string.sub(char, 2, 2) ~= "/" then
			table.insert(self.tagStack, char)
		elseif tagStackCount > 0 then
			table.remove(self.tagStack)
		end
	else
		retText = self.curText

		if tagStackCount > 0 then
			if self.tagCount == tagStackCount then
				local ends = ""

				for j = tagStackCount, 1, -1 do
					local tag = self.tagStack[j]

					ends = ends .. string.gsub(tag, "<", "</")
				end

				local len = -string.len(ends) - 1

				retText = string.format("%s%s%s", string.sub(retText, 1, len), char, ends)
			else
				for _, tag in ipairs(self.tagStack) do
					retText = retText .. tag
				end

				retText = retText .. char

				for j = tagStackCount, 1, -1 do
					local tag = self.tagStack[j]

					retText = retText .. string.gsub(tag, "<", "</")
				end
			end
		else
			retText = retText .. char
		end

		self.tagCount = tagStackCount
	end

	self.charIndex = self.charIndex + 1

	return retText
end

function NecrologistStoryTextComp:getUCharArr(ucharStr)
	local ret = {}

	if LuaUtil.isEmptyStr(ucharStr) then
		return ret
	end

	local i = 1
	local len = #ucharStr

	while i <= len do
		if string.sub(ucharStr, i, i) == "<" then
			local tagEnd = string.find(ucharStr, ">", i)

			if tagEnd then
				table.insert(ret, string.sub(ucharStr, i, tagEnd))

				i = tagEnd + 1
			else
				table.insert(ret, string.sub(ucharStr, i, i))

				i = i + 1
			end
		else
			local char = string.sub(ucharStr, i, i)

			if string.byte(char) > 127 then
				local byte = string.byte(char)
				local charLen = 1

				if byte >= 194 and byte <= 223 then
					charLen = 2
				elseif byte >= 224 and byte <= 239 then
					charLen = 3
				elseif byte >= 240 and byte <= 244 then
					charLen = 4
				end

				char = string.sub(ucharStr, i, i + charLen - 1)
				i = i + charLen
			else
				i = i + 1
			end

			table.insert(ret, char)
		end
	end

	return ret
end

function NecrologistStoryTextComp:clearTextTimer()
	self:_setMarksTop(true)
	TaskDispatcher.cancelTask(self._showTypewriterText, self)
end

function NecrologistStoryTextComp:getTextStr()
	return self.curText
end

function NecrologistStoryTextComp:onDestroy()
	FrameTimerController.instance:unregister(self._fTimer)
	self:clearTextTimer()
end

return NecrologistStoryTextComp
