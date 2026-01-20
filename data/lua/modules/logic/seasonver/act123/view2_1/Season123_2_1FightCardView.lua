-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1FightCardView.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1FightCardView", package.seeall)

local Season123_2_1FightCardView = class("Season123_2_1FightCardView", BaseView)

function Season123_2_1FightCardView:onInitView()
	self._goCardItem = gohelper.findChild(self.viewGO, "mask/Scroll View/Viewport/Content/#go_carditem")

	gohelper.setActive(self._goCardItem, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_1FightCardView:addEvents()
	return
end

function Season123_2_1FightCardView:removeEvents()
	return
end

function Season123_2_1FightCardView:_editableInitView()
	return
end

function Season123_2_1FightCardView:onOpen()
	local dataList = Season123Model.instance:getFightCardDataList()

	if not self.itemList then
		self.itemList = {}
	end

	for i = 1, math.max(#self.itemList, #dataList) do
		local data = dataList[i]
		local item = self.itemList[i] or self:createItem(i)

		self:updateItem(item, data)
	end
end

function Season123_2_1FightCardView:createItem(index)
	local go = gohelper.cloneInPlace(self._goCardItem, string.format("card%s", index))
	local item = Season123_2_1FightCardItem.New(go)

	self.itemList[index] = item

	return item
end

function Season123_2_1FightCardView:updateItem(item, data)
	item:setData(data)
end

function Season123_2_1FightCardView:destroyItem(item)
	item:destroy()
end

function Season123_2_1FightCardView:onClose()
	return
end

function Season123_2_1FightCardView:onDestroyView()
	if self.itemList then
		for k, v in pairs(self.itemList) do
			self:destroyItem(v)
		end

		self.itemList = nil
	end
end

return Season123_2_1FightCardView
