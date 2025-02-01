module("modules.logic.seasonver.act166.controller.Season166HeroGroupController", package.seeall)

slot0 = class("Season166HeroGroupController", BaseController)

function slot0.onOpenViewInitData(slot0, slot1, slot2)
	if Season166Model.instance:getBattleContext() and DungeonConfig.instance:getEpisodeCO(slot3.episodeId) then
		HeroGroupTrialModel.instance:setTrialByBattleId(slot4.battleId)
	end

	Season166HeroGroupEditModel.instance:init(slot1, slot2)
	Season166HeroGroupQuickEditModel.instance:init(slot1, slot2)
end

function slot0.onCloseViewCleanData(slot0)
	slot0:saveCurrentHeroGroup()
end

function slot0.cleanAssistHeroGroup(slot0)
	if not Season166HeroSingleGroupModel.instance.assistMO then
		return
	end

	Season166HeroSingleGroupModel.instance:removeFrom(slot1.id)
	Season166HeroSingleGroupModel.instance:setAssistHeroGroupMO(nil)
end

function slot0.openHeroGroupView(slot0, slot1, slot2)
	if not Season166Model.instance:getBattleContext() then
		return
	end

	Season166HeroGroupModel.instance:setParam(slot1, slot2)
	Season166HeroGroupModel.instance:cleanAssistData()

	HeroGroupModel.instance.battleId = slot1

	Season166HeroSingleGroupModel.instance:setMaxHeroCount(Season166HeroGroupModel.instance:getMaxHeroCountInGroup())
	Season166HeroGroupModel.instance:setCurGroupId(1)
	Season166Controller.instance:openHeroGroupFightView({
		actId = slot3.actId,
		battleId = slot3.battleId,
		episodeId = slot3.episodeId
	})
end

function slot0.checkEquipClothSkill()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return
	end

	if PlayerClothModel.instance:getById(HeroGroupModel.instance:getCurGroupMO().clothId) then
		return
	end

	for slot5, slot6 in ipairs(PlayerClothModel.instance:getList()) do
		if PlayerClothModel.instance:hasCloth(slot6.id) then
			HeroGroupModel.instance:replaceCloth(slot6.id)

			return true
		end
	end
end

function slot0.saveCurrentHeroGroup(slot0)
	if not Season166HeroGroupModel.instance.actId then
		return
	end

	if not Season166Model.instance:getActInfo(slot1) then
		return
	end

	if not Season166HeroGroupModel.instance:getCurGroupMO() then
		return
	end

	if slot3.isHaveTrial then
		return
	end

	slot0:syncHeroGroup(slot3, 1, slot1)
end

function slot0.syncHeroGroup(slot0, slot1, slot2, slot3)
	Season166HeroSingleGroupModel.instance:setSingleGroup(slot1, true)

	if Season166HeroGroupModel.instance:isSeason166BaseSpotEpisode() then
		Season166HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season166Base, Season166Model.instance:getBattleContext().episodeId, true, {
			groupIndex = slot2,
			heroGroup = slot1
		})
	elseif Season166HeroGroupModel.instance:isSeason166TrainEpisode() then
		Season166HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season166Train, slot4.episodeId, true, slot5)
	elseif Season166HeroGroupModel.instance:isSeason166TeachEpisode() then
		Season166HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season166Teach, slot4.episodeId, true, slot5)
	end
end

function slot0.sendStartAct166Battle(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9, slot10, slot11)
	slot12 = Season166HeroGroupModel.instance.actId

	if not (slot3 and lua_episode.configDict[slot3].type) then
		logError("episodeType is nil, episodeId = " .. slot3)

		return
	end

	Activity166Rpc.instance:sendStartAct166BattleRequest(slot12, slot13, slot1, slot4, slot2, slot3, slot5, slot6, slot7, slot8, slot9, slot10, slot11)
end

slot0.instance = slot0.New()

return slot0
