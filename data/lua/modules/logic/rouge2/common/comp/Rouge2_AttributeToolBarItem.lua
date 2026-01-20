-- chunkname: @modules/logic/rouge2/common/comp/Rouge2_AttributeToolBarItem.lua

module("modules.logic.rouge2.common.comp.Rouge2_AttributeToolBarItem", package.seeall)

local Rouge2_AttributeToolBarItem = class("Rouge2_AttributeToolBarItem", LuaCompBase)

Rouge2_AttributeToolBarItem.TipPosOffset = Vector2(0, 450)

function Rouge2_AttributeToolBarItem:init(go)
	self.go = go
	self._imageIcon = gohelper.findChildImage(self.go, "#image_Icon")
	self._txtValue = gohelper.findChildText(self.go, "#txt_Value")
	self._goRecommend = gohelper.findChild(self.go, "#go_Recommand")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "#btn_Click")
	self._animator = gohelper.onceAddComponent(self.go, gohelper.Type_Animator)
	self._goLoopEffect = gohelper.findChild(self.go, "#effect/loop")
end

function Rouge2_AttributeToolBarItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.onLightAttr, self._onLightAttr, self)
end

function Rouge2_AttributeToolBarItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function Rouge2_AttributeToolBarItem:_btnClickOnClick()
	local clickPos = GamepadController.instance:getMousePosition()

	Rouge2_ViewHelper.openCareerAttributeTipsView(self._careerId, self._attrId, self._attrValue, clickPos, Rouge2_AttributeToolBarItem.TipPosOffset)
end

function Rouge2_AttributeToolBarItem:refresh(index, careerId, attributeMo)
	self._index = index
	self._careerId = careerId
	self._mo = attributeMo
	self._attrId = attributeMo.attrId
	self._attrValue = attributeMo.value

	local recommendIds = Rouge2_CareerConfig.instance:getCareerRecommendAttributeIds(self._careerId)

	self._isRecommend = recommendIds and tabletool.indexOf(recommendIds, self._attrId)

	self:refreshUI()
end

function Rouge2_AttributeToolBarItem:refreshUI()
	self._txtValue.text = self._attrValue or 0

	gohelper.setActive(self._goRecommend, self._isRecommend)
	Rouge2_IconHelper.setAttributeIcon(self._attrId, self._imageIcon)
end

function Rouge2_AttributeToolBarItem:_onLightAttr(lightAttrIdList)
	local isLight = lightAttrIdList and tabletool.indexOf(lightAttrIdList, self._attrId) ~= nil

	gohelper.setActive(self._goLoopEffect, isLight)

	if isLight then
		self._animator:Play("click", 0, 0)
	end
end

function Rouge2_AttributeToolBarItem:onDestroy()
	return
end

return Rouge2_AttributeToolBarItem
