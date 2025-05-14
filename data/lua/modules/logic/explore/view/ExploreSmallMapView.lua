module("modules.logic.explore.view.ExploreSmallMapView", package.seeall)

local var_0_0 = class("ExploreSmallMapView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnsmallmap = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "topright/minimap/#btn_smallmap")
	arg_1_0._keytips = gohelper.findChild(arg_1_0._btnsmallmap.gameObject, "#go_pcbtn1")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	ExploreController.instance:registerCallback(ExploreEvent.HeroTweenDisTr, arg_2_0.applyRolePos, arg_2_0)
	ExploreController.instance:registerCallback(ExploreEvent.OnCharacterPosChange, arg_2_0.applyRolePos, arg_2_0)
	ExploreController.instance:registerCallback(ExploreEvent.AreaShow, arg_2_0._areaShowChange, arg_2_0)
	ExploreController.instance:registerCallback(ExploreEvent.UnitOutlineChange, arg_2_0.outlineChange, arg_2_0)
	ExploreController.instance:registerCallback(ExploreEvent.MapRotate, arg_2_0.applyRolePos, arg_2_0)
	arg_2_0._btnsmallmap:AddClickListener(arg_2_0._openSmallMap, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.HeroTweenDisTr, arg_3_0.applyRolePos, arg_3_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterPosChange, arg_3_0.applyRolePos, arg_3_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.AreaShow, arg_3_0._areaShowChange, arg_3_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.UnitOutlineChange, arg_3_0.outlineChange, arg_3_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.MapRotate, arg_3_0.applyRolePos, arg_3_0)
	arg_3_0._btnsmallmap:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._mapItems = {}
	arg_4_0._mapItemsNoUse = {}

	local var_4_0 = gohelper.findChild(arg_4_0.viewGO, "topright/minimap/mask").transform

	arg_4_0._maskHalfWidth = recthelper.getWidth(var_4_0) / 2
	arg_4_0._maskHalfHeight = recthelper.getHeight(var_4_0) / 2
	arg_4_0._container = gohelper.findChild(arg_4_0.viewGO, "topright/minimap/mask/container").transform
	arg_4_0._mapItem = gohelper.findChild(arg_4_0.viewGO, "topright/minimap/mask/container/#go_mapitem")
	arg_4_0._itemWidth = recthelper.getWidth(arg_4_0._mapItem.transform)
	arg_4_0._itemHeight = recthelper.getHeight(arg_4_0._mapItem.transform)

	local var_4_1 = ExploreMapModel.instance.mapBound

	arg_4_0._offsetX = var_4_1.x
	arg_4_0._offsetY = var_4_1.z
	arg_4_0._mapWidth = (var_4_1.y - var_4_1.x + 1) * arg_4_0._itemWidth
	arg_4_0._mapHeight = (var_4_1.w - var_4_1.z + 1) * arg_4_0._itemHeight

	recthelper.setWidth(arg_4_0._container, arg_4_0._mapWidth)
	recthelper.setHeight(arg_4_0._container, arg_4_0._mapHeight)
	arg_4_0:applyRolePos()
	arg_4_0:showKeyTips()
end

function var_0_0._openSmallMap(arg_5_0)
	ViewMgr.instance:openView(ViewName.ExploreMapView)
end

function var_0_0.outlineChange(arg_6_0, arg_6_1)
	if arg_6_0._mapItems[arg_6_1] then
		arg_6_0._mapItems[arg_6_1]:updateOutLineIcon()
	end
end

function var_0_0._areaShowChange(arg_7_0)
	arg_7_0._fromX = nil

	arg_7_0:applyRolePos()
end

function var_0_0.applyRolePos(arg_8_0, arg_8_1)
	if not arg_8_1 then
		arg_8_0._hero = arg_8_0._hero or ExploreController.instance:getMap():getHero()

		if not arg_8_0._hero then
			return
		end

		arg_8_1 = arg_8_0._hero:getPos()
	end

	local var_8_0 = -arg_8_0._offsetX
	local var_8_1 = -arg_8_0._offsetY
	local var_8_2 = ExploreMapModel.instance.nowMapRotate
	local var_8_3 = -(var_8_0 + arg_8_1.x) * arg_8_0._itemWidth
	local var_8_4 = -(var_8_1 + arg_8_1.z) * arg_8_0._itemWidth
	local var_8_5 = math.floor((-var_8_3 - arg_8_0._maskHalfWidth) / arg_8_0._itemWidth)
	local var_8_6 = math.ceil((-var_8_3 + arg_8_0._maskHalfWidth) / arg_8_0._itemWidth)
	local var_8_7 = math.floor((-var_8_4 - arg_8_0._maskHalfHeight) / arg_8_0._itemHeight)
	local var_8_8 = math.ceil((-var_8_4 + arg_8_0._maskHalfHeight) / arg_8_0._itemHeight)

	if var_8_2 ~= 0 then
		local var_8_9 = var_8_3

		var_8_3 = var_8_4 * math.sin(-var_8_2 * Mathf.Deg2Rad) + var_8_3 * math.cos(-var_8_2 * Mathf.Deg2Rad)
		var_8_4 = var_8_4 * math.cos(-var_8_2 * Mathf.Deg2Rad) + var_8_9 * math.sin(var_8_2 * Mathf.Deg2Rad)
	end

	transformhelper.setLocalPosXY(arg_8_0._container, var_8_3, var_8_4)
	transformhelper.setLocalRotation(arg_8_0._container, 0, 0, var_8_2)
	arg_8_0:showMapItem(var_8_5 + arg_8_0._offsetX, var_8_7 + arg_8_0._offsetY, var_8_6 + arg_8_0._offsetX, var_8_8 + arg_8_0._offsetY)
end

function var_0_0.showMapItem(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if arg_9_0._fromX == arg_9_1 and arg_9_0._fromY == arg_9_2 and arg_9_0._toX == arg_9_3 and arg_9_0._toY == arg_9_4 then
		for iter_9_0, iter_9_1 in pairs(arg_9_0._mapItems) do
			iter_9_1:updateRotate()
		end

		return
	end

	arg_9_0._fromX, arg_9_0._fromY, arg_9_0._toX, arg_9_0._toY = arg_9_1, arg_9_2, arg_9_3, arg_9_4

	for iter_9_2, iter_9_3 in pairs(arg_9_0._mapItems) do
		iter_9_3:markUse(false)
	end

	local var_9_0 = {}
	local var_9_1 = {}

	for iter_9_4 = arg_9_1, arg_9_3 do
		for iter_9_5 = arg_9_2, arg_9_4 do
			local var_9_2 = ExploreHelper.getKeyXY(iter_9_4, iter_9_5)

			if ExploreMapModel.instance:getNodeIsShow(var_9_2) then
				if arg_9_0._mapItems[var_9_2] then
					arg_9_0._mapItems[var_9_2]:markUse(true)

					arg_9_0._mapItems[var_9_2]._mo.rotate = true

					arg_9_0._mapItems[var_9_2]:updateRotate()
				else
					local var_9_3 = {}
					local var_9_4 = ExploreHelper.getKeyXY(iter_9_4 - 1, iter_9_5)
					local var_9_5 = ExploreHelper.getKeyXY(iter_9_4 + 1, iter_9_5)
					local var_9_6 = ExploreHelper.getKeyXY(iter_9_4, iter_9_5 + 1)
					local var_9_7 = ExploreHelper.getKeyXY(iter_9_4, iter_9_5 - 1)

					var_9_3.left = not ExploreMapModel.instance:getNodeIsShow(var_9_4)
					var_9_3.right = not ExploreMapModel.instance:getNodeIsShow(var_9_5)
					var_9_3.top = not ExploreMapModel.instance:getNodeIsShow(var_9_6)
					var_9_3.bottom = not ExploreMapModel.instance:getNodeIsShow(var_9_7)
					var_9_3.key = var_9_2
					var_9_3.posX, var_9_3.posY = (iter_9_4 - arg_9_0._offsetX) * arg_9_0._itemWidth, (iter_9_5 - arg_9_0._offsetY) * arg_9_0._itemHeight
					var_9_3.rotate = true
					var_9_0[var_9_2] = var_9_3

					if arg_9_0._mapItems[var_9_4] then
						arg_9_0._mapItems[var_9_4]._mo.right = false
						var_9_1[var_9_4] = true
					end

					if arg_9_0._mapItems[var_9_5] then
						arg_9_0._mapItems[var_9_5]._mo.left = false
						var_9_1[var_9_5] = true
					end

					if arg_9_0._mapItems[var_9_6] then
						arg_9_0._mapItems[var_9_6]._mo.bottom = false
						var_9_1[var_9_6] = true
					end

					if arg_9_0._mapItems[var_9_7] then
						arg_9_0._mapItems[var_9_7]._mo.top = false
						var_9_1[var_9_7] = true
					end
				end
			end
		end
	end

	for iter_9_6, iter_9_7 in pairs(arg_9_0._mapItems) do
		if not iter_9_7:getIsUse() then
			table.insert(arg_9_0._mapItemsNoUse, iter_9_7)

			arg_9_0._mapItems[iter_9_6] = nil
			var_9_1[iter_9_6] = nil
		end
	end

	local var_9_8 = #arg_9_0._mapItemsNoUse

	for iter_9_8, iter_9_9 in pairs(var_9_0) do
		if var_9_8 > 0 then
			arg_9_0._mapItems[iter_9_8] = arg_9_0._mapItemsNoUse[var_9_8]
			arg_9_0._mapItemsNoUse[var_9_8] = nil
			var_9_8 = var_9_8 - 1

			arg_9_0._mapItems[iter_9_8]:markUse()
			arg_9_0._mapItems[iter_9_8]:updateMo(iter_9_9)
			arg_9_0._mapItems[iter_9_8]:updateRotate()
		else
			local var_9_9 = gohelper.cloneInPlace(arg_9_0._mapItem)

			gohelper.setActive(var_9_9, true)

			arg_9_0._mapItems[iter_9_8] = MonoHelper.addNoUpdateLuaComOnceToGo(var_9_9, ExploreMapItem, iter_9_9)
		end
	end

	for iter_9_10 in pairs(var_9_1) do
		arg_9_0._mapItems[iter_9_10]:updateMo(arg_9_0._mapItems[iter_9_10]._mo)
		arg_9_0._mapItems[iter_9_10]:updateRotate()
	end

	for iter_9_11 = 1, var_9_8 do
		arg_9_0._mapItemsNoUse[iter_9_11]:setActive(false)
	end
end

function var_0_0.showKeyTips(arg_10_0)
	PCInputController.instance:showkeyTips(arg_10_0._keytips, PCInputModel.Activity.thrityDoor, PCInputModel.thrityDoorFun.map)
end

return var_0_0
