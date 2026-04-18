-- chunkname: @modules/logic/main/view/skininteraction/waitvoiceparams/MultiGroupWaitVoiceParams.lua

module("modules.logic.main.view.skininteraction.waitvoiceparams.MultiGroupWaitVoiceParams", package.seeall)

local MultiGroupWaitVoiceParams = class("MultiGroupWaitVoiceParams", BaseWaitVoiceParams)

function MultiGroupWaitVoiceParams:init(list)
	self._voiceGroup1 = string.splitToNumber(list[2], "#")
	self._voiceGroup2 = string.splitToNumber(list[3], "#")
end

function MultiGroupWaitVoiceParams:isWaitVoice(audio)
	return audio == self._voiceGroup1[2] or audio == self._voiceGroup2[2]
end

function MultiGroupWaitVoiceParams:_randomConfig(config, group)
	if group[1] > 100 then
		logError("voice group weight error: " .. tostring(group[1]), config.audio)
	end

	local groupConfig
	local random = math.random(1, 100)

	if random <= group[1] then
		groupConfig = lua_character_voice.configDict[config.heroId][group[2]]
	else
		groupConfig = lua_character_voice.configDict[config.heroId][group[3]]
	end

	if not groupConfig then
		logError("voice group config error: " .. tostring(group[2]) .. "," .. tostring(group[3]), config.audio)

		return config
	end

	return groupConfig
end

function MultiGroupWaitVoiceParams:selectFromGroup(config)
	if config.audio == self._voiceGroup1[2] then
		return self:_randomConfig(config, self._voiceGroup1)
	elseif config.audio == self._voiceGroup2[2] then
		return self:_randomConfig(config, self._voiceGroup2)
	end

	logError("MultiGroupWaitVoiceParams:selectFromGroup error audioId:", config.audio)

	return config
end

function MultiGroupWaitVoiceParams:onDestroy()
	return
end

return MultiGroupWaitVoiceParams
