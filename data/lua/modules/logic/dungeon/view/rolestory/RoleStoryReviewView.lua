module("modules.logic.dungeon.view.rolestory.RoleStoryReviewView", package.seeall)

local var_0_0 = class("RoleStoryReviewView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.storyItems = {}
	arg_1_0.goStorytItem = gohelper.findChild(arg_1_0.viewGO, "left/#go_herocontainer/#scroll_hero/Viewport/Content/#go_heroitem")
	arg_1_0.txtTitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "right/#txt_title")
	arg_1_0.goLayout = gohelper.findChild(arg_1_0.viewGO, "right/layout")
	arg_1_0.txtEnd = gohelper.findChildTextMesh(arg_1_0.viewGO, "right/#txt_end")
	arg_1_0.btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_close")
	arg_1_0.goTalk = gohelper.findChild(arg_1_0.goLayout, "#go_Talk")
	arg_1_0.goArrow = gohelper.findChild(arg_1_0.goLayout, "#go_Talk/Scroll DecView/Viewport/Content/arrow")
	arg_1_0.goChatItem = gohelper.findChild(arg_1_0.goLayout, "#go_Talk/Scroll DecView/Viewport/Content/#go_chatitem")

	gohelper.setActive(arg_1_0.goChatItem, false)

	arg_1_0.scroll = gohelper.findChildScrollRect(arg_1_0.goLayout, "#go_Talk/Scroll DecView")
	arg_1_0.talkList = {}

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClose, arg_2_0.onClickBtnClose, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ClickReviewItem, arg_2_0._onClickReviewItem, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onClickBtnClose(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._onClickReviewItem(arg_6_0, arg_6_1)
	arg_6_0:refreshDispatchView(arg_6_1)
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.storyId = arg_7_0.viewParam.storyId

	arg_7_0:refreshDispatchList()

	local var_7_0 = 1
	local var_7_1 = arg_7_0.storyItems[var_7_0]

	if var_7_1 then
		var_7_1:onClickBtnClick()
	end
end

function var_0_0.refreshDispatchList(arg_8_0)
	local var_8_0 = RoleStoryConfig.instance:getDispatchList(arg_8_0.storyId, RoleStoryEnum.DispatchType.Story) or {}

	for iter_8_0 = 1, math.max(#var_8_0, #arg_8_0.storyItems) do
		arg_8_0:refreshDispatchItem(arg_8_0.storyItems[iter_8_0], var_8_0[iter_8_0], iter_8_0)
	end
end

function var_0_0.refreshDispatchView(arg_9_0, arg_9_1)
	local var_9_0 = RoleStoryConfig.instance:getDispatchConfig(arg_9_1)

	arg_9_0.txtTitle.text = var_9_0.name
	arg_9_0.txtEnd.text = var_9_0.completeDesc

	arg_9_0:refreshTalk(var_9_0)

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.storyItems) do
		iter_9_1:updateSelect(arg_9_1)
	end

	arg_9_0:layoutView()
end

function var_0_0.refreshDispatchItem(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_1 = arg_10_1 or arg_10_0:createItem(arg_10_3)

	arg_10_1:onUpdateMO(arg_10_2, arg_10_3)
end

function var_0_0.createItem(arg_11_0, arg_11_1)
	local var_11_0 = gohelper.cloneInPlace(arg_11_0.goStorytItem)
	local var_11_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_0, RoleStoryReviewItem)

	arg_11_0.storyItems[arg_11_1] = var_11_1

	return var_11_1
end

function var_0_0.refreshTalk(arg_12_0, arg_12_1)
	local var_12_0 = string.splitToNumber(arg_12_1.talkIds, "#")

	arg_12_0:refreshTalkList(var_12_0)
end

function var_0_0.refreshTalkList(arg_13_0, arg_13_1)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		local var_13_1 = RoleStoryConfig.instance:getTalkConfig(iter_13_1)

		table.insert(var_13_0, var_13_1)
	end

	for iter_13_2 = 1, math.max(#var_13_0, #arg_13_0.talkList) do
		arg_13_0:refreshTalkItem(arg_13_0.talkList[iter_13_2], var_13_0[iter_13_2], iter_13_2)
	end
end

function var_0_0.refreshTalkItem(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_1 = arg_14_1 or arg_14_0:createTalkItem(arg_14_3)

	arg_14_1:onUpdateMO(arg_14_2, arg_14_3)
end

function var_0_0.createTalkItem(arg_15_0, arg_15_1)
	local var_15_0 = gohelper.cloneInPlace(arg_15_0.goChatItem, string.format("go%s", arg_15_1))
	local var_15_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_15_0, RoleStoryDispatchTalkItem)

	arg_15_0.talkList[arg_15_1] = var_15_1

	return var_15_1
end

function var_0_0.layoutView(arg_16_0)
	local var_16_0 = recthelper.getHeight(arg_16_0.goLayout.transform)

	recthelper.setHeight(arg_16_0.goTalk.transform, var_16_0)
end

function var_0_0.onClickModalMask(arg_17_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	arg_17_0:closeThis()
end

function var_0_0.onClose(arg_18_0)
	return
end

function var_0_0.onDestroyView(arg_19_0)
	return
end

return var_0_0
