module("modules.logic.fight.view.FightToughBattleSkillItem", package.seeall)

slot0 = class("FightToughBattleSkillItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._goselect = gohelper.findChild(slot1, "#go_Selected")
	slot0._btn = gohelper.getClickWithDefaultAudio(slot1, "btn")
	slot0._gonum = gohelper.findChild(slot1, "#go_Num")
	slot0._txtnum = gohelper.findChildTextMesh(slot1, "#go_Num/#txt_Num")
	slot0._simagechar = gohelper.findChildSingleImage(slot1, "#simage_Char")
	slot0._iconImage = gohelper.findChildImage(slot1, "#simage_Char")
	slot0._goDetails = gohelper.findChild(slot1, "#go_details")
	slot0._txtDetailTitle = gohelper.findChildTextMesh(slot0._goDetails, "details/#scroll_details/Viewport/Content/#txt_title")
	slot0._txtDetailContent = gohelper.findChildTextMesh(slot0._goDetails, "details/#scroll_details/Viewport/Content/#txt_details")
	slot0._ani = gohelper.onceAddComponent(slot1, typeof(UnityEngine.Animator))
end

function slot0.addEventListeners(slot0)
	slot0._btn:AddClickListener(slot0.clickIcon, slot0)

	slot0._long = SLFramework.UGUI.UILongPressListener.Get(slot0._btn.gameObject)

	slot0._long:SetLongPressTime({
		0.5,
		99999
	})
	slot0._long:AddLongPressListener(slot0._onLongPress, slot0)
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceFinish, slot0.updateSkillRound, slot0)
	FightController.instance:registerCallback(FightEvent.OnEntityDead, slot0.checkHeroIsDead, slot0)
	FightController.instance:registerCallback(FightEvent.TouchFightViewScreen, slot0._onTouchFightViewScreen, slot0)
	FightController.instance:registerCallback(FightEvent.OnClothSkillRoundSequenceFinish, slot0.updateSkillRound, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btn:RemoveClickListener()
	slot0._long:RemoveLongPressListener()
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceFinish, slot0.updateSkillRound, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnEntityDead, slot0.checkHeroIsDead, slot0)
	FightController.instance:unregisterCallback(FightEvent.TouchFightViewScreen, slot0._onTouchFightViewScreen, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnClothSkillRoundSequenceFinish, slot0.updateSkillRound, slot0)
end

function slot0.setCo(slot0, slot1)
	slot0._co = slot1

	slot0:refreshView()
end

function slot0.refreshView(slot0)
	if not slot0._co then
		return
	end

	gohelper.setActive(slot0._gonum, false)
	slot0._simagechar:LoadImage(ResUrl.getHandbookheroIcon(slot0._co.icon))

	if slot0._co.type == ToughBattleEnum.HeroType.Hero then
		slot0._trialId = tonumber(slot0._co.param) or 0

		slot0:checkHeroIsDead()
	elseif slot0._co.type == ToughBattleEnum.HeroType.Rule then
		slot0._ani:Play("passive", 0, 0)
	elseif slot0._co.type == ToughBattleEnum.HeroType.Skill then
		slot0._skillId = string.splitToNumber(slot0._co.param, "#")[1] or 0

		slot0:updateSkillRound()
	end

	slot0._txtDetailTitle.text = slot0._co.name
	slot0._txtDetailContent.text = HeroSkillModel.instance:skillDesToSpot(slot0._co.desc)
end

function slot0.checkHeroIsDead(slot0)
	if not slot0._co or slot0._co.type ~= ToughBattleEnum.HeroType.Hero then
		return
	end

	slot2 = nil

	for slot6, slot7 in ipairs(FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.MySide)) do
		if slot7.trialId == slot0._trialId then
			slot2 = slot7

			break
		end
	end

	SLFramework.UGUI.GuiHelper.SetColor(slot0._simagechar.gameObject:GetComponent(gohelper.Type_Image), slot2 and "#FFFFFF" or "#c8c8c8")

	if slot2 then
		slot0._ani:Play("passive", 0, 0)
	elseif slot0.go.activeInHierarchy then
		slot0._ani:Play("die", 0, 0)
		TaskDispatcher.runDelay(slot0._destoryThis, slot0, 0.667)
	else
		slot0._isDeaded = true
	end
end

function slot0.onEnable(slot0)
	if slot0._isDeaded and slot0._ani then
		slot0._ani:Play("die", 0, 0)
		TaskDispatcher.runDelay(slot0._destoryThis, slot0, 0.667)
	end
end

function slot0._destoryThis(slot0)
	gohelper.destroy(slot0.go)
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._destoryThis, slot0)
end

function slot0.updateSkillRound(slot0)
	if not slot0._co or slot0._co.type ~= ToughBattleEnum.HeroType.Skill then
		return
	end

	if slot0:getCd() > 0 then
		gohelper.setActive(slot0._gonum, true)

		slot0._txtnum.text = slot1
	else
		gohelper.setActive(slot0._gonum, false)
	end

	SLFramework.UGUI.GuiHelper.SetColor(slot0._simagechar.gameObject:GetComponent(gohelper.Type_Image), slot1 <= 0 and "#FFFFFF" or "#808080")

	if slot1 <= 0 then
		slot0._ani:Play("active", 0, 0)
	else
		slot0._ani:Play("cooling", 0, 0)
	end
end

function slot0.getCd(slot0)
	slot1 = 0

	if FightModel.instance:getClothSkillList() and #slot2 > 0 then
		for slot6, slot7 in pairs(slot2) do
			if slot7.skillId == slot0._skillId then
				slot1 = slot7.cd

				break
			end
		end
	end

	return slot1
end

function slot0.clickIcon(slot0)
	if FightViewHandCard.blockOperate or FightModel.instance:isAuto() then
		return
	end

	if FightReplayModel.instance:isReplay() then
		return
	end

	if FightCardModel.instance:isCardOpEnd() then
		return
	end

	if not slot0._co or slot0._co.type ~= ToughBattleEnum.HeroType.Skill then
		return
	end

	if slot0:getCd() > 0 then
		return
	end

	if #FightCardModel.instance:getCardOps() > 0 then
		FightRpc.instance:sendResetRoundRequest()
	end

	FightRpc.instance:sendUseClothSkillRequest(slot0._skillId, nil, , FightEnum.ClothSkillType.ClothSkill)
end

function slot0._onLongPress(slot0)
	gohelper.setActive(slot0._goDetails, true)
end

function slot0._onTouchFightViewScreen(slot0)
	gohelper.setActive(slot0._goDetails, false)
end

return slot0
