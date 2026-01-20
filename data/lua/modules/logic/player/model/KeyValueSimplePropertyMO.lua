-- chunkname: @modules/logic/player/model/KeyValueSimplePropertyMO.lua

module("modules.logic.player.model.KeyValueSimplePropertyMO", package.seeall)

local KeyValueSimplePropertyMO = pureTable("KeyValueSimplePropertyMO")

function KeyValueSimplePropertyMO:ctor()
	self._isNumber = true
end

function KeyValueSimplePropertyMO:init(info)
	self.id = info.id
	self.property = info.property
	self._map = {}

	local list = GameUtil.splitString2(info.property, self._isNumber, "|", "#")

	for i, v in ipairs(list) do
		local id = v[1]
		local value = v[2]

		self._map[id] = value
	end
end

function KeyValueSimplePropertyMO:getValue(id, defaultValue)
	return self._map and self._map[id] or defaultValue
end

function KeyValueSimplePropertyMO:setValue(id, state)
	if not self._map then
		self._map = {}
	end

	self._map[id] = state
end

function KeyValueSimplePropertyMO:getString()
	local result = ""

	if not self._map then
		return result
	end

	for k, v in pairs(self._map) do
		local str = string.format("%s#%s", k, v)

		if not string.nilorempty(result) then
			result = result .. "|" .. str
		else
			result = str
		end
	end

	return result
end

return KeyValueSimplePropertyMO
