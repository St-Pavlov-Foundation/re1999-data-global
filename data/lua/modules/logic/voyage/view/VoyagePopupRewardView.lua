-- chunkname: @modules/logic/voyage/view/VoyagePopupRewardView.lua

module("modules.logic.voyage.view.VoyagePopupRewardView", package.seeall)

local VoyagePopupRewardView = class("VoyagePopupRewardView", BaseView)

function VoyagePopupRewardView:onInitView()
	self._goclickmask = gohelper.findChild(self.viewGO, "Root/#go_clickmask")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_bg")
	self._txttitle = gohelper.findChildText(self.viewGO, "Root/desc_scroll/viewport/#txt_title")
	self._gonormal = gohelper.findChild(self.viewGO, "Root/reward_scroll/viewport/content/#go_normal")
	self._imagenum = gohelper.findChildImage(self.viewGO, "Root/reward_scroll/viewport/content/#go_normal/#image_num")
	self._goimgall = gohelper.findChild(self.viewGO, "Root/reward_scroll/viewport/content/#go_normal/#go_imgall")
	self._txttaskdesc = gohelper.findChildText(self.viewGO, "Root/reward_scroll/viewport/content/#go_normal/#txt_taskdesc")
	self._goRewards = gohelper.findChild(self.viewGO, "Root/reward_scroll/viewport/content/#go_normal/scroll_Rewards/Viewport/#go_Rewards")
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_jump")
	self._gomail = gohelper.findChild(self.viewGO, "Root/#btn_jump/#go_mail")
	self._godungeon = gohelper.findChild(self.viewGO, "Root/#btn_jump/#go_dungeon")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VoyagePopupRewardView:addEvents()
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function VoyagePopupRewardView:removeEvents()
	self._btnjump:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function VoyagePopupRewardView:_btnjumpOnClick()
	VoyageController.instance:jump()
end

function VoyagePopupRewardView:_btncloseOnClick()
	self:closeThis()
end

function VoyagePopupRewardView:_editableInitView()
	self:addClickCb(gohelper.getClick(self._goclickmask), self.closeThis, self)

	self._txttitle.text = VoyageConfig.instance:getTitle()

	gohelper.setActive(self._gomail, false)
	gohelper.setActive(self._godungeon, false)
end

function VoyagePopupRewardView:onUpdateParam()
	self:_refresh()
end

function VoyagePopupRewardView:onOpen()
	self:_refresh()
	VoyageController.instance:registerCallback(VoyageEvent.OnReceiveAct1001UpdatePush, self._refresh, self)
	VoyageController.instance:registerCallback(VoyageEvent.OnReceiveAct1001GetInfoReply, self._refresh, self)
end

function VoyagePopupRewardView:onClose()
	VoyageController.instance:unregisterCallback(VoyageEvent.OnReceiveAct1001GetInfoReply, self._refresh, self)
	VoyageController.instance:unregisterCallback(VoyageEvent.OnReceiveAct1001UpdatePush, self._refresh, self)
end

function VoyagePopupRewardView:onDestroyView()
	GameUtil.onDestroyViewMemberList(self, "_itemList")
end

function VoyagePopupRewardView:_createOrRefreshList()
	self:_createItemList()

	for _, item in pairs(self._itemList) do
		item:onRefresh()
	end
end

function VoyagePopupRewardView:_createItemList()
	if self._itemList then
		return
	end

	self._itemList = {}

	gohelper.setActive(self._gonormal, true)

	local taskList = VoyageConfig.instance:getTaskList()

	for i, v in ipairs(taskList) do
		local item = self:_createItem(VoyagePopupRewardViewItem)

		item._index = i
		item._view = self

		item:onUpdateMO(v)
		table.insert(self._itemList, item)
	end

	gohelper.setActive(self._gonormal, false)
end

function VoyagePopupRewardView:_refresh()
	self:_createOrRefreshList()
	self:_refreshJumpBtn()
end

function VoyagePopupRewardView:_createItem(class)
	local go = gohelper.cloneInPlace(self._gonormal, class.__name)

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, class)
end

function VoyagePopupRewardView:_refreshJumpBtn()
	local isAnyRewardAvailable = VoyageModel.instance:hasAnyRewardAvailable()

	gohelper.setActive(self._gomail, isAnyRewardAvailable)
	gohelper.setActive(self._godungeon, not isAnyRewardAvailable)
end

return VoyagePopupRewardView
