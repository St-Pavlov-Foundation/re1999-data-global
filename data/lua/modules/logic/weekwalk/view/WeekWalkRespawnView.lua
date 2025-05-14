module("modules.logic.weekwalk.view.WeekWalkRespawnView", package.seeall)

local var_0_0 = class("WeekWalkRespawnView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gorolecontainer = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer")
	arg_1_0._scrollcard = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_rolecontainer/#scroll_card")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_confirm")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnconfirm:RemoveClickListener()
end

function var_0_0._btnconfirmOnClick(arg_4_0)
	if not arg_4_0._heroMO then
		GameFacade.showToast(ToastEnum.AdventureRespawn2)

		return
	end

	WeekwalkRpc.instance:sendWeekwalkRespawnRequest(arg_4_0.info.elementId, arg_4_0._heroMO.heroId)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._imgBg = gohelper.findChildSingleImage(arg_5_0.viewGO, "bg/bgimg")

	arg_5_0._imgBg:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))
	HeroGroupEditListModel.instance:setParam(nil, WeekWalkModel.instance:getInfo())
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.info = arg_7_0.viewParam

	WeekWalkRespawnModel.instance:setRespawnList()
	arg_7_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, arg_7_0._onHeroItemClick, arg_7_0)
	arg_7_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.WeekWalkRespawnReply, arg_7_0._onWeekWalkRespawnReply, arg_7_0)
end

function var_0_0._onHeroItemClick(arg_8_0, arg_8_1)
	arg_8_0._heroMO = arg_8_1
end

function var_0_0._onWeekWalkRespawnReply(arg_9_0)
	GameFacade.showToast(ToastEnum.AdventureRespawn3)
	arg_9_0:closeThis()
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._imgBg:UnLoadImage()
end

return var_0_0
