-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer156.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer156", package.seeall)

local SummonCharacterProbUpVer156 = class("SummonCharacterProbUpVer156", SummonMainCharacterProbUp)

SummonCharacterProbUpVer156.preloadList = {
	"singlebg/summon/heroversion_1_3/rabbit/full/v1a3_rabbit_bg.png"
}

function SummonCharacterProbUpVer156:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagedog = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_dog")
	self._simageround = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/5role/#simage_round")
	self._simagerole1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/5role/#simage_role1")
	self._simagerole2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/5role/#simage_role2")
	self._simagecircle = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/5role/#simage_circle")
	self._g = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/tip/bg")
	self._rrow = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/tip/arrow/arrow")
	self._charaterItemCount = 1

	SummonCharacterProbUpVer156.super._editableInitView(self)
end

function SummonCharacterProbUpVer156:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer156:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simagedog:UnLoadImage()
	self._simageround:UnLoadImage()
	self._simagerole1:UnLoadImage()
	self._simagerole2:UnLoadImage()
	self._simagecircle:UnLoadImage()
	self._g:UnLoadImage()
	self._rrow:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

function SummonCharacterProbUpVer156:_refreshOpenTime()
	self._txtdeadline.text = ""

	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	local poolMO = SummonMainModel.instance:getPoolServerMO(curPool.id)

	if not poolMO then
		return
	end

	local onTs, offTs = poolMO:onOffTimestamp()

	if onTs < offTs and offTs > 0 then
		local remainTime = offTs - ServerTime.now()

		self._txtdeadline.text = formatLuaLang("summonmainequipprobup_deadline", SummonModel.formatRemainTime(remainTime))
	end
end

return SummonCharacterProbUpVer156
