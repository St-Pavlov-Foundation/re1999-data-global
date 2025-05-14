module("modules.logic.summon.view.variant.SummonCharacterProbUpVer196", package.seeall)

local var_0_0 = class("SummonCharacterProbUpVer196", SummonMainCharacterProbUp)

var_0_0.preloadList = {
	"singlebg/summon/heroversion_1_3/rabbit/full/v1a5_rabbit_newplayerbg.png"
}

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_bg")
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
	arg_3_0._g:UnLoadImage()
	arg_3_0._rrow:UnLoadImage()
	arg_3_0._simageline:UnLoadImage()
	arg_3_0._simagecurrency1:UnLoadImage()
	arg_3_0._simagecurrency10:UnLoadImage()
end

return var_0_0
