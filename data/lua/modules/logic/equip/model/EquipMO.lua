module("modules.logic.equip.model.EquipMO", package.seeall)

slot0 = pureTable("EquipMO")

function slot0.init(slot0, slot1)
	slot0.id = tonumber(slot1.uid)
	slot0.config = EquipConfig.instance:getEquipCo(slot1.equipId)
	slot0._canBreak = nil
	slot0.equipId = slot1.equipId
	slot0.uid = slot1.uid
	slot0.level = slot1.level
	slot0.exp = slot1.exp
	slot0.breakLv = slot1.breakLv
	slot0.count = slot1.count
	slot0.isLock = slot1.isLock
	slot0.refineLv = slot1.refineLv
	slot0.equipType = EquipEnum.ClientEquipType.Normal

	slot0:clearRecommend()
end

function slot0.getBreakLvByLevel(slot0, slot1)
	slot2 = math.huge

	if slot0.config then
		for slot6, slot7 in pairs(lua_equip_break_cost.configDict[slot0.config.rare]) do
			if slot6 < slot2 and slot1 <= slot7.level then
				slot2 = slot6
			end
		end
	else
		slot2 = 0
	end

	return slot2
end

function slot0.initByConfig(slot0, slot1, slot2, slot3, slot4)
	slot1 = slot1 or "-9999999999"
	slot0.id = tonumber(slot1)
	slot0.uid = slot1
	slot0.equipId = slot2
	slot0.level = slot3
	slot0.refineLv = math.max(1, slot4)
	slot0.config = EquipConfig.instance:getEquipCo(slot2)
	slot0.exp = 0
	slot5 = math.huge

	if slot0.config then
		for slot9, slot10 in pairs(lua_equip_break_cost.configDict[slot0.config.rare]) do
			if slot9 < slot5 and slot0.level <= slot10.level then
				slot5 = slot9
			end
		end
	else
		slot5 = 1

		logError("试用角色心相不存在   >>>  " .. tostring(slot0.equipId))
	end

	slot0.breakLv = slot5
	slot0.count = 1
	slot0.isLock = true
	slot0.equipType = EquipEnum.ClientEquipType.Config
end

function slot0.initByTrialCO(slot0, slot1)
	slot0:initByConfig(tostring(-slot1.equipId - 1099511627776.0), slot1.equipId, slot1.equipLv, slot1.equipRefine)

	slot0.equipType = EquipEnum.ClientEquipType.TrialHero
end

function slot0.initByTrialEquipCO(slot0, slot1)
	slot0:initByConfig(tostring(-slot1.id), slot1.equipId, slot1.equipLv, slot1.equipRefine)

	slot0.equipType = EquipEnum.ClientEquipType.TrialEquip
end

function slot0.initOtherPlayerEquip(slot0, slot1)
	slot0:init(slot1)

	slot0.equipType = EquipEnum.ClientEquipType.OtherPlayer
end

function slot0.clone(slot0, slot1)
	slot2 = uv0.New()

	slot2:init(slot0)

	slot2.count = 1
	slot2.id = slot1

	return slot2
end

function slot0.clearRecommend(slot0)
	slot0.recommondIndex = -1
end

return slot0
