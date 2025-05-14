module("modules.logic.summon.view.variant.SummonCharacterProbUpVer122", package.seeall)

local var_0_0 = class("SummonCharacterProbUpVer122", SummonMainCharacterProbUp)

var_0_0.SIMAGE_COUNT = 3
var_0_0.preloadList = {
	ResUrl.getSummonCoverBg("heroversion_1_2/xinbabieta/full/img_bg")
}

function var_0_0._editableInitView(arg_1_0)
	for iter_1_0 = 1, var_0_0.SIMAGE_COUNT do
		arg_1_0["_simagead" .. iter_1_0] = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_ad" .. iter_1_0)
	end

	var_0_0.super._editableInitView(arg_1_0)
end

function var_0_0.refreshSingleImage(arg_2_0)
	arg_2_0._simagebg:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_2/xinbabieta/full/img_bg"))
	arg_2_0._simagead1:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_2/xinbabieta/img_chara_xbbt"))
	arg_2_0._simagead2:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_2/xinbabieta/img_wx_xl"))
	arg_2_0._simagead3:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_2/xinbabieta/img_wx_mll"))
	arg_2_0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function var_0_0.unloadSingleImage(arg_3_0)
	for iter_3_0 = 1, var_0_0.SIMAGE_COUNT do
		arg_3_0["_simagead" .. iter_3_0]:UnLoadImage()
	end

	arg_3_0._simagebg:UnLoadImage()
	arg_3_0._simageline:UnLoadImage()
	arg_3_0._simagecurrency1:UnLoadImage()
	arg_3_0._simagecurrency10:UnLoadImage()
end

return var_0_0
