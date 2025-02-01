module("modules.logic.versionactivity1_8.dungeon.view.factory.VersionActivity1_8FactoryBlueprintPartItem", package.seeall)

slot0 = class("VersionActivity1_8FactoryBlueprintPartItem", LuaCompBase)
slot1 = 0.87

function slot0.ctor(slot0, slot1)
	slot0.actId = Activity157Model.instance:getActId()
	slot0.componentId = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.trans = slot0.go.transform
	slot0._statusAnimator = gohelper.findChildComponent(slot0.go, "status", typeof(UnityEngine.Animator))
	slot0._golock = gohelper.findChild(slot0.go, "status/#go_lock")
	slot0._golockicon = gohelper.findChild(slot0.go, "status/#go_lock/#go_lockedicon")
	slot0._goberepaired = gohelper.findChild(slot0.go, "status/#go_lock/#go_berepaired")
	slot0._btnrepair = gohelper.findChildClickWithDefaultAudio(slot0.go, "status/#go_lock/#go_berepaired/#btn_repair")
	slot0._goberepairedreddot = gohelper.findChild(slot0.go, "status/#go_lock/#go_berepaired/#go_reddot")
	slot0._txtrepairtip = gohelper.findChildText(slot0.go, "status/#go_lock/#go_berepaired/bg/#txt_num")
	slot0._imagerepairicon = gohelper.findChildImage(slot0.go, "status/#go_lock/#go_berepaired/bg/icon")
	slot0._gonormal = gohelper.findChild(slot0.go, "status/#go_normal")
	slot0._btnpart = gohelper.findChildClickWithDefaultAudio(slot0.go, "#btn_part")
	slot0._gobtnpart = slot0._btnpart.gameObject

	if Activity157Config.instance:getAct157Const(slot0.actId, Activity157Enum.ConstId.FactoryRepairPartItem) and string.splitToNumber(slot2, "#") and CurrencyConfig.instance:getCurrencyCo(slot3[2]) and slot4.icon then
		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imagerepairicon, slot5 .. "_1", true)
	end

	RedDotController.instance:addRedDot(slot0._goberepairedreddot, RedDotEnum.DotNode.V1a8DungeonFactoryCanRepair, slot0.componentId)
end

function slot0.addEventListeners(slot0)
	slot0._btnrepair:AddClickListener(slot0._btnrepairOnClick, slot0)
	slot0._btnpart:AddClickListener(slot0._btnpartOnClick, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnrepair:RemoveClickListener()
	slot0._btnpart:RemoveClickListener()
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
end

function slot0._btnrepairOnClick(slot0)
	if Activity157Model.instance:isCanRepairComponent(slot0.componentId) then
		Activity157Controller.instance:enterFactoryRepairGame(slot0.componentId)
	else
		GameFacade.showToast(ToastEnum.V1a8Activity157RepairNotEnoughItem)
	end
end

function slot0._btnpartOnClick(slot0)
	if not Activity157Model.instance:isRepairComponent(slot0.componentId) then
		GameFacade.showToast(ToastEnum.V1a8Activity157NotRepairPreComponent)
	end
end

function slot0._onCurrencyChange(slot0, slot1)
	if not slot1[CurrencyEnum.CurrencyType.V1a8FactoryPart] then
		return
	end

	slot0:refreshRepairTip()
end

function slot0.refresh(slot0)
	if Activity157Model.instance:isRepairComponent(slot0.componentId) then
		if Activity157Model.instance:getHasPlayedAnim(VersionActivity1_8DungeonEnum.PlayerPrefsKey.IsPlayedFactoryComponentUnlockANim .. slot0.componentId) then
			slot0:setUnlocked()
		else
			slot0:playUnlockAnim(slot2)
		end
	else
		slot0:refreshLockedStatus()
	end
end

function slot0.setUnlocked(slot0)
	gohelper.setActive(slot0._gonormal, true)
	gohelper.setActive(slot0._golock, false)
	gohelper.setActive(slot0._gobtnpart, false)
end

function slot0.refreshLockedStatus(slot0)
	slot1 = Activity157Model.instance:isPreComponentRepaired(slot0.componentId)

	gohelper.setActive(slot0._gonormal, false)
	gohelper.setActive(slot0._golock, true)
	gohelper.setActive(slot0._golockicon, not slot1)
	gohelper.setActive(slot0._gobtnpart, not slot1)
	gohelper.setActive(slot0._goberepaired, slot1)

	if slot1 then
		slot0:refreshRepairTip()
	end
end

function slot0.refreshRepairTip(slot0)
	slot1, slot2, slot3 = Activity157Config.instance:getComponentUnlockCondition(slot0.actId, slot0.componentId)
	slot5 = "#F5744D"

	if slot3 and slot3 <= ItemModel.instance:getItemQuantity(slot1, slot2) then
		slot5 = "#88CB7F"

		ZProj.UGUIHelper.SetGrayscale(slot0._btnrepair.gameObject, false)
	else
		ZProj.UGUIHelper.SetGrayscale(slot0._btnrepair.gameObject, true)
	end

	slot0._txtrepairtip.text = string.format("<color=%s>%s</color>/%s", slot5, slot4, slot3 or 0)
end

function slot0.playUnlockAnim(slot0, slot1)
	if not slot0.componentId then
		return
	end

	slot0:refreshLockedStatus()
	slot0._statusAnimator:Play("unlock", 0, 0)
	Activity157Model.instance:setHasPlayedAnim(slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.Act157UnlockFactoryComponent)
	TaskDispatcher.cancelTask(slot0.setUnlocked, slot0)
	TaskDispatcher.runDelay(slot0.setUnlocked, slot0, uv0)
end

function slot0.destroy(slot0)
	TaskDispatcher.cancelTask(slot0.setUnlocked, slot0)
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0.setUnlocked, slot0)
end

return slot0
