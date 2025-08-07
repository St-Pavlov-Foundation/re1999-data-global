module("modules.logic.sp01.assassin2.outside.view.AssassinBuildingLevelUpListItem", package.seeall)

local var_0_0 = class("AssassinBuildingLevelUpListItem", LuaCompBase)
local var_0_1 = "#FFFFFF"
local var_0_2 = "#F54623"
local var_0_3 = "AssassinBuildingLevelUpListItem"
local var_0_4 = 0.3

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._godone = gohelper.findChild(arg_1_0.go, "go_done")
	arg_1_0._golock = gohelper.findChild(arg_1_0.go, "go_lock")
	arg_1_0._gounlock = gohelper.findChild(arg_1_0.go, "go_unlock")
	arg_1_0._gounlockeffects = gohelper.findChild(arg_1_0.go, "go_unlock/go_effects")
	arg_1_0._golockeffects = gohelper.findChild(arg_1_0.go, "go_lock/go_effects")
	arg_1_0._godoneeffects = gohelper.findChild(arg_1_0.go, "go_done/go_effects")
	arg_1_0._goeffectitem = gohelper.findChild(arg_1_0.go, "go_effectitem")
	arg_1_0._btnlevelup = gohelper.findChildButtonWithAudio(arg_1_0.go, "go_unlock/btn_levelup", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._gocost = gohelper.findChild(arg_1_0.go, "go_unlock/go_cost")
	arg_1_0._gocostitem = gohelper.findChild(arg_1_0.go, "go_unlock/go_cost/go_costitem")
	arg_1_0._txtcostnum = gohelper.findChildText(arg_1_0.go, "go_unlock/go_cost/go_costitem/txt_num")
	arg_1_0._simagecosticon = gohelper.findChildSingleImage(arg_1_0.go, "go_unlock/go_cost/go_costitem/txt_num/image_icon")
	arg_1_0._txtlv1 = gohelper.findChildText(arg_1_0.go, "go_done/level/txt_Lv1")
	arg_1_0._txtlv2 = gohelper.findChildText(arg_1_0.go, "go_lock/level/txt_Lv2")
	arg_1_0._txtpreLv = gohelper.findChildText(arg_1_0.go, "go_unlock/level/txt_preLv")
	arg_1_0._txtnextLv = gohelper.findChildText(arg_1_0.go, "go_unlock/level/txt_nextLv")
	arg_1_0._golevelupeffect = gohelper.findChild(arg_1_0.go, "go_unlock/#leveing")
	arg_1_0._gounlocktips = gohelper.findChildText(arg_1_0.go, "go_lock/#go_unlockTips")
	arg_1_0._txtunlocktips = gohelper.findChildText(arg_1_0.go, "go_lock/#go_unlockTips/#txt_unlockTips")
	arg_1_0._rewardItemTab = arg_1_0:getUserDataTb_()
	arg_1_0._rewardItemParentMap = arg_1_0:getUserDataTb_()
	arg_1_0._rewardItemParentMap[AssassinEnum.BuildingStatus.Locked] = arg_1_0._golockeffects
	arg_1_0._rewardItemParentMap[AssassinEnum.BuildingStatus.Unlocked] = arg_1_0._gounlockeffects
	arg_1_0._rewardItemParentMap[AssassinEnum.BuildingStatus.LevelUp] = arg_1_0._godoneeffects
	arg_1_0._animator = gohelper.onceAddComponent(arg_1_0.go, gohelper.Type_Animator)
	arg_1_0._canvasgroup = gohelper.onceAddComponent(arg_1_0.go, gohelper.Type_CanvasGroup)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnlevelup:AddClickListener(arg_2_0._btnlevelupOnClick, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.UpdateCoinNum, arg_2_0.refresh, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnlevelup:RemoveClickListener()
end

function var_0_0._btnlevelupOnClick(arg_4_0)
	if arg_4_0._status ~= AssassinEnum.BuildingStatus.Unlocked then
		return
	end

	local var_4_0, var_4_1 = arg_4_0._mapMo:isBuildingLevelUp2NextLv(arg_4_0._type)

	if not var_4_0 then
		GameFacade.showToast(ToastEnum.CurrencyNotEnough)

		return
	end

	AssassinController.instance:dispatchEvent(AssassinEvent.OnLevelUpBuilding)

	arg_4_0._levelUpFlow = FlowSequence.New()

	arg_4_0._levelUpFlow:addWork(FunctionWork.New(arg_4_0._lockScreen, arg_4_0, true))
	arg_4_0._levelUpFlow:addWork(FunctionWork.New(arg_4_0._playAnim, arg_4_0, arg_4_0:_createAnimParam("leveup", nil, AudioEnum2_9.Dungeon.play_ui_unlockMode)))
	arg_4_0._levelUpFlow:addWork(DelayDoFuncWork.New(arg_4_0._sendRpc2LevelUpBuilding, arg_4_0, var_0_4, var_4_1))
	arg_4_0._levelUpFlow:addWork(FunctionWork.New(arg_4_0._playAnim, arg_4_0, arg_4_0:_createAnimParam("open", 1)))
	arg_4_0._levelUpFlow:addWork(FunctionWork.New(arg_4_0._lockScreen, arg_4_0, false))
	arg_4_0._levelUpFlow:start()
end

function var_0_0._playAnim(arg_5_0, arg_5_1)
	if not arg_5_1 or string.nilorempty(arg_5_1.name) then
		return
	end

	arg_5_0._animator:Play(arg_5_1.name, 0, arg_5_1.normalizedTime)

	if arg_5_1.audioId then
		AudioMgr.instance:trigger(arg_5_1.audioId)
	end
end

function var_0_0._createAnimParam(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_2 = arg_6_2 or 0

	return {
		name = arg_6_1,
		normalizedTime = arg_6_2,
		audioId = arg_6_3
	}
end

function var_0_0._sendRpc2LevelUpBuilding(arg_7_0, arg_7_1)
	AssassinOutSideRpc.instance:sendBuildingLevelUpRequest(arg_7_1, function(arg_8_0, arg_8_1)
		if arg_8_1 ~= 0 then
			return
		end

		local var_8_0 = {
			buildingType = arg_7_0._type
		}

		ViewMgr.instance:openView(ViewName.AssassinBuildingLevelUpSuccessView, var_8_0)
	end)
end

function var_0_0._destroyLevelUpFlow(arg_9_0)
	if arg_9_0._levelUpFlow then
		arg_9_0._levelUpFlow:destroy()

		arg_9_0._levelUpFlow = nil
	end
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:_lockScreen(false)
	arg_10_0:_destroyLevelUpFlow()

	arg_10_0._config = arg_10_1
	arg_10_0._index = arg_10_2

	arg_10_0:checkIsNeedPlayOpenAnim()
	arg_10_0:refresh()
end

function var_0_0.refresh(arg_11_0)
	arg_11_0:refreshStatus()
	arg_11_0:refreshRewards()
	arg_11_0:refreshCosts()
end

function var_0_0.refreshStatus(arg_12_0)
	arg_12_0._mapMo = AssassinOutsideModel.instance:getBuildingMapMo()
	arg_12_0._status = arg_12_0._mapMo:getBuildingStatus(arg_12_0._config.id)
	arg_12_0._type = arg_12_0._config.type
	arg_12_0._level = arg_12_0._config.level

	gohelper.setActive(arg_12_0._godone, arg_12_0._status == AssassinEnum.BuildingStatus.LevelUp)
	gohelper.setActive(arg_12_0._golock, arg_12_0._status == AssassinEnum.BuildingStatus.Locked)
	gohelper.setActive(arg_12_0._gounlock, arg_12_0._status == AssassinEnum.BuildingStatus.Unlocked)

	arg_12_0._txtlv1.text = arg_12_0._level
	arg_12_0._txtlv2.text = arg_12_0._level
	arg_12_0._txtpreLv.text = arg_12_0._level - 1
	arg_12_0._txtnextLv.text = arg_12_0._level

	local var_12_0 = arg_12_0._mapMo:isBuildingLevelUp2NextLv(arg_12_0._type)

	gohelper.setActive(arg_12_0._golevelupeffect, var_12_0)

	if arg_12_0._status == AssassinEnum.BuildingStatus.Locked then
		arg_12_0._txtunlocktips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("assassinbuildinglevelupview_unlocktips"), arg_12_0._config.unlockDesc)
	end
end

function var_0_0.refreshRewards(arg_13_0)
	arg_13_0._descList = string.split(arg_13_0._config.desc, "#")
	arg_13_0._effectDescList = string.split(arg_13_0._config.effectDesc, "#")
	arg_13_0._effectIconUrlList = string.split(arg_13_0._config.itemIcon, "#")

	local var_13_0 = {}
	local var_13_1 = arg_13_0._rewardItemParentMap[arg_13_0._status]

	for iter_13_0 = 1, #arg_13_0._descList do
		local var_13_2 = arg_13_0:_getOrCreateSingleRewardItem(iter_13_0, var_13_1)

		arg_13_0:_refreshSingleRewardItem(var_13_2, arg_13_0._descList[iter_13_0], arg_13_0._effectDescList[iter_13_0], arg_13_0._effectIconUrlList[iter_13_0], iter_13_0)

		var_13_0[var_13_2] = true
	end

	for iter_13_1, iter_13_2 in pairs(arg_13_0._rewardItemTab) do
		if not var_13_0[iter_13_2] then
			gohelper.setActive(iter_13_2.go, false)
		end
	end
end

function var_0_0._getOrCreateSingleRewardItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0._rewardItemTab[arg_14_1]

	if not var_14_0 then
		var_14_0 = arg_14_0:getUserDataTb_()
		var_14_0.go = gohelper.clone(arg_14_0._goeffectitem, arg_14_2, "effect_" .. arg_14_1)
		var_14_0.tran = var_14_0.go.transform
		var_14_0.txtdesc = gohelper.findChildText(var_14_0.go, "txt_desc")
		var_14_0.txteffectdesc = gohelper.findChildText(var_14_0.go, "txt_effectdesc")
		var_14_0.imageicon = gohelper.findChildImage(var_14_0.go, "image_icon")
		arg_14_0._rewardItemTab[arg_14_1] = var_14_0
	else
		var_14_0.tran:SetParent(arg_14_2.transform)
	end

	return var_14_0
end

function var_0_0._refreshSingleRewardItem(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	gohelper.setActive(arg_15_1.go, true)

	arg_15_1.txteffectdesc.text = arg_15_3
	arg_15_1.txtdesc.text = arg_15_2

	UISpriteSetMgr.instance:setSp01AssassinSprite(arg_15_1.imageicon, arg_15_4)
end

function var_0_0.refreshCosts(arg_16_0)
	local var_16_0 = AssassinController.instance:getCoinNum()
	local var_16_1 = arg_16_0._config.cost
	local var_16_2 = var_16_1 <= var_16_0

	arg_16_0._txtcostnum.text = var_16_1

	SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._txtcostnum, var_16_2 and var_0_1 or var_0_2)
end

function var_0_0._playOpenAnim(arg_17_0)
	arg_17_0:setVisible(true)
	arg_17_0:_lockScreen(false)
	arg_17_0:_playAnim(arg_17_0:_createAnimParam("open"))
	AssassinBuildingLevelUpListModel.instance:onItemPlayOpenAnimDone()
end

function var_0_0.checkIsNeedPlayOpenAnim(arg_18_0)
	local var_18_0 = AssassinBuildingLevelUpListModel.instance:getNeedPlayOpenAnimItemCount() >= arg_18_0._index

	arg_18_0:setVisible(not var_18_0)

	if var_18_0 then
		arg_18_0:_lockScreen(true)
		TaskDispatcher.cancelTask(arg_18_0._playOpenAnim, arg_18_0)
		TaskDispatcher.runDelay(arg_18_0._playOpenAnim, arg_18_0, AssassinEnum.BuildingDelayOpenAnim * (arg_18_0._index - 1))
	end
end

function var_0_0._lockScreen(arg_19_0, arg_19_1)
	AssassinHelper.lockScreen(var_0_3, arg_19_1)
end

function var_0_0.setVisible(arg_20_0, arg_20_1)
	arg_20_0._canvasgroup.alpha = arg_20_1 and 1 or 0
	arg_20_0._canvasgroup.interactable = arg_20_1
	arg_20_0._canvasgroup.blocksRaycasts = arg_20_1
end

function var_0_0.onDestroy(arg_21_0)
	arg_21_0._simagecosticon:UnLoadImage()
	arg_21_0:_lockScreen(false)
	arg_21_0:_destroyLevelUpFlow()
	TaskDispatcher.cancelTask(arg_21_0._playOpenAnim, arg_21_0)
end

return var_0_0
