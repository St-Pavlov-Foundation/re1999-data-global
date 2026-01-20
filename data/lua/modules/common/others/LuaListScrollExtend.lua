-- chunkname: @modules/common/others/LuaListScrollExtend.lua

module("modules.common.others.LuaListScrollExtend", package.seeall)

local LuaListScrollExtend = class("LuaListScrollExtend", LuaListScrollView)

function LuaListScrollExtend:onUpdateFinish()
	for k, v in pairs(self._cellCompDict) do
		k.parent_view = self

		if k.initDone then
			k:initDone()
		end
	end

	self.isInitDone = true
end

return LuaListScrollExtend
