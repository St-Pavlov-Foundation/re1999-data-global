-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer197.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer197", package.seeall)

local SummonCharacterProbUpVer197 = class("SummonCharacterProbUpVer197", SummonMainCharacterProbUp)

SummonCharacterProbUpVer197.preloadList = {
	"singlebg/summon/heroversion_1_9/yuanlv/v1a9_yuanlv_summon_fullbg.png",
	"singlebg/summon/heroversion_1_9/yuanlv/v1a9_yuanlv_summon_role1.png",
	"singlebg/summon/heroversion_1_9/yuanlv/v1a9_yuanlv_summon_mask.png"
}

function SummonCharacterProbUpVer197:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagead1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node1/#simage_ad1")
	self._simagerole3 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/#simage_role3")
	self._simagerole2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/#simage_role2")
	self._simagefrontbg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_frontbg")
	self._charaterItemCount = 1

	SummonCharacterProbUpVer197.super._editableInitView(self)
end

function SummonCharacterProbUpVer197:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer197:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simagead1:UnLoadImage()
	self._simagerole3:UnLoadImage()
	self._simagerole2:UnLoadImage()
	self._simagefrontbg:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonCharacterProbUpVer197
