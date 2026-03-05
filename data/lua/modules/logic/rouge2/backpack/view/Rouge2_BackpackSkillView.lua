-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackSkillView.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackSkillView", package.seeall)

local Rouge2_BackpackSkillView = class("Rouge2_BackpackSkillView", BaseView)

Rouge2_BackpackSkillView.ViewState = {
	Panel = 1,
	Edit = 2
}
Rouge2_BackpackSkillView.ViewState2AnimName = {
	[Rouge2_BackpackSkillView.ViewState.Panel] = "toskill",
	[Rouge2_BackpackSkillView.ViewState.Edit] = "toskilledit"
}

function Rouge2_BackpackSkillView:onInitView()
	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_BackpackSkillView:addEvents()
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnSwitchSkillViewType, self._onSwitchSkillViewType, self)
end

function Rouge2_BackpackSkillView:removeEvents()
	return
end

function Rouge2_BackpackSkillView:_editableInitView()
	self:initChildViews()
	self._animator:Rebind()
end

function Rouge2_BackpackSkillView:onOpen()
	self._animator:Play("open", 0, 0)
	self:switchState(Rouge2_BackpackSkillView.ViewState.Panel)
end

function Rouge2_BackpackSkillView:initChildViews()
	self._childViewMap = {}

	if Rouge2_Model.instance:isUseYBXCareer() then
		self._goPanel = self:getResInst(Rouge2_Enum.ResPath.BackpackTalentView, self.viewGO, "SkillTalent")
		self._childViewMap[Rouge2_BackpackSkillView.ViewState.Panel] = Rouge2_BackpackSkillTalentView.New()
	else
		self._goPanel = self:getResInst(Rouge2_Enum.ResPath.BackpackSkillPanelView, self.viewGO, "SkillPanel")
		self._childViewMap[Rouge2_BackpackSkillView.ViewState.Panel] = Rouge2_BackpackSkillPanelView.New()
	end

	self._childViewMap[Rouge2_BackpackSkillView.ViewState.Edit] = Rouge2_BackpackSkillEditView.New()

	for _, childView in pairs(self._childViewMap) do
		self:addChildView(childView)
	end
end

function Rouge2_BackpackSkillView:switchState(state, params)
	if self._state == state then
		return
	end

	local animName = self._state and Rouge2_BackpackSkillView.ViewState2AnimName[state]

	if not string.nilorempty(animName) then
		self._animator:Play(animName, 0, 0)
	end

	local childView = self._childViewMap[state]

	if not childView then
		return
	end

	if self._curChildView then
		self._curChildView:onCloseChildView()
	end

	self._state = state
	self._curChildView = childView

	self._curChildView:onOpenChildView(params)
end

function Rouge2_BackpackSkillView:_onSwitchSkillViewType(state, params)
	self:switchState(state, params)
end

function Rouge2_BackpackSkillView:getView(viewState)
	return self._childViewMap and self._childViewMap[viewState]
end

return Rouge2_BackpackSkillView
