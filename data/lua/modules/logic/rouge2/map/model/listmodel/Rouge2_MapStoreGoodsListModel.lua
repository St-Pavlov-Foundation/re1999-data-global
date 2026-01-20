-- chunkname: @modules/logic/rouge2/map/model/listmodel/Rouge2_MapStoreGoodsListModel.lua

module("modules.logic.rouge2.map.model.listmodel.Rouge2_MapStoreGoodsListModel", package.seeall)

local Rouge2_MapStoreGoodsListModel = class("Rouge2_MapStoreGoodsListModel", ListScrollModel)
local DefaultSelectIndex = 1

function Rouge2_MapStoreGoodsListModel:initList(nodeMo)
	self._nodeMo = nodeMo
	self._eventMo = nodeMo.eventMo
	self._stealRateMap = {}

	self:refreshList()
	self:select(DefaultSelectIndex)
end

function Rouge2_MapStoreGoodsListModel:refreshList()
	self._state = self._eventMo:getStoreState()

	local posGoodsList = self._eventMo.posGoodsList or {}

	self:setList(posGoodsList)

	local count = self:getCount()

	if count <= 0 then
		logError(string.format("肉鸽商店商品数量为0!!! nodeId = %s,", self._nodeMo.nodeId, self._nodeMo.eventId))
	end
end

function Rouge2_MapStoreGoodsListModel:getState()
	return self._state or Rouge2_MapEnum.StoreState.Normal
end

function Rouge2_MapStoreGoodsListModel:getSelectGoodsMo()
	local selectGood = self:getByIndex(self._selectIndex)

	return selectGood
end

function Rouge2_MapStoreGoodsListModel:getSelectGoodsIndex()
	return self._selectIndex
end

function Rouge2_MapStoreGoodsListModel:isGoodSelect(index)
	return index == self._selectIndex
end

function Rouge2_MapStoreGoodsListModel:changeState(state)
	self._state = state

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onChangeStoreState, state)
end

function Rouge2_MapStoreGoodsListModel:select(index)
	self:selectCell(index, true)

	self._selectIndex = index

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onSelectStoreGoods, index)
end

function Rouge2_MapStoreGoodsListModel:getStoreState()
	return self._state
end

function Rouge2_MapStoreGoodsListModel:getGoodsState(index)
	return self._eventMo and self._eventMo:getGoodsState(index)
end

function Rouge2_MapStoreGoodsListModel:clear()
	self._state = Rouge2_MapEnum.StoreState.Normal
	self._eventMo = nil
end

function Rouge2_MapStoreGoodsListModel:getRefreshNeedCoin()
	return self._eventMo.refreshNeedCoin or 0
end

function Rouge2_MapStoreGoodsListModel:checkCanRefresh()
	local coin = Rouge2_Model.instance:getCoin()

	return coin >= self:getRefreshNeedCoin()
end

function Rouge2_MapStoreGoodsListModel:getRpcParams()
	local layerId = Rouge2_MapModel.instance:getLayerId()
	local nodeMo = Rouge2_MapModel.instance:getCurNode()
	local nodeId = nodeMo.nodeId
	local eventId = nodeMo.eventId

	return layerId, nodeId, eventId
end

function Rouge2_MapStoreGoodsListModel:getAndMarkStealRate(goodsId, stealRate)
	local oldStealRate = self._stealRateMap and self._stealRateMap[goodsId]

	self._stealRateMap = self._stealRateMap or {}
	self._stealRateMap[goodsId] = stealRate

	return oldStealRate
end

Rouge2_MapStoreGoodsListModel.instance = Rouge2_MapStoreGoodsListModel.New()

return Rouge2_MapStoreGoodsListModel
