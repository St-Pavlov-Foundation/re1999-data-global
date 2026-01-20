-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer216.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer216", package.seeall)

local SummonCharacterProbUpVer216 = class("SummonCharacterProbUpVer216", SummonMainCharacterProbUp)

SummonCharacterProbUpVer216.preloadList = {
	"singlebg/summon/heroversion_1_4/role37/full/v1a4_role37_summon_bg.png",
	"singlebg/summon/heroversion_1_4/role37/v1a4_role37_summon_37.png"
}

function SummonCharacterProbUpVer216:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagead1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node1/#simage_ad1")
	self._simagerole2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/#simage_role2")
	self._simagerole1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/#simage_role1")
	self._simagefrontbg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_frontbg")
	self._magedec6 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/Dec/image_dec6")
	self._magedec10 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/Dec/image_dec10")
	self._magedec20 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/Dec/image_dec20")
	self._ip = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/tip/tip")
	self._charaterItemCount = 1

	SummonCharacterProbUpVer216.super._editableInitView(self)
end

function SummonCharacterProbUpVer216:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer216:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simagead1:UnLoadImage()
	self._simagerole2:UnLoadImage()
	self._simagerole1:UnLoadImage()
	self._simagefrontbg:UnLoadImage()
	self._magedec6:UnLoadImage()
	self._magedec10:UnLoadImage()
	self._magedec20:UnLoadImage()
	self._ip:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonCharacterProbUpVer216
