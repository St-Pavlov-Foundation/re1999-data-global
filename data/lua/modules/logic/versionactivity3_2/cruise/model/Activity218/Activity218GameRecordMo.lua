-- chunkname: @modules/logic/versionactivity3_2/cruise/model/Activity218/Activity218GameRecordMo.lua

module("modules.logic.versionactivity3_2.cruise.model.Activity218.Activity218GameRecordMo", package.seeall)

local Activity218GameRecordMo = pureTable("Activity218GameRecordMo")

function Activity218GameRecordMo:parseJson(str)
	if not string.nilorempty(str) then
		self.dataDic = cjson.decode(str)
	else
		self.dataDic = {}
	end

	self.dataDic.notWinCount = self.dataDic.notWinCount or 0
end

function Activity218GameRecordMo:getNotWinCount()
	return self.dataDic.notWinCount
end

function Activity218GameRecordMo:setNotWinCount(value)
	self.dataDic.notWinCount = value
end

function Activity218GameRecordMo:toJson()
	local str = cjson.encode(self.dataDic)

	return str
end

return Activity218GameRecordMo
