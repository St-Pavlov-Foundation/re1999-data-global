module("modules.logic.dungeon.view.DungeonStoryView", package.seeall)

local var_0_0 = class("DungeonStoryView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnback = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "top_left/#btn_back")
	arg_1_0._btnplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_play")
	arg_1_0._txtchapter = gohelper.findChildText(arg_1_0.viewGO, "#txt_chapter")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "#txt_nameen")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_desc")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnback:AddClickListener(arg_2_0._btnbackOnClick, arg_2_0)
	arg_2_0._btnplay:AddClickListener(arg_2_0._btnplayOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnback:RemoveClickListener()
	arg_3_0._btnplay:RemoveClickListener()
end

function var_0_0._btnbackOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnplayOnClick(arg_5_0)
	return
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0._txtchapter.text = ""
	arg_8_0._txtname.text = arg_8_0.viewParam.name
	arg_8_0._txtdesc.text = arg_8_0.viewParam.desc
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
