module("modules.logic.summon.view.variant.SummonCharacterProbUpVer178", package.seeall)

local var_0_0 = class("SummonCharacterProbUpVer178", SummonMainCharacterProbUp)

var_0_0.preloadList = {
	"singlebg/summon/heroversion_1_1/full/bg_hnj.png",
	"singlebg/summon/heroversion_1_1/hongnujian/img_role_hongnujian.png"
}

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_bg")
	arg_1_0._simagead1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/node1/#simage_ad1")
	arg_1_0._mgcirbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/node2/img_cirbg")
	arg_1_0._simagead2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/node2/#simage_ad2")
	arg_1_0._simagead3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/node2/#simage_ad3")
	arg_1_0._mgcirbgoutline = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/node2/img_cirbgoutline")
	arg_1_0._ip = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/tip")
	arg_1_0._g = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/tip/bg")
	arg_1_0._rrow = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/tip/arrow/arrow")
	arg_1_0._charaterItemCount = 1

	var_0_0.super._editableInitView(arg_1_0)
end

function var_0_0.refreshSingleImage(arg_2_0)
	arg_2_0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function var_0_0.unloadSingleImage(arg_3_0)
	arg_3_0._simagebg:UnLoadImage()
	arg_3_0._simagead1:UnLoadImage()
	arg_3_0._mgcirbg:UnLoadImage()
	arg_3_0._simagead2:UnLoadImage()
	arg_3_0._simagead3:UnLoadImage()
	arg_3_0._mgcirbgoutline:UnLoadImage()
	arg_3_0._ip:UnLoadImage()
	arg_3_0._g:UnLoadImage()
	arg_3_0._rrow:UnLoadImage()
	arg_3_0._simageline:UnLoadImage()
	arg_3_0._simagecurrency1:UnLoadImage()
	arg_3_0._simagecurrency10:UnLoadImage()
end

return var_0_0
