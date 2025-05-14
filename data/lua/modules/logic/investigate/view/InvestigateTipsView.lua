module("modules.logic.investigate.view.InvestigateTipsView", package.seeall)

local var_0_0 = class("InvestigateTipsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagewindowbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#simage_windowbg")
	arg_1_0._simagepic = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#simage_pic")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#scroll_desc")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "root/#scroll_desc/viewport/content/#txt_dec")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._elementId = arg_7_0.viewParam.elementId
	arg_7_0._fragmentId = arg_7_0.viewParam.fragmentId

	local var_7_0 = lua_chapter_map_fragment.configDict[arg_7_0._fragmentId]

	arg_7_0._txtdec.text = var_7_0.content

	local var_7_1 = InvestigateConfig.instance:getInvestigateClueInfoByElement(arg_7_0._elementId)

	if var_7_1 then
		arg_7_0._simagepic:LoadImage(var_7_1.mapRes)
	end

	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, false)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Investigate.play_ui_molu_jlbn_open)
end

function var_0_0.onClose(arg_8_0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, true)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Investigate.play_ui_shuori_dreamsong_receive_open)
end

function var_0_0.onCloseFinish(arg_9_0)
	InvestigateController.instance:dispatchEvent(InvestigateEvent.ShowGetEffect)
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
