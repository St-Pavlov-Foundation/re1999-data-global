-- chunkname: @modules/logic/main/controller/work/Activity101SignMonthCardPatFaceWork.lua

module("modules.logic.main.controller.work.Activity101SignMonthCardPatFaceWork", package.seeall)

local Activity101SignMonthCardPatFaceWork = class("Activity101SignMonthCardPatFaceWork", Activity101SignPatFaceWork)

function Activity101SignMonthCardPatFaceWork:checkCanPat()
	local couldGet = V2a9FreeMonthCardModel.instance:isCurDayCouldGet()

	return couldGet
end

return Activity101SignMonthCardPatFaceWork
