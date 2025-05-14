module("modules.logic.versionactivity1_8.dungeon.view.factory.VersionActivity1_8FactoryBlueprintPartItem", package.seeall)

local var_0_0 = class("VersionActivity1_8FactoryBlueprintPartItem", LuaCompBase)
local var_0_1 = 0.87

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.actId = Activity157Model.instance:getActId()
	arg_1_0.componentId = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.trans = arg_2_0.go.transform
	arg_2_0._statusAnimator = gohelper.findChildComponent(arg_2_0.go, "status", typeof(UnityEngine.Animator))
	arg_2_0._golock = gohelper.findChild(arg_2_0.go, "status/#go_lock")
	arg_2_0._golockicon = gohelper.findChild(arg_2_0.go, "status/#go_lock/#go_lockedicon")
	arg_2_0._goberepaired = gohelper.findChild(arg_2_0.go, "status/#go_lock/#go_berepaired")
	arg_2_0._btnrepair = gohelper.findChildClickWithDefaultAudio(arg_2_0.go, "status/#go_lock/#go_berepaired/#btn_repair")
	arg_2_0._goberepairedreddot = gohelper.findChild(arg_2_0.go, "status/#go_lock/#go_berepaired/#go_reddot")
	arg_2_0._txtrepairtip = gohelper.findChildText(arg_2_0.go, "status/#go_lock/#go_berepaired/bg/#txt_num")
	arg_2_0._imagerepairicon = gohelper.findChildImage(arg_2_0.go, "status/#go_lock/#go_berepaired/bg/icon")
	arg_2_0._gonormal = gohelper.findChild(arg_2_0.go, "status/#go_normal")
	arg_2_0._btnpart = gohelper.findChildClickWithDefaultAudio(arg_2_0.go, "#btn_part")
	arg_2_0._gobtnpart = arg_2_0._btnpart.gameObject

	local var_2_0 = Activity157Config.instance:getAct157Const(arg_2_0.actId, Activity157Enum.ConstId.FactoryRepairPartItem)
	local var_2_1 = var_2_0 and string.splitToNumber(var_2_0, "#")

	if var_2_1 then
		local var_2_2 = CurrencyConfig.instance:getCurrencyCo(var_2_1[2])
		local var_2_3 = var_2_2 and var_2_2.icon

		if var_2_3 then
			UISpriteSetMgr.instance:setCurrencyItemSprite(arg_2_0._imagerepairicon, var_2_3 .. "_1", true)
		end
	end

	RedDotController.instance:addRedDot(arg_2_0._goberepairedreddot, RedDotEnum.DotNode.V1a8DungeonFactoryCanRepair, arg_2_0.componentId)
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnrepair:AddClickListener(arg_3_0._btnrepairOnClick, arg_3_0)
	arg_3_0._btnpart:AddClickListener(arg_3_0._btnpartOnClick, arg_3_0)
	arg_3_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0._onCurrencyChange, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnrepair:RemoveClickListener()
	arg_4_0._btnpart:RemoveClickListener()
	arg_4_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_4_0._onCurrencyChange, arg_4_0)
end

function var_0_0._btnrepairOnClick(arg_5_0)
	if Activity157Model.instance:isCanRepairComponent(arg_5_0.componentId) then
		Activity157Controller.instance:enterFactoryRepairGame(arg_5_0.componentId)
	else
		GameFacade.showToast(ToastEnum.V1a8Activity157RepairNotEnoughItem)
	end
end

function var_0_0._btnpartOnClick(arg_6_0)
	if not Activity157Model.instance:isRepairComponent(arg_6_0.componentId) then
		GameFacade.showToast(ToastEnum.V1a8Activity157NotRepairPreComponent)
	end
end

function var_0_0._onCurrencyChange(arg_7_0, arg_7_1)
	if not arg_7_1[CurrencyEnum.CurrencyType.V1a8FactoryPart] then
		return
	end

	arg_7_0:refreshRepairTip()
end

function var_0_0.refresh(arg_8_0)
	if Activity157Model.instance:isRepairComponent(arg_8_0.componentId) then
		local var_8_0 = VersionActivity1_8DungeonEnum.PlayerPrefsKey.IsPlayedFactoryComponentUnlockANim .. arg_8_0.componentId

		if Activity157Model.instance:getHasPlayedAnim(var_8_0) then
			arg_8_0:setUnlocked()
		else
			arg_8_0:playUnlockAnim(var_8_0)
		end
	else
		arg_8_0:refreshLockedStatus()
	end
end

function var_0_0.setUnlocked(arg_9_0)
	gohelper.setActive(arg_9_0._gonormal, true)
	gohelper.setActive(arg_9_0._golock, false)
	gohelper.setActive(arg_9_0._gobtnpart, false)
end

function var_0_0.refreshLockedStatus(arg_10_0)
	local var_10_0 = Activity157Model.instance:isPreComponentRepaired(arg_10_0.componentId)

	gohelper.setActive(arg_10_0._gonormal, false)
	gohelper.setActive(arg_10_0._golock, true)
	gohelper.setActive(arg_10_0._golockicon, not var_10_0)
	gohelper.setActive(arg_10_0._gobtnpart, not var_10_0)
	gohelper.setActive(arg_10_0._goberepaired, var_10_0)

	if var_10_0 then
		arg_10_0:refreshRepairTip()
	end
end

function var_0_0.refreshRepairTip(arg_11_0)
	local var_11_0, var_11_1, var_11_2 = Activity157Config.instance:getComponentUnlockCondition(arg_11_0.actId, arg_11_0.componentId)
	local var_11_3 = ItemModel.instance:getItemQuantity(var_11_0, var_11_1)
	local var_11_4 = "#F5744D"

	if var_11_2 and var_11_2 <= var_11_3 then
		var_11_4 = "#88CB7F"

		ZProj.UGUIHelper.SetGrayscale(arg_11_0._btnrepair.gameObject, false)
	else
		ZProj.UGUIHelper.SetGrayscale(arg_11_0._btnrepair.gameObject, true)
	end

	arg_11_0._txtrepairtip.text = string.format("<color=%s>%s</color>/%s", var_11_4, var_11_3, var_11_2 or 0)
end

function var_0_0.playUnlockAnim(arg_12_0, arg_12_1)
	if not arg_12_0.componentId then
		return
	end

	arg_12_0:refreshLockedStatus()
	arg_12_0._statusAnimator:Play("unlock", 0, 0)
	Activity157Model.instance:setHasPlayedAnim(arg_12_1)
	AudioMgr.instance:trigger(AudioEnum.UI.Act157UnlockFactoryComponent)
	TaskDispatcher.cancelTask(arg_12_0.setUnlocked, arg_12_0)
	TaskDispatcher.runDelay(arg_12_0.setUnlocked, arg_12_0, var_0_1)
end

function var_0_0.destroy(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0.setUnlocked, arg_13_0)
end

function var_0_0.onDestroy(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0.setUnlocked, arg_14_0)
end

return var_0_0
