-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer238.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer238", package.seeall)

local SummonCharacterProbUpVer238 = class("SummonCharacterProbUpVer238", SummonMainCharacterProbUp)

SummonCharacterProbUpVer238.preloadList = {
	"singlebg/summon/heroversion_1_5/v1a5_weixiukai/v1a5_weixiukai_summon_fullbg.png",
	"singlebg/summon/heroversion_1_5/v1a5_weixiukai/v1a5_weixiukai_summon_frontbg.png",
	"singlebg/summon/heroversion_1_5/v1a5_weixiukai/v1a5_roleweixiukai_summon_role1.png",
	"singlebg/summon/hero/full/mask.png"
}

function SummonCharacterProbUpVer238:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagefrontbg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_frontbg")
	self._simagerole1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/#simage_role1")
	self._simagerole2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/#simage_role2")
	self._simagead1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node1/#simage_ad1")
	self._simageleftdown = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_leftdown")
	self._simagerighttop = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_righttop")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_mask")
	self._simageline = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/image_deadline/#txt_deadline/#simage_line")
	self._txtdeadline = gohelper.findChildText(self.viewGO, "#go_ui/current/image_deadline/#txt_deadline")
	self._charaterItemCount = 1

	SummonCharacterProbUpVer238.super._editableInitView(self)
end

function SummonCharacterProbUpVer238:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer238:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simagefrontbg:UnLoadImage()
	self._simagerole1:UnLoadImage()
	self._simagerole2:UnLoadImage()
	self._simagead1:UnLoadImage()
	self._simageleftdown:UnLoadImage()
	self._simagerighttop:UnLoadImage()
	self._simagemask:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonCharacterProbUpVer238
