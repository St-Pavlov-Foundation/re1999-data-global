module("modules.logic.fight.controller.entitymohelper.FightEntityMoCompareHelper", package.seeall)

slot0 = _M
slot0.DeepMaxStack = 100
slot0.CompareFilterAttrDict = {
	stanceDic = true,
	playCardExPoint = true,
	buffFeaturesSplit = true,
	_playCardAddExpoint = true,
	isOnlyData = true,
	_last_clone_mo = true,
	moveCardExPoint = true,
	passiveSkillDic = true,
	_combineCardAddExpoint = true,
	custom_refreshNameUIOp = true,
	stanceIndex = true,
	__cname = true,
	skillList = true,
	_moveCardAddExpoint = true
}

function slot0.compareEntityMo(slot0, slot1)
	uv0.initCompareHandleDict()

	for slot5, slot6 in pairs(slot0) do
		if not uv0.CompareFilterAttrDict[slot5] and not uv0.compareHandleDict[slot5] or uv0.defaultTableDeepCompare(slot6, slot1[slot5]) then
			return false
		end
	end

	return true
end

function slot0.initCompareHandleDict()
	if not uv0.compareHandleDict then
		uv0.compareHandleDict = {
			buffModel = uv0.defaultTableDeepCompare,
			_powerInfos = uv0.defaultTableDeepCompare,
			summonedInfo = uv0.summonedInfoCompare,
			attrMO = uv0.attrMoCompare
		}
	end
end

function slot0.defaultCompare(slot0, slot1)
	if slot0 == slot1 then
		return true
	end

	if not slot0 or not slot1 then
		return false
	end

	if type(slot0) ~= type(slot1) then
		return false
	end

	if slot2 == "table" then
		return uv0.defaultTableCompare(slot0, slot1)
	end

	return slot0 == slot1
end

slot0.CompareStatus = {
	CompareFinish = 2,
	WaitCompare = 1
}

function slot0._innerTableCompare(slot0, slot1)
	if slot0 == slot1 then
		return uv0.CompareStatus.CompareFinish, true
	end

	if not slot0 or not slot1 then
		return uv0.CompareStatus.CompareFinish, false
	end

	if type(slot0) ~= type(slot1) then
		return uv0.CompareStatus.CompareFinish, false
	end

	return uv0.CompareStatus.WaitCompare, true
end

function slot0.defaultTableCompare(slot0, slot1)
	slot2, slot3 = uv0._innerTableCompare(slot0, slot1)

	if slot2 == uv0.CompareStatus.CompareFinish then
		return slot3
	end

	for slot7, slot8 in pairs(slot1) do
		if not uv0.CompareFilterAttrDict[slot7] and slot8 ~= slot0[slot7] then
			return false
		end
	end

	return true
end

function slot0.defaultTableDeepCompare(slot0, slot1, slot2, slot3)
	if uv0.DeepMaxStack < (slot2 or 0) then
		logError("stackoverflow")

		return true, slot3
	end

	slot4, slot5 = uv0._innerTableCompare(slot0, slot1)

	if slot4 == uv0.CompareStatus.CompareFinish then
		return slot5, slot3
	end

	for slot9, slot10 in pairs(slot0) do
		if not uv0.CompareFilterAttrDict[slot9] then
			if type(slot10) ~= type(slot1[slot9]) then
				return false, slot3 and slot3 .. slot9 or slot9
			end

			if slot13 == "table" then
				slot15, slot11 = uv0.defaultTableDeepCompare(slot10, slot12, slot2 + 1, slot11)

				if not slot15 then
					return false, slot11
				end
			elseif slot10 ~= slot12 then
				return false, slot11
			end
		end
	end

	return true
end

function slot0.summonedInfoCompare(slot0, slot1)
	slot2, slot3 = uv0._innerTableCompare(slot0, slot1)

	if slot2 == uv0.CompareStatus.CompareFinish then
		return slot3
	end

	return uv0.defaultTableDeepCompare(slot0.getDataDic and slot0:getDataDic(), slot1.getDataDic and slot1:getDataDic())
end

function slot0.attrMoCompare(slot0, slot1)
	slot2, slot3 = uv0._innerTableCompare(slot0, slot1)

	if slot2 == uv0.CompareStatus.CompareFinish then
		return slot3
	end

	if slot0.hp ~= slot1.hp then
		return false
	end

	if slot0.multiHpIdx ~= slot1.multiHpIdx then
		return false
	end

	if slot0.multiHpNum ~= slot1.multiHpNum then
		return false
	end

	return true
end

return slot0
