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
	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)

	self:initChildViews()
end

function Rouge2_BackpackSkillView:onOpen()
	self:switchState(Rouge2_BackpackSkillView.ViewState.Panel)
	self._animator:Play("open", 0, 0)
end

function Rouge2_BackpackSkillView:initChildViews()
	self._childViewMap = {}
	self._childViewMap[Rouge2_BackpackSkillView.ViewState.Panel] = Rouge2_BackpackSkillPanelView.New()
	self._childViewMap[Rouge2_BackpackSkillView.ViewState.Edit] = Rouge2_BackpackSkillEditView.New()

	for _, childView in pairs(self._childViewMap) do
		self:addChildView(childView)
	end
end

function Rouge2_BackpackSkillView:switchState(state, params)
	if self._state == state then
		return
	end

	self._state = state

	local animName = Rouge2_BackpackSkillView.ViewState2AnimName[self._state]

	if string.nilorempty(animName) then
		return
	end

	self._animator:Play(animName, 0, 0)

	local childView = self._childViewMap[state]

	if not childView then
		return
	end

	if self._curChildView then
		self._curChildView:onCloseChildView()
	end

	self._curChildView = childView

	self._curChildView:onOpenChildView(params)
end

function Rouge2_BackpackSkillView:_onSwitchSkillViewType(state, params)
	self:switchState(state, params)
end

return Rouge2_BackpackSkillView
