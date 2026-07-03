-- chunkname: @modules/logic/rouge2/record/view/Rouge2_FightRecordView.lua

module("modules.logic.rouge2.record.view.Rouge2_FightRecordView", package.seeall)

local Rouge2_FightRecordView = class("Rouge2_FightRecordView", BaseView)

function Rouge2_FightRecordView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._scrollrecordlist = gohelper.findChildScrollRect(self.viewGO, "#scroll_recordlist")
	self._goRecordContent = gohelper.findChild(self.viewGO, "#scroll_recordlist/Viewport/Content")
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_FightRecordView:addEvents()
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnUpdateRecordInfo, self._onUpdateRecordInfo, self)
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnSaveRecordDone, self._onSaveRecordDone, self)
end

function Rouge2_FightRecordView:removeEvents()
	return
end

function Rouge2_FightRecordView:_editableInitView()
	self._goRecordItem = self:getResInst(self.viewContainer._viewSetting.otherRes[1], self._goRecordContent)
end

function Rouge2_FightRecordView:onUpdateParam()
	return
end

function Rouge2_FightRecordView:onOpen()
	Rouge2_FightRecordListModel.instance:setViewType(self.viewParam and self.viewParam.viewType)

	local info = Rouge2_OutsideModel.instance:getReviewInfoList()
	local haveReviewInfo = info and #info > 0

	gohelper.setActive(self._goempty, not haveReviewInfo)
	gohelper.setActive(self._scrollrecordlist, haveReviewInfo)
	self:refreshUI()
end

function Rouge2_FightRecordView:refreshUI()
	Rouge2_FightRecordListModel.instance:initList()

	local recordList = Rouge2_FightRecordListModel.instance:getList()

	gohelper.CreateObjList(self, self._refreshRecordItem, recordList, self._goRecordContent, self._goRecordItem, Rouge2_FightRecordItem)
end

function Rouge2_FightRecordView:_refreshRecordItem(recordItem, mo, index)
	recordItem._index = index
	recordItem._view = self

	recordItem:onUpdateMO(mo, index)
end

function Rouge2_FightRecordView:_onUpdateRecordInfo()
	self:refreshUI()
end

function Rouge2_FightRecordView:_onSaveRecordDone()
	Rouge2_FightRecordListModel.instance:setViewType(Rouge2_Enum.RecordViewType.Show)
	self:refreshUI()
end

function Rouge2_FightRecordView:onClose()
	return
end

function Rouge2_FightRecordView:onDestroyView()
	return
end

return Rouge2_FightRecordView
