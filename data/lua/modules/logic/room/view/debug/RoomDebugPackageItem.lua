module("modules.logic.room.view.debug.RoomDebugPackageItem", package.seeall)

slot0 = class("RoomDebugPackageItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._txtdefineid = gohelper.findChildText(slot0.viewGO, "#txt_defineid")
	slot0._txtpackageorder = gohelper.findChildText(slot0.viewGO, "#txt_packageorder")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "#go_select")
	slot0._simagebirthhero = gohelper.findChildSingleImage(slot0.viewGO, "#simage_birthhero")
	slot0._icon = gohelper.onceAddComponent(gohelper.findChild(slot0.viewGO, "icon"), gohelper.Type_RawImage)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	slot1 = UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl)
	slot2 = UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift)
	slot3 = RoomDebugPackageListModel.instance:getSelect()
	slot4 = RoomMapBlockModel.instance:getFullBlockMOById(slot0._mo.id)

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.C) then
		RoomDebugController.instance:debugSetPackageId(slot0._mo.id, 0)
	elseif not slot1 then
		if not slot2 then
			RoomDebugPackageListModel.instance:setSelect(slot0._mo.id)

			if slot4 then
				slot5 = HexMath.hexToPosition(slot4.hexPoint, RoomBlockEnum.BlockSize)

				slot0._scene.camera:tweenCamera({
					focusX = slot5.x,
					focusY = slot5.y
				})
			end
		else
			RoomDebugController.instance:debugSetMainRes(slot0._mo.id)
		end
	elseif not slot3 or slot3 == slot0._mo.id then
		RoomDebugController.instance:debugSetPackageOrder(slot0._mo.id)
	else
		RoomDebugPackageListModel.instance:clearSelect()
		RoomDebugController.instance:exchangeOrder(slot3, slot0._mo.id)
	end
end

function slot0._editableInitView(slot0)
	slot0._scene = GameSceneMgr.instance:getCurScene()
	slot0._isSelect = false

	gohelper.addUIClickAudio(slot0._btnclick.gameObject, AudioEnum.UI.UI_Common_Click)
end

function slot0._refreshUI(slot0)
	slot0._txtdefineid.text = "地块id:" .. slot0._mo.id
	slot0._txtpackageorder.text = string.format("序号: %s", slot0._mo.packageOrder)
	slot0._txtname.text = RoomHelper.getBlockPrefabName(slot0._mo.config.prefabPath)

	slot0:_refreshCharacter(slot0._mo.id)
end

function slot0.onUpdateMO(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot0._isSelect)

	slot0._mo = slot1

	slot0:_refreshUI()
	slot0:_refreshBlock(slot1 and slot1.blockId)
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot1)

	slot0._isSelect = slot1
end

function slot0._refreshBlock(slot0, slot1)
	slot0._lastOldBlockId = slot1

	if slot0._lastOldBlockId then
		GameSceneMgr.instance:getCurScene().inventorymgr:removeBlockEntity(slot3)
	end

	gohelper.setActive(slot0._icon, slot1 and true or false)

	if slot1 then
		slot2.inventorymgr:addBlockEntity(slot1)
		OrthCameraRTMgr.instance:setRawImageUvRect(slot0._icon, slot2.inventorymgr:getIndexById(slot1))
	end
end

function slot0.onDestroy(slot0)
	slot0._simagebirthhero:UnLoadImage()
	slot0:_refreshBlock(nil)
end

function slot0._refreshCharacter(slot0, slot1)
	gohelper.setActive(slot0._simagebirthhero.gameObject, RoomConfig.instance:getSpecialBlockConfig(slot1) ~= nil)

	if not slot2 then
		return
	end

	if not HeroConfig.instance:getHeroCO(slot2.heroId) then
		return
	end

	if not SkinConfig.instance:getSkinCo(slot3.skinId) then
		return
	end

	slot0._simagebirthhero:LoadImage(ResUrl.getHeadIconSmall(slot4.headIcon))
end

return slot0
