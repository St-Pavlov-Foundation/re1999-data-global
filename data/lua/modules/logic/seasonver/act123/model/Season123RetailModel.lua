module("modules.logic.seasonver.act123.model.Season123RetailModel", package.seeall)

slot0 = class("Season123RetailModel", BaseModel)

function slot0.release(slot0)
	slot0.lastSendEpisodeCfg = nil
	slot0.rewardIconCfgs = nil
end

function slot0.init(slot0, slot1)
	slot0.activityId = slot1

	slot0:initDatas()
	slot0:initRewards()
end

function slot0.initDatas(slot0)
	if not Season123Model.instance:getActInfo(slot0.activityId) then
		return
	end

	slot0.retailId = slot1.retailId

	if not slot0.retailId then
		return
	end

	slot0.retailCO = Season123Config.instance:getRetailCO(slot0.activityId, slot0.retailId)

	if not slot0.retailCO then
		return
	end

	slot0.episodeCO = DungeonConfig.instance:getEpisodeCO(slot0.retailCO.episodeId)
end

function slot0.initRewards(slot0)
	slot0.rewardIcons = {}
	slot0.rewardIconCfgs = {}

	if not slot0.retailCO then
		return
	end

	slot5 = "#"

	for slot5, slot6 in ipairs(GameUtil.splitString2(slot0.retailCO.bonus, true, "|", slot5)) do
		slot9, slot10 = ItemModel.instance:getItemConfigAndIcon(slot6[1], slot6[2])

		table.insert(slot0.rewardIconCfgs, slot6)
		table.insert(slot0.rewardIcons, slot10)
	end
end

function slot0.getRecommentLevel(slot0)
	if not slot0.episodeCO then
		return nil
	end

	if FightHelper.getBattleRecommendLevel(DungeonConfig.instance:getEpisodeCO(slot0.episodeCO.id).battleId) >= 0 then
		return slot3
	else
		return nil
	end
end

function slot0.getEpisodeId(slot0)
	if not slot0.episodeCO then
		return nil
	end

	return slot0.episodeCO.id
end

function slot0.getRewards(slot0)
	if not slot0.episodeCO then
		return {}
	end
end

function slot0.getUTTUTicketNum(slot0)
	if Season123Config.instance:getEquipItemCoin(slot0.activityId, Activity123Enum.Const.UttuTicketsCoin) then
		return CurrencyModel.instance:getCurrency(slot2) and slot3.quantity or 0
	end

	return 0
end

slot0.instance = slot0.New()

return slot0
