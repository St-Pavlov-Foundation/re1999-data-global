module("modules.logic.versionactivity1_5.aizila.view.AiZiLaRecordView", package.seeall)

local var_0_0 = class("AiZiLaRecordView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goLeftTabContent = gohelper.findChild(arg_1_0.viewGO, "scroll_Left/Viewport/#go_LeftTabContent")
	arg_1_0._goLeftTabItem = gohelper.findChild(arg_1_0.viewGO, "#go_LeftTabItem")
	arg_1_0._goRecordItem = gohelper.findChild(arg_1_0.viewGO, "#go_RecordItem")
	arg_1_0._scrollRight = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_Right")
	arg_1_0._goRightItemContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_Right/Viewport/#go_RightItemContent")
	arg_1_0._goArrow = gohelper.findChild(arg_1_0.viewGO, "#go_Arrow")

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
	gohelper.setActive(arg_4_0._goLeftTabItem, false)
	gohelper.setActive(arg_4_0._goRecordItem, false)
	arg_4_0._scrollRight:AddOnValueChanged(arg_4_0._onScrollValueChanged, arg_4_0)
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(AiZiLaController.instance, AiZiLaEvent.UISelectRecordTabItem, arg_6_0._onSelectRecordTabItem, arg_6_0)

	if arg_6_0.viewContainer then
		NavigateMgr.instance:addEscape(arg_6_0.viewContainer.viewName, arg_6_0.closeThis, arg_6_0)
	end

	arg_6_0._recordMOList = {}

	tabletool.addValues(arg_6_0._recordMOList, AiZiLaModel.instance:getRecordMOList())

	arg_6_0._selectRecordMO = arg_6_0._recordMOList[1]

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._recordMOList) do
		if iter_6_1:isUnLock() then
			arg_6_0._selectRecordMO = iter_6_1

			break
		end
	end

	arg_6_0._initSelectRecordMO = arg_6_0._selectRecordMO

	arg_6_0:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_forward_paper4)
end

function var_0_0.onClose(arg_7_0)
	arg_7_0:_finishRed(arg_7_0._initSelectRecordMO)
end

function var_0_0.onDestroyView(arg_8_0)
	arg_8_0._scrollRight:RemoveOnValueChanged()
end

function var_0_0._getSelectGroupMOList(arg_9_0)
	return arg_9_0._selectRecordMO and arg_9_0._selectRecordMO:getRroupMOList()
end

function var_0_0._onSelectRecordTabItem(arg_10_0, arg_10_1)
	if not arg_10_1 or arg_10_0._selectRecordMO and arg_10_0._selectRecordMO.id == arg_10_1 then
		return
	end

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._recordMOList) do
		if iter_10_1.id == arg_10_1 then
			arg_10_0._selectRecordMO = iter_10_1

			arg_10_0:refreshUI()
			arg_10_0:_finishRed(iter_10_1)

			return
		end
	end
end

function var_0_0._onScrollValueChanged(arg_11_0, arg_11_1)
	local var_11_0 = gohelper.getRemindFourNumberFloat(arg_11_0._scrollRight.verticalNormalizedPosition) > 0

	gohelper.setActive(arg_11_0._goArrow, var_11_0)

	if not var_11_0 then
		arg_11_0:_finishRed(arg_11_0._selectRecordMO)
	end
end

function var_0_0.refreshUI(arg_12_0)
	gohelper.CreateObjList(arg_12_0, arg_12_0._onRecordTabItem, arg_12_0._recordMOList, arg_12_0._goLeftTabContent, arg_12_0._goLeftTabItem, AiZiLaRecordTabItem)
	arg_12_0:_refreshRecordUI()
end

function var_0_0._refreshRecordUI(arg_13_0)
	local var_13_0 = {}

	tabletool.addValues(var_13_0, arg_13_0:_getSelectGroupMOList())
	gohelper.CreateObjList(arg_13_0, arg_13_0._onRecordItem, var_13_0, arg_13_0._goRightItemContent, arg_13_0._goRecordItem, AiZiLaRecordItem)
end

function var_0_0._onRecordTabItem(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_1:onUpdateMO(arg_14_2)
	arg_14_1:onSelect(arg_14_0._selectRecordMO and arg_14_2 and arg_14_0._selectRecordMO.id == arg_14_2.id)
end

function var_0_0._onRecordItem(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_1:onUpdateMO(arg_15_2)
end

function var_0_0._finishRed(arg_16_0, arg_16_1)
	if arg_16_1 and arg_16_1:isHasRed() then
		arg_16_1:finishRed()
		AiZiLaModel.instance:checkRecordRed()
	end
end

return var_0_0
