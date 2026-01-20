-- chunkname: @modules/logic/sp01/act204/model/Activity204MileStoneListModel.lua

module("modules.logic.sp01.act204.model.Activity204MileStoneListModel", package.seeall)

local Activity204MileStoneListModel = class("Activity204MileStoneListModel", MixScrollModel)
local startSpace = 21

function Activity204MileStoneListModel:init(actMo)
	self.actMo = actMo
end

function Activity204MileStoneListModel:refresh()
	local list = Activity204Config.instance:getMileStoneList(self.actMo.id)
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

function Activity204MileStoneListModel:caleProgressIndex()
	local list = Activity204Config.instance:getMileStoneList(self.actMo.id)
	local index = 0
	local currencyId = Activity204Config.instance:getConstNum(Activity204Enum.ConstId.CurrencyId)
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

function Activity204MileStoneListModel:getMaxMileStoneValue()
	local count = self:getCount()

	for i = count, 1, -1 do
		local mo = self:getByIndex(i)
		local actMo = Activity204Model.instance:getById(mo.activityId)

		if actMo and not mo.isLoopBonus then
			return actMo:getMilestoneValue(mo.rewardId)
		end
	end

	return 0
end

function Activity204MileStoneListModel:getInfoList(scrollGO)
	self._mixCellInfo = {}

	local list = self:getList()

	for i, mo in ipairs(list) do
		local rewards = GameUtil.splitString2(mo.bonus, true)
		local rewardCount = rewards and #rewards or 0
		local width = rewardCount * 215
		local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(i, width, i)

		table.insert(self._mixCellInfo, mixCellInfo)
	end

	return self._mixCellInfo
end

function Activity204MileStoneListModel:getItemPosX(index)
	if index <= 0 then
		return 0
	end

	local posX = startSpace
	local cellWidth = 0

	for i = 1, index - 1 do
		posX = posX + self:getItemWidth(i)
	end

	local lastItemWidth = self:getItemWidth(index)

	posX = posX + cellWidth / 2 + lastItemWidth / 2

	return posX
end

function Activity204MileStoneListModel:getItemWidth(index)
	if not index then
		return 0
	end

	local cellInfo = self._mixCellInfo and self._mixCellInfo[index]

	return cellInfo and cellInfo.lineLength or 0
end

function Activity204MileStoneListModel:getItemFocusPosX(index)
	local itemWidth = self:getItemWidth(index - 1)
	local focusPosX = self:getItemPosX(index - 1) + itemWidth / 2

	return focusPosX
end

Activity204MileStoneListModel.instance = Activity204MileStoneListModel.New()

return Activity204MileStoneListModel
