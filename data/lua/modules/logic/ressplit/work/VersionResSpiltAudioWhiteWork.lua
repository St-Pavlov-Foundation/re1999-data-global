-- chunkname: @modules/logic/ressplit/work/VersionResSpiltAudioWhiteWork.lua

module("modules.logic.ressplit.work.VersionResSpiltAudioWhiteWork", package.seeall)

local VersionResSpiltAudioWhiteWork = class("VersionResSpiltAudioWhiteWork", BaseWork)
local _AuidoFuncType = {
	toNumber = 2,
	splitToNumber = 1
}
local _GameCfgAudioWhiteList = {
	{
		resKey = "roleVoice",
		separation = "|",
		luaName = "lua_room_character",
		funcType = _AuidoFuncType.splitToNumber
	}
}

function VersionResSpiltAudioWhiteWork:onStart(context)
	logError(string.format("VersionResSpiltAudioWhiteWork:onStart(context) =====>"))

	local allAudioDic = AudioConfig.instance:getAudioCO()
	local audioIdWhiteDic = self:_getAuidoIdWhiteListDict() or {}
	local bankEvent2wenDic = context and context.bankEvent2wenDic or {}

	self.bankNameWhiteDic = {}
	self.wenNameWhiteDic = {}

	for audioId, v in pairs(audioIdWhiteDic) do
		local audioCfg = allAudioDic[audioId]

		if audioCfg then
			self.bankNameWhiteDic[audioCfg.bankName] = true

			local eventNap = bankEvent2wenDic[audioCfg.eventName]
			local wenNames = eventNap and eventNap[audioCfg.bankName]

			if wenNames and type(wenNames) == "table" then
				for _, wenName in ipairs(wenNames) do
					self.wenNameWhiteDic[wenName] = true
				end
			end
		end
	end

	self:onDone(true)
end

function VersionResSpiltAudioWhiteWork:_getAuidoIdWhiteListDict()
	local audioIdWhiteDic = {}

	if not self._ToNumberFuncMap then
		self._ToNumberFuncMap = {
			[_AuidoFuncType.splitToNumber] = VersionResSpiltAudioWhiteWork._gameCfgWhiteSplitToNumber,
			[_AuidoFuncType.toNumber] = VersionResSpiltAudioWhiteWork._gameCfgWhiteToNumber
		}
	end

	local whiteCfgList = _GameCfgAudioWhiteList
	local numberFuncMap = self._ToNumberFuncMap

	for i = 1, #whiteCfgList do
		local whiteCfg = whiteCfgList[i]
		local tempLua = _G[whiteCfg.luaName]

		if tempLua and tempLua.configList then
			local cfgList = tempLua.configList

			for _, cfg in ipairs(cfgList) do
				local func = numberFuncMap[whiteCfg.funcType]

				if func then
					func(audioIdWhiteDic, cfg[whiteCfg.resKey], whiteCfg.separation)
				end
			end
		end
	end

	return audioIdWhiteDic
end

function VersionResSpiltAudioWhiteWork._gameCfgWhiteSplitToNumber(whiteDic, res, separation)
	if whiteDic and not string.nilorempty(res) and not string.nilorempty(separation) then
		local nums = string.splitToNumber(res, separation)

		if nums then
			for k, v in ipairs(nums) do
				whiteDic[v] = true
			end
		end
	end
end

function VersionResSpiltAudioWhiteWork._gameCfgWhiteToNumber(whiteDic, value)
	if whiteDic and value then
		whiteDic[tonumber(value)] = true
	end
end

return VersionResSpiltAudioWhiteWork
