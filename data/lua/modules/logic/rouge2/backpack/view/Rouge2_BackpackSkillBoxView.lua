-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackSkillBoxView.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackSkillBoxView", package.seeall)

local Rouge2_BackpackSkillBoxView = class("Rouge2_BackpackSkillBoxView", BaseView)

function Rouge2_BackpackSkillBoxView:onInitView()
	self._goCapacity = gohelper.findChild(self.viewGO, "SkillPanel/Capacity")
	self._goCapacity2 = gohelper.findChild(self.viewGO, "SkilleditPanel/SkillPanel/Capacity")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_BackpackSkillBoxView:addEvents()
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnUpdateRougeInfo, self._onUpdateRougeInfo, self)
end

function Rouge2_BackpackSkillBoxView:removeEvents()
	return
end

function Rouge2_BackpackSkillBoxView:onOpen()
	self:refreshUI()
end

function Rouge2_BackpackSkillBoxView:refreshUI()
	self._isFit = Rouge2_Model.instance:isUseBXSCareer()

	gohelper.setActive(self._goCapacity, not self._isFit)
	gohelper.setActive(self._goCapacity2, not self._isFit)
end

function Rouge2_BackpackSkillBoxView:_onUpdateRougeInfo()
	self:refreshUI()
end

return Rouge2_BackpackSkillBoxView
