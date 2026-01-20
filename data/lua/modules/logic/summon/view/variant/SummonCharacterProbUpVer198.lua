-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer198.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer198", package.seeall)

local SummonCharacterProbUpVer198 = class("SummonCharacterProbUpVer198", SummonMainCharacterProbUp)

SummonCharacterProbUpVer198.preloadList = {
	"singlebg/summon/heroversion_1_9/yaxian/v1a9_yaxian_summon_fullbg.png",
	"singlebg/summon/heroversion_1_9/yaxian/v1a9_yaxian_summon_role1.png",
	"singlebg/summon/heroversion_1_9/yaxian/v1a9_yaxian_summon_fontbg.png"
}

function SummonCharacterProbUpVer198:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagead1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node1/#simage_ad1")
	self._simagerole1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/#simage_role1")
	self._simagerole2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/#simage_role2")
	self._simagefrontbg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_frontbg")
	self._simageline = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/image_deadline/#txt_deadline/#simage_line")
	self._txtdeadline = gohelper.findChildText(self.viewGO, "#go_ui/current/image_deadline/#txt_deadline")
	self._charaterItemCount = 1

	SummonCharacterProbUpVer198.super._editableInitView(self)
end

function SummonCharacterProbUpVer198:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer198:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simagead1:UnLoadImage()
	self._simagerole1:UnLoadImage()
	self._simagerole2:UnLoadImage()
	self._simagefrontbg:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonCharacterProbUpVer198
