module("modules.logic.character.view.CharacterGuideTalentView", package.seeall)

local var_0_0 = class("CharacterGuideTalentView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "commen/#simage_bg")
	arg_1_0._simagehead = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_head")
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
	CharacterModel.instance:setSortByRankDescOnce()

	if ViewMgr.instance:hasOpenFullView() then
		ViewMgr.instance:openView(ViewName.GuideTransitionBlackView)
	else
		ViewMgr.instance:closeAllPopupViews()
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simagebg:LoadImage(ResUrl.getCommonIcon("yd_yindaodi_2"))
	arg_5_0._simagehead:LoadImage(ResUrl.getCharacterTalentUpIcon("yd_sixugongming"))
	arg_5_0._simagedecorate1:LoadImage(ResUrl.getCommonIcon("yd_biaoti_di"))
	arg_5_0._simagedecorate3:LoadImage(ResUrl.getCommonIcon("yd_blxian"))
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_7_0._onOpenViewFinish, arg_7_0)
	arg_7_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_7_0._onCloseViewFinish, arg_7_0, LuaEventSystem.Low)
	AudioMgr.instance:trigger(AudioEnum.UI.play_artificial_ui_openfunction)
end

function var_0_0._onOpenViewFinish(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.GuideTransitionBlackView then
		if not ViewMgr.instance:isOpen(ViewName.MainView) then
			ViewMgr.instance:openView(ViewName.MainView)
		end

		ViewMgr.instance:closeAllPopupViews({
			ViewName.GuideTransitionBlackView
		})
	end
end

function var_0_0._onCloseViewFinish(arg_9_0, arg_9_1)
	if arg_9_1 == ViewName.CharacterGuideTalentView then
		ViewMgr.instance:closeView(ViewName.GuideTransitionBlackView)
	end
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simagebg:UnLoadImage()
	arg_11_0._simagehead:UnLoadImage()
	arg_11_0._simagedecorate1:UnLoadImage()
	arg_11_0._simagedecorate3:UnLoadImage()
end

return var_0_0
