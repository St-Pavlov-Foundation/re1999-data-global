-- chunkname: @modules/logic/rouge2/record/view/Rouge2_FightRecordViewContainer.lua

module("modules.logic.rouge2.record.view.Rouge2_FightRecordViewContainer", package.seeall)

local Rouge2_FightRecordViewContainer = class("Rouge2_FightRecordViewContainer", BaseViewContainer)

function Rouge2_FightRecordViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_FightRecordView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Rouge2_FightRecordViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setOverrideClose(self._onBtnCloseCallback, self)

		return {
			self.navigateView
		}
	end
end

function Rouge2_FightRecordViewContainer:_onBtnCloseCallback()
	local viewType = Rouge2_FightRecordListModel.instance:getViewType()

	if viewType == Rouge2_Enum.RecordViewType.Edit then
		GameFacade.showMessageBox(MessageBoxIdDefine.Rouge2AbandonRecord, MsgBoxEnum.BoxType.Yes_No, self._abandonRecord, nil, nil, self)

		return
	end

	self:closeThis()
end

function Rouge2_FightRecordViewContainer:_abandonRecord()
	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnSaveRecordDone)
	self:closeThis()
end

return Rouge2_FightRecordViewContainer
