module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoleRevivalView", package.seeall)

local var_0_0 = class("V1a6_CachotRoleRevivalView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotipswindow = gohelper.findChild(arg_1_0.viewGO, "#go_tipswindow")
	arg_1_0._gopreparecontent = gohelper.findChild(arg_1_0.viewGO, "#go_tipswindow/scroll_view/Viewport/#go_preparecontent")
	arg_1_0._gostart = gohelper.findChild(arg_1_0.viewGO, "#go_tipswindow/#go_start")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_tipswindow/#go_start/#btn_start")
	arg_1_0._gostartlight = gohelper.findChild(arg_1_0.viewGO, "#go_tipswindow/#go_start/#btn_start/#go_startlight")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_title")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btnstartOnClick(arg_4_0)
	if not arg_4_0._selectedMo or not arg_4_0._selectedMo:getHeroMO() then
		GameFacade.showToast(ToastEnum.V1a6CachotToast11)

		return
	end

	local var_4_0 = arg_4_0._selectedMo:getHeroMO()

	RogueRpc.instance:sendRogueEventSelectRequest(V1a6_CachotEnum.ActivityId, arg_4_0.viewParam.eventId, var_4_0.heroId, arg_4_0._onSelectEnd, arg_4_0)
end

function var_0_0._onSelectEnd(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_easter_success)

	local var_5_0 = arg_5_0._selectedMo:getHeroMO()
	local var_5_1 = formatLuaLang("cachot_revival", var_5_0.config.name)

	V1a6_CachotController.instance:openV1a6_CachotTipsView({
		str = var_5_1,
		style = V1a6_CachotEnum.TipStyle.Normal
	})
end

function var_0_0._btncloseOnClick(arg_6_0)
	RogueRpc.instance:sendRogueEventEndRequest(V1a6_CachotEnum.ActivityId, arg_6_0.viewParam.eventId, arg_6_0.closeThis, arg_6_0)
end

function var_0_0._editableInitView(arg_7_0)
	V1a6_CachotRoleRevivalPrepareListModel.instance:initList()
	gohelper.setActive(arg_7_0._gostartlight, false)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnClickTeamItem, arg_9_0._onClickTeamItem, arg_9_0)
	arg_9_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_9_0._onCloseView, arg_9_0)
end

function var_0_0._onCloseView(arg_10_0, arg_10_1)
	if arg_10_1 == ViewName.V1a6_CachotRoleRevivalResultView or arg_10_1 == ViewName.V1a6_CachotTipsView then
		arg_10_0:closeThis()
	end
end

function var_0_0._onClickTeamItem(arg_11_0, arg_11_1)
	arg_11_0._selectedMo = arg_11_1

	gohelper.setActive(arg_11_0._gostartlight, true)
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
