module("modules.logic.main.controller.work.Activity101SignSpRewardPatFaceWork", package.seeall)

slot0 = class("Activity101SignSpRewardPatFaceWork", Activity101SignPatFaceWork)

function slot0.isType101RewardCouldGetAnyOne(slot0)
	if uv0.super.isType101RewardCouldGetAnyOne(slot0) then
		return true
	end

	return ActivityType101Model.instance:isType101SpRewardCouldGetAnyOne(slot0:_actId())
end

return slot0
