-- chunkname: @modules/logic/rouge2/common/comp/Rouge2_AttributeDetailTipsView.lua

module("modules.logic.rouge2.common.comp.Rouge2_AttributeDetailTipsView", package.seeall)

local Rouge2_AttributeDetailTipsView = class("Rouge2_AttributeDetailTipsView", BaseView)

function Rouge2_AttributeDetailTipsView:onInitView()
	self._goRoot = gohelper.findChild(self.viewGO, "#go_Root")
	self._goTips = gohelper.findChild(self.viewGO, "#go_Root/#go_Tips")
	self._goLevelList = gohelper.findChild(self.viewGO, "#go_Root/#go_Tips/bg/#scroll_resistance/viewport/content")
	self._goEffectTips = gohelper.findChild(self.viewGO, "#go_Root/#go_Tips/bg/#scroll_resistance/viewport/content/#go_EffectTips")
	self._btnCloseTips = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#go_Tips/#btn_CloseTips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_AttributeDetailTipsView:addEvents()
	self._btnCloseTips:AddClickListener(self._btnCloseTipsOnClick, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onShowAttrSpSkillTips, self._onShowAttrSpSkillTips, self)
end

function Rouge2_AttributeDetailTipsView:removeEvents()
	self._btnCloseTips:RemoveClickListener()
end

function Rouge2_AttributeDetailTipsView:onOpen()
	self._tranRoot = self._goRoot.transform
	self._tranTips = self._goTips.transform

	gohelper.setActive(self._goTips, false)
end

function Rouge2_AttributeDetailTipsView:_btnCloseTipsOnClick()
	gohelper.setActive(self._goTips, false)
end

function Rouge2_AttributeDetailTipsView:_onShowAttrSpSkillTips(clickPos, attrId)
	local anchorPosX, anchorPosY = recthelper.screenPosToAnchorPos2(clickPos, self._tranRoot)

	gohelper.setActive(self._goTips, true)
	recthelper.setAnchor(self._tranTips, anchorPosX, anchorPosY)

	self._attrId = attrId
	self._attrCo = Rouge2_AttributeConfig.instance:getAttributeConfig(self._attrId)
	self._attrName = self._attrCo and self._attrCo.name or ""

	local careerId = Rouge2_Model.instance:getCareerId()

	self._curAttrValue = Rouge2_Model.instance:getAttrValue(self._attrId)

	local skillList = Rouge2_AttributeConfig.instance:getCareerPassiveSkillList_Sp(careerId, self._attrId) or {}

	gohelper.CreateObjList(self, self._refreshSkillTipsItem, skillList, self._goLevelList, self._goEffectTips)
end

function Rouge2_AttributeDetailTipsView:_refreshSkillTipsItem(obj, skillCo, index)
	local txtEffectOn = gohelper.findChildText(obj, "#txt_effect_on")
	local txtEffectOff = gohelper.findChildText(obj, "#txt_effect_off")
	local isOn = self._curAttrValue >= skillCo.level

	gohelper.setActive(txtEffectOn.gameObject, isOn)
	gohelper.setActive(txtEffectOff.gameObject, not isOn)

	local imLevelUpDescStr = Rouge2_AttributeConfig.instance:getPassiveSkillImLevelUpDesc(skillCo.id, skillCo.level)
	local result = GameUtil.getSubPlaceholderLuaLangThreeParam(luaLang("rouge2_effecttips2"), skillCo.level, self._attrName, imLevelUpDescStr)

	txtEffectOn.text = SkillHelper.buildDesc(result)
	txtEffectOff.text = SkillHelper.buildDesc(result)
end

return Rouge2_AttributeDetailTipsView
