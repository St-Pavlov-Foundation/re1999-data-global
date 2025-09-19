module("modules.logic.store.view.DecorateStoreGoodsTipView", package.seeall)

local var_0_0 = class("DecorateStoreGoodsTipView", RoomMaterialTipView)

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)

	arg_1_0._simagetheme = gohelper.findChildSingleImage(arg_1_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/iconmask/simage_theme")
	arg_1_0._goitemContent = gohelper.findChildSingleImage(arg_1_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/go_itemContent")
	arg_1_0._simageinfobg = gohelper.findChildSingleImage(arg_1_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/simage_infobg")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/txt_desc")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/txt_desc/txt_name")
	arg_1_0._goslider = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_slider")
end

function var_0_0._refreshUI(arg_2_0)
	var_0_0.super._refreshUI(arg_2_0)
	gohelper.setActive(arg_2_0._goitemContent.gameObject, false)
	gohelper.setActive(arg_2_0._goslider.gameObject, false)
	arg_2_0._simagetheme:LoadImage(ResUrl.getDecorateStoreBuyBannerFullPath(arg_2_0._config.id), function()
		ZProj.UGUIHelper.SetImageSize(arg_2_0._simagetheme.gameObject)
	end, arg_2_0)

	arg_2_0._txtdesc.text = arg_2_0._config.desc
	arg_2_0._txtname.text = arg_2_0._config.name

	arg_2_0._simageinfobg:LoadImage(ResUrl.getRoomImage("bg_zhezhao_yinying"))
end

function var_0_0.onDestroyView(arg_4_0)
	var_0_0.super.onDestroyView(arg_4_0)
	arg_4_0._simagetheme:UnLoadImage()
	arg_4_0._simageinfobg:UnLoadImage()
end

return var_0_0
