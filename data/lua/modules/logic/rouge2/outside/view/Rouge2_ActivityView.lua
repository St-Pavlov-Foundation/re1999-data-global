-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_ActivityView.lua

module("modules.logic.rouge2.outside.view.Rouge2_ActivityView", package.seeall)

local Rouge2_ActivityView = class("Rouge2_ActivityView", BaseView)

function Rouge2_ActivityView:onInitView()
	self._txttime = gohelper.findChildText(self.viewGO, "title/LimitTime/#txt_time")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#btn_start")
	self._goimagestart = gohelper.findChild(self.viewGO, "Middle/#btn_start/#go_image_start")
	self._goprogress = gohelper.findChild(self.viewGO, "Middle/#go_progress")
	self._txtdifficulty = gohelper.findChildText(self.viewGO, "Middle/#go_progress/#txt_difficulty")
	self._txtname = gohelper.findChildText(self.viewGO, "Middle/#go_progress/#txt_name")
	self._btnend = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#btn_end")
	self._golocked = gohelper.findChild(self.viewGO, "Middle/#go_locked")
	self._txtunlockTime = gohelper.findChildText(self.viewGO, "Middle/#go_locked/#txt_unlockTime")
	self._btnachievementpreview = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_achievementpreview")
	self._btnStore = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Store")
	self._txtRewardNum = gohelper.findChildText(self.viewGO, "Right/#btn_Store/#txt_RewardNum")
	self._goreddot = gohelper.findChild(self.viewGO, "Right/#btn_Store/#go_reddot")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_ActivityView:addEvents()
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnend:AddClickListener(self._btnendOnClick, self)
	self._btnachievementpreview:AddClickListener(self._btnachievementpreviewOnClick, self)
	self._btnStore:AddClickListener(self._btnStoreOnClick, self)
	Rouge2_Controller.instance:registerCallback(Rouge2_Event.OnUpdateRougeInfo, self._onUpdateRougeInfo, self)
	Rouge2_OutsideController.instance:registerCallback(Rouge2_OutsideEvent.onAlchemyInfoUpdate, self._onUpdateRougeInfo, self)
	Rouge2_OutsideController.instance:registerCallback(Rouge2_OutsideEvent.OnUpdateRougeOutsideInfo, self._onUpdateRougeInfo, self)
	self:addEventCb(Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnBuyStoreGoodsSuccess, self.refreshUI, self)
end

function Rouge2_ActivityView:removeEvents()
	self._btnstart:RemoveClickListener()
	self._btnend:RemoveClickListener()
	self._btnachievementpreview:RemoveClickListener()
	self._btnStore:RemoveClickListener()
	Rouge2_Controller.instance:unregisterCallback(Rouge2_Event.OnUpdateRougeInfo, self._onUpdateRougeInfo, self)
	Rouge2_OutsideController.instance:unregisterCallback(Rouge2_OutsideEvent.onAlchemyInfoUpdate, self._onUpdateRougeInfo, self)
	Rouge2_OutsideController.instance:unregisterCallback(Rouge2_OutsideEvent.OnUpdateRougeOutsideInfo, self._onUpdateRougeInfo, self)
	self:removeEventCb(Rouge2_OutsideController.instance, Rouge2_OutsideEvent.OnBuyStoreGoodsSuccess, self.refreshUI, self)
end

function Rouge2_ActivityView:_btnendOnClick()
	self:_end()
end

function Rouge2_ActivityView:_btnachievementpreviewOnClick()
	return
end

function Rouge2_ActivityView:_btnstartOnClick()
	if not Rouge2_Controller.instance:checkIsOpen(true) then
		return
	end

	if Rouge2_Model.instance:isStarted() then
		Rouge2_Controller.instance:startRouge()
		self:closeThis()
	else
		Rouge2_ViewHelper.openEnterView()
	end
end

function Rouge2_ActivityView:_btnStoreOnClick()
	if not Rouge2_Controller.instance:checkIsOpen(true) then
		return
	end

	Rouge2_ViewHelper.openStoreView()
end

function Rouge2_ActivityView:onSceneSwitchFinish()
	Rouge2_OutsideController.instance:unregisterCallback(Rouge2_OutsideEvent.SceneSwitchFinish, self.onSceneSwitchFinish, self)
	Rouge2_Controller.instance:openMainView()
end

function Rouge2_ActivityView:_editableInitView()
	self.animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)

	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.V3a2_Rouge_Store_Main, 0)
	gohelper.setActive(self._golocked, false)
	gohelper.setActive(self._btnachievementpreview, false)
end

function Rouge2_ActivityView:onUpdateParam()
	return
end

function Rouge2_ActivityView:onOpen()
	local actId = Rouge2_Model.instance:getCurActId()

	self.actId = actId

	self.animator:Play("open", 0, 0)
	Rouge2_Model.instance:setCurActId(self.actId)
	self:_refreshTime()
	TaskDispatcher.runRepeat(self._refreshTime, self, TimeUtil.OneSecond)
	Rouge2OutsideRpc.instance:sendGetRouge2OutsideInfoRequest(function(_, resultCode)
		if resultCode ~= 0 then
			logError("openRouge2ActivityView sendGetRouge2OutsideInfoRequest resultCode=" .. tostring(resultCode))

			return
		end

		Rouge2_Rpc.instance:sendGetRouge2InfoRequest(function(_, resultCode2)
			if resultCode2 ~= 0 then
				logError("openRouge2ActivityView sendGetRouge2InfoRequest resultCode=" .. tostring(resultCode2))

				return
			end

			self:refreshUI()
		end)
	end)
	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OpenRougeView, Rouge2_Enum.GuideView.ActivityView)
end

function Rouge2_ActivityView:_onUpdateRougeInfo()
	self:refreshUI()
end

function Rouge2_ActivityView:refreshUI()
	local costId = CurrencyEnum.CurrencyType.V3a2Rouge
	local currencyMo = CurrencyModel.instance:getCurrency(costId)

	if currencyMo == nil then
		return
	end

	local count = currencyMo.quantity or 0

	if self._txtRewardNum then
		self._txtRewardNum.text = tostring(count)
	end

	self:_refreshProgress()
end

function Rouge2_ActivityView:_refreshTime()
	local actInfo = ActivityModel.instance:getActMO(self.actId)
	local endTime = actInfo:getRealEndTimeStamp()
	local nowTime = ServerTime.now()

	if endTime <= nowTime then
		self._txttime.text = luaLang("ended")

		return
	end

	local dataStr = TimeUtil.SecondToActivityTimeFormat(endTime - nowTime)

	self._txttime.text = dataStr
end

function Rouge2_ActivityView:_refreshProgress()
	local isInRouge = Rouge2_Model.instance:inRouge()
	local difficulty = Rouge2_Model.instance:getDifficulty()
	local selectDifficulty = difficulty ~= nil and difficulty ~= 0

	gohelper.setActive(self._goprogress, isInRouge and selectDifficulty)
	gohelper.setActive(self._btnend, isInRouge and selectDifficulty)

	if not selectDifficulty then
		return
	end

	local difficultyCO = Rouge2_Config.instance:getDifficultyCoById(difficulty)

	self._txtdifficulty.text = difficultyCO.title
end

function Rouge2_ActivityView:_end()
	GameFacade.showMessageBox(MessageBoxIdDefine.RougeMainView_AbortRequest, MsgBoxEnum.BoxType.Yes_No, self._endYesCallback, nil, nil, self, nil, nil)
end

function Rouge2_ActivityView:_onReceiveEndReply()
	Rouge2_Controller.instance:startEndFlow()
end

function Rouge2_ActivityView:_endYesCallback()
	Rouge2_StatController.instance:setReset()
	Rouge2_Rpc.instance:sendRouge2AbortRequest(self._onReceiveEndReply, self)
end

function Rouge2_ActivityView:_onReceiveEndReply()
	Rouge2_Controller.instance:startEndFlow()
end

function Rouge2_ActivityView:onClose()
	TaskDispatcher.cancelTask(self._refreshTime, self)
end

function Rouge2_ActivityView:onDestroyView()
	return
end

return Rouge2_ActivityView
