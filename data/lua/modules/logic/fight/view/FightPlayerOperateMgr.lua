module("modules.logic.fight.view.FightPlayerOperateMgr", package.seeall)

slot0 = class("FightPlayerOperateMgr", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, slot0._onClothSkillRoundSequenceFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, slot0._onStartSequenceFinish, slot0, LuaEventSystem.Low)
end

function slot0.removeEvents(slot0)
end

function slot0._onRoundSequenceFinish(slot0)
	slot0:checkNeedPlayerOperate()
end

function slot0._onClothSkillRoundSequenceFinish(slot0)
	slot0:checkNeedPlayerOperate()
end

function slot0._onStartSequenceFinish(slot0)
	slot0:checkNeedPlayerOperate()
end

function slot0.checkNeedPlayerOperate(slot0)
	if FightDataHelper.fieldMgr:isDouQuQu() then
		return
	end

	if slot0:_checkChangeHeroNeedUseSkill() then
		return
	end

	if slot0:_checkBindContract() then
		return
	end

	slot0:_checkHeroUpgrade()

	if not FightModel.instance:isFinish() then
		FightViewPartVisible.set(true, true, true, false, false)
	end
end

function slot0.sortEntity(slot0, slot1)
	slot3 = slot1:getMO()

	if slot0:getMO() and slot3 then
		return slot2.position < slot3.position
	end

	return false
end

function slot0._checkHeroUpgrade(slot0)
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	if FightReplayModel.instance:isReplay() then
		return
	end

	if FightModel.instance:getCurStage() == FightEnum.Stage.AutoCard then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if FightCardModel.instance:isCardOpEnd() then
		return
	end

	if FightModel.instance:isFinish() then
		return
	end

	if #uv0.detectUpgrade() > 0 then
		for slot5 = #slot1, 1, -1 do
			if lua_hero_upgrade.configDict[slot1[slot5].id].type == 1 then
				FightRpc.instance:sendUseClothSkillRequest(slot6.id, slot6.entityId, slot6.optionIds[1], FightEnum.ClothSkillType.HeroUpgrade)
				table.remove(slot1, slot5)
			end
		end

		if #slot1 > 0 then
			slot0._upgradeDatas = slot1

			ViewMgr.instance:openView(ViewName.FightSkillStrengthenView, slot1)
		end
	end
end

function slot0.detectUpgrade()
	if FightModel.instance:isFinish() then
		return {}
	end

	slot0 = {}
	slot1 = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide)

	table.sort(slot1, uv0.sortEntity)

	for slot5, slot6 in ipairs(slot1) do
		if slot6:getMO() and slot7.canUpgradeIds and tabletool.len(slot7.canUpgradeIds) > 0 then
			for slot11, slot12 in pairs(slot7.canUpgradeIds) do
				if lua_hero_upgrade.configDict[slot12] then
					slot14 = {}

					for slot19, slot20 in ipairs(string.splitToNumber(slot13.options, "#")) do
						if not slot7.upgradedOptions[slot20] then
							table.insert(slot14, slot20)
						end
					end

					if #slot14 > 0 then
						table.insert(slot0, {
							id = slot12,
							entityId = slot7.id,
							optionIds = slot14
						})
					end
				end
			end
		end
	end

	return slot0
end

function slot0._checkChangeHeroNeedUseSkill(slot0)
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	if FightReplayModel.instance:isReplay() then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Season2AutoChangeHero) then
		return
	end

	if FightModel.instance:getCurStage() == FightEnum.Stage.AutoCard then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if FightCardModel.instance:isCardOpEnd() then
		return
	end

	if FightModel.instance:isFinish() then
		return
	end

	if not FightModel.instance:getCurRoundMO() then
		return
	end

	if not FightDataHelper.entityMgr:getById(slot1.lastChangeHeroUid) then
		return
	end

	if not lua_skill.configDict[slot2.exSkill] then
		return
	end

	if FightEnum.ShowLogicTargetView[slot3.logicTarget] and slot3.targetLimit == FightEnum.TargetLimit.MySide and #FightDataHelper.entityMgr:getMyNormalList() + #FightDataHelper.entityMgr:getSpList(FightEnum.EntitySide.MySide) == 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.FightChangeHeroSelectSkillTargetView, {
		skillConfig = slot3,
		fromId = slot2.id
	})

	return true
end

function slot0._checkBindContract(slot0)
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	if FightReplayModel.instance:isReplay() then
		return
	end

	if FightModel.instance:getCurStage() == FightEnum.Stage.AutoCard then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if FightCardModel.instance:isCardOpEnd() then
		return
	end

	if FightModel.instance:isFinish() then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		logNormal("打开娜娜锲约界面，但是还在指引ing")

		return
	end

	if string.nilorempty(FightModel.instance.notifyEntityId) then
		return
	end

	if not FightHelper.getEntity(slot1) then
		return
	end

	if not FightModel.instance.canContractList or #slot3 < 1 then
		return
	end

	FightDataHelper.stageMgr:enterOperateState(FightStageMgr.OperateStateType.BindContract)
	ViewMgr.instance:openView(ViewName.FightNaNaTargetView)

	return true
end

return slot0
