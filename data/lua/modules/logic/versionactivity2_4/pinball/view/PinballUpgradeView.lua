module("modules.logic.versionactivity2_4.pinball.view.PinballUpgradeView", package.seeall)

local var_0_0 = class("PinballUpgradeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#image_icon")
	arg_1_0._txtname = gohelper.findChildTextMesh(arg_1_0.viewGO, "#txt_buildingname")
	arg_1_0._txttitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "#scroll_dec/Viewport/Content/#txt_title")
	arg_1_0._txtdesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "#scroll_dec/Viewport/Content/#txt_dec")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._btnremove = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_remove")
	arg_1_0._goupgrade = gohelper.findChild(arg_1_0.viewGO, "#go_upgrade")
	arg_1_0._btnupgrade = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_upgrade/#btn_upgrade")
	arg_1_0._btnupgradeEffect = gohelper.findChild(arg_1_0.viewGO, "#go_upgrade/#btn_upgrade/vx_ink")
	arg_1_0._txtnowlv = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_upgrade/#txt_nowLv")
	arg_1_0._txtnextlv = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_upgrade/#txt_nextLv")
	arg_1_0._gomax = gohelper.findChild(arg_1_0.viewGO, "#go_max")
	arg_1_0._txtmaxlv = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_max/#txt_lv")
	arg_1_0._gocostitem = gohelper.findChild(arg_1_0.viewGO, "#go_upgrade/#go_currency/go_item")
	arg_1_0._gopreviewitem = gohelper.findChild(arg_1_0.viewGO, "#go_preview/#go_group/go_item")
	arg_1_0._gopreviewtitle = gohelper.findChild(arg_1_0.viewGO, "#go_preview/txt_preview")
	arg_1_0._topCurrencyRoot = gohelper.findChild(arg_1_0.viewGO, "#go_topright")
	arg_1_0._goeffect = gohelper.findChild(arg_1_0.viewGO, "vx_upgrade")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._btnremove:AddClickListener(arg_2_0.removeBuilding, arg_2_0)
	arg_2_0._btnupgrade:AddClickListener(arg_2_0.upgradeBuilding, arg_2_0)
	PinballController.instance:registerCallback(PinballEvent.UpgradeBuilding, arg_2_0._buildingUpdate, arg_2_0)
	PinballController.instance:registerCallback(PinballEvent.RemoveBuilding, arg_2_0._buildingRemove, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnremove:RemoveClickListener()
	arg_3_0._btnupgrade:RemoveClickListener()
	PinballController.instance:unregisterCallback(PinballEvent.UpgradeBuilding, arg_3_0._buildingUpdate, arg_3_0)
	PinballController.instance:unregisterCallback(PinballEvent.RemoveBuilding, arg_3_0._buildingRemove, arg_3_0)
end

function var_0_0.onClickModalMask(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onOpen(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio3)
	arg_5_0:createCurrencyItem()
	arg_5_0:_refreshBuilding()
end

function var_0_0._refreshBuilding(arg_6_0)
	local var_6_0 = PinballModel.instance:getBuildingInfo(arg_6_0.viewParam.index)

	if not var_6_0 then
		return
	end

	local var_6_1 = var_6_0.co
	local var_6_2 = var_6_0.nextCo

	arg_6_0._imageicon:LoadImage(string.format("singlebg/v2a4_tutushizi_singlebg/building/%s.png", var_6_0.baseCo.icon))

	arg_6_0._txtname.text = var_6_0.baseCo.name
	arg_6_0._txttitle.text = var_6_0.baseCo.desc
	arg_6_0._txtdesc.text = var_6_0.baseCo.desc2

	gohelper.setActive(arg_6_0._gomax, not var_6_2)
	gohelper.setActive(arg_6_0._goupgrade, var_6_2)
	gohelper.setActive(arg_6_0._gopreviewtitle, var_6_2)
	gohelper.setActive(arg_6_0._btnremove, var_6_1.destory)

	if var_6_2 then
		arg_6_0._txtnowlv.text = var_6_1.level
		arg_6_0._txtnextlv.text = var_6_2.level

		arg_6_0:updateCost(var_6_2)

		local var_6_3 = arg_6_0._costNoEnough and true or arg_6_0:checkLock(var_6_2) or false

		ZProj.UGUIHelper.SetGrayscale(arg_6_0._btnupgrade.gameObject, var_6_3)
		gohelper.setActive(arg_6_0._btnupgradeEffect, not var_6_3)
	else
		arg_6_0._txtmaxlv.text = var_6_1.level
	end

	arg_6_0:updatePreview(var_6_1, var_6_2)
end

function var_0_0.createCurrencyItem(arg_7_0)
	local var_7_0 = {
		PinballEnum.ResType.Wood,
		PinballEnum.ResType.Mine,
		PinballEnum.ResType.Stone
	}

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		local var_7_1 = arg_7_0:getResInst(arg_7_0.viewContainer._viewSetting.otherRes.currency, arg_7_0._topCurrencyRoot)

		MonoHelper.addNoUpdateLuaComOnceToGo(var_7_1, PinballCurrencyItem):setCurrencyType(iter_7_1)
	end
end

function var_0_0.updatePreview(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {}
	local var_8_1 = arg_8_1.effect
	local var_8_2 = {}

	if not string.nilorempty(var_8_1) then
		local var_8_3 = GameUtil.splitString2(var_8_1, true)

		for iter_8_0, iter_8_1 in pairs(var_8_3) do
			if iter_8_1[1] == PinballEnum.BuildingEffectType.AddScore then
				table.insert(var_8_0, {
					resType = PinballEnum.ResType.Score,
					value = iter_8_1[2]
				})

				var_8_2[iter_8_1[1]] = #var_8_0
			elseif iter_8_1[1] == PinballEnum.BuildingEffectType.AddFood then
				table.insert(var_8_0, {
					resType = PinballEnum.ResType.Food,
					value = iter_8_1[2]
				})

				var_8_2[iter_8_1[1]] = #var_8_0
			elseif iter_8_1[1] == PinballEnum.BuildingEffectType.AddPlay then
				table.insert(var_8_0, {
					resType = PinballEnum.ResType.Play,
					value = iter_8_1[2]
				})

				var_8_2[iter_8_1[1]] = #var_8_0
			elseif iter_8_1[1] == PinballEnum.BuildingEffectType.CostFood then
				table.insert(var_8_0, {
					resType = PinballEnum.ResType.Food,
					value = iter_8_1[2],
					text = luaLang("pinball_food_need")
				})

				var_8_2[iter_8_1[1]] = #var_8_0
			elseif iter_8_1[1] == PinballEnum.BuildingEffectType.AddPlayDemand then
				table.insert(var_8_0, {
					resType = PinballEnum.ResType.Play,
					value = iter_8_1[2],
					text = luaLang("pinball_play_need")
				})

				var_8_2[iter_8_1[1]] = #var_8_0
			end
		end
	end

	if arg_8_2 then
		local var_8_4 = arg_8_2.effect

		if not string.nilorempty(var_8_4) then
			local var_8_5 = GameUtil.splitString2(var_8_4, true)

			for iter_8_2, iter_8_3 in pairs(var_8_5) do
				if iter_8_3[1] == PinballEnum.BuildingEffectType.AddScore then
					local var_8_6 = var_8_2[iter_8_3[1]]

					if var_8_6 then
						var_8_0[var_8_6].nextVal = iter_8_3[2]
					else
						table.insert(var_8_0, {
							resType = PinballEnum.ResType.Score,
							nextVal = iter_8_3[2]
						})
					end
				elseif iter_8_3[1] == PinballEnum.BuildingEffectType.AddFood then
					local var_8_7 = var_8_2[iter_8_3[1]]

					if var_8_7 then
						var_8_0[var_8_7].nextVal = iter_8_3[2]
					else
						table.insert(var_8_0, {
							resType = PinballEnum.ResType.Food,
							nextVal = iter_8_3[2]
						})
					end
				elseif iter_8_3[1] == PinballEnum.BuildingEffectType.AddPlay then
					local var_8_8 = var_8_2[iter_8_3[1]]

					if var_8_8 then
						var_8_0[var_8_8].nextVal = iter_8_3[2]
					else
						table.insert(var_8_0, {
							resType = PinballEnum.ResType.Play,
							nextVal = iter_8_3[2]
						})
					end
				elseif iter_8_3[1] == PinballEnum.BuildingEffectType.CostFood then
					local var_8_9 = var_8_2[iter_8_3[1]]

					if var_8_9 then
						var_8_0[var_8_9].nextVal = iter_8_3[2]
					else
						table.insert(var_8_0, {
							resType = PinballEnum.ResType.Food,
							nextVal = iter_8_3[2],
							text = luaLang("pinball_food_need")
						})
					end
				elseif iter_8_3[1] == PinballEnum.BuildingEffectType.AddPlayDemand then
					local var_8_10 = var_8_2[iter_8_3[1]]

					if var_8_10 then
						var_8_0[var_8_10].nextVal = iter_8_3[2]
					else
						table.insert(var_8_0, {
							resType = PinballEnum.ResType.Play,
							nextVal = iter_8_3[2],
							text = luaLang("pinball_play_need")
						})
					end
				end
			end
		end
	end

	for iter_8_4, iter_8_5 in pairs(var_8_0) do
		iter_8_5.haveNext = arg_8_2
	end

	arg_8_0._goeffects = arg_8_0._goeffects or arg_8_0:getUserDataTb_()

	tabletool.clear(arg_8_0._goeffects)
	gohelper.CreateObjList(arg_8_0, arg_8_0._createEffectItem, var_8_0, nil, arg_8_0._gopreviewitem)
end

function var_0_0._createEffectItem(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = gohelper.findChildImage(arg_9_1, "#image_icon")
	local var_9_1 = gohelper.findChildTextMesh(arg_9_1, "#txt_base")
	local var_9_2 = gohelper.findChildTextMesh(arg_9_1, "#txt_curnum")
	local var_9_3 = gohelper.findChildTextMesh(arg_9_1, "#txt_num")
	local var_9_4 = gohelper.findChild(arg_9_1, "vx_eff")

	table.insert(arg_9_0._goeffects, var_9_4)

	local var_9_5 = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][arg_9_2.resType]

	if not var_9_5 then
		logError("资源配置不存在" .. arg_9_2.resType)

		return
	end

	UISpriteSetMgr.instance:setAct178Sprite(var_9_0, var_9_5.icon)

	var_9_1.text = arg_9_2.text or var_9_5.name

	if arg_9_2.haveNext then
		var_9_2.text = string.format("%d", arg_9_2.value or 0)

		local var_9_6 = (arg_9_2.nextVal or 0) - (arg_9_2.value or 0)

		if var_9_6 >= 0 then
			var_9_3.text = string.format("<color=#BCFF85>+%s", var_9_6)
		else
			var_9_3.text = string.format("<color=#FC8A6A>%s", var_9_6)
		end
	else
		var_9_2.text = ""
		var_9_3.text = string.format("%d", arg_9_2.value)
	end
end

function var_0_0.updateCost(arg_10_0, arg_10_1)
	local var_10_0 = {}
	local var_10_1 = arg_10_1.cost

	if not string.nilorempty(var_10_1) then
		local var_10_2 = GameUtil.splitString2(var_10_1, true)

		for iter_10_0, iter_10_1 in pairs(var_10_2) do
			table.insert(var_10_0, {
				resType = iter_10_1[1],
				value = iter_10_1[2]
			})
		end
	end

	arg_10_0._costNoEnough = nil

	gohelper.CreateObjList(arg_10_0, arg_10_0._createCostItem, var_10_0, nil, arg_10_0._gocostitem)
end

function var_0_0.checkLock(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_1 then
		return
	end

	local var_11_0 = arg_11_1.condition

	if string.nilorempty(var_11_0) then
		return false
	end

	local var_11_1 = GameUtil.splitString2(var_11_0, true)

	for iter_11_0, iter_11_1 in pairs(var_11_1) do
		local var_11_2 = iter_11_1[1]

		if var_11_2 == PinballEnum.ConditionType.Talent then
			local var_11_3 = iter_11_1[2]

			if not PinballModel.instance:getTalentMo(var_11_3) then
				if arg_11_2 then
					local var_11_4 = lua_activity178_talent.configDict[VersionActivity2_4Enum.ActivityId.Pinball][var_11_3]

					GameFacade.showToast(ToastEnum.Act178TalentCondition, var_11_4.name)
				end

				return true
			end
		elseif var_11_2 == PinballEnum.ConditionType.Score then
			local var_11_5 = iter_11_1[2]

			if var_11_5 > PinballModel.instance.maxProsperity then
				if arg_11_2 then
					local var_11_6 = PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, var_11_5)

					GameFacade.showToast(ToastEnum.Act178ScoreCondition, var_11_6)
				end

				return true
			end
		end
	end

	return false
end

function var_0_0._createCostItem(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = gohelper.findChildTextMesh(arg_12_1, "#txt_num")
	local var_12_1 = gohelper.findChildImage(arg_12_1, "#txt_num/#image_icon")
	local var_12_2 = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][arg_12_2.resType]

	if not var_12_2 then
		logError("资源配置不存在" .. arg_12_2.resType)

		return
	end

	UISpriteSetMgr.instance:setAct178Sprite(var_12_1, var_12_2.icon)

	local var_12_3 = ""

	if arg_12_2.value > PinballModel.instance:getResNum(arg_12_2.resType) then
		var_12_3 = "<color=#FC8A6A>"
		arg_12_0._costNoEnough = arg_12_0._costNoEnough or var_12_2.name
	end

	var_12_0.text = string.format("%s-%d", var_12_3, arg_12_2.value)
end

function var_0_0.removeBuilding(arg_13_0)
	PinballController.instance:removeBuilding(arg_13_0.viewParam.index)
end

function var_0_0.upgradeBuilding(arg_14_0)
	local var_14_0 = PinballModel.instance:getBuildingInfo(arg_14_0.viewParam.index)

	if not var_14_0 then
		return
	end

	if arg_14_0._costNoEnough then
		GameFacade.showToast(ToastEnum.DiamondBuy, arg_14_0._costNoEnough)

		return
	end

	if arg_14_0:checkLock(var_14_0.nextCo, true) then
		return
	end

	Activity178Rpc.instance:sendAct178Build(VersionActivity2_4Enum.ActivityId.Pinball, var_14_0.configId, PinballEnum.BuildingOperType.Upgrade, arg_14_0.viewParam.index)
end

function var_0_0._buildingUpdate(arg_15_0, arg_15_1)
	if arg_15_1 == arg_15_0.viewParam.index then
		gohelper.setActive(arg_15_0._goeffect, false)
		gohelper.setActive(arg_15_0._goeffect, true)

		for iter_15_0, iter_15_1 in pairs(arg_15_0._goeffects) do
			gohelper.setActive(iter_15_1, false)
			gohelper.setActive(iter_15_1, true)
		end

		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio34)
		UIBlockMgr.instance:startBlock("PinballUpgradeView_Effect")
		TaskDispatcher.runDelay(arg_15_0._effectEnd, arg_15_0, 1)
	end
end

function var_0_0._effectEnd(arg_16_0)
	UIBlockMgr.instance:endBlock("PinballUpgradeView_Effect")
	arg_16_0:_refreshBuilding()
end

function var_0_0.onClose(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._effectEnd, arg_17_0)
	UIBlockMgr.instance:endBlock("PinballUpgradeView_Effect")
end

function var_0_0._buildingRemove(arg_18_0, arg_18_1)
	if arg_18_1 == arg_18_0.viewParam.index then
		arg_18_0:closeThis()
	end
end

return var_0_0
