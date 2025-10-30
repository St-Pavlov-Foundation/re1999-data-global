module("modules.logic.commandstation.view.CommandStationDetailView", package.seeall)

local var_0_0 = class("CommandStationDetailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "Root/#txt_Title")
	arg_1_0._goHead = gohelper.findChild(arg_1_0.viewGO, "Root/#go_Head")
	arg_1_0._goItem = gohelper.findChild(arg_1_0.viewGO, "Root/#go_Head/#go_Item")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Root/Scroll View/Viewport/#txt_Descr")

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
	gohelper.setActive(arg_5_0._goItem, false)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = arg_7_0.viewParam.timeId
	local var_7_1 = lua_copost_time_point_event.configDict[var_7_0]
	local var_7_2 = var_7_1 and var_7_1.allTextId
	local var_7_3 = var_7_2 and lua_copost_event_text.configDict[var_7_2]

	arg_7_0._txtDescr.text = var_7_3 and var_7_3.text

	local var_7_4 = var_7_1 and var_7_1.chaEventId

	if var_7_4 and #var_7_4 ~= 0 then
		gohelper.CreateObjList(arg_7_0, arg_7_0._onItemShow, var_7_4, arg_7_0._goHead, arg_7_0._goItem)
	end
end

function var_0_0._onItemShow(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = gohelper.findChildSingleImage(arg_8_1, "image_Icon")
	local var_8_1 = lua_copost_character_event.configDict[arg_8_2]
	local var_8_2 = var_8_1 and var_8_1.chaId
	local var_8_3 = var_8_2 and lua_copost_character.configDict[var_8_2]

	if var_8_3 then
		var_8_0:LoadImage(ResUrl.getHeadIconSmall(var_8_3.chaPicture))
	end
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
