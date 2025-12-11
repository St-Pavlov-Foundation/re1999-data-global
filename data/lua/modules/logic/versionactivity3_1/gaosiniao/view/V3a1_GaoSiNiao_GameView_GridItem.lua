module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_GameView_GridItem", package.seeall)

local var_0_0 = class("V3a1_GaoSiNiao_GameView_GridItem", V3a1_GaoSiNiao_GameViewDragItemBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goStartIcon = gohelper.findChild(arg_1_0.viewGO, "#go_StartIcon")

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

function var_0_0.ctor(arg_4_0, arg_4_1)
	var_0_0.super.ctor(arg_4_0, arg_4_1)

	arg_4_0._mo = {}
end

function var_0_0.addEventListeners(arg_5_0)
	var_0_0.super.addEventListeners(arg_5_0)
end

function var_0_0.removeEventListeners(arg_6_0)
	var_0_0.super.removeEventListeners(arg_6_0)
end

function var_0_0.onDestroyView(arg_7_0)
	var_0_0.super.onDestroyView(arg_7_0)
end

function var_0_0._editableInitView_Empty(arg_8_0)
	local var_8_0 = arg_8_0.viewGO
	local var_8_1 = arg_8_0:newObject(V3a1_GaoSiNiao_GameView_GridItem_Empty)

	var_8_1:init(var_8_0)

	arg_8_0._empty = var_8_1
end

function var_0_0._editableInitView_Path(arg_9_0)
	local var_9_0 = gohelper.findChild(arg_9_0.viewGO, "blood")
	local var_9_1 = arg_9_0:newObject(V3a1_GaoSiNiao_GameView_GridItem_Path)

	var_9_1:init(var_9_0)

	arg_9_0._path = var_9_1
end

function var_0_0._editableInitView_Wall(arg_10_0)
	local var_10_0 = gohelper.findChild(arg_10_0.viewGO, "blood_qiang")
	local var_10_1 = arg_10_0:newObject(V3a1_GaoSiNiao_GameView_GridItem_Wall)

	var_10_1:init(var_10_0)

	arg_10_0._wall = var_10_1
end

function var_0_0._editableInitView_Start(arg_11_0)
	local var_11_0 = gohelper.findChild(arg_11_0.viewGO, "blood_start")
	local var_11_1 = arg_11_0:newObject(V3a1_GaoSiNiao_GameView_GridItem_Start)

	var_11_1:init(var_11_0)

	arg_11_0._start = var_11_1
end

function var_0_0._editableInitView_End(arg_12_0)
	local var_12_0 = gohelper.findChild(arg_12_0.viewGO, "blood_end")
	local var_12_1 = arg_12_0:newObject(V3a1_GaoSiNiao_GameView_GridItem_End)

	var_12_1:init(var_12_0)

	arg_12_0._end = var_12_1
end

function var_0_0._editableInitView_Portal(arg_13_0)
	local var_13_0 = gohelper.findChild(arg_13_0.viewGO, "blood_chuansongmen")
	local var_13_1 = arg_13_0:newObject(V3a1_GaoSiNiao_GameView_GridItem_Portal)

	var_13_1:init(var_13_0)

	arg_13_0._portal = var_13_1
end

function var_0_0._editableInitView_Pieces(arg_14_0)
	arg_14_0:_editableInitView_Empty()
	arg_14_0:_editableInitView_Path()
	arg_14_0:_editableInitView_Wall()
	arg_14_0:_editableInitView_Start()
	arg_14_0:_editableInitView_End()
	arg_14_0:_editableInitView_Portal()
end

function var_0_0._editableInitView(arg_15_0)
	var_0_0.super._editableInitView(arg_15_0)
	arg_15_0:_editableInitView_Pieces()

	arg_15_0._goClickArea = gohelper.findChild(arg_15_0.viewGO, "#go_ClickArea")
	arg_15_0._goShadow = gohelper.findChild(arg_15_0.viewGO, "#go_Shadow")
	arg_15_0._vx_put = gohelper.findChild(arg_15_0.viewGO, "vx_put")
	arg_15_0._vx_finish = gohelper.findChild(arg_15_0.viewGO, "vx_finish")
	arg_15_0._vx_light = gohelper.findChild(arg_15_0.viewGO, "vx_light")
	arg_15_0._vx_putAnimator = arg_15_0._vx_put:GetComponent(gohelper.Type_Animator)

	arg_15_0:_setActive_goStartIcon(false)
	arg_15_0:_setActive_goShadow(false)
	arg_15_0:_setActive_vx_light(false)
	arg_15_0:_setActive_vx_finish(false)
	arg_15_0:_setActive_vx_put(false)
	arg_15_0:initDragObj(arg_15_0._goClickArea)
end

function var_0_0._isPortal(arg_16_0)
	return arg_16_0._mo:isPortal()
end

function var_0_0._isFixedPath(arg_17_0)
	return arg_17_0._mo:isFixedPath()
end

function var_0_0._isConnedStart(arg_18_0)
	return arg_18_0._mo:_isConnedStart()
end

function var_0_0._whoActivedPortalGrid(arg_19_0)
	return arg_19_0._mo:_whoActivedPortalGrid()
end

function var_0_0.setData(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:getType()

	var_0_0.super.setData(arg_20_0, arg_20_1)

	local var_20_1 = arg_20_0:getType()

	if var_20_0 ~= var_20_1 then
		arg_20_0:_switchType(var_20_1)
	end

	arg_20_0:_refreshSprite()
end

function var_0_0._switchType(arg_21_0, arg_21_1)
	if arg_21_0._impl then
		arg_21_0._impl:setActive(false)
	end

	if arg_21_1 == GaoSiNiaoEnum.GridType.Path then
		arg_21_0._path:setIsFixedPath(true)
	else
		arg_21_0._path:setIsFixedPath(false)
	end

	if arg_21_1 == GaoSiNiaoEnum.GridType.Empty then
		arg_21_0:asEmpty()
	elseif arg_21_1 == GaoSiNiaoEnum.GridType.Wall then
		arg_21_0:asWall()
	elseif arg_21_1 == GaoSiNiaoEnum.GridType.Portal then
		arg_21_0:asPortal()
	elseif arg_21_1 == GaoSiNiaoEnum.GridType.End then
		arg_21_0:asEnd()
	elseif arg_21_1 == GaoSiNiaoEnum.GridType.Start then
		arg_21_0:asStart()
	elseif arg_21_1 == GaoSiNiaoEnum.GridType.Path then
		arg_21_0:asFixedPath()
	else
		assert(false, "unsupported eGridType:" .. tostring(arg_21_1))
	end

	if arg_21_0._impl then
		arg_21_0._impl:setActive(true)
	end
end

function var_0_0._hideOtherPiece(arg_22_0)
	if arg_22_0._impl ~= arg_22_0._portal then
		arg_22_0._portal:setActive(false)
	end

	if arg_22_0._impl ~= arg_22_0._start then
		arg_22_0._start:setActive(false)
	end

	if arg_22_0._impl ~= arg_22_0._end then
		arg_22_0._end:setActive(false)
	end

	if arg_22_0._impl ~= arg_22_0._wall then
		arg_22_0._wall:setActive(false)
	end

	if arg_22_0._impl ~= arg_22_0._path then
		arg_22_0._path:setActive(false)
	end

	if arg_22_0._impl ~= arg_22_0._empty then
		arg_22_0._empty:setActive(false)
	end
end

function var_0_0.asEmpty(arg_23_0)
	arg_23_0._impl = arg_23_0._empty

	arg_23_0:_hideOtherPiece()
end

function var_0_0.asWall(arg_24_0)
	arg_24_0._impl = arg_24_0._wall

	arg_24_0:_hideOtherPiece()
end

function var_0_0.asPortal(arg_25_0)
	arg_25_0._impl = arg_25_0._portal

	arg_25_0:_hideOtherPiece()
end

function var_0_0.asStart(arg_26_0)
	arg_26_0._impl = arg_26_0._start

	arg_26_0:_hideOtherPiece()
end

function var_0_0.asEnd(arg_27_0)
	arg_27_0._impl = arg_27_0._end

	arg_27_0:_hideOtherPiece()
end

function var_0_0.asFixedPath(arg_28_0)
	arg_28_0._impl = arg_28_0._path

	arg_28_0:_hideOtherPiece()
	arg_28_0._path:selectPathType(arg_28_0._mo.ePathType)
end

function var_0_0._refreshSprite(arg_29_0)
	local var_29_0 = arg_29_0:_placedBagItemObj()
	local var_29_1 = arg_29_0:_isConnedStart()
	local var_29_2 = arg_29_0:isCompleted()
	local var_29_3 = arg_29_0._mo
	local var_29_4 = var_29_3.type
	local var_29_5 = var_29_3.zRot
	local var_29_6 = var_29_3.ePathType

	arg_29_0:_setActive_goShadow(false)
	arg_29_0:_setActive_goStartIcon(var_29_4 == GaoSiNiaoEnum.GridType.Start)

	local var_29_7 = not var_29_2 and true or false

	if var_29_1 then
		arg_29_0._impl:setGray_Blood(var_29_7)
	else
		arg_29_0._impl:hideBlood()
	end

	if arg_29_0._impl ~= arg_29_0._path then
		arg_29_0._path:setActive(false)
		arg_29_0._path:hideBlood()
	end

	if var_29_0 then
		local var_29_8, var_29_9 = var_29_0:getDraggingSpriteAndZRot()

		arg_29_0._path:localRotateZ(var_29_9)
		arg_29_0._path:selectPathType(var_29_0:getType())
		arg_29_0._path:setActive(true)

		if var_29_1 then
			arg_29_0._path:setGray_Blood(var_29_7)
		end

		arg_29_0:_setActive_goShadow(true)
	elseif arg_29_0:_isPortal() then
		if var_29_2 then
			if var_29_1 then
				arg_29_0._portal:setIsConnectedNoAnim(var_29_1)
				arg_29_0._portal:setGray_Blood(var_29_7)
			end
		else
			arg_29_0._portal:setIsConnected(var_29_1)

			if var_29_1 then
				arg_29_0:_rotateActivedPortal()
			else
				arg_29_0._portal:resetRotate()
			end
		end
	elseif var_29_4 ~= GaoSiNiaoEnum.GridType.Path then
		arg_29_0._impl:localRotateZ(var_29_5)
	end
end

function var_0_0.getType(arg_30_0)
	return arg_30_0._mo.type or GaoSiNiaoEnum.GridType.None
end

function var_0_0.isSelectable(arg_31_0)
	return arg_31_0._mo:isEmpty() or arg_31_0:isDraggable()
end

function var_0_0.onSelect(arg_32_0, arg_32_1)
	arg_32_0._staticData.isSelected = arg_32_1

	arg_32_0:onShowSelected(arg_32_1)
end

function var_0_0.onShowSelected(arg_33_0, arg_33_1)
	arg_33_0:_setActive_vx_light(arg_33_1)
end

function var_0_0.onCompleteGame(arg_34_0)
	local var_34_0 = arg_34_0:_isConnedStart()

	arg_34_0:_setActive_vx_finish(var_34_0)

	if var_34_0 then
		arg_34_0._impl:setGray_Blood(false)
		arg_34_0._path:setGray_Blood(false)
	end
end

function var_0_0.onPushBagToGrid(arg_35_0)
	AudioMgr.instance:trigger(AudioEnum3_1.GaoSiNiao.play_ui_mingdi_gsn_fang)
	arg_35_0:_setActive_vx_put(true)
	arg_35_0._vx_putAnimator:Play("gameview_put", -1, 0)
end

function var_0_0._onBeginDrag(arg_36_0, arg_36_1)
	arg_36_0:parent():onBeginDrag_GridItemObj(arg_36_0, arg_36_1)
end

function var_0_0._onDragging(arg_37_0, arg_37_1)
	arg_37_0:parent():onDragging_GridItemObj(arg_37_0, arg_37_1)
end

function var_0_0._onEndDrag(arg_38_0, arg_38_1)
	arg_38_0:parent():onEndDrag_GridItemObj(arg_38_0, arg_38_1)
end

function var_0_0._placedBagItemObj(arg_39_0)
	return arg_39_0:_dragContext():getPlacedBagItemObj(arg_39_0)
end

function var_0_0._placedBagItemObjSprite(arg_40_0)
	local var_40_0 = arg_40_0:_placedBagItemObj()

	if var_40_0 then
		return var_40_0:getDraggingSpriteAndZRot()
	end

	return nil
end

function var_0_0.getDraggingSpriteAndZRot(arg_41_0)
	local var_41_0, var_41_1 = arg_41_0:_placedBagItemObjSprite()

	return var_41_0 or arg_41_0._impl:getPieceSprite(), var_41_1 or 0
end

function var_0_0.isDraggable(arg_42_0)
	if arg_42_0:_placedBagItemObj() then
		return true
	end

	return arg_42_0._mo.bMovable
end

function var_0_0._rotateActivedPortal(arg_43_0)
	local var_43_0 = arg_43_0:_whoActivedPortalGrid():getNeighborWalkableGridList()
	local var_43_1 = GaoSiNiaoEnum.ZoneMask.None

	for iter_43_0, iter_43_1 in ipairs(var_43_0) do
		if iter_43_1 then
			if iter_43_1 == arg_43_0._mo then
				var_43_1 = GaoSiNiaoEnum.flipDir(GaoSiNiaoEnum.bitPos2Dir(iter_43_0 - 1))

				break
			end

			if iter_43_1:isPortal() then
				var_43_1 = GaoSiNiaoEnum.bitPos2Dir(iter_43_0 - 1)
			end
		end
	end

	arg_43_0._portal:rotateByZoneMask(var_43_1)
end

function var_0_0._setActive_goShadow(arg_44_0, arg_44_1)
	gohelper.setActive(arg_44_0._goShadow, arg_44_1)
end

function var_0_0._setActive_vx_light(arg_45_0, arg_45_1)
	gohelper.setActive(arg_45_0._vx_light, arg_45_1)
end

function var_0_0._setActive_vx_finish(arg_46_0, arg_46_1)
	gohelper.setActive(arg_46_0._vx_finish, arg_46_1)
end

function var_0_0._setActive_vx_put(arg_47_0, arg_47_1)
	gohelper.setActive(arg_47_0._vx_put, arg_47_1)
end

function var_0_0._setActive_goStartIcon(arg_48_0, arg_48_1)
	gohelper.setActive(arg_48_0._goStartIcon, arg_48_1)
end

return var_0_0
