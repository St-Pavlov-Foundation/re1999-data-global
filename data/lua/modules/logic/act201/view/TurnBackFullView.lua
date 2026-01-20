-- chunkname: @modules/logic/act201/view/TurnBackFullView.lua

module("modules.logic.act201.view.TurnBackFullView", package.seeall)

local TurnBackFullView = class("TurnBackFullView", BaseView)

function TurnBackFullView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/Right/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/Right/#txt_LimitTime")
	self._txtnum = gohelper.findChildText(self.viewGO, "Root/Right/#txt_num")
	self._scrolldes = gohelper.findChildScrollRect(self.viewGO, "Root/Right/#scroll_des")
	self._btninvite = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Right/#btn_invite")
	self._btncopy = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Right/#btn_copy")
	self._simagebook = gohelper.findChildSingleImage(self.viewGO, "Root/Left/#simage_book")
	self._txttitle = gohelper.findChildText(self.viewGO, "Root/Left/#txt_title")
	self._simageplayerheadicon = gohelper.findChildSingleImage(self.viewGO, "Root/Left/#simage_playerheadicon")
	self._goframenode = gohelper.findChild(self.viewGO, "Root/Left/#simage_playerheadicon/#go_framenode")
	self._goplayer1 = gohelper.findChild(self.viewGO, "Root/Left/#scroll_playerlist/viweport/content/#go_player1")
	self._goLongClick = gohelper.findChild(self.viewGO, "Root/Right/#txt_num/#go_copyLongClick")
	self._btnCopyClick = gohelper.findChildClick(self.viewGO, "Root/Right/#txt_num/#go_copyLongClick")
	self._btnreward1 = gohelper.findChildClick(self.viewGO, "Root/Right/rewardroot1/#btn_reward")
	self._btnreward2 = gohelper.findChildClick(self.viewGO, "Root/Right/rewardroot2/#btn_reward")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TurnBackFullView:addEvents()
	self._btninvite:AddClickListener(self._btninviteOnClick, self)
	self._btncopy:AddClickListener(self._btncopyOnClick, self)
	self._btnCopyClick:AddClickListener(self._btncopyOnClick, self)
	self._btnreward1:AddClickListener(self._btnrewardOnClick, self)
	self._btnreward2:AddClickListener(self._btnrewardOnClick, self)
	self._btnCopyLongPress:AddLongPressListener(self._btncopyOnClick, self)
end

function TurnBackFullView:removeEvents()
	self._btninvite:RemoveClickListener()
	self._btncopy:RemoveClickListener()
	self._btnCopyClick:RemoveClickListener()
	self._btnreward1:RemoveClickListener()
	self._btnreward2:RemoveClickListener()
	self._btnCopyLongPress:RemoveLongPressListener()
end

function TurnBackFullView:_btninviteOnClick()
	SDKDataTrackMgr.instance:trackClickEnterActivityButton("海外人拉人H5活动界面", "进入活动")

	local url = Activity201Model.instance:getLoginUrl()

	WebViewController.instance:openWebView(url, false, self.OnWebViewBack, self)
end

function TurnBackFullView:_btncopyOnClick()
	local activityInfo = Activity201Model.instance:getInvitationInfo(self._actId)

	if not activityInfo then
		return
	end

	local inviteCode = activityInfo.inviteCode

	if not inviteCode then
		return
	end

	ZProj.UGUIHelper.CopyText(inviteCode)
	ToastController.instance:showToast(ToastEnum.ClickPlayerId)
end

function TurnBackFullView:_btnrewardOnClick()
	local itemId = CurrencyEnum.CurrencyType.FreeDiamondCoupon

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, itemId, false, nil, nil)
end

function TurnBackFullView:OnWebViewBack(errorType, msg)
	if errorType == WebViewEnum.WebViewCBType.Cb then
		local msgParamList = string.split(msg, "#")
		local eventName = msgParamList[1]

		if eventName == "webClose" then
			Activity201Controller.instance:getInvitationInfo(self._actId)
			ViewMgr.instance:closeView(ViewName.WebView)
		elseif eventName == "saveImage" and msgParamList[2] then
			Base64Util.saveImage(msgParamList[2])
		end
	end
end

function TurnBackFullView:_editableInitView()
	self._friendItemList = {}
	self._loader = MultiAbLoader.New()
	self._btnCopyLongPress = SLFramework.UGUI.UILongPressListener.Get(self._goLongClick)

	self._btnCopyLongPress:SetLongPressTime({
		0.5,
		99999
	})
	gohelper.setActive(self._goplayer1, false)
end

function TurnBackFullView:onUpdateParam()
	return
end

function TurnBackFullView:onOpen()
	self:addEventCb(Activity201Controller.instance, Activity201Event.OnGetInfoSuccess, self._refreshUI, self)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TurnBackH5.play_ui_rolesopen)
	self:_checkParent()
	self:_refreshData()
end

function TurnBackFullView:_refreshData()
	self._actId = self.viewParam.actId

	Activity201Controller.instance:getInvitationInfo(self._actId)
end

function TurnBackFullView:_checkParent()
	local parentGO = self.viewParam.parent

	if parentGO then
		gohelper.addChild(parentGO, self.viewGO)
	end

	self._actId = self.viewParam.actId
end

function TurnBackFullView:_refreshUI()
	local activityInfo = Activity201Model.instance:getInvitationInfo(self._actId)
	local infoLen = #activityInfo.invitePlayers

	for i = 1, infoLen do
		local item = self._friendItemList[i]

		if not item then
			item = self:_create_TurnBackFullViewFriendItem(i)
			self._friendItemList[i] = item
		end

		item:setActive(true)
		item:setData(activityInfo.invitePlayers[i])
	end

	for i = infoLen + 1, math.max(3, #self._friendItemList) do
		local item = self._friendItemList[i]

		if not item then
			item = self:_create_TurnBackFullViewFriendItem(i)
			self._friendItemList[i] = item
		end

		item:setEmpty()
		item:setActive(i <= 3)
	end

	self._txtnum.text = activityInfo.inviteCode

	self:_refreshTime()

	if Activity201Model.instance:isActOpen(self._actId) then
		TaskDispatcher.cancelTask(self._refreshTime, self)
		TaskDispatcher.runRepeat(self._refreshTime, self, 1)
	end

	self:_refreshPlayerInfo()
end

function TurnBackFullView:_refreshTime()
	local actInfo = ActivityModel.instance:getActMO(self._actId)
	local endTime = actInfo:getRealEndTimeStamp()
	local nowTime = ServerTime.now()

	if endTime <= nowTime then
		self._txtLimitTime.text = luaLang("ended")

		return
	end

	local dataStr = TimeUtil.SecondToActivityTimeFormat(endTime - nowTime)

	self._txtLimitTime.text = dataStr
end

function TurnBackFullView:_refreshPlayerInfo()
	local info = PlayerModel.instance:getPlayinfo()
	local config = lua_item.configDict[info.portrait]

	if not self._liveHeadIcon then
		local commonLiveIcon = IconMgr.instance:getCommonLiveHeadIcon(self._simageplayerheadicon)

		self._liveHeadIcon = commonLiveIcon
	end

	self._liveHeadIcon:setLiveHead(config.id)

	self._txttitle.text = formatLuaLang("TurnBackFullView_title", info.name)

	local effectArr = string.split(config.effect, "#")

	if #effectArr > 1 then
		if config.id == tonumber(effectArr[#effectArr]) then
			gohelper.setActive(self._goframenode, true)

			if not self.frame then
				local framePath = "ui/viewres/common/effect/frame.prefab"

				self._loader:addPath(framePath)
				self._loader:startLoad(self._onLoadCallback, self)
			end
		end
	else
		gohelper.setActive(self._goframenode, false)
	end
end

function TurnBackFullView:_onLoadCallback()
	local framePrefab = self._loader:getFirstAssetItem():GetResource()

	gohelper.clone(framePrefab, self._goframenode, "frame")

	self.frame = gohelper.findChild(self._goframenode, "frame")

	local img = self.frame:GetComponent(gohelper.Type_Image)

	img.enabled = false

	local iconwidth = recthelper.getWidth(self._simageplayerheadicon.transform)
	local framenodewidth = recthelper.getWidth(self.frame.transform)
	local scale = 1.41 * (iconwidth / framenodewidth)

	transformhelper.setLocalScale(self.frame.transform, scale, scale, 1)
end

function TurnBackFullView:onClose()
	self:disposeLoader()
	self:removeEventCb(Activity201Controller.instance, Activity201Event.OnGetInfoSuccess, self._refreshUI, self)
	TaskDispatcher.cancelTask(self._refreshTime, self)
end

function TurnBackFullView:onDestroyView()
	GameUtil.onDestroyViewMemberList(self, "_friendItemList")
	TaskDispatcher.cancelTask(self._refreshTime, self)
end

function TurnBackFullView:_create_TurnBackFullViewFriendItem(index, go)
	local item = TurnBackFullViewFriendItem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(go or gohelper.cloneInPlace(self._goplayer1))

	return item
end

function TurnBackFullView:disposeLoader()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	for _, item in ipairs(self._friendItemList or {}) do
		if item then
			item:disposeLoader()
		end
	end
end

return TurnBackFullView
