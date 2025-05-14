module("modules.logic.room.view.RoomCharacterPlaceItem", package.seeall)

local var_0_0 = class("RoomCharacterPlaceItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "role/heroicon")
	arg_1_0._gobeplaced = gohelper.findChild(arg_1_0.viewGO, "placeicon")
	arg_1_0._goclick = gohelper.findChild(arg_1_0.viewGO, "go_click")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "select")
	arg_1_0._gotrust = gohelper.findChild(arg_1_0.viewGO, "trust")
	arg_1_0._txttrust = gohelper.findChildText(arg_1_0.viewGO, "trust/txt_trust")
	arg_1_0._goonbirthdayicon = gohelper.findChild(arg_1_0.viewGO, "#go_onbirthdayicon")
	arg_1_0._gorole = gohelper.findChild(arg_1_0.viewGO, "role")
	arg_1_0._imagecareer = gohelper.findChildImage(arg_1_0.viewGO, "role/career")
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0.viewGO, "role/rare")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "role/name")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "role/name/nameEn")

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

function var_0_0._btnclickOnClick(arg_4_0)
	if arg_4_0._scene.camera:isTweening() then
		return
	end

	if arg_4_0._isDragUI then
		return
	end

	local var_4_0 = arg_4_0._mo.heroId
	local var_4_1 = arg_4_0._mo.skinId

	if RoomHelper.isFSMState(RoomEnum.FSMObState.Idle) or RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceCharacterConfirm) then
		RoomCharacterModel.instance:endAllMove()

		local var_4_2 = RoomCharacterModel.instance:getTempCharacterMO()

		if var_4_2 and var_4_2.id == var_4_0 then
			RoomCharacterPlaceListModel.instance:setSelect(arg_4_0._mo.id)
			arg_4_0._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceCharacter, {
				focus = true,
				heroId = var_4_0
			})

			return
		end

		if arg_4_0._mo.use then
			RoomCharacterPlaceListModel.instance:setSelect(arg_4_0._mo.id)

			local var_4_3 = RoomCharacterModel.instance:getCharacterMOById(var_4_0)

			arg_4_0._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceCharacter, {
				heroId = var_4_0
			})
		else
			local function var_4_4(arg_5_0, arg_5_1, arg_5_2)
				local var_5_0 = RoomCharacterHelper.getRecommendHexPoint(arg_5_0, arg_5_1, arg_5_2)

				if not var_5_0 then
					GameFacade.showToast(ToastEnum.RoomCharacterPlace)

					return
				end

				RoomCharacterPlaceListModel.instance:setSelect(nil)
				RoomCharacterPlaceListModel.instance:setSelect(arg_5_0)
				arg_4_0._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceCharacter, {
					heroId = arg_5_0,
					skinId = arg_5_1,
					position = var_5_0.position
				})
			end

			local var_4_5 = RoomCharacterModel.instance:getConfirmCharacterCount()
			local var_4_6 = RoomCharacterModel.instance:getMaxCharacterCount()

			if var_4_2 then
				if var_4_6 <= var_4_5 - 1 then
					GameFacade.showToast(ToastEnum.RoomCharacterPlace2)

					return
				end

				local var_4_7 = Vector2(var_4_2.currentPosition.x, var_4_2.currentPosition.z)

				if var_4_2.characterState == RoomCharacterEnum.CharacterState.Revert then
					RoomMapController.instance:unUseCharacterRequest(var_4_2.heroId, function()
						var_4_4(var_4_0, var_4_1, var_4_7)
					end)
				else
					var_4_4(var_4_0, var_4_1, var_4_7)
				end

				return
			end

			if var_4_6 <= var_4_5 then
				GameFacade.showToast(ToastEnum.RoomCharacterPlace2)

				return
			end

			var_4_4(var_4_0, var_4_1, nil)
		end
	end
end

function var_0_0._onDragBegin(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._isDragUI = true
	arg_7_0._isDragFirstBegin = true

	RoomCharacterController.instance:dispatchEvent(RoomEvent.CharacterListOnDragBeginListener, arg_7_2)
end

function var_0_0._onDrag(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._isDragUI = true

	if arg_8_0._isStartDrag then
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressCharacter, arg_8_2.position)
	elseif arg_8_2.position.y > arg_8_0._dragStartY and arg_8_0._isDragFirstBegin then
		local var_8_0 = arg_8_0._mo.id
		local var_8_1 = RoomCharacterModel.instance:getTempCharacterMO()
		local var_8_2 = RoomCharacterModel.instance:getConfirmCharacterCount()
		local var_8_3 = RoomCharacterModel.instance:getMaxCharacterCount()

		if not arg_8_0._mo.use and (not var_8_1 or var_8_1.id ~= var_8_0) and var_8_3 <= var_8_2 then
			GameFacade.showToast(ToastEnum.RoomCharacterPlace2)

			arg_8_0._isDragFirstBegin = false
		else
			arg_8_0._isStartDrag = true

			arg_8_0._scene.touch:setUIDragScreenScroll(true)

			local var_8_4 = arg_8_0._mo.skinId
			local var_8_5 = RoomBendingHelper.screenToWorld(arg_8_2.position)
			local var_8_6 = RoomCharacterHelper.getRecommendHexPoint(var_8_0, var_8_4, var_8_5)

			if var_8_6 then
				arg_8_0._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceCharacter, {
					uidrag = true,
					heroId = var_8_0,
					skinId = var_8_4,
					position = var_8_6.position
				})
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressCharacter, arg_8_2.position, var_8_0)
			else
				GameFacade.showToast(ToastEnum.RoomCharacterPlace)

				arg_8_0._isDragFirstBegin = false
			end
		end
	end

	if not arg_8_0._isStartDrag then
		RoomCharacterController.instance:dispatchEvent(RoomEvent.CharacterListOnDragListener, arg_8_2)
	end
end

function var_0_0._onDragEnd(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._isDragUI = false

	if arg_9_0._isStartDrag then
		arg_9_0._isStartDrag = false

		arg_9_0._scene.touch:setUIDragScreenScroll(false)
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchDropCharacter, arg_9_2.position)
	end

	RoomCharacterController.instance:dispatchEvent(RoomEvent.CharacterListOnDragEndListener, arg_9_2)
end

function var_0_0._btnclickOnClickDown(arg_10_0)
	arg_10_0._isDragUI = false
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0._scene = GameSceneMgr.instance:getCurScene()
	arg_11_0._isSelect = false

	gohelper.addUIClickAudio(arg_11_0._goclick, AudioEnum.UI.UI_Common_Click)

	arg_11_0._canvasGroup = arg_11_0._gorole:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_11_0._uiclick = SLFramework.UGUI.UIClickListener.Get(arg_11_0._goclick)

	arg_11_0._uiclick:AddClickListener(arg_11_0._btnclickOnClick, arg_11_0)
	arg_11_0._uiclick:AddClickDownListener(arg_11_0._btnclickOnClickDown, arg_11_0)

	arg_11_0._uidrag = SLFramework.UGUI.UIDragListener.Get(arg_11_0._goclick)

	arg_11_0._uidrag:AddDragBeginListener(arg_11_0._onDragBegin, arg_11_0)
	arg_11_0._uidrag:AddDragListener(arg_11_0._onDrag, arg_11_0)
	arg_11_0._uidrag:AddDragEndListener(arg_11_0._onDragEnd, arg_11_0)

	arg_11_0._isStartDrag = false
	arg_11_0._isDragFirstBegin = false
	arg_11_0._isDragUI = false
	arg_11_0._dragStartY = 350 * UnityEngine.Screen.height / 1080
end

function var_0_0._refreshUI(arg_12_0)
	arg_12_0._simageicon:LoadImage(ResUrl.getRoomHeadIcon(arg_12_0._mo.skinConfig.headIcon))
	gohelper.setActive(arg_12_0._gobeplaced, arg_12_0._mo.use)

	local var_12_0 = RoomCharacterModel.instance:isOnBirthday(arg_12_0._mo.heroConfig.id)

	gohelper.setActive(arg_12_0._goonbirthdayicon, var_12_0)

	if arg_12_0._mo.use then
		arg_12_0._canvasGroup.alpha = 0.7
	else
		arg_12_0._canvasGroup.alpha = 1
	end

	gohelper.addUIClickAudio(arg_12_0._goclick, arg_12_0._mo.use and AudioEnum.UI.UI_Common_Click or AudioEnum.UI.Play_UI_Copies)
	UISpriteSetMgr.instance:setCommonSprite(arg_12_0._imagecareer, "lssx_" .. arg_12_0._mo.heroConfig.career)
	UISpriteSetMgr.instance:setCommonSprite(arg_12_0._imagerare, "bgequip" .. CharacterEnum.Color[arg_12_0._mo.heroConfig.rare])

	arg_12_0._txtname.text = arg_12_0._mo.heroConfig.name
	arg_12_0._txtnameen.text = arg_12_0._mo.heroConfig.nameEng

	local var_12_1 = RoomCharacterPlaceListModel.instance:getOrder()
	local var_12_2

	var_12_2 = var_12_1 == RoomCharacterEnum.CharacterOrderType.FaithUp or var_12_1 == RoomCharacterEnum.CharacterOrderType.FaithDown

	local var_12_3 = HeroConfig.instance:getFaithPercent(arg_12_0._mo.heroMO.faith)[1]
	local var_12_4 = var_12_3 ~= 1 and "#cccccc" or "#e59650"

	arg_12_0._txttrust.text = string.format("<color=%s>%s%%</color>", var_12_4, var_12_3 * 100)
end

function var_0_0.onUpdateMO(arg_13_0, arg_13_1)
	gohelper.setActive(arg_13_0._goselect, arg_13_0._isSelect)

	arg_13_0._mo = arg_13_1

	arg_13_0:_refreshUI()

	arg_13_0._uidrag.enabled = RoomCharacterModel.instance:canDragCharacter()
end

function var_0_0.onSelect(arg_14_0, arg_14_1)
	gohelper.setActive(arg_14_0._goselect, arg_14_1)

	arg_14_0._isSelect = arg_14_1
end

function var_0_0.onDestroy(arg_15_0)
	arg_15_0._simageicon:UnLoadImage()
	arg_15_0._uiclick:RemoveClickListener()
	arg_15_0._uiclick:RemoveClickDownListener()
	arg_15_0._uidrag:RemoveDragBeginListener()
	arg_15_0._uidrag:RemoveDragListener()
	arg_15_0._uidrag:RemoveDragEndListener()
end

return var_0_0
