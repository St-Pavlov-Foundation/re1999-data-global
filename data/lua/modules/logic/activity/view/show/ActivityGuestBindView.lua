-- chunkname: @modules/logic/activity/view/show/ActivityGuestBindView.lua

module("modules.logic.activity.view.show.ActivityGuestBindView", package.seeall)

local ActivityGuestBindView = class("ActivityGuestBindView", BaseView)

function ActivityGuestBindView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "leftbottom/#scroll_reward")
	self._btngo = gohelper.findChildButtonWithAudio(self.viewGO, "rightbottom/#btn_go")
	self._txtbtngo = gohelper.findChildText(self.viewGO, "rightbottom/#btn_go/#txt_btngo")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityGuestBindView:addEvents()
	self._btngo:AddClickListener(self._btngoOnClick, self)
end

function ActivityGuestBindView:removeEvents()
	self._btngo:RemoveClickListener()
end

function ActivityGuestBindView:_btngoOnClick()
	local E = SDKEnum.RewardType
	local e = SDKModel.instance:getAccountBindBonus()

	logNormal("ActivityGuestBindView:_btngoOnClick click: e=" .. tostring(e))

	if e == E.None then
		SDKMgr.instance:openAccountBind()

		return
	end

	if e == E.Claim then
		logNormal("ActivityGuestBindView:_btngoOnClick sendAct1000AccountBindBonusRequest")

		local viewParam = self.viewParam
		local actId = viewParam.actId

		Activity1000Rpc.instance:sendAct1000AccountBindBonusRequest(actId)

		return
	end
end

function ActivityGuestBindView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getActivityBg("full/img_blind_bg"))
end

function ActivityGuestBindView:onUpdateParam()
	return
end

function ActivityGuestBindView:onOpen()
	local viewParam = self.viewParam
	local parentGO = viewParam.parent
	local actId = viewParam.actId

	gohelper.addChild(parentGO, self.viewGO)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Task_page)
	Activity1000Rpc.instance:sendAct1000GetInfoRequest(actId, self._refresh, self)

	local rewards = GameUtil.splitString2(SDKConfig.instance:getGuestBindRewards(), true, "|", "#")
	local dataList = {}

	for i = 1, #rewards do
		dataList[#dataList + 1] = {
			itemCO = rewards[i]
		}
	end

	ActivityGuestBindViewListModel.instance:setList(dataList)
	self:_refresh()
	self:addEventCb(SDKController.instance, SDKEvent.UpdateAccountBindBonus, self._refresh, self)
end

function ActivityGuestBindView:onClose()
	self:removeEventCb(SDKController.instance, SDKEvent.UpdateAccountBindBonus, self._refresh, self)
end

function ActivityGuestBindView:onDestroyView()
	self._simagebg:UnLoadImage()
end

function ActivityGuestBindView:_onUpdateAccountBindBonus()
	logNormal("ActivityGuestBindView:_onGuestBindSucc")
	self:_refresh()
end

function ActivityGuestBindView:_refresh()
	local E = SDKEnum.RewardType
	local e = SDKModel.instance:getAccountBindBonus()

	logNormal("ActivityGuestBindView:_refresh e=" .. tostring(e))

	if e == E.None then
		self._txtbtngo.text = luaLang("activityguestbindview_go")
	elseif e == E.Claim then
		self._txtbtngo.text = luaLang("activityguestbindview_reward")
	elseif e == E.Got then
		self._txtbtngo.text = luaLang("activityguestbindview_rewarded")
	end

	SLFramework.UGUI.GuiHelper.SetColor(self._btngo.gameObject:GetComponent(gohelper.Type_Image), e == E.Got and "#666666" or "#ffffff")
end

return ActivityGuestBindView
