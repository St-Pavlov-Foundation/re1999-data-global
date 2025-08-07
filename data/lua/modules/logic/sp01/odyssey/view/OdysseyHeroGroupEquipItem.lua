module("modules.logic.sp01.odyssey.view.OdysseyHeroGroupEquipItem", package.seeall)

local var_0_0 = class("OdysseyHeroGroupEquipItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._goEmpty = gohelper.findChild(arg_1_0.go, "#go_Empty")
	arg_1_0._goShowEmpty = gohelper.findChild(arg_1_0.go, "#go_showEmpty")
	arg_1_0._gonoEmpty = gohelper.findChild(arg_1_0.go, "#go_noEmpty")
	arg_1_0._simageEquipIcon = gohelper.findChildSingleImage(arg_1_0.go, "#go_noEmpty/#simage_EquipIcon")
	arg_1_0._goSelect = gohelper.findChild(arg_1_0.go, "#go_Select")
	arg_1_0._btnClick = gohelper.findChildButtonWithAudio(arg_1_0.go, "#btn_Click")
	arg_1_0._imageRare = gohelper.findChildImage(arg_1_0.go, "#go_noEmpty/#image_rare")
	arg_1_0._imageSuit = gohelper.findChildImage(arg_1_0.go, "#go_noEmpty/suit/image_suitIcon")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnClick:AddClickListener(arg_2_0._btnClickOnClick, arg_2_0)
	arg_2_0._clickEquip:AddClickUpListener(arg_2_0._btnClickUp, arg_2_0)
	arg_2_0._clickEquip:AddClickListener(arg_2_0._btnClickOnClick, arg_2_0)
	arg_2_0._btnLongPress:AddLongPressListener(arg_2_0.onLongClickItem, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnClick:RemoveClickListener()
	arg_3_0._clickEquip:RemoveClickListener()
	arg_3_0._clickEquip:RemoveClickUpListener()
	arg_3_0._btnLongPress:RemoveLongPressListener()
end

function var_0_0._btnClickUp(arg_4_0)
	arg_4_0.isLongParse = false
end

function var_0_0._btnClickOnClick(arg_5_0)
	if arg_5_0.isDrag or arg_5_0.isLongParse then
		return
	end

	if arg_5_0.type == OdysseyEnum.BagType.Bag then
		OdysseyController.instance:dispatchEvent(OdysseyEvent.OnEquipPosSelect, arg_5_0.index)
	elseif arg_5_0.type == OdysseyEnum.BagType.FightPrepare then
		local var_5_0 = {
			index = arg_5_0.index,
			heroPos = arg_5_0.heroPos
		}

		OdysseyController.instance:openEquipView(var_5_0)
	end
end

function var_0_0.onLongClickItem(arg_6_0)
	if arg_6_0.isDrag then
		return
	end

	arg_6_0.isLongParse = true

	if arg_6_0.equipUid ~= nil and arg_6_0.equipUid ~= 0 and arg_6_0.type == OdysseyEnum.BagType.FightPrepare then
		local var_6_0 = OdysseyItemModel.instance:getItemMoByUid(arg_6_0.equipUid)
		local var_6_1 = {
			itemId = var_6_0.id,
			clickPos = GamepadController.instance:getMousePosition()
		}

		OdysseyController.instance:showItemTipView(var_6_1)
	end
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._clickEquip = gohelper.getClick(arg_7_0._gonoEmpty)
	arg_7_0._btnLongPress = SLFramework.UGUI.UILongPressListener.Get(arg_7_0._gonoEmpty)

	arg_7_0._btnLongPress:SetLongPressTime({
		0.8,
		99999
	})
end

function var_0_0.setActive(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0.go, arg_8_1)
	gohelper.setActive(arg_8_0._goEmpty, arg_8_1)
end

function var_0_0.setEmptyParent(arg_9_0, arg_9_1)
	arg_9_0._goEmpty.transform:SetParent(arg_9_1, false)
end

function var_0_0.setInfo(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	arg_10_0.index = arg_10_2
	arg_10_0.heroPos = arg_10_1
	arg_10_0.equipUid = arg_10_3
	arg_10_0.type = arg_10_4

	local var_10_0 = arg_10_3 == nil or arg_10_3 == 0
	local var_10_1 = arg_10_4 == OdysseyEnum.BagType.OnlyDisplay

	gohelper.setActive(arg_10_0._gonoEmpty, not var_10_0)
	gohelper.setActive(arg_10_0._goShowEmpty, var_10_0 and var_10_1)
	arg_10_0:resetPos()

	if var_10_0 then
		return
	end

	local var_10_2 = OdysseyItemModel.instance:getItemMoByUid(arg_10_3)
	local var_10_3 = OdysseyConfig.instance:getItemConfig(var_10_2.id)

	if var_10_3.type == OdysseyEnum.ItemType.Item then
		arg_10_0._simageEquipIcon:LoadImage(ResUrl.getPropItemIcon(var_10_3.icon))
	elseif var_10_3.type == OdysseyEnum.ItemType.Equip then
		arg_10_0._simageEquipIcon:LoadImage(ResUrl.getSp01OdysseyItemSingleBg(var_10_3.icon))

		local var_10_4 = OdysseyConfig.instance:getEquipSuitConfig(var_10_3.suitId)

		UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(arg_10_0._imageSuit, var_10_4.icon)
	end

	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(arg_10_0._imageRare, "odyssey_item_quality" .. var_10_3.rare)
	arg_10_0:setSelect(nil)
end

function var_0_0.setSelect(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.index and arg_11_1 == arg_11_0.index

	gohelper.setActive(arg_11_0._goSelect, var_11_0)
end

function var_0_0.resetPos(arg_12_0)
	recthelper.setAnchor(arg_12_0._gonoEmpty.transform, 0, 0)
end

function var_0_0.clear(arg_13_0)
	arg_13_0.index = nil
	arg_13_0.heroPos = nil
	arg_13_0.equipUid = nil
	arg_13_0.type = nil

	arg_13_0:setSelect(nil)
end

function var_0_0.refreshUI(arg_14_0)
	return
end

function var_0_0.onItemBeginDrag(arg_15_0, arg_15_1)
	if arg_15_1 == arg_15_0.mo.id then
		ZProj.TweenHelper.DOScale(arg_15_0.go.transform, 1.1, 1.1, 1, 0.2, nil, nil, nil, EaseType.Linear)
	end
end

function var_0_0.isEmpty(arg_16_0)
	return arg_16_0.go.activeSelf == true and (arg_16_0.equipUid == nil or arg_16_0.equipUid == 0)
end

function var_0_0.isActive(arg_17_0)
	return arg_17_0.go.activeSelf == true and arg_17_0.heroPos ~= nil and arg_17_0.index ~= nil
end

function var_0_0.onDestroy(arg_18_0)
	return
end

return var_0_0
