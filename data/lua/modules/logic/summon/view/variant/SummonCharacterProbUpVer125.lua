module("modules.logic.summon.view.variant.SummonCharacterProbUpVer125", package.seeall)

slot0 = class("SummonCharacterProbUpVer125", SummonMainCharacterProbUp)
slot0.SIMAGE_COUNT = 3
slot0.preloadList = {
	ResUrl.getSummonCoverBg("heroversion_1_2/yaxian/full/img_bg"),
	ResUrl.getSummonCoverBg("heroversion_1_2/yaxian/img_qianjing")
}
slot0.decoCount = 9

function slot0._editableInitView(slot0)
	for slot4 = 1, uv0.SIMAGE_COUNT do
		slot0["_simagead" .. slot4] = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/node" .. slot4 .. "/#simage_ad" .. slot4)
	end

	for slot5 = 1, uv0.decoCount do
		slot0["_simagedecorate" .. slot5] = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/decorates/#simage_decorate" .. slot5)
	end

	slot0._txtdeadline = gohelper.findChildText(slot0.viewGO, "#go_ui/current/image_deadline/#txt_deadline")
	slot0._simageline = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/image_deadline/#txt_deadline/#simage_line")
	slot0._charaterItemCount = 2

	uv0.super._editableInitView(slot0)
end

function slot0.refreshSingleImage(slot0)
	slot0._simagebg:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_2/yaxian/full/img_bg"))
	slot0._simagead1:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_2/yaxian/img_juese3"))
	slot0._simagead2:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_2/yaxian/img_juese1"))
	slot0._simagead3:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_2/yaxian/img_juese2"))
	slot0._simagefrontbg:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_2/yaxian/img_qianjing"))

	for slot5 = 1, uv0.decoCount - 1 do
		slot0["_simagedecorate" .. slot5]:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_2/yaxian/img_xian" .. tostring(slot5)))
	end

	slot0._simagedecorate9:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_2/yaxian/img_xiaoren"))
	slot0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function slot0.unloadSingleImage(slot0)
	for slot4 = 1, uv0.SIMAGE_COUNT do
		slot0["_simagead" .. slot4]:UnLoadImage()
	end

	slot0._simagebg:UnLoadImage()
	slot0._simagefrontbg:UnLoadImage()
	slot0._simageline:UnLoadImage()

	for slot5 = 1, uv0.decoCount do
		if slot0["_simagedecorate" .. slot5] then
			slot6:UnLoadImage()
		end
	end

	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
end

return slot0
