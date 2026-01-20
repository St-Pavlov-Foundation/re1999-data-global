-- chunkname: @modules/logic/resonance/model/TalentStyle/TalentStyleMo.lua

module("modules.logic.resonance.model.TalentStyle.TalentStyleMo", package.seeall)

local TalentStyleMo = class("TalentStyleMo")

function TalentStyleMo:ctor()
	self._styleCo = nil
	self._orginId = nil
	self._replaceId = nil
	self._styleId = nil
	self._isUse = false
	self._isSelect = false
	self._isNew = false
	self._isUnlock = false
	self._unlockPercent = 0
	self._hotUnlockStyle = nil
end

function TalentStyleMo:setMo(co, orginId, replaceId)
	self._styleCo = co
	self._orginId = orginId
	self._replaceId = replaceId
	self._styleId = co.styleId
end

function TalentStyleMo:isCanUnlock(heroLevel)
	local unlockLevel = self._styleCo and self._styleCo.level and self._styleCo.level or 0

	return unlockLevel <= heroLevel
end

function TalentStyleMo:onRefresh(useId, selectId, isUnlock)
	self._isUse = useId == self._styleId
	self._isSelect = selectId == self._styleId
	self._isUnlock = isUnlock
end

function TalentStyleMo:setShowInfo()
	return
end

function TalentStyleMo:getStyleTag()
	local curLang = LangSettings.instance:getCurLang()

	if self._lastLangId ~= curLang then
		self._tagStr = nil
		self._name = nil
		self._lastLangId = curLang
	end

	if not self._name then
		self._name = self._styleCo.name
	end

	if string.nilorempty(self._tagStr) then
		local tag = self._styleCo.tag

		self._tagStr = ""

		if not string.nilorempty(tag) then
			local split = string.splitToNumber(tag, "#")

			for _, v in ipairs(split) do
				local co = lua_character_attribute.configDict[v]
				local t = co and co.name or luaLang("talent_style_special_tag_" .. v)

				if string.nilorempty(self._tagStr) then
					self._tagStr = t
				else
					self._tagStr = string.format("%s    %s", self._tagStr, t)
				end
			end
		end
	end

	return self._name, self._tagStr
end

function TalentStyleMo:getStyleTagIcon()
	if not self._growTagIcon or not self._nomalTagIcon then
		local tagicon = self._styleCo.tagicon

		if tagicon then
			local numIcon = tonumber(tagicon)

			if numIcon and numIcon < 10 then
				tagicon = "0" .. numIcon
			end

			self._growTagIcon = "fg_" .. tagicon
			self._nomalTagIcon = "fz_" .. tagicon
		end
	end

	return self._growTagIcon, self._nomalTagIcon
end

function TalentStyleMo:setNew(isNew)
	self._isNew = isNew and self._styleId ~= 0
end

function TalentStyleMo:setUnlockPercent(percent)
	self._unlockPercent = percent
end

function TalentStyleMo:getUnlockPercent()
	return self._unlockPercent or 0
end

function TalentStyleMo:setHotUnlockStyle(isHot)
	self._hotUnlockStyle = isHot
end

function TalentStyleMo:isHotUnlock()
	return self._hotUnlockStyle
end

return TalentStyleMo
