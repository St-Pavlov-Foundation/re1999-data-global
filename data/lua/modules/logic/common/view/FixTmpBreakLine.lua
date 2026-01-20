-- chunkname: @modules/logic/common/view/FixTmpBreakLine.lua

module("modules.logic.common.view.FixTmpBreakLine", package.seeall)

local FixTmpBreakLine = class("FixTmpBreakLine", LuaCompBase)
local Type_LangFont = typeof(ZProj.LangFont)
local needIgnoreLang = {
	"en",
	"de",
	"fr",
	"thai"
}

function FixTmpBreakLine:initData(txtComp)
	self.textMeshPro = txtComp.gameObject:GetComponent(typeof(TMPro.TextMeshProUGUI))

	if self.textMeshPro then
		self.textMeshPro.richText = true
	end
end

function FixTmpBreakLine:refreshTmpContent(txtComp)
	for _, lang in pairs(needIgnoreLang) do
		if GameConfig:GetCurLangShortcut() == lang then
			return
		end
	end

	if not txtComp then
		return
	end

	self:initData(txtComp)

	local content = self.textMeshPro.text

	if not self:startsWith(content, "<nobr>") then
		content = string.format("<nobr>%s", content)
	end

	local gameLangFont = GameGlobalMgr.instance:getLangFont()

	gameLangFont:refreshFontAsset(self.textMeshPro)

	content = self:replaceContent(content)
	self.textMeshPro.text = content

	self.textMeshPro:Rebuild(UnityEngine.UI.CanvasUpdate.PreRender)
end

function FixTmpBreakLine:replaceContent(content)
	local spaceCount = 0
	local result = ""
	local char = ""
	local isInTag = false

	for i = 1, #content do
		char = string.sub(content, i, i)

		if char == "<" then
			isInTag = true
		elseif char == ">" then
			isInTag = false
		end

		if not isInTag and char == " " then
			spaceCount = spaceCount + 1
		else
			if spaceCount > 0 then
				result = result .. "<space=" .. spaceCount * ZProj.GameHelper.GetTmpCharWidth(self.textMeshPro, 32) .. ">"
				spaceCount = 0
			end

			result = result .. char
		end
	end

	return result
end

function FixTmpBreakLine:startsWith(content, str)
	return string.sub(content, 1, string.len(str)) == str
end

return FixTmpBreakLine
