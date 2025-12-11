module("modules.logic.room.view.RoomInventorySelectItem", package.seeall)

local var_0_0 = class("RoomInventorySelectItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnItem:AddClickListener(arg_2_0._onBtnItemClick, arg_2_0)
	arg_2_0:addEventCb(RoomWaterReformController.instance, RoomEvent.OnGetBlockReformPermanentInfo, arg_2_0._onGetReformPermanentInfo, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnItem:RemoveClickListener()
	arg_3_0:removeEventCb(RoomWaterReformController.instance, RoomEvent.OnGetBlockReformPermanentInfo, arg_3_0._onGetReformPermanentInfo, arg_3_0)
end

function var_0_0._editableAddEvents(arg_4_0)
	RoomMapController.instance:registerCallback(RoomEvent.BackBlockListDataChanged, arg_4_0._onBackBlockChanged, arg_4_0)
	RoomMapController.instance:registerCallback(RoomEvent.BackBlockPlayUIAnim, arg_4_0._onPlayAnim, arg_4_0)
end

function var_0_0._editableRemoveEvents(arg_5_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.BackBlockListDataChanged, arg_5_0._onBackBlockChanged, arg_5_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.BackBlockPlayUIAnim, arg_5_0._onPlayAnim, arg_5_0)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._rtIndex = OrthCameraRTMgr.instance:getNewIndex()
	arg_6_0._goselect = gohelper.findChild(arg_6_0.viewGO, "go_select")
	arg_6_0._goempty = gohelper.findChild(arg_6_0.viewGO, "go_empty")
	arg_6_0._goicon = gohelper.findChild(arg_6_0.viewGO, "go_icon")
	arg_6_0._gobirthicon = gohelper.findChild(arg_6_0.viewGO, "go_birthicon")
	arg_6_0._simagebirthhero = gohelper.findChildSingleImage(arg_6_0.viewGO, "go_birthicon/simage_birthhero")
	arg_6_0._goonbirthdayicon = gohelper.findChild(arg_6_0.viewGO, "go_birthicon/#image_onbirthday")
	arg_6_0._animator = arg_6_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_6_0._btnItem = gohelper.findChildButtonWithAudio(arg_6_0.viewGO, "go_icon")
	arg_6_0._rawImageIcon = gohelper.onceAddComponent(arg_6_0._goicon, gohelper.Type_RawImage)

	OrthCameraRTMgr.instance:setRawImageUvRect(arg_6_0._rawImageIcon, arg_6_0._rtIndex)

	local var_6_0 = "#BFB5A3"

	SLFramework.UGUI.GuiHelper.SetColor(arg_6_0._rawImageIcon, var_6_0)

	arg_6_0._scene = GameSceneMgr.instance:getCurScene()

	gohelper.setActive(arg_6_0._goempty, false)

	arg_6_0._backBlockIds = {}
end

function var_0_0._onBackBlockChanged(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_2 then
		if arg_7_0:_IsShow() then
			arg_7_0:_playBackBlockAnim(arg_7_1, false, arg_7_4)
		else
			tabletool.addValues(arg_7_0._backBlockIds, arg_7_1)
		end
	end
end

function var_0_0._onPlayAnim(arg_8_0)
	if arg_8_0:_IsShow() and #arg_8_0._backBlockIds > 0 then
		local var_8_0 = arg_8_0._backBlockIds

		arg_8_0._backBlockIds = {}

		arg_8_0:_playBackBlockAnim(var_8_0, true)
	end
end

function var_0_0._playBackBlockAnim(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_1 = arg_9_1 or {}

	local var_9_0 = arg_9_0._blockMO and tabletool.indexOf(arg_9_1, arg_9_0._blockMO.id)
	local var_9_1

	if arg_9_2 then
		if var_9_0 then
			var_9_1 = "dikuai03"
		end
	elseif var_9_0 then
		var_9_1 = "dikuai01"
	else
		local var_9_2 = true

		if arg_9_3 and arg_9_0._index then
			var_9_2 = arg_9_3 < arg_9_0._index
		end

		if var_9_2 then
			var_9_1 = "dikuai02"
		end
	end

	if not var_9_1 then
		return
	end

	arg_9_0._animator:Play(var_9_1, 0, 0)
end

function var_0_0._IsShow(arg_10_0)
	if RoomMapBlockModel.instance:isBackMore() or RoomBuildingController.instance:isBuildingListShow() then
		return false
	end

	return true
end

function var_0_0._onBtnItemClick(arg_11_0)
	if not arg_11_0._blockMO then
		return
	end

	local var_11_0 = arg_11_0._blockMO
	local var_11_1 = arg_11_0._blockMO.id

	RoomShowBlockListModel.instance:setSelect(var_11_1)

	local var_11_2 = arg_11_0._scene
	local var_11_3 = var_11_2.fsm:getCurStateName()

	if RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceConfirm) then
		local var_11_4 = RoomMapBlockModel.instance:getTempBlockMO()
		local var_11_5 = HexMath.hexToPosition(var_11_4.hexPoint, RoomBlockEnum.BlockSize)

		if var_11_4.id == var_11_1 then
			if RoomHelper.isOutCameraFocusCenter(var_11_5) then
				if not var_11_2.camera:isTweening() then
					var_11_2.camera:tweenCamera({
						focusX = var_11_5.x,
						focusY = var_11_5.y
					})
				end
			else
				GameFacade.showToast(ToastEnum.RoomInventorySelect)
			end
		else
			var_11_2.fsm:triggerEvent(RoomSceneEvent.TryPlaceBlock, {
				hexPoint = var_11_4.hexPoint
			})
		end
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.SelectBlock)
end

function var_0_0._onGetReformPermanentInfo(arg_12_0)
	local var_12_0 = arg_12_0:getBlockMO()

	if not var_12_0 then
		return
	end

	local var_12_1 = arg_12_0._scene.inventorymgr:getBlockEntity(var_12_0.id, SceneTag.RoomInventoryBlock)

	RoomBlockHelper.refreshBlockEntity({
		var_12_1
	}, "refreshBlock")
end

function var_0_0._refreshBlock(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2 then
		arg_13_0._scene.inventorymgr:removeBlockEntity(arg_13_2)
	end

	if arg_13_1 then
		arg_13_0._scene.inventorymgr:addBlockEntity(arg_13_1)

		local var_13_0 = arg_13_0._scene.inventorymgr:getIndexById(arg_13_1)

		OrthCameraRTMgr.instance:setRawImageUvRect(arg_13_0._rawImageIcon, var_13_0)
	end
end

function var_0_0.getBlockMO(arg_14_0)
	return arg_14_0._blockMO
end

function var_0_0.onUpdateMO(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._blockMO and arg_15_0._blockMO.id
	local var_15_1 = arg_15_1 and arg_15_1.id

	arg_15_0._blockMO = arg_15_1

	arg_15_0:_refreshBlock(var_15_1, var_15_0)

	local var_15_2 = arg_15_0._blockMO and arg_15_0._blockMO.packageId == RoomBlockPackageEnum.ID.RoleBirthday

	gohelper.setActive(arg_15_0._gobirthicon, var_15_2)

	if var_15_2 then
		arg_15_0:_refreshCharacter(var_15_1)
	end

	RoomMapController.instance:getNextBlockReformPermanentInfo(arg_15_0._index)
end

function var_0_0.onSelect(arg_16_0, arg_16_1)
	gohelper.setActive(arg_16_0._goselect, arg_16_1)
end

function var_0_0.onDestroyView(arg_17_0)
	if arg_17_0._blockMO then
		arg_17_0._scene.inventorymgr:removeBlockEntity(arg_17_0._blockMO.id)
	end

	if arg_17_0._rawImageIcon then
		arg_17_0._rawImageIcon.texture = nil
	end

	arg_17_0._simagebirthhero:UnLoadImage()
end

function var_0_0._refreshCharacter(arg_18_0, arg_18_1)
	local var_18_0 = RoomConfig.instance:getSpecialBlockConfig(arg_18_1)

	if not var_18_0 then
		return
	end

	local var_18_1 = RoomCharacterModel.instance:isOnBirthday(var_18_0.heroId)

	gohelper.setActive(arg_18_0._goonbirthdayicon, var_18_1)

	local var_18_2 = arg_18_0:_findSkinIdByHeroId(var_18_0.heroId)

	if not var_18_2 then
		return
	end

	local var_18_3 = SkinConfig.instance:getSkinCo(var_18_2)

	arg_18_0._simagebirthhero:LoadImage(ResUrl.getHeadIconSmall(var_18_3.headIcon))
end

function var_0_0._findSkinIdByHeroId(arg_19_0, arg_19_1)
	local var_19_0 = RoomCharacterModel.instance:getCharacterMOById(arg_19_1)

	if var_19_0 then
		return var_19_0.skinId
	end

	local var_19_1 = HeroConfig.instance:getHeroCO(arg_19_1)

	return var_19_1 and var_19_1.skinId or nil
end

return var_0_0
