module("modules.logic.rouge.map.view.nextlayer.RougeNextLayerView", package.seeall)

local var_0_0 = class("RougeNextLayerView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._simagetitlebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_titlebg")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "#txt_title")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "#txt_dec")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagefullbg:LoadImage("singlebg/rouge/map/rouge_map_nextlevelbg.png")
	arg_4_0._simagetitlebg:LoadImage("singlebg/rouge/map/rouge_map_nextlevelbg2.png")
	NavigateMgr.instance:addEscape(arg_4_0.viewName, RougeMapHelper.blockEsc, arg_4_0)
	arg_4_0:addEventCb(RougeMapController.instance, RougeMapEvent.onLoadMapDone, arg_4_0.onLoadMapDone, arg_4_0)
end

function var_0_0.onLoadMapDone(arg_5_0)
	arg_5_0.loadDone = true

	arg_5_0:closeView()
end

function var_0_0.closeView(arg_6_0)
	if not arg_6_0.loadDone or not arg_6_0.overMinTime then
		return
	end

	arg_6_0:closeThis()
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.SwitchNormalLayer)

	arg_7_0.loadDone = not RougeMapModel.instance:checkIsLoading()
	arg_7_0.overMinTime = false

	local var_7_0 = arg_7_0.viewParam
	local var_7_1 = lua_rouge_layer.configDict[var_7_0]

	arg_7_0._txttitle.text = var_7_1.name
	arg_7_0._txtdec.text = var_7_1.crossDesc

	TaskDispatcher.runDelay(arg_7_0.onMinTimeDone, arg_7_0, RougeMapEnum.SwitchLayerMinDuration)
	TaskDispatcher.runDelay(arg_7_0.onMaxTimeDone, arg_7_0, RougeMapEnum.SwitchLayerMaxDuration)
end

function var_0_0.onMinTimeDone(arg_8_0)
	arg_8_0.overMinTime = true

	arg_8_0:closeView()
end

function var_0_0.onMaxTimeDone(arg_9_0)
	arg_9_0:closeThis()
end

function var_0_0.onDestroyView(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.onMinTimeDone, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.onMaxTimeDone, arg_10_0)
	arg_10_0._simagefullbg:UnLoadImage()
	arg_10_0._simagetitlebg:UnLoadImage()
end

return var_0_0
