module("modules.logic.gm.view.GMSubViewSurvival", package.seeall)

local var_0_0 = class("GMSubViewSurvival", GMSubViewBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0.tabName = "2.8探索"
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

	arg_4_0._txtEventId = arg_4_0:addInputText(arg_4_0:getLineGroup(), "3100")

	arg_4_0:addButton(arg_4_0:getLineGroup(), "创建事件", arg_4_0.addEvent, arg_4_0)
	arg_4_0:addTitleSplitLine("通用")
	arg_4_0:addLineIndex()

	arg_4_0._txtCurrency = arg_4_0:addInputText(arg_4_0:getLineGroup(), "10000")

	arg_4_0:addButton(arg_4_0:getLineGroup(), "添加所有货币", arg_4_0.addCurrency, arg_4_0)
	arg_4_0:addButton(arg_4_0:getLineGroup(), "清空背包", arg_4_0.clearBag, arg_4_0)
	arg_4_0:addButton(arg_4_0:getLineGroup(), "添加所有道具", arg_4_0.addAllItem, arg_4_0)
end

function var_0_0.setDay(arg_5_0)
	GMRpc.instance:sendGMRequest("surChangeDay " .. arg_5_0._txtDay:GetText())
end

function var_0_0.addAllNPC(arg_6_0)
	GMRpc.instance:sendGMRequest("surAddNpc 0")
end

function var_0_0.clearBag(arg_7_0)
	GMRpc.instance:sendGMRequest("surDeleteAllBag")
end

function var_0_0.addCurrency(arg_8_0)
	local var_8_0 = tonumber(arg_8_0._txtCurrency:GetText()) or 10000

	for iter_8_0 = 1, 3 do
		GMRpc.instance:sendGMRequest("surAddItem " .. iter_8_0 .. " " .. var_8_0)
	end
end

function var_0_0.addEvent(arg_9_0)
	GMRpc.instance:sendGMRequest("surCreateUnit " .. arg_9_0._txtEventId:GetText())
end

function var_0_0.addAllItem(arg_10_0)
	GMRpc.instance:sendGMRequest("surAddAllItem 10000")
end

function var_0_0.enterSurvival(arg_11_0, arg_11_1)
	local function var_11_0(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
		if arg_12_2 == 0 then
			arg_12_0()
		end
	end

	SurvivalOutSideRpc.instance:sendSurvivalOutSideGetInfo(var_11_0, function()
		local function var_13_0()
			local var_14_0 = SurvivalShelterModel.instance:getWeekInfo()

			if var_14_0.inSurvival then
				SurvivalController.instance:enterSurvivalMap()
			else
				if var_14_0:isInFight() then
					SurvivalWeekRpc.instance:sendSurvivalIntrudeAbandonExterminateRequest()
				end

				local var_14_1 = SurvivalMapModel.instance:getInitGroup()

				var_14_1:init()

				var_14_1.selectCopyIndex = arg_11_1 or 1

				if not var_14_1.allSelectHeroMos[1] then
					CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.Survival)

					for iter_14_0, iter_14_1 in ipairs(CharacterBackpackCardListModel.instance:getCharacterCardList()) do
						if var_14_0:getHeroMo(iter_14_1.heroId).health > 0 then
							var_14_1.allSelectHeroMos[1] = iter_14_1

							break
						end
					end
				end

				if not var_14_1.allSelectHeroMos[1] then
					ToastController.instance:showToastWithString("一个角色都没有???")

					return
				end

				SurvivalController.instance:enterSurvivalMap(var_14_1)
			end
		end

		if not SurvivalModel.instance:getOutSideInfo().inWeek then
			SurvivalWeekRpc.instance:sendSurvivalStartWeekChooseDiff(1, nil, var_11_0, function()
				if SurvivalShelterModel.instance:getWeekInfo().difficulty == SurvivalEnum.FirstPlayDifficulty then
					var_13_0()
				else
					SurvivalWeekRpc.instance:sendSurvivalStartWeekChooseTalent(1, var_11_0, var_13_0)
				end
			end)
		else
			SurvivalWeekRpc.instance:sendSurvivalGetWeekInfo(var_11_0, var_13_0)
		end
	end)
	arg_11_0:closeThis()
end

function var_0_0.openFog(arg_16_0)
	if not SurvivalMapHelper.instance:getScene() then
		ToastController.instance:showToastWithString("不在探索场景中")

		return
	end

	GMRpc.instance:sendGMRequest("surOneKeyVision")
end

return var_0_0
