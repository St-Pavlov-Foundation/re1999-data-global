module("modules.logic.room.view.RoomViewNavigateBubble", package.seeall)

local var_0_0 = class("RoomViewNavigateBubble", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gopanel = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/go_navigatebubble")
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/go_navigatebubble/go_layout")
	arg_1_0._gocategoryitem = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/go_navigatebubble/go_layout/roomnavigatebubbleitem")

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
	arg_4_0._nodeUIs = {}
	arg_4_0._processedNodes = {}
end

function var_0_0.onDestroyView(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0._nodeUIs) do
		iter_5_1.btnself:RemoveClickListener()

		for iter_5_2, iter_5_3 in pairs(iter_5_1.childrenNodes) do
			iter_5_3.btnself:RemoveClickListener()
		end
	end

	arg_5_0._processedNodes = nil
end

function var_0_0.onOpen(arg_6_0)
	RoomNavigateBubbleController.instance:init()
	arg_6_0:addEventCb(RoomNavigateBubbleController.instance, RoomEvent.NavigateBubbleUpdate, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(RoomCharacterController.instance, RoomEvent.UpdateCharacterInteractionUI, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:refreshUI()
end

function var_0_0.onClose(arg_7_0)
	arg_7_0:removeEventCb(RoomNavigateBubbleController.instance, RoomEvent.NavigateBubbleUpdate, arg_7_0.refreshUI, arg_7_0)
	arg_7_0:removeEventCb(RoomCharacterController.instance, RoomEvent.UpdateCharacterInteractionUI, arg_7_0.refreshUI, arg_7_0)
	RoomNavigateBubbleController.instance:clear()
end

function var_0_0.refreshUI(arg_8_0)
	if RoomCharacterHelper.isInDialogInteraction() then
		gohelper.setActive(arg_8_0._gopanel, false)

		return
	end

	local var_8_0 = RoomNavigateBubbleModel.instance:getCategoryMap()

	if var_8_0 and tabletool.len(var_8_0) > 0 then
		for iter_8_0, iter_8_1 in pairs(var_8_0) do
			arg_8_0:refreshCategoryItem(iter_8_1, iter_8_0)
		end

		gohelper.setActive(arg_8_0._gopanel, true)
	else
		gohelper.setActive(arg_8_0._gopanel, false)
	end

	arg_8_0:hideNoProcessNodes()
end

function var_0_0.refreshCategoryItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:getOrCreateCategoryItem(arg_9_2)

	arg_9_0._processedNodes[var_9_0] = 1

	local var_9_1 = var_9_0.expand and "1" or "0"

	UISpriteSetMgr.instance:setRoomSprite(var_9_0.imagebg, string.format("xw_bubblebg_%s", var_9_1))
	SLFramework.UGUI.GuiHelper.SetColor(var_9_0.imageType, tonumber(var_9_1) == 1 and "#ffffff" or "#262a27")
	SLFramework.UGUI.GuiHelper.SetColor(var_9_0.txtcategory, tonumber(var_9_1) == 1 and "#f8f8f8" or "#262a27")

	local var_9_2 = arg_9_1:getBubblesCount()

	var_9_0.txtcategory.text = tostring(var_9_2)

	local var_9_3 = arg_9_1:getBubbles()

	if tabletool.len(var_9_3) > 0 and var_9_2 > 0 then
		for iter_9_0, iter_9_1 in ipairs(var_9_3) do
			local var_9_4 = iter_9_1:getShowType()
			local var_9_5 = arg_9_0:getOrCreateBubbleItem(var_9_0, var_9_4)
			local var_9_6 = iter_9_1:getBubbleCount()

			if var_9_6 > 0 then
				var_9_5.txtbubble.text = tostring(var_9_6)

				gohelper.setActive(var_9_5.go, var_9_0.expand)

				arg_9_0._processedNodes[var_9_5] = 1

				gohelper.setActive(var_9_5.gobubbleeffect, var_9_0.expand and var_9_4 == RoomNavigateBubbleEnum.FactoryBubbleType.BuildingUpgrade)
			else
				gohelper.setActive(var_9_5.go, false)
			end
		end

		gohelper.setActive(var_9_0.go, true)
	else
		gohelper.setActive(var_9_0.go, false)
	end
end

function var_0_0.onClickCategory(arg_10_0)
	local var_10_0 = arg_10_0.self
	local var_10_1 = arg_10_0.index
	local var_10_2 = var_10_0:getOrCreateCategoryItem(var_10_1)
	local var_10_3 = RoomNavigateBubbleModel.instance:getCategoryMap()

	if not var_10_3 then
		return
	end

	local var_10_4 = var_10_3[var_10_1]

	var_10_2.expand = not var_10_2.expand

	var_10_0:refreshCategoryItem(var_10_4, var_10_1)
	ZProj.UGUIHelper.RebuildLayout(var_10_0._gocontainer.transform)
end

function var_0_0.onClickBubble(arg_11_0)
	local var_11_0 = arg_11_0.self
	local var_11_1 = arg_11_0.bubbleType
	local var_11_2 = arg_11_0.categoryIndex
	local var_11_3 = var_11_0:getOrCreateCategoryItem(var_11_2)
	local var_11_4 = RoomNavigateBubbleModel.instance:getCategoryMap()

	if not var_11_4 then
		return
	end

	var_11_0:getOrCreateBubbleItem(var_11_3, var_11_1)

	local var_11_5 = var_11_4[var_11_2]:getBubbleByType(var_11_1)

	RoomNavigateBubbleController.instance:onClickCall(var_11_5)
end

function var_0_0.hideNoProcessNodes(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0._nodeUIs) do
		if not arg_12_0._processedNodes[iter_12_1] then
			gohelper.setActive(iter_12_1.go, false)
		else
			for iter_12_2, iter_12_3 in pairs(iter_12_1.childrenNodes) do
				if not arg_12_0._processedNodes[iter_12_3] then
					gohelper.setActive(iter_12_3.go, false)
				end
			end
		end
	end

	for iter_12_4, iter_12_5 in pairs(arg_12_0._processedNodes) do
		arg_12_0._processedNodes[iter_12_4] = nil
	end
end

function var_0_0.getOrCreateCategoryItem(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._nodeUIs[arg_13_1]

	if not var_13_0 then
		var_13_0 = arg_13_0:getUserDataTb_()

		local var_13_1 = arg_13_0.viewContainer:getSetting().otherRes[5]
		local var_13_2 = arg_13_0:getResInst(var_13_1, arg_13_0._gocontainer, "category_item_" .. tostring(arg_13_1))

		var_13_0.go = var_13_2
		var_13_0.imagebg = gohelper.findChildImage(var_13_2, "bubblecategory/image_bg")
		var_13_0.imageType = gohelper.findChildImage(var_13_2, "bubblecategory/image_type")
		var_13_0.txtcategory = gohelper.findChildText(var_13_2, "bubblecategory/txt_num")
		var_13_0.gobubbleitem = gohelper.findChild(var_13_2, "childitemContent/roomnavigatebubblechilditem")
		var_13_0.btnself = gohelper.findChildButtonWithAudio(var_13_2, "bubblecategory/btn_categoryclick")

		var_13_0.btnself:AddClickListener(arg_13_0.onClickCategory, {
			self = arg_13_0,
			index = arg_13_1
		})
		gohelper.addUIClickAudio(var_13_0.btnself.gameObject, AudioEnum.UI.play_ui_callfor_open)

		var_13_0.index = arg_13_1
		var_13_0.expand = true

		gohelper.setActive(var_13_0.go, false)

		var_13_0.childrenNodes = {}
		arg_13_0._nodeUIs[arg_13_1] = var_13_0
	end

	return var_13_0
end

function var_0_0.getOrCreateBubbleItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1.childrenNodes[arg_14_2]

	if not var_14_0 then
		var_14_0 = arg_14_0:getUserDataTb_()

		local var_14_1 = gohelper.clone(arg_14_1.gobubbleitem, arg_14_1.go, "bubble_item_" .. tostring(arg_14_2))

		var_14_0.go = var_14_1
		var_14_0.imagebubblechild = gohelper.findChildImage(var_14_1, "imagebubblechild")
		var_14_0.gobg = gohelper.findChild(var_14_1, "txtbg")
		var_14_0.txtbubble = gohelper.findChildText(var_14_1, "txtbg/txt_bubblechildnum")
		var_14_0.gobubbleeffect = gohelper.findChild(var_14_1, "#xw_bubbleicon_up")
		var_14_0.btnself = gohelper.findChildButtonWithAudio(var_14_1, "btn_bubbleclick")

		var_14_0.btnself:AddClickListener(arg_14_0.onClickBubble, {
			self = arg_14_0,
			bubbleType = arg_14_2,
			categoryIndex = arg_14_1.index
		})
		gohelper.setActive(var_14_0.go, true)

		arg_14_1.childrenNodes[arg_14_2] = var_14_0

		local var_14_2 = not RoomNavigateBubbleEnum.BubbleHideNum[arg_14_2]

		gohelper.setActive(var_14_0.gobg, var_14_2)

		local var_14_3 = RoomNavigateBubbleEnum.Bubble2ResPath[arg_14_2]

		if not string.nilorempty(var_14_3) then
			UISpriteSetMgr.instance:setRoomSprite(var_14_0.imagebubblechild, var_14_3, true)
		end

		arg_14_0:_addUIClickAudio(var_14_0.btnself.gameObject, arg_14_2)
	end

	return var_14_0
end

function var_0_0._addUIClickAudio(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_2 == RoomNavigateBubbleEnum.FactoryBubbleType.BuildingUpgrade then
		gohelper.addUIClickAudio(arg_15_1, AudioEnum.UI.play_ui_admission_open)
	elseif arg_15_2 == RoomNavigateBubbleEnum.FactoryBubbleType.FaithReward then
		gohelper.addUIClickAudio(arg_15_1, AudioEnum.Room.ui_home_board_upgrade)
	elseif arg_15_2 == RoomNavigateBubbleEnum.FactoryBubbleType.FaithFull then
		gohelper.addUIClickAudio(arg_15_1, AudioEnum.Room.ui_home_board_upgrade)
	end
end

return var_0_0
