module("modules.logic.gm.view.GMToolFightView", package.seeall)

slot0 = class("GMToolFightView", BaseView)

function slot0.onInitView(slot0)
	slot0._toggleShowFightNum = gohelper.findChildToggle(slot0.viewGO, "viewport/content/item28/Toggle1")
	slot0._toggleShowFightUI = gohelper.findChildToggle(slot0.viewGO, "viewport/content/item28/Toggle2")
	slot0._btnFightLockLifeMySide = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item29/Button1")
	slot0._btnFightLockLifeEnemySide = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item29/Button2")
	slot0._btnAddHurtMySide = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item30/Button1")
	slot0._btnAddHurtEnemySide = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item30/Button2")
	slot0._btnReduceDamageMySide = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item31/Button1")
	slot0._btnReduceDamageEnemySide = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item31/Button2")
	slot0._inpCost = gohelper.findChildInputField(slot0.viewGO, "viewport/content/item32/inpText")
	slot0._btnAddCost = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item32/Button1")
	slot0._btnAddMySideExpoint = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item33/Button1")
	slot0._btnAddEnemySideExpoint = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item33/Button2")
	slot0._btnArrow = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item28/hideDetail/Arrow")
	slot0._hideTemplate = gohelper.findChild(slot0.viewGO, "viewport/content/item28/hideDetail/Template")
	slot0._clickMask = gohelper.findChild(slot0.viewGO, "viewport/content/item28/hideDetail/clickmask")
	slot0._itemGO = gohelper.findChild(slot0.viewGO, "viewport/content/item28/hideDetail/Template/Viewport/Item")
	slot0._contentGO = gohelper.findChild(slot0.viewGO, "viewport/content/item28/hideDetail/Template/Viewport/Content")
	slot0._itemList = {}

	gohelper.setActive(slot0._hideTemplate, false)
	gohelper.setActive(slot0._clickMask, false)
	gohelper.setActive(slot0._itemGO, false)
	recthelper.setHeight(slot0._hideTemplate.transform, 400)
end

function slot0.addEvents(slot0)
	slot0._toggleShowFightNum:AddOnValueChanged(slot0._onToggleShowFightNumChange, slot0)
	slot0._toggleShowFightUI:AddOnValueChanged(slot0._onToggleShowFightUIChange, slot0)
	slot0._btnFightLockLifeMySide:AddClickListener(slot0._onToggleMySideLockLifeChange, slot0)
	slot0._btnFightLockLifeEnemySide:AddClickListener(slot0._onToggleEnemySideLockLifeChange, slot0)
	slot0._btnAddHurtMySide:AddClickListener(slot0._onToggleMySideAddHurtChange, slot0)
	slot0._btnAddHurtEnemySide:AddClickListener(slot0._onToggleEnemySideAddHurtChange, slot0)
	slot0._btnReduceDamageMySide:AddClickListener(slot0._onToggleMySideDamageChange, slot0)
	slot0._btnReduceDamageEnemySide:AddClickListener(slot0._onToggleEnemySideDamageChange, slot0)
	slot0._btnAddCost:AddClickListener(slot0._onClickAddCost, slot0)
	slot0._btnAddMySideExpoint:AddClickListener(slot0._onClickAddMySideExpoint, slot0)
	slot0._btnAddEnemySideExpoint:AddClickListener(slot0._onClickEnemySideExpoint, slot0)
	slot0._btnArrow:AddClickListener(slot0._onClickArrow, slot0)
	gohelper.getClick(slot0._clickMask):AddClickListener(slot0._onClickMask, slot0)
end

function slot0.removeEvents(slot0)
	slot0._toggleShowFightNum:RemoveOnValueChanged()
	slot0._toggleShowFightUI:RemoveOnValueChanged()
	slot0._btnFightLockLifeMySide:RemoveClickListener()
	slot0._btnFightLockLifeEnemySide:RemoveClickListener()
	slot0._btnAddHurtMySide:RemoveClickListener()
	slot0._btnAddHurtEnemySide:RemoveClickListener()
	slot0._btnReduceDamageMySide:RemoveClickListener()
	slot0._btnReduceDamageEnemySide:RemoveClickListener()
	slot0._btnAddCost:RemoveClickListener()
	slot0._btnAddMySideExpoint:RemoveClickListener()
	slot0._btnAddEnemySideExpoint:RemoveClickListener()
	slot0._btnArrow:RemoveClickListener()
	gohelper.getClick(slot0._clickMask):RemoveClickListener()

	for slot4, slot5 in ipairs(slot0._itemList) do
		gohelper.getClick(slot5):RemoveClickListener()
	end
end

function slot0.onOpen(slot0)
	slot0.initDone = false

	slot0:refreshToggleStatus()

	slot0.initDone = true
end

function slot0.refreshToggleStatus(slot0)
	slot0._toggleShowFightNum.isOn = PlayerPrefsHelper.getNumber(PlayerPrefsKey.FightShowFightNum, 1) == 1
	slot1 = true

	for slot6, slot7 in ipairs(GMFightShowState.getList()) do
		slot8 = slot0._itemList[slot6]

		if not GMFightShowState.getStatus(slot7.valueKey) then
			slot1 = false

			break
		end
	end

	slot0._toggleShowFightUI.isOn = slot1
end

function slot0._onToggleShowFightNumChange(slot0)
	if not slot0.initDone then
		return
	end

	slot1 = slot0._toggleShowFightNum.isOn

	FightFloatMgr.instance:setCanShowFightNumUI(slot1)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.FightShowFightNum, slot1 and 1 or 0)
end

function slot0._onToggleShowFightUIChange(slot0)
	if not slot0.initDone then
		return
	end

	slot0:_oneKeySetStatus(slot0._toggleShowFightUI.isOn)
	FightController.instance:dispatchEvent(FightEvent.GMHideFightView)
end

function slot0._onToggleMySideLockLifeChange(slot0)
	GMRpc.instance:sendGMRequest("fight lockLife 0")
end

function slot0._onToggleEnemySideLockLifeChange(slot0)
	GMRpc.instance:sendGMRequest("fight lockLife 1")
end

function slot0._onToggleMySideAddHurtChange(slot0)
	GMRpc.instance:sendGMRequest("fight addHurt 0")
end

function slot0._onToggleEnemySideAddHurtChange(slot0)
	GMRpc.instance:sendGMRequest("fight addHurt 1")
end

function slot0._onToggleMySideDamageChange(slot0)
	GMRpc.instance:sendGMRequest("fight reduceDamage 0")
end

function slot0._onToggleEnemySideDamageChange(slot0)
	GMRpc.instance:sendGMRequest("fight reduceDamage 1")
end

function slot0._onClickAddCost(slot0)
	GMRpc.instance:sendGMRequest(string.format("fight addPower %s 0", slot0._inpCost:GetText()))
end

function slot0._onClickAddMySideExpoint(slot0)
	GMRpc.instance:sendGMRequest("fight addExpoint 5 0")
end

function slot0._onClickEnemySideExpoint(slot0)
	GMRpc.instance:sendGMRequest("fight addExpoint 5 1")
end

function slot0._onClickArrow(slot0)
	gohelper.setActive(slot0._hideTemplate, true)
	gohelper.setActive(slot0._clickMask, true)

	for slot5, slot6 in ipairs(GMFightShowState.getList()) do
		if not slot0._itemList[slot5] then
			table.insert(slot0._itemList, gohelper.clone(slot0._itemGO, slot0._contentGO, "item" .. slot5))
		end

		gohelper.setActive(slot7, true)

		gohelper.findChildText(slot7, "Item Label").text = slot5 .. slot6.desc

		gohelper.setActive(gohelper.findChild(slot7, "Item Checkmark"), GMFightShowState.getStatus(slot6.valueKey))
		gohelper.getClick(slot7):AddClickListener(slot0._onClickItem, slot0, slot6)
	end

	for slot5 = #slot1 + 1, #slot0._itemList do
		gohelper.setActive(slot0._itemList[slot5], false)
	end
end

function slot0._oneKeySetStatus(slot0, slot1)
	for slot6, slot7 in ipairs(GMFightShowState.getList()) do
		GMFightShowState.setStatus(slot7.valueKey, slot1)
		gohelper.setActive(gohelper.findChild(slot0._itemList[slot6], "Item Checkmark"), slot1)
	end

	FightController.instance:dispatchEvent(FightEvent.GMHideFightView)
end

function slot0._onClickItem(slot0, slot1)
	slot4 = nil
	slot4 = (GMFightShowState.getStatus(slot1.valueKey) == nil or slot3 == false) and true or false

	GMFightShowState.setStatus(slot1.valueKey, slot4)
	gohelper.setActive(gohelper.findChild(slot0._itemList[slot1.id], "Item Checkmark"), slot4)
	FightController.instance:dispatchEvent(FightEvent.GMHideFightView)
end

function slot0._onClickMask(slot0)
	gohelper.setActive(slot0._hideTemplate, false)
	gohelper.setActive(slot0._clickMask, false)
end

return slot0
