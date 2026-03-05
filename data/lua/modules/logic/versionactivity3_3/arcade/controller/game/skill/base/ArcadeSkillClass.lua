-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/base/ArcadeSkillClass.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.base.ArcadeSkillClass", package.seeall)

local ArcadeSkillClass = class("ArcadeSkillClass", ArcadeSkillObject)

function ArcadeSkillClass:ctor()
	ArcadeSkillClass.super.ctor(self)

	self._childClassList = {}
	self._childInsIdDict = {}
end

function ArcadeSkillClass:setOwner(owner)
	self.owner = owner

	for _, child in ipairs(self._childClassList) do
		child:setOwner(owner)
	end
end

function ArcadeSkillClass:addChild(child)
	if child and self._childInsIdDict[child:getInstanceID()] then
		self._childInsIdDict[child:getInstanceID()] = child

		table.insert(self._childClassList, child)

		if self._skillBase then
			child:setSkillBase(self._skillBase)
		end
	end
end

function ArcadeSkillClass:setSkillBase(skillBase)
	self._skillBase = skillBase
end

function ArcadeSkillClass:getSkillConfig()
	return self._skillBase and self._skillBase:getSkillConfig()
end

function ArcadeSkillClass:getSkillId()
	return self._skillBase and self._skillBase.skillId
end

function ArcadeSkillClass:getLogPrefixStr()
	return string.format("%s skillId:%s", self.__cname, self:getSkillId())
end

function ArcadeSkillClass:clearTable(data)
	if data and type(data) == "table" then
		for datakey in pairs(data) do
			rawset(data, datakey, nil)
		end
	end
end

function ArcadeSkillClass:clearList(list)
	if list and #list > 0 then
		local len = #list

		for i = len, 1, -1 do
			table.remove(list, i)
		end
	end
end

function ArcadeSkillClass:clearKey()
	return
end

return ArcadeSkillClass
