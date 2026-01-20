-- chunkname: @modules/logic/rouge2/common/comp/Rouge2_AttributeDetailView.lua

module("modules.logic.rouge2.common.comp.Rouge2_AttributeDetailView", package.seeall)

local Rouge2_AttributeDetailView = class("Rouge2_AttributeDetailView", BaseView)

function Rouge2_AttributeDetailView:onInitView()
	self._goRoot = gohelper.findChild(self.viewGO, "#go_Root")
	self._goContent = gohelper.findChild(self.viewGO, "#go_Root/Scroll View/Viewport/Content")
	self._goDetailItem = gohelper.findChild(self.viewGO, "#go_Root/Scroll View/Viewport/Content/#go_DetailItem")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#btn_Close")
	self._btnClose2 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#btn_Close2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_AttributeDetailView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnClose2:AddClickListener(self._btnCloseOnClick, self)
end

function Rouge2_AttributeDetailView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnClose2:RemoveClickListener()
end

function Rouge2_AttributeDetailView:_btnCloseOnClick()
	self:closeThis()
end

function Rouge2_AttributeDetailView:_editableInitView()
	self._clickTab = self:getUserDataTb_()
end

function Rouge2_AttributeDetailView:onUpdateParam()
	return
end

function Rouge2_AttributeDetailView:onOpen()
	self._careerId = self.viewParam and self.viewParam.careerId
	self._careerCo = Rouge2_CareerConfig.instance:getCareerConfig(self._careerId)

	self:initAttrInfoList()
end

function Rouge2_AttributeDetailView:initAttrInfoList()
	self._attrInfoList = {}

	local attrInfoList = self.viewParam and self.viewParam.attrInfoList

	tabletool.addValues(self._attrInfoList, attrInfoList)
	table.sort(self._attrInfoList, function(aAttrInfo, bAttrInfo)
		local aSortIndex = Rouge2_CareerConfig.instance:getAttrSortIndex(self._careerId, aAttrInfo.attrId)
		local bSortIndex = Rouge2_CareerConfig.instance:getAttrSortIndex(self._careerId, bAttrInfo.attrId)

		return aSortIndex < bSortIndex
	end)

	self._attrInfoNum = self._attrInfoList and #self._attrInfoList or 0

	gohelper.CreateObjList(self, self._refreshAttribute, self._attrInfoList, self._goContent, self._goDetailItem)
end

function Rouge2_AttributeDetailView._sortAttrFunc(aAttrInfo, bAttrInfo)
	return
end

function Rouge2_AttributeDetailView:_refreshAttribute(obj, attrInfo, index)
	local imageIcon = gohelper.findChildImage(obj, "go_left/image_Icon")
	local txtName = gohelper.findChildText(obj, "go_left/txt_Name")
	local txtValue = gohelper.findChildText(obj, "go_left/txt_Value")
	local txtCareerDesc = gohelper.findChildText(obj, "careerDesc/txt_CareerDesc")
	local goDescList = gohelper.findChild(obj, "go_DescList")
	local goDescItem = gohelper.findChild(obj, "go_DescList/go_DescItem")
	local goLine = gohelper.findChild(obj, "image_Line")
	local goRecommend = gohelper.findChild(obj, "go_Recommend")
	local btnTips = gohelper.findChildButtonWithAudio(obj, "#btn_tips")

	btnTips:RemoveClickListener()
	btnTips:AddClickListener(self._btnTipsOnClick, self, attrInfo.attrId)

	self._clickTab[index] = btnTips

	local attrId = attrInfo.attrId
	local attributeCo = Rouge2_AttributeConfig.instance:getAttributeConfig(attrId)

	txtName.text = attributeCo and attributeCo.name
	txtCareerDesc.text = attributeCo and attributeCo.careerDesc
	txtValue.text = attrInfo.value

	Rouge2_IconHelper.setAttributeIcon(attrId, imageIcon)

	local descList = Rouge2_AttributeConfig.instance:getPassiveSkillDescList(self._careerId, attrId, attrInfo.value)

	gohelper.CreateObjList(self, self._refreshDesc, descList or {}, goDescList, goDescItem)
	gohelper.setActive(goLine, index < self._attrInfoNum)
	gohelper.setActive(goRecommend, Rouge2_CareerConfig.instance:isAttrRecommend(self._careerId, attrId))
end

function Rouge2_AttributeDetailView:_refreshDesc(obj, desc, index)
	local txtDesc = gohelper.findChildText(obj, "txt_Desc")

	desc = SkillHelper.removeAllColorRichTags(desc)
	txtDesc.text = SkillHelper.buildDesc(desc)

	SkillHelper.addHyperLinkClick(txtDesc)
end

function Rouge2_AttributeDetailView:_btnTipsOnClick(attrId)
	local clickPos = GamepadController.instance:getMousePosition()

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onShowAttrSpSkillTips, clickPos, attrId)
end

function Rouge2_AttributeDetailView:onClose()
	for _, btnClick in pairs(self._clickTab) do
		btnClick:RemoveClickListener()
	end
end

function Rouge2_AttributeDetailView:onDestroyView()
	return
end

return Rouge2_AttributeDetailView
