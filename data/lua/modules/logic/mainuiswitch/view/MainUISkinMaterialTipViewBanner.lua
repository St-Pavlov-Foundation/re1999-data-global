module("modules.logic.mainuiswitch.view.MainUISkinMaterialTipViewBanner", package.seeall)

local var_0_0 = class("MainUISkinMaterialTipViewBanner", MainSceneSkinMaterialTipViewBanner)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0._goSceneLogo = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo")
	arg_1_0._goSceneLogo2 = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo2")
	arg_1_0._goSceneLogo3 = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo3")
	arg_1_0._simageSceneLogo4 = gohelper.findChildSingleImage(arg_1_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo4")
end

function var_0_0._createInfoItemUserDataTb_(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:getUserDataTb_()

	var_2_0._go = arg_2_1
	var_2_0._gotag = gohelper.findChild(arg_2_1, "#go_tag")
	var_2_0._txtdesc = gohelper.findChildText(arg_2_1, "txt_desc")
	var_2_0._txtname = gohelper.findChildText(arg_2_1, "txt_desc/txt_name")
	var_2_0._simageinfobg = gohelper.findChildSingleImage(arg_2_1, "#simage_pic")
	var_2_0._btn = gohelper.findChildButtonWithAudio(arg_2_1, "txt_desc/txt_name/#btn_Info")

	var_2_0._btn:AddClickListener(arg_2_0._clickCheckBtn, arg_2_0, var_2_0)

	arg_2_0._infoItemTbList = arg_2_0._infoItemTbList or {}

	table.insert(arg_2_0._infoItemTbList, var_2_0)

	return var_2_0
end

function var_0_0._clickCheckBtn(arg_3_0, arg_3_1)
	if not arg_3_1._uiSkinId then
		return
	end

	if arg_3_0._classify == MainSwitchClassifyEnum.Classify.UI then
		MainUISwitchController.instance:openMainUISwitchInfoView(arg_3_1._uiSkinId, true, true)
	elseif arg_3_0._classify == MainSwitchClassifyEnum.Classify.Click then
		ClickUISwitchController.instance:openClickUISwitchInfoView(arg_3_1._uiSkinId, true, true)
	end
end

function var_0_0._updateInfoItemUI(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_1
	local var_4_1 = ItemModel.instance:getItemConfig(arg_4_3, arg_4_2)

	var_4_0._txtdesc.text = var_4_1.desc
	var_4_0._txtname.text = var_4_1.name

	gohelper.setActive(var_4_0._gotag, true)

	local var_4_2 = arg_4_0:_getUIConfig(arg_4_2)

	var_4_0._uiSkinId = var_4_2.id

	local var_4_3 = arg_4_0._classify == MainSwitchClassifyEnum.Classify.Click and ResUrl.getMainSceneSwitchIcon(var_4_2.previewIcon) or ResUrl.getMainSceneSwitchLangIcon(var_4_2.previewIcon)

	var_4_0._simageinfobg:LoadImage(var_4_3)
end

function var_0_0._refreshTitle(arg_5_0)
	local var_5_0 = MainSwitchClassifyEnum.ClassifyShowInfo[arg_5_0._classify].TitleLogo

	arg_5_0._simageSceneLogo4:LoadImage(ResUrl.getMainSceneSwitchLangIcon(var_5_0))
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._infoItemDataList = {}
	arg_6_0._classify = MainSwitchClassifyEnum.Classify.UI
	arg_6_0._itemSubType = ItemModel.instance:getItemConfig(arg_6_0.viewParam.type, arg_6_0.viewParam.id).subType

	tabletool.addValues(arg_6_0._infoItemDataList, arg_6_0:_getItemDataList())
	arg_6_0:_refreshUI()
	arg_6_0:_startAutoSwitch()
	gohelper.setActive(arg_6_0._goSceneLogo, false)
	gohelper.setActive(arg_6_0._goSceneLogo2, false)
	gohelper.setActive(arg_6_0._goSceneLogo3, false)
	gohelper.setActive(arg_6_0._simageSceneLogo4.gameObject, true)
	arg_6_0:_refreshTitle()
end

function var_0_0._getUIConfig(arg_7_0, arg_7_1)
	local var_7_0 = MainUISwitchConfig.instance:getUISwitchCoByItemId(arg_7_1)

	if var_7_0 then
		arg_7_0._classify = MainSwitchClassifyEnum.Classify.UI
	else
		arg_7_0._classify = MainSwitchClassifyEnum.Classify.Click
		var_7_0 = ClickUISwitchConfig.instance:getClickUICoByItemId(arg_7_1)
	end

	return var_7_0
end

function var_0_0.onDestroyView(arg_8_0)
	var_0_0.super.onDestroyView(arg_8_0)
	arg_8_0._simageSceneLogo4:UnLoadImage()
end

return var_0_0
