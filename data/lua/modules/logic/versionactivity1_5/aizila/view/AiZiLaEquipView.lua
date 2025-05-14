module("modules.logic.versionactivity1_5.aizila.view.AiZiLaEquipView", package.seeall)

local var_0_0 = class("AiZiLaEquipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_PanelBG")
	arg_1_0._goequipitem = gohelper.findChild(arg_1_0.viewGO, "Left/Sticker1/#go_equipitem")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "Right/#txt_Title")
	arg_1_0._txtEffect = gohelper.findChildText(arg_1_0.viewGO, "Right/#txt_Effect")
	arg_1_0._txtNextEffect = gohelper.findChildText(arg_1_0.viewGO, "Right/#txt_Effect/#txt_NextEffect")
	arg_1_0._goLv = gohelper.findChild(arg_1_0.viewGO, "Right/#go_Lv")
	arg_1_0._txtlevel = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_Lv/#txt_level")
	arg_1_0._txtnextlevel = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_Lv/#txt_nextlevel")
	arg_1_0._scrolluplevelItem = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/#go_Lv/#scroll_uplevelItem")
	arg_1_0._gouplevelItems = gohelper.findChild(arg_1_0.viewGO, "Right/#go_Lv/#scroll_uplevelItem/Viewport/#go_uplevelItems")
	arg_1_0._btnuplevel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_Lv/Btn/#btn_uplevel")
	arg_1_0._goRedPoint = gohelper.findChild(arg_1_0.viewGO, "Right/#go_Lv/Btn/#btn_uplevel/#go_RedPoint")
	arg_1_0._btnunUplevel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_Lv/Btn/#btn_unUplevel")
	arg_1_0._goLvMax = gohelper.findChild(arg_1_0.viewGO, "Right/#go_LvMax")
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "#go_BackBtns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnuplevel:AddClickListener(arg_2_0._btnuplevelOnClick, arg_2_0)
	arg_2_0._btnunUplevel:AddClickListener(arg_2_0._btnunUplevelOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnuplevel:RemoveClickListener()
	arg_3_0._btnunUplevel:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	return
end

function var_0_0._btnuplevelOnClick(arg_5_0)
	if arg_5_0._isLockUpLevel then
		GameFacade.showToast(ToastEnum.V1a5AiZiLaUpLevelInGame)

		return
	end

	local var_5_0 = arg_5_0._equipCfg or arg_5_0._nextEquipCfg

	if var_5_0 and var_5_0.equipId and not arg_5_0:_isLockType(var_5_0.typeId) then
		arg_5_0:_setLockType(var_5_0.typeId, 0.5)
		Activity144Rpc.instance:sendAct144UpgradeEquipRequest(arg_5_0._actId, var_5_0.equipId)
	end
end

function var_0_0._btnunUplevelOnClick(arg_6_0)
	GameFacade.showToast(arg_6_0._isLockUpLevel and ToastEnum.V1a5AiZiLaUpLevelInGame or ToastEnum.V1a5AiZiLaUpLevelItemLack)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._animator = arg_7_0.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)
	arg_7_0._animatorRight = gohelper.findChildComponent(arg_7_0.viewGO, "Right", AiZiLaEnum.ComponentType.Animator)
	arg_7_0._equipItemList = {}
	arg_7_0._actId = VersionActivity1_5Enum.ActivityId.AiZiLa
	arg_7_0._equipCoTypeList = AiZiLaConfig.instance:getEquipCoTypeList(arg_7_0._actId)
	arg_7_0._upLevelNextTimeDic = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._equipCoTypeList) do
		local var_7_0 = gohelper.findChild(arg_7_0.viewGO, "Left/Sticker" .. iter_7_0)
		local var_7_1 = gohelper.clone(arg_7_0._goequipitem, var_7_0, "go_equipitem")
		local var_7_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_1, AiZiLaEquipItem, arg_7_0)

		if arg_7_0._selectTypeId == nil then
			arg_7_0._selectTypeId = iter_7_1.typeId
		end

		var_7_2:setCfg(iter_7_1)
		table.insert(arg_7_0._equipItemList, var_7_2)
	end

	gohelper.setActive(arg_7_0._goequipitem, false)

	arg_7_0._goodsItemGo = arg_7_0:getResInst(AiZiLaGoodsItem.prefabPath2, arg_7_0.viewGO)

	gohelper.setActive(arg_7_0._goodsItemGo, false)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._isLockUpLevel = ViewMgr.instance:isOpen(ViewName.AiZiLaGameView)

	if arg_9_0.viewContainer then
		NavigateMgr.instance:addEscape(arg_9_0.viewContainer.viewName, arg_9_0.closeThis, arg_9_0)
	end

	arg_9_0:addEventCb(AiZiLaController.instance, AiZiLaEvent.UISelectEquipType, arg_9_0._onSelectEquitType, arg_9_0)
	arg_9_0:addEventCb(AiZiLaController.instance, AiZiLaEvent.OnEquipUpLevel, arg_9_0._onEquipUpLevel, arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_forward_paper2)
	arg_9_0:refreshUI()
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._onDelayRefreshUI, arg_11_0)
end

function var_0_0._onEquipUpLevel(arg_12_0, arg_12_1)
	local var_12_0 = AiZiLaModel.instance:getCurActivityID()
	local var_12_1 = AiZiLaConfig.instance:getEquipCo(var_12_0, arg_12_1)

	if var_12_1 then
		if arg_12_0._selectTypeId == var_12_1.typeId and arg_12_0._animatorRight then
			arg_12_0:_refreshData()

			if not arg_12_0._isDelayRefreshUIIng then
				arg_12_0._isDelayRefreshUIIng = true

				arg_12_0._animatorRight:Play("refresh", 0, 0)
				arg_12_0:_setLockType(var_12_1.typeId, 0.53)
				TaskDispatcher.runDelay(arg_12_0._onDelayRefreshUI, arg_12_0, 0.5)
				AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_equip_update)
			end
		else
			arg_12_0:refreshUI()
		end

		arg_12_0:_refreshEquipItemUpLevel(var_12_1.typeId)
	else
		arg_12_0:refreshUI()
	end
end

function var_0_0._onDelayRefreshUI(arg_13_0)
	arg_13_0._isDelayRefreshUIIng = false

	arg_13_0:refreshUI()
end

function var_0_0._onSelectEquitType(arg_14_0, arg_14_1)
	arg_14_0._selectTypeId = arg_14_1

	arg_14_0:refreshUI()
end

function var_0_0._refreshData(arg_15_0)
	arg_15_0._selectEquipMO = AiZiLaModel.instance:getEquipMO(arg_15_0._selectTypeId)

	if arg_15_0._selectEquipMO then
		arg_15_0._equipCfg = arg_15_0._selectEquipMO:getConfig()
		arg_15_0._nextEquipCfg = arg_15_0._selectEquipMO:getNextConfig()
		arg_15_0._costparams = arg_15_0._selectEquipMO:getCostParams()
	else
		arg_15_0._equipCfg = nil
		arg_15_0._nextEquipCfg = arg_15_0:_findInitCfg(arg_15_0._selectTypeId)
		arg_15_0._costparams = AiZiLaHelper.getCostParams(arg_15_0._nextEquipCfg)
	end
end

function var_0_0.refreshUI(arg_16_0)
	arg_16_0:_refreshData()

	local var_16_0 = false

	if arg_16_0._selectEquipMO then
		var_16_0 = arg_16_0._selectEquipMO:isMaxLevel()
		arg_16_0._txtlevel.text = formatLuaLang("v1a5_aizila_level", arg_16_0._equipCfg.level)
		arg_16_0._txtEffect.text = formatLuaLang("v1a5_aizila_equip_effect", arg_16_0._equipCfg.effectDesc)
		arg_16_0._txtTitle.text = arg_16_0._equipCfg.name
	else
		arg_16_0._txtlevel.text = luaLang("v1a5_aizila_nolevel")
		arg_16_0._txtEffect.text = luaLang("v1a5_aizila_equip_noeffect")
		arg_16_0._txtTitle.text = arg_16_0._nextEquipCfg.name
	end

	if not var_16_0 then
		arg_16_0._txtnextlevel.text = formatLuaLang("v1a5_aizila_level", arg_16_0._nextEquipCfg.level)
		arg_16_0._txtNextEffect.text = formatLuaLang("v1a5_aizila_equip_effect_nextlv", arg_16_0._nextEquipCfg.effectDesc)

		local var_16_1 = not arg_16_0._isLockUpLevel and AiZiLaHelper.checkCostParams(arg_16_0._costparams)

		gohelper.setActive(arg_16_0._btnuplevel, var_16_1)
		gohelper.setActive(arg_16_0._btnunUplevel, not var_16_1)
		RedDotController.instance:addRedDot(arg_16_0._goRedPoint, RedDotEnum.DotNode.V1a5AiZiLaEquipUpLevel, arg_16_0._selectTypeId)
	end

	gohelper.setActive(arg_16_0._goLvMax, var_16_0)
	gohelper.setActive(arg_16_0._goLv, not var_16_0)
	gohelper.setActive(arg_16_0._txtnextlevel, not var_16_0)
	gohelper.setActive(arg_16_0._txtNextEffect, not var_16_0)
	gohelper.CreateObjList(arg_16_0, arg_16_0._onShowUplevelItem, arg_16_0._costparams, arg_16_0._gouplevelItems, arg_16_0._goodsItemGo, AiZiLaGoodsItem)
	arg_16_0:_refreshEquipItem()
end

function var_0_0._onShowUplevelItem(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_1:onUpdateMO(arg_17_2)

	if arg_17_1._isUpLevelInit ~= true then
		arg_17_1._isUpLevelInit = true

		arg_17_1:setShowCount(true, false)
	end

	local var_17_0 = arg_17_2.itemNum
	local var_17_1 = AiZiLaModel.instance:getItemQuantity(arg_17_2.itemId)
	local var_17_2 = var_17_1 < var_17_0 and "#de4618" or "#4a7900"

	arg_17_1:setCountStr(string.format("<color=%s>%s</color><color=#3C322B>/%s</color>", var_17_2, var_17_1, var_17_0))
end

function var_0_0._findInitCfg(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0._equipCoTypeList) do
		if iter_18_1.typeId == arg_18_1 then
			return iter_18_1
		end
	end
end

function var_0_0._refreshEquipItem(arg_19_0)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0._equipItemList) do
		iter_19_1:onSelect(iter_19_1:getTypeId() == arg_19_0._selectTypeId)
		iter_19_1:refreshUI(arg_19_0._isLockUpLevel)
	end
end

function var_0_0._refreshEquipItemUpLevel(arg_20_0, arg_20_1)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0._equipItemList) do
		if iter_20_1:getTypeId() == arg_20_1 then
			iter_20_1:refreshUpLevel()
		end
	end
end

function var_0_0.playViewAnimator(arg_21_0, arg_21_1)
	if arg_21_0._animator then
		arg_21_0._animator.enabled = true

		arg_21_0._animator:Play(arg_21_1, 0, 0)
	end
end

function var_0_0._isLockType(arg_22_0, arg_22_1)
	if arg_22_1 and arg_22_0._upLevelNextTimeDic[arg_22_1] and arg_22_0._upLevelNextTimeDic[arg_22_1] > Time.time then
		return true
	end

	return false
end

function var_0_0._setLockType(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1 and arg_23_2 then
		arg_23_0._upLevelNextTimeDic[arg_23_1] = Time.time + arg_23_2
	end
end

return var_0_0
