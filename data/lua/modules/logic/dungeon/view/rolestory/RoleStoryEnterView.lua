-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryEnterView.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryEnterView", package.seeall)

local RoleStoryEnterView = class("RoleStoryEnterView", VersionActivityEnterBaseSubView)

function RoleStoryEnterView:onInitView()
	self._txttime = gohelper.findChildTextMesh(self.viewGO, "Left/#txt_LimitTime")
	self._btnenter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Enter")
	self._goreddot = gohelper.findChild(self.viewGO, "Right/#btn_Enter/#image_reddot")
	self._simagephoto = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Photo")
	self._gorewardcontent = gohelper.findChild(self.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	self._txttitle = gohelper.findChildTextMesh(self.viewGO, "Left/Title/#txt_Title")
	self._txttitleen = gohelper.findChildTextMesh(self.viewGO, "Left/Title/#txt_Titleen")
	self._simagesignature = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_signature")
	self.rewardItems = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoleStoryEnterView:addEvents()
	self._btnenter:AddClickListener(self._onClickEnter, self)
end

function RoleStoryEnterView:removeEvents()
	self._btnenter:RemoveClickListener()
end

function RoleStoryEnterView:_editableInitView()
	return
end

function RoleStoryEnterView:onOpen()
	self.actId = self.viewContainer.activityId

	RoleStoryEnterView.super.onOpen(self)
	self:refreshUI()
end

function RoleStoryEnterView:onClose()
	RoleStoryEnterView.super.onClose(self)
end

function RoleStoryEnterView:onDestroyView()
	if self._simagephoto then
		self._simagephoto:UnLoadImage()

		self._simagephoto = nil
	end

	if self.rewardItems then
		for k, v in pairs(self.rewardItems) do
			v:onDestroy()
		end

		self.rewardItems = nil
	end

	if self._simagesignature then
		self._simagesignature:UnLoadImage()

		self._simagesignature = nil
	end
end

function RoleStoryEnterView:refreshUI()
	self:refreshRemainTime()
	self:refreshStory()
end

function RoleStoryEnterView:refreshStory()
	local curStoryId = RoleStoryModel.instance:getCurActStoryId()

	if not curStoryId or curStoryId == 0 then
		curStoryId = RoleStoryConfig.instance:getStoryIdByActivityId(self.actId)
	end

	if curStoryId and curStoryId > 0 then
		local cfg = RoleStoryConfig.instance:getStoryById(curStoryId)

		self:refreshTitle(cfg)

		local photo = cfg.photo

		self._simagephoto:LoadImage(ResUrl.getRoleStoryPhotoIcon(photo))
		self._simagesignature:LoadImage(ResUrl.getSignature(cfg.signature))
	end

	local actCo = ActivityConfig.instance:getActivityCo(self.actId)

	RedDotController.instance:addRedDot(self._goreddot, actCo.redDotId)

	local rewards = GameUtil.splitString2(actCo.activityBonus, true) or {}

	for i = 1, math.max(#rewards, #self.rewardItems) do
		local item = self.rewardItems[i]
		local data = rewards[i]

		if not item then
			item = IconMgr.instance:getCommonPropItemIcon(self._gorewardcontent)

			table.insert(self.rewardItems, item)
		end

		if data then
			gohelper.setActive(item.go, true)
			item:setMOValue(data[1], data[2], data[3] or 1, nil, true)
			item:isShowEquipAndItemCount(false)
			item:hideEquipLvAndBreak(true)
		else
			gohelper.setActive(item.go, false)
		end
	end
end

function RoleStoryEnterView:refreshTitle(cfg)
	if not cfg then
		return
	end

	local name = cfg.name
	local strLen = GameUtil.utf8len(name)
	local first = GameUtil.utf8sub(name, 1, 1)
	local second = ""
	local remain = ""

	if strLen > 1 then
		second = GameUtil.utf8sub(name, 2, 2)
	end

	if strLen > 3 then
		remain = GameUtil.utf8sub(name, 4, strLen - 3)
	end

	self._txttitle.text = string.format("<size=105>%s</size><size=70>%s</size>%s", first, second, remain)
	self._txttitleen.text = cfg.nameEn
end

function RoleStoryEnterView:everySecondCall()
	self:refreshRemainTime()
end

function RoleStoryEnterView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActMO(self.actId)
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	gohelper.setActive(self._txttime, offsetSecond > 0)

	if offsetSecond > 0 then
		local day, hour, min, sec = TimeUtil.secondsToDDHHMMSS(offsetSecond)
		local timeFormat

		if LangSettings.instance:isEn() then
			local kFmt = "<color=#BC5E18>%s</color>%s <color=#BC5E18>%s</color>%s"

			if day > 0 then
				timeFormat = string.format(kFmt, day, luaLang("time_day"), hour, luaLang("time_hour2"))
			elseif hour > 0 then
				timeFormat = string.format(kFmt, hour, luaLang("time_hour2"), min, luaLang("time_minute2"))
			else
				timeFormat = string.format(kFmt, min, luaLang("time_minute2"), sec, luaLang("time_second"))
			end
		elseif day > 0 then
			timeFormat = string.format("<color=#BC5E18>%s</color>%s<color=#BC5E18>%s</color>%s", day, luaLang("time_day"), hour, luaLang("time_hour2"))
		elseif hour > 0 then
			timeFormat = string.format("<color=#BC5E18>%s</color>%s<color=#BC5E18>%s</color>%s", hour, luaLang("time_hour2"), min, luaLang("time_minute2"))
		else
			timeFormat = string.format("<color=#BC5E18>%s</color>%s<color=#BC5E18>%s</color>%s", min, luaLang("time_minute2"), sec, luaLang("time_second"))
		end

		self._txttime.text = string.format("%s%s", luaLang("activity_remain"), timeFormat)
	end
end

function RoleStoryEnterView:_onClickEnter()
	local curStoryId = RoleStoryModel.instance:getCurActStoryId()

	NecrologistStoryController.instance:openGameView(curStoryId)
end

return RoleStoryEnterView
