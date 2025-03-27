module("modules.logic.versionactivity2_4.pinball.model.PinballModel", package.seeall)

slot0 = class("PinballModel", BaseModel)

function slot0.onInit(slot0)
	slot0._buildingInfo = {}
	slot0._resInfo = {}
	slot0._unlockTalents = {}
	slot0.day = 0
	slot0.restCdDay = 0
	slot0.maxProsperity = 0
	slot0.isGuideAddGrain = false
	slot0.gameAddResDict = {}
	slot0.leftEpisodeId = 0
	slot0.marblesLvDict = {}
	slot0._gmball = 0
	slot0._gmUnlockAll = false
	slot0._gmkey = false
	slot0._talentRedDict = {}
	slot0.guideHole = 1
end

function slot0.reInit(slot0)
	slot0._buildingInfo = {}
	slot0._resInfo = {}
	slot0._unlockTalents = {}
	slot0.day = 0
	slot0.gameAddResDict = {}
end

function slot0.isOpen(slot0)
	return ActivityHelper.getActivityStatus(VersionActivity2_4Enum.ActivityId.Pinball, true) == ActivityEnum.ActivityStatus.Normal
end

function slot0.initData(slot0, slot1)
	slot0.day = slot1.day
	slot0.oper = slot1.oper
	slot0.restCdDay = slot1.restCdDay
	slot0.maxProsperity = slot1.maxProsperity
	slot0.isGuideAddGrain = slot1.isGuideAddGrain
	slot0._buildingInfo = {}
	slot0._resInfo = {}
	slot0._unlockTalents = {}
	slot0.gameAddResDict = {}

	for slot5, slot6 in ipairs(slot1.buildings) do
		slot0._buildingInfo[slot6.index] = PinballBuildingMo.New()

		slot0._buildingInfo[slot6.index]:init(slot6)
	end

	for slot5, slot6 in ipairs(slot1.currencys) do
		slot0._resInfo[slot6.type] = PinballCurrencyMo.New()

		slot0._resInfo[slot6.type]:init(slot6)
	end

	for slot5, slot6 in ipairs(slot1.talentIds) do
		slot7 = PinballTalentMo.New()

		slot7:init(slot6)

		slot0._unlockTalents[slot6] = slot7
	end

	slot0:checkTalentRed()
	PinballController.instance:dispatchEvent(PinballEvent.DataInited)
end

function slot0.unlockTalent(slot0, slot1)
	slot2 = PinballTalentMo.New()

	slot2:init(slot1)

	slot0._unlockTalents[slot1] = slot2

	slot0:checkTalentRed()
end

function slot0.getTalentMo(slot0, slot1)
	return slot0._unlockTalents[slot1]
end

function slot0.getBuildingNum(slot0, slot1)
	for slot6, slot7 in pairs(slot0._buildingInfo) do
		if slot7.baseCo.id == slot1 then
			slot2 = 0 + 1
		end
	end

	return slot2
end

function slot0.onCurrencyChange(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0._resInfo[slot6.type] = slot0._resInfo[slot6.type] or PinballCurrencyMo.New()

		slot0._resInfo[slot6.type]:init(slot6)
	end

	slot0:checkTalentRed()
end

function slot0.getScoreLevel(slot0)
	return PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, slot0:getResNum(PinballEnum.ResType.Score))
end

function slot0.setCurrency(slot0, slot1)
	if not slot0._resInfo[slot1.type] then
		slot0._resInfo[slot1.type] = PinballCurrencyMo.New()
	end

	slot0._resInfo[slot1.type]:init(slot1)
end

function slot0.getResNum(slot0, slot1)
	if not slot0._resInfo[slot1] then
		return 0, 0
	end

	return slot0._resInfo[slot1].num, slot0._resInfo[slot1].changeNum
end

function slot0.getTotalFoodCost(slot0)
	for slot5, slot6 in pairs(slot0._buildingInfo) do
		slot1 = 0 + slot6:getFoodCost()
	end

	return slot1
end

function slot0.getTotalPlayDemand(slot0)
	for slot5, slot6 in pairs(slot0._buildingInfo) do
		slot1 = 0 + slot6:getPlayDemand()
	end

	return math.max(0, slot1 - slot0:getPlayDec())
end

function slot0.getCostDec(slot0)
	for slot5, slot6 in pairs(slot0._unlockTalents) do
		slot1 = 0 + slot6:getCostDec()
	end

	return slot1
end

function slot0.getResAdd(slot0, slot1)
	for slot6, slot7 in pairs(slot0._unlockTalents) do
		slot2 = 0 + slot7:getResAdd(slot1)
	end

	return slot2
end

function slot0.checkTalentRed(slot0)
	slot0._talentRedDict = {}

	for slot4, slot5 in pairs(slot0._buildingInfo) do
		if slot5.baseCo.type == PinballEnum.BuildingType.Talent then
			slot6 = slot5.level
			slot7 = 1

			for slot12, slot13 in pairs(GameUtil.splitString2(slot5.baseCo.effect, true) or {}) do
				if slot13[1] == PinballEnum.BuildingEffectType.UnlockTalent then
					slot7 = slot13[2]

					break
				end
			end

			for slot13, slot14 in pairs(PinballConfig.instance:getTalentCoByRoot(VersionActivity2_4Enum.ActivityId.Pinball, slot7)) do
				if not slot0:getTalentMo(slot14.id) and slot14.needLv <= slot6 then
					slot17 = true

					for slot21, slot22 in pairs(string.splitToNumber(slot14.condition, "#") or {}) do
						if not slot0:getTalentMo(slot22) then
							slot17 = false

							break
						end
					end

					if slot17 and not string.nilorempty(slot14.cost) then
						for slot23, slot24 in pairs(GameUtil.splitString2(slot18, true)) do
							if slot0:getResNum(slot24[1]) < slot24[2] then
								slot17 = false

								break
							end
						end
					end

					if slot17 then
						slot0._talentRedDict[slot5.baseCo.id] = true

						break
					end
				end
			end
		end
	end

	PinballController.instance:dispatchEvent(PinballEvent.TalentRedChange)
end

function slot0.getTalentRed(slot0, slot1)
	return slot0._talentRedDict[slot1] or false
end

function slot0.getPlayDec(slot0)
	for slot5, slot6 in pairs(slot0._unlockTalents) do
		slot1 = 0 + slot6:getPlayDec()
	end

	return slot1
end

function slot0.getMarblesLv(slot0, slot1)
	for slot6, slot7 in pairs(slot0._unlockTalents) do
		slot2 = math.max(slot7:getMarblesLv(slot1), 1)
	end

	return slot2
end

function slot0.getMarblesIsUnlock(slot0, slot1)
	for slot5, slot6 in pairs(slot0._unlockTalents) do
		if slot6:getIsUnlockMarbles(slot1) then
			return true
		end
	end

	return false
end

function slot0.getAllMarblesNum(slot0)
	slot1 = {
		[slot11[1]] = slot11[2]
	}
	slot2 = {}
	slot3 = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.DefaultMarblesHoleNum)
	slot4, slot5 = PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.DefaultMarblesNum)

	for slot10, slot11 in pairs(GameUtil.splitString2(slot5, true) or {}) do
		-- Nothing
	end

	for slot10 = 1, 5 do
		slot1[slot10] = slot1[slot10] or 0

		if slot0:getMarblesIsUnlock(slot10) then
			slot2[slot10] = slot0:getMarblesLv(slot10)
			slot13 = string.splitToNumber(lua_activity178_marbles.configDict[VersionActivity2_4Enum.ActivityId.Pinball][slot10].limit, "#") or {}
			slot1[slot10] = slot1[slot10] + (slot13[slot11] or slot13[#slot13] or 0)
		end
	end

	if slot0._gmUnlockAll then
		for slot10 = 1, 5 do
			slot1[slot10] = 5
			slot2[slot10] = 4
		end
	end

	slot7 = slot3

	if PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintLimit) <= uv0.instance:getResNum(PinballEnum.ResType.Complaint) then
		slot3 = slot3 - PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintMaxSubHoleNum)
	elseif PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintThreshold) <= slot8 then
		slot3 = slot3 - PinballConfig.instance:getConstValue(VersionActivity2_4Enum.ActivityId.Pinball, PinballEnum.ConstId.ComplaintThresholdSubHoleNum)
	end

	slot0.marblesLvDict = slot2

	return slot1, slot3, slot7
end

function slot0.getMarblesLvCache(slot0, slot1)
	return slot0.marblesLvDict[slot1] or 1
end

function slot0.addGameRes(slot0, slot1, slot2)
	slot0.gameAddResDict[slot1] = slot0.gameAddResDict[slot1] or 0
	slot0.gameAddResDict[slot1] = slot0.gameAddResDict[slot1] + slot2

	PinballController.instance:dispatchEvent(PinballEvent.GameResChange)
end

function slot0.getGameRes(slot0, slot1)
	slot2 = 0

	if not slot1 or slot1 == 0 then
		for slot6, slot7 in pairs(slot0.gameAddResDict) do
			slot2 = slot2 + slot7
		end
	else
		slot2 = slot0.gameAddResDict[slot1] or 0
	end

	return slot2
end

function slot0.clearGameRes(slot0)
	slot0.gameAddResDict = {}
end

function slot0.getBuildingInfo(slot0, slot1)
	return slot0._buildingInfo[slot1]
end

function slot0.getBuildingInfoById(slot0, slot1)
	for slot5, slot6 in pairs(slot0._buildingInfo) do
		if slot6.baseCo.id == slot1 then
			return slot6
		end
	end
end

function slot0.getAllTalentBuildingId(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0._buildingInfo) do
		if slot6.baseCo.type == PinballEnum.BuildingType.Talent then
			table.insert(slot1, slot6.baseCo.id)
		end
	end

	table.sort(slot1)

	return slot1
end

function slot0.addBuilding(slot0, slot1, slot2)
	if slot0._buildingInfo[slot2] then
		logError("建筑已存在？？" .. slot2)
	end

	slot0._buildingInfo[slot2] = PinballBuildingMo.New()

	slot0._buildingInfo[slot2]:init({
		food = 0,
		interact = 0,
		level = 1,
		configId = slot1,
		index = slot2
	})
	slot0:checkTalentRed()
	PinballController.instance:dispatchEvent(PinballEvent.AddBuilding, slot2)
end

function slot0.upgradeBuilding(slot0, slot1)
	if not slot0._buildingInfo[slot1] then
		logError("建筑不存在？？" .. slot1)

		return
	end

	slot0._buildingInfo[slot1]:upgrade()
	slot0:checkTalentRed()
	PinballController.instance:dispatchEvent(PinballEvent.UpgradeBuilding, slot1)
end

function slot0.removeBuilding(slot0, slot1)
	if not slot0._buildingInfo[slot1] then
		logError("建筑不存在？？" .. slot1)
	end

	slot0._buildingInfo[slot1] = nil

	PinballController.instance:dispatchEvent(PinballEvent.RemoveBuilding, slot1)
end

slot0.instance = slot0.New()

return slot0
