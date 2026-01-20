-- chunkname: @modules/logic/versionactivity2_5/act186/model/Activity186MileStoneListModel.lua

module("modules.logic.versionactivity2_5.act186.model.Activity186MileStoneListModel", package.seeall)

local Activity186MileStoneListModel = class("Activity186MileStoneListModel", MixScrollModel)

function Activity186MileStoneListModel:init(actMo)
	self.actMo = actMo
end

function Activity186MileStoneListModel:refresh()
	local list = Activity186Config.instance:getMileStoneList(self.actMo.id)
	local dataList = {}

	for i, v in ipairs(list) do
		local mo = {}

		mo.id = v.rewardId
		mo.rewardId = v.rewardId
		mo.activityId = v.activityId
		mo.isLoopBonus = v.isLoopBonus
		mo.bonus = v.bonus
		mo.isSpBonus = v.isSpBonus

		table.insert(dataList, mo)
	end

	self:setList(dataList)
end

function Activity186MileStoneListModel:caleProgressIndex()
	local list = Activity186Config.instance:getMileStoneList(self.actMo.id)
	local index = 0
	local currencyId = Activity186Config.instance:getConstNum(Activity186Enum.ConstId.CurrencyId)
	local hasCurrencyNum = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, currencyId)
	local lastCoinNum = 0

	for i, v in ipairs(list) do
		local coinNum = v.coinNum

		if hasCurrencyNum < coinNum then
			index = i + (hasCurrencyNum - lastCoinNum) / (coinNum - lastCoinNum) - 1

			return index
		end

		lastCoinNum = coinNum
	end

	local listLen = #list

	lastCoinNum = list[listLen - 1] and list[listLen - 1].coinNum or 0

	local loopConfig = list[listLen]
	local progress = self.actMo.getMilestoneProgress
	local loopNum = loopConfig.loopBonusIntervalNum or 1
	local coinNum = loopConfig.coinNum

	if progress < coinNum then
		index = listLen
	else
		local canGetTimesValue = (hasCurrencyNum - coinNum) / loopNum
		local canGetTimes = math.floor(canGetTimesValue)
		local getTimes = math.floor((progress - coinNum) / loopNum)

		if getTimes < canGetTimes then
			index = listLen
		else
			index = listLen - 1 + canGetTimesValue - canGetTimes
		end
	end

	return index
end

Activity186MileStoneListModel.instance = Activity186MileStoneListModel.New()

return Activity186MileStoneListModel
