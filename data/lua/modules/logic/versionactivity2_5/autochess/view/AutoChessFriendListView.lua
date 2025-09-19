module("modules.logic.versionactivity2_5.autochess.view.AutoChessFriendListView", package.seeall)

local var_0_0 = class("AutoChessFriendListView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")
	arg_1_0._goFriendItem = gohelper.findChild(arg_1_0.viewGO, "root/#scroll_list/viewport/content/go_FriendItem")
	arg_1_0._goFriendItemRoot = gohelper.findChild(arg_1_0.viewGO, "root/#scroll_list/viewport/content")
	arg_1_0._goFriendList = gohelper.findChild(arg_1_0.viewGO, "root/#scroll_list")
	arg_1_0._goEmpty = gohelper.findChild(arg_1_0.viewGO, "root/go_empty")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0.onClickClose, arg_2_0)
	arg_2_0:addEventCb(AutoChessController.instance, AutoChessEvent.SelectFriendSnapshot, arg_2_0.onClickClose, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0.onClickModalMask(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onClickClose(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = Activity182Model.instance:getCurActId()
	local var_7_1 = Activity182Model.instance:getActMo(var_7_0):getFriendInfoList()

	arg_7_0._friendDataList = {}

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		local var_7_2 = {
			portrait = iter_7_1.portrait,
			name = iter_7_1.name,
			rank = iter_7_1.rank,
			userId = iter_7_1.userId
		}

		arg_7_0._friendDataList[#arg_7_0._friendDataList + 1] = var_7_2
	end

	if #arg_7_0._friendDataList == 0 then
		gohelper.setActive(arg_7_0._goEmpty, true)
		gohelper.setActive(arg_7_0._goFriendList, false)
	else
		gohelper.setActive(arg_7_0._goEmpty, false)
		gohelper.setActive(arg_7_0._goFriendList, true)
	end

	arg_7_0:createFriendItemList()
end

function var_0_0.createFriendItemList(arg_8_0)
	arg_8_0._recordItemDict = {}

	gohelper.CreateObjList(arg_8_0, arg_8_0._createFriendItem, arg_8_0._friendDataList, arg_8_0._goFriendItemRoot, arg_8_0._goFriendItem, AutoChessFriendItem)
end

function var_0_0._createFriendItem(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_1:onUpdateData(arg_9_2)
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
