module("modules.logic.explore.view.ExploreMapView", package.seeall)

local var_0_0 = class("ExploreMapView", BaseView)
local var_0_1 = 0.5
local var_0_2 = 1.5

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close1")
	arg_1_0._btnclose2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close2")
	arg_1_0._mapContainer = gohelper.findChild(arg_1_0.viewGO, "container/#go_map").transform
	arg_1_0._mapScrollRect = gohelper.findChild(arg_1_0.viewGO, "container")
	arg_1_0._mapItem = gohelper.findChild(arg_1_0.viewGO, "container/#go_map/mapitems/#go_mapitem")
	arg_1_0._heroItem = gohelper.findChild(arg_1_0.viewGO, "container/#go_map/#go_hero").transform
	arg_1_0._txtmapname = gohelper.findChildTextMesh(arg_1_0.viewGO, "top/#txt_mapname")
	arg_1_0._txtmapnameen = gohelper.findChildTextMesh(arg_1_0.viewGO, "top/#txt_mapname/#txt_mapnameen")
	arg_1_0._slider = gohelper.findChildSlider(arg_1_0.viewGO, "Right/#go_mapSlider")
	arg_1_0._gocategory = gohelper.findChild(arg_1_0.viewGO, "#scroll_category")
	arg_1_0._gocategoryParent = gohelper.findChild(arg_1_0.viewGO, "#scroll_category/Viewport/Content")
	arg_1_0._gocategoryItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_category/Viewport/Content/#go_categoryitem")
	arg_1_0._btnCategory = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_tushi")
	arg_1_0._gocategoryon = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_tushi/icon_on")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose1:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._btnclose2:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._btnCategory:AddClickListener(arg_2_0.showHideCategory, arg_2_0)
	arg_2_0._slider:AddOnValueChanged(arg_2_0.onSliderValueChange, arg_2_0)
	ExploreController.instance:registerCallback(ExploreEvent.HeroTweenDisTr, arg_2_0.applyRolePos, arg_2_0)
	ExploreController.instance:registerCallback(ExploreEvent.OnCharacterPosChange, arg_2_0.applyRolePos, arg_2_0)
	ExploreController.instance:registerCallback(ExploreEvent.OnCharacterNodeChange, arg_2_0.onRoleNodeChange, arg_2_0)
	ExploreController.instance:registerCallback(ExploreEvent.UnitOutlineChange, arg_2_0.outlineChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose1:RemoveClickListener()
	arg_3_0._btnclose2:RemoveClickListener()
	arg_3_0._btnCategory:RemoveClickListener()
	arg_3_0._slider:RemoveOnValueChanged()
	ExploreController.instance:unregisterCallback(ExploreEvent.HeroTweenDisTr, arg_3_0.applyRolePos, arg_3_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterPosChange, arg_3_0.applyRolePos, arg_3_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterNodeChange, arg_3_0.onRoleNodeChange, arg_3_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.UnitOutlineChange, arg_3_0.outlineChange, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(arg_4_0._mapContainer.gameObject)

	arg_4_0._touchEventMgr:SetIgnoreUI(true)
	arg_4_0._touchEventMgr:SetScrollWheelCb(arg_4_0.onMouseScrollWheelChange, arg_4_0)

	if BootNativeUtil.isMobilePlayer() then
		TaskDispatcher.runRepeat(arg_4_0._checkMultDrag, arg_4_0, 0, -1)
	end

	arg_4_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_4_0._mapContainer.gameObject)

	arg_4_0._drag:AddDragBeginListener(arg_4_0._onDragBegin, arg_4_0)
	arg_4_0._drag:AddDragEndListener(arg_4_0._onDragEnd, arg_4_0)
	arg_4_0._drag:AddDragListener(arg_4_0._onDrag, arg_4_0)
end

function var_0_0.showHideCategory(arg_5_0)
	local var_5_0 = not arg_5_0._gocategory.activeSelf

	gohelper.setActive(arg_5_0._gocategory, var_5_0)
	gohelper.setActive(arg_5_0._gocategoryon, var_5_0)
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_2.play_ui_lvhu_level_unlock)
	gohelper.setActive(arg_6_0._mapItem, false)

	local var_6_0 = ExploreModel.instance:getMapId()
	local var_6_1 = var_6_0 and ExploreConfig.instance:getMapIdConfig(var_6_0)
	local var_6_2 = var_6_1 and lua_episode.configDict[var_6_1.episodeId]

	if var_6_2 then
		arg_6_0._txtmapname.text = var_6_2.name
		arg_6_0._txtmapnameen.text = var_6_2.name_En
	end

	arg_6_0._mapItems = {}
	arg_6_0._containWidth = recthelper.getWidth(arg_6_0._mapScrollRect.transform)
	arg_6_0._containHeight = recthelper.getHeight(arg_6_0._mapScrollRect.transform)
	arg_6_0._itemWidth = recthelper.getWidth(arg_6_0._mapItem.transform)
	arg_6_0._itemHeight = recthelper.getHeight(arg_6_0._mapItem.transform)

	local var_6_3 = ExploreMapModel.instance.mapBound

	arg_6_0._mapWidth = (var_6_3.y - var_6_3.x + 1) * arg_6_0._itemWidth
	arg_6_0._mapHeight = (var_6_3.w - var_6_3.z + 1) * arg_6_0._itemHeight

	recthelper.setWidth(arg_6_0._mapContainer, arg_6_0._mapWidth)
	recthelper.setHeight(arg_6_0._mapContainer, arg_6_0._mapHeight)

	arg_6_0._hero = ExploreController.instance:getMap():getHero()

	local var_6_4 = arg_6_0._hero:getPos()

	arg_6_0._offsetX = var_6_3.x
	arg_6_0._offsetY = var_6_3.z

	local var_6_5 = (var_6_4.x - arg_6_0._offsetX - 0.5) * arg_6_0._itemWidth
	local var_6_6 = (var_6_4.z - arg_6_0._offsetY - 0.5) * arg_6_0._itemHeight

	transformhelper.setLocalPosXY(arg_6_0._heroItem, var_6_5, var_6_6)

	local var_6_7 = var_6_5 + arg_6_0._itemWidth / 2
	local var_6_8 = var_6_6 + arg_6_0._itemHeight / 2

	transformhelper.setLocalPosXY(arg_6_0._mapContainer, -var_6_7, -var_6_8)

	arg_6_0._scale = 1

	arg_6_0._slider:SetValue((1 - var_0_1) / (var_0_2 - var_0_1))
	arg_6_0:calcBound()
	gohelper.setActive(arg_6_0._gocategory, false)
	gohelper.setActive(arg_6_0._gocategoryon, false)

	local var_6_9 = string.splitToNumber(var_6_1 and var_6_1.signsId or "", "#")
	local var_6_10 = {}

	if var_6_9 then
		for iter_6_0, iter_6_1 in ipairs(var_6_9) do
			local var_6_11 = lua_explore_signs.configDict[iter_6_1]

			table.insert(var_6_10, var_6_11)
		end
	end

	gohelper.CreateObjList(arg_6_0, arg_6_0.onCategoryItem, var_6_10, arg_6_0._gocategoryParent, arg_6_0._gocategoryItem)
end

function var_0_0.onCategoryItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = gohelper.findChildTextMesh(arg_7_1, "#txt_name")
	local var_7_1 = gohelper.findChildImage(arg_7_1, "#txt_name/icon")

	var_7_0.text = arg_7_2.desc

	UISpriteSetMgr.instance:setExploreSprite(var_7_1, arg_7_2.icon)
end

function var_0_0.onSliderValueChange(arg_8_0)
	arg_8_0:setScale(var_0_1 + (var_0_2 - var_0_1) * arg_8_0._slider:GetValue(), true)
end

function var_0_0._onDragBegin(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.startDragPos = arg_9_2.position
end

function var_0_0._onDragEnd(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.startDragPos = nil
end

function var_0_0._onDrag(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0.startDragPos then
		return
	end

	if UnityEngine.Input.touchCount >= 2 then
		return
	end

	local var_11_0, var_11_1 = transformhelper.getLocalPos(arg_11_0._mapContainer)
	local var_11_2 = arg_11_2.position
	local var_11_3 = var_11_0 + var_11_2.x - arg_11_0.startDragPos.x
	local var_11_4 = var_11_1 + var_11_2.y - arg_11_0.startDragPos.y

	arg_11_0.startDragPos = var_11_2

	transformhelper.setLocalPosXY(arg_11_0._mapContainer, var_11_3, var_11_4)
	arg_11_0:calcBound()
end

function var_0_0._checkMultDrag(arg_12_0)
	if UnityEngine.Input.touchCount ~= 2 then
		return
	end

	local var_12_0 = UnityEngine.Input.GetTouch(0)
	local var_12_1 = var_12_0.position
	local var_12_2 = var_12_0.deltaPosition
	local var_12_3 = UnityEngine.Input.GetTouch(1)
	local var_12_4 = var_12_3.position
	local var_12_5 = var_12_3.deltaPosition

	if (var_12_0.phase == TouchPhase.Moved or var_12_0.phase == TouchPhase.Stationary) and (var_12_3.phase == TouchPhase.Moved or var_12_3.phase == TouchPhase.Stationary) then
		local var_12_6 = var_12_1 - var_12_2
		local var_12_7 = var_12_4 - var_12_5

		if Vector2.Distance(var_12_1, var_12_4) < 5 or Vector2.Distance(var_12_6, var_12_7) < 5 then
			return
		end

		local var_12_8 = Vector2.Distance(var_12_6, var_12_7)
		local var_12_9 = (0.005 * (Vector2.Distance(var_12_1, var_12_4) - var_12_8) + 1) * arg_12_0._scale

		arg_12_0:setScale(var_12_9)
	end
end

function var_0_0.onScaleHandler(arg_13_0, arg_13_1)
	arg_13_0.startDragPos = nil

	arg_13_0:setScale(arg_13_0._scale * (1 + (arg_13_1 and 0.1 or -0.1)))
end

function var_0_0.onMouseScrollWheelChange(arg_14_0, arg_14_1)
	arg_14_0:setScale(arg_14_0._scale * (1 + arg_14_1))
end

function var_0_0.setScale(arg_15_0, arg_15_1, arg_15_2)
	arg_15_1 = Mathf.Clamp(arg_15_1, var_0_1, var_0_2)

	if arg_15_1 == arg_15_0._scale then
		return
	end

	if not arg_15_2 then
		arg_15_0._slider:SetValue((arg_15_1 - var_0_1) / (var_0_2 - var_0_1))
	end

	local var_15_0, var_15_1 = transformhelper.getLocalPos(arg_15_0._mapContainer)
	local var_15_2 = var_15_0 / arg_15_0._scale * arg_15_1
	local var_15_3 = var_15_1 / arg_15_0._scale * arg_15_1

	arg_15_0._scale = arg_15_1

	transformhelper.setLocalScale(arg_15_0._mapContainer, arg_15_0._scale, arg_15_0._scale, 1)
	transformhelper.setLocalPosXY(arg_15_0._mapContainer, var_15_2, var_15_3)

	for iter_15_0, iter_15_1 in pairs(arg_15_0._mapItems) do
		iter_15_1:setScale(1 / arg_15_0._scale)
	end

	arg_15_0:calcBound()
end

function var_0_0.applyRolePos(arg_16_0)
	if not arg_16_0._hero then
		return
	end

	local var_16_0 = arg_16_0._hero:getPos()
	local var_16_1 = (var_16_0.x - arg_16_0._offsetX - 0.5) * arg_16_0._itemWidth
	local var_16_2 = (var_16_0.z - arg_16_0._offsetY - 0.5) * arg_16_0._itemHeight

	transformhelper.setLocalPosXY(arg_16_0._heroItem, var_16_1, var_16_2)
end

function var_0_0.onRoleNodeChange(arg_17_0)
	arg_17_0._fromX = nil

	arg_17_0:calcBound()
end

function var_0_0.onClose(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._checkMultDrag, arg_18_0)

	arg_18_0._hero = nil
end

function var_0_0.calcBound(arg_19_0)
	local var_19_0, var_19_1 = transformhelper.getLocalPos(arg_19_0._mapContainer)
	local var_19_2 = math.floor((-var_19_0 - arg_19_0._containWidth / 2) / arg_19_0._itemWidth / arg_19_0._scale)
	local var_19_3 = math.ceil((-var_19_0 + arg_19_0._containWidth / 2) / arg_19_0._itemWidth / arg_19_0._scale)
	local var_19_4 = math.floor((-var_19_1 - arg_19_0._containHeight / 2) / arg_19_0._itemHeight / arg_19_0._scale)
	local var_19_5 = math.ceil((-var_19_1 + arg_19_0._containHeight / 2) / arg_19_0._itemHeight / arg_19_0._scale)

	arg_19_0:showMapItem(var_19_2 + arg_19_0._offsetX, var_19_4 + arg_19_0._offsetY, var_19_3 + arg_19_0._offsetX, var_19_5 + arg_19_0._offsetY)
end

function var_0_0.showMapItem(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	if arg_20_0._fromX == arg_20_1 and arg_20_0._fromY == arg_20_2 and arg_20_0._toX == arg_20_3 and arg_20_0._toY == arg_20_4 then
		return
	end

	arg_20_0._fromX, arg_20_0._fromY, arg_20_0._toX, arg_20_0._toY = arg_20_1, arg_20_2, arg_20_3, arg_20_4

	local var_20_0 = {}

	for iter_20_0 = arg_20_1, arg_20_3 do
		for iter_20_1 = arg_20_2, arg_20_4 do
			local var_20_1 = ExploreHelper.getKeyXY(iter_20_0, iter_20_1)

			if not arg_20_0._mapItems[var_20_1] and (ExploreMapModel.instance:getNodeIsShow(var_20_1) or ExploreMapModel.instance:getNodeIsBound(var_20_1)) then
				local var_20_2 = gohelper.cloneInPlace(arg_20_0._mapItem)

				gohelper.setActive(var_20_2, true)

				local var_20_3 = {}
				local var_20_4 = ExploreHelper.getKeyXY(iter_20_0 - 1, iter_20_1)
				local var_20_5 = ExploreHelper.getKeyXY(iter_20_0 + 1, iter_20_1)
				local var_20_6 = ExploreHelper.getKeyXY(iter_20_0, iter_20_1 + 1)
				local var_20_7 = ExploreHelper.getKeyXY(iter_20_0, iter_20_1 - 1)

				var_20_3.bound = ExploreMapModel.instance:getNodeBoundType(var_20_1)
				var_20_3.left = not ExploreMapModel.instance:getNodeIsShow(var_20_4) and not ExploreMapModel.instance:getNodeIsBound(var_20_4)
				var_20_3.right = not ExploreMapModel.instance:getNodeIsShow(var_20_5) and not ExploreMapModel.instance:getNodeIsBound(var_20_5)
				var_20_3.top = not ExploreMapModel.instance:getNodeIsShow(var_20_6) and not ExploreMapModel.instance:getNodeIsBound(var_20_6)
				var_20_3.bottom = not ExploreMapModel.instance:getNodeIsShow(var_20_7) and not ExploreMapModel.instance:getNodeIsBound(var_20_7)

				if var_20_3.bound then
					var_20_3.left = var_20_3.left and (var_20_3.bound == 7 or var_20_3.bound == 8)
					var_20_3.right = var_20_3.right and (var_20_3.bound == 7 or var_20_3.bound == 8)
					var_20_3.top = var_20_3.top and (var_20_3.bound == 5 or var_20_3.bound == 6)
					var_20_3.bottom = var_20_3.bottom and (var_20_3.bound == 5 or var_20_3.bound == 6)
				end

				var_20_3.posX, var_20_3.posY = (iter_20_0 - arg_20_0._offsetX) * arg_20_0._itemWidth, (iter_20_1 - arg_20_0._offsetY) * arg_20_0._itemHeight
				var_20_3.key = var_20_1
				arg_20_0._mapItems[var_20_1] = MonoHelper.addNoUpdateLuaComOnceToGo(var_20_2, ExploreMapItem, var_20_3)

				arg_20_0._mapItems[var_20_1]:setScale(1 / arg_20_0._scale)

				if arg_20_0._mapItems[var_20_4] then
					arg_20_0._mapItems[var_20_4]._mo.right = false
					var_20_0[var_20_4] = true
				end

				if arg_20_0._mapItems[var_20_5] then
					arg_20_0._mapItems[var_20_5]._mo.left = false
					var_20_0[var_20_5] = true
				end

				if arg_20_0._mapItems[var_20_6] then
					arg_20_0._mapItems[var_20_6]._mo.bottom = false
					var_20_0[var_20_6] = true
				end

				if arg_20_0._mapItems[var_20_7] then
					arg_20_0._mapItems[var_20_7]._mo.top = false
					var_20_0[var_20_7] = true
				end
			elseif arg_20_0._mapItems[var_20_1] and arg_20_0._mapItems[var_20_1]._mo.bound ~= ExploreMapModel.instance:getNodeBoundType(var_20_1) then
				local var_20_8 = ExploreHelper.getKeyXY(iter_20_0 - 1, iter_20_1)
				local var_20_9 = ExploreHelper.getKeyXY(iter_20_0 + 1, iter_20_1)
				local var_20_10 = ExploreHelper.getKeyXY(iter_20_0, iter_20_1 + 1)
				local var_20_11 = ExploreHelper.getKeyXY(iter_20_0, iter_20_1 - 1)
				local var_20_12 = arg_20_0._mapItems[var_20_1]._mo

				var_20_12.left = not ExploreMapModel.instance:getNodeIsShow(var_20_8) and not ExploreMapModel.instance:getNodeIsBound(var_20_8)
				var_20_12.right = not ExploreMapModel.instance:getNodeIsShow(var_20_9) and not ExploreMapModel.instance:getNodeIsBound(var_20_9)
				var_20_12.top = not ExploreMapModel.instance:getNodeIsShow(var_20_10) and not ExploreMapModel.instance:getNodeIsBound(var_20_10)
				var_20_12.bottom = not ExploreMapModel.instance:getNodeIsShow(var_20_11) and not ExploreMapModel.instance:getNodeIsBound(var_20_11)
				var_20_12.bound = ExploreMapModel.instance:getNodeBoundType(var_20_1)

				arg_20_0._mapItems[var_20_1]:updateMo(var_20_12)
			end
		end
	end

	for iter_20_2 in pairs(var_20_0) do
		arg_20_0._mapItems[iter_20_2]:updateMo(arg_20_0._mapItems[iter_20_2]._mo)
	end
end

function var_0_0.outlineChange(arg_21_0, arg_21_1)
	if arg_21_0._mapItems[arg_21_1] then
		arg_21_0._mapItems[arg_21_1]:updateOutLineIcon()
	end
end

function var_0_0.onDestroyView(arg_22_0)
	if arg_22_0._touchEventMgr then
		TouchEventMgrHepler.remove(arg_22_0._touchEventMgr)

		arg_22_0._touchEventMgr = nil
	end

	arg_22_0._drag:RemoveDragBeginListener()
	arg_22_0._drag:RemoveDragListener()
	arg_22_0._drag:RemoveDragEndListener()
end

return var_0_0
