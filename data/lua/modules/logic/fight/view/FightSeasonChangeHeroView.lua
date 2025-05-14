module("modules.logic.fight.view.FightSeasonChangeHeroView", package.seeall)

local var_0_0 = class("FightSeasonChangeHeroView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._block = gohelper.findChildClick(arg_1_0.viewGO, "block")
	arg_1_0._blockTransform = arg_1_0._block:GetComponent(gohelper.Type_RectTransform)
	arg_1_0._confirmPart = gohelper.findChild(arg_1_0.viewGO, "#go_SeasonConfirm")

	gohelper.setActive(arg_1_0._confirmPart, false)

	arg_1_0._txt_Tips = gohelper.findChildText(arg_1_0.viewGO, "#go_SeasonConfirm/image_TipsBG/txt_Tips")
	arg_1_0._selectIcon = gohelper.findChild(arg_1_0.viewGO, "#go_SeasonConfirm/#go_Selected").transform
	arg_1_0._skillRoot = gohelper.findChild(arg_1_0.viewGO, "#go_SeasonConfirm/skillPart/skillRoot")
	arg_1_0._restrainGO = gohelper.findChild(arg_1_0.viewGO, "#go_SeasonConfirm/skillPart/restrain/restrain")
	arg_1_0._beRestrainGO = gohelper.findChild(arg_1_0.viewGO, "#go_SeasonConfirm/skillPart/restrain/beRestrain")
	arg_1_0._restrainAnimator = arg_1_0._restrainGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._beRestrainAnimator = arg_1_0._beRestrainGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._goHeroListRoot = gohelper.findChild(arg_1_0.viewGO, "#go_fightseasonsubherolist")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registClick(arg_2_0._block, arg_2_0._onBlock)
	arg_2_0:com_registFightEvent(FightEvent.ReceiveChangeSubHeroReply, arg_2_0._onReceiveChangeSubHeroReply)
	arg_2_0:com_registFightEvent(FightEvent.GuideSeasonChangeHeroClickEntity, arg_2_0._onGuideSeasonChangeHeroClickEntity)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._onReceiveChangeSubHeroReply(arg_4_0)
	arg_4_0:_exitOperate(true)
end

function var_0_0._getEntityList(arg_5_0)
	return FightHelper.getSideEntitys(FightEnum.EntitySide.MySide)
end

function var_0_0._onGuideSeasonChangeHeroClickEntity(arg_6_0, arg_6_1)
	arg_6_1 = tonumber(arg_6_1)

	local var_6_0
	local var_6_1 = FightDataHelper.entityMgr:getMyNormalList()

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		if iter_6_1.skin == arg_6_1 then
			local var_6_2 = iter_6_1.id
			local var_6_3 = FightHelper.getEntity(var_6_2)
			local var_6_4, var_6_5, var_6_6, var_6_7 = FightHelper.calcRect(var_6_3, arg_6_0._blockTransform)
			local var_6_8 = var_6_3:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle)
			local var_6_9
			local var_6_10

			if var_6_8 then
				local var_6_11, var_6_12, var_6_13 = transformhelper.getPos(var_6_8.transform)

				var_6_9, var_6_10 = recthelper.worldPosToAnchorPosXYZ(var_6_11, var_6_12, var_6_13, arg_6_0._blockTransform)
			else
				var_6_9 = (var_6_4 + var_6_6) / 2
				var_6_10 = (var_6_5 + var_6_7) / 2
			end

			arg_6_0:_clickEntity(var_6_2, var_6_9, var_6_10)

			break
		end
	end
end

function var_0_0._onBlock(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_0._selectItem then
		arg_7_0:_exitOperate()

		return
	end

	local var_7_0 = arg_7_0:_getEntityList()
	local var_7_1, var_7_2, var_7_3 = FightHelper.getClickEntity(var_7_0, arg_7_0._blockTransform, arg_7_2)

	if var_7_1 then
		if not FightDataHelper.entityMgr:getById(var_7_1) then
			return
		end

		arg_7_0:_clickEntity(var_7_1, var_7_2, var_7_3)

		return
	end

	arg_7_0:_exitOperate()
end

function var_0_0._clickEntity(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_0._curSelectEntityId == arg_8_1 then
		FightRpc.instance:sendChangeSubHeroRequest(arg_8_0._selectItem._entityId, arg_8_1)
	else
		arg_8_0._txt_Tips.text = luaLang("fight_season_change_hero_confirm")
		arg_8_0._curSelectEntityId = arg_8_1

		gohelper.setActive(arg_8_0._selectIcon, false)
		gohelper.setActive(arg_8_0._selectIcon, true)
		recthelper.setAnchor(arg_8_0._selectIcon, arg_8_2, arg_8_3)
		arg_8_0:com_sendFightEvent(FightEvent.SeasonSelectChangeHeroTarget, arg_8_0._curSelectEntityId)
	end
end

function var_0_0._onLoadFinish(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_1 then
		return
	end

	local var_9_0 = arg_9_2:GetResource()
	local var_9_1 = gohelper.clone(var_9_0, arg_9_0._skillRoot)

	arg_9_0._skillItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_9_1, FightViewCardItem)

	arg_9_0:_refreshSkill()
end

function var_0_0._refreshSkill(arg_10_0)
	if not arg_10_0._skillItem then
		return
	end

	if arg_10_0._selectItem then
		local var_10_0 = FightDataHelper.entityMgr:getById(arg_10_0._selectItem._entityId)

		arg_10_0._skillItem:updateItem(var_10_0.id, var_10_0.exSkill)

		local var_10_1 = FightViewHandCardItemRestrain.getNewRestrainStatus(var_10_0.id, var_10_0.exSkill)
		local var_10_2 = GMFightShowState.handCardRestrain

		gohelper.setActive(arg_10_0._restrainGO, var_10_1 == FightViewHandCardItemRestrain.RestrainMvStatus.Restrain and var_10_2)
		gohelper.setActive(arg_10_0._beRestrainGO, var_10_1 == FightViewHandCardItemRestrain.RestrainMvStatus.BeRestrain and var_10_2)

		if var_10_1 == FightViewHandCardItemRestrain.RestrainMvStatus.Restrain then
			arg_10_0._restrainAnimator:Play("fight_restrain_all_not", 0, 0)
			arg_10_0._restrainAnimator:Update(0)
		elseif var_10_1 == FightViewHandCardItemRestrain.RestrainMvStatus.BeRestrain then
			arg_10_0._beRestrainAnimator:Play("fight_restrain_all_not", 0, 0)
			arg_10_0._beRestrainAnimator:Update(0)
		end
	end
end

function var_0_0.selectItem(arg_11_0, arg_11_1)
	arg_11_0._selectItem = arg_11_1

	if not arg_11_0._loadedSkill then
		arg_11_0._loadedSkill = true

		local var_11_0 = "ui/viewres/fight/fightcarditem.prefab"

		arg_11_0:com_loadAsset(var_11_0, arg_11_0._onLoadFinish)
	else
		arg_11_0:_refreshSkill()
	end
end

function var_0_0._exitOperate(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0._block, false)
	gohelper.setActive(arg_12_0._confirmPart, false)
	gohelper.setActive(arg_12_0._selectIcon, false)

	if arg_12_0._fightdardObj then
		gohelper.setActive(arg_12_0._fightdardObj, false)
	end

	local var_12_0 = arg_12_0:_getEntityList()

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		if iter_12_1.spine then
			iter_12_1:setRenderOrder(FightRenderOrderMgr.instance:getOrder(iter_12_1.id))
			FightRenderOrderMgr.instance:register(iter_12_1.id)
		end
	end

	arg_12_0._curSelectEntityId = nil
	arg_12_0._selectItem = nil

	arg_12_0._heroListView:_exitOperate(arg_12_1)
	FightDataHelper.stageMgr:exitOperateState(FightStageMgr.OperateStateType.SeasonChangeHero)
	NavigateMgr.instance:removeEscape(arg_12_0.viewContainer.viewName)
end

function var_0_0._enterOperate(arg_13_0)
	arg_13_0._txt_Tips.text = luaLang("fight_season_change_hero_select")

	if not arg_13_0._loadedFightDard then
		arg_13_0._loadedFightDard = true

		local var_13_0 = "effects/prefabs/buff/fightdark.prefab"

		arg_13_0:com_loadAsset(var_13_0, arg_13_0._onFightdardLoadFinish)
	elseif arg_13_0._fightdardObj then
		gohelper.setActive(arg_13_0._fightdardObj, true)
	end

	local var_13_1 = arg_13_0:_getEntityList()

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		if iter_13_1.spine then
			local var_13_2 = iter_13_1.spine._renderOrder or 0

			iter_13_1:setRenderOrder(20000 + var_13_2)
			FightRenderOrderMgr.instance:unregister(iter_13_1.id)
		end
	end

	gohelper.setActive(arg_13_0._block, true)
	gohelper.setActive(arg_13_0._confirmPart, true)
	FightDataHelper.stageMgr:enterOperateState(FightStageMgr.OperateStateType.SeasonChangeHero)
	NavigateMgr.instance:addEscape(arg_13_0.viewContainer.viewName, arg_13_0._onBtnEsc, arg_13_0)
end

function var_0_0._onFightdardLoadFinish(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_1 then
		return
	end

	local var_14_0 = 20000
	local var_14_1 = arg_14_2:GetResource()

	arg_14_0._fightdardObj = gohelper.clone(var_14_1)
	gohelper.findChild(arg_14_0._fightdardObj, "fightdark"):GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = var_14_0

	if FightDataHelper.stageMgr:getCurOperateState() ~= FightStageMgr.OperateStateType.SeasonChangeHero then
		gohelper.setActive(arg_14_0._fightdardObj, false)
	end
end

function var_0_0._onBtnEsc(arg_15_0)
	if FightDataHelper.stageMgr:getCurOperateState() == FightStageMgr.OperateStateType.SeasonChangeHero then
		arg_15_0:_exitOperate()
	end
end

function var_0_0.onOpen(arg_16_0)
	gohelper.setActive(arg_16_0._block, false)
	gohelper.setActive(arg_16_0._selectIcon, false)

	arg_16_0._heroListView = arg_16_0:com_openSubView(FightSeasonSubHeroList, "ui/viewres/fight/fightseasonsubherolist.prefab", arg_16_0._goHeroListRoot)
end

function var_0_0.onClose(arg_17_0)
	if arg_17_0._fightdardObj then
		gohelper.destroy(arg_17_0._fightdardObj)
	end
end

function var_0_0.onDestroyView(arg_18_0)
	return
end

return var_0_0
