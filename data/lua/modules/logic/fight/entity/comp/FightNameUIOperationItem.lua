module("modules.logic.fight.entity.comp.FightNameUIOperationItem", package.seeall)

local var_0_0 = class("FightNameUIOperationItem", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imgMat = gohelper.findChildImage(arg_1_0.viewGO, "imgMat")
	arg_1_0._imgTag = gohelper.findChildImage(arg_1_0.viewGO, "imgTag")
	arg_1_0._imgBgs = arg_1_0:newUserDataTable()
	arg_1_0._imgBgGos = arg_1_0:newUserDataTable()

	for iter_1_0 = 0, 4 do
		arg_1_0._imgBgs[iter_1_0] = gohelper.findChildImage(arg_1_0.viewGO, "imgBg/" .. iter_1_0)
		arg_1_0._imgBgGos[iter_1_0] = gohelper.findChild(arg_1_0.viewGO, "imgBg/" .. iter_1_0)
	end

	arg_1_0._imgBg2 = gohelper.findChildImage(arg_1_0.viewGO, "forbid/mask")

	if isDebugBuild then
		arg_1_0._imgTag.raycastTarget = true

		arg_1_0:com_registClick(gohelper.getClick(arg_1_0.viewGO), arg_1_0._onClickOp)
	end

	arg_1_0.topPosRectTr = gohelper.findChildComponent(arg_1_0.viewGO, "topPos", gohelper.Type_RectTransform)
	arg_1_0.viewGOEmitNormal = gohelper.findChild(arg_1_0.viewGO, "#emit_normal")
	arg_1_0.viewGOEmitUitimate = gohelper.findChild(arg_1_0.viewGO, "#emit_uitimate")
	arg_1_0.animator = SLFramework.AnimatorPlayer.Get(arg_1_0.viewGO)

	arg_1_0:com_registFightEvent(FightEvent.OnSelectMonsterCardMo, arg_1_0.onSelectMonsterCardMo)
	arg_1_0:com_registEvent(ViewMgr.instance, ViewEvent.OnCloseView, arg_1_0.onCloseView)
	arg_1_0:com_registFightEvent(FightEvent.OnExPointChange, arg_1_0._onExPointChange)
	arg_1_0:com_registFightEvent(FightEvent.OnExSkillPointChange, arg_1_0._onExSkillPointChange)
end

function var_0_0.refreshItemData(arg_2_0, arg_2_1)
	arg_2_0._cardData = arg_2_1
	arg_2_0._entityMO = FightDataHelper.entityMgr:getById(arg_2_1.uid)

	local var_2_0 = lua_skill.configDict[arg_2_1.skillId]

	gohelper.setActive(arg_2_0.viewGO, var_2_0 ~= nil)

	if not var_2_0 then
		return
	end

	local var_2_1 = arg_2_0._cardData.skillId
	local var_2_2 = arg_2_0._entityMO.uid

	arg_2_0._isBigSkill = FightCardDataHelper.isBigSkill(var_2_1)

	local var_2_3 = FightCardDataHelper.getSkillLv(var_2_2, var_2_1)

	var_2_3 = arg_2_0._isBigSkill and FightEnum.UniqueSkillCardLv or var_2_3 == FightEnum.UniqueSkillCardLv and 1 or var_2_3

	UISpriteSetMgr.instance:setFightSprite(arg_2_0._imgTag, "jnk_gj" .. var_2_0.showTag)

	for iter_2_0, iter_2_1 in pairs(arg_2_0._imgBgs) do
		gohelper.setActive(iter_2_1.gameObject, iter_2_0 == var_2_3)
	end

	if arg_2_0._imgBg2 and arg_2_0._imgBgs[var_2_3] then
		arg_2_0._imgBg2.sprite = arg_2_0._imgBgs[var_2_3].sprite
	end

	gohelper.setActive(arg_2_0._imgTag.gameObject, var_2_3 ~= FightEnum.UniqueSkillCardLv)

	arg_2_0._lastAniName = nil
	arg_2_0._lastCanUse = true

	arg_2_0:_refreshAni()
end

function var_0_0._refreshAni(arg_3_0)
	arg_3_0._canUse = FightViewHandCardItemLock.canUseCardSkill(arg_3_0._entityMO.id, arg_3_0._cardData.skillId)

	if arg_3_0._isBigSkill and arg_3_0._canUse then
		arg_3_0._canUse = arg_3_0._entityMO.exPoint >= arg_3_0._entityMO:getUniqueSkillPoint()
	end

	arg_3_0._curAniName = arg_3_0._canUse and "fightname_op_in" or "fightname_forbid_in"

	if arg_3_0._curAniName ~= arg_3_0._lastAniName then
		if not arg_3_0._lastCanUse and arg_3_0._canUse then
			arg_3_0._curAniName = "fightname_forbid_unlock"

			if arg_3_0.viewGO.activeInHierarchy then
				arg_3_0.animator:Play(arg_3_0._curAniName, arg_3_0._refreshAni, arg_3_0)
			end
		elseif arg_3_0.viewGO.activeInHierarchy then
			arg_3_0.animator:Play(arg_3_0._curAniName, nil, nil)
		end
	end

	arg_3_0._lastAniName = arg_3_0._curAniName
	arg_3_0._lastCanUse = arg_3_0._canUse
end

function var_0_0.onSelectMonsterCardMo(arg_4_0, arg_4_1)
	local var_4_0 = FightHelper.compareData(arg_4_1, arg_4_0._cardData)
	local var_4_1 = FightCardDataHelper.isBigSkill(arg_4_0._cardData.skillId)

	gohelper.setActive(arg_4_0.viewGOEmitNormal, var_4_0 and not var_4_1)
	gohelper.setActive(arg_4_0.viewGOEmitUitimate, var_4_0 and var_4_1)
end

function var_0_0.onCloseView(arg_5_0, arg_5_1)
	if arg_5_1 == ViewName.FightEnemyActionView then
		gohelper.setActive(arg_5_0.viewGOEmitNormal, false)
		gohelper.setActive(arg_5_0.viewGOEmitUitimate, false)
	end
end

function var_0_0._onClickOp(arg_6_0)
	if arg_6_0._cardData then
		logNormal(arg_6_0._cardData.skillId .. " " .. lua_skill.configDict[arg_6_0._cardData.skillId].name)
	end
end

function var_0_0._onExSkillPointChange(arg_7_0, arg_7_1)
	if arg_7_1 == arg_7_0._entityMO.id and arg_7_0._isBigSkill then
		arg_7_0:_refreshAni()
	end
end

function var_0_0._onExPointChange(arg_8_0, arg_8_1)
	if arg_8_1 == arg_8_0._entityMO.id and arg_8_0._isBigSkill then
		arg_8_0:_refreshAni()
	end
end

function var_0_0.onDestructor(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0._imgBgs) do
		iter_9_1.material = nil
	end
end

return var_0_0
