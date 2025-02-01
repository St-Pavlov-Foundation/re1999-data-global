module("modules.logic.summon.view.variant.SummonCharacterProbUpVer178", package.seeall)

slot0 = class("SummonCharacterProbUpVer178", SummonMainCharacterProbUp)
slot0.preloadList = {
	"singlebg/summon/heroversion_1_1/full/bg_hnj.png",
	"singlebg/summon/heroversion_1_1/hongnujian/img_role_hongnujian.png"
}

function slot0._editableInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_bg")
	slot0._simagead1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/node1/#simage_ad1")
	slot0._mgcirbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/node2/img_cirbg")
	slot0._simagead2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/node2/#simage_ad2")
	slot0._simagead3 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/node2/#simage_ad3")
	slot0._mgcirbgoutline = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/node2/img_cirbgoutline")
	slot0._ip = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/tip")
	slot0._g = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/tip/bg")
	slot0._rrow = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/tip/arrow/arrow")
	slot0._charaterItemCount = 1

	uv0.super._editableInitView(slot0)
end

function slot0.refreshSingleImage(slot0)
	slot0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function slot0.unloadSingleImage(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagead1:UnLoadImage()
	slot0._mgcirbg:UnLoadImage()
	slot0._simagead2:UnLoadImage()
	slot0._simagead3:UnLoadImage()
	slot0._mgcirbgoutline:UnLoadImage()
	slot0._ip:UnLoadImage()
	slot0._g:UnLoadImage()
	slot0._rrow:UnLoadImage()
	slot0._simageline:UnLoadImage()
	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
end

return slot0
