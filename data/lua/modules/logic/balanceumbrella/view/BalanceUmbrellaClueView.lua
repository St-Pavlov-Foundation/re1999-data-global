module("modules.logic.balanceumbrella.view.BalanceUmbrellaClueView", package.seeall)

local var_0_0 = class("BalanceUmbrellaClueView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goget = gohelper.findChild(arg_1_0.viewGO, "#go_get")
	arg_1_0._godetail = gohelper.findChild(arg_1_0.viewGO, "#go_detail")
	arg_1_0._animget = arg_1_0._goget:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._animdetail = arg_1_0._godetail:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._btngetClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_get/#btn_close")
	arg_1_0._simagegetclue = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_get/#simage_clue")
	arg_1_0._btndetailclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_detail/#btn_close")
	arg_1_0._simagedetailclue = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_detail/Left/#simage_clue")
	arg_1_0._txtroledesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_detail/Right/#scroll_desc/viewport/content/#txt_dec")
	arg_1_0._txtdesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_detail/Right/#scroll_desc/viewport/content/#txt_cluedec")
	arg_1_0._txtname = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_detail/Right/titlebg/#txt_cluename")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btngetClose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._btndetailclose:AddClickListener(arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btngetClose:RemoveClickListener()
	arg_3_0._btndetailclose:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	gohelper.setActive(arg_4_0._goget, arg_4_0.viewParam.isGet)
	gohelper.setActive(arg_4_0._godetail, not arg_4_0.viewParam.isGet)
	arg_4_0._simagegetclue:LoadImage(string.format("singlebg/balance_singlebg/item/balance_bigitem_%02d.png", arg_4_0.viewParam.id))
	arg_4_0._simagedetailclue:LoadImage(string.format("singlebg/balance_singlebg/item/balance_bigitem_%02d.png", arg_4_0.viewParam.id))

	local var_4_0 = lua_balance_umbrella.configDict[arg_4_0.viewParam.id]

	if not var_4_0 then
		return
	end

	arg_4_0._txtname.text = var_4_0.name
	arg_4_0._txtdesc.text = var_4_0.desc
	arg_4_0._txtroledesc.text = var_4_0.players

	if arg_4_0.viewParam.isGet then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_season_succeed)
		UIBlockHelper.instance:startBlock("BalanceUmbrellaClueView_Get", 1, arg_4_0.viewName)
		TaskDispatcher.runDelay(arg_4_0._showDetail, arg_4_0, 1)
		arg_4_0._animget:Play("open", 0, 0)
	else
		arg_4_0._animdetail:Play("open", 0, 0)
	end
end

function var_0_0._showDetail(arg_5_0)
	gohelper.setActive(arg_5_0._godetail, true)
	arg_5_0._animget:Play("close", 0, 0)
	arg_5_0._animdetail:Play("switch", 0, 0)
end

function var_0_0.onClickModalMask(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0.onClose(arg_7_0)
	if arg_7_0.viewParam.isGet then
		BalanceUmbrellaController.instance:dispatchEvent(BalanceUmbrellaEvent.ShowGetEffect)
	end
end

function var_0_0.onDestroyView(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._showDetail, arg_8_0)
	BalanceUmbrellaController.instance:dispatchEvent(BalanceUmbrellaEvent.GuideClueViewClose)
	arg_8_0._simagegetclue:UnLoadImage()
	arg_8_0._simagedetailclue:UnLoadImage()
end

return var_0_0
