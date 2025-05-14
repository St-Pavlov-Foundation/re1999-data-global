module("modules.logic.rouge.view.RougeOpenGuideView", package.seeall)

local var_0_0 = class("RougeOpenGuideView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "commen/#simage_bg")
	arg_1_0._btnlook = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_look")
	arg_1_0._simagedecorate1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "commen/#simage_decorate1")
	arg_1_0._simagedecorate3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "commen/#simage_decorate3")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnlook:AddClickListener(arg_2_0._btnlookOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlook:RemoveClickListener()
end

function var_0_0._btnlookOnClick(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayClick, arg_4_0)
	TaskDispatcher.runDelay(arg_4_0._delayClick, arg_4_0, 0.015)
end

function var_0_0._delayClick(arg_5_0)
	if ViewMgr.instance:hasOpenFullView() then
		ViewMgr.instance:openView(ViewName.GuideTransitionBlackView)
	else
		ViewMgr.instance:closeAllPopupViews()
	end

	JumpController.instance:jumpTo("5#1")
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._simagebg:LoadImage(ResUrl.getCommonIcon("yd_yindaodi_2"))
	arg_6_0._simagedecorate1:LoadImage(ResUrl.getCommonIcon("yd_biaoti_di"))
	arg_6_0._simagedecorate3:LoadImage(ResUrl.getCommonIcon("yd_blxian"))
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_artificial_ui_openfunction)

	local var_8_0 = lua_open.configDict[OpenEnum.UnlockFunc.EquipDungeon].episodeId
	local var_8_1 = DungeonConfig.instance:getEpisodeCO(var_8_0)
	local var_8_2 = lua_bonus.configDict[var_8_1.firstBonus]
	local var_8_3 = string.splitToNumber(var_8_2.fixBonus, "#")

	arg_8_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_8_0._onOpenViewFinish, arg_8_0)
	arg_8_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_8_0._onCloseViewFinish, arg_8_0, LuaEventSystem.Low)
end

function var_0_0._onOpenViewFinish(arg_9_0, arg_9_1)
	return
end

function var_0_0._onCloseViewFinish(arg_10_0, arg_10_1)
	if arg_10_1 == ViewName.RougeOpenGuideView then
		ViewMgr.instance:closeView(ViewName.GuideTransitionBlackView)
	end
end

function var_0_0.onOpenFinish(arg_11_0)
	return
end

function var_0_0.onClose(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._delayClick, arg_12_0)
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0._simagebg:UnLoadImage()
	arg_13_0._simagedecorate1:UnLoadImage()
	arg_13_0._simagedecorate3:UnLoadImage()
end

return var_0_0
