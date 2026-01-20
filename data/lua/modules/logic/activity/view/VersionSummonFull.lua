-- chunkname: @modules/logic/activity/view/VersionSummonFull.lua

module("modules.logic.activity.view.VersionSummonFull", package.seeall)

local VersionSummonFull = class("VersionSummonFull", VersionSummon_BaseView)

function VersionSummonFull:onInitView()
	self._txtremainTime = gohelper.findChildText(self.viewGO, "image_TimeBG/#txt_remainTime")
	self._btnClaim = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Claim")
	self._goNormal = gohelper.findChild(self.viewGO, "#btn_Claim/#go_Normal")
	self._goReceived = gohelper.findChild(self.viewGO, "#btn_Claim/#go_Received")
	self._simageRole = gohelper.findChildSingleImage(self.viewGO, "#simage_Role")
	self._simageLogo = gohelper.findChildSingleImage(self.viewGO, "#simage_Logo")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "#simage_Title")
	self._simageProp = gohelper.findChildSingleImage(self.viewGO, "prop/image_Prop")
	self._txtTips = gohelper.findChildText(self.viewGO, "txt_Tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionSummonFull:addEvents()
	VersionSummonFull.super.addEvents(self)
	self._btnClaim:AddClickListener(self._btnClaimOnClick, self)
end

function VersionSummonFull:removeEvents()
	VersionSummonFull.super.removeEvents(self)
	self._btnClaim:RemoveClickListener()
end

function VersionSummonFull:_btnClaimOnClick()
	self.viewContainer:sendGet101BonusRequest()
end

function VersionSummonFull:onUpdateParam()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, TimeUtil.OneMinuteSecond)
	self:onRefresh()
end

function VersionSummonFull:onOpen()
	self._txtremainTime.text = ""

	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.ActivityBeginnerView)
	self:internal_onOpen()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, TimeUtil.OneMinuteSecond)
end

function VersionSummonFull:onRefresh()
	self:_refreshTimeTick()

	local isCanGet = self.viewContainer:isType101RewardCouldGetAnyOne()

	gohelper.setActive(self._goNormal, isCanGet)
	gohelper.setActive(self._goReceived, not isCanGet)
end

function VersionSummonFull:_refreshTimeTick()
	self._txtremainTime.text = self.viewContainer:getActRemainTimeStr()
end

function VersionSummonFull:onClose()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function VersionSummonFull:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

return VersionSummonFull
