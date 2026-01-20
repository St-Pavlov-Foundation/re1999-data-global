-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer237.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer237", package.seeall)

local SummonCharacterProbUpVer237 = class("SummonCharacterProbUpVer237", SummonMainCharacterProbUp)

SummonCharacterProbUpVer237.preloadList = {
	"singlebg/summon/heroversion_1_1/full/bg_xt.png",
	"singlebg/summon/heroversion_1_1/xingti/role_xingti.png"
}

function SummonCharacterProbUpVer237:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagead1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node1/#simage_ad1")
	self._simagerole2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/#simage_role2")
	self._simagerole1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/#simage_role1")
	self._simagebottom = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bottom")
	self._charaterItemCount = 1

	SummonCharacterProbUpVer237.super._editableInitView(self)
end

function SummonCharacterProbUpVer237:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer237:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simagead1:UnLoadImage()
	self._simagerole2:UnLoadImage()
	self._simagerole1:UnLoadImage()
	self._simagebottom:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonCharacterProbUpVer237
