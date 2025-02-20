module("modules.logic.fight.controller.FightConditionTargetHelper", package.seeall)

slot0 = _M

function slot0.initConditionTargetHandle()
	if not uv0.ConditionTargetHandle then
		uv0.ConditionTargetHandle = {
			[FightEnum.ConditionTarget.Self] = uv0.getSelfConditionTarget
		}
	end
end

function slot0.getTarget(slot0, slot1, slot2)
	uv0.initConditionTargetHandle()

	if uv0.ConditionTargetHandle[slot0] then
		return slot3(slot0, slot1, slot2)
	end

	return slot2
end

function slot0.getSelfConditionTarget(slot0, slot1, slot2)
	return slot1
end

return slot0
