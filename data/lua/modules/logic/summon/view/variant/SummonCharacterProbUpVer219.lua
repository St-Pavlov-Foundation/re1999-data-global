module("modules.logic.summon.view.variant.SummonCharacterProbUpVer219", package.seeall)

local var_0_0 = class("SummonCharacterProbUpVer219", SummonMainCharacterProbUp)

var_0_0.preloadList = {
	"singlebg/summon/heroversion_newplayer/sufubi/sufubi_newplayer_fullbg.png",
	"singlebg/summon/heroversion_newplayer/sufubi/sufubi_newplayer_role.png"
}

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_bg")
	arg_1_0._simagead3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_ad3")
	arg_1_0._simagead3dec = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_ad3dec")
	arg_1_0._charaterItemCount = 1

	var_0_0.super._editableInitView(arg_1_0)
end

function var_0_0.refreshSingleImage(arg_2_0)
	arg_2_0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function var_0_0.unloadSingleImage(arg_3_0)
	arg_3_0._simagebg:UnLoadImage()
	arg_3_0._simagead3:UnLoadImage()
	arg_3_0._simagead3dec:UnLoadImage()
	arg_3_0._simageline:UnLoadImage()
	arg_3_0._simagecurrency1:UnLoadImage()
	arg_3_0._simagecurrency10:UnLoadImage()
end

return var_0_0
