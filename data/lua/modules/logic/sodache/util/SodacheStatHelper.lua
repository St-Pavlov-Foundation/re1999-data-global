-- chunkname: @modules/logic/sodache/util/SodacheStatHelper.lua

module("modules.logic.sodache.util.SodacheStatHelper", package.seeall)

local SodacheStatHelper = class("SodacheStatHelper")

function SodacheStatHelper:startEnterFight()
	self.isFightEnter = true
end

function SodacheStatHelper:startStat()
	local isFightEnter = self.isFightEnter

	self.isFightEnter = nil

	if isFightEnter and self.beginDt then
		return
	end

	local _ = SodacheStatEnum

	self.beginDt = ServerTime.now()
end

function SodacheStatHelper:clientEndStat()
	if not self.beginDt then
		return
	end

	SodacheInsideRpc.instance:sendSodacheInsideStatisticGet()
end

function SodacheStatHelper:endStat(msg)
	if not self.beginDt then
		return
	end

	local outSideMo = SodacheModel.instance:getOutsideMo()
	local insideMo = SodacheModel.instance:getInsideMo()

	if not outSideMo or not insideMo then
		return
	end

	self.isFightEnter = nil

	local diffStr = {
		[SodacheEnum.MapType.Simple] = "普通",
		[SodacheEnum.MapType.Hard] = "困难",
		[SodacheEnum.MapType.Rookie] = "新手"
	}
	local resultStr = {
		[0] = "主动返回退出",
		"成功",
		"失败",
		"重置"
	}
	local costTime = ServerTime.now() - self.beginDt

	self.beginDt = nil

	local ticketCo = lua_sodache_tickets.configDict[msg.ticketId]

	StatController.instance:track(StatEnum.EventName.Sodache, {
		[StatEnum.EventProperties.Sodache_Level] = outSideMo.prop.level,
		[StatEnum.EventProperties.Sodache_Difficulty] = diffStr[insideMo.copyCo.type] or tostring(insideMo.copyCo.type),
		[StatEnum.EventProperties.Sodache_TimeSlot] = self:getTimeStr(insideMo),
		[StatEnum.EventProperties.Sodache_Patience] = SodacheUtil.getAttr(SodacheEnum.AttrId.ActionPoint),
		[StatEnum.EventProperties.Sodache_MaterialsList] = self:getBagItemNames(outSideMo:getBag(SodacheEnum.BagType.Inside)),
		[StatEnum.EventProperties.Sodache_Materials] = self:getBagItemList(outSideMo:getBag(SodacheEnum.BagType.Inside)),
		[StatEnum.EventProperties.Sodache_Faith] = SodacheUtil.getAttr(SodacheEnum.AttrId.EvilValue),
		[StatEnum.EventProperties.Sodache_UseTime] = costTime,
		[StatEnum.EventProperties.Sodache_MatchId] = msg.matchId,
		[StatEnum.EventProperties.Sodache_Tickets] = ticketCo and ticketCo.name or tostring(msg.ticketId),
		[StatEnum.EventProperties.Sodache_Skill] = GameUtil.copyArray(msg.skillIds),
		[StatEnum.EventProperties.Sodache_Result] = resultStr[msg.settleType] or tostring(msg.settleType),
		[StatEnum.EventProperties.Sodache_InterruptReason] = msg.settleParam,
		[StatEnum.EventProperties.Sodache_CompletedEventId] = GameUtil.copyArray(msg.completedEventIds),
		[StatEnum.EventProperties.Sodache_WaypointNum] = msg.waypointNum,
		[StatEnum.EventProperties.Sodache_CompletedEventNum] = msg.completedEventNum,
		[StatEnum.EventProperties.Sodache_BuyGoods] = self:parstGoods(msg.buyItems),
		[StatEnum.EventProperties.Sodache_UsedCard] = self:parstCardNames(msg.usedCardIds),
		[StatEnum.EventProperties.Sodache_UsedPatience] = msg.usedPatience,
		[StatEnum.EventProperties.Sodache_EvacuateMaterials] = self:parstRewards(msg.rewards),
		[StatEnum.EventProperties.Sodache_MaterialsValue] = msg.value,
		[StatEnum.EventProperties.Sodache_TotalGoldNum] = msg.value2
	})
end

function SodacheStatHelper:parstCardNames(cardIds)
	local names = {}

	for i, v in ipairs(cardIds) do
		local cardCo = lua_sodache_card.configDict[v]

		if cardCo then
			table.insert(names, cardCo.name)
		end
	end

	return names
end

function SodacheStatHelper:parstGoods(goodsList)
	local goods = {}

	for i, v in ipairs(goodsList) do
		table.insert(goods, {
			id = v.id,
			num = v.count
		})
	end

	return goods
end

function SodacheStatHelper:parstRewards(rewards)
	local items = {}

	for i, v in ipairs(rewards) do
		local arr = GameUtil.rpcInfosToList(v.items, SodacheItemMo)

		for _, vv in ipairs(arr) do
			table.insert(items, {
				id = vv.configId,
				name = vv.itemCo.name,
				num = vv.count
			})
		end
	end

	return items
end

function SodacheStatHelper:getTimeStr(insideMo)
	local cardCo = lua_sodache_card.configDict[insideMo.prop.timeCardId]

	if not cardCo then
		return ""
	end

	return cardCo.name
end

function SodacheStatHelper:getBagItemNames(bagMo)
	local names = {}

	for i, v in ipairs(bagMo.items) do
		if v.itemType == SodacheEnum.ItemType.Card then
			table.insert(names, v.itemCo.name)
		end
	end

	return names
end

function SodacheStatHelper:getBagItemList(bagMo)
	local list = {}

	for i, v in ipairs(bagMo.items) do
		if v.itemType == SodacheEnum.ItemType.Card then
			table.insert(list, {
				id = v.itemCo.id,
				name = v.itemCo.name,
				num = v.count,
				type = v.itemCo.type
			})
		end
	end

	return list
end

SodacheStatHelper.instance = SodacheStatHelper.New()

return SodacheStatHelper
