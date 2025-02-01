module("modules.logic.summon.view.variant.SummonCharacterProbUpVer116", package.seeall)

slot0 = class("SummonCharacterProbUpVer116", SummonMainCharacterProbUp)
slot0.SIMAGE_COUNT = 3
slot0.preloadList = {
	ResUrl.getSummonCoverBg("heroversion_1_1/full/bg_fjs")
}

function slot0._editableInitView(slot0)
	for slot4 = 2, uv0.SIMAGE_COUNT do
		slot0["_simagead" .. slot4] = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_ad" .. slot4)
	end

	uv0.super._editableInitView(slot0)
end

function slot0.refreshSingleImage(slot0)
	slot0._simagebg:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_1/full/bg_fjs"))
	slot0._simagead2:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_1/fujishen/img_x"))
	slot0._simagead3:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_1/fujishen/img_kaca"))
	slot0._simagefrontbg:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_1/fujishen/img_zhuangshi"))
	slot0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function slot0.unloadSingleImage(slot0)
	for slot4 = 2, uv0.SIMAGE_COUNT do
		slot0["_simagead" .. slot4]:UnLoadImage()
	end

	slot0._simagebg:UnLoadImage()
	slot0._simagefrontbg:UnLoadImage()
	slot0._simageline:UnLoadImage()
	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
end

return slot0
