-- chunkname: @modules/logic/mainuiswitch/view/MainUIPartView.lua

module("modules.logic.mainuiswitch.view.MainUIPartView", package.seeall)

local MainUIPartView = class("MainUIPartView", BaseView)

function MainUIPartView:onInitView()
	self._goactbottomDec = gohelper.findChild(self.viewGO, "bottom/#go_contentbg/act_bottomDec")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainUIPartView:addEvents()
	self:addEventCb(MainUISwitchController.instance, MainUISwitchEvent.UseMainUI, self.refreshMainUI, self)
	self:addEventCb(MainController.instance, MainEvent.SetMainViewVisible, self._setViewVisible, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._OnCloseViewFinish, self, LuaEventSystem.Low)
end

function MainUIPartView:removeEvents()
	self:removeEventCb(MainUISwitchController.instance, MainUISwitchEvent.UseMainUI, self.refreshMainUI, self)
	self:removeEventCb(MainController.instance, MainEvent.SetMainViewVisible, self._setViewVisible, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._OnCloseViewFinish, self, LuaEventSystem.Low)
end

function MainUIPartView:_OnCloseViewFinish(viewName)
	if viewName == ViewName.LoadingView then
		self:_setViewVisible(true)
	end
end

function MainUIPartView:_setViewVisible(value)
	if value and self._uiId then
		if self._uiId == MainUISwitchEnum.Skin.Normal then
			if not self._aniroommask then
				local goani = gohelper.findChild(self.viewGO, "right/#btn_summon/1/mask/image")

				self._aniroommask = goani:GetComponent(typeof(UnityEngine.Animation))
			end

			self._aniroommask:Play()
		else
			if not self._aniroommask1 then
				local goani = gohelper.findChild(self.viewGO, "right/#btn_summon/2/icon/mask1/image")

				self._aniroommask1 = goani:GetComponent(typeof(UnityEngine.Animator))
			end

			self._aniroommask1:Play("in", 0, 0)
		end
	end
end

function MainUIPartView:onOpen()
	local skinId = self.viewParam and self.viewParam.SkinId

	self:refreshMainUI(skinId)
end

function MainUIPartView:_editableInitView()
	local anim = gohelper.findChild(self.viewGO, "right/#btn_role/2/act_rolehead/ani")

	self._imagerolehead = gohelper.findChildImage(anim, "act_rolehead")
	self._animrolehead = anim:GetComponent(typeof(UnityEngine.Animator))
end

function MainUIPartView:_initMainUIPart()
	local gomail = gohelper.findChild(self.viewGO, "left/#btn_mail")
	local gostorage = gohelper.findChild(self.viewGO, "left/#btn_storage")
	local goquest = gohelper.findChild(self.viewGO, "left/#btn_quest/btn")
	local gobank = gohelper.findChild(self.viewGO, "left/#btn_bank")
	local gobankeffect = gohelper.findChild(self.viewGO, "left/#btn_bank/#go_bankeffect")
	local goroom = gohelper.findChild(self.viewGO, "right/#btn_room")
	local gorole = gohelper.findChild(self.viewGO, "right/#btn_role")
	local gosummon = gohelper.findChild(self.viewGO, "right/#btn_summon")
	local gopower = gohelper.findChild(self.viewGO, "right/#btn_power")
	local gofight = gohelper.findChild(self.viewGO, "right/go_fight")
	local goactivityfight = gohelper.findChild(self.viewGO, "right/go_fight/#go_activityfight/#btn_fight")
	local gonormaljumpfight = gohelper.findChild(self.viewGO, "right/go_fight/#go_normalfight/#btn_jumpfight")
	local gonormalfight = gohelper.findChild(self.viewGO, "right/go_fight/#go_normalfight/#btn_fight")

	self._mainUIParts = self:getUserDataTb_()

	for _, skinId in pairs(MainUISwitchEnum.Skin) do
		local skinTb = self._mainUIParts[skinId]

		if not skinTb then
			skinTb = self:getUserDataTb_()
			self._mainUIParts[skinId] = skinTb
		end

		skinTb[MainUISwitchEnum.MainUIPart.Mail] = gohelper.findChild(gomail, skinId)
		skinTb[MainUISwitchEnum.MainUIPart.Quest] = gohelper.findChild(gostorage, skinId)
		skinTb[MainUISwitchEnum.MainUIPart.Storage] = gohelper.findChild(goquest, skinId)
		skinTb[MainUISwitchEnum.MainUIPart.Bank] = gohelper.findChild(gobank, skinId)
		skinTb[MainUISwitchEnum.MainUIPart.Room] = gohelper.findChild(goroom, skinId)
		skinTb[MainUISwitchEnum.MainUIPart.Role] = gohelper.findChild(gorole, skinId)
		skinTb[MainUISwitchEnum.MainUIPart.Summon] = gohelper.findChild(gosummon, skinId)
		skinTb[MainUISwitchEnum.MainUIPart.Power] = gohelper.findChild(gopower, skinId)
		skinTb[MainUISwitchEnum.MainUIPart.Fight] = gohelper.findChild(gofight, skinId)
		skinTb[MainUISwitchEnum.MainUIPart.ActivityFight] = gohelper.findChild(goactivityfight, skinId)
		skinTb[MainUISwitchEnum.MainUIPart.NormalFight] = gohelper.findChild(gonormalfight, skinId)
		skinTb[MainUISwitchEnum.MainUIPart.NormalJumpFight] = gohelper.findChild(gonormaljumpfight, skinId)
		skinTb[MainUISwitchEnum.MainUIPart.BankEffect] = gohelper.findChild(gobankeffect, skinId)
	end
end

function MainUIPartView:refreshMainUI(id)
	id = id or MainUISwitchModel.instance:getCurUseUI()

	if self._uiId == id then
		return
	end

	self._uiId = id
	self._bankeffect = 1

	if not self._mainUIParts then
		self:_initMainUIPart()
	end

	for _, skinId in pairs(MainUISwitchEnum.Skin) do
		local skinTb = self._mainUIParts[skinId]

		for _, part in pairs(MainUISwitchEnum.MainUIPart) do
			local obj = skinTb[part]

			if id == skinId then
				obj = obj or self._mainUIParts[MainUISwitchEnum.Skin.Normal][part]

				gohelper.setActive(obj, true)
			elseif self._mainUIParts[id] then
				local skinObj = self._mainUIParts[id][part]

				skinObj = skinObj or self._mainUIParts[MainUISwitchEnum.Skin.Normal][part]

				if obj and skinObj and skinObj ~= obj then
					gohelper.setActive(obj, false)
				end
			end
		end
	end

	gohelper.setActive(self._goactbottomDec, id == MainUISwitchEnum.Skin.Sp01)
	TaskDispatcher.cancelTask(self._cutRoleHead, self)

	if id == MainUISwitchEnum.Skin.Sp01 then
		self:_delayCutHead()
		TaskDispatcher.runRepeat(self._cutRoleHead, self, MainUISwitchEnum.HeadCutTime)
	end

	self:_setViewVisible(true)
end

function MainUIPartView:_cutRoleHead()
	self._animrolehead:Play(MainUISwitchEnum.AnimName.Switch, 0, 0)
	TaskDispatcher.cancelTask(self._delayCutHead, self)
	TaskDispatcher.runDelay(self._delayCutHead, self, MainUISwitchEnum.HeadCutLoadime)
end

function MainUIPartView:_delayCutHead()
	local random = math.random(1, 3)

	UISpriteSetMgr.instance:setMainSprite(self._imagerolehead, "main_act_rolehead_" .. random, true)
end

function MainUIPartView:onClose()
	TaskDispatcher.cancelTask(self._cutRoleHead, self)
	TaskDispatcher.cancelTask(self._delayCutHead, self)
end

function MainUIPartView:onDestroyView()
	return
end

return MainUIPartView
