module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114OpenTransitionViewByEventCoWork", package.seeall)

slot0 = class("Activity114OpenTransitionViewByEventCoWork", Activity114OpenTransitionViewWork)

function slot0.getTransitionId(slot0)
	if slot0._transitionId then
		return slot0._transitionId
	end

	if string.nilorempty(slot0.context.eventCo.config.isTransition) then
		return
	end

	slot3 = nil

	if slot0.context.result == Activity114Enum.Result.Success or slot0.context.result == Activity114Enum.Result.FightSucess then
		slot3 = string.splitToNumber(slot1.config.isTransition, "#")[1]
	elseif slot0.context.result == Activity114Enum.Result.Fail then
		slot3 = slot2[2]
	end

	if not slot3 or slot3 == 0 then
		return
	end

	return slot3
end

return slot0
