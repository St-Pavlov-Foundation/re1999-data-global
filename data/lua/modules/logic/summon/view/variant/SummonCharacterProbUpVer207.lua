module("modules.logic.summon.view.variant.SummonCharacterProbUpVer207", package.seeall)

local var_0_0 = class("SummonCharacterProbUpVer207", SummonMainCharacterProbUp)

var_0_0.preloadList = {
	"singlebg/summon/heroversion_1_2/nimengdishi/full/bg_da.png",
	"singlebg/summon/heroversion_1_2/nimengdishi/anan.png",
	"singlebg/summon/heroversion_1_2/nimengdishi/bg_zhezhao.png"
}

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_bg")
	arg_1_0._simagead3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/node3/#simage_ad3")
	arg_1_0._simagedecorate1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/decorates/#simage_decorate1")
	arg_1_0._simagedecorate2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/decorates/#simage_decorate2")
	arg_1_0._simagefrontbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_frontbg")
	arg_1_0._simageline = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/image_deadline/#txt_deadline/#simage_line")
	arg_1_0._txtdeadline = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/current/image_deadline/#txt_deadline")
	arg_1_0._charaterItemCount = 1

	var_0_0.super._editableInitView(arg_1_0)
end

function var_0_0.refreshSingleImage(arg_2_0)
	arg_2_0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function var_0_0.unloadSingleImage(arg_3_0)
	arg_3_0._simagebg:UnLoadImage()
	arg_3_0._simagead3:UnLoadImage()
	arg_3_0._simagedecorate1:UnLoadImage()
	arg_3_0._simagedecorate2:UnLoadImage()
	arg_3_0._simagefrontbg:UnLoadImage()
	arg_3_0._simageline:UnLoadImage()
	arg_3_0._simageline:UnLoadImage()
	arg_3_0._simagecurrency1:UnLoadImage()
	arg_3_0._simagecurrency10:UnLoadImage()
end

return var_0_0
