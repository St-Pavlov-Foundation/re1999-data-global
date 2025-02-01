module("modules.logic.room.view.RoomViewNavigateBubble", package.seeall)

slot0 = class("RoomViewNavigateBubble", BaseView)

function slot0.onInitView(slot0)
	slot0._gopanel = gohelper.findChild(slot0.viewGO, "go_normalroot/go_navigatebubble")
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "go_normalroot/go_navigatebubble/go_layout")
	slot0._gocategoryitem = gohelper.findChild(slot0.viewGO, "go_normalroot/go_navigatebubble/go_layout/roomnavigatebubbleitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._nodeUIs = {}
	slot0._processedNodes = {}
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0._nodeUIs) do
		slot5.btnself:RemoveClickListener()

		for slot9, slot10 in pairs(slot5.childrenNodes) do
			slot10.btnself:RemoveClickListener()
		end
	end

	slot0._processedNodes = nil
end

function slot0.onOpen(slot0)
	RoomNavigateBubbleController.instance:init()
	slot0:addEventCb(RoomNavigateBubbleController.instance, RoomEvent.NavigateBubbleUpdate, slot0.refreshUI, slot0)
	slot0:addEventCb(RoomCharacterController.instance, RoomEvent.UpdateCharacterInteractionUI, slot0.refreshUI, slot0)
	slot0:refreshUI()
end

function slot0.onClose(slot0)
	slot0:removeEventCb(RoomNavigateBubbleController.instance, RoomEvent.NavigateBubbleUpdate, slot0.refreshUI, slot0)
	slot0:removeEventCb(RoomCharacterController.instance, RoomEvent.UpdateCharacterInteractionUI, slot0.refreshUI, slot0)
	RoomNavigateBubbleController.instance:clear()
end

function slot0.refreshUI(slot0)
	if RoomCharacterHelper.isInDialogInteraction() then
		gohelper.setActive(slot0._gopanel, false)

		return
	end

	if RoomNavigateBubbleModel.instance:getCategoryMap() and tabletool.len(slot2) > 0 then
		for slot6, slot7 in pairs(slot2) do
			slot0:refreshCategoryItem(slot7, slot6)
		end

		gohelper.setActive(slot0._gopanel, true)
	else
		gohelper.setActive(slot0._gopanel, false)
	end

	slot0:hideNoProcessNodes()
end

function slot0.refreshCategoryItem(slot0, slot1, slot2)
	slot3 = slot0:getOrCreateCategoryItem(slot2)
	slot0._processedNodes[slot3] = 1
	slot4 = slot3.expand and "1" or "0"

	UISpriteSetMgr.instance:setRoomSprite(slot3.imagebg, string.format("xw_bubblebg_%s", slot4))
	SLFramework.UGUI.GuiHelper.SetColor(slot3.imageType, tonumber(slot4) == 1 and "#ffffff" or "#262a27")
	SLFramework.UGUI.GuiHelper.SetColor(slot3.txtcategory, tonumber(slot4) == 1 and "#f8f8f8" or "#262a27")

	slot3.txtcategory.text = tostring(slot1:getBubblesCount())

	if tabletool.len(slot1:getBubbles()) > 0 and slot5 > 0 then
		for slot10, slot11 in ipairs(slot6) do
			slot13 = slot0:getOrCreateBubbleItem(slot3, slot11:getShowType())

			if slot11:getBubbleCount() > 0 then
				slot13.txtbubble.text = tostring(slot14)

				gohelper.setActive(slot13.go, slot3.expand)

				slot0._processedNodes[slot13] = 1

				gohelper.setActive(slot13.gobubbleeffect, slot3.expand and slot12 == RoomNavigateBubbleEnum.FactoryBubbleType.BuildingUpgrade)
			else
				gohelper.setActive(slot13.go, false)
			end
		end

		gohelper.setActive(slot3.go, true)
	else
		gohelper.setActive(slot3.go, false)
	end
end

function slot0.onClickCategory(slot0)
	slot3 = slot0.self:getOrCreateCategoryItem(slot0.index)

	if not RoomNavigateBubbleModel.instance:getCategoryMap() then
		return
	end

	slot3.expand = not slot3.expand

	slot1:refreshCategoryItem(slot4[slot2], slot2)
	ZProj.UGUIHelper.RebuildLayout(slot1._gocontainer.transform)
end

function slot0.onClickBubble(slot0)
	slot2 = slot0.bubbleType
	slot4 = slot0.self:getOrCreateCategoryItem(slot0.categoryIndex)

	if not RoomNavigateBubbleModel.instance:getCategoryMap() then
		return
	end

	slot1:getOrCreateBubbleItem(slot4, slot2)
	RoomNavigateBubbleController.instance:onClickCall(slot5[slot3]:getBubbleByType(slot2))
end

function slot0.hideNoProcessNodes(slot0)
	for slot4, slot5 in pairs(slot0._nodeUIs) do
		if not slot0._processedNodes[slot5] then
			gohelper.setActive(slot5.go, false)
		else
			for slot9, slot10 in pairs(slot5.childrenNodes) do
				if not slot0._processedNodes[slot10] then
					gohelper.setActive(slot10.go, false)
				end
			end
		end
	end

	for slot4, slot5 in pairs(slot0._processedNodes) do
		slot0._processedNodes[slot4] = nil
	end
end

function slot0.getOrCreateCategoryItem(slot0, slot1)
	if not slot0._nodeUIs[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot4 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[5], slot0._gocontainer, "category_item_" .. tostring(slot1))
		slot2.go = slot4
		slot2.imagebg = gohelper.findChildImage(slot4, "bubblecategory/image_bg")
		slot2.imageType = gohelper.findChildImage(slot4, "bubblecategory/image_type")
		slot2.txtcategory = gohelper.findChildText(slot4, "bubblecategory/txt_num")
		slot2.gobubbleitem = gohelper.findChild(slot4, "childitemContent/roomnavigatebubblechilditem")
		slot2.btnself = gohelper.findChildButtonWithAudio(slot4, "bubblecategory/btn_categoryclick")

		slot2.btnself:AddClickListener(slot0.onClickCategory, {
			self = slot0,
			index = slot1
		})
		gohelper.addUIClickAudio(slot2.btnself.gameObject, AudioEnum.UI.play_ui_callfor_open)

		slot2.index = slot1
		slot2.expand = true

		gohelper.setActive(slot2.go, false)

		slot2.childrenNodes = {}
		slot0._nodeUIs[slot1] = slot2
	end

	return slot2
end

function slot0.getOrCreateBubbleItem(slot0, slot1, slot2)
	if not slot1.childrenNodes[slot2] then
		slot3 = slot0:getUserDataTb_()
		slot4 = gohelper.clone(slot1.gobubbleitem, slot1.go, "bubble_item_" .. tostring(slot2))
		slot3.go = slot4
		slot3.imagebubblechild = gohelper.findChildImage(slot4, "imagebubblechild")
		slot3.gobg = gohelper.findChild(slot4, "txtbg")
		slot3.txtbubble = gohelper.findChildText(slot4, "txtbg/txt_bubblechildnum")
		slot3.gobubbleeffect = gohelper.findChild(slot4, "#xw_bubbleicon_up")
		slot3.btnself = gohelper.findChildButtonWithAudio(slot4, "btn_bubbleclick")

		slot3.btnself:AddClickListener(slot0.onClickBubble, {
			self = slot0,
			bubbleType = slot2,
			categoryIndex = slot1.index
		})
		gohelper.setActive(slot3.go, true)

		slot1.childrenNodes[slot2] = slot3

		gohelper.setActive(slot3.gobg, not RoomNavigateBubbleEnum.BubbleHideNum[slot2])

		if not string.nilorempty(RoomNavigateBubbleEnum.Bubble2ResPath[slot2]) then
			UISpriteSetMgr.instance:setRoomSprite(slot3.imagebubblechild, slot6, true)
		end

		slot0:_addUIClickAudio(slot3.btnself.gameObject, slot2)
	end

	return slot3
end

function slot0._addUIClickAudio(slot0, slot1, slot2)
	if slot2 == RoomNavigateBubbleEnum.FactoryBubbleType.BuildingUpgrade then
		gohelper.addUIClickAudio(slot1, AudioEnum.UI.play_ui_admission_open)
	elseif slot2 == RoomNavigateBubbleEnum.FactoryBubbleType.FaithReward then
		gohelper.addUIClickAudio(slot1, AudioEnum.Room.ui_home_board_upgrade)
	elseif slot2 == RoomNavigateBubbleEnum.FactoryBubbleType.FaithFull then
		gohelper.addUIClickAudio(slot1, AudioEnum.Room.ui_home_board_upgrade)
	end
end

return slot0
