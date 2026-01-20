-- chunkname: @modules/logic/store/model/StorePackageGoodsItemListModel.lua

module("modules.logic.store.model.StorePackageGoodsItemListModel", package.seeall)

local StorePackageGoodsItemListModel = class("StorePackageGoodsItemListModel", ListScrollModel)

function StorePackageGoodsItemListModel:setMOList(storeMO, moList, excludeList, notDispatchEmpty)
	local tempList = {}
	local allPreGoodsIdDic = {}

	self._moList = {}

	for _, mo in pairs(moList or {}) do
		if mo.config.preGoodsId then
			allPreGoodsIdDic[mo.config.preGoodsId] = true
		end

		if self:checkShow(mo, true) then
			table.insert(tempList, mo)
		end
	end

	if storeMO then
		local goodsList = storeMO:getGoodsList()

		for _, mo in pairs(goodsList) do
			if mo.config.preGoodsId then
				allPreGoodsIdDic[mo.config.preGoodsId] = true
			end

			if self:checkShow(mo) then
				local goodsMO = StorePackageGoodsMO.New()

				goodsMO:init(storeMO.id, mo.goodsId, mo.buyCount, mo.offlineTime)
				table.insert(tempList, goodsMO)
			end
		end
	end

	local excludeDict = {}

	if excludeList then
		for _, mo in ipairs(excludeList) do
			excludeDict[mo.goodsId] = true
		end
	end

	for i, goodsMO in ipairs(tempList) do
		if not excludeDict[goodsMO.goodsId] and (allPreGoodsIdDic[goodsMO.goodsId] ~= true or (goodsMO.buyLevel > 0 and goodsMO:isSoldOut()) == false) then
			table.insert(self._moList, goodsMO)
		end
	end

	table.sort(self._moList, self._sortFunction)

	local curBuyPackageId = StoreModel.instance:getCurBuyPackageId()

	if #self._moList == 0 and curBuyPackageId == nil and not notDispatchEmpty then
		StoreController.instance:dispatchEvent(StoreEvent.CurPackageListEmpty)
	end

	StoreController.instance:dispatchEvent(StoreEvent.BeforeUpdatePackageStore)
	self:setList(self._moList)
	StoreController.instance:dispatchEvent(StoreEvent.AfterUpdatePackageStore)
end

function StorePackageGoodsItemListModel:checkShow(goodsMO, isChargeGoods)
	isChargeGoods = isChargeGoods or false

	local show = true

	if goodsMO:isSoldOut() then
		if isChargeGoods and goodsMO.refreshTime == StoreEnum.ChargeRefreshTime.Forever then
			show = false
		end

		if isChargeGoods == false and goodsMO.config.refreshTime == StoreEnum.RefreshTime.Forever then
			show = false
		end

		if not show and StoreCharageConditionalHelper.isCharageTaskNotFinish(goodsMO.goodsId) then
			show = true
		end
	end

	if goodsMO.isChargeGoods == false then
		show = show and self:checkPreGoodsId(goodsMO.config.preGoodsId)
	end

	return show
end

function StorePackageGoodsItemListModel:checkPreGoodsId(goodsId)
	if goodsId == 0 then
		return true
	end

	local preGoodsMO = StoreModel.instance:getGoodsMO(goodsId)

	return preGoodsMO and preGoodsMO:isSoldOut()
end

function StorePackageGoodsItemListModel._sortFunction(x, y)
	local xConfig = x.config
	local yConfig = y.config
	local xCanTask = StoreCharageConditionalHelper.isHasCanFinishGoodsTask(x.goodsId)
	local yCanTask = StoreCharageConditionalHelper.isHasCanFinishGoodsTask(y.goodsId)

	if xCanTask ~= yCanTask then
		return xCanTask
	end

	local xSoldOut = x:isSoldOut()
	local ySoldOut = y:isSoldOut()

	if xSoldOut ~= ySoldOut then
		return ySoldOut
	end

	local xIsMothCard = x.goodsId == StoreEnum.MonthCardGoodsId
	local yIsMothCard = y.goodsId == StoreEnum.MonthCardGoodsId

	if xIsMothCard ~= yIsMothCard then
		local isMonthCardDaysEnough = StoreModel.instance:IsMonthCardDaysEnough()

		if isMonthCardDaysEnough then
			return yIsMothCard
		end
	end

	local xLevelOpen = x:isLevelOpen()
	local yLevelOpen = y:isLevelOpen()

	if xLevelOpen ~= yLevelOpen then
		return xLevelOpen
	end

	local xPreGoodsSoldOut = x:checkPreGoodsSoldOut()
	local yPreGoodsSoldOut = y:checkPreGoodsSoldOut()

	if xPreGoodsSoldOut ~= yPreGoodsSoldOut then
		return xPreGoodsSoldOut
	end

	if xConfig.order ~= yConfig.order then
		return xConfig.order < yConfig.order
	end

	local xOrder = StorePackageGoodsItemListModel._getMOOrder(x)
	local yOrder = StorePackageGoodsItemListModel._getMOOrder(y)

	if xOrder ~= yOrder then
		return xOrder < yOrder
	end

	return xConfig.id < yConfig.id
end

function StorePackageGoodsItemListModel._getMOOrder(goodsMO)
	if goodsMO and goodsMO.config then
		if goodsMO.buyCount and goodsMO.buyCount > 0 and goodsMO.config.taskid ~= 0 then
			local condCfg = StoreConfig.instance:getChargeConditionalConfig(goodsMO.config.taskid)

			if condCfg and condCfg.order2 then
				return condCfg.order2
			end
		end

		return goodsMO.config.order
	end

	return -1
end

StorePackageGoodsItemListModel.instance = StorePackageGoodsItemListModel.New()

return StorePackageGoodsItemListModel
