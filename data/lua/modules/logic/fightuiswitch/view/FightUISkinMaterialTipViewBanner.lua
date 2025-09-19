module("modules.logic.fightuiswitch.view.FightUISkinMaterialTipViewBanner", package.seeall)

local var_0_0 = class("FightUISkinMaterialTipViewBanner", MainSceneSkinMaterialTipViewBanner)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0._goSceneLogo = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo")
	arg_1_0._goSceneLogo2 = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo2")
	arg_1_0._goSceneLogo3 = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo3")
	arg_1_0._goSceneLogo4 = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo4")
end

function var_0_0._createInfoItemUserDataTb_(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:getUserDataTb_()

	var_2_0._go = arg_2_1
	var_2_0._gotag = gohelper.findChild(arg_2_1, "#go_tag")
	var_2_0._gotag2 = gohelper.findChild(arg_2_1, "#go_tag2")
	var_2_0._txtdesc = gohelper.findChildText(arg_2_1, "txt_desc")
	var_2_0._txtname = gohelper.findChildText(arg_2_1, "txt_desc/txt_name")
	var_2_0._simageinfobg = gohelper.findChildSingleImage(arg_2_1, "#simage_pic")
	var_2_0._btn = gohelper.findChildButtonWithAudio(arg_2_1, "txt_desc/txt_name/#btn_Info")
	arg_2_0._infoItemTbList = arg_2_0._infoItemTbList or {}

	table.insert(arg_2_0._infoItemTbList, var_2_0)

	return var_2_0
end

function var_0_0._updateInfoItemUI(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_1
	local var_3_1 = ItemModel.instance:getItemConfig(arg_3_3, arg_3_2)

	var_3_0._txtdesc.text = var_3_1.desc
	var_3_0._txtname.text = var_3_1.name

	gohelper.setActive(var_3_0._gotag, false)
	gohelper.setActive(var_3_0._gotag2, true)
	arg_3_0:_addClickFightUI(var_3_0._btn, arg_3_2)

	local var_3_2 = FightUISwitchModel.instance:getStyleMoByItemId(arg_3_2)

	if var_3_2 then
		var_3_0._uiSkinId = var_3_2.id

		if not string.nilorempty(var_3_2.co.previewImage) then
			var_3_0._simageinfobg:LoadImage(ResUrl.getMainSceneSwitchIcon(var_3_2.co.previewImage))
		end
	end
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0._infoItemDataList = {}
	arg_4_0._itemSubType = ItemModel.instance:getItemConfig(arg_4_0.viewParam.type, arg_4_0.viewParam.id).subType

	tabletool.addValues(arg_4_0._infoItemDataList, arg_4_0:_getItemDataList())
	arg_4_0:_refreshUI()
	arg_4_0:_startAutoSwitch()
	gohelper.setActive(arg_4_0._goSceneLogo, false)
	gohelper.setActive(arg_4_0._goSceneLogo2, false)
	gohelper.setActive(arg_4_0._goSceneLogo3, false)
	gohelper.setActive(arg_4_0._goSceneLogo4, true)
end

function var_0_0._addClickFightUI(arg_5_0, arg_5_1, arg_5_2)
	arg_5_1:RemoveClickListener()
	arg_5_1:AddClickListener(function()
		FightUISwitchController.instance:openSceneView(arg_5_2)
	end, arg_5_0)
end

return var_0_0
