module("modules.logic.fight.view.FightSeasonChangeHeroView", package.seeall)

slot0 = class("FightSeasonChangeHeroView", FightBaseView)

function slot0.onInitView(slot0)
	slot0._block = gohelper.findChildClick(slot0.viewGO, "block")
	slot0._blockTransform = slot0._block:GetComponent(gohelper.Type_RectTransform)
	slot0._confirmPart = gohelper.findChild(slot0.viewGO, "#go_SeasonConfirm")

	gohelper.setActive(slot0._confirmPart, false)

	slot0._txt_Tips = gohelper.findChildText(slot0.viewGO, "#go_SeasonConfirm/image_TipsBG/txt_Tips")
	slot0._selectIcon = gohelper.findChild(slot0.viewGO, "#go_SeasonConfirm/#go_Selected").transform
	slot0._skillRoot = gohelper.findChild(slot0.viewGO, "#go_SeasonConfirm/skillPart/skillRoot")
	slot0._restrainGO = gohelper.findChild(slot0.viewGO, "#go_SeasonConfirm/skillPart/restrain/restrain")
	slot0._beRestrainGO = gohelper.findChild(slot0.viewGO, "#go_SeasonConfirm/skillPart/restrain/beRestrain")
	slot0._restrainAnimator = slot0._restrainGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._beRestrainAnimator = slot0._beRestrainGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._goHeroListRoot = gohelper.findChild(slot0.viewGO, "#go_fightseasonsubherolist")
end

function slot0.addEvents(slot0)
	slot0:com_registClick(slot0._block, slot0._onBlock)
	slot0:com_registFightEvent(FightEvent.ReceiveChangeSubHeroReply, slot0._onReceiveChangeSubHeroReply)
	slot0:com_registFightEvent(FightEvent.GuideSeasonChangeHeroClickEntity, slot0._onGuideSeasonChangeHeroClickEntity)
end

function slot0.removeEvents(slot0)
end

function slot0._onReceiveChangeSubHeroReply(slot0)
	slot0:_exitOperate(true)
end

function slot0._getEntityList(slot0)
	return FightHelper.getSideEntitys(FightEnum.EntitySide.MySide)
end

function slot0._onGuideSeasonChangeHeroClickEntity(slot0, slot1)
	slot2 = nil

	for slot7, slot8 in ipairs(FightDataHelper.entityMgr:getMyNormalList()) do
		if slot8.skin == tonumber(slot1) then
			slot9 = FightHelper.getEntity(slot8.id)
			slot10, slot11, slot12, slot13 = FightHelper.calcRect(slot9, slot0._blockTransform)
			slot15, slot16 = nil

			if slot9:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle) then
				slot17, slot18, slot19 = transformhelper.getPos(slot14.transform)
				slot15, slot16 = recthelper.worldPosToAnchorPosXYZ(slot17, slot18, slot19, slot0._blockTransform)
			else
				slot15 = (slot10 + slot12) / 2
				slot16 = (slot11 + slot13) / 2
			end

			slot0:_clickEntity(slot2, slot15, slot16)

			break
		end
	end
end

function slot0._onBlock(slot0, slot1, slot2)
	if not slot0._selectItem then
		slot0:_exitOperate()

		return
	end

	slot4, slot5, slot6 = FightHelper.getClickEntity(slot0:_getEntityList(), slot0._blockTransform, slot2)

	if slot4 then
		if not FightDataHelper.entityMgr:getById(slot4) then
			return
		end

		slot0:_clickEntity(slot4, slot5, slot6)

		return
	end

	slot0:_exitOperate()
end

function slot0._clickEntity(slot0, slot1, slot2, slot3)
	if slot0._curSelectEntityId == slot1 then
		FightRpc.instance:sendChangeSubHeroRequest(slot0._selectItem._entityId, slot1)
	else
		slot0._txt_Tips.text = luaLang("fight_season_change_hero_confirm")
		slot0._curSelectEntityId = slot1

		gohelper.setActive(slot0._selectIcon, false)
		gohelper.setActive(slot0._selectIcon, true)
		recthelper.setAnchor(slot0._selectIcon, slot2, slot3)
		slot0:com_sendFightEvent(FightEvent.SeasonSelectChangeHeroTarget, slot0._curSelectEntityId)
	end
end

function slot0._onLoadFinish(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot0._skillItem = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot2:GetResource(), slot0._skillRoot), FightViewCardItem)

	slot0:_refreshSkill()
end

function slot0._refreshSkill(slot0)
	if not slot0._skillItem then
		return
	end

	if slot0._selectItem then
		slot1 = FightDataHelper.entityMgr:getById(slot0._selectItem._entityId)

		slot0._skillItem:updateItem(slot1.id, slot1.exSkill)

		slot3 = GMFightShowState.handCardRestrain

		gohelper.setActive(slot0._restrainGO, FightViewHandCardItemRestrain.getNewRestrainStatus(slot1.id, slot1.exSkill) == FightViewHandCardItemRestrain.RestrainMvStatus.Restrain and slot3)
		gohelper.setActive(slot0._beRestrainGO, slot2 == FightViewHandCardItemRestrain.RestrainMvStatus.BeRestrain and slot3)

		if slot2 == FightViewHandCardItemRestrain.RestrainMvStatus.Restrain then
			slot0._restrainAnimator:Play("fight_restrain_all_not", 0, 0)
			slot0._restrainAnimator:Update(0)
		elseif slot2 == FightViewHandCardItemRestrain.RestrainMvStatus.BeRestrain then
			slot0._beRestrainAnimator:Play("fight_restrain_all_not", 0, 0)
			slot0._beRestrainAnimator:Update(0)
		end
	end
end

function slot0.selectItem(slot0, slot1)
	slot0._selectItem = slot1

	if not slot0._loadedSkill then
		slot0._loadedSkill = true

		slot0:com_loadAsset("ui/viewres/fight/fightcarditem.prefab", slot0._onLoadFinish)
	else
		slot0:_refreshSkill()
	end
end

function slot0._exitOperate(slot0, slot1)
	gohelper.setActive(slot0._block, false)
	gohelper.setActive(slot0._confirmPart, false)
	gohelper.setActive(slot0._selectIcon, false)

	if slot0._fightdardObj then
		gohelper.setActive(slot0._fightdardObj, false)
	end

	for slot6, slot7 in ipairs(slot0:_getEntityList()) do
		if slot7.spine then
			slot7:setRenderOrder(FightRenderOrderMgr.instance:getOrder(slot7.id))
			FightRenderOrderMgr.instance:register(slot7.id)
		end
	end

	slot0._curSelectEntityId = nil
	slot0._selectItem = nil

	slot0._heroListView:_exitOperate(slot1)
	FightDataHelper.stageMgr:exitOperateState(FightStageMgr.OperateStateType.SeasonChangeHero)
	NavigateMgr.instance:removeEscape(slot0.viewContainer.viewName)
end

function slot0._enterOperate(slot0)
	slot0._txt_Tips.text = luaLang("fight_season_change_hero_select")

	if not slot0._loadedFightDard then
		slot0._loadedFightDard = true

		slot0:com_loadAsset("effects/prefabs/buff/fightdark.prefab", slot0._onFightdardLoadFinish)
	elseif slot0._fightdardObj then
		gohelper.setActive(slot0._fightdardObj, true)
	end

	for slot5, slot6 in ipairs(slot0:_getEntityList()) do
		if slot6.spine then
			slot6:setRenderOrder(20000 + (slot6.spine._renderOrder or 0))
			FightRenderOrderMgr.instance:unregister(slot6.id)
		end
	end

	gohelper.setActive(slot0._block, true)
	gohelper.setActive(slot0._confirmPart, true)
	FightDataHelper.stageMgr:enterOperateState(FightStageMgr.OperateStateType.SeasonChangeHero)
	NavigateMgr.instance:addEscape(slot0.viewContainer.viewName, slot0._onBtnEsc, slot0)
end

function slot0._onFightdardLoadFinish(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot0._fightdardObj = gohelper.clone(slot2:GetResource())
	gohelper.findChild(slot0._fightdardObj, "fightdark"):GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = 20000

	if FightDataHelper.stageMgr:getCurOperateState() ~= FightStageMgr.OperateStateType.SeasonChangeHero then
		gohelper.setActive(slot0._fightdardObj, false)
	end
end

function slot0._onBtnEsc(slot0)
	if FightDataHelper.stageMgr:getCurOperateState() == FightStageMgr.OperateStateType.SeasonChangeHero then
		slot0:_exitOperate()
	end
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._block, false)
	gohelper.setActive(slot0._selectIcon, false)

	slot0._heroListView = slot0:com_openSubView(FightSeasonSubHeroList, "ui/viewres/fight/fightseasonsubherolist.prefab", slot0._goHeroListRoot)
end

function slot0.onClose(slot0)
	if slot0._fightdardObj then
		gohelper.destroy(slot0._fightdardObj)
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
