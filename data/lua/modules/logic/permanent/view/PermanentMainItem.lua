module("modules.logic.permanent.view.PermanentMainItem", package.seeall)

local var_0_0 = class("PermanentMainItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._btnClick = gohelper.findChildButtonWithAudio(arg_1_0._go, "Root/click")
	arg_1_0._goNormal = gohelper.findChild(arg_1_0._go, "Root/#go_Normal")
	arg_1_0._simagekv = gohelper.findChildSingleImage(arg_1_0._go, "Root/#go_Normal/#simage_kv")
	arg_1_0._txtname = gohelper.findChildTextMesh(arg_1_0._go, "Root/#go_Normal/#txt_name")
	arg_1_0._txtnameen = gohelper.findChildTextMesh(arg_1_0._go, "Root/#go_Normal/#txt_name_en")
	arg_1_0._goallget = gohelper.findChild(arg_1_0._go, "Root/#go_Normal/#go_allget")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0._go, "Root/#go_Normal/#go_reddot")
	arg_1_0._goLocked = gohelper.findChild(arg_1_0._go, "Root/#go_Locked")
	arg_1_0._simagekvL = gohelper.findChildSingleImage(arg_1_0._go, "Root/#go_Locked/#simage_kv")
	arg_1_0._txtnameL = gohelper.findChildTextMesh(arg_1_0._go, "Root/#go_Locked/#txt_name")
	arg_1_0._txtnameenL = gohelper.findChildTextMesh(arg_1_0._go, "Root/#go_Locked/#txt_name_en")
	arg_1_0._imagePropItem = gohelper.findChildImage(arg_1_0._goLocked, "image_LockedTextBG/#image_PropItem")
	arg_1_0._txtPropNum = gohelper.findChildTextMesh(arg_1_0._goLocked, "image_LockedTextBG/#txt_PropNum")
	arg_1_0._goEmpty = gohelper.findChild(arg_1_0._go, "Root/#go_Empty")
	arg_1_0._gonew = gohelper.findChild(arg_1_0._go, "Root/#go_Locked/#go_new")

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_1_0._imagePropItem, "216_1")

	local var_1_0 = CommonConfig.instance:getConstStr(ConstEnum.PermanentUnlockCost)
	local var_1_1 = string.splitToNumber(var_1_0, "#")

	arg_1_0.cost = {
		type = var_1_1[1],
		id = var_1_1[2],
		quantity = var_1_1[3] or 0
	}
	arg_1_0._root = gohelper.findChild(arg_1_0._go, "Root")
	arg_1_0.animator = arg_1_0._root:GetComponent(gohelper.Type_Animator)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnClick:AddClickListener(arg_2_0._btnOnClick, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0._onCurrencyChange, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.UnlockPermanent, arg_2_0._onUnlcokPermanent, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.GetActivityInfoWithParamSuccess, arg_2_0._refreshAllGetFlag, arg_2_0)
	arg_2_0:addEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, arg_2_0.refreshRedDot, arg_2_0, LuaEventSystem.Low)
	arg_2_0:addEventCb(Activity165Controller.instance, Activity165Event.refreshStoryReddot, arg_2_0._onRefreshStoryReddot, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnClick:RemoveClickListener()
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0._onCurrencyChange, arg_3_0)
	arg_3_0:removeEventCb(ActivityController.instance, ActivityEvent.UnlockPermanent, arg_3_0._onUnlcokPermanent, arg_3_0)
	arg_3_0:removeEventCb(ActivityController.instance, ActivityEvent.GetActivityInfoWithParamSuccess, arg_3_0._refreshAllGetFlag, arg_3_0)
	arg_3_0:removeEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, arg_3_0.refreshRedDot, arg_3_0)
	arg_3_0:removeEventCb(Activity165Controller.instance, Activity165Event.refreshStoryReddot, arg_3_0._onRefreshStoryReddot, arg_3_0)
end

function var_0_0.refreshRedDot(arg_4_0)
	if not arg_4_0.notEventRedDot then
		return
	end

	arg_4_0.notEventRedDot:refreshRedDot()
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0._mo = arg_5_1

	if arg_5_1.id == -999 then
		gohelper.setActive(arg_5_0._goEmpty, true)
		gohelper.setActive(arg_5_0._goNormal, false)
		gohelper.setActive(arg_5_0._goLocked, false)

		if arg_5_0._view.playOpen then
			arg_5_0.animator:Play(UIAnimationName.Open)
		end

		return
	end

	local var_5_0 = arg_5_1.config.id
	local var_5_1 = PermanentConfig.instance:getKvIconName(arg_5_1.id)

	arg_5_0._simagekv:LoadImage(ResUrl.getPermanentSingleBg(var_5_1))

	arg_5_0._txtname.text = arg_5_1.config.name
	arg_5_0._txtnameen.text = arg_5_1.config.nameEn

	arg_5_0._simagekvL:LoadImage(ResUrl.getPermanentSingleBg(var_5_1))

	arg_5_0._txtnameL.text = arg_5_1.config.name
	arg_5_0._txtnameenL.text = arg_5_1.config.nameEn

	if arg_5_1.config.redDotId ~= 0 then
		RedDotController.instance:addRedDot(arg_5_0._goreddot, arg_5_1.config.redDotId)
	elseif var_5_0 == VersionActivity2_1Enum.ActivityId.EnterView then
		arg_5_0.notEventRedDot = RedDotController.instance:addNotEventRedDot(arg_5_0._goreddot, arg_5_0._v2a1_checkNotEventReddotShow, arg_5_0)
	else
		arg_5_0.notEventRedDot = RedDotController.instance:addNotEventRedDot(arg_5_0._goreddot, arg_5_0._checkNotEventReddotShow, arg_5_0)
	end

	arg_5_0:_refreshState()
	arg_5_0:_refreshCost()
end

function var_0_0._checkNotEventReddotShow(arg_6_0)
	local var_6_0 = false
	local var_6_1 = ActivityConfig.instance:getPermanentChildActList(arg_6_0._mo.id)

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		local var_6_2 = ActivityConfig.instance:getActivityCo(iter_6_1)

		if RedDotModel.instance:isDotShow(var_6_2.redDotId, iter_6_1) then
			var_6_0 = true

			break
		end
	end

	return var_6_0
end

function var_0_0.onDestroy(arg_7_0)
	arg_7_0._simagekv:UnLoadImage()
	arg_7_0._simagekvL:UnLoadImage()
	TaskDispatcher.cancelTask(arg_7_0._onUnlcokPermanent, arg_7_0)
end

function var_0_0._refreshState(arg_8_0)
	if arg_8_0._view.playOpen then
		arg_8_0.animator:Play(UIAnimationName.Open)
	end

	local var_8_0 = PermanentModel.instance:isActivityLocalRead(arg_8_0._mo.id)

	gohelper.setActive(arg_8_0._gonew, not var_8_0)

	if not var_8_0 then
		PermanentModel.instance:setActivityLocalRead(arg_8_0._mo.id)
		RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
			[arg_8_0._mo.config.redDotId] = true
		})
	end

	arg_8_0:_refreshAllGetFlag()
	gohelper.setActive(arg_8_0._goEmpty, false)
	gohelper.setActive(arg_8_0._goNormal, arg_8_0._mo.permanentUnlock)
	gohelper.setActive(arg_8_0._goLocked, not arg_8_0._mo.permanentUnlock)
end

function var_0_0._refreshCost(arg_9_0)
	local var_9_0 = CurrencyModel.instance:getCurrency(arg_9_0.cost.id)
	local var_9_1 = var_9_0 and var_9_0.quantity or 0

	if var_9_1 >= arg_9_0.cost.quantity then
		arg_9_0._txtPropNum.text = string.format(string.format("%s/%s", var_9_1, arg_9_0.cost.quantity))
	else
		arg_9_0._txtPropNum.text = string.format(string.format("<color=#d97373>%s</color>/%s", var_9_1, arg_9_0.cost.quantity))
	end
end

function var_0_0._btnOnClick(arg_10_0)
	if arg_10_0._mo.id == -999 then
		return
	end

	if arg_10_0._mo.permanentUnlock then
		if OptionPackageController.instance:checkNeedDownload(OptionPackageEnum.Package.VersionActivity) then
			return
		end

		PermanentController.instance:enterActivity(arg_10_0._mo.id)
	else
		local var_10_0 = ItemModel.instance:getItemConfig(arg_10_0.cost.type, arg_10_0.cost.id)
		local var_10_1 = var_10_0 and var_10_0.name

		GameFacade.showMessageBox(MessageBoxIdDefine.PermanentUnlockConfirm, MsgBoxEnum.BoxType.Yes_No, arg_10_0._unlockCallback, nil, nil, arg_10_0, nil, nil, arg_10_0.cost.quantity, var_10_1, arg_10_0._mo.config.name)
	end
end

function var_0_0._unlockCallback(arg_11_0)
	local var_11_0 = {}

	table.insert(var_11_0, arg_11_0.cost)

	local var_11_1, var_11_2, var_11_3 = ItemModel.instance:hasEnoughItems(var_11_0)

	if var_11_2 then
		PermanentController.instance:unlockPermanent(arg_11_0._mo.id)
	else
		GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, var_11_3, var_11_1)
	end
end

function var_0_0._onCurrencyChange(arg_12_0)
	arg_12_0:_refreshCost()
end

function var_0_0._onUnlcokPermanent(arg_13_0, arg_13_1)
	if arg_13_0._mo.id == arg_13_1 then
		gohelper.setActive(arg_13_0._goNormal, true)
		arg_13_0.animator:Play("unlock", 0, 0)
		AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_permanent_unlock)
		UIBlockMgrExtend.instance.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("permanentUnlockAnim")
		TaskDispatcher.runDelay(arg_13_0.setPermanentUnlock, arg_13_0, 1.5)
	end
end

function var_0_0._refreshAllGetFlag(arg_14_0)
	local var_14_0 = ActivityModel.instance:isReceiveAllBonus(arg_14_0._mo.id)

	gohelper.setActive(arg_14_0._goallget, var_14_0)
end

function var_0_0.setPermanentUnlock(arg_15_0)
	gohelper.setActive(arg_15_0._goLocked, false)
	UIBlockMgr.instance:endBlock("permanentUnlockAnim")
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
end

function var_0_0.getAnimator(arg_16_0)
	return arg_16_0.animator
end

function var_0_0._v2a1_checkNotEventReddotShow(arg_17_0)
	return arg_17_0:_checkNotEventReddotShow() or PermanentModel.instance:IsDotShowPermanent2_1()
end

function var_0_0._onRefreshStoryReddot(arg_18_0)
	local var_18_0 = arg_18_0._mo

	if not var_18_0 then
		return
	end

	if not arg_18_0.notEventRedDot then
		return
	end

	if var_18_0.id == -999 then
		return
	end

	if not var_18_0.config then
		return
	end

	if var_18_0.config.id ~= VersionActivity2_1Enum.ActivityId.EnterView then
		return
	end

	arg_18_0.notEventRedDot:refreshRedDot()
end

return var_0_0
