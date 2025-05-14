module("modules.logic.bossrush.view.FightViewBossHpBossRushAction", package.seeall)

local var_0_0 = class("FightViewBossHpBossRushAction", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._moveRoot = gohelper.findChild(arg_1_0.viewGO, "mask/moveRoot/moveRootScript").transform
	arg_1_0._content = gohelper.findChild(arg_1_0.viewGO, "mask/moveRoot/moveRootScript/root/Content")
	arg_1_0._opItem = gohelper.findChild(arg_1_0.viewGO, "mask/moveRoot/moveRootScript/root/Content/op")
	arg_1_0._btn = gohelper.findChildButton(arg_1_0.viewGO, "btn")
	arg_1_0._ani = SLFramework.AnimatorPlayer.Get(arg_1_0.viewGO)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnMonsterChange, arg_2_0._onMonsterChange, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_2_0._onRoundSequenceFinish, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnEntityDead, arg_2_0._onEntityDead, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_2_0._onBuffUpdate, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btn, arg_2_0._ontBtnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0.viewGO, true)
end

function var_0_0._ontBtnClick(arg_5_0)
	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if not arg_5_0._curDataList or #arg_5_0._curDataList == 0 then
		return
	end

	if not arg_5_0._bossEntityMO then
		return
	end

	local var_5_0 = {
		entityId = arg_5_0._bossEntityMO.id,
		dataList = LuaUtil.deepCopySimple(arg_5_0._curDataList)
	}

	ViewMgr.instance:openView(ViewName.FightActionBarPopView, var_5_0)
end

function var_0_0.onRefreshViewParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:_refreshActData()
	arg_7_0:_refreshRoundShow()
end

function var_0_0._onMonsterChange(arg_8_0, arg_8_1)
	if arg_8_0._bossEntityMO and arg_8_1.id == arg_8_0._bossEntityMO.id then
		arg_8_0:_refreshActData(1)
	end
end

function var_0_0._onEntityDead(arg_9_0, arg_9_1)
	if arg_9_0._bossEntityMO and arg_9_0._bossEntityMO.id == arg_9_1 then
		arg_9_0:_refreshActData(1)
	end
end

function var_0_0._onBuffUpdate(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if arg_10_0._bossEntityMO and arg_10_0._bossEntityMO.id == arg_10_1 and arg_10_2 == FightEnum.EffectType.BUFFADD and arg_10_3 == 514000102 then
		local var_10_0 = {}

		tabletool.addValues(var_10_0, arg_10_0._curDataList)
		tabletool.addValues(var_10_0, arg_10_0._actList)

		for iter_10_0, iter_10_1 in ipairs(var_10_0) do
			for iter_10_2, iter_10_3 in ipairs(iter_10_1) do
				if iter_10_3.isChannelPosedSkill then
					iter_10_3.forbidden = true

					FightController.instance:dispatchEvent(FightEvent.ForbidBossRushHpChannelSkillOpItem, iter_10_3)

					return
				end
			end
		end
	end
end

function var_0_0._refreshActData(arg_11_0, arg_11_1)
	arg_11_0._curRound = FightModel.instance:getCurRoundId() + (arg_11_1 or 0)
	arg_11_0._maxRound = FightModel.instance:getMaxRound()
	arg_11_0._actList = {}
	arg_11_0._curDataList = {}

	local var_11_0 = FightModel.instance:getBattleId()

	arg_11_0._bossEntityMO = arg_11_0:getParentView()._bossEntityMO

	if arg_11_0._bossEntityMO then
		local var_11_1 = arg_11_0._bossEntityMO.modelId
		local var_11_2 = lua_boss_action.configDict[var_11_0] and lua_boss_action.configDict[var_11_0][var_11_1]

		if var_11_2 then
			local var_11_3 = var_11_2.actionId
			local var_11_4 = lua_boss_action_list.configDict[var_11_3]

			if var_11_4 then
				local var_11_5 = 0
				local var_11_6 = arg_11_0._curRound

				while var_11_6 <= arg_11_0._maxRound do
					for iter_11_0 = 1, var_11_4.circle do
						var_11_5 = var_11_5 + 1

						local var_11_7 = arg_11_0._actList[var_11_5] or {}
						local var_11_8 = var_11_4["actionId" .. iter_11_0]

						if var_11_8 == "noAction" then
							if #var_11_7 == 0 then
								table.insert(var_11_7, {
									skillId = 0
								})
							end
						else
							local var_11_9 = FightStrUtil.instance:getSplitCache(var_11_8, "#")
							local var_11_10

							if not tonumber(var_11_9[1]) then
								var_11_10 = {}

								local var_11_11 = FightStrUtil.instance:getSplitCache(var_11_8, "|")
								local var_11_12 = tonumber(var_11_11[#var_11_11])

								if var_11_12 then
									var_11_10[1] = var_11_12
								end
							else
								var_11_10 = FightStrUtil.instance:getSplitToNumberCache(var_11_8, "#")
							end

							for iter_11_1, iter_11_2 in ipairs(var_11_10) do
								local var_11_13, var_11_14, var_11_15 = FightHelper.isBossRushChannelSkill(iter_11_2)

								if var_11_13 then
									local var_11_16 = var_11_5 + var_11_15

									if var_11_16 <= arg_11_0._maxRound then
										arg_11_0._actList[var_11_16] = arg_11_0._actList[var_11_16] or {}

										table.insert(arg_11_0._actList[var_11_16], {
											isChannelPosedSkill = true,
											skillId = var_11_14
										})
									end

									table.insert(var_11_7, {
										isChannelSkill = true,
										round = var_11_15,
										skillId = iter_11_2
									})
								else
									table.insert(var_11_7, {
										skillId = iter_11_2
									})
								end
							end
						end

						arg_11_0._actList[var_11_5] = var_11_7
						var_11_6 = var_11_6 + 1

						if var_11_6 > arg_11_0._maxRound then
							break
						end
					end
				end
			end
		end
	end
end

local var_0_1 = 10

function var_0_0._refreshRoundShow(arg_12_0)
	arg_12_0._cardCount = 0

	for iter_12_0 = 1, var_0_1 do
		if not arg_12_0._curDataList[iter_12_0] then
			local var_12_0 = table.remove(arg_12_0._actList, 1)

			if var_12_0 then
				table.insert(arg_12_0._curDataList, var_12_0)
			end
		end
	end

	arg_12_0:com_createObjList(arg_12_0._onRoundSkillShow, arg_12_0._curDataList, arg_12_0._content, arg_12_0._opItem)
end

function var_0_0._releaseTween(arg_13_0)
	if arg_13_0._tweenId then
		ZProj.TweenHelper.KillById(arg_13_0._tweenId)

		arg_13_0._tweenId = nil
	end
end

function var_0_0._onRoundSequenceFinish(arg_14_0)
	if #arg_14_0._curDataList > 0 then
		local var_14_0 = table.remove(arg_14_0._curDataList, 1)

		arg_14_0:_releaseTween()

		local var_14_1 = recthelper.getWidth(arg_14_0._content.transform:GetChild(0))

		arg_14_0._tweenId = ZProj.TweenHelper.DOAnchorPosX(arg_14_0._moveRoot, -var_14_1, 0.3, arg_14_0._onTweenEnd, arg_14_0)
	else
		if arg_14_0.viewGO.activeInHierarchy then
			arg_14_0._ani:Play("update", nil, nil)
		end

		TaskDispatcher.runDelay(arg_14_0._refreshRoundShow, arg_14_0, 0.16)
	end
end

function var_0_0._onTweenEnd(arg_15_0)
	arg_15_0:_refreshRoundShow()
	recthelper.setAnchorX(arg_15_0._moveRoot, 0)
end

function var_0_0._onRoundSkillShow(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if arg_16_0._cardCount >= var_0_1 then
		gohelper.setActive(arg_16_1, false)

		return
	end

	gohelper.setActive(arg_16_1, true)

	local var_16_0 = {
		0
	}

	tabletool.addValues(var_16_0, arg_16_2)

	local var_16_1 = gohelper.findChild(arg_16_1, "item")

	arg_16_0:com_createObjList(arg_16_0._onOpSkillShow, var_16_0, arg_16_1, var_16_1)
end

function var_0_0._onOpSkillShow(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_3 == 1 then
		return
	end

	arg_17_0._cardCount = arg_17_0._cardCount + 1

	if arg_17_0._cardCount > var_0_1 then
		gohelper.setActive(arg_17_1, false)

		return
	end

	gohelper.setActive(arg_17_1, true)

	if not arg_17_0._opItemClassDic then
		arg_17_0._opItemClassDic = {}
	end

	if not arg_17_0._opItemClassDic[arg_17_0._cardCount] then
		arg_17_0._opItemClassDic[arg_17_0._cardCount] = arg_17_0:openSubView(FightViewBossHpBossRushActionOpItem)
	end

	arg_17_0._opItemClassDic[arg_17_0._cardCount]:refreshUI(arg_17_1, arg_17_2)
end

function var_0_0.onClose(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._refreshRoundShow, arg_18_0)
	arg_18_0:_releaseTween()
end

function var_0_0.onDestroyView(arg_19_0)
	return
end

return var_0_0
