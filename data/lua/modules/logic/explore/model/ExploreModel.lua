module("modules.logic.explore.model.ExploreModel", package.seeall)

slot0 = class("ExploreModel", BaseModel)

function slot0.onInit(slot0)
	slot0:clearData()
end

function slot0.reInit(slot0)
	slot0:clearData()

	slot0.isFirstEnterMap = ExploreEnum.EnterMode.Normal
	slot0.isJumpToExplore = false
end

function slot0.clearData(slot0)
	slot0._heroControlDict = {}
	slot0._stepPause = false
	slot0.isReseting = false
	slot0._useItemUid = 0
	slot0.isRoleInitDone = false
	slot0.isShowingResetBoxMessage = false
	slot0.mapId = 0
	slot0.challengeCount = 0
	slot0.unLockAreaIds = {}
	slot0._interactInfosDic = {}

	ExploreCounterModel.instance:reInit()
end

function slot0.isHeroInControl(slot0, slot1)
	if slot1 then
		return not slot0._heroControlDict[slot1]
	end

	return not next(slot0._heroControlDict)
end

function slot0.setHeroControl(slot0, slot1, slot2)
	if slot1 then
		if (slot2 or ExploreEnum.HeroLock.All) == ExploreEnum.HeroLock.All then
			slot0._heroControlDict = {}
		else
			slot0._heroControlDict[slot2] = nil
		end
	else
		slot0._heroControlDict[slot2] = true

		if slot0.isShowingResetBoxMessage then
			slot0.isShowingResetBoxMessage = false

			ViewMgr.instance:closeView(ViewName.MessageBoxView)
		end
	end
end

function slot0.setStepPause(slot0, slot1)
	if slot0._stepPause == slot1 then
		return
	end

	slot0._stepPause = slot1

	if not slot1 then
		ExploreStepController.instance:startStep()
	end
end

function slot0.getStepPause(slot0)
	return slot0._stepPause
end

function slot0.getMapId(slot0)
	return slot0.mapId
end

function slot0.getNowMapEpisodeId(slot0)
	return ExploreConfig.instance:getEpisodeId(slot0.mapId)
end

function slot0.addChallengeCount(slot0)
	slot0.challengeCount = slot0.challengeCount + 1
end

function slot0.getChallengeCount(slot0)
	return slot0.challengeCount
end

function slot0.updateExploreInfo(slot0, slot1)
	slot0:clearData()

	slot2 = slot1.exploreMap
	slot0.mapId = slot2.mapId
	slot0.challengeCount = slot2.challengeCount

	for slot6, slot7 in ipairs(slot2.interacts) do
		slot0:updateInteractInfo(slot7, slot2.mapId)
	end

	for slot6, slot7 in ipairs(slot2.areaIds) do
		slot0.unLockAreaIds[slot7] = true
	end

	ExploreBackpackModel.instance:updateItems(slot1.exploreItems, true)
	ExploreMapModel.instance:updatHeroPos(slot2.posx, slot2.posy, slot2.dir)

	ExploreMapModel.instance.moveNodes = slot2.moveNodes

	slot0:setUseItemUid(slot1.useItemUid)
	ExploreController.instance:dispatchEvent(ExploreEvent.UnitInteractInfoChange)
end

function slot0.updateInteractInfo(slot0, slot1, slot2, slot3)
	slot0:getInteractInfo(slot1.id, slot2 or slot0.mapId):initNO(slot1)

	if slot3 then
		ExploreController.instance:dispatchEvent(ExploreEvent.UnitInteractInfoChange)
	end
end

function slot0.updateInteractStatus(slot0, slot1, slot2, slot3)
	slot0:getInteractInfo(slot2, slot1):updateStatus(slot3)
end

function slot0.updateInteractStatus2(slot0, slot1, slot2, slot3)
	slot0:getInteractInfo(slot2, slot1):updateStatus2(slot3)
end

function slot0.updateInteractStep(slot0, slot1)
	slot0:getInteractInfo(slot1.id, slot1.mapId).step = slot1.step
end

function slot0.getInteractInfo(slot0, slot1, slot2)
	slot2 = slot2 or slot0.mapId
	slot0._interactInfosDic[slot2] = slot0._interactInfosDic[slot2] or {}

	if slot0._interactInfosDic[slot2][slot1] == nil then
		slot3 = ExploreInteractInfoMO.New()

		slot3:init(slot1)

		slot0._interactInfosDic[slot2][slot1] = slot3
	end

	return slot0._interactInfosDic[slot2][slot1]
end

function slot0.hasInteractInfo(slot0, slot1, slot2)
	slot2 = slot2 or slot0.mapId
	slot0._interactInfosDic[slot2] = slot0._interactInfosDic[slot2] or {}

	return slot0._interactInfosDic[slot2][slot1] ~= nil
end

function slot0.getAllInteractInfo(slot0, slot1)
	return slot0._interactInfosDic[slot1 or slot0.mapId]
end

function slot0.getUseItemUid(slot0)
	return slot0._useItemUid
end

function slot0.setUseItemUid(slot0, slot1, slot2)
	slot0._useItemUid = slot1

	if slot0._useItemUid ~= slot0._useItemUid and not slot2 then
		ExploreController.instance:dispatchEvent(ExploreEvent.UseItemChanged, slot0._useItemUid)
	end
end

function slot0.getCarryUnit(slot0)
	if not isTypeOf(ExploreController.instance:getMap():getUnit(tonumber(slot0:getUseItemUid()), true), ExplorePipePotUnit) then
		return nil
	end

	return slot2
end

function slot0.isUseItemOrUnit(slot0, slot1)
	return slot0._useItemUid == slot1 or tonumber(slot0._useItemUid) == slot1
end

function slot0.hasUseItemOrUnit(slot0)
	return slot0._useItemUid ~= 0 and slot0._useItemUid ~= "0"
end

function slot0.isAreaShow(slot0, slot1)
	if not slot1 or slot1 == 0 then
		return true
	end

	return slot0.unLockAreaIds[slot1] or false
end

slot0.instance = slot0.New()

return slot0
