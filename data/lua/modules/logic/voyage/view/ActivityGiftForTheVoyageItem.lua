-- chunkname: @modules/logic/voyage/view/ActivityGiftForTheVoyageItem.lua

module("modules.logic.voyage.view.ActivityGiftForTheVoyageItem", package.seeall)

local ActivityGiftForTheVoyageItem = class("ActivityGiftForTheVoyageItem", ActivityGiftForTheVoyageItemBase)

function ActivityGiftForTheVoyageItem:onInitView()
	self._txttaskdesc = gohelper.findChildText(self.viewGO, "#txt_taskdesc")
	self._gotxttaskdesc1 = gohelper.findChild(self.viewGO, "#go_txt_taskdesc1")
	self._gotxttaskdesc2 = gohelper.findChild(self.viewGO, "#go_txt_taskdesc2")
	self._gotxttaskdesc3 = gohelper.findChild(self.viewGO, "#go_txt_taskdesc3")
	self._txttaskdesc_client = gohelper.findChildText(self.viewGO, "#txt_taskdesc_client")
	self._goline = gohelper.findChild(self.viewGO, "#go_line")
	self._scrollRewards = gohelper.findChildScrollRect(self.viewGO, "#scroll_Rewards")
	self._goRewards = gohelper.findChild(self.viewGO, "#scroll_Rewards/Viewport/#go_Rewards")
	self._goitem = gohelper.findChild(self.viewGO, "#scroll_Rewards/Viewport/#go_Rewards/#go_Item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityGiftForTheVoyageItem:addEvents()
	return
end

function ActivityGiftForTheVoyageItem:removeEvents()
	return
end

function ActivityGiftForTheVoyageItem:onRefresh()
	local mo = self._mo
	local id = mo.id
	local state = VoyageModel.instance:getStateById(id)

	gohelper.setActive(self._gotxttaskdesc1, id > 0 and state == VoyageEnum.State.Got)
	gohelper.setActive(self._gotxttaskdesc2, id > 0 and state == VoyageEnum.State.Available)
	gohelper.setActive(self._gotxttaskdesc3, id > 0 and state == VoyageEnum.State.None)

	self._txttaskdesc.text = id > 0 and mo.desc or ""
	self._txttaskdesc_client.text = id > 0 and "" or mo.desc

	self:_refreshRewards()

	self._scrollRewards.horizontalNormalizedPosition = 0
end

function ActivityGiftForTheVoyageItem:_onRewardItemShow(cell_component, data, index)
	ActivityGiftForTheVoyageItem.super._onRewardItemShow(self, cell_component, data, index)
	cell_component:setGetMask(true)
end

function ActivityGiftForTheVoyageItem:setActiveLine(bool)
	gohelper.setActive(self._goline, bool)
end

function ActivityGiftForTheVoyageItem:_isGot()
	local mo = self._mo
	local id = mo.id
	local state = VoyageModel.instance:getStateById(id)

	return state == VoyageEnum.State.Got
end

function ActivityGiftForTheVoyageItem:_createItemList()
	if self._itemList then
		return
	end

	local mo = self._mo
	local id = mo.id

	gohelper.setActive(self._goitem, true)

	self._itemList = {}

	local rewardStrList = VoyageConfig.instance:getRewardStrList(id)

	for _, rewardStr in ipairs(rewardStrList) do
		local itemCo = string.splitToNumber(rewardStr, "#")
		local item = self:_createRewardItem(ActivityGiftForTheVoyageItemRewardItem)

		table.insert(self._itemList, item)
		item:refreshRewardItem(itemCo, self:_isGot())
	end

	gohelper.setActive(self._goitem, false)
end

function ActivityGiftForTheVoyageItem:_createRewardItem(class)
	local go = gohelper.cloneInPlace(self._goitem, class.__name)

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, class)
end

function ActivityGiftForTheVoyageItem:_refreshRewards()
	self:_createItemList()
end

function ActivityGiftForTheVoyageItem:onDestroyView()
	GameUtil.onDestroyViewMemberList(self, "_itemList")
end

return ActivityGiftForTheVoyageItem
