module("modules.logic.survival.view.map.SurvivalSmallMapView", package.seeall)

local var_0_0 = class("SurvivalSmallMapView", BaseView)
local var_0_1 = 115
local var_0_2 = 0.5
local var_0_3 = 1.5
local var_0_4 = Vector2()

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goscroll = gohelper.findChild(arg_1_0.viewGO, "container")
	arg_1_0._scroll = arg_1_0._goscroll:GetComponent(gohelper.Type_LimitedScrollRect)
	arg_1_0._mapRoot = gohelper.findChild(arg_1_0.viewGO, "container/#go_map").transform
	arg_1_0._gomapItem = gohelper.findChild(arg_1_0.viewGO, "container/#go_map/mapitems/#go_mapitem")
	arg_1_0._gowarmItem = gohelper.findChild(arg_1_0.viewGO, "container/#go_map/warming/#go_warning")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._slider = gohelper.findChildSlider(arg_1_0.viewGO, "Right/#go_mapSlider")
	arg_1_0._btnup = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_up")
	arg_1_0._btndown = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_down")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._btnup:AddClickListener(arg_2_0.setScaleByBtn, arg_2_0, 1)
	arg_2_0._btndown:AddClickListener(arg_2_0.setScaleByBtn, arg_2_0, -1)
	arg_2_0._slider:AddOnValueChanged(arg_2_0.onSliderValueChange, arg_2_0)

	arg_2_0._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(arg_2_0._scroll.gameObject)

	arg_2_0._touchEventMgr:SetIgnoreUI(true)
	arg_2_0._touchEventMgr:SetOnMultiDragCb(arg_2_0.onScaleHandler, arg_2_0)
	arg_2_0._touchEventMgr:SetScrollWheelCb(arg_2_0.onMouseScrollWheelChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnup:RemoveClickListener()
	arg_3_0._btndown:RemoveClickListener()
	arg_3_0._slider:RemoveOnValueChanged()

	if arg_3_0._touchEventMgr then
		TouchEventMgrHepler.remove(arg_3_0._touchEventMgr)

		arg_3_0._touchEventMgr = nil
	end
end

function var_0_0.onOpen(arg_4_0)
	if BootNativeUtil.isMobilePlayer() then
		TaskDispatcher.runRepeat(arg_4_0._checkMultDrag, arg_4_0, 0, -1)
	end

	arg_4_0._scale = 1

	arg_4_0._slider:SetValue((1 - var_0_2) / (var_0_3 - var_0_2))
	gohelper.setActive(arg_4_0._gomapItem, false)

	local var_4_0 = SurvivalMapModel.instance:getCurMapCo()

	arg_4_0._mapCo = var_4_0

	recthelper.setWidth(arg_4_0._mapRoot, (arg_4_0._mapCo.maxX - arg_4_0._mapCo.minX + 2) * var_0_1)
	recthelper.setHeight(arg_4_0._mapRoot, (arg_4_0._mapCo.maxY - arg_4_0._mapCo.minY + 2) * var_0_1)

	arg_4_0._allItemDatas = {}

	for iter_4_0, iter_4_1 in pairs(var_4_0.allBlocks) do
		local var_4_1 = iter_4_1.pos

		table.insert(arg_4_0._allItemDatas, {
			pos = var_4_1,
			walkable = iter_4_1.walkable,
			hightValue = tabletool.indexOf(var_4_0.allHightValueNode, var_4_1)
		})

		for iter_4_2, iter_4_3 in ipairs(iter_4_1.exNodes) do
			table.insert(arg_4_0._allItemDatas, {
				pos = iter_4_3,
				walkable = iter_4_1.walkable,
				hightValue = tabletool.indexOf(var_4_0.allHightValueNode, iter_4_3)
			})
		end
	end

	local var_4_2 = SurvivalMapModel.instance:getSceneMo()
	local var_4_3 = var_4_2.units

	table.sort(var_4_3, SurvivalSceneMo.sortUnitMo)

	local var_4_4 = false

	for iter_4_4, iter_4_5 in ipairs(var_4_3) do
		local var_4_5 = false

		for iter_4_6, iter_4_7 in ipairs(arg_4_0._allItemDatas) do
			if iter_4_7.pos == iter_4_5.pos then
				var_4_5 = true

				if not iter_4_7.unitMos then
					iter_4_7.unitMos = {}
				end

				table.insert(iter_4_7.unitMos, iter_4_5)

				break
			end
		end

		if not var_4_5 then
			table.insert(arg_4_0._allItemDatas, {
				walkable = false,
				hightValue = false,
				pos = iter_4_5.pos,
				unitMos = {
					iter_4_5
				}
			})
		end
	end

	local var_4_6 = false

	for iter_4_8, iter_4_9 in ipairs(arg_4_0._allItemDatas) do
		if iter_4_9.pos == var_4_2.player.pos then
			iter_4_9.unitMos = nil
			iter_4_9.unitMo = var_4_2.player
			var_4_6 = true

			break
		end
	end

	if not var_4_6 then
		table.insert(arg_4_0._allItemDatas, {
			walkable = false,
			hightValue = false,
			pos = var_4_2.player.pos,
			unitMo = var_4_2.player
		})
	end

	local var_4_7 = arg_4_0._goscroll.transform
	local var_4_8 = recthelper.getWidth(var_4_7)
	local var_4_9 = recthelper.getHeight(var_4_7)
	local var_4_10, var_4_11 = arg_4_0:hexToRectPos(var_4_2.player.pos.q, var_4_2.player.pos.r)
	local var_4_12 = -var_4_10 + var_4_8 / 2 - var_0_1 / 2
	local var_4_13 = -var_4_11 + var_4_9 / 2 - var_0_1 / 2

	recthelper.setAnchor(arg_4_0._mapRoot, var_4_12, var_4_13)

	local var_4_14 = var_4_2.exitPos

	for iter_4_10, iter_4_11 in ipairs(arg_4_0._allItemDatas) do
		iter_4_11.isInRain = SurvivalHelper.instance:getDistance(iter_4_11.pos, var_4_14) > var_4_2.circle
	end

	arg_4_0._allMulIcons = {}
	arg_4_0._curCreateIndex = 0

	TaskDispatcher.runRepeat(arg_4_0.frameToCreateItems, arg_4_0, 0)
	arg_4_0:createWarmItems()
end

function var_0_0.createWarmItems(arg_5_0)
	local var_5_0 = SurvivalMapModel.instance:getCurMapCo().exitPos
	local var_5_1 = 0
	local var_5_2 = SurvivalMapModel.instance:getSceneMo().safeZone[1]

	if var_5_2 and var_5_2.round ~= 1 then
		var_5_1 = var_5_2.finalCircle
	end

	if var_5_1 <= 0 then
		return
	end

	for iter_5_0 = -var_5_1, var_5_1 do
		for iter_5_1 = -var_5_1, var_5_1 do
			for iter_5_2 = -var_5_1, var_5_1 do
				if iter_5_0 + iter_5_1 + iter_5_2 == 0 and (math.abs(iter_5_0) == var_5_1 or math.abs(iter_5_1) == var_5_1 or math.abs(iter_5_2) == var_5_1) then
					arg_5_0:createWarmItem(iter_5_0, iter_5_1, iter_5_2, var_5_1, var_5_0)
				end
			end
		end
	end
end

function var_0_0.createWarmItem(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	local var_6_0 = gohelper.cloneInPlace(arg_6_0._gowarmItem)

	gohelper.setActive(var_6_0, true)

	local var_6_1, var_6_2 = arg_6_0:hexToRectPos(arg_6_1 + arg_6_5.q, arg_6_2 + arg_6_5.r)

	transformhelper.setLocalPos(var_6_0.transform, var_6_1, var_6_2, 0)

	local var_6_3 = {
		[0] = arg_6_1 == arg_6_4 or arg_6_3 == -arg_6_4,
		arg_6_3 == -arg_6_4 or arg_6_2 == arg_6_4,
		arg_6_2 == arg_6_4 or arg_6_1 == -arg_6_4,
		arg_6_1 == -arg_6_4 or arg_6_3 == arg_6_4,
		arg_6_3 == arg_6_4 or arg_6_2 == -arg_6_4,
		arg_6_2 == -arg_6_4 or arg_6_1 == arg_6_4
	}

	for iter_6_0 = 0, 5 do
		local var_6_4 = gohelper.findChild(var_6_0, tostring(iter_6_0))

		gohelper.setActive(var_6_4, var_6_3[iter_6_0])
	end
end

function var_0_0.frameToCreateItems(arg_7_0)
	for iter_7_0 = 1, 50 do
		arg_7_0._curCreateIndex = arg_7_0._curCreateIndex + 1

		local var_7_0 = arg_7_0._allItemDatas[arg_7_0._curCreateIndex]

		if not var_7_0 then
			TaskDispatcher.cancelTask(arg_7_0.frameToCreateItems, arg_7_0)

			if #arg_7_0._allMulIcons > 0 then
				TaskDispatcher.runRepeat(arg_7_0.autoSwitchIcon, arg_7_0, 1)
			end

			break
		end

		arg_7_0:createItem(var_7_0)
	end
end

function var_0_0.autoSwitchIcon(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0._allMulIcons) do
		ZProj.TweenHelper.DoFade(iter_8_1.icon, 1, 0, 0.2)
	end

	TaskDispatcher.runDelay(arg_8_0.autoSwitchIcon2, arg_8_0, 0.2)
end

function var_0_0.autoSwitchIcon2(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0._allMulIcons) do
		iter_9_1.curIndex = iter_9_1.curIndex + 1

		if iter_9_1.curIndex > #iter_9_1.list then
			iter_9_1.curIndex = 1
		end

		UISpriteSetMgr.instance:setSurvivalSprite(iter_9_1.icon, iter_9_1.list[iter_9_1.curIndex])
		ZProj.TweenHelper.DoFade(iter_9_1.icon, 0, 1, 0.2)
	end
end

function var_0_0.onClickModalMask(arg_10_0)
	arg_10_0:closeThis()
end

local var_0_5 = {
	[SurvivalEnum.UnitType.Task] = "survival_smallmap_block_3_1",
	[SurvivalEnum.UnitType.Treasure] = "survival_smallmap_block_3_5",
	[SurvivalEnum.UnitType.Exit] = "survival_smallmap_block_3_8",
	[SurvivalEnum.UnitType.Door] = "survival_smallmap_block_3_9"
}

function var_0_0.createItem(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.pos
	local var_11_1 = gohelper.cloneInPlace(arg_11_0._gomapItem)

	gohelper.setActive(var_11_1, true)

	local var_11_2, var_11_3 = arg_11_0:hexToRectPos(var_11_0.q, var_11_0.r)

	transformhelper.setLocalPos(var_11_1.transform, var_11_2, var_11_3, 0)

	local var_11_4 = gohelper.findChildImage(var_11_1, "#image_block")
	local var_11_5 = gohelper.findChildImage(var_11_1, "#image_icon")
	local var_11_6 = gohelper.findChild(var_11_1, "#go_hero")
	local var_11_7 = gohelper.findChild(var_11_1, "#go_rain")
	local var_11_8 = gohelper.findChild(var_11_1, "#go_multiple")

	UISpriteSetMgr.instance:setSurvivalSprite(var_11_4, arg_11_1.hightValue and "survival_smallmap_block_4" or "survival_smallmap_block_0")
	gohelper.setActive(var_11_6, arg_11_1.unitMo and arg_11_1.unitMo.id == 0)
	gohelper.setActive(var_11_7, arg_11_1.isInRain)

	local var_11_9 = {}

	if arg_11_1.unitMos then
		for iter_11_0, iter_11_1 in ipairs(arg_11_1.unitMos) do
			table.insert(var_11_9, arg_11_0:getIcon(iter_11_1))
		end
	end

	gohelper.setActive(var_11_5, #var_11_9 > 0 or not arg_11_1.walkable)
	gohelper.setActive(var_11_8, #var_11_9 > 1)

	if #var_11_9 > 1 then
		table.insert(arg_11_0._allMulIcons, {
			curIndex = 1,
			icon = var_11_5,
			list = var_11_9
		})
	end

	if var_11_9[1] then
		UISpriteSetMgr.instance:setSurvivalSprite(var_11_5, var_11_9[1])
	elseif not arg_11_1.walkable then
		UISpriteSetMgr.instance:setSurvivalSprite(var_11_5, "survival_smallmap_block_2")
	end
end

function var_0_0.getIcon(arg_12_0, arg_12_1)
	if not arg_12_1 then
		return
	end

	local var_12_0 = arg_12_1.unitType
	local var_12_1 = arg_12_1.co.subType

	if arg_12_1.visionVal == 8 then
		return "survival_smallmap_block_3_10"
	elseif var_12_0 == SurvivalEnum.UnitType.NPC then
		return var_12_1 == 53 and "survival_smallmap_block_3_13" or "survival_smallmap_block_3_2"
	elseif var_12_0 == SurvivalEnum.UnitType.Search then
		local var_12_2 = arg_12_1.extraParam == "true"

		if var_12_1 == 392 then
			return var_12_2 and "survival_smallmap_block_3_16" or "survival_smallmap_block_3_15"
		else
			return var_12_2 and "survival_smallmap_block_3_4" or "survival_smallmap_block_3_3"
		end
	elseif var_12_0 == SurvivalEnum.UnitType.Battle then
		local var_12_3 = var_12_1 == 41 or var_12_1 == 43
		local var_12_4 = SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.HeroFightLevel)
		local var_12_5 = arg_12_1.co.fightLevel

		if arg_12_1.co.skip == 1 and var_12_5 <= var_12_4 then
			return var_12_3 and "survival_smallmap_block_3_12" or "survival_smallmap_block_3_11"
		else
			return var_12_3 and "survival_smallmap_block_3_7" or "survival_smallmap_block_3_6"
		end
	else
		return var_0_5[var_12_0]
	end
end

function var_0_0.hexToRectPos(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0, var_13_1, var_13_2 = SurvivalHelper.instance:hexPointToWorldPoint(arg_13_1, arg_13_2)

	return (var_13_0 - arg_13_0._mapCo.minX + 0.5) * var_0_1, (var_13_2 - arg_13_0._mapCo.minY + 0.5) * var_0_1
end

function var_0_0.onScaleHandler(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.startDragPos = nil

	arg_14_0:setScale(arg_14_0._scale * (1 + arg_14_2 * 0.01))
end

function var_0_0.onMouseScrollWheelChange(arg_15_0, arg_15_1)
	arg_15_0:setScale(arg_15_0._scale * (1 + arg_15_1))
end

function var_0_0.onSliderValueChange(arg_16_0)
	arg_16_0:setScale(var_0_2 + (var_0_3 - var_0_2) * arg_16_0._slider:GetValue(), true)
end

function var_0_0.setScaleByBtn(arg_17_0, arg_17_1)
	arg_17_0:setScale(arg_17_0._scale + arg_17_1 * 0.1)
end

function var_0_0.setScale(arg_18_0, arg_18_1, arg_18_2)
	arg_18_1 = Mathf.Clamp(arg_18_1, var_0_2, var_0_3)

	if arg_18_1 == arg_18_0._scale then
		return
	end

	if not arg_18_2 then
		arg_18_0._slider:SetValue((arg_18_1 - var_0_2) / (var_0_3 - var_0_2))
	end

	local var_18_0, var_18_1 = transformhelper.getLocalPos(arg_18_0._mapRoot)
	local var_18_2 = var_18_0 / arg_18_0._scale * arg_18_1
	local var_18_3 = var_18_1 / arg_18_0._scale * arg_18_1

	arg_18_0._scale = arg_18_1

	transformhelper.setLocalPosXY(arg_18_0._mapRoot, var_18_2, var_18_3)
	transformhelper.setLocalScale(arg_18_0._mapRoot, arg_18_0._scale, arg_18_0._scale, 1)

	arg_18_0._scroll.velocity = var_0_4
end

function var_0_0.setCanScroll(arg_19_0, arg_19_1)
	if arg_19_0._canScroll == nil then
		arg_19_0._canScroll = true
	end

	if arg_19_1 ~= arg_19_0._canScroll then
		arg_19_0._canScroll = arg_19_1

		if gohelper.isNil(arg_19_0._scroll) then
			return
		end

		if not arg_19_1 then
			arg_19_0._scroll:StopMovement()

			arg_19_0._scroll.velocity = var_0_4
		end

		arg_19_0._scroll.horizontal = arg_19_1
		arg_19_0._scroll.vertical = arg_19_1
	end
end

function var_0_0._checkMultDrag(arg_20_0)
	arg_20_0:setCanScroll(UnityEngine.Input.touchCount <= 1)
end

function var_0_0.onDestroyView(arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0.frameToCreateItems, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._checkMultDrag, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0.autoSwitchIcon, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0.autoSwitchIcon2, arg_21_0)
end

return var_0_0
