module("modules.logic.room.view.RoomInventorySelectItem", package.seeall)

slot0 = class("RoomInventorySelectItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnItem:AddClickListener(slot0._onBtnItemClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnItem:RemoveClickListener()
end

function slot0._editableAddEvents(slot0)
	RoomMapController.instance:registerCallback(RoomEvent.BackBlockListDataChanged, slot0._onBackBlockChanged, slot0)
	RoomMapController.instance:registerCallback(RoomEvent.BackBlockPlayUIAnim, slot0._onPlayAnim, slot0)
end

function slot0._editableRemoveEvents(slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.BackBlockListDataChanged, slot0._onBackBlockChanged, slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.BackBlockPlayUIAnim, slot0._onPlayAnim, slot0)
end

function slot0._editableInitView(slot0)
	slot0._rtIndex = OrthCameraRTMgr.instance:getNewIndex()
	slot0._goselect = gohelper.findChild(slot0.viewGO, "go_select")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "go_empty")
	slot0._goicon = gohelper.findChild(slot0.viewGO, "go_icon")
	slot0._gobirthicon = gohelper.findChild(slot0.viewGO, "go_birthicon")
	slot0._simagebirthhero = gohelper.findChildSingleImage(slot0.viewGO, "go_birthicon/simage_birthhero")
	slot0._goonbirthdayicon = gohelper.findChild(slot0.viewGO, "go_birthicon/#image_onbirthday")
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._btnItem = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_icon")
	slot0._rawImageIcon = gohelper.onceAddComponent(slot0._goicon, gohelper.Type_RawImage)

	OrthCameraRTMgr.instance:setRawImageUvRect(slot0._rawImageIcon, slot0._rtIndex)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._rawImageIcon, "#BFB5A3")

	slot0._scene = GameSceneMgr.instance:getCurScene()

	gohelper.setActive(slot0._goempty, false)

	slot0._backBlockIds = {}
end

function slot0._onBackBlockChanged(slot0, slot1, slot2, slot3, slot4)
	if slot2 then
		if slot0:_IsShow() then
			slot0:_playBackBlockAnim(slot1, false, slot4)
		else
			tabletool.addValues(slot0._backBlockIds, slot1)
		end
	end
end

function slot0._onPlayAnim(slot0)
	if slot0:_IsShow() and #slot0._backBlockIds > 0 then
		slot0._backBlockIds = {}

		slot0:_playBackBlockAnim(slot0._backBlockIds, true)
	end
end

function slot0._playBackBlockAnim(slot0, slot1, slot2, slot3)
	slot5 = nil

	if slot2 then
		if slot0._blockMO and tabletool.indexOf(slot1 or {}, slot0._blockMO.id) then
			slot5 = "dikuai03"
		end
	elseif slot4 then
		slot5 = "dikuai01"
	else
		slot6 = true

		if slot3 and slot0._index then
			slot6 = slot3 < slot0._index
		end

		if slot6 then
			slot5 = "dikuai02"
		end
	end

	if not slot5 then
		return
	end

	slot0._animator:Play(slot5, 0, 0)
end

function slot0._IsShow(slot0)
	if RoomMapBlockModel.instance:isBackMore() or RoomBuildingController.instance:isBuildingListShow() then
		return false
	end

	return true
end

function slot0._onBtnItemClick(slot0)
	if not slot0._blockMO then
		return
	end

	slot1 = slot0._blockMO

	RoomShowBlockListModel.instance:setSelect(slot0._blockMO.id)

	slot4 = slot0._scene.fsm:getCurStateName()

	if RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceConfirm) then
		slot5 = RoomMapBlockModel.instance:getTempBlockMO()
		slot6 = HexMath.hexToPosition(slot5.hexPoint, RoomBlockEnum.BlockSize)

		if slot5.id == slot2 then
			if RoomHelper.isOutCameraFocusCenter(slot6) then
				if not slot3.camera:isTweening() then
					slot3.camera:tweenCamera({
						focusX = slot6.x,
						focusY = slot6.y
					})
				end
			else
				GameFacade.showToast(ToastEnum.RoomInventorySelect)
			end
		else
			slot3.fsm:triggerEvent(RoomSceneEvent.TryPlaceBlock, {
				hexPoint = slot5.hexPoint
			})
		end
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.SelectBlock)
end

function slot0._refreshBlock(slot0, slot1, slot2)
	if slot2 then
		slot0._scene.inventorymgr:removeBlockEntity(slot2)
	end

	if slot1 then
		slot0._scene.inventorymgr:addBlockEntity(slot1)
		OrthCameraRTMgr.instance:setRawImageUvRect(slot0._rawImageIcon, slot0._scene.inventorymgr:getIndexById(slot1))
	end
end

function slot0.getBlockMO(slot0)
	return slot0._blockMO
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._blockMO = slot1

	slot0:_refreshBlock(slot1 and slot1.id, slot0._blockMO and slot0._blockMO.id)

	slot4 = slot0._blockMO and slot0._blockMO.packageId == RoomBlockPackageEnum.ID.RoleBirthday

	gohelper.setActive(slot0._gobirthicon, slot4)

	if slot4 then
		slot0:_refreshCharacter(slot3)
	end
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot1)
end

function slot0.onDestroyView(slot0)
	if slot0._blockMO then
		slot0._scene.inventorymgr:removeBlockEntity(slot0._blockMO.id)
	end

	if slot0._rawImageIcon then
		slot0._rawImageIcon.texture = nil
	end

	slot0._simagebirthhero:UnLoadImage()
end

function slot0._refreshCharacter(slot0, slot1)
	if not RoomConfig.instance:getSpecialBlockConfig(slot1) then
		return
	end

	gohelper.setActive(slot0._goonbirthdayicon, RoomCharacterModel.instance:isOnBirthday(slot2.heroId))

	if not slot0:_findSkinIdByHeroId(slot2.heroId) then
		return
	end

	slot0._simagebirthhero:LoadImage(ResUrl.getHeadIconSmall(SkinConfig.instance:getSkinCo(slot4).headIcon))
end

function slot0._findSkinIdByHeroId(slot0, slot1)
	if RoomCharacterModel.instance:getCharacterMOById(slot1) then
		return slot2.skinId
	end

	return HeroConfig.instance:getHeroCO(slot1) and slot3.skinId or nil
end

return slot0
