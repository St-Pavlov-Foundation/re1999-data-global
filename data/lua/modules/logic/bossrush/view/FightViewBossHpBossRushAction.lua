module("modules.logic.bossrush.view.FightViewBossHpBossRushAction", package.seeall)

slot0 = class("FightViewBossHpBossRushAction", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._moveRoot = gohelper.findChild(slot0.viewGO, "mask/moveRoot/moveRootScript").transform
	slot0._content = gohelper.findChild(slot0.viewGO, "mask/moveRoot/moveRootScript/root/Content")
	slot0._opItem = gohelper.findChild(slot0.viewGO, "mask/moveRoot/moveRootScript/root/Content/op")
	slot0._btn = gohelper.findChildButton(slot0.viewGO, "btn")
	slot0._ani = SLFramework.AnimatorPlayer.Get(slot0.viewGO)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnMonsterChange, slot0._onMonsterChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnEntityDead, slot0._onEntityDead, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
	slot0:addClickCb(slot0._btn, slot0._ontBtnClick, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0.viewGO, true)
end

function slot0._ontBtnClick(slot0)
	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if not slot0._curDataList or #slot0._curDataList == 0 then
		return
	end

	if not slot0._bossEntityMO then
		return
	end

	ViewMgr.instance:openView(ViewName.FightActionBarPopView, {
		entityId = slot0._bossEntityMO.id,
		dataList = LuaUtil.deepCopySimple(slot0._curDataList)
	})
end

function slot0.onRefreshViewParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:_refreshActData()
	slot0:_refreshRoundShow()
end

function slot0._onMonsterChange(slot0, slot1)
	if slot0._bossEntityMO and slot1.id == slot0._bossEntityMO.id then
		slot0:_refreshActData(1)
	end
end

function slot0._onEntityDead(slot0, slot1)
	if slot0._bossEntityMO and slot0._bossEntityMO.id == slot1 then
		slot0:_refreshActData(1)
	end
end

function slot0._onBuffUpdate(slot0, slot1, slot2, slot3, slot4)
	if slot0._bossEntityMO and slot0._bossEntityMO.id == slot1 and slot2 == FightEnum.EffectType.BUFFADD and slot3 == 514000102 then
		slot5 = {}

		tabletool.addValues(slot5, slot0._curDataList)
		tabletool.addValues(slot5, slot0._actList)

		for slot9, slot10 in ipairs(slot5) do
			for slot14, slot15 in ipairs(slot10) do
				if slot15.isChannelPosedSkill then
					slot15.forbidden = true

					FightController.instance:dispatchEvent(FightEvent.ForbidBossRushHpChannelSkillOpItem, slot15)

					return
				end
			end
		end
	end
end

function slot0._refreshActData(slot0, slot1)
	slot0._curRound = FightModel.instance:getCurRoundId() + (slot1 or 0)
	slot0._maxRound = FightModel.instance:getMaxRound()
	slot0._actList = {}
	slot0._curDataList = {}
	slot2 = FightModel.instance:getBattleId()
	slot0._bossEntityMO = slot0:getParentView()._bossEntityMO

	if slot0._bossEntityMO and lua_boss_action.configDict[slot2] and lua_boss_action.configDict[slot2][slot0._bossEntityMO.modelId] and lua_boss_action_list.configDict[slot5.actionId] then
		slot7 = 0

		while slot0._curRound <= slot0._maxRound do
			for slot12 = 1, slot5.circle do
				slot13 = slot0._actList[slot7 + 1] or {}

				if slot5["actionId" .. slot12] == "noAction" then
					if #slot13 == 0 then
						table.insert(slot13, {
							skillId = 0
						})
					end
				else
					slot16 = nil

					if not tonumber(FightStrUtil.instance:getSplitCache(slot14, "#")[1]) then
						slot17 = FightStrUtil.instance:getSplitCache(slot14, "|")

						if tonumber(slot17[#slot17]) then
							-- Nothing
						end
					else
						slot16 = FightStrUtil.instance:getSplitToNumberCache(slot14, "#")
					end

					for slot20, slot21 in ipairs({
						slot18
					}) do
						slot22, slot23, slot24 = FightHelper.isBossRushChannelSkill(slot21)

						if slot22 then
							if slot7 + slot24 <= slot0._maxRound then
								slot0._actList[slot25] = slot0._actList[slot25] or {}

								table.insert(slot0._actList[slot25], {
									isChannelPosedSkill = true,
									skillId = slot23
								})
							end

							table.insert(slot13, {
								isChannelSkill = true,
								round = slot24,
								skillId = slot21
							})
						else
							table.insert(slot13, {
								skillId = slot21
							})
						end
					end
				end

				slot0._actList[slot7] = slot13

				if slot0._maxRound < slot8 + 1 then
					break
				end
			end
		end
	end
end

slot1 = 10

function slot0._refreshRoundShow(slot0)
	slot0._cardCount = 0

	for slot4 = 1, uv0 do
		if not slot0._curDataList[slot4] and table.remove(slot0._actList, 1) then
			table.insert(slot0._curDataList, slot5)
		end
	end

	slot0:com_createObjList(slot0._onRoundSkillShow, slot0._curDataList, slot0._content, slot0._opItem)
end

function slot0._releaseTween(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

function slot0._onRoundSequenceFinish(slot0)
	if #slot0._curDataList > 0 then
		slot1 = table.remove(slot0._curDataList, 1)

		slot0:_releaseTween()

		slot0._tweenId = ZProj.TweenHelper.DOAnchorPosX(slot0._moveRoot, -recthelper.getWidth(slot0._content.transform:GetChild(0)), 0.3, slot0._onTweenEnd, slot0)
	else
		if slot0.viewGO.activeInHierarchy then
			slot0._ani:Play("update", nil, )
		end

		TaskDispatcher.runDelay(slot0._refreshRoundShow, slot0, 0.16)
	end
end

function slot0._onTweenEnd(slot0)
	slot0:_refreshRoundShow()
	recthelper.setAnchorX(slot0._moveRoot, 0)
end

function slot0._onRoundSkillShow(slot0, slot1, slot2, slot3)
	if uv0 <= slot0._cardCount then
		gohelper.setActive(slot1, false)

		return
	end

	gohelper.setActive(slot1, true)

	slot4 = {
		0
	}

	tabletool.addValues(slot4, slot2)
	slot0:com_createObjList(slot0._onOpSkillShow, slot4, slot1, gohelper.findChild(slot1, "item"))
end

function slot0._onOpSkillShow(slot0, slot1, slot2, slot3)
	if slot3 == 1 then
		return
	end

	slot0._cardCount = slot0._cardCount + 1

	if uv0 < slot0._cardCount then
		gohelper.setActive(slot1, false)

		return
	end

	gohelper.setActive(slot1, true)

	if not slot0._opItemClassDic then
		slot0._opItemClassDic = {}
	end

	if not slot0._opItemClassDic[slot0._cardCount] then
		slot0._opItemClassDic[slot0._cardCount] = slot0:openSubView(FightViewBossHpBossRushActionOpItem)
	end

	slot0._opItemClassDic[slot0._cardCount]:refreshUI(slot1, slot2)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._refreshRoundShow, slot0)
	slot0:_releaseTween()
end

function slot0.onDestroyView(slot0)
end

return slot0
