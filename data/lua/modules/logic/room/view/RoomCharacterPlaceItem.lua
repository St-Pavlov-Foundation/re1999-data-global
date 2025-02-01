module("modules.logic.room.view.RoomCharacterPlaceItem", package.seeall)

slot0 = class("RoomCharacterPlaceItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "role/heroicon")
	slot0._gobeplaced = gohelper.findChild(slot0.viewGO, "placeicon")
	slot0._goclick = gohelper.findChild(slot0.viewGO, "go_click")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "select")
	slot0._gotrust = gohelper.findChild(slot0.viewGO, "trust")
	slot0._txttrust = gohelper.findChildText(slot0.viewGO, "trust/txt_trust")
	slot0._goonbirthdayicon = gohelper.findChild(slot0.viewGO, "#go_onbirthdayicon")
	slot0._gorole = gohelper.findChild(slot0.viewGO, "role")
	slot0._imagecareer = gohelper.findChildImage(slot0.viewGO, "role/career")
	slot0._imagerare = gohelper.findChildImage(slot0.viewGO, "role/rare")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "role/name")
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, "role/name/nameEn")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._btnclickOnClick(slot0)
	if slot0._scene.camera:isTweening() then
		return
	end

	if slot0._isDragUI then
		return
	end

	slot1 = slot0._mo.heroId
	slot2 = slot0._mo.skinId

	if RoomHelper.isFSMState(RoomEnum.FSMObState.Idle) or RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceCharacterConfirm) then
		RoomCharacterModel.instance:endAllMove()

		if RoomCharacterModel.instance:getTempCharacterMO() and slot3.id == slot1 then
			RoomCharacterPlaceListModel.instance:setSelect(slot0._mo.id)
			slot0._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceCharacter, {
				focus = true,
				heroId = slot1
			})

			return
		end

		if slot0._mo.use then
			RoomCharacterPlaceListModel.instance:setSelect(slot0._mo.id)

			slot4 = RoomCharacterModel.instance:getCharacterMOById(slot1)

			slot0._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceCharacter, {
				heroId = slot1
			})
		else
			function slot4(slot0, slot1, slot2)
				if not RoomCharacterHelper.getRecommendHexPoint(slot0, slot1, slot2) then
					GameFacade.showToast(ToastEnum.RoomCharacterPlace)

					return
				end

				RoomCharacterPlaceListModel.instance:setSelect(nil)
				RoomCharacterPlaceListModel.instance:setSelect(slot0)
				uv0._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceCharacter, {
					heroId = slot0,
					skinId = slot1,
					position = slot3.position
				})
			end

			slot5 = RoomCharacterModel.instance:getConfirmCharacterCount()
			slot6 = RoomCharacterModel.instance:getMaxCharacterCount()

			if slot3 then
				if slot6 <= slot5 - 1 then
					GameFacade.showToast(ToastEnum.RoomCharacterPlace2)

					return
				end

				slot7 = Vector2(slot3.currentPosition.x, slot3.currentPosition.z)

				if slot3.characterState == RoomCharacterEnum.CharacterState.Revert then
					RoomMapController.instance:unUseCharacterRequest(slot3.heroId, function ()
						uv0(uv1, uv2, uv3)
					end)
				else
					slot4(slot1, slot2, slot7)
				end

				return
			end

			if slot6 <= slot5 then
				GameFacade.showToast(ToastEnum.RoomCharacterPlace2)

				return
			end

			slot4(slot1, slot2, nil)
		end
	end
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot0._isDragUI = true
	slot0._isDragFirstBegin = true

	RoomCharacterController.instance:dispatchEvent(RoomEvent.CharacterListOnDragBeginListener, slot2)
end

function slot0._onDrag(slot0, slot1, slot2)
	slot0._isDragUI = true

	if slot0._isStartDrag then
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressCharacter, slot2.position)
	elseif slot0._dragStartY < slot2.position.y and slot0._isDragFirstBegin then
		slot4 = RoomCharacterModel.instance:getTempCharacterMO()

		if not slot0._mo.use and (not slot4 or slot4.id ~= slot0._mo.id) and RoomCharacterModel.instance:getMaxCharacterCount() <= RoomCharacterModel.instance:getConfirmCharacterCount() then
			GameFacade.showToast(ToastEnum.RoomCharacterPlace2)

			slot0._isDragFirstBegin = false
		else
			slot0._isStartDrag = true

			slot0._scene.touch:setUIDragScreenScroll(true)

			if RoomCharacterHelper.getRecommendHexPoint(slot3, slot0._mo.skinId, RoomBendingHelper.screenToWorld(slot2.position)) then
				slot0._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceCharacter, {
					uidrag = true,
					heroId = slot3,
					skinId = slot7,
					position = slot9.position
				})
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressCharacter, slot2.position, slot3)
			else
				GameFacade.showToast(ToastEnum.RoomCharacterPlace)

				slot0._isDragFirstBegin = false
			end
		end
	end

	if not slot0._isStartDrag then
		RoomCharacterController.instance:dispatchEvent(RoomEvent.CharacterListOnDragListener, slot2)
	end
end

function slot0._onDragEnd(slot0, slot1, slot2)
	slot0._isDragUI = false

	if slot0._isStartDrag then
		slot0._isStartDrag = false

		slot0._scene.touch:setUIDragScreenScroll(false)
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchDropCharacter, slot2.position)
	end

	RoomCharacterController.instance:dispatchEvent(RoomEvent.CharacterListOnDragEndListener, slot2)
end

function slot0._btnclickOnClickDown(slot0)
	slot0._isDragUI = false
end

function slot0._editableInitView(slot0)
	slot0._scene = GameSceneMgr.instance:getCurScene()
	slot0._isSelect = false

	gohelper.addUIClickAudio(slot0._goclick, AudioEnum.UI.UI_Common_Click)

	slot0._canvasGroup = slot0._gorole:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._uiclick = SLFramework.UGUI.UIClickListener.Get(slot0._goclick)

	slot0._uiclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0._uiclick:AddClickDownListener(slot0._btnclickOnClickDown, slot0)

	slot0._uidrag = SLFramework.UGUI.UIDragListener.Get(slot0._goclick)

	slot0._uidrag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._uidrag:AddDragListener(slot0._onDrag, slot0)
	slot0._uidrag:AddDragEndListener(slot0._onDragEnd, slot0)

	slot0._isStartDrag = false
	slot0._isDragFirstBegin = false
	slot0._isDragUI = false
	slot0._dragStartY = 350 * UnityEngine.Screen.height / 1080
end

function slot0._refreshUI(slot0)
	slot0._simageicon:LoadImage(ResUrl.getRoomHeadIcon(slot0._mo.skinConfig.headIcon))
	gohelper.setActive(slot0._gobeplaced, slot0._mo.use)
	gohelper.setActive(slot0._goonbirthdayicon, RoomCharacterModel.instance:isOnBirthday(slot0._mo.heroConfig.id))

	if slot0._mo.use then
		slot0._canvasGroup.alpha = 0.7
	else
		slot0._canvasGroup.alpha = 1
	end

	gohelper.addUIClickAudio(slot0._goclick, slot0._mo.use and AudioEnum.UI.UI_Common_Click or AudioEnum.UI.Play_UI_Copies)
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareer, "lssx_" .. slot0._mo.heroConfig.career)
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagerare, "bgequip" .. CharacterEnum.Color[slot0._mo.heroConfig.rare])

	slot0._txtname.text = slot0._mo.heroConfig.name
	slot0._txtnameen.text = slot0._mo.heroConfig.nameEng
	slot3 = RoomCharacterPlaceListModel.instance:getOrder() == RoomCharacterEnum.CharacterOrderType.FaithUp or slot2 == RoomCharacterEnum.CharacterOrderType.FaithDown
	slot0._txttrust.text = string.format("<color=%s>%s%%</color>", HeroConfig.instance:getFaithPercent(slot0._mo.heroMO.faith)[1] ~= 1 and "#cccccc" or "#e59650", slot4 * 100)
end

function slot0.onUpdateMO(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot0._isSelect)

	slot0._mo = slot1

	slot0:_refreshUI()

	slot0._uidrag.enabled = RoomCharacterModel.instance:canDragCharacter()
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot1)

	slot0._isSelect = slot1
end

function slot0.onDestroy(slot0)
	slot0._simageicon:UnLoadImage()
	slot0._uiclick:RemoveClickListener()
	slot0._uiclick:RemoveClickDownListener()
	slot0._uidrag:RemoveDragBeginListener()
	slot0._uidrag:RemoveDragListener()
	slot0._uidrag:RemoveDragEndListener()
end

return slot0
