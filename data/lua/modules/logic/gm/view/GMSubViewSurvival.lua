module("modules.logic.gm.view.GMSubViewSurvival", package.seeall)

local var_0_0 = class("GMSubViewSurvival", GMSubViewBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0.tabName = "3.1探索"
end

function var_0_0.addLineIndex(arg_2_0)
	arg_2_0.lineIndex = arg_2_0.lineIndex and arg_2_0.lineIndex + 1 or 1
end

function var_0_0.getLineGroup(arg_3_0)
	return "L" .. arg_3_0.lineIndex
end

function var_0_0.initViewContent(arg_4_0)
	if arg_4_0._inited then
		return
	end

	GMSubViewBase.initViewContent(arg_4_0)
	arg_4_0:addTitleSplitLine("避难所")
	arg_4_0:addLineIndex()
	arg_4_0:addButton(arg_4_0:getLineGroup(), "一键添加所有NPC", arg_4_0.addAllNPC, arg_4_0)

	arg_4_0._txtDay = arg_4_0:addInputText(arg_4_0:getLineGroup(), "1")

	arg_4_0:addButton(arg_4_0:getLineGroup(), "设置天数", arg_4_0.setDay, arg_4_0)
	arg_4_0:addTitleSplitLine("探索")
	arg_4_0:addLineIndex()
	arg_4_0:addButton(arg_4_0:getLineGroup(), "一键进入探索", arg_4_0.enterSurvival, arg_4_0)
	arg_4_0:addButton(arg_4_0:getLineGroup(), "一键开启迷雾", arg_4_0.openFog, arg_4_0)
	arg_4_0:addButton(arg_4_0:getLineGroup(), "看昼夜效果", arg_4_0.testAmbient, arg_4_0)

	arg_4_0._txtEventId = arg_4_0:addInputText(arg_4_0:getLineGroup())

	arg_4_0:addButton(arg_4_0:getLineGroup(), "创建事件", arg_4_0.addEvent, arg_4_0)
	arg_4_0:addLineIndex()

	local var_4_0 = {
		"普通雨",
		"垃圾雨",
		"苦力怕雨"
	}

	arg_4_0._rainDrop = arg_4_0:addDropDown(arg_4_0:getLineGroup(), "暴雨类型", var_4_0, arg_4_0._onRainDropChange, arg_4_0)

	arg_4_0._rainDrop:SetValue(arg_4_0:getCurRainId() - 1)

	arg_4_0._txtItemId = arg_4_0:addInputText(arg_4_0:getLineGroup())

	arg_4_0:addButton(arg_4_0:getLineGroup(), "加10个道具", arg_4_0.addItem, arg_4_0)
	arg_4_0:addLineIndex()
	arg_4_0:addButton(arg_4_0:getLineGroup(), "清空周围所有事件", arg_4_0.clearUnit, arg_4_0)

	local var_4_1 = {
		"瘴气",
		"泥沼",
		"岩浆",
		"冰面",
		"水域"
	}

	arg_4_0._spBlockDrop = arg_4_0:addDropDown(arg_4_0:getLineGroup(), "特殊地形", var_4_1)

	arg_4_0:addButton(arg_4_0:getLineGroup(), "设置周围地形类型", arg_4_0.setBlockType, arg_4_0)
	arg_4_0:addTitleSplitLine("通用")
	arg_4_0:addLineIndex()

	arg_4_0._txtCurrency = arg_4_0:addInputText(arg_4_0:getLineGroup(), "10000")

	arg_4_0:addButton(arg_4_0:getLineGroup(), "添加所有货币", arg_4_0.addCurrency, arg_4_0)
	arg_4_0:addButton(arg_4_0:getLineGroup(), "清空背包", arg_4_0.clearBag, arg_4_0)
	arg_4_0:addButton(arg_4_0:getLineGroup(), "添加快捷道具", arg_4_0.addQuick, arg_4_0)
	arg_4_0:addTitleSplitLine("属性-避难所")
	arg_4_0:addAttrInput("无法被治疗复活", 104, true)
	arg_4_0:addAttrInput("健康度上限", 105)
	arg_4_0:addTitleSplitLine("属性-掉落")
	arg_4_0:addAttrInput("掉落数量", 201, true)
	arg_4_0:addAttrInput("掉落可选数量", 202)
	arg_4_0:addTitleSplitLine("属性-价值属性")
	arg_4_0:addAttrInput("购买价格", 301, true)
	arg_4_0:addAttrInput("出售价格", 302)
	arg_4_0:addAttrInput("建筑购买价值", 303, true)
	arg_4_0:addAttrInput("建筑出售价值", 304)
	arg_4_0:addTitleSplitLine("属性-健康度")
	arg_4_0:addAttrInput("健康度减少", 501, true)
	arg_4_0:addAttrInput("探索战斗失败", 502)
	arg_4_0:addAttrInput("避难所战斗失败", 503, true)
	arg_4_0:addAttrInput("探索超时", 504)
	arg_4_0:addAttrInput("处于毒圈", 505, true)
	arg_4_0:addAttrInput("健康度增加", 601)
	arg_4_0:addTitleSplitLine("属性-平衡属性")
	arg_4_0:addAttrInput("平衡角色等级", 701, true)
	arg_4_0:addAttrInput("平衡共鸣等级", 702)
	arg_4_0:addAttrInput("平衡心相等级", 703, true)
	arg_4_0:addTitleSplitLine("属性-探索属性")
	arg_4_0:addAttrInput("视野范围", 801, true)
	arg_4_0:addAttrInput("玩法最大天数", 802)
	arg_4_0:addAttrInput("移动耗时", 803, true)
	arg_4_0:addAttrInput("撤离损失", 805)
	arg_4_0:addAttrInput("探索角色数量", 806, true)
	arg_4_0:addAttrInput("探索Npc数量", 807)
	arg_4_0:addAttrInput("世界等级", 808, true)
	arg_4_0:addAttrInput("招募价值修正", 810)
	arg_4_0:addAttrInput("选项消耗时间修正", 811, true)
	arg_4_0:addAttrInput("角色战斗等级", 812)
	arg_4_0:addAttrInput("额外负重", 813, true)
	arg_4_0:addAttrInput("金币转换率", 814)
	arg_4_0:addAttrInput("不会被警戒发现", 817, true)
	arg_4_0:addAttrInput("视野范围2", 818)
	arg_4_0:addAttrInput("额外搜刮金币", 820, true)
	arg_4_0:addAttrInput("快捷道具复制率", 821)
	arg_4_0:addAttrInput("快捷道具复制率修正", 822, true)
	arg_4_0:addAttrInput("探索商店购买修正", 823)
	arg_4_0:addAttrInput("探索出售修正", 824, true)
	arg_4_0:addAttrInput("声望修正", 825)
	arg_4_0:addAttrInput("怪物视野", 826, true)
	arg_4_0:addTitleSplitLine("属性-载具")
	arg_4_0:addAttrInput("瘴气车", 1001, true)
	arg_4_0:addAttrInput("沼泽车", 1002)
	arg_4_0:addAttrInput("耐热车", 1003, true)
	arg_4_0:addAttrInput("履带车", 1004)
	arg_4_0:addAttrInput("动力船", 1005, true)
	arg_4_0:addTitleSplitLine("属性-难度")
	arg_4_0:addAttrInput("警戒范围修正", 1201, true)
	arg_4_0:addAttrInput("解码进度修正", 1202)
	arg_4_0:addAttrInput("是否有云雾", 1203, true)
end

function var_0_0.addAttrInput(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = SurvivalShelterModel.instance:getWeekInfo()

	if not var_5_0 then
		return
	end

	if arg_5_3 then
		arg_5_0:addLineIndex()
	end

	arg_5_0:addLabel(arg_5_0:getLineGroup(), string.format("%s(%s)", arg_5_1, arg_5_2))
	arg_5_0:addInputText(arg_5_0:getLineGroup(), var_5_0:getAttrRaw(arg_5_2), nil, function(arg_6_0, arg_6_1)
		if not tonumber(arg_6_1) then
			return
		end

		GMRpc.instance:sendGMRequest("surAttr " .. arg_5_2 .. " " .. arg_6_1)
	end, arg_5_0)
end

function var_0_0.setDay(arg_7_0)
	GMRpc.instance:sendGMRequest("surChangeDay " .. arg_7_0._txtDay:GetText())
end

function var_0_0.addAllNPC(arg_8_0)
	GMRpc.instance:sendGMRequest("surAddNpc 0")
end

function var_0_0.clearBag(arg_9_0)
	GMRpc.instance:sendGMRequest("surDeleteAllBag")
end

function var_0_0.addCurrency(arg_10_0)
	local var_10_0 = tonumber(arg_10_0._txtCurrency:GetText()) or 10000

	for iter_10_0 = 1, 1 do
		GMRpc.instance:sendGMRequest("surAddItem " .. iter_10_0 .. " " .. var_10_0)
	end
end

function var_0_0.addQuick(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(lua_survival_item.configList) do
		if iter_11_1.type == SurvivalEnum.ItemType.Quick then
			GMRpc.instance:sendGMRequest("surAddItem " .. iter_11_1.id .. " " .. 99)
		end
	end
end

function var_0_0.addEvent(arg_12_0)
	GMRpc.instance:sendGMRequest("surCreateUnit " .. arg_12_0._txtEventId:GetText())
end

function var_0_0.addItem(arg_13_0)
	GMRpc.instance:sendGMRequest("surAddItem " .. arg_13_0._txtItemId:GetText() .. " " .. 10)
end

function var_0_0.addAllItem(arg_14_0)
	GMRpc.instance:sendGMRequest("surAddAllItem 10000")
end

function var_0_0.enterSurvival(arg_15_0)
	local var_15_0 = false

	local function var_15_1(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
		if arg_16_2 == 0 then
			arg_16_0()
		end
	end

	SurvivalOutSideRpc.instance:sendSurvivalOutSideGetInfo(var_15_1, function()
		local function var_17_0()
			local var_18_0 = SurvivalShelterModel.instance:getWeekInfo()

			if var_18_0.inSurvival then
				SurvivalController.instance:enterSurvivalMap()
			else
				if var_18_0:isInFight() then
					SurvivalWeekRpc.instance:sendSurvivalIntrudeAbandonExterminateRequest()
				end

				local var_18_1 = SurvivalMapModel.instance:getInitGroup()

				var_18_1:init()

				var_18_1.selectMapIndex = 0

				if not var_18_1.allSelectHeroMos[1] then
					CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.Survival)

					for iter_18_0, iter_18_1 in ipairs(CharacterBackpackCardListModel.instance:getCharacterCardList()) do
						if var_18_0:getHeroMo(iter_18_1.heroId).health > 0 then
							var_18_1.allSelectHeroMos[1] = iter_18_1

							break
						end
					end
				end

				if not var_18_1.allSelectHeroMos[1] then
					ToastController.instance:showToastWithString("一个角色都没有???")

					return
				end

				SurvivalController.instance:enterSurvivalMap(var_18_1)

				if var_15_0 then
					TaskDispatcher.runDelay(function()
						GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, nil)
					end, arg_15_0, 2)
				end
			end
		end

		local function var_17_1()
			if SurvivalShelterModel.instance:getWeekInfo().day > 0 then
				var_17_0()
			else
				SurvivalWeekRpc.instance:sendSurvivalChooseBooty(nil, nil, var_15_1, var_17_0)
			end
		end

		if not SurvivalModel.instance:getOutSideInfo().inWeek then
			var_15_0 = true

			SurvivalWeekRpc.instance:sendSurvivalStartWeekChooseDiff(1, nil, var_15_1, var_17_1)
		else
			SurvivalWeekRpc.instance:sendSurvivalGetWeekInfo(var_15_1, var_17_0)
		end
	end)
	arg_15_0:closeThis()
end

function var_0_0.openFog(arg_21_0)
	if not SurvivalMapHelper.instance:getScene() then
		ToastController.instance:showToastWithString("不在探索场景中")

		return
	end

	GMRpc.instance:sendGMRequest("surOneKeyVision")
end

function var_0_0.testAmbient(arg_22_0)
	arg_22_0:closeThis()
	ZProj.TweenHelper.DOTweenFloat(0, 1440, 10, function(arg_23_0, arg_23_1)
		local var_23_0 = SurvivalMapModel.instance:getSceneMo()

		var_23_0.gameTime = arg_23_1 + var_23_0.addTime

		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapGameTimeUpdate, SurvivalEnum.GameTimeUpdateReason.Normal)
		GameSceneMgr.instance:getCurScene().ambient:_onTweenFrame(1)
	end, nil, {}, nil, EaseType.Linear)
end

function var_0_0._onRainDropChange(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1 + 1

	if var_24_0 == arg_24_0:getCurRainId() then
		return
	end

	local var_24_1 = SurvivalMapHelper.instance:getSceneFogComp()

	if not var_24_1 then
		return
	end

	if not var_24_1._rainEntity then
		return
	end

	var_24_1._rainEntity:setCurRain(var_24_0)

	for iter_24_0, iter_24_1 in ipairs(lua_survival_rain.configList) do
		if iter_24_1.type == var_24_0 then
			GMRpc.instance:sendGMRequest("surSetRainId " .. iter_24_1.id)

			break
		end
	end
end

function var_0_0.getCurRainId(arg_25_0)
	local var_25_0 = SurvivalMapHelper.instance:getSceneFogComp()

	if not var_25_0 then
		return 1
	end

	if not var_25_0._rainEntity then
		return 1
	end

	return var_25_0._rainEntity._rainId
end

function var_0_0.clearUnit(arg_26_0)
	local var_26_0 = SurvivalMapModel.instance:getSceneMo()

	if not var_26_0 then
		return
	end

	for iter_26_0, iter_26_1 in pairs(SurvivalHelper.instance:getAllPointsByDis(var_26_0.player.pos, 10)) do
		local var_26_1 = var_26_0:getUnitByPos(iter_26_1, true, true)

		for iter_26_2, iter_26_3 in pairs(var_26_1) do
			GMRpc.instance:sendGMRequest("surDelUnit " .. iter_26_3.id)
		end
	end

	for iter_26_4, iter_26_5 in pairs(var_26_0.blocks) do
		if SurvivalHelper.instance:getDistance(iter_26_5.pos, var_26_0.player.pos) <= 10 then
			GMRpc.instance:sendGMRequest("surDelUnit " .. iter_26_5.id)
		end
	end
end

function var_0_0.setBlockType(arg_27_0)
	local var_27_0 = SurvivalMapModel.instance:getSceneMo()

	if not var_27_0 then
		return
	end

	local var_27_1 = arg_27_0._spBlockDrop:GetValue() + 70001

	arg_27_0:clearUnit()

	local var_27_2 = SurvivalMapModel.instance:getCurMapCo()
	local var_27_3 = var_27_0.player.pos

	for iter_27_0, iter_27_1 in pairs(SurvivalHelper.instance:getAllPointsByDis(var_27_3, 3)) do
		if SurvivalHelper.instance:getValueFromDict(var_27_2.rawWalkables, iter_27_1) then
			GMRpc.instance:sendGMRequest("surCreateUnitAtPos " .. var_27_1 .. " " .. iter_27_1.q .. " " .. iter_27_1.r)
		end
	end
end

return var_0_0
