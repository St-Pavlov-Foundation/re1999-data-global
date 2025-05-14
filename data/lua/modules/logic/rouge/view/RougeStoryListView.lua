module("modules.logic.rouge.view.RougeStoryListView", package.seeall)

local var_0_0 = class("RougeStoryListView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollstorylist = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_storylist")
	arg_1_0._goline = gohelper.findChild(arg_1_0.viewGO, "#scroll_storylist/viewport/content/linelayout/#go_line")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")

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
	arg_4_0._goStoryListContent = gohelper.findChild(arg_4_0.viewGO, "#scroll_storylist/viewport/content")
	arg_4_0._storyItemList = arg_4_0:getUserDataTb_()
end

function var_0_0._cloneStoryItem(arg_5_0)
	arg_5_0:_stopStoryItemEnterAnim()

	local var_5_0 = RougeFavoriteConfig.instance:getStoryList()

	arg_5_0.storyItemMoList = var_5_0

	local var_5_1 = arg_5_0.viewContainer:getSetting().otherRes[1]

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_2 = arg_5_0._storyItemList[iter_5_0]

		if not var_5_2 then
			var_5_2 = {
				go = arg_5_0:getResInst(var_5_1, arg_5_0._goStoryListContent, "item" .. iter_5_0)
			}
			var_5_2.anim = var_5_2.go:GetComponent(typeof(UnityEngine.Animator))
			var_5_2.item = MonoHelper.addNoUpdateLuaComOnceToGo(var_5_2.go, RougeStoryListItem)
			var_5_2.anim.enabled = false

			table.insert(arg_5_0._storyItemList, var_5_2)
		end

		gohelper.setActive(var_5_2.go, false)
		var_5_2.item:onUpdateMO(iter_5_1)
	end

	arg_5_0.playedAnimIndex = 0

	arg_5_0:_showStoryItemEnterAnim()
end

function var_0_0._stopStoryItemEnterAnim(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._showStoryItemEnterAnim, arg_6_0)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._storyItemList) do
		iter_6_1.anim.enabled = false

		gohelper.setActive(iter_6_1.go, false)
	end
end

function var_0_0._showStoryItemEnterAnim(arg_7_0)
	if arg_7_0.playedAnimIndex >= #arg_7_0.storyItemMoList then
		return
	end

	arg_7_0.playedAnimIndex = arg_7_0.playedAnimIndex + 1

	gohelper.setActive(arg_7_0._storyItemList[arg_7_0.playedAnimIndex].go, true)

	arg_7_0._storyItemList[arg_7_0.playedAnimIndex].anim.enabled = true

	TaskDispatcher.runDelay(arg_7_0._showStoryItemEnterAnim, arg_7_0, 0.03)
end

function var_0_0.onClose(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._showStoryItemEnterAnim, arg_8_0)
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:_cloneStoryItem()
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
