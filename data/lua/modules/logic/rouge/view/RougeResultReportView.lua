module("modules.logic.rouge.view.RougeResultReportView", package.seeall)

local var_0_0 = class("RougeResultReportView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._scrollrecordlist = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_recordlist")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_empty")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

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

function var_0_0._btndetailsOnClick(arg_4_0)
	return
end

function var_0_0._editableInitView(arg_5_0)
	RougeResultReportListModel.instance.startFrameCount = UnityEngine.Time.frameCount

	RougeResultReportListModel.instance:init()

	local var_5_0 = RougeResultReportListModel.instance:getList()

	gohelper.setActive(arg_5_0._goempty, #var_5_0 == 0)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.RougeFavoriteAudio9)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	RougeResultReportListModel.instance:clear()
end

return var_0_0
