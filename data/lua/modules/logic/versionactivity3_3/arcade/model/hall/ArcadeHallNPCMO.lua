-- chunkname: @modules/logic/versionactivity3_3/arcade/model/hall/ArcadeHallNPCMO.lua

module("modules.logic.versionactivity3_3.arcade.model.hall.ArcadeHallNPCMO", package.seeall)

local ArcadeHallNPCMO = class("ArcadeHallNPCMO", ArcadeHallInteractiveMO)

function ArcadeHallNPCMO:ctor(id)
	ArcadeHallNPCMO.super.ctor(self, id)

	self._talkGroupCoList = ArcadeConfig.instance:getTalkGroupCfg(self.id)
	self._totalWeight = {}

	for _, co in pairs(self._talkGroupCoList) do
		local condition = co.condition

		if not self._totalWeight[condition] then
			self._totalWeight[condition] = 0
		end

		self._totalWeight[condition] = self._totalWeight[condition] + co.weight
	end
end

function ArcadeHallNPCMO:getTalkGroupId(condition)
	if not self._talkGroupCoList then
		return
	end

	local random = math.random(1, self._totalWeight[condition] or 100)

	for _, co in pairs(self._talkGroupCoList) do
		if co.condition == condition then
			if random <= co.weight then
				return co.groupId
			else
				random = random - co.weight
			end
		end
	end
end

function ArcadeHallNPCMO:getGroupStepCoList(groupId)
	if not self._groupStepCoList then
		self._groupStepCoList = {}
	end

	local coList = self._groupStepCoList[groupId]

	if coList then
		return coList
	end

	coList = {}

	local coDict = ArcadeConfig.instance:getTalkStepGroupCfg(groupId)

	if not coDict then
		return coList
	end

	for _, stepCo in pairs(coDict) do
		table.insert(coList, stepCo)
	end

	table.sort(coList, function(a, b)
		return a.step < b.step
	end)

	self._groupStepCoList[groupId] = coList

	return coList
end

function ArcadeHallNPCMO:getStepContentInfo(groupId, stepId)
	if not self._stepContentDict then
		self._stepContentDict = {}
	end

	local lang = LangSettings.instance:getCurLang() or -1

	if not self._stepContentDict[lang] then
		self._stepContentDict[lang] = {}
	end

	if not self._stepContentDict[lang][groupId] then
		self._stepContentDict[lang][groupId] = {}
	end

	local stepContentDict = self._stepContentDict[lang][groupId][stepId]
	local coList = self:getGroupStepCoList(groupId)

	if not coList or not coList[stepId] then
		return
	end

	local stepCo = coList[stepId]

	if stepContentDict then
		return stepContentDict, stepCo
	end

	stepContentDict = {}
	self._stepContentDict[lang][groupId][stepId] = stepContentDict

	local content = stepCo.content

	if string.nilorempty(content) then
		return content
	end

	self:_matchContentColor(content, stepContentDict)

	return stepContentDict, stepCo
end

function ArcadeHallNPCMO:_matchContentColor(content, list)
	if LuaUtil.isEmptyStr(content) then
		return
	end

	local startIndex, endIndex = string.find(content, "</color>")
	local lastCharArr = list[#list] or ""

	if not startIndex then
		local list3 = LuaUtil.getUCharArrWithLineFeed(content)

		for _, charArr in ipairs(list3) do
			local arr = lastCharArr .. charArr

			table.insert(list, arr)

			lastCharArr = arr
		end

		return
	end

	local content1 = string.sub(content, 0, endIndex)
	local m1, m2, m3 = string.match(content1, "(.-)<color=(.-)>(.-)</color>")
	local list1 = LuaUtil.getUCharArrWithLineFeed(m1)

	for _, charArr in ipairs(list1) do
		local arr = lastCharArr .. charArr

		table.insert(list, arr)

		lastCharArr = arr
	end

	local list2 = LuaUtil.getUCharArrWithLineFeed(m3)
	local _lastCharArr = ""

	for _, charArr in ipairs(list2) do
		local arr = string.format("%s<color=%s>%s%s</color>", lastCharArr, m2, _lastCharArr, charArr)

		table.insert(list, arr)

		_lastCharArr = _lastCharArr .. charArr
	end

	if not endIndex then
		return
	end

	local content2 = string.sub(content, endIndex + 1, #content)

	self:_matchContentColor(content2, list)
end

return ArcadeHallNPCMO
