module("modules.logic.critter.model.CritterMO", package.seeall)

slot0 = pureTable("CritterMO")
slot1 = {}

function slot0.ctor(slot0)
	slot0.id = 0
	slot0.uid = 0
	slot0.defineId = 0
	slot0.createTime = 0
	slot0.efficiency = 0
	slot0.patience = 0
	slot0.lucky = 0
	slot0.efficiencyIncrRate = 0
	slot0.patienceIncrRate = 0
	slot0.luckyIncrRate = 0
	slot0.currentMood = 0
	slot0.specialSkin = false
	slot0.lock = false
	slot0.finishTrain = false
	slot0.trainInfo = CritterTrainInfoMO.New()
	slot0.skillInfo = CritterSkillInfoMO.New()
	slot0.workInfo = CritterWorkInfoMO.New()
	slot0.restInfo = CritterRestInfoMO.New()
	slot0.tagAttributeRates = nil
	slot0.isHighQuality = false
	slot0.trainHeroId = 0
	slot0.totalFinishCount = 0
end

function slot0.init(slot0, slot1)
	slot1 = slot1 or uv0
	slot0.id = slot1.uid or 0
	slot0.uid = slot1.uid or 0
	slot0.defineId = slot1.defineId or 0
	slot0.createTime = slot1.createTime or 0
	slot0.efficiency = slot1.efficiency or 0
	slot0.patience = slot1.patience or 0
	slot0.lucky = slot1.lucky or 0
	slot0.efficiencyIncrRate = slot1.efficiencyIncrRate or 0
	slot0.patienceIncrRate = slot1.patienceIncrRate or 0
	slot0.luckyIncrRate = slot1.luckyIncrRate or 0
	slot0.currentMood = slot1.currentMood or 0
	slot0.specialSkin = slot1.specialSkin == true
	slot0.lock = slot1.lock == true
	slot0.finishTrain = slot1.finishTrain == true
	slot0.isHighQuality = slot1.isHighQuality == true
	slot0.trainHeroId = slot1.trainHeroId or 0
	slot0.totalFinishCount = slot1.totalFinishCount or 0
	slot0.name = slot1.name or ""

	slot0.trainInfo:init(slot1.trainInfo or uv0)
	slot0.skillInfo:init(slot1.skillInfo or uv0)
	slot0.workInfo:init(slot1.workInfo or uv0)
	slot0.restInfo:init(slot1.restInfo or uv0)

	slot0.tagAttributeRates = {}

	if slot1.tagAttributeRates then
		for slot5 = 1, #slot1.tagAttributeRates do
			slot6 = slot1.tagAttributeRates[slot5]
			slot0.tagAttributeRates[slot6.attributeId] = slot6.rate
		end
	end

	slot0:initAttributeInfo()

	slot2 = slot0:getDefineCfg()
	slot0.trainInfo.trainTime = slot0:getTainTime()

	slot0.trainInfo:setCritterMO(slot0)
end

function slot0.getId(slot0)
	return slot0.id
end

function slot0.getDefineId(slot0)
	return slot0.defineId
end

function slot0.refreshCfg(slot0)
	slot0:getDefineCfg()
end

function slot0.getTainTime(slot0)
	if slot0:getDefineCfg() then
		return slot1.trainTime * 60 * 60
	end

	return 0
end

function slot0.getDefineCfg(slot0)
	if not slot0.config or slot0.config.id ~= slot0.defineId then
		slot0.config = CritterConfig.instance:getCritterCfg(slot0.defineId)
	end

	return slot0.config
end

function slot0.getSkinId(slot0)
	if slot0:isMutate() then
		return slot0:getDefineCfg().mutateSkin
	else
		return slot1.normalSkin
	end

	return 0
end

function slot0.isCultivating(slot0)
	if slot0.trainInfo.heroId and slot0.trainInfo.heroId ~= 0 and slot0.finishTrain ~= true then
		return true
	end
end

function slot0.getWorkBuildingInfo(slot0)
	return slot0.workInfo:getBuildingInfo()
end

function slot0.getCultivator(slot0)
	return slot0.trainInfo.heroId
end

function slot0.getCultivateProcess(slot0)
	return slot0.trainInfo:getProcess()
end

function slot0.isMutate(slot0)
	return slot0.specialSkin == true
end

function slot0.getAttributeInfos(slot0)
	return slot0.attributeInfo
end

function slot0.getAttributeInfoByType(slot0, slot1)
	return slot0:getAttributeInfos() and slot2[slot1]
end

function slot0.getAddValuePerHourByType(slot0, slot1)
	if not (slot0.trainInfo:getEventOptions(CritterEnum.NormalEventId.NormalGrow) and slot2[1]) then
		return 0
	end

	return slot3:getAddAttriuteInfoById(slot1) and slot4.value or 0
end

function slot0.initAttributeInfo(slot0)
	slot0.attributeInfo = {}
	slot1 = 10000
	slot2 = CritterAttributeInfoMO.New()
	slot3 = CritterEnum.AttributeType.Efficiency

	slot2:init({
		attributeId = slot3,
		value = slot0.efficiency * slot1,
		rate = slot0.efficiencyIncrRate,
		addRate = slot0.tagAttributeRates[slot3]
	})

	slot0.attributeInfo[slot3] = slot2
	slot5 = CritterAttributeInfoMO.New()
	slot6 = CritterEnum.AttributeType.Patience

	slot5:init({
		attributeId = slot6,
		value = slot0.patience * slot1,
		rate = slot0.patienceIncrRate,
		addRate = slot0.tagAttributeRates[slot6]
	})

	slot0.attributeInfo[slot6] = slot5
	slot8 = CritterAttributeInfoMO.New()
	slot9 = CritterEnum.AttributeType.Lucky

	slot8:init({
		attributeId = slot9,
		value = slot0.lucky * slot1,
		rate = slot0.luckyIncrRate,
		addRate = slot0.tagAttributeRates[slot9]
	})

	slot0.attributeInfo[slot9] = slot8
end

function slot0.getAdditionAttr(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0:getAttributeInfos()) do
		if slot6:getIsAddition() then
			table.insert(slot1, slot5)
		end
	end

	return slot1
end

function slot0.isAddition(slot0, slot1)
	slot2 = false

	if slot0:getAttributeInfoByType(slot1) then
		slot2 = slot3:getIsAddition()
	end

	return slot2
end

function slot0.getTotalAttrValue(slot0)
	return slot0.efficiency + slot0.patience + slot0.lucky
end

function slot0.getMoodValue(slot0)
	return math.ceil((slot0.currentMood or 0) / CritterEnum.MoodFactor)
end

function slot0.isNoMood(slot0)
	return slot0:getMoodValue() <= 0
end

function slot0.isNoMoodWorking(slot0)
	slot1 = false

	if ManufactureModel.instance:getCritterWorkingBuilding(slot0.uid) or RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(slot0.uid) then
		slot1 = true
	end

	return slot1 and slot0:isNoMood()
end

function slot0.isLock(slot0)
	return slot0.lock
end

function slot0.getIsHighQuality(slot0)
	return slot0.isHighQuality
end

function slot0.getSkillInfo(slot0)
	return slot0.skillInfo:getTags()
end

function slot0.isMaturity(slot0)
	return slot0.finishTrain
end

function slot0.getName(slot0)
	if not string.nilorempty(slot0.name) then
		return slot0.name
	end

	return slot0:getDefineCfg().name
end

function slot0.getCatalogueName(slot0)
	return CritterConfig.instance:getCritterCatalogueCfg(slot0:getDefineCfg().catalogue) and slot3.name or ""
end

function slot0.getDesc(slot0)
	return slot0:getDefineCfg().desc
end

return slot0
