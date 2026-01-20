-- chunkname: @modules/logic/versionactivity2_7/towergift/view/DestinyStoneGiftPickChoiceView.lua

module("modules.logic.versionactivity2_7.towergift.view.DestinyStoneGiftPickChoiceView", package.seeall)

local DestinyStoneGiftPickChoiceView = class("DestinyStoneGiftPickChoiceView", BaseView)

function DestinyStoneGiftPickChoiceView:onInitView()
	self._goconfirm = gohelper.findChild(self.viewGO, "#btn_confirm")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")
	self._goconfirmgrey = gohelper.findChild(self.viewGO, "#btn_confirm_grey")
	self._btnconfirmgrey = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm_grey")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_cancel")
	self._scrollstone = gohelper.findChildScrollRect(self.viewGO, "#scroll_stone")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DestinyStoneGiftPickChoiceView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self._btnconfirmgrey:AddClickListener(self._btnconfirmgreyOnClick, self)
	self:addEventCb(DestinyStoneGiftPickChoiceController.instance, DestinyStoneGiftPickChoiceEvent.onCustomPickListChanged, self.refreshUI, self)
	self:addEventCb(DestinyStoneGiftPickChoiceController.instance, DestinyStoneGiftPickChoiceEvent.hadStoneUp, self.onStoneUpFinish, self)
end

function DestinyStoneGiftPickChoiceView:removeEvents()
	self._btnconfirm:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self._btnconfirmgrey:RemoveClickListener()
	self:removeEventCb(DestinyStoneGiftPickChoiceController.instance, DestinyStoneGiftPickChoiceEvent.onCustomPickListChanged, self.refreshUI, self)
	self:removeEventCb(DestinyStoneGiftPickChoiceController.instance, DestinyStoneGiftPickChoiceEvent.hadStoneUp, self.onStoneUpFinish, self)
end

function DestinyStoneGiftPickChoiceView:_btnconfirmOnClick()
	local currentSelectMo = DestinyStoneGiftPickChoiceListModel.instance:getCurrentSelectMo()

	if currentSelectMo then
		local heroDestinyStoneMO = currentSelectMo.heroMo.destinyStoneMo

		heroDestinyStoneMO:setUpStoneId(currentSelectMo.stoneId)

		local param = {
			materialId = self._materialId,
			heroMo = currentSelectMo.heroMo,
			stoneMo = currentSelectMo.stoneMo
		}

		ViewMgr.instance:openView(ViewName.CharacterDestinyStoneUpView, param)
	end
end

function DestinyStoneGiftPickChoiceView:_btncancelOnClick()
	self:closeThis()
end

function DestinyStoneGiftPickChoiceView:_btnconfirmgreyOnClick()
	GameFacade.showToast(ToastEnum.NoChoiceHeroStoneUp)
end

function DestinyStoneGiftPickChoiceView:onStoneUpFinish()
	self:closeThis()
end

function DestinyStoneGiftPickChoiceView:_editableInitView()
	return
end

function DestinyStoneGiftPickChoiceView:onUpdateParam()
	return
end

function DestinyStoneGiftPickChoiceView:onOpen()
	self._materialId = self.viewParam and self.viewParam.materialId

	local ignoreIds = self.viewParam.ignoreIds

	DestinyStoneGiftPickChoiceListModel.instance:initList(ignoreIds)
	self:refreshUI()
end

function DestinyStoneGiftPickChoiceView:refreshUI()
	local isSelect = DestinyStoneGiftPickChoiceListModel.instance:getCurrentSelectMo() ~= nil

	gohelper.setActive(self._goconfirm, isSelect)
	gohelper.setActive(self._goconfirmgrey, not isSelect)
end

function DestinyStoneGiftPickChoiceView:onClose()
	DestinyStoneGiftPickChoiceListModel.instance:clearSelect()
end

function DestinyStoneGiftPickChoiceView:onDestroyView()
	return
end

return DestinyStoneGiftPickChoiceView
