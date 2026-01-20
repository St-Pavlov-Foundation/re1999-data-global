-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer247.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer247", package.seeall)

local SummonCharacterProbUpVer247 = class("SummonCharacterProbUpVer247", SummonMainCharacterProbUp)

SummonCharacterProbUpVer247.preloadList = {
	"singlebg/summon/heroversion_1_8/v1a8_windsong/v1a8_windsong_summon_fullbg.png",
	"singlebg/summon/heroversion_1_8/v1a8_windsong/v1a8_windsong_summon_role1.png",
	"singlebg/summon/heroversion_1_8/v1a8_windsong/v1a8_windsong_summon_dec2.png"
}

function SummonCharacterProbUpVer247:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagead1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node1/#simage_ad1")
	self._simagerole1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/#simage_role1")
	self._simagerole2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/#simage_role2")
	self._simagelight = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_light")
	self._simagemiddle = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_middle")
	self._charaterItemCount = 1

	SummonCharacterProbUpVer247.super._editableInitView(self)
end

function SummonCharacterProbUpVer247:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer247:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simagead1:UnLoadImage()
	self._simagerole1:UnLoadImage()
	self._simagerole2:UnLoadImage()
	self._simagelight:UnLoadImage()
	self._simagemiddle:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonCharacterProbUpVer247
