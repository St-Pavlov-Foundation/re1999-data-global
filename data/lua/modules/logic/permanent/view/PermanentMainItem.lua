module("modules.logic.permanent.view.PermanentMainItem", package.seeall)

slot0 = class("PermanentMainItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._btnClick = gohelper.findChildButtonWithAudio(slot0._go, "Root/click")
	slot0._goNormal = gohelper.findChild(slot0._go, "Root/#go_Normal")
	slot0._simagekv = gohelper.findChildSingleImage(slot0._go, "Root/#go_Normal/#simage_kv")
	slot0._txtname = gohelper.findChildTextMesh(slot0._go, "Root/#go_Normal/#txt_name")
	slot0._txtnameen = gohelper.findChildTextMesh(slot0._go, "Root/#go_Normal/#txt_name_en")
	slot0._goallget = gohelper.findChild(slot0._go, "Root/#go_Normal/#go_allget")
	slot0._goreddot = gohelper.findChild(slot0._go, "Root/#go_Normal/#go_reddot")
	slot0._goLocked = gohelper.findChild(slot0._go, "Root/#go_Locked")
	slot0._simagekvL = gohelper.findChildSingleImage(slot0._go, "Root/#go_Locked/#simage_kv")
	slot0._txtnameL = gohelper.findChildTextMesh(slot0._go, "Root/#go_Locked/#txt_name")
	slot0._txtnameenL = gohelper.findChildTextMesh(slot0._go, "Root/#go_Locked/#txt_name_en")
	slot0._imagePropItem = gohelper.findChildImage(slot0._goLocked, "image_LockedTextBG/#image_PropItem")
	slot0._txtPropNum = gohelper.findChildTextMesh(slot0._goLocked, "image_LockedTextBG/#txt_PropNum")
	slot0._goEmpty = gohelper.findChild(slot0._go, "Root/#go_Empty")
	slot0._gonew = gohelper.findChild(slot0._go, "Root/#go_Locked/#go_new")

	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imagePropItem, "216_1")

	slot3 = string.splitToNumber(CommonConfig.instance:getConstStr(ConstEnum.PermanentUnlockCost), "#")
	slot0.cost = {
		type = slot3[1],
		id = slot3[2],
		quantity = slot3[3] or 0
	}
	slot0._root = gohelper.findChild(slot0._go, "Root")
	slot0.animator = slot0._root:GetComponent(gohelper.Type_Animator)
end

function slot0.addEventListeners(slot0)
	slot0._btnClick:AddClickListener(slot0._btnOnClick, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.UnlockPermanent, slot0._onUnlcokPermanent, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.GetActivityInfoWithParamSuccess, slot0._refreshAllGetFlag, slot0)
	slot0:addEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, slot0.refreshRedDot, slot0, LuaEventSystem.Low)
end

function slot0.removeEventListeners(slot0)
	slot0._btnClick:RemoveClickListener()
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
	slot0:removeEventCb(ActivityController.instance, ActivityEvent.UnlockPermanent, slot0._onUnlcokPermanent, slot0)
	slot0:removeEventCb(ActivityController.instance, ActivityEvent.GetActivityInfoWithParamSuccess, slot0._refreshAllGetFlag, slot0)
	slot0:removeEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, slot0.refreshRedDot, slot0)
end

function slot0.refreshRedDot(slot0)
	if not slot0.notEventRedDot then
		return
	end

	slot0.notEventRedDot:refreshRedDot()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	if slot1.id == -999 then
		gohelper.setActive(slot0._goEmpty, true)
		gohelper.setActive(slot0._goNormal, false)
		gohelper.setActive(slot0._goLocked, false)

		if slot0._view.playOpen then
			slot0.animator:Play(UIAnimationName.Open)
		end

		return
	end

	slot2 = PermanentConfig.instance:getKvIconName(slot1.id)

	slot0._simagekv:LoadImage(ResUrl.getPermanentSingleBg(slot2))

	slot0._txtname.text = slot1.config.name
	slot0._txtnameen.text = slot1.config.nameEn

	slot0._simagekvL:LoadImage(ResUrl.getPermanentSingleBg(slot2))

	slot0._txtnameL.text = slot1.config.name
	slot0._txtnameenL.text = slot1.config.nameEn

	if slot1.config.redDotId ~= 0 then
		RedDotController.instance:addRedDot(slot0._goreddot, slot1.config.redDotId)
	else
		slot0.notEventRedDot = RedDotController.instance:addNotEventRedDot(slot0._goreddot, slot0._checkNotEventReddotShow, slot0)
	end

	slot0:_refreshState()
	slot0:_refreshCost()
end

function slot0._checkNotEventReddotShow(slot0)
	slot1 = false

	for slot6, slot7 in ipairs(ActivityConfig.instance:getPermanentChildActList(slot0._mo.id)) do
		if RedDotModel.instance:isDotShow(ActivityConfig.instance:getActivityCo(slot7).redDotId, slot7) then
			slot1 = true

			break
		end
	end

	return slot1
end

function slot0.onDestroy(slot0)
	slot0._simagekv:UnLoadImage()
	slot0._simagekvL:UnLoadImage()
	TaskDispatcher.cancelTask(slot0._onUnlcokPermanent, slot0)
end

function slot0._refreshState(slot0)
	if slot0._view.playOpen then
		slot0.animator:Play(UIAnimationName.Open)
	end

	slot1 = PermanentModel.instance:isActivityLocalRead(slot0._mo.id)

	gohelper.setActive(slot0._gonew, not slot1)

	if not slot1 then
		PermanentModel.instance:setActivityLocalRead(slot0._mo.id)
		RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
			[slot0._mo.config.redDotId] = true
		})
	end

	slot0:_refreshAllGetFlag()
	gohelper.setActive(slot0._goEmpty, false)
	gohelper.setActive(slot0._goNormal, slot0._mo.permanentUnlock)
	gohelper.setActive(slot0._goLocked, not slot0._mo.permanentUnlock)
end

function slot0._refreshCost(slot0)
	if slot0.cost.quantity <= (CurrencyModel.instance:getCurrency(slot0.cost.id) and slot1.quantity or 0) then
		slot0._txtPropNum.text = string.format(string.format("%s/%s", slot2, slot0.cost.quantity))
	else
		slot0._txtPropNum.text = string.format(string.format("<color=#d97373>%s</color>/%s", slot2, slot0.cost.quantity))
	end
end

function slot0._btnOnClick(slot0)
	if slot0._mo.id == -999 then
		return
	end

	if slot0._mo.permanentUnlock then
		if OptionPackageController.instance:checkNeedDownload(OptionPackageEnum.Package.VersionActivity) then
			return
		end

		PermanentController.instance:enterActivity(slot0._mo.id)
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.PermanentUnlockConfirm, MsgBoxEnum.BoxType.Yes_No, slot0._unlockCallback, nil, , slot0, nil, , slot0.cost.quantity, ItemModel.instance:getItemConfig(slot0.cost.type, slot0.cost.id) and slot1.name, slot0._mo.config.name)
	end
end

function slot0._unlockCallback(slot0)
	slot1 = {}

	table.insert(slot1, slot0.cost)

	slot2, slot3, slot4 = ItemModel.instance:hasEnoughItems(slot1)

	if slot3 then
		PermanentController.instance:unlockPermanent(slot0._mo.id)
	else
		GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, slot4, slot2)
	end
end

function slot0._onCurrencyChange(slot0)
	slot0:_refreshCost()
end

function slot0._onUnlcokPermanent(slot0, slot1)
	if slot0._mo.id == slot1 then
		gohelper.setActive(slot0._goNormal, true)
		slot0.animator:Play("unlock", 0, 0)
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_permanent_unlock)
		UIBlockMgrExtend.instance.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("permanentUnlockAnim")
		TaskDispatcher.runDelay(slot0.setPermanentUnlock, slot0, 1.5)
	end
end

function slot0._refreshAllGetFlag(slot0)
	gohelper.setActive(slot0._goallget, ActivityModel.instance:isReceiveAllBonus(slot0._mo.id))
end

function slot0.setPermanentUnlock(slot0)
	gohelper.setActive(slot0._goLocked, false)
	UIBlockMgr.instance:endBlock("permanentUnlockAnim")
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
end

function slot0.getAnimator(slot0)
	return slot0.animator
end

return slot0
