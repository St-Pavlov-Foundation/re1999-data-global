-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer188.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer188", package.seeall)

local SummonCharacterProbUpVer188 = class("SummonCharacterProbUpVer188", SummonMainCharacterProbUp)

SummonCharacterProbUpVer188.preloadList = {
	"singlebg/summon/heroversion_1_1/full/bg_xt.png",
	"singlebg/summon/hero/3025.png"
}

function SummonCharacterProbUpVer188:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagead1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node1/#simage_ad1")
	self._simagerole2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/#simage_role2")
	self._simagerole1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/#simage_role1")
	self._simagebottom = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bottom")
	self._charaterItemCount = 1

	SummonCharacterProbUpVer188.super._editableInitView(self)
end

function SummonCharacterProbUpVer188:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer188:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simagead1:UnLoadImage()
	self._simagerole2:UnLoadImage()
	self._simagerole1:UnLoadImage()
	self._simagebottom:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonCharacterProbUpVer188
