module("modules.logic.summon.view.variant.SummonCharacterProbUpVer245", package.seeall)

local var_0_0 = class("SummonCharacterProbUpVer245", SummonCharacterProbDoubleUpBase)

var_0_0.preloadList = {
	"singlebg/summon/heroversion_2_4/v2a4_lake/v2a4_lake_fullbg.png",
	"singlebg/summon/heroversion_2_4/v2a4_lake/v2a4_lake_role2.png",
	"singlebg/summon/heroversion_2_4/v2a4_lake/v2a4_lake_fullmake.png"
}

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_bg")
	arg_1_0._simagead2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_ad2")
	arg_1_0._simagead1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_ad1")
	arg_1_0._simagefullmask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_fullmask")
	arg_1_0._charaterItemCount = 2

	var_0_0.super._editableInitView(arg_1_0)
end

function var_0_0.refreshSingleImage(arg_2_0)
	arg_2_0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function var_0_0.unloadSingleImage(arg_3_0)
	arg_3_0._simagebg:UnLoadImage()
	arg_3_0._simagead2:UnLoadImage()
	arg_3_0._simagead1:UnLoadImage()
	arg_3_0._simagefullmask:UnLoadImage()
	arg_3_0._simageline:UnLoadImage()
	arg_3_0._simagecurrency1:UnLoadImage()
	arg_3_0._simagecurrency10:UnLoadImage()
end

return var_0_0
