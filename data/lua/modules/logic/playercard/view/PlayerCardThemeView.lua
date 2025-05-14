module("modules.logic.playercard.view.PlayerCardThemeView", package.seeall)

local var_0_0 = class("PlayerCardThemeView", BaseView)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1

	arg_1_0:onInitView()
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0.goBottom = gohelper.findChild(arg_2_0.viewGO, "bottom")
	arg_2_0.btnConfirm = gohelper.findChildButtonWithAudio(arg_2_0.goBottom, "#btn_confirm")
	arg_2_0.goLocked = gohelper.findChild(arg_2_0.goBottom, "#go_locked")
	arg_2_0.goUsing = gohelper.findChild(arg_2_0.goBottom, "#go_using")
	arg_2_0.goSource = gohelper.findChild(arg_2_0.goBottom, "source")
	arg_2_0.txtSourceTitle = gohelper.findChildTextMesh(arg_2_0.goSource, "layout/#txt_title")
	arg_2_0.txtSourceDesc = gohelper.findChildTextMesh(arg_2_0.goSource, "layout/#txt_dec")
	arg_2_0.goSourceLock = gohelper.findChild(arg_2_0.goSource, "locked")
end

function var_0_0.canOpen(arg_3_0)
	arg_3_0:addEvents()
end

function var_0_0.addEvents(arg_4_0)
	arg_4_0:addClickCb(arg_4_0.btnConfirm, arg_4_0.onClickConfirm, arg_4_0)
	arg_4_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.ShowTheme, arg_4_0.refreshView, arg_4_0)
	arg_4_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.SwitchTheme, arg_4_0.onSwitchView, arg_4_0)
	arg_4_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.ChangeSkin, arg_4_0.onSwitchView, arg_4_0)
end

function var_0_0.removeEvents(arg_5_0)
	arg_5_0:removeClickCb(arg_5_0.btnConfirm, arg_5_0.onClickConfirm, arg_5_0)
end

function var_0_0.onClickConfirm(arg_6_0)
	local var_6_0 = PlayerCardModel.instance:getSelectSkinMO()

	PlayerCardRpc.instance:sendSetPlayerCardThemeRequest(var_6_0.id)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.refreshView(arg_8_0, arg_8_1)
	if not PlayerCardModel.instance:getCardInfo(arg_8_1) then
		return
	end

	PlayerCardThemeListModel.instance:init()
	arg_8_0:onSwitchView()
end

function var_0_0.onSwitchView(arg_9_0)
	local var_9_0 = PlayerCardModel.instance:getSelectSkinMO()
	local var_9_1 = var_9_0:isUnLock()

	gohelper.setActive(arg_9_0.goLocked, not var_9_1)
	gohelper.setActive(arg_9_0.goSourceLock, not var_9_1)

	local var_9_2 = var_9_0:checkIsUse()

	gohelper.setActive(arg_9_0.goUsing, var_9_2)
	gohelper.setActive(arg_9_0.btnConfirm, not var_9_2 and var_9_1)

	if var_9_0:isEmpty() then
		arg_9_0.txtSourceTitle.text = luaLang("talent_style_special_tag_998")
		arg_9_0.txtSourceDesc.text = luaLang("playercard_skin_default")
	else
		local var_9_3 = var_9_0:getConfig()

		arg_9_0.txtSourceTitle.text = var_9_3.name
		arg_9_0.txtSourceDesc.text = var_9_3.desc
	end
end

function var_0_0.onDestroy(arg_10_0)
	return
end

return var_0_0
