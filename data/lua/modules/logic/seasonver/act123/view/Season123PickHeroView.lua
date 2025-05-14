module("modules.logic.seasonver.act123.view.Season123PickHeroView", package.seeall)

local var_0_0 = class("Season123PickHeroView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtcount = gohelper.findChildText(arg_1_0.viewGO, "#go_count/#txt_count")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ops/#btn_confirm")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ops/#btn_cancel")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0._btncancelOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btncancel:RemoveClickListener()
end

function var_0_0._btnconfirmOnClick(arg_4_0)
	Season123PickHeroController.instance:pickOver()
	arg_4_0:closeThis()
end

function var_0_0._btncancelOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._imgBg = gohelper.findChildSingleImage(arg_6_0.viewGO, "bg/bgimg")
	arg_6_0._simageredlight = gohelper.findChildSingleImage(arg_6_0.viewGO, "bg/#simage_redlight")

	arg_6_0._imgBg:LoadImage(ResUrl.getCommonViewBg("full/biandui_di"))
	arg_6_0._simageredlight:LoadImage(ResUrl.getHeroGroupBg("guang_027"))
end

function var_0_0.onDestroyView(arg_7_0)
	arg_7_0._imgBg:UnLoadImage()
	arg_7_0._simageredlight:UnLoadImage()
	Season123PickHeroController.instance:onCloseView()
end

function var_0_0.onOpen(arg_8_0)
	local var_8_0 = arg_8_0.viewParam.actId
	local var_8_1 = arg_8_0.viewParam.stage

	Season123PickHeroController.instance:onOpenView(var_8_0, var_8_1, arg_8_0.viewParam.finishCall, arg_8_0.viewParam.finishCallObj, arg_8_0.viewParam.entryMOList, arg_8_0.viewParam.selectHeroUid)

	local var_8_2 = ActivityModel.instance:getActMO(var_8_0)

	if not var_8_2 or not var_8_2:isOpen() or var_8_2:isExpired() then
		return
	end

	arg_8_0:addEventCb(Season123Controller.instance, Season123Event.PickViewRefresh, arg_8_0.refreshUI, arg_8_0)
	arg_8_0:refreshUI()
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.refreshUI(arg_10_0)
	local var_10_0 = Season123PickHeroModel.instance:getSelectCount()
	local var_10_1 = Season123PickHeroModel.instance:getLimitCount()

	arg_10_0._txtcount.text = GameUtil.getSubPlaceholderLuaLang(luaLang("season123_custompick_selectnum"), {
		var_10_0,
		var_10_1
	})
end

return var_0_0
