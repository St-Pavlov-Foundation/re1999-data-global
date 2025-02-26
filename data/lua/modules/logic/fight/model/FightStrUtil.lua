slot0 = class("FightStrUtil")
slot1 = "true"
slot2 = "false"

function slot0.ctor(slot0)
end

function slot0.split(slot0, slot1)
	slot0 = tostring(slot0)

	if tostring(slot1) == "" then
		return false
	end

	slot3 = {}

	for slot7, slot8 in function ()
		return string.find(uv0, uv1, uv2, true)
	end, nil,  do
		table.insert(slot3, string.sub(slot0, 0, slot7 - 1))

		slot2 = slot8 + 1
	end

	table.insert(slot3, string.sub(slot0, slot2))

	return slot3
end

function slot0.splitToNumber(slot0, slot1)
	slot6 = slot1

	for slot6, slot7 in ipairs(uv0.split(slot0, slot6)) do
		-- Nothing
	end

	return {
		[slot6] = tonumber(slot7)
	}
end

function slot0.splitString2(slot0, slot1, slot2, slot3)
	if string.nilorempty(slot0) then
		return
	end

	for slot8, slot9 in ipairs(uv0.split(slot0, slot2 or "|")) do
		if slot1 then
			slot4[slot8] = uv0.splitToNumber(slot9, slot3 or "#")
		else
			slot4[slot8] = uv0.split(slot9, slot3)
		end
	end

	return slot4
end

function slot0.init(slot0)
	slot0.inited = true
end

function slot0.getSplitCache(slot0, slot1, slot2)
	slot0:logNoInFight()

	slot3 = tostring(slot2)

	if not slot0._splitCache then
		slot0._splitCache = {}
	end

	if not slot0._splitCache[slot3] then
		slot0._splitCache[slot3] = {}
	end

	if not slot0._splitCache[slot3][tostring(slot1)] then
		slot4[slot5] = slot0.split(slot1, slot2)
	end

	return slot4[slot5]
end

function slot0.getSplitToNumberCache(slot0, slot1, slot2)
	slot0:logNoInFight()

	slot3 = tostring(slot2)

	if not slot0._splitToNumberCache then
		slot0._splitToNumberCache = {}
	end

	if not slot0._splitToNumberCache[slot3] then
		slot0._splitToNumberCache[slot3] = {}
	end

	if not slot0._splitToNumberCache[slot3][tostring(slot1)] then
		slot4[slot5] = slot0.splitToNumber(slot1, slot2)
	end

	return slot4[slot5]
end

function slot0.getSplitString2Cache(slot0, slot1, slot2, slot3, slot4)
	slot0:logNoInFight()

	if string.nilorempty(slot1) then
		return
	end

	slot3 = slot3 or "|"
	slot4 = slot4 or "#"
	slot5 = slot2 and uv0 or uv1

	if not slot0._splitString2Cache then
		slot0._splitString2Cache = {}
	end

	if not slot0._splitString2Cache[slot5] then
		slot0._splitString2Cache[slot5] = {}
	end

	if not slot0._splitString2Cache[slot5][slot3] then
		slot0._splitString2Cache[slot5][slot3] = {}
	end

	if not slot0._splitString2Cache[slot5][slot3][slot4] then
		slot0._splitString2Cache[slot5][slot3][slot4] = {}
	end

	if not slot0._splitString2Cache[slot5][slot3][slot4][tostring(slot1)] then
		slot6[slot7] = slot0.splitString2(slot1, slot2, slot3, slot4)
	end

	return slot6[slot7]
end

function slot0.logNoInFight(slot0)
	if not slot0.inited and GameUtil.needLogInOtherSceneUseFightStrUtilFunc() then
		logError("不在战斗内，不要调用`FightStrUtil`相关接口")
	end
end

function slot0.dispose(slot0)
	slot0.inited = nil

	if slot0._splitCache then
		slot0._splitCache = nil
	end

	if slot0._splitToNumberCache then
		slot0._splitToNumberCache = nil
	end

	if slot0._splitString2Cache then
		slot0._splitString2Cache = nil
	end
end

slot0.instance = slot0.New()

return slot0
