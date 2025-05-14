module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotEndingView", package.seeall)

local var_0_0 = class("V1a6_CachotEndingView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagelevelbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_levelbg")
	arg_1_0._simagecg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_cg")
	arg_1_0._txten = gohelper.findChildText(arg_1_0.viewGO, "#txt_en")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "#txt_title")
	arg_1_0._txttips = gohelper.findChildText(arg_1_0.viewGO, "#txt_tips")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

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
	V1a6_CachotController.instance:openV1a6_CachotResultView()
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	NavigateMgr.instance:addEscape(ViewName.V1a6_CachotEndingView, arg_7_0._btncloseOnClick, arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_finale_get)
	arg_7_0:refreshUI()
end

function var_0_0.refreshUI(arg_8_0)
	local var_8_0 = V1a6_CachotModel.instance:getRogueEndingInfo()
	local var_8_1 = var_8_0 and var_8_0._ending
	local var_8_2 = lua_rogue_ending.configDict[var_8_1]

	if var_8_2 then
		arg_8_0._txttitle.text = tostring(var_8_2.title)
		arg_8_0._txttips.text = tostring(var_8_2.endingDesc)

		arg_8_0._simagecg:LoadImage(ResUrl.getV1a6CachotIcon(var_8_2.endingIcon))
	end
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
