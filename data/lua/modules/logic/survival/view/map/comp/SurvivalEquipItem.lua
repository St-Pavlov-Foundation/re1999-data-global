module("modules.logic.survival.view.map.comp.SurvivalEquipItem", package.seeall)

local var_0_0 = class("SurvivalEquipItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._golight = gohelper.findChild(arg_1_1, "#light")
	arg_1_0._godrag = gohelper.findChild(arg_1_1, "#go_drag")
	arg_1_0._goitem = gohelper.findChild(arg_1_1, "#go_drag/item")
	arg_1_0._goselect = gohelper.findChild(arg_1_1, "#go_select")
	arg_1_0._goempty = gohelper.findChild(arg_1_1, "#go_drag/empty")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_1, "#btn_click")
	arg_1_0._golock = gohelper.findChild(arg_1_1, "#go_lock")
	arg_1_0._gonew = gohelper.findChild(arg_1_1, "#go_new")
	arg_1_0._goput = gohelper.findChild(arg_1_1, "#put")
	arg_1_0._goFrequency = gohelper.findChild(arg_1_1, "#go_drag/Frequency")
	arg_1_0._imageFrequency = gohelper.findChildImage(arg_1_1, "#go_drag/Frequency/image_NumBG/#txt_Num/image_FrequencyIcon")
	arg_1_0._txtFrequency = gohelper.findChildTextMesh(arg_1_1, "#go_drag/Frequency/image_NumBG/#txt_Num")
end

function var_0_0.addEventListeners(arg_2_0)
	CommonDragHelper.instance:registerDragObj(arg_2_0.go, arg_2_0._beginDrag, arg_2_0._onDrag, arg_2_0._onEndDrag, arg_2_0._checkDrag, arg_2_0, nil, true)
	arg_2_0._btnclick:AddClickListener(arg_2_0._onClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	CommonDragHelper.instance:unregisterDragObj(arg_3_0.go)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0.initIndex(arg_4_0, arg_4_1)
	arg_4_0._index = arg_4_1
end

function var_0_0.setIsSelect(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0._goselect, arg_5_1)
end

function var_0_0.setClickCallback(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._callback = arg_6_1
	arg_6_0._callobj = arg_6_2
end

function var_0_0._onClick(arg_7_0)
	if not arg_7_0.mo then
		return
	end

	if not arg_7_0.mo.unlock then
		GameFacade.showToast(ToastEnum.SurvivalEquipLock)

		return
	end

	if arg_7_0.mo.newFlag then
		SurvivalWeekRpc.instance:sendSurvivalEquipSetNewFlagRequest({
			arg_7_0.mo.slotId
		})

		arg_7_0.mo.newFlag = false

		gohelper.setActive(arg_7_0._gonew, false)
	end

	arg_7_0._callback(arg_7_0._callobj, arg_7_0._index)
end

function var_0_0.setItemRes(arg_8_0, arg_8_1)
	local var_8_0 = gohelper.clone(arg_8_1, arg_8_0._goitem)

	gohelper.setActive(var_8_0, true)

	arg_8_0._item = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_0, SurvivalBagItem)
end

function var_0_0.initData(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = false

	if not arg_9_2 and arg_9_0.mo and arg_9_1 and not arg_9_1.item:isEmpty() and arg_9_0.mo.item.uid ~= arg_9_1.item.uid then
		var_9_0 = true
	end

	arg_9_0.mo = arg_9_1

	gohelper.setActive(arg_9_0.go, arg_9_1)

	local var_9_1 = not arg_9_1 or arg_9_1.item:isEmpty()
	local var_9_2 = arg_9_1 and arg_9_1.unlock

	gohelper.setActive(arg_9_0._goitem, not var_9_1 and var_9_2)
	gohelper.setActive(arg_9_0._goempty, var_9_1 and var_9_2)
	gohelper.setActive(arg_9_0._golock, not var_9_2)
	gohelper.setActive(arg_9_0._goFrequency, false)

	if not var_9_1 then
		arg_9_0._item:updateMo(arg_9_1.item)

		local var_9_3 = arg_9_1.parent.maxTagId
		local var_9_4 = lua_survival_equip_found.configDict[var_9_3]

		if var_9_4 then
			gohelper.setActive(arg_9_0._goFrequency, true)
			UISpriteSetMgr.instance:setSurvivalSprite(arg_9_0._imageFrequency, var_9_4.value)

			arg_9_0._txtFrequency.text = arg_9_0.mo.values[var_9_4.value] or 0
		end
	end

	if arg_9_1 then
		gohelper.setActive(arg_9_0._gonew, arg_9_1.newFlag)
	end

	if var_9_0 then
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_put_2)
		gohelper.setActive(arg_9_0._goput, false)
		gohelper.setActive(arg_9_0._goput, true)
	end
end

function var_0_0.setParentRoot(arg_10_0, arg_10_1)
	arg_10_0._root = arg_10_1
	arg_10_0._rawRoot = arg_10_0.go.transform.parent
end

function var_0_0._beginDrag(arg_11_0)
	arg_11_0.go.transform:SetParent(arg_11_0._root, true)
end

function var_0_0._onDrag(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_2.position
	local var_12_1 = recthelper.screenPosToAnchorPos(var_12_0, arg_12_0.go.transform)
	local var_12_2 = arg_12_0._godrag.transform
	local var_12_3, var_12_4 = recthelper.getAnchor(var_12_2)

	if math.abs(var_12_3 - var_12_1.x) > 10 or math.abs(var_12_4 - var_12_1.y) > 10 then
		ZProj.TweenHelper.DOAnchorPos(var_12_2, var_12_1.x, var_12_1.y, 0.2)
	else
		recthelper.setAnchor(var_12_2, var_12_1.x, var_12_1.y)
	end

	local var_12_5, var_12_6 = arg_12_0._parentView:getDragIndex(arg_12_2.position)

	if var_12_6 ~= arg_12_0 and var_12_6 ~= arg_12_0._curOverEquip then
		if arg_12_0._curOverEquip then
			arg_12_0._curOverEquip:setLightActive(false)
		end

		arg_12_0._curOverEquip = var_12_6

		if arg_12_0._curOverEquip then
			arg_12_0._curOverEquip:setLightActive(true)
		end
	end
end

function var_0_0.setLightActive(arg_13_0, arg_13_1)
	if not arg_13_0.mo or not arg_13_0.mo.unlock then
		return
	end

	gohelper.setActive(arg_13_0._golight, arg_13_1)
end

function var_0_0._onEndDrag(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0._curOverEquip then
		arg_14_0._curOverEquip:setLightActive(false)

		arg_14_0._curOverEquip = nil
	end

	local var_14_0, var_14_1 = arg_14_0._parentView:getDragIndex(arg_14_2.position)

	if var_14_0 == -1 then
		local var_14_2 = arg_14_0._godrag.transform

		ZProj.TweenHelper.DOAnchorPos(var_14_2, 0, 0, 0.2)
		SurvivalWeekRpc.instance:sendSurvivalEquipDemount(arg_14_0._index)
	elseif not var_14_0 or var_14_0 == arg_14_0._index or not arg_14_0:canMoveToIndex(var_14_0) then
		local var_14_3 = arg_14_0._godrag.transform

		ZProj.TweenHelper.DOAnchorPos(var_14_3, 0, 0, 0.2)
	else
		arg_14_0._tweenToIndex = var_14_0
		arg_14_0._tweenToItem = var_14_1

		UIBlockHelper.instance:startBlock("SurvivalEquipItem_Tween", 0.2)
		var_14_1:moveTo(arg_14_0)
		arg_14_0:moveTo(var_14_1, arg_14_0.moveEnd, arg_14_0)
	end

	arg_14_0.go.transform:SetParent(arg_14_0._rawRoot, true)
end

function var_0_0.moveTo(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = recthelper.uiPosToScreenPos(arg_15_1.go.transform)
	local var_15_1 = recthelper.screenPosToAnchorPos(var_15_0, arg_15_0.go.transform)
	local var_15_2 = arg_15_0._godrag.transform

	ZProj.TweenHelper.DOAnchorPos(var_15_2, var_15_1.x, var_15_1.y, 0.2, arg_15_2, arg_15_3)
end

function var_0_0.moveEnd(arg_16_0)
	SurvivalWeekRpc.instance:sendSurvivalEquipWear(arg_16_0._tweenToIndex, arg_16_0.mo.item.uid, arg_16_0._onRecvMsg, arg_16_0)
end

function var_0_0._onRecvMsg(arg_17_0)
	local var_17_0 = arg_17_0._godrag.transform

	recthelper.setAnchor(var_17_0, 0, 0)

	local var_17_1 = arg_17_0._tweenToItem._godrag.transform

	recthelper.setAnchor(var_17_1, 0, 0)
end

function var_0_0.canMoveToIndex(arg_18_0, arg_18_1)
	local var_18_0 = SurvivalShelterModel.instance:getWeekInfo().equipBox.slots

	if not var_18_0[arg_18_1] then
		return false
	end

	if not var_18_0[arg_18_1].unlock then
		GameFacade.showToast(ToastEnum.SurvivalEquipLock)

		return false
	end

	if arg_18_0.mo.item.equipLevel > var_18_0[arg_18_1].level then
		GameFacade.showToast(ToastEnum.SurvivalEquipLevelLimit)

		return false
	end

	if not var_18_0[arg_18_1].item:isEmpty() and var_18_0[arg_18_1].item.equipLevel > arg_18_0.mo.level then
		GameFacade.showToast(ToastEnum.SurvivalEquipLevelLimit)

		return false
	end

	return true
end

function var_0_0._checkDrag(arg_19_0)
	if not arg_19_0.mo or arg_19_0.mo.item:isEmpty() then
		return true
	end
end

function var_0_0.setParentView(arg_20_0, arg_20_1)
	arg_20_0._parentView = arg_20_1
end

return var_0_0
