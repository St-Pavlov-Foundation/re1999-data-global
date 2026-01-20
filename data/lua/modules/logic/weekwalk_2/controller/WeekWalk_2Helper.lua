-- chunkname: @modules/logic/weekwalk_2/controller/WeekWalk_2Helper.lua

module("modules.logic.weekwalk_2.controller.WeekWalk_2Helper", package.seeall)

local WeekWalk_2Helper = class("WeekWalk_2Helper")

function WeekWalk_2Helper.setCupIcon(icon, cupInfo)
	local result = cupInfo and cupInfo.result or 0

	UISpriteSetMgr.instance:setWeekWalkSprite(icon, "weekwalkheart_star" .. result)
end

function WeekWalk_2Helper.setCupEffect(go, cupInfo)
	if not go then
		return
	end

	local result = cupInfo and cupInfo.result or WeekWalk_2Enum.CupType.None

	WeekWalk_2Helper.setCupEffectByResult(go, result)
end

function WeekWalk_2Helper.setCupEffectByResult(go, result)
	local transform = go.transform
	local childCount = transform.childCount
	local targetName = "star0" .. result

	for i = 1, childCount do
		local child = transform:GetChild(i - 1)

		gohelper.setActive(child, child.name == targetName)
	end
end

return WeekWalk_2Helper
