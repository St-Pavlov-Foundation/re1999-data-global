module("modules.logic.playercard.view.PlayerCardThemeItem", package.seeall)

local var_0_0 = class("PlayerCardThemeItem", ListScrollCellExtend)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0.simageBg = gohelper.findChildSingleImage(arg_1_0.viewGO, "themeBg")
	arg_1_0.txtName = gohelper.findChildTextMesh(arg_1_0.viewGO, "#txt_name")
	arg_1_0.txtEn = gohelper.findChildTextMesh(arg_1_0.viewGO, "#txt_en")
	arg_1_0.goLocked = gohelper.findChild(arg_1_0.viewGO, "#go_locked")
	arg_1_0.goSelect = gohelper.findChild(arg_1_0.viewGO, "#go_select")
	arg_1_0.goUsing = gohelper.findChild(arg_1_0.viewGO, "#go_using")
	arg_1_0.btnClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "click")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.btnClick:AddClickListener(arg_2_0._onClick, arg_2_0)
	PlayerCardController.instance:registerCallback(PlayerCardEvent.SwitchTheme, arg_2_0.refreshUI, arg_2_0)
	PlayerCardController.instance:registerCallback(PlayerCardEvent.ChangeSkin, arg_2_0.refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	PlayerCardController.instance:unregisterCallback(PlayerCardEvent.SwitchTheme, arg_3_0.refreshUI, arg_3_0)
	PlayerCardController.instance:unregisterCallback(PlayerCardEvent.ChangeSkin, arg_3_0.refreshUI, arg_3_0)
	arg_3_0.btnClick:RemoveClickListener()
end

function var_0_0._onClick(arg_4_0)
	PlayerCardModel.instance:setSelectSkinMO(arg_4_0._mo)
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.SwitchTheme, arg_4_0._mo.id)
end

function var_0_0.refreshUI(arg_5_0)
	local var_5_0 = arg_5_0._skinId == PlayerCardModel.instance:getSelectSkinMO().id

	gohelper.setActive(arg_5_0.goSelect, var_5_0)

	local var_5_1 = arg_5_0._mo:checkIsUse()

	gohelper.setActive(arg_5_0.goUsing, var_5_1)
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0._mo = arg_6_1
	arg_6_0._skinId = arg_6_0._mo:isEmpty() and 0 or arg_6_0._mo.id
	arg_6_0._config = arg_6_0._mo:getConfig()

	if arg_6_0._mo:isEmpty() then
		arg_6_0:refreshEmpty()
	else
		arg_6_0:refreshItem()
	end

	local var_6_0 = arg_6_0._skinId == PlayerCardModel.instance:getSelectSkinMO().id

	gohelper.setActive(arg_6_0.goSelect, var_6_0)

	local var_6_1 = arg_6_0._mo:checkIsUse()

	gohelper.setActive(arg_6_0.goUsing, var_6_1)
end

function var_0_0.refreshEmpty(arg_7_0)
	arg_7_0.txtName.text = luaLang("talent_style_special_tag_998")

	arg_7_0.simageBg:LoadImage(ResUrl.getPlayerCardIcon("banner/" .. arg_7_0._skinId))
	gohelper.setActive(arg_7_0.goLocked, false)
end

function var_0_0.refreshItem(arg_8_0)
	arg_8_0.txtName.text = arg_8_0._config.name
	arg_8_0.txtEn.text = arg_8_0._config.nameEn

	arg_8_0.simageBg:LoadImage(ResUrl.getPlayerCardIcon("banner/" .. arg_8_0._skinId))
	gohelper.setActive(arg_8_0.goLocked, not arg_8_0._mo:isUnLock())
end

function var_0_0.onDestroy(arg_9_0)
	arg_9_0.simageBg:UnLoadImage()
end

return var_0_0
