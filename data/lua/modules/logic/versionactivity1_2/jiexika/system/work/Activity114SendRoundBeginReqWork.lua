module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114SendRoundBeginReqWork", package.seeall)

slot0 = class("Activity114SendRoundBeginReqWork", Activity114ReqBaseWork)

function slot0.onStart(slot0)
	if Activity114Model.instance.serverData.day ~= slot0.context.day or Activity114Model.instance.serverData.round ~= slot0.context.round then
		slot0:onDone(true)

		return
	end

	Activity114Rpc.instance:markRoundStory(Activity114Model.instance.id, slot0.onReply, slot0)
end

function slot0.onReply(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		if Activity114Config.instance:getRoundCo(Activity114Model.instance.id, slot0.context.day, slot0.context.round) and slot4.isSkip == 1 then
			if Activity114Config.instance:getRoundCo(Activity114Model.instance.id, slot0.context.day, slot0.context.round + 1) or Activity114Config.instance:getRoundCo(Activity114Model.instance.id, slot0.context.day + 1, 1) then
				Activity114Model.instance.serverData.day = slot5.day
				Activity114Model.instance.serverData.round = slot5.id
			else
				logError("没有下回合配置？" .. slot0.context.day .. "  #  " .. slot0.context.round)
			end
		else
			Activity114Model.instance.serverData.isReadRoundStory = true
		end
	end

	uv0.super.onReply(slot0, slot1, slot2, slot3)
end

return slot0
