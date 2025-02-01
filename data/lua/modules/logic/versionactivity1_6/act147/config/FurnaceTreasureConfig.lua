module("modules.logic.versionactivity1_6.act147.config.FurnaceTreasureConfig", package.seeall)

slot0 = class("FurnaceTreasureConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"activity147",
		"activity147_goods"
	}
end

function slot0.onInit(slot0)
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot0[string.format("%sConfigLoaded", slot1)] then
		slot4(slot0, slot2)
	end
end

function slot1(slot0, slot1)
	if not (lua_activity147 and lua_activity147.configDict[slot0] or nil) and slot1 then
		logError(string.format("FurnaceTreasureConfig.getAct147Cfg error, cfg is nil, id:%s", slot0))
	end

	return slot2
end

function slot0.getDescList(slot0, slot1)
	slot2 = {}

	if uv0(slot1, true) then
		slot2 = string.split(slot3.descList, "|")
	end

	return slot2
end

function slot0.getRewardList(slot0, slot1)
	slot2 = {}

	if uv0(slot1, true) then
		slot2 = ItemModel.instance:getItemDataListByConfigStr(slot3.rewardList)
	end

	return slot2
end

function slot0.getSpineRes(slot0, slot1)
	slot2 = nil

	if uv0(slot1, true) then
		slot2 = slot3.spineRes
	end

	return slot2
end

function slot0.getDialogList(slot0, slot1)
	slot2 = {}

	if uv0(slot1, true) then
		slot2 = string.split(slot3.dialogs, "|")
	end

	return slot2
end

function slot0.getJumpId(slot0, slot1)
	slot2 = 0

	if uv0(slot1, true) then
		slot2 = slot3.jumpId
	end

	return slot2
end

function slot2(slot0, slot1)
	slot2 = nil
	slot3 = FurnaceTreasureModel.instance:getActId()

	if lua_activity147_goods and lua_activity147_goods.configDict[slot3] then
		slot2 = lua_activity147_goods.configDict[slot3][slot0]
	end

	if not slot2 and slot1 then
		logError(string.format("FurnaceTreasureConfig.get147GoodCfg error, cfg is nil, actId:%s,goodsId:%s", slot3, slot0))
	end

	return slot2
end

function slot0.get147GoodsCost(slot0, slot1)
	slot2 = nil

	if uv0(slot1, true) then
		slot2 = slot3.cost
	end

	return slot2
end

function slot0.getAct147GoodsShowItem(slot0, slot1)
	slot2 = 0
	slot3 = 0
	slot4 = 0

	if slot1 and FurnaceTreasureEnum.Pool2GoodsId[slot1] or nil then
		slot2 = string.splitToNumber(slot5, "#")[1] or 0
		slot3 = slot6[2] or 0
		slot4 = slot6[3] or 0
	else
		logError(string.format("FurnaceTreasureConfig:getAct147GoodsShowItem error, can't get strShowItem, poolId:%s", slot1))
	end

	return slot2, slot3, slot4
end

slot0.instance = slot0.New()

return slot0
