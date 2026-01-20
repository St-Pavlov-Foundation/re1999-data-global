-- chunkname: @modules/logic/rouge2/start/view/Rouge2_CareerCollectionItem.lua

module("modules.logic.rouge2.start.view.Rouge2_CareerCollectionItem", package.seeall)

local Rouge2_CareerCollectionItem = class("Rouge2_CareerCollectionItem", LuaCompBase)

Rouge2_CareerCollectionItem.PercentColor = "#F3A055"
Rouge2_CareerCollectionItem.BracketColor = "#5E7DD9"

function Rouge2_CareerCollectionItem:init(go)
	self.go = go
	self._imagePropIcon = gohelper.findChildSingleImage(self.go, "#image_PropIcon")
	self._txtDescr = gohelper.findChildText(self.go, "#txt_Descr")
	self._txtName = gohelper.findChildText(self.go, "#txt_Name")
end

function Rouge2_CareerCollectionItem:addEventListeners()
	return
end

function Rouge2_CareerCollectionItem:removeEventListeners()
	return
end

function Rouge2_CareerCollectionItem:onUpdateMO(relicsId)
	self._relicsId = relicsId
	self._relicsCo = Rouge2_CollectionConfig.instance:getRelicsConfig(relicsId)

	self:refreshUI()
	self:setUse(true)
end

function Rouge2_CareerCollectionItem:refreshUI()
	self._txtName.text = self._relicsCo and self._relicsCo.name

	Rouge2_IconHelper.setRelicsIcon(self._relicsId, self._imagePropIcon)
	Rouge2_ItemDescHelper.setItemDescStr(Rouge2_Enum.ItemDataType.Config, self._relicsId, self._txtDescr, nil, nil, Rouge2_CareerCollectionItem.PercentColor, Rouge2_CareerCollectionItem.BracketColor)
end

function Rouge2_CareerCollectionItem:setUse(isUse)
	self._isUse = isUse

	gohelper.setActive(self.go, isUse)
end

function Rouge2_CareerCollectionItem:onDestory()
	return
end

return Rouge2_CareerCollectionItem
