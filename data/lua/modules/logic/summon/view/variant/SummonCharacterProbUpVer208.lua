-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer208.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer208", package.seeall)

local SummonCharacterProbUpVer208 = class("SummonCharacterProbUpVer208", SummonMainCharacterProbUp)

SummonCharacterProbUpVer208.preloadList = {
	"singlebg/summon/heroversion_1_9/getian/v1a9_getian_summon_fullbg.png",
	"singlebg/summon/heroversion_1_9/getian/v1a9_getian_summon_role1.png",
	"singlebg/summon/heroversion_1_9/getian/v1a9_getian_summon_fontbg.png"
}

function SummonCharacterProbUpVer208:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagerole1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node1/#simage_role1")
	self._simagelight = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node1/#simage_light")
	self._simagerole2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/#simage_role2")
	self._simagerole3 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/#simage_role3")
	self._charaterItemCount = 1

	SummonCharacterProbUpVer208.super._editableInitView(self)
end

function SummonCharacterProbUpVer208:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer208:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simagerole1:UnLoadImage()
	self._simagelight:UnLoadImage()
	self._simagerole2:UnLoadImage()
	self._simagerole3:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonCharacterProbUpVer208
