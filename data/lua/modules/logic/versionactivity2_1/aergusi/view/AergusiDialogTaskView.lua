module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogTaskView", package.seeall)

local var_0_0 = class("AergusiDialogTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotask = gohelper.findChild(arg_1_0.viewGO, "#go_task")
	arg_1_0._gotarget1 = gohelper.findChild(arg_1_0.viewGO, "#go_task/TargetList/#go_target1")
	arg_1_0._txttarget1desc = gohelper.findChildText(arg_1_0.viewGO, "#go_task/TargetList/#go_target1/#txt_target1desc")
	arg_1_0._gotarget2 = gohelper.findChild(arg_1_0.viewGO, "#go_task/TargetList/#go_target2")

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
	arg_4_0._taskItems = {}

	arg_4_0:_addEvents()
end

function var_0_0.onOpen(arg_5_0)
	gohelper.setActive(arg_5_0._gotarget1, false)
	gohelper.setActive(arg_5_0._gotarget2, false)
end

function var_0_0.showTaskItems(arg_6_0)
	local var_6_0 = AergusiDialogModel.instance:getCurDialogGroup()
	local var_6_1 = AergusiConfig.instance:getEvidenceConfig(var_6_0)

	gohelper.setActive(arg_6_0._gotarget1, false)

	if LuaUtil.getStrLen(var_6_1.puzzleTxt) ~= 0 then
		gohelper.setActive(arg_6_0._gotarget1, true)

		arg_6_0._txttarget1desc.text = var_6_1.puzzleTxt
	end

	for iter_6_0, iter_6_1 in pairs(arg_6_0._taskItems) do
		iter_6_1:hide()
	end

	local var_6_2 = AergusiDialogModel.instance:getTargetGroupList()

	for iter_6_2 = #var_6_2, 1, -1 do
		if not arg_6_0._taskItems[iter_6_2] then
			local var_6_3 = AergusiDialogTaskItem.New()
			local var_6_4 = gohelper.cloneInPlace(arg_6_0._gotarget2, "target" .. iter_6_2)

			var_6_3:init(var_6_4, iter_6_2)

			arg_6_0._taskItems[iter_6_2] = var_6_3
		end

		arg_6_0._taskItems[iter_6_2]:setCo(var_6_2[iter_6_2])
		arg_6_0._taskItems[iter_6_2]:refreshItem()
	end
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0._addEvents(arg_8_0)
	arg_8_0:addEventCb(AergusiController.instance, AergusiEvent.OnShowDialogGroupFinished, arg_8_0._onShowDialogGroupFinished, arg_8_0)
	arg_8_0:addEventCb(AergusiController.instance, AergusiEvent.OnStartDialogGroup, arg_8_0._onStartDialogGroup, arg_8_0)
end

function var_0_0._removeEvents(arg_9_0)
	arg_9_0:removeEventCb(AergusiController.instance, AergusiEvent.OnShowDialogGroupFinished, arg_9_0._onShowDialogGroupFinished, arg_9_0)
	arg_9_0:removeEventCb(AergusiController.instance, AergusiEvent.OnStartDialogGroup, arg_9_0._onStartDialogGroup, arg_9_0)
end

function var_0_0._onShowDialogGroupFinished(arg_10_0)
	arg_10_0:showTaskItems()
	AergusiController.instance:dispatchEvent(AergusiEvent.OnGuideShowTask)
end

function var_0_0._onStartDialogGroup(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0._taskItems) do
		iter_11_1:refreshItem()
	end
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0:_removeEvents()

	if arg_12_0._taskItems then
		for iter_12_0, iter_12_1 in pairs(arg_12_0._taskItems) do
			iter_12_1:destroy()
		end

		arg_12_0._taskItems = nil
	end
end

return var_0_0
