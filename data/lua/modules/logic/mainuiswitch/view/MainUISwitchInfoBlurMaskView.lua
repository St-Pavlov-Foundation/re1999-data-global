module("modules.logic.mainuiswitch.view.MainUISwitchInfoBlurMaskView", package.seeall)

local var_0_0 = class("MainUISwitchInfoBlurMaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._root = gohelper.findChild(arg_1_0.viewGO, "root")
	arg_1_0._gorawImage = gohelper.findChild(arg_1_0._root, "RawImage")
	arg_1_0._rawImage = gohelper.onceAddComponent(arg_1_0._gorawImage, gohelper.Type_RawImage)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
	arg_2_0:addEventCb(MainUISwitchController.instance, MainUISwitchEvent.PreviewSwitchUIVisible, arg_2_0._onSwitchUIVisible, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
	arg_3_0:removeEventCb(MainUISwitchController.instance, MainUISwitchEvent.PreviewSwitchUIVisible, arg_3_0._onSwitchUIVisible, arg_3_0)
end

local var_0_1 = ViewName.MainUISwitchInfoView

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._onSwitchUIVisible(arg_5_0, arg_5_1)
	if arg_5_1 then
		gohelper.addChildPosStay(arg_5_0.viewGO, arg_5_0._root)
	elseif ViewMgr.instance:isOpen(var_0_1) then
		local var_5_0 = ViewMgr.instance:getContainer(var_0_1)

		if var_5_0 and var_5_0.viewGO then
			gohelper.addChildPosStay(var_5_0.viewGO, arg_5_0._root)
			arg_5_0._root.transform:SetAsFirstSibling()
		end
	end
end

function var_0_0._onCloseView(arg_6_0, arg_6_1)
	if arg_6_1 == var_0_1 then
		arg_6_0:closeThis()
	end
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = arg_7_0.viewParam and arg_7_0.viewParam.sceneId or MainSceneSwitchModel.instance:getCurSceneId()

	gohelper.setActive(arg_7_0._gorawImage, false)
	arg_7_0:_onShowSceneInfo(var_7_0)
end

function var_0_0._onShowSceneInfo(arg_8_0, arg_8_1)
	arg_8_0._sceneId = arg_8_1

	MainSceneSwitchCameraController.instance:showScene(arg_8_1, arg_8_0._showSceneFinished, arg_8_0)
end

function var_0_0._showSceneFinished(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._gorawImage, true)
	MainSceneSwitchInfoDisplayView.adjustRt(arg_9_0._rawImage, arg_9_1)
	ViewMgr.instance:openView(var_0_1, arg_9_0.viewParam)
end

function var_0_0.adjustRt(arg_10_0, arg_10_1)
	arg_10_0.texture = arg_10_1

	arg_10_0:SetNativeSize()

	local var_10_0 = arg_10_1.width
	local var_10_1 = ViewMgr.instance:getUIRoot().transform
	local var_10_2 = recthelper.getWidth(var_10_1) / var_10_0

	transformhelper.setLocalScale(arg_10_0.transform, var_10_2, var_10_2, 1)
end

function var_0_0.onDestroyView(arg_11_0)
	MainSceneSwitchCameraController.instance:clear()
end

return var_0_0
