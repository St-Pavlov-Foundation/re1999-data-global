-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer258.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer258", package.seeall)

local SummonCharacterProbUpVer258 = class("SummonCharacterProbUpVer258", SummonMainCharacterProbUp)

SummonCharacterProbUpVer258.preloadList = {
	"singlebg/summon/heroversion_2_5/v2a5_saimeierweisi/v2a5_summon_saimeierweisi_fullbg.png",
	"singlebg/summon/heroversion_2_5/v2a5_saimeierweisi/v2a5_summon_saimeierweisi_role1.png",
	"singlebg/summon/heroversion_2_5/v2a5_saimeierweisi/v2a5_summon_saimeierweisi_dec.png"
}

function SummonCharacterProbUpVer258:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagerole1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node1/#simage_role1")
	self._simagerole3 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/root/#simage_role3")
	self._simagerole2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/root/#simage_role2")
	self._simagefrontbg1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_frontbg1")
	self._charaterItemCount = 1

	SummonCharacterProbUpVer258.super._editableInitView(self)
end

function SummonCharacterProbUpVer258:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer258:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simagerole1:UnLoadImage()
	self._simagerole3:UnLoadImage()
	self._simagerole2:UnLoadImage()
	self._simagefrontbg1:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonCharacterProbUpVer258
