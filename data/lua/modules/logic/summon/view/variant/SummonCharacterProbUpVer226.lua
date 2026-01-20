-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer226.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer226", package.seeall)

local SummonCharacterProbUpVer226 = class("SummonCharacterProbUpVer226", SummonMainCharacterProbUp)

SummonCharacterProbUpVer226.preloadList = {
	"singlebg/summon/heroversion_2_0/galapona/full/v2a0_galapona_bg.png",
	"singlebg/summon/heroversion_2_0/galapona/v2a0_galapona_summon_dec2.png",
	"singlebg/summon/heroversion_2_0/galapona/v2a0_galapona_summon_dec2.png",
	"singlebg/summon/heroversion_2_0/galapona/v2a0_galapona_summon_dec1.png",
	"singlebg/summon/heroversion_2_0/galapona/v2a0_galapona_summon_dec1.png",
	"singlebg/summon/heroversion_2_0/galapona/v2a0_galapona_role1.png",
	"singlebg/summon/heroversion_2_0/galapona/full/v2a0_galapona_dec.png",
	"singlebg/summon/heroversion_2_0/galapona/v2a0_galapona_line1.png",
	"singlebg/summon/heroversion_2_0/galapona/v2a0_galapona_line3.png"
}

function SummonCharacterProbUpVer226:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagedec1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_dec1")
	self._simagedec1glow = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_dec1/#simage_dec1_glow")
	self._simagedec2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_dec2")
	self._simagedec2glow = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_dec2/#simage_dec2_glow")
	self._simagead1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node1/#simage_ad1")
	self._simagerole2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/#simage_role2")
	self._simagerole1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/#simage_role1")
	self._simageforeground = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_foreground")
	self._simageline1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_line1")
	self._simageline2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_line2")
	self._simageline3 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_line3")
	self._simageline4 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_line4")
	self._simageline5 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_line5")
	self._ip = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/tip/tip")
	self._charaterItemCount = 1

	SummonCharacterProbUpVer226.super._editableInitView(self)
end

function SummonCharacterProbUpVer226:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer226:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simagedec1:UnLoadImage()
	self._simagedec1glow:UnLoadImage()
	self._simagedec2:UnLoadImage()
	self._simagedec2glow:UnLoadImage()
	self._simagead1:UnLoadImage()
	self._simagerole2:UnLoadImage()
	self._simagerole1:UnLoadImage()
	self._simageforeground:UnLoadImage()
	self._simageline1:UnLoadImage()
	self._simageline2:UnLoadImage()
	self._simageline3:UnLoadImage()
	self._simageline4:UnLoadImage()
	self._simageline5:UnLoadImage()
	self._ip:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonCharacterProbUpVer226
