module("modules.logic.bossrush.view.FightViewBossHpBossRushAction", package.seeall)

local var_0_0 = class("FightViewBossHpBossRushAction", FightBaseView)

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
	arg_2_0:com_registFightEvent(FightEvent.OnMonsterChange, arg_2_0._onMonsterChange)
	arg_2_0:com_registFightEvent(FightEvent.OnRoundSequenceFinish, arg_2_0._onRoundSequenceFinish)
	arg_2_0:com_registFightEvent(FightEvent.OnEntityDead, arg_2_0._onEntityDead)
	arg_2_0:com_registFightEvent(FightEvent.OnBuffUpdate, arg_2_0._onBuffUpdate)
	arg_2_0:com_registClick(arg_2_0._btn, arg_2_0._ontBtnClick)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0.viewGO, true)
end

function var_0_0._ontBtnClick(arg_5_0)
	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
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

function var_0_0.onOpen(arg_6_0)
	arg_6_0:_refreshActData()
	arg_6_0:_refreshRoundShow()
end

function var_0_0._onMonsterChange(arg_7_0, arg_7_1)
	if arg_7_0._bossEntityMO and arg_7_1.id == arg_7_0._bossEntityMO.id then
		arg_7_0:_refreshActData(1)
	end
end

function var_0_0._onEntityDead(arg_8_0, arg_8_1)
	if arg_8_0._bossEntityMO and arg_8_0._bossEntityMO.id == arg_8_1 then
		arg_8_0:_refreshActData(1)
	end
end

function var_0_0._onBuffUpdate(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if arg_9_0._bossEntityMO and arg_9_0._bossEntityMO.id == arg_9_1 and arg_9_2 == FightEnum.EffectType.BUFFADD and arg_9_3 == 514000102 then
		local var_9_0 = {}

		tabletool.addValues(var_9_0, arg_9_0._curDataList)
		tabletool.addValues(var_9_0, arg_9_0._actList)

		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			for iter_9_2, iter_9_3 in ipairs(iter_9_1) do
				if iter_9_3.isChannelPosedSkill then
					iter_9_3.forbidden = true

					FightController.instance:dispatchEvent(FightEvent.ForbidBossRushHpChannelSkillOpItem, iter_9_3)

					return
				end
			end
		end
	end
end

function var_0_0._refreshActData(arg_10_0, arg_10_1)
	arg_10_0._curRound = FightModel.instance:getCurRoundId() + (arg_10_1 or 0)
	arg_10_0._maxRound = FightModel.instance:getMaxRound()
	arg_10_0._actList = {}
	arg_10_0._curDataList = {}

	local var_10_0 = FightModel.instance:getBattleId()

	arg_10_0._bossEntityMO = arg_10_0.PARENT_VIEW._bossEntityMO

	if arg_10_0._bossEntityMO then
		local var_10_1 = arg_10_0._bossEntityMO.modelId
		local var_10_2 = lua_boss_action.configDict[var_10_0] and lua_boss_action.configDict[var_10_0][var_10_1]

		if var_10_2 then
			local var_10_3 = var_10_2.actionId
			local var_10_4 = lua_boss_action_list.configDict[var_10_3]

			if var_10_4 then
				local var_10_5 = 0
				local var_10_6 = arg_10_0._curRound

				while var_10_6 <= arg_10_0._maxRound do
					for iter_10_0 = 1, var_10_4.circle do
						var_10_5 = var_10_5 + 1

						local var_10_7 = arg_10_0._actList[var_10_5] or {}
						local var_10_8 = var_10_4["actionId" .. iter_10_0]

						if var_10_8 == "noAction" then
							if #var_10_7 == 0 then
								table.insert(var_10_7, {
									skillId = 0
								})
							end
						else
							local var_10_9 = FightStrUtil.instance:getSplitCache(var_10_8, "#")
							local var_10_10

							if not tonumber(var_10_9[1]) then
								var_10_10 = {}

								local var_10_11 = FightStrUtil.instance:getSplitCache(var_10_8, "|")
								local var_10_12 = tonumber(var_10_11[#var_10_11])

								if var_10_12 then
									var_10_10[1] = var_10_12
								end
							else
								var_10_10 = FightStrUtil.instance:getSplitToNumberCache(var_10_8, "#")
							end

							for iter_10_1, iter_10_2 in ipairs(var_10_10) do
								local var_10_13, var_10_14, var_10_15 = FightHelper.isBossRushChannelSkill(iter_10_2)

								if var_10_13 then
									local var_10_16 = var_10_5 + var_10_15

									if var_10_16 <= arg_10_0._maxRound then
										arg_10_0._actList[var_10_16] = arg_10_0._actList[var_10_16] or {}

										table.insert(arg_10_0._actList[var_10_16], {
											isChannelPosedSkill = true,
											skillId = var_10_14
										})
									end

									table.insert(var_10_7, {
										isChannelSkill = true,
										round = var_10_15,
										skillId = iter_10_2
									})
								else
									table.insert(var_10_7, {
										skillId = iter_10_2
									})
								end
							end
						end

						arg_10_0._actList[var_10_5] = var_10_7
						var_10_6 = var_10_6 + 1

						if var_10_6 > arg_10_0._maxRound then
							break
						end
					end
				end
			end
		end
	end
end

local var_0_1 = 10

function var_0_0._refreshRoundShow(arg_11_0)
	arg_11_0._cardCount = 0

	for iter_11_0 = 1, var_0_1 do
		if not arg_11_0._curDataList[iter_11_0] then
			local var_11_0 = table.remove(arg_11_0._actList, 1)

			if var_11_0 then
				table.insert(arg_11_0._curDataList, var_11_0)
			end
		end
	end

	arg_11_0:com_createObjList(arg_11_0._onRoundSkillShow, arg_11_0._curDataList, arg_11_0._content, arg_11_0._opItem)
end

function var_0_0._releaseTween(arg_12_0)
	if arg_12_0._tweenId then
		ZProj.TweenHelper.KillById(arg_12_0._tweenId)

		arg_12_0._tweenId = nil
	end
end

function var_0_0._onRoundSequenceFinish(arg_13_0)
	if #arg_13_0._curDataList > 0 then
		local var_13_0 = table.remove(arg_13_0._curDataList, 1)

		arg_13_0:_releaseTween()

		local var_13_1 = recthelper.getWidth(arg_13_0._content.transform:GetChild(0))

		arg_13_0._tweenId = ZProj.TweenHelper.DOAnchorPosX(arg_13_0._moveRoot, -var_13_1, 0.3, arg_13_0._onTweenEnd, arg_13_0)
	else
		if arg_13_0.viewGO.activeInHierarchy then
			arg_13_0._ani:Play("update", nil, nil)
		end

		TaskDispatcher.runDelay(arg_13_0._refreshRoundShow, arg_13_0, 0.16)
	end
end

function var_0_0._onTweenEnd(arg_14_0)
	arg_14_0:_refreshRoundShow()
	recthelper.setAnchorX(arg_14_0._moveRoot, 0)
end

function var_0_0._onRoundSkillShow(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if arg_15_0._cardCount >= var_0_1 then
		gohelper.setActive(arg_15_1, false)

		return
	end

	gohelper.setActive(arg_15_1, true)

	local var_15_0 = {
		0
	}

	tabletool.addValues(var_15_0, arg_15_2)

	local var_15_1 = gohelper.findChild(arg_15_1, "item")

	arg_15_0:com_createObjList(arg_15_0._onOpSkillShow, var_15_0, arg_15_1, var_15_1)
end

function var_0_0._onOpSkillShow(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if arg_16_3 == 1 then
		return
	end

	arg_16_0._cardCount = arg_16_0._cardCount + 1

	if arg_16_0._cardCount > var_0_1 then
		gohelper.setActive(arg_16_1, false)

		return
	end

	gohelper.setActive(arg_16_1, true)

	if not arg_16_0._opItemClassDic then
		arg_16_0._opItemClassDic = {}
	end

	if not arg_16_0._opItemClassDic[arg_16_0._cardCount] then
		arg_16_0._opItemClassDic[arg_16_0._cardCount] = arg_16_0:com_openSubView(FightViewBossHpBossRushActionOpItem)
	end

	arg_16_0._opItemClassDic[arg_16_0._cardCount]:refreshUI(arg_16_1, arg_16_2)
end

function var_0_0.onClose(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._refreshRoundShow, arg_17_0)
	arg_17_0:_releaseTween()
end

function var_0_0.onDestroyView(arg_18_0)
	return
end

return var_0_0
