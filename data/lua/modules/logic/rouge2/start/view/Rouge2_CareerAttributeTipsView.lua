-- chunkname: @modules/logic/rouge2/start/view/Rouge2_CareerAttributeTipsView.lua

module("modules.logic.rouge2.start.view.Rouge2_CareerAttributeTipsView", package.seeall)

local Rouge2_CareerAttributeTipsView = class("Rouge2_CareerAttributeTipsView", BaseView)

Rouge2_CareerAttributeTipsView.SafeArea = Vector2(0, 200)

function Rouge2_CareerAttributeTipsView:onInitView()
	self._goRoot = gohelper.findChild(self.viewGO, "#go_Root")
	self._goMark = gohelper.findChild(self.viewGO, "#go_Mark")
	self._goFlag = gohelper.findChild(self.viewGO, "#go_Mark/#go_Flag")
	self._scrolloverview = gohelper.findChildScrollRect(self.viewGO, "#go_Root/#scroll_overview")
	self._goArrow = gohelper.findChild(self.viewGO, "#go_Root/#scroll_overview/arrow")
	self._imageIcon = gohelper.findChildImage(self.viewGO, "#go_Root/#scroll_overview/Viewport/Content/Title/#image_Icon")
	self._txtCareer = gohelper.findChildText(self.viewGO, "#go_Root/#scroll_overview/Viewport/Content/Title/txt_Career")
	self._txtNum = gohelper.findChildText(self.viewGO, "#go_Root/#scroll_overview/Viewport/Content/Title/#txt_Num")
	self._goContent = gohelper.findChild(self.viewGO, "#go_Root/#scroll_overview/Viewport")
	self._goDescList = gohelper.findChild(self.viewGO, "#go_Root/#scroll_overview/Viewport/Content/#go_DescList")
	self._goDescItem = gohelper.findChild(self.viewGO, "#go_Root/#scroll_overview/Viewport/Content/#go_DescList/#go_DescItem")
	self._goSpDescList = gohelper.findChild(self.viewGO, "#go_Root/#scroll_overview/Viewport/Content/#go_SpDescList")
	self._goSpDescItem = gohelper.findChild(self.viewGO, "#go_Root/#scroll_overview/Viewport/Content/#go_SpDescList/#go_SpDescItem")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._txtCareerDesc = gohelper.findChildText(self.viewGO, "#go_Root/#scroll_overview/Viewport/Content/CareerDesc/#txt_CareerDesc")
	self._transform = self.viewGO.transform
	self._tranRoot = self._goRoot.transform
	self._tranMark = self._goMark.transform
	self._tranFlag = self._goFlag.transform

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_CareerAttributeTipsView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._scrolloverview:AddOnValueChanged(self._refreshArrow, self)
end

function Rouge2_CareerAttributeTipsView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._scrolloverview:RemoveOnValueChanged()
end

function Rouge2_CareerAttributeTipsView:_refreshArrow()
	gohelper.setActive(self._goMark, self._scrolloverview.verticalNormalizedPosition > 0.01)
end

function Rouge2_CareerAttributeTipsView:_editableInitView()
	local width = recthelper.getWidth(self._scrolloverview.transform) + Rouge2_CareerAttributeTipsView.SafeArea.x
	local height = recthelper.getHeight(self._scrolloverview.transform) + Rouge2_CareerAttributeTipsView.SafeArea.y

	recthelper.setSize(self._tranFlag, width, height)

	local scrollPosX, scrollPosY = recthelper.getAnchor(self._scrolloverview.transform)

	recthelper.setAnchor(self._tranFlag, scrollPosX, scrollPosY)

	width = recthelper.getWidth(self._tranRoot)
	height = recthelper.getHeight(self._tranRoot)

	recthelper.setSize(self._tranMark, width, height)
end

function Rouge2_CareerAttributeTipsView:onOpen()
	self:refreshParams()
	self:refreshUI()
	self:updatePosition()
end

function Rouge2_CareerAttributeTipsView:onUpdateParam()
	self:refreshParams()
	self:refreshUI()
	self:updatePosition()
end

function Rouge2_CareerAttributeTipsView:refreshParams()
	self._careerId = self.viewParam and self.viewParam.careerId
	self._attrId = self.viewParam and self.viewParam.attributeId
	self._attrValue = self.viewParam and self.viewParam.attributeValue
	self._pos = self.viewParam and self.viewParam.pos or Vector2.zero
	self._offset = self.viewParam and self.viewParam.offset or Vector2.zero
	self._attrCo = Rouge2_AttributeConfig.instance:getAttributeConfig(self._attrId)
	self._clickCallback = self.viewParam and self.viewParam.clickCallback
	self._clickCallbackObj = self.viewParam and self.viewParam.clickCallbackObj
end

function Rouge2_CareerAttributeTipsView:refreshUI()
	Rouge2_IconHelper.setAttributeIcon(self._attrId, self._imageIcon)

	self._txtNum.text = self._attrValue or 0
	self._txtCareer.text = self._attrCo and self._attrCo.name
	self._txtCareerDesc.text = self._attrCo and self._attrCo.careerDesc
	self._passiveSkillList = Rouge2_AttributeConfig.instance:getPassiveSkillDescList(self._careerId, self._attrId, self._attrValue)
	self._spPassiveSkillList = Rouge2_AttributeConfig.instance:getCareerPassiveSkillList_Sp(self._careerId, self._attrId) or {}

	gohelper.CreateObjList(self, self._refreshPassiveSkillDesc, self._passiveSkillList, self._goDescList, self._goDescItem)
	gohelper.CreateObjList(self, self._refreshSpPassiveSkillDesc, self._spPassiveSkillList, self._goSpDescList, self._goSpDescItem)
end

function Rouge2_CareerAttributeTipsView:_refreshPassiveSkillDesc(obj, desc, index)
	local txtDesc = gohelper.findChildText(obj, "txt_Descr")

	txtDesc.text = SkillHelper.buildDesc(desc)

	SkillHelper.addHyperLinkClick(txtDesc)
end

function Rouge2_CareerAttributeTipsView:_refreshSpPassiveSkillDesc(obj, skillCo, index)
	local txtDesc = gohelper.findChildText(obj, "txt_Descr")
	local imLevelUpDescStr = Rouge2_AttributeConfig.instance:getPassiveSkillImLevelUpDesc(skillCo.id, skillCo.level)
	local result = GameUtil.getSubPlaceholderLuaLangThreeParam(luaLang("rouge2_effecttips2"), skillCo.level, self._attrCo.name, imLevelUpDescStr)

	txtDesc.text = SkillHelper.buildDesc(result)

	SkillHelper.addHyperLinkClick(txtDesc)
end

function Rouge2_CareerAttributeTipsView:updatePosition()
	local anchorPosX, anchorPosY = recthelper.screenPosToAnchorPos2(self._pos, self._transform)
	local offsetX = self._offset and self._offset.x or 0
	local offsetY = self._offset and self._offset.y or 0

	anchorPosX = anchorPosX + offsetX
	anchorPosY = anchorPosY + offsetY

	recthelper.setAnchor(self._tranMark, anchorPosX, anchorPosY)
	self:_fitScreenOffset()
	TaskDispatcher.cancelTask(self._fitScreenOffset, self)
	TaskDispatcher.runDelay(self._fitScreenOffset, self, 0.01)
end

function Rouge2_CareerAttributeTipsView:_fitScreenOffset()
	gohelper.fitScreenOffset(self._tranMark)

	local posX, posY = recthelper.getAnchor(self._tranMark)

	recthelper.setAnchor(self._tranRoot, posX, posY)
end

function Rouge2_CareerAttributeTipsView:_btnCloseOnClick()
	if self._clickCallback then
		local clickPosition = GamepadController.instance:getMousePosition()

		if self._clickCallbackObj then
			self._clickCallback(self._clickCallbackObj, self, clickPosition)
		else
			self._clickCallback(self, clickPosition)
		end

		return
	end

	self:closeThis()
end

function Rouge2_CareerAttributeTipsView:onClose()
	TaskDispatcher.cancelTask(self._fitScreenOffset, self)
end

return Rouge2_CareerAttributeTipsView
