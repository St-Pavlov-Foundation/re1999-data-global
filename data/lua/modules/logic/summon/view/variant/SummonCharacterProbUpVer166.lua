-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer166.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer166", package.seeall)

local SummonCharacterProbUpVer166 = class("SummonCharacterProbUpVer166", SummonMainCharacterProbUp)

SummonCharacterProbUpVer166.preloadList = {
	"singlebg/summon/heroversion_1_6/v1a6_meilanni/v1a6_rolemeilanni_summon_fullbg.png",
	"singlebg/summon/heroversion_1_1/bg_zsz.png",
	"singlebg/summon/heroversion_1_6/v1a6_meilanni/v1a6_rolemeilanni_summon_role1.png"
}

function SummonCharacterProbUpVer166:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagem = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_m")
	self._simagerole2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/pos/#simage_role2")
	self._simagerole1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/pos/#simage_role1")
	self._simagead1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node1/#simage_ad1")
	self._charaterItemCount = 1

	SummonCharacterProbUpVer166.super._editableInitView(self)
end

function SummonCharacterProbUpVer166:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer166:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simagem:UnLoadImage()
	self._simagerole2:UnLoadImage()
	self._simagerole1:UnLoadImage()
	self._simagead1:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonCharacterProbUpVer166
