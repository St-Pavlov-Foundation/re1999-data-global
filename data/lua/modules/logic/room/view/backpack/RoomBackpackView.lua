module("modules.logic.room.view.backpack.RoomBackpackView", package.seeall)

local var_0_0 = class("RoomBackpackView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocategoryItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_category/viewport/content/#go_categoryItem")

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

function var_0_0._btnTabOnClick(arg_4_0, arg_4_1)
	if not arg_4_0.viewContainer:checkTabId(arg_4_1) then
		logError(string.format("RoomBackpackView._btnTabOnClick error, no subview, tabId:%s", arg_4_1))

		return
	end

	if arg_4_0._curSelectTab == arg_4_1 then
		return
	end

	arg_4_0.viewContainer:switchTab(arg_4_1)

	arg_4_0._curSelectTab = arg_4_1

	arg_4_0:refreshTab()
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._gocategoryItem, false)
	arg_5_0:clearVar()
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._curSelectTab = arg_7_0.viewContainer:getDefaultSelectedTab()

	arg_7_0:setTabItem()
	arg_7_0:refreshTab()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_state_lower)
end

function var_0_0.setTabItem(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(RoomBackpackViewContainer.TabSettingList) do
		if not arg_8_0._tabDict[iter_8_0] then
			local var_8_0 = gohelper.cloneInPlace(arg_8_0._gocategoryItem, iter_8_0)

			if not gohelper.isNil(var_8_0) then
				local var_8_1 = arg_8_0:getUserDataTb_()

				var_8_1.go = var_8_0
				var_8_1.btn = gohelper.getClickWithDefaultAudio(var_8_0)

				var_8_1.btn:AddClickListener(arg_8_0._btnTabOnClick, arg_8_0, iter_8_0)

				var_8_1.goselected = gohelper.findChild(var_8_0, "#go_selected")
				var_8_1.gounselected = gohelper.findChild(var_8_0, "#go_normal")
				var_8_1.goreddot = gohelper.findChild(var_8_0, "#go_reddot")

				if iter_8_0 == RoomBackpackViewContainer.SubViewTabId.Critter then
					RedDotController.instance:addRedDot(var_8_1.goreddot, RedDotEnum.DotNode.CritterIsFull)
				end

				local var_8_2 = luaLang(iter_8_1.namecn)
				local var_8_3 = gohelper.findChildText(var_8_0, "#go_normal/#txt_namecn")
				local var_8_4 = gohelper.findChildText(var_8_0, "#go_selected/#txt_namecn")

				var_8_3.text = var_8_2
				var_8_4.text = var_8_2

				local var_8_5 = luaLang(iter_8_1.nameen)
				local var_8_6 = gohelper.findChildText(var_8_0, "#go_normal/#txt_nameen")
				local var_8_7 = gohelper.findChildText(var_8_0, "#go_selected/#txt_nameen")

				var_8_6.text = var_8_5
				var_8_7.text = var_8_5

				gohelper.setActive(var_8_0, true)

				arg_8_0._tabDict[iter_8_0] = var_8_1
			end
		end
	end
end

function var_0_0.refreshTab(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0._tabDict) do
		local var_9_0 = iter_9_0 == arg_9_0._curSelectTab

		gohelper.setActive(iter_9_1.goselected, var_9_0)
		gohelper.setActive(iter_9_1.gounselected, not var_9_0)
	end
end

function var_0_0.clearVar(arg_10_0)
	arg_10_0._curSelectTab = nil

	arg_10_0:clearTab()
end

function var_0_0.clearTab(arg_11_0)
	if arg_11_0._tabDict then
		for iter_11_0, iter_11_1 in pairs(arg_11_0._tabDict) do
			iter_11_1.btn:RemoveClickListener()
		end
	end

	arg_11_0._tabDict = {}
end

function var_0_0.onClose(arg_12_0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_state_normal)
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0:clearVar()
end

return var_0_0
