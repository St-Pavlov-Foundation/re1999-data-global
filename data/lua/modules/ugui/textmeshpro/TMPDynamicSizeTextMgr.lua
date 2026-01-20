-- chunkname: @modules/ugui/textmeshpro/TMPDynamicSizeTextMgr.lua

module("modules.ugui.textmeshpro.TMPDynamicSizeTextMgr", package.seeall)

local TMPDynamicSizeTextMgr = class("TMPDynamicSizeTextMgr")

function TMPDynamicSizeTextMgr:ctor()
	return
end

function TMPDynamicSizeTextMgr:init()
	self.csharpInst = ZProj.LangTextDynamicSizeMgr.Instance

	self.csharpInst:SetChangeSizeFunc(self._changeSize, self)
	self.csharpInst:SetFilterRichTextFunc(self._filterRichText, self)
end

function TMPDynamicSizeTextMgr:_changeSize(comp, fontSizeScale, text)
	local arr = string.gmatch(text, "<size=(%d+)>(.+)</size>")

	for size, str in arr do
		local str1 = string.format("<size=%d>%s</size>", size, str)
		local str2 = string.format("<size=%d>%s</size>", size * fontSizeScale, str)

		text = string.gsub(text, str1, str2)
	end

	comp:SetText(text)
end

function TMPDynamicSizeTextMgr:_filterRichText(comp, text)
	comp:FilterRichTextCb(text)
end

TMPDynamicSizeTextMgr.instance = TMPDynamicSizeTextMgr.New()

return TMPDynamicSizeTextMgr
