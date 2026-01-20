-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer207.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer207", package.seeall)

local SummonCharacterProbUpVer207 = class("SummonCharacterProbUpVer207", SummonMainCharacterProbUp)

SummonCharacterProbUpVer207.preloadList = {
	"singlebg/summon/heroversion_1_2/nimengdishi/full/bg_da.png",
	"singlebg/summon/heroversion_1_2/nimengdishi/anan.png",
	"singlebg/summon/heroversion_1_2/nimengdishi/bg_zhezhao.png"
}

function SummonCharacterProbUpVer207:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagead3 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node3/#simage_ad3")
	self._simagedecorate1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/decorates/#simage_decorate1")
	self._simagedecorate2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/decorates/#simage_decorate2")
	self._simagefrontbg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_frontbg")
	self._simageline = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/image_deadline/#txt_deadline/#simage_line")
	self._txtdeadline = gohelper.findChildText(self.viewGO, "#go_ui/current/image_deadline/#txt_deadline")
	self._charaterItemCount = 1

	SummonCharacterProbUpVer207.super._editableInitView(self)
end

function SummonCharacterProbUpVer207:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer207:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simagead3:UnLoadImage()
	self._simagedecorate1:UnLoadImage()
	self._simagedecorate2:UnLoadImage()
	self._simagefrontbg:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonCharacterProbUpVer207
