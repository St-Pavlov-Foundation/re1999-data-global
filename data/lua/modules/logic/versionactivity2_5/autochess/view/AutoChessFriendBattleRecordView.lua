module("modules.logic.versionactivity2_5.autochess.view.AutoChessFriendBattleRecordView", package.seeall)

local var_0_0 = class("AutoChessFriendBattleRecordView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._recordItemRoot = gohelper.findChild(arg_1_0.viewGO, "#scroll_record/viewport/content")
	arg_1_0._goRecordItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_record/viewport/content/#go_recorditem")

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

function var_0_0.onClickBattleRecord(arg_4_0)
	return
end

function var_0_0.onClickFriendList(arg_5_0)
	return
end

function var_0_0.onClickModalMask(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	return
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._actId = Activity182Model.instance:getCurActId()

	local var_9_0 = Activity182Model.instance:getActMo(arg_9_0._actId):getFriendFightRecords()

	arg_9_0._recordDataList = {}

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		arg_9_0._recordDataList[#var_9_0 - iter_9_0 + 1] = iter_9_1
	end

	arg_9_0:_createRecordItems()
end

function var_0_0._createRecordItems(arg_10_0)
	arg_10_0._recordItemDict = {}

	gohelper.CreateObjList(arg_10_0, arg_10_0._createRecordItem, arg_10_0._recordDataList, arg_10_0._recordItemRoot, arg_10_0._goRecordItem, AutoChessBattleRecordItem)
end

function var_0_0._createRecordItem(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_1:onUpdateData(arg_11_2)
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
