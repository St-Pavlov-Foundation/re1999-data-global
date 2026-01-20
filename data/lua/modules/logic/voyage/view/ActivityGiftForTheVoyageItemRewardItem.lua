-- chunkname: @modules/logic/voyage/view/ActivityGiftForTheVoyageItemRewardItem.lua

module("modules.logic.voyage.view.ActivityGiftForTheVoyageItemRewardItem", package.seeall)

local ActivityGiftForTheVoyageItemRewardItem = class("ActivityGiftForTheVoyageItemRewardItem", LuaCompBase)

function ActivityGiftForTheVoyageItemRewardItem:onInitView()
	self._goitem = gohelper.findChild(self.viewGO, "#go_item")
	self._gohasGet = gohelper.findChild(self.viewGO, "#go_hasGet")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityGiftForTheVoyageItemRewardItem:init(go)
	self.viewGO = go

	self:onInitView()
end

function ActivityGiftForTheVoyageItemRewardItem:_editableInitView()
	gohelper.setActive(self._gohasGet, false)

	self._item = IconMgr.instance:getCommonItemIcon(self._goitem)
end

function ActivityGiftForTheVoyageItemRewardItem:refreshRewardItem(itemCo, isActiveTick)
	local cell_component = self._item

	cell_component:setMOValue(itemCo[1], itemCo[2], itemCo[3], nil, true)
	cell_component:setConsume(true)
	cell_component:isShowEffect(true)
	cell_component:setAutoPlay(true)
	cell_component:setCountFontSize(48)
	cell_component:showStackableNum2()
	cell_component:setGetMask(isActiveTick)
	gohelper.setActive(self._gohasGet, isActiveTick)
end

function ActivityGiftForTheVoyageItemRewardItem:onDestroyView()
	GameUtil.onDestroyViewMemberList(self, "_item")
end

function ActivityGiftForTheVoyageItemRewardItem:onDestroy()
	self:onDestroyView()
end

return ActivityGiftForTheVoyageItemRewardItem
