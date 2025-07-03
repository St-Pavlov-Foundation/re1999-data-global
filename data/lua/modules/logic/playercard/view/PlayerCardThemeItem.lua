module("modules.logic.playercard.view.PlayerCardThemeItem", package.seeall)

local var_0_0 = class("PlayerCardThemeItem", ListScrollCellExtend)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0.simageBg = gohelper.findChildSingleImage(arg_1_0.viewGO, "themeBg")
	arg_1_0.txtName = gohelper.findChildTextMesh(arg_1_0.viewGO, "#txt_name")
	arg_1_0.goLocked = gohelper.findChild(arg_1_0.viewGO, "#go_locked")
	arg_1_0.goSelect = gohelper.findChild(arg_1_0.viewGO, "#go_select")
	arg_1_0.goUsing = gohelper.findChild(arg_1_0.viewGO, "#go_using")
	arg_1_0.btnClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "click")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "#go_reddot")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.btnClick:AddClickListener(arg_2_0._onClick, arg_2_0)
	PlayerCardController.instance:registerCallback(PlayerCardEvent.SwitchTheme, arg_2_0.refreshUI, arg_2_0)
	PlayerCardController.instance:registerCallback(PlayerCardEvent.ChangeSkin, arg_2_0.refreshUI, arg_2_0)

	arg_2_0._bgreddot = RedDotController.instance:addNotEventRedDot(arg_2_0._goreddot, arg_2_0._isShowRedDot, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	PlayerCardController.instance:unregisterCallback(PlayerCardEvent.SwitchTheme, arg_3_0.refreshUI, arg_3_0)
	PlayerCardController.instance:unregisterCallback(PlayerCardEvent.ChangeSkin, arg_3_0.refreshUI, arg_3_0)
	arg_3_0.btnClick:RemoveClickListener()
end

function var_0_0._isShowRedDot(arg_4_0)
	local var_4_0 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PlayerCardNewBgSkinRed) .. arg_4_0._mo.id

	return PlayerPrefsHelper.getNumber(var_4_0, 0) == 1
end

function var_0_0._onClick(arg_5_0)
	PlayerCardModel.instance:setSelectSkinMO(arg_5_0._mo)

	if arg_5_0:_isShowRedDot() then
		PlayerCardController.instance:setBgSkinRed(arg_5_0._mo.id, false)
		PlayerCardModel.instance:setShowRed()
		gohelper.setActive(arg_5_0._goreddot, false)
	end

	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.SwitchTheme, arg_5_0._mo.id)
end

function var_0_0.refreshUI(arg_6_0)
	local var_6_0 = arg_6_0._skinId == PlayerCardModel.instance:getSelectSkinMO().id

	gohelper.setActive(arg_6_0.goSelect, var_6_0)

	local var_6_1 = arg_6_0._mo:checkIsUse()

	gohelper.setActive(arg_6_0.goUsing, var_6_1)
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0._mo = arg_7_1
	arg_7_0._skinId = arg_7_0._mo:isEmpty() and 0 or arg_7_0._mo.id
	arg_7_0._config = arg_7_0._mo:getConfig()

	if arg_7_0._mo:isEmpty() then
		arg_7_0:refreshEmpty()
	else
		arg_7_0:refreshItem()
	end

	local var_7_0 = arg_7_0._skinId == PlayerCardModel.instance:getSelectSkinMO().id

	gohelper.setActive(arg_7_0.goSelect, var_7_0)

	local var_7_1 = arg_7_0._mo:checkIsUse()

	gohelper.setActive(arg_7_0.goUsing, var_7_1)
end

function var_0_0.refreshEmpty(arg_8_0)
	arg_8_0.txtName.text = luaLang("talent_style_special_tag_998")

	arg_8_0.simageBg:LoadImage(ResUrl.getPlayerCardIcon("banner/" .. arg_8_0._skinId))
	gohelper.setActive(arg_8_0.goLocked, false)
end

function var_0_0.refreshItem(arg_9_0)
	arg_9_0.txtName.text = arg_9_0._config.name

	arg_9_0.simageBg:LoadImage(ResUrl.getPlayerCardIcon("banner/" .. arg_9_0._skinId))
	gohelper.setActive(arg_9_0.goLocked, not arg_9_0._mo:isUnLock())
end

function var_0_0.onDestroy(arg_10_0)
	arg_10_0.simageBg:UnLoadImage()
end

return var_0_0
