-- chunkname: @modules/logic/season/view3_0/Season3_0FightCardView.lua

module("modules.logic.season.view3_0.Season3_0FightCardView", package.seeall)

local Season3_0FightCardView = class("Season3_0FightCardView", BaseView)

function Season3_0FightCardView:onInitView()
	self._goCardItem = gohelper.findChild(self.viewGO, "mask/Scroll View/Viewport/Content/#go_carditem")

	gohelper.setActive(self._goCardItem, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season3_0FightCardView:addEvents()
	return
end

function Season3_0FightCardView:removeEvents()
	return
end

function Season3_0FightCardView:_editableInitView()
	return
end

function Season3_0FightCardView:onOpen()
	local dataList = Activity104Model.instance:getFightCardDataList()

	if not self.itemList then
		self.itemList = {}
	end

	for i = 1, math.max(#self.itemList, #dataList) do
		local data = dataList[i]
		local item = self.itemList[i] or self:createItem(i)

		self:updateItem(item, data)
	end
end

function Season3_0FightCardView:createItem(index)
	local go = gohelper.cloneInPlace(self._goCardItem, string.format("card%s", index))
	local item = Season3_0FightCardItem.New(go)

	self.itemList[index] = item

	return item
end

function Season3_0FightCardView:updateItem(item, data)
	item:setData(data)
end

function Season3_0FightCardView:destroyItem(item)
	item:destroy()
end

function Season3_0FightCardView:onClose()
	return
end

function Season3_0FightCardView:onDestroyView()
	if self.itemList then
		for k, v in pairs(self.itemList) do
			self:destroyItem(v)
		end

		self.itemList = nil
	end
end

return Season3_0FightCardView
