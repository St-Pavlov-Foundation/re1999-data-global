module("modules.logic.gm.view.GMToolFightView", package.seeall)

local var_0_0 = class("GMToolFightView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._toggleShowFightNum = gohelper.findChildToggle(arg_1_0.viewGO, "viewport/content/item28/Toggle1")
	arg_1_0._toggleShowFightUI = gohelper.findChildToggle(arg_1_0.viewGO, "viewport/content/item28/Toggle2")
	arg_1_0._btnFightLockLifeMySide = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item29/Button1")
	arg_1_0._btnFightLockLifeEnemySide = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item29/Button2")
	arg_1_0._btnAddHurtMySide = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item30/Button1")
	arg_1_0._btnAddHurtEnemySide = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item30/Button2")
	arg_1_0._btnReduceDamageMySide = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item31/Button1")
	arg_1_0._btnReduceDamageEnemySide = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item31/Button2")
	arg_1_0._inpCost = gohelper.findChildInputField(arg_1_0.viewGO, "viewport/content/item32/inpText")
	arg_1_0._btnAddCost = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item32/Button1")
	arg_1_0._btnAddMySideExpoint = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item33/Button1")
	arg_1_0._btnAddEnemySideExpoint = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item33/Button2")
	arg_1_0._btnArrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item28/hideDetail/Arrow")
	arg_1_0._hideTemplate = gohelper.findChild(arg_1_0.viewGO, "viewport/content/item28/hideDetail/Template")
	arg_1_0._clickMask = gohelper.findChild(arg_1_0.viewGO, "viewport/content/item28/hideDetail/clickmask")
	arg_1_0._itemGO = gohelper.findChild(arg_1_0.viewGO, "viewport/content/item28/hideDetail/Template/Viewport/Item")
	arg_1_0._contentGO = gohelper.findChild(arg_1_0.viewGO, "viewport/content/item28/hideDetail/Template/Viewport/Content")
	arg_1_0._itemList = {}

	gohelper.setActive(arg_1_0._hideTemplate, false)
	gohelper.setActive(arg_1_0._clickMask, false)
	gohelper.setActive(arg_1_0._itemGO, false)
	recthelper.setHeight(arg_1_0._hideTemplate.transform, 400)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._toggleShowFightNum:AddOnValueChanged(arg_2_0._onToggleShowFightNumChange, arg_2_0)
	arg_2_0._toggleShowFightUI:AddOnValueChanged(arg_2_0._onToggleShowFightUIChange, arg_2_0)
	arg_2_0._btnFightLockLifeMySide:AddClickListener(arg_2_0._onToggleMySideLockLifeChange, arg_2_0)
	arg_2_0._btnFightLockLifeEnemySide:AddClickListener(arg_2_0._onToggleEnemySideLockLifeChange, arg_2_0)
	arg_2_0._btnAddHurtMySide:AddClickListener(arg_2_0._onToggleMySideAddHurtChange, arg_2_0)
	arg_2_0._btnAddHurtEnemySide:AddClickListener(arg_2_0._onToggleEnemySideAddHurtChange, arg_2_0)
	arg_2_0._btnReduceDamageMySide:AddClickListener(arg_2_0._onToggleMySideDamageChange, arg_2_0)
	arg_2_0._btnReduceDamageEnemySide:AddClickListener(arg_2_0._onToggleEnemySideDamageChange, arg_2_0)
	arg_2_0._btnAddCost:AddClickListener(arg_2_0._onClickAddCost, arg_2_0)
	arg_2_0._btnAddMySideExpoint:AddClickListener(arg_2_0._onClickAddMySideExpoint, arg_2_0)
	arg_2_0._btnAddEnemySideExpoint:AddClickListener(arg_2_0._onClickEnemySideExpoint, arg_2_0)
	arg_2_0._btnArrow:AddClickListener(arg_2_0._onClickArrow, arg_2_0)
	gohelper.getClick(arg_2_0._clickMask):AddClickListener(arg_2_0._onClickMask, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._toggleShowFightNum:RemoveOnValueChanged()
	arg_3_0._toggleShowFightUI:RemoveOnValueChanged()
	arg_3_0._btnFightLockLifeMySide:RemoveClickListener()
	arg_3_0._btnFightLockLifeEnemySide:RemoveClickListener()
	arg_3_0._btnAddHurtMySide:RemoveClickListener()
	arg_3_0._btnAddHurtEnemySide:RemoveClickListener()
	arg_3_0._btnReduceDamageMySide:RemoveClickListener()
	arg_3_0._btnReduceDamageEnemySide:RemoveClickListener()
	arg_3_0._btnAddCost:RemoveClickListener()
	arg_3_0._btnAddMySideExpoint:RemoveClickListener()
	arg_3_0._btnAddEnemySideExpoint:RemoveClickListener()
	arg_3_0._btnArrow:RemoveClickListener()
	gohelper.getClick(arg_3_0._clickMask):RemoveClickListener()

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._itemList) do
		gohelper.getClick(iter_3_1):RemoveClickListener()
	end
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0.initDone = false

	arg_4_0:refreshToggleStatus()

	arg_4_0.initDone = true
end

function var_0_0.refreshToggleStatus(arg_5_0)
	arg_5_0._toggleShowFightNum.isOn = PlayerPrefsHelper.getNumber(PlayerPrefsKey.FightShowFightNum, 1) == 1

	local var_5_0 = true
	local var_5_1 = GMFightShowState.getList()

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		local var_5_2 = arg_5_0._itemList[iter_5_0]

		if not GMFightShowState.getStatus(iter_5_1.valueKey) then
			var_5_0 = false

			break
		end
	end

	arg_5_0._toggleShowFightUI.isOn = var_5_0
end

function var_0_0._onToggleShowFightNumChange(arg_6_0)
	if not arg_6_0.initDone then
		return
	end

	local var_6_0 = arg_6_0._toggleShowFightNum.isOn

	FightFloatMgr.instance:setCanShowFightNumUI(var_6_0)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.FightShowFightNum, var_6_0 and 1 or 0)
end

function var_0_0._onToggleShowFightUIChange(arg_7_0)
	if not arg_7_0.initDone then
		return
	end

	arg_7_0:_oneKeySetStatus(arg_7_0._toggleShowFightUI.isOn)
	FightController.instance:dispatchEvent(FightEvent.GMHideFightView)
end

function var_0_0._onToggleMySideLockLifeChange(arg_8_0)
	GMRpc.instance:sendGMRequest("fight lockLife 0")
end

function var_0_0._onToggleEnemySideLockLifeChange(arg_9_0)
	GMRpc.instance:sendGMRequest("fight lockLife 1")
end

function var_0_0._onToggleMySideAddHurtChange(arg_10_0)
	GMRpc.instance:sendGMRequest("fight addHurt 0")
end

function var_0_0._onToggleEnemySideAddHurtChange(arg_11_0)
	GMRpc.instance:sendGMRequest("fight addHurt 1")
end

function var_0_0._onToggleMySideDamageChange(arg_12_0)
	GMRpc.instance:sendGMRequest("fight reduceDamage 0")
end

function var_0_0._onToggleEnemySideDamageChange(arg_13_0)
	GMRpc.instance:sendGMRequest("fight reduceDamage 1")
end

function var_0_0._onClickAddCost(arg_14_0)
	local var_14_0 = arg_14_0._inpCost:GetText()

	GMRpc.instance:sendGMRequest(string.format("fight addPower %s 0", var_14_0))
end

function var_0_0._onClickAddMySideExpoint(arg_15_0)
	GMRpc.instance:sendGMRequest("fight addExpoint 5 0")
end

function var_0_0._onClickEnemySideExpoint(arg_16_0)
	GMRpc.instance:sendGMRequest("fight addExpoint 5 1")
end

function var_0_0._onClickArrow(arg_17_0)
	gohelper.setActive(arg_17_0._hideTemplate, true)
	gohelper.setActive(arg_17_0._clickMask, true)

	local var_17_0 = GMFightShowState.getList()

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		local var_17_1 = arg_17_0._itemList[iter_17_0]

		if not var_17_1 then
			var_17_1 = gohelper.clone(arg_17_0._itemGO, arg_17_0._contentGO, "item" .. iter_17_0)

			table.insert(arg_17_0._itemList, var_17_1)
		end

		gohelper.setActive(var_17_1, true)

		gohelper.findChildText(var_17_1, "Item Label").text = iter_17_0 .. iter_17_1.desc

		gohelper.setActive(gohelper.findChild(var_17_1, "Item Checkmark"), GMFightShowState.getStatus(iter_17_1.valueKey))
		gohelper.getClick(var_17_1):AddClickListener(arg_17_0._onClickItem, arg_17_0, iter_17_1)
	end

	for iter_17_2 = #var_17_0 + 1, #arg_17_0._itemList do
		gohelper.setActive(arg_17_0._itemList[iter_17_2], false)
	end
end

function var_0_0._oneKeySetStatus(arg_18_0, arg_18_1)
	local var_18_0 = GMFightShowState.getList()

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		local var_18_1 = arg_18_0._itemList[iter_18_0]

		GMFightShowState.setStatus(iter_18_1.valueKey, arg_18_1)
		gohelper.setActive(gohelper.findChild(var_18_1, "Item Checkmark"), arg_18_1)
	end

	FightController.instance:dispatchEvent(FightEvent.GMHideFightView)
end

function var_0_0._onClickItem(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0._itemList[arg_19_1.id]
	local var_19_1 = GMFightShowState.getStatus(arg_19_1.valueKey)
	local var_19_2
	local var_19_3 = (var_19_1 == nil or var_19_1 == false) and true or false

	GMFightShowState.setStatus(arg_19_1.valueKey, var_19_3)
	gohelper.setActive(gohelper.findChild(var_19_0, "Item Checkmark"), var_19_3)
	FightController.instance:dispatchEvent(FightEvent.GMHideFightView)
end

function var_0_0._onClickMask(arg_20_0)
	gohelper.setActive(arg_20_0._hideTemplate, false)
	gohelper.setActive(arg_20_0._clickMask, false)
end

return var_0_0
