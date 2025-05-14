module("modules.logic.share.view.ShareTipView", package.seeall)

local var_0_0 = class("ShareTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bg/#btn_close")
	arg_1_0._gorawImage = gohelper.findChild(arg_1_0.viewGO, "bg/#go_rawImage")
	arg_1_0._btnshare = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bg/#go_rawImage/#btn_share")
	arg_1_0._simagelogo = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_logo")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnshare:AddClickListener(arg_2_0._btnshareOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnshare:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnshareOnClick(arg_5_0)
	if not arg_5_0._viewOpen then
		return
	end

	arg_5_0._openShareEditor = true

	arg_5_0:closeThis()
	ShareController.instance:openShareEditorView(arg_5_0._texture)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._bgGO = gohelper.findChild(arg_6_0.viewGO, "bg")
	arg_6_0._bgTr = arg_6_0._bgGO.transform
	arg_6_0._touchGO = gohelper.findChild(arg_6_0.viewGO, "touch")
	arg_6_0._touch = TouchEventMgrHepler.getTouchEventMgr(arg_6_0._touchGO)

	arg_6_0._touch:SetIgnoreUI(true)
	arg_6_0._touch:SetOnlyTouch(true)
	arg_6_0._touch:SetOnTouchDownCb(arg_6_0._onTouch, arg_6_0)

	arg_6_0._viewOpen = false
end

function var_0_0._onTouch(arg_7_0, arg_7_1)
	local var_7_0 = recthelper.screenPosToAnchorPos(arg_7_1, arg_7_0._bgTr)

	if math.abs(var_7_0.x) > recthelper.getWidth(arg_7_0._bgTr) or math.abs(var_7_0.y) > recthelper.getHeight(arg_7_0._bgTr) then
		arg_7_0:closeThis()
	end
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0:_refreshUI()
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._viewOpen = true

	arg_9_0:_refreshUI()
end

function var_0_0._refreshUI(arg_10_0)
	arg_10_0._texture = arg_10_0.viewParam
	gohelper.onceAddComponent(arg_10_0._gorawImage, gohelper.Type_RawImage).texture = arg_10_0._texture

	TaskDispatcher.cancelTask(arg_10_0.closeThis, arg_10_0)
	TaskDispatcher.runDelay(arg_10_0.closeThis, arg_10_0, 3)
end

function var_0_0.onClose(arg_11_0)
	arg_11_0._viewOpen = false

	if not arg_11_0._openShareEditor then
		UnityEngine.Object.Destroy(arg_11_0._texture)
	end
end

function var_0_0.onDestroyView(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0.closeThis, arg_12_0)

	if arg_12_0._touch then
		TouchEventMgrHepler.remove(arg_12_0._touch)

		arg_12_0._touch = nil
	end
end

return var_0_0
