-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer257.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer257", package.seeall)

local SummonCharacterProbUpVer257 = class("SummonCharacterProbUpVer257", SummonMainCharacterProbUp)

SummonCharacterProbUpVer257.preloadList = {
	"singlebg/summon/heroversion_2_1/weila/v2a1_weila_fullbg.png",
	"singlebg/summon/heroversion_2_1/weila/v2a1_weila_role1.png",
	"singlebg/summon/heroversion_2_1/weila/v2a1_weila_frontbg.png"
}

function SummonCharacterProbUpVer257:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagead1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node1/#simage_ad1")
	self._simagerole1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/#simage_role1")
	self._simagerole2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/#simage_role2")
	self._simagebottom = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bottom")
	self._charaterItemCount = 1

	SummonCharacterProbUpVer257.super._editableInitView(self)
end

function SummonCharacterProbUpVer257:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer257:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simagead1:UnLoadImage()
	self._simagerole1:UnLoadImage()
	self._simagerole2:UnLoadImage()
	self._simagebottom:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonCharacterProbUpVer257
