module("modules.logic.versionactivity2_8.act199.view.V2a8_SelfSelectCharacterView", package.seeall)

local var_0_0 = class("V2a8_SelfSelectCharacterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simagerole1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "role/#simage_role1")
	arg_1_0._simagefrontbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_frontbg")
	arg_1_0._txtremainTime = gohelper.findChildText(arg_1_0.viewGO, "timebg/#txt_remainTime")
	arg_1_0._goinviteContent = gohelper.findChild(arg_1_0.viewGO, "#go_inviteContent")
	arg_1_0._btncheck = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_inviteContent/#btn_check")
	arg_1_0._gouninvite = gohelper.findChild(arg_1_0.viewGO, "#go_inviteContent/#go_uninvite")
	arg_1_0._btninvite = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_inviteContent/#go_uninvite/#btn_invite")
	arg_1_0._btnuninviteTips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_inviteContent/#go_uninvite/#btn_uninviteTips")
	arg_1_0._goinvited = gohelper.findChild(arg_1_0.viewGO, "#go_inviteContent/#go_invited")
	arg_1_0._btninviteTips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_inviteContent/#go_invited/#btn_inviteTips")
	arg_1_0._simagerolehead = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_inviteContent/#go_invited/#btn_inviteTips/#simage_rolehead")
	arg_1_0._txtrolename = gohelper.findChildText(arg_1_0.viewGO, "#go_inviteContent/#go_invited/#txt_rolename")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._btncheck:AddClickListener(arg_2_0._btncheckOnClick, arg_2_0)
	arg_2_0._btninvite:AddClickListener(arg_2_0._btninviteOnClick, arg_2_0)
	arg_2_0._btnuninviteTips:AddClickListener(arg_2_0._btnuninviteTipsOnClick, arg_2_0)
	arg_2_0._btninviteTips:AddClickListener(arg_2_0._btninviteTipsOnClick, arg_2_0)
	arg_2_0:addEventCb(V2a8_SelfSelectSix_PickChoiceController.instance, V2a8_SelfSelectSix_PickChoiceEvent.GetHero, arg_2_0._refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btncheck:RemoveClickListener()
	arg_3_0._btninvite:RemoveClickListener()
	arg_3_0._btnuninviteTips:RemoveClickListener()
	arg_3_0._btninviteTips:RemoveClickListener()
	arg_3_0:removeEventCb(V2a8_SelfSelectSix_PickChoiceController.instance, V2a8_SelfSelectSix_PickChoiceEvent.GetHero, arg_3_0._refreshUI, arg_3_0)
end

function var_0_0._btncheckOnClick(arg_4_0)
	HelpController.instance:openBpRuleTipsView(luaLang("ruledetail"), "Rule Details", luaLang("anniversary_bonus_rule"))
end

function var_0_0._btninviteOnClick(arg_5_0)
	V2a8_SelfSelectSix_PickChoiceListModel.instance:initDatas(arg_5_0._actId)
	ViewMgr.instance:openView(ViewName.V2a8_SelfSelectSix_PickChoiceView)
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0._actId = arg_8_0.viewParam.actId

	Activity199Rpc.instance:sendGet199InfoRequest(arg_8_0._actId, arg_8_0._refreshUI, arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.SummonNewCustomSkin.play_ui_youyu_liuxing_give)
end

function var_0_0._refreshUI(arg_9_0)
	local var_9_0 = Activity199Model.instance:getSelectHeroId() ~= 0

	gohelper.setActive(arg_9_0._goinvited, var_9_0)
	gohelper.setActive(arg_9_0._gouninvite, not var_9_0)

	if var_9_0 then
		arg_9_0:_refreshSelectRole()
	end

	arg_9_0._txtremainTime.text = ActivityHelper.getActivityRemainTimeStr(arg_9_0._actId)
end

function var_0_0._refreshSelectRole(arg_10_0)
	local var_10_0 = Activity199Model.instance:getSelectHeroId()
	local var_10_1 = HeroConfig.instance:getHeroCO(var_10_0)

	if not var_10_1 then
		logError("SummonNewCustomPick.refreshUI error, heroConfig is nil, id:" .. tostring(var_10_0))

		return
	end

	local var_10_2 = SkinConfig.instance:getSkinCo(var_10_1.skinId)

	if not var_10_2 then
		logError("SummonNewCustomPick.refreshUI error,  skinCfg is nil, id:" .. tostring(var_10_1.skinId))

		return
	end

	arg_10_0._simagerolehead:LoadImage(ResUrl.getRoomHeadIcon(var_10_2.headIcon))

	arg_10_0._txtrolename.text = var_10_1.name
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
