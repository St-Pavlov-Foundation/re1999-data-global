-- chunkname: @modules/logic/voyage/view/ActivityGiftForTheVoyageItemBase.lua

module("modules.logic.voyage.view.ActivityGiftForTheVoyageItemBase", package.seeall)

local ActivityGiftForTheVoyageItemBase = class("ActivityGiftForTheVoyageItemBase", LuaCompBase)

function ActivityGiftForTheVoyageItemBase:init(go)
	self.viewGO = go

	self:onInitView()
	self:addEvents()
end

function ActivityGiftForTheVoyageItemBase:onDestroy()
	self:onDestroyView()
end

function ActivityGiftForTheVoyageItemBase:onUpdateMO(mo)
	self._mo = mo

	self:onRefresh()
end

function ActivityGiftForTheVoyageItemBase:_refreshRewardList(templateGo)
	local mo = self._mo
	local id = mo.id
	local str = VoyageConfig.instance:getRewardStr(id)
	local item_list = ItemModel.instance:getItemDataListByConfigStr(str)

	IconMgr.instance:getCommonPropItemIconList(self, self._onRewardItemShow, item_list, templateGo)
end

function ActivityGiftForTheVoyageItemBase:_onRewardItemShow(cell_component, data, index)
	cell_component:onUpdateMO(data)
	cell_component:setConsume(true)
	cell_component:isShowEffect(true)
	cell_component:setAutoPlay(true)
	cell_component:setCountFontSize(48)
	cell_component:showStackableNum2()
end

function ActivityGiftForTheVoyageItemBase:addEvents()
	return
end

function ActivityGiftForTheVoyageItemBase:removeEvents()
	return
end

function ActivityGiftForTheVoyageItemBase:onRefresh()
	return
end

function ActivityGiftForTheVoyageItemBase:onDestroyView()
	self:removeEvents()
end

return ActivityGiftForTheVoyageItemBase
