-- chunkname: @modules/logic/rouge2/start/view/Rouge2_CareerAttributeItem.lua

module("modules.logic.rouge2.start.view.Rouge2_CareerAttributeItem", package.seeall)

local Rouge2_CareerAttributeItem = class("Rouge2_CareerAttributeItem", LuaCompBase)

Rouge2_CareerAttributeItem.TipPosOffset = Vector2(0, -200)

function Rouge2_CareerAttributeItem:init(go)
	self.go = go
	self._imageProgress = gohelper.findChildImage(self.go, "#image_Progress")
	self._txtValue = gohelper.findChildText(self.go, "#txt_Value")
	self._txtName = gohelper.findChildText(self.go, "#txt_Name")
	self._imageIcon = gohelper.findChildImage(self.go, "#image_Icon")
	self._goSelected = gohelper.findChild(self.go, "#go_Selected")
	self._goRecommand = gohelper.findChild(self.go, "#go_Recommand")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "#btn_Click")
	self._iconPosition = self._imageIcon.transform.position

	self:setUse(false)
	self:onSelect(false)
	self:setCanClickDetail(true)
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnSelectCareerAttribute, self._onSelectCareerAttribute, self)
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnUpdateAttributeInfo, self._onUpdateAttributeInfo, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function Rouge2_CareerAttributeItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function Rouge2_CareerAttributeItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function Rouge2_CareerAttributeItem:_btnClickOnClick()
	if not self._isSelect then
		Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnSelectCareerAttribute, self._attrId)
	end

	if self._isCanClickDetail then
		local clickPos = GamepadController.instance:getMousePosition()

		Rouge2_ViewHelper.openCareerAttributeTipsView(self._careerId, self._attrId, self._attrValue, clickPos, Rouge2_CareerAttributeItem.TipPosOffset, self._tipsClickCallback, self._tipsClickCallbackObj)
	end
end

function Rouge2_CareerAttributeItem:setTipsClickCallback(clickCallback, clickCallbackObj)
	self._tipsClickCallback = clickCallback
	self._tipsClickCallbackObj = clickCallbackObj
end

function Rouge2_CareerAttributeItem:setUsage(usage)
	self._usage = usage
end

function Rouge2_CareerAttributeItem:onUpdateMO(careerId, attrId, attrValue)
	self._careerId = careerId
	self._attrId = attrId
	self._attrValue = attrValue or 0
	self._config = Rouge2_AttributeConfig.instance:getAttributeConfig(attrId)
	self._maxAttrValue = self._config and self._config.showMax or 0
	self._minAttrValue = self._config and self._config.min or 0
	self._attrValueRange = self._maxAttrValue - self._minAttrValue
	self._attrProgress = self._attrValueRange ~= 0 and self._attrValue / self._attrValueRange or 0
	self._txtName.text = self._config and self._config.name
	self._txtValue.text = self._attrValue or ""
	self._imageProgress.fillAmount = self._attrProgress

	Rouge2_IconHelper.setAttributeIcon(self._attrId, self._imageIcon, Rouge2_Enum.AttrIconSuffix.Big)
	self:checkRecommend()
	self:setUse(true)
end

function Rouge2_CareerAttributeItem:checkRecommend()
	local isRecommend = self._careerId and Rouge2_CareerConfig.instance:isAttrRecommend(self._careerId, self._attrId)

	gohelper.setActive(self._goRecommand, isRecommend)
end

function Rouge2_CareerAttributeItem:setUse(isUse)
	self._isUse = isUse

	gohelper.setActive(self.go, isUse)
end

function Rouge2_CareerAttributeItem:isUse()
	return self._isUse
end

function Rouge2_CareerAttributeItem:onSelect(isSelect)
	self._isSelect = isSelect

	gohelper.setActive(self._goSelected, isSelect)
end

function Rouge2_CareerAttributeItem:_onSelectCareerAttribute(attrId)
	if not self._isUse then
		return
	end

	self:onSelect(self._attrId == attrId)
end

function Rouge2_CareerAttributeItem:_onCloseView(viewName)
	if viewName == ViewName.Rouge2_CareerAttributeTipsView then
		self:onSelect(false)
	end
end

function Rouge2_CareerAttributeItem:_onUpdateAttributeInfo()
	return
end

function Rouge2_CareerAttributeItem:setCanClickDetail(isCan)
	self._isCanClickDetail = isCan
end

function Rouge2_CareerAttributeItem:getAttributeId()
	return self._attrId
end

function Rouge2_CareerAttributeItem:isInClickArea(clickPosition)
	return recthelper.screenPosInRect(self._btnClick.transform, nil, clickPosition.x, clickPosition.y)
end

function Rouge2_CareerAttributeItem:onDestory()
	return
end

return Rouge2_CareerAttributeItem
