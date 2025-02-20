module("modules.logic.fight.controller.FightConditionHelper", package.seeall)

slot0 = _M

function slot0.initConditionHandle()
	if not uv0.ConditionHandle then
		uv0.ConditionHandle = {
			[FightEnum.ConditionType.HasBuffId] = uv0.checkHasBuffId
		}
	end
end

function slot0.checkCondition(slot0, slot1, slot2, slot3)
	uv0.initConditionHandle()

	if not lua_skill_behavior_condition.configDict[tonumber(FightStrUtil.splitToNumber(slot0, "#")[1])] then
		return true
	end

	if uv0.ConditionHandle[slot5.type] then
		return slot6(slot4, slot1, slot2, slot3)
	end

	return true
end

function slot0.checkHasBuffId(slot0, slot1, slot2, slot3)
	if not FightConditionTargetHelper.getTarget(slot1, slot2, slot3) then
		return false
	end

	if not FightDataHelper.entityMgr:getById(slot3) then
		return false
	end

	for slot8 = 2, #slot0 do
		if slot4:hasBuffId(tonumber(slot0[slot8])) then
			return true
		end
	end

	return false
end

return slot0
