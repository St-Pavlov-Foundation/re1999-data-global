-- chunkname: @modules/logic/store/view/decoratemultigoods/DecorateMultiGoodsTipsPayItem.lua

module("modules.logic.store.view.decoratemultigoods.DecorateMultiGoodsTipsPayItem", package.seeall)

local DecorateMultiGoodsTipsPayItem = class("DecorateMultiGoodsTipsPayItem", LuaCompBase)

function DecorateMultiGoodsTipsPayItem:init(go)
	self.go = go
	self._goNormalbg = gohelper.findChild(self.go, "go_Normalbg")
	self._goSelectbg = gohelper.findChild(self.go, "go_Selectbg")
	self._imageIcon = gohelper.findChildImage(self.go, "txt_Desc/simage_Icon")
	self._txtDesc = gohelper.findChildText(self.go, "txt_Desc")
	self._btnPay = gohelper.findChildButtonWithAudio(self.go, "btn_Pay")
	self._isSelect = false
end

function DecorateMultiGoodsTipsPayItem:addEventListeners()
	self._btnPay:AddClickListener(self._btnPayOnClick, self)
end

function DecorateMultiGoodsTipsPayItem:removeEventListeners()
	self._btnPay:RemoveClickListener()
end

function DecorateMultiGoodsTipsPayItem:_btnPayOnClick()
	if self._isSelect then
		return
	end

	StoreController.instance:dispatchEvent(StoreEvent.OnSelectDecoratePayItem, self._index)
end

function DecorateMultiGoodsTipsPayItem:onUpdateMO(costInfo, index, isSelect)
	self._costInfo = costInfo
	self._index = index
	self._isSelect = isSelect

	self:refreshUI()
end

function DecorateMultiGoodsTipsPayItem:refreshUI()
	gohelper.setActive(self._goSelectbg, self._isSelect)
	gohelper.setActive(self._goNormalbg, not self._isSelect)
	SLFramework.UGUI.GuiHelper.SetColor(self._txtDesc, self._isSelect and "#FFFFFF" or "#4C4341")
	self:refreshPayUI()
end

function DecorateMultiGoodsTipsPayItem:refreshPayUI()
	local str = DecorateMultiGoodsTipsPayItem._getCostIcon(self._costInfo)

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageIcon, str)

	local itemCfg, _ = ItemModel.instance:getItemConfigAndIcon(self._costInfo[1], self._costInfo[2], true)

	self._txtDesc.text = itemCfg and itemCfg.name or ""
end

function DecorateMultiGoodsTipsPayItem._getCostIcon(cost)
	local id = 0

	if string.len(cost[2]) == 1 then
		id = cost[1] .. "0" .. cost[2]
	else
		id = cost[1] .. cost[1]
	end

	local str = string.format("%s_1", id)

	return str
end

return DecorateMultiGoodsTipsPayItem
