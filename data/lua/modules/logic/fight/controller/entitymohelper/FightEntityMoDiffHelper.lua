module("modules.logic.fight.controller.entitymohelper.FightEntityMoDiffHelper", package.seeall)

slot0 = _M
slot0.DeepMaxStack = 100
slot1 = {}
slot2 = "entityMo1"
slot3 = "[表现层数据] entityMo2"
slot4 = 0

function slot0.getDiffMsg(slot0, slot1)
	uv0.initGetDiffHandleDict()
	tabletool.clear(uv1)

	uv2 = 0

	for slot5, slot6 in pairs(slot0) do
		if not FightEntityMoCompareHelper.CompareFilterAttrDict[slot5] then
			uv0.diffHandleDict[slot5] or uv0.defaultDiff(slot6, slot1[slot5], slot5)
		end
	end

	return table.concat(uv1, "\n")
end

function slot0.getTypeDiffMsg(slot0, slot1, slot2, slot3, slot4)
	uv0 = uv0 + 1

	table.insert(uv1, string.format([[

[error %s] key : %s, 
%s.%s type is %s, 
%s.%s type is %s]], uv0, slot0, slot1, slot0, slot2, slot3, slot0, slot4))
end

function slot0.getValueDiffMsg(slot0, slot1, slot2, slot3, slot4)
	uv0 = uv0 + 1

	table.insert(uv1, string.format([[

[error %s] key : %s, 
%s.%s = %s, 
%s.%s = %s]], uv0, slot0, slot1, slot0, slot2, slot3, slot0, slot4))
end

function slot0.addDiffMsg(slot0)
	table.insert(uv0, "\n" .. tostring(slot0))
end

function slot0.initGetDiffHandleDict()
	if not uv0.diffHandleDict then
		uv0.diffHandleDict = {
			buffModel = uv0.buffModelDiff,
			_powerInfos = uv0.defaultTableDeepDiff,
			summonedInfo = uv0.summonedInfoDiff
		}
	end
end

function slot0.defaultDiff(slot0, slot1, slot2)
	if slot0 == slot1 then
		return
	end

	if not slot0 or not slot1 then
		uv0.getValueDiffMsg(slot2, uv1, slot0, uv2, slot1)

		return
	end

	if type(slot0) ~= type(slot1) then
		uv0.getTypeDiffMsg(slot2, uv1, slot3, uv2, slot4)

		return
	end

	if slot3 == "table" then
		return uv0.defaultTableDiff(slot0, slot1, slot2)
	end

	if slot0 ~= slot1 then
		uv0.getValueDiffMsg(slot2, uv1, slot0, uv2, slot1)
	end
end

slot0.CompareStatus = {
	CompareFinish = 2,
	WaitCompare = 1
}

function slot0._innerTableDiff(slot0, slot1, slot2)
	if slot0 == slot1 then
		return uv0.CompareStatus.CompareFinish
	end

	if not slot0 or not slot1 then
		uv0.getValueDiffMsg(slot2, uv1, slot0, uv2, slot1)

		return uv0.CompareStatus.CompareFinish
	end

	if type(slot0) ~= type(slot1) then
		uv0.getTypeDiffMsg(slot2, uv1, slot3, uv2, slot4)

		return uv0.CompareStatus.CompareFinish
	end

	return uv0.CompareStatus.WaitCompare
end

function slot0.defaultTableDiff(slot0, slot1, slot2)
	if uv0._innerTableDiff(slot0, slot1, slot2) == uv0.CompareStatus.CompareFinish then
		return
	end

	slot4 = true

	for slot8, slot9 in pairs(slot1) do
		if slot9 ~= slot0[slot8] then
			slot4 = false

			uv0.getValueDiffMsg(slot2 .. slot8, uv1, slot9, uv2, slot0[slot2])
		end
	end

	if not slot4 then
		uv0.addDiffMsg(GameUtil.logTab(slot0))
		uv0.addDiffMsg(GameUtil.logTab(slot1))
	end
end

function slot0.defaultTableDeepDiff(slot0, slot1, slot2, slot3)
	if uv0.DeepMaxStack < (slot3 or 0) then
		logError("stackoverflow")

		return
	end

	if uv0._innerTableDiff(slot0, slot1, slot2) == uv0.CompareStatus.CompareFinish then
		return
	end

	slot5 = true

	for slot9, slot10 in pairs(slot0) do
		if type(slot10) ~= type(slot1[slot9]) then
			slot5 = false

			uv0.getTypeDiffMsg(slot2 .. "." .. slot9, uv1, slot13, uv2, slot14)
		elseif slot13 == "table" then
			uv0.defaultTableDeepDiff(slot10, slot12, slot11, slot3 + 1)
		elseif slot10 ~= slot12 then
			slot5 = false

			uv0.getValueDiffMsg(slot11, uv1, slot10, uv2, slot12)
		end
	end

	if not slot5 then
		uv0.addDiffMsg(GameUtil.logTab(slot0))
		uv0.addDiffMsg(GameUtil.logTab(slot1))
	end
end

function slot0.buffModelDiff(slot0, slot1, slot2)
	if uv0._innerTableDiff(slot0, slot1, slot2) == uv0.CompareStatus.CompareFinish then
		return
	end

	if uv0._innerTableDiff(slot0.getDict and slot0:getDict(), slot1.getDict and slot1:getDict(), slot2 .. "._dict") == uv0.CompareStatus.CompareFinish then
		return
	end

	slot6 = true

	for slot10, slot11 in pairs(slot4) do
		slot12 = slot2 .. "._dict." .. slot10
		slot14, slot15 = FightEntityMoCompareHelper.defaultTableDeepCompare(slot11, slot5[slot10])

		if not slot14 then
			slot6 = false

			if slot15 then
				slot12 = slot12 .. slot15 or slot12
			end

			uv0.getValueDiffMsg(slot12, uv1, GameUtil.logTab(slot11), uv2, GameUtil.logTab(slot13))
		end
	end

	if not slot6 then
		uv0.addDiffMsg(FightLogHelper.getFightBuffDictString(slot4))
		uv0.addDiffMsg(FightLogHelper.getFightBuffDictString(slot5))
	end
end

function slot0.summonedInfoDiff(slot0, slot1, slot2)
	if uv0._innerTableDiff(slot0, slot1, slot2) == uv0.CompareStatus.CompareFinish then
		return
	end

	if uv0._innerTableDiff(slot0.getDataDic and slot0:getDataDic(), slot0.getDataDic and slot1:getDataDic(), slot2 .. ".dataDic") == uv0.CompareStatus.CompareFinish then
		return
	end

	slot6 = true

	for slot10, slot11 in pairs(slot4) do
		if not FightEntityMoCompareHelper.defaultTableDeepCompare(slot11, slot5[slot10]) then
			uv0.getValueDiffMsg(slot2 .. ".dataDic." .. slot10, uv1, GameUtil.logTab(slot11), uv2, GameUtil.logTab(slot13))
		end
	end

	if not slot6 then
		uv0.addDiffMsg(GameUtil.logTab(slot4))
		uv0.addDiffMsg(GameUtil.logTab(slot5))
	end
end

return slot0
