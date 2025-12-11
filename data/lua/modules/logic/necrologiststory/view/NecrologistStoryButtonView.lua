module("modules.logic.necrologiststory.view.NecrologistStoryButtonView", package.seeall)

local var_0_0 = class("NecrologistStoryButtonView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnNext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "")
	arg_1_0.btnAuto = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_topright/#btn_auto")
	arg_1_0.goautooff = gohelper.findChild(arg_1_0.viewGO, "#go_topright/#btn_auto/#image_autooff")
	arg_1_0.goautoon = gohelper.findChild(arg_1_0.viewGO, "#go_topright/#btn_auto/#image_autoon")
	arg_1_0.btnSkip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_topright/#btn_skip")
	arg_1_0.btnExit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_topright/#btn_exit")
	arg_1_0.btnEnd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_end")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnNext, arg_2_0.onClickNext, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnAuto, arg_2_0.onClickAuto, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnSkip, arg_2_0.onClickSkip, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnEnd, arg_2_0.onClickEnd, arg_2_0)
	arg_2_0:addEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnStoryStart, arg_2_0._onStoryStart, arg_2_0)
	arg_2_0:addEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnAutoChange, arg_2_0._onAutoChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnNext)
	arg_3_0:removeClickCb(arg_3_0.btnAuto)
	arg_3_0:removeClickCb(arg_3_0.btnSkip)
	arg_3_0:removeClickCb(arg_3_0.btnEnd)
	arg_3_0:removeEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnStoryStart, arg_3_0._onStoryStart, arg_3_0)
	arg_3_0:removeEventCb(NecrologistStoryController.instance, NecrologistStoryEvent.OnAutoChange, arg_3_0._onAutoChange, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onClickEnd(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._onAutoChange(arg_6_0)
	arg_6_0:refreshButton()
end

function var_0_0.onClickNext(arg_7_0)
	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnClickNext)
end

function var_0_0.onClickAuto(arg_8_0)
	local var_8_0 = NecrologistStoryModel.instance:getCurStoryMO()
	local var_8_1 = var_8_0:getIsAuto()

	var_8_0:setIsAuto(not var_8_1)
end

function var_0_0.onClickSkip(arg_9_0)
	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnClickSkip)
end

function var_0_0._onStoryStart(arg_10_0)
	arg_10_0:refreshButton()
end

function var_0_0.refreshButton(arg_11_0)
	local var_11_0 = NecrologistStoryModel.instance:getCurStoryMO():getIsAuto()

	gohelper.setActive(arg_11_0.goautooff, not var_11_0)
	gohelper.setActive(arg_11_0.goautoon, var_11_0)
end

function var_0_0.onDestroyView(arg_12_0)
	if arg_12_0._touchEventMgr then
		TouchEventMgrHepler.remove(arg_12_0._touchEventMgr)

		arg_12_0._touchEventMgr = nil
	end
end

return var_0_0
