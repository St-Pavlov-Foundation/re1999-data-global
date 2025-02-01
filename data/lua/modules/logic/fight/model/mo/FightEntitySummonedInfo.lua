module("modules.logic.fight.model.mo.FightEntitySummonedInfo", package.seeall)

slot0 = pureTable("FightEntitySummonedInfo")

function slot0.ctor(slot0)
	slot0.stanceDic = {}
	slot0.dataDic = {}
end

function slot0.init(slot0, slot1)
	slot0.stanceDic = {}
	slot0.dataDic = {}

	for slot5, slot6 in ipairs(slot1) do
		slot0:addData(slot6)
	end
end

function slot0.addData(slot0, slot1)
	slot2 = {
		summonedId = slot1.summonedId,
		level = slot1.level,
		uid = slot1.uid,
		fromUid = slot1.fromUid
	}
	slot0.dataDic[slot1.uid] = slot2

	if lua_fight_summoned_stance.configDict[FightConfig.instance:getSummonedConfig(slot2.summonedId, slot2.level).stanceId] then
		slot0.stanceDic[slot4] = slot0.stanceDic[slot4] or {}

		for slot9 = 1, 20 do
			if not slot5["pos" .. slot9] then
				break
			end

			if #slot5["pos" .. slot9] == 0 then
				break
			end

			if not slot0.stanceDic[slot4][slot9] then
				slot0.stanceDic[slot4][slot9] = slot2.uid
				slot2.stanceIndex = slot9

				break
			end
		end
	end

	if not slot2.stanceIndex then
		logError("挂件位置都被占用了,或者坐标数据没有配置,或者位置表找不到id:" .. slot4)

		slot2.stanceIndex = 1
	end

	return slot2
end

function slot0.removeData(slot0, slot1)
	slot2 = slot0:getData(slot1)

	if slot0.stanceDic[FightConfig.instance:getSummonedConfig(slot2.summonedId, slot2.level).stanceId] then
		for slot8, slot9 in pairs(slot0.stanceDic[slot4]) do
			if slot9 == slot1 then
				slot0.stanceDic[slot4][slot8] = nil

				break
			end
		end
	end

	slot0.dataDic[slot1] = nil
end

function slot0.getDataDic(slot0)
	return slot0.dataDic
end

function slot0.getData(slot0, slot1)
	return slot0.dataDic[slot1]
end

function slot0.setLevel(slot0, slot1, slot2)
	if slot0.dataDic[slot1] then
		slot3.level = slot2
	end
end

return slot0
