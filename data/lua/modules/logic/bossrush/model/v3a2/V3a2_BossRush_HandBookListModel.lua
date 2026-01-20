-- chunkname: @modules/logic/bossrush/model/v3a2/V3a2_BossRush_HandBookListModel.lua

module("modules.logic.bossrush.model.v3a2.V3a2_BossRush_HandBookListModel", package.seeall)

local V3a2_BossRush_HandBookListModel = class("V3a2_BossRush_HandBookListModel", ListScrollModel)

function V3a2_BossRush_HandBookListModel:setMoList()
	local moList = {}

	for _, mo in pairs(V3a2_BossRushModel.instance:getHandBookMos()) do
		table.insert(moList, mo)
	end

	table.sort(moList, self.sort)
	self:setList(moList)
	self:_onSelectMo(moList[1])
end

function V3a2_BossRush_HandBookListModel.sort(a, b)
	local a_sort = a.config.sort
	local b_sort = b.config.sort

	if a_sort ~= b_sort then
		return a_sort < b_sort
	end

	return a:getBossType() < b:getBossType()
end

function V3a2_BossRush_HandBookListModel:_onSelectMo(mo)
	if not mo then
		return
	end

	local index = self:getIndex(mo)

	self:selectCell(index, true)

	self._selectMo = mo
end

function V3a2_BossRush_HandBookListModel:onSelect(mo)
	self:_onSelectMo(mo)
	BossRushController.instance:dispatchEvent(BossRushEvent.V3a2_BossRush_HandBook_SelectMonster, mo)
end

function V3a2_BossRush_HandBookListModel:getSelectMo()
	return self._selectMo
end

V3a2_BossRush_HandBookListModel.instance = V3a2_BossRush_HandBookListModel.New()

return V3a2_BossRush_HandBookListModel
