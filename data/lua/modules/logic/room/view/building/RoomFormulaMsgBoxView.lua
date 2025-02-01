module("modules.logic.room.view.building.RoomFormulaMsgBoxView", package.seeall)

slot0 = class("RoomFormulaMsgBoxView", BaseView)
slot1 = -92.5

function slot0.onInitView(slot0)
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#txt_desc")
	slot0._btnyes = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_yes")
	slot0._btnno = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_no")
	slot0._goScrollView = gohelper.findChild(slot0.viewGO, "Exchange/Left/Scroll View")
	slot0._originalScrollViewPosX, slot0._originalScrollViewPosY, _ = transformhelper.getLocalPos(slot0._goScrollView.transform)
	slot0._goContent = gohelper.findChild(slot0.viewGO, "Exchange/Left/Scroll View/Viewport/Content")
	slot0._contentGrid = slot0._goContent:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	slot0._goPropItem = gohelper.findChild(slot0.viewGO, "Exchange/Left/Scroll View/Viewport/Content/#go_PropItem")

	gohelper.setActive(slot0._goPropItem, false)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnyes:AddClickListener(slot0._btnyesOnClick, slot0)
	slot0._btnno:AddClickListener(slot0._btnnoOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnyes:RemoveClickListener()
	slot0._btnno:RemoveClickListener()
end

function slot0._btnyesOnClick(slot0)
	slot1 = RoomProductionModel.instance:getLineMO(slot0.viewParam.lineId)

	if slot0.viewParam.callback then
		slot2(slot0.viewParam.callbackObj)
	end

	RoomRpc.instance:sendStartProductionLineRequest(slot1.id, slot0.viewParam.costItemAndFormulaIdList.formulaIdList, slot0.costItemList)
	slot0:closeThis()
end

function slot0._btnnoOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._rightImageRare = gohelper.findChildImage(slot0.viewGO, "Exchange/Right/#image_rare")
	slot0._sImageRightProduceItem = gohelper.findChildSingleImage(slot0.viewGO, "Exchange/Right/#simage_produceitem")
	slot0._txtRightNum = gohelper.findChildText(slot0.viewGO, "Exchange/Right/image_NumBG/#txt_Num")
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_upgrade)

	if not slot0.viewParam then
		return
	end

	slot0._contentGrid.enabled = false
	slot1, slot2 = ItemModel.instance:getItemConfigAndIcon(slot0.viewParam.produce.type, slot0.viewParam.produce.id)

	slot0._sImageRightProduceItem:LoadImage(slot2)
	UISpriteSetMgr.instance:setRoomSprite(slot0._rightImageRare, "huangyuan_pz_" .. CharacterEnum.Color[slot1.rare])

	slot3 = luaLang("multiple") .. tostring(slot0.viewParam.produce.quantity)
	slot0._txtRightNum.text = slot3
	slot0._txtdesc.text = formatLuaLang("room_formula_easy_combine_msg_box_tip", string.format("%s%s", slot1.name, slot3))

	if slot0.viewParam.costItemAndFormulaIdList.itemTypeDic then
		slot0.costItemList = {}

		for slot9, slot10 in pairs(slot5) do
			for slot14, slot15 in pairs(slot10) do
				if slot15 > 0 then
					table.insert(slot0.costItemList, {
						type = slot9,
						id = slot14,
						quantity = slot15
					})
				end
			end
		end
	end

	RoomFormulaMsgBoxModel.instance:setCostItemList(slot0.costItemList)

	if #RoomFormulaMsgBoxModel.instance:getList() <= slot0.viewContainer.lineCount then
		transformhelper.setLocalPosXY(slot0._goScrollView.transform, slot0._originalScrollViewPosX, uv0)

		slot0._contentGrid.enabled = true
	else
		slot0._contentGrid.enabled = false

		transformhelper.setLocalPosXY(slot0._goScrollView.transform, slot0._originalScrollViewPosX, slot0._originalScrollViewPosY)
	end
end

function slot0.onClose(slot0)
end

return slot0
