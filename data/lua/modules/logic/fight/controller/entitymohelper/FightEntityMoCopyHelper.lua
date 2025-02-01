module("modules.logic.fight.controller.entitymohelper.FightEntityMoCopyHelper", package.seeall)

slot0 = _M
slot0.DeepMaxStack = 100
slot0.CopyFilterAttr = {
	isOnlyData = true,
	__cname = true
}

function slot0.copyEntityMo(slot0, slot1)
	uv0.initCopyHandleDict()

	for slot5, slot6 in pairs(slot0) do
		if not uv0.CopyFilterAttr[slot5] then
			uv0.copyHandleDict[slot5] or uv0.defaultCopyHandle(slot0, slot1, slot5)
		end
	end
end

function slot0.initCopyHandleDict()
	if not uv0.copyHandleDict then
		uv0.copyHandleDict = {
			buffModel = uv0.copyBuffModel,
			summonedInfo = uv0.copySummonedInfo
		}
	end
end

function slot0.defaultCopyHandle(slot0, slot1, slot2)
	if type(slot1[slot2]) ~= "table" then
		slot1[slot2] = slot0[slot2]
	else
		uv0.defaultTableCopyHandle(slot0, slot1, slot2)
	end
end

function slot0.defaultTableCopyHandle(slot0, slot1, slot2)
	if not slot0[slot2] then
		slot1[slot2] = nil

		return
	end

	slot1[slot2] = slot1[slot2] or {}

	tabletool.clear(slot1[slot2])

	for slot8, slot9 in pairs(slot3) do
		slot4[slot8] = slot9
	end
end

function slot0.defaultTableDeepCopyHandle(slot0, slot1, slot2)
	if not slot0[slot2] then
		slot1[slot2] = nil

		return
	end

	slot1[slot2] = slot1[slot2] or {}
	slot4 = slot1[slot2]

	tabletool.clear(slot4)
	uv0._innerDeepCopyTable(slot3, slot4)
end

function slot0._innerDeepCopyTable(slot0, slot1, slot2)
	if uv0.DeepMaxStack < (slot2 or 0) then
		logError("stackoverflow")

		return
	end

	for slot6, slot7 in pairs(slot0) do
		if type(slot7) == "table" then
			slot1[slot6] = slot1[slot6] or {}

			tabletool.clear(slot1[slot6])
			uv0._innerDeepCopyTable(slot7, slot1[slot6], slot2 + 1)
		else
			slot1[slot6] = slot7
		end
	end
end

function slot0.copyBuffModel(slot0, slot1, slot2)
	slot1.buffModel = slot1.buffModel or BaseModel.New()

	slot1.buffModel:clear()

	for slot8, slot9 in ipairs(slot0.buffModel:getList()) do
		slot1:addBuff(slot9)
	end
end

function slot0.copySummonedInfo(slot0, slot1, slot2)
	slot3 = slot0.summonedInfo
	slot1.summonedInfo = slot1.summonedInfo or FightEntitySummonedInfo.New()
	slot4 = slot1.summonedInfo
	slot6 = slot3 and slot3.stanceDic

	if not (slot3 and slot3.dataDic) then
		return
	end

	uv0._innerDeepCopyTable(slot5, slot4.dataDic)
	uv0._innerDeepCopyTable(slot6, slot4.stanceDic)
end

return slot0
