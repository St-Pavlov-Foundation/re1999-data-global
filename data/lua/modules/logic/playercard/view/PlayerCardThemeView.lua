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
	arg_2_0.golimitsale = gohelper.findChild(arg_2_0.goBottom, "#go_limitsale")
	arg_2_0.btnSource = gohelper.findChildButtonWithAudio(arg_2_0.goBottom, "#btn_get")
	arg_2_0.txtSourceTitle = gohelper.findChildTextMesh(arg_2_0.goBottom, "source/layout/#txt_title")
	arg_2_0.txtSourceDesc = gohelper.findChildTextMesh(arg_2_0.goBottom, "source/layout/#txt_dec")
	arg_2_0._goSourceLock = gohelper.findChild(arg_2_0.goBottom, "source/locked")
end

function var_0_0.canOpen(arg_3_0)
	arg_3_0:addEvents()
end

function var_0_0.addEvents(arg_4_0)
	arg_4_0:addClickCb(arg_4_0.btnConfirm, arg_4_0.onClickConfirm, arg_4_0)
	arg_4_0:addClickCb(arg_4_0.btnSource, arg_4_0.onClickSource, arg_4_0)
	arg_4_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.ShowTheme, arg_4_0.refreshView, arg_4_0)
	arg_4_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.SwitchTheme, arg_4_0.onSwitchView, arg_4_0)
	arg_4_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.ChangeSkin, arg_4_0.onSwitchView, arg_4_0)
end

function var_0_0.removeEvents(arg_5_0)
	arg_5_0:removeClickCb(arg_5_0.btnConfirm, arg_5_0.onClickConfirm, arg_5_0)
	arg_5_0:removeClickCb(arg_5_0.btnSource, arg_5_0.onClickSource, arg_5_0)
end

function var_0_0.onClickConfirm(arg_6_0)
	local var_6_0 = PlayerCardModel.instance:getSelectSkinMO()

	PlayerCardRpc.instance:sendSetPlayerCardThemeRequest(var_6_0.id)
end

function var_0_0.onClickSource(arg_7_0)
	local var_7_0 = PlayerCardModel.instance:getSelectSkinMO()

	GameFacade.jump(var_7_0:getSources())
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.refreshView(arg_9_0, arg_9_1)
	if not PlayerCardModel.instance:getCardInfo(arg_9_1) then
		return
	end

	PlayerCardThemeListModel.instance:init()
	arg_9_0:onSwitchView()
end

function var_0_0.onSwitchView(arg_10_0)
	local var_10_0 = PlayerCardModel.instance:getSelectSkinMO()
	local var_10_1 = var_10_0:isUnLock()
	local var_10_2 = var_10_0:canBuyInStore()
	local var_10_3 = var_10_0:isStoreDecorateGoodsValid()

	if not var_10_1 then
		local var_10_4 = var_10_0:getSources()
		local var_10_5 = JumpController.instance:isJumpOpen(var_10_4)

		if var_10_2 then
			gohelper.setActive(arg_10_0.goLocked, false)
			gohelper.setActive(arg_10_0.golimitsale, not var_10_3)
			gohelper.setActive(arg_10_0.btnSource.gameObject, var_10_3)
		else
			gohelper.setActive(arg_10_0.golimitsale, false)
			gohelper.setActive(arg_10_0.btnSource.gameObject, var_10_5)
			gohelper.setActive(arg_10_0.goLocked, not var_10_5)
		end

		gohelper.setActive(arg_10_0._goSourceLock, true)
	else
		gohelper.setActive(arg_10_0.goLocked, false)
		gohelper.setActive(arg_10_0.golimitsale, false)
		gohelper.setActive(arg_10_0.btnSource.gameObject, false)
		gohelper.setActive(arg_10_0._goSourceLock, false)
	end

	local var_10_6 = var_10_0:checkIsUse()

	gohelper.setActive(arg_10_0.goUsing, var_10_6)
	gohelper.setActive(arg_10_0.btnConfirm, not var_10_6 and var_10_1)

	if var_10_0:isEmpty() then
		arg_10_0.txtSourceTitle.text = luaLang("talent_style_special_tag_998")
		arg_10_0.txtSourceDesc.text = luaLang("playercard_skin_default")
	else
		local var_10_7 = var_10_0:getConfig()

		arg_10_0.txtSourceTitle.text = var_10_7.name
		arg_10_0.txtSourceDesc.text = var_10_7.desc
	end
end

function var_0_0.onDestroy(arg_11_0)
	return
end

return var_0_0
