-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer217.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer217", package.seeall)

local SummonCharacterProbUpVer217 = class("SummonCharacterProbUpVer217", SummonMainCharacterProbUp)

SummonCharacterProbUpVer217.preloadList = {
	"singlebg/summon/heroversion_1_6/v1a6_zongmaoshali/v1a6_zongmaoshali_fullbg.png",
	"singlebg/summon/heroversion_1_6/v1a6_zongmaoshali/v1a6_zongmaoshali_role1.png",
	"singlebg/summon/heroversion_1_6/v1a6_zongmaoshali/v1a6_zongmaoshali_middlebg.png",
	"singlebg/summon/heroversion_1_6/v1a6_zongmaoshali/v1a6_zongmaoshali_lightbg.png"
}

function SummonCharacterProbUpVer217:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagead1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node1/#simage_ad1")
	self._simagemiddlebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_middlebg")
	self._simagerole2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/pos/#simage_role2")
	self._simagerole1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/pos/#simage_role1")
	self._simagefrontbg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_frontbg")
	self._ip = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/tip/tip")
	self._rrow = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/tip/tip/arrow")
	self._charaterItemCount = 1

	SummonCharacterProbUpVer217.super._editableInitView(self)
end

function SummonCharacterProbUpVer217:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer217:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simagead1:UnLoadImage()
	self._simagemiddlebg:UnLoadImage()
	self._simagerole2:UnLoadImage()
	self._simagerole1:UnLoadImage()
	self._simagefrontbg:UnLoadImage()
	self._ip:UnLoadImage()
	self._rrow:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonCharacterProbUpVer217
