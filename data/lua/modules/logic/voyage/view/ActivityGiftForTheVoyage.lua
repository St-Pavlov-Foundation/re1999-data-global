-- chunkname: @modules/logic/voyage/view/ActivityGiftForTheVoyage.lua

module("modules.logic.voyage.view.ActivityGiftForTheVoyage", package.seeall)

local ActivityGiftForTheVoyage = class("ActivityGiftForTheVoyage", BaseView)

function ActivityGiftForTheVoyage:onInitView()
	self._txttitle = gohelper.findChildText(self.viewGO, "title/scroll/view/#txt_title")
	self._gotaskitem = gohelper.findChild(self.viewGO, "scroll_task/Viewport/content/#go_taskitem")
	self._goRewards = gohelper.findChild(self.viewGO, "scroll_task/Viewport/content/#go_taskitem/scroll_Rewards/Viewport/#go_Rewards")
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_jump")
	self._gomail = gohelper.findChild(self.viewGO, "#btn_jump/#go_mail")
	self._godungeon = gohelper.findChild(self.viewGO, "#btn_jump/#go_dungeon")
	self._gored = gohelper.findChild(self.viewGO, "#btn_jump/#go_red")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityGiftForTheVoyage:addEvents()
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
end

function ActivityGiftForTheVoyage:removeEvents()
	self._btnjump:RemoveClickListener()
end

function ActivityGiftForTheVoyage:_btnjumpOnClick()
	ViewMgr.instance:closeView(ViewName.ActivityBeginnerView)
	VoyageController.instance:jump()
end

function ActivityGiftForTheVoyage:_editableInitView()
	gohelper.setActive(self._gomail, false)
	gohelper.setActive(self._godungeon, false)

	self._txttitle.text = VoyageConfig.instance:getTitle()
end

function ActivityGiftForTheVoyage:onUpdateParam()
	self:_refresh()
end

function ActivityGiftForTheVoyage:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)
	self:_refresh()
	VoyageController.instance:registerCallback(VoyageEvent.OnReceiveAct1001UpdatePush, self._refresh, self)
	VoyageController.instance:registerCallback(VoyageEvent.OnReceiveAct1001GetInfoReply, self._refresh, self)
	Activity1001Rpc.instance:sendAct1001GetInfoRequest(VoyageConfig.instance:getActivityId())
	RedDotController.instance:addRedDot(self._gored, -11235, nil, self._addRedDotOverrideFunc, self)
end

function ActivityGiftForTheVoyage:onClose()
	VoyageController.instance:unregisterCallback(VoyageEvent.OnReceiveAct1001GetInfoReply, self._refresh, self)
	VoyageController.instance:unregisterCallback(VoyageEvent.OnReceiveAct1001UpdatePush, self._refresh, self)
end

function ActivityGiftForTheVoyage:onDestroyView()
	GameUtil.onDestroyViewMemberList(self, "_itemList")
end

function ActivityGiftForTheVoyage:_createItemList()
	if self._itemList then
		return
	end

	self._itemList = {}

	local taskList = VoyageConfig.instance:getTaskList()

	gohelper.setActive(self._gotaskitem, true)

	for i, v in ipairs(taskList) do
		local item = self:_createItem(ActivityGiftForTheVoyageItem)

		item._index = i
		item._view = self

		item:onUpdateMO(v)
		item:setActiveLine(i ~= #taskList)
		table.insert(self._itemList, item)
	end

	gohelper.setActive(self._gotaskitem, false)
end

function ActivityGiftForTheVoyage:_refresh()
	self:_createOrRefreshList()
	self:_refreshJumpBtn()
end

function ActivityGiftForTheVoyage:_createItem(class)
	local go = gohelper.cloneInPlace(self._gotaskitem, class.__name)

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, class)
end

function ActivityGiftForTheVoyage:_createOrRefreshList()
	self:_createItemList()

	for _, item in pairs(self._itemList) do
		item:onRefresh()
	end
end

function ActivityGiftForTheVoyage:_refreshJumpBtn()
	local isAnyRewardAvailable = VoyageModel.instance:hasAnyRewardAvailable()

	gohelper.setActive(self._gomail, isAnyRewardAvailable)
	gohelper.setActive(self._godungeon, not isAnyRewardAvailable)
end

function ActivityGiftForTheVoyage:_addRedDotOverrideFunc(redDotIcon)
	redDotIcon.show = VoyageModel.instance:hasAnyRewardAvailable()

	redDotIcon:showRedDot(RedDotEnum.Style.Normal)
end

return ActivityGiftForTheVoyage
