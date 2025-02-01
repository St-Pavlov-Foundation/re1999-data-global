module("modules.logic.summon.view.variant.SummonCharacterProbUpVer124", package.seeall)

slot0 = class("SummonCharacterProbUpVer124", SummonMainCharacterProbUp)
slot0.SIMAGE_COUNT = 3
slot0.preloadList = {
	ResUrl.getSummonCoverBg("heroversion_1_2/jiaxika/full/bg"),
	ResUrl.getSummonCoverBg("heroversion_1_2/jiaxika/full/img_qianjing")
}

function slot0._editableInitView(slot0)
	for slot4 = 1, uv0.SIMAGE_COUNT do
		slot0["_simagead" .. slot4] = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/node" .. slot4 .. "/#simage_ad" .. slot4)
	end

	slot0._txtdeadline = gohelper.findChildText(slot0.viewGO, "#go_ui/current/image_deadline/#txt_deadline")
	slot0._simageline = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/image_deadline/#txt_deadline/#simage_line")
	slot0._charaterItemCount = 2

	uv0.super._editableInitView(slot0)
end

function slot0.refreshSingleImage(slot0)
	slot0._simagebg:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_2/jiaxika/full/bg"))
	slot0._simagead1:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_2/jiaxika/img_juese1"))
	slot0._simagead2:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_2/jiaxika/img_juese2"))
	slot0._simagead3:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_2/jiaxika/img_juese3"))
	slot0._simagefrontbg:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_2/jiaxika/full/img_qianjing"))
	slot0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function slot0.unloadSingleImage(slot0)
	for slot4 = 1, uv0.SIMAGE_COUNT do
		slot0["_simagead" .. slot4]:UnLoadImage()
	end

	slot0._simagebg:UnLoadImage()
	slot0._simagefrontbg:UnLoadImage()
	slot0._simageline:UnLoadImage()
	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
end

return slot0
