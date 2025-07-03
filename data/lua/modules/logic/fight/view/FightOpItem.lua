module("modules.logic.fight.view.FightOpItem", package.seeall)

local var_0_0 = class("FightOpItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tr = arg_1_1.transform
	arg_1_0._imgMat = gohelper.findChildImage(arg_1_1, "imgMat")
	arg_1_0._imgTag = gohelper.findChildImage(arg_1_1, "imgTag")
	arg_1_0._imgBgs = arg_1_0:getUserDataTb_()
	arg_1_0._imgBgGos = arg_1_0:getUserDataTb_()

	for iter_1_0 = 0, 4 do
		arg_1_0._imgBgs[iter_1_0] = gohelper.findChildImage(arg_1_1, "imgBg/" .. iter_1_0)
		arg_1_0._imgBgGos[iter_1_0] = gohelper.findChild(arg_1_1, "imgBg/" .. iter_1_0)
	end

	arg_1_0._imgBg2 = gohelper.findChildImage(arg_1_1, "forbid/mask")

	if isDebugBuild then
		arg_1_0._imgTag.raycastTarget = true
		arg_1_0._click = gohelper.getClick(arg_1_0.go)

		arg_1_0._click:AddClickListener(arg_1_0._onClickOp, arg_1_0)
	end

	arg_1_0.topPosRectTr = gohelper.findChildComponent(arg_1_1, "topPos", gohelper.Type_RectTransform)
	arg_1_0.goEmitNormal = gohelper.findChild(arg_1_1, "#emit_normal")
	arg_1_0.goEmitUitimate = gohelper.findChild(arg_1_1, "#emit_uitimate")

	arg_1_0:addEventCb(FightController.instance, FightEvent.OnSelectMonsterCardMo, arg_1_0.onSelectMonsterCardMo, arg_1_0)
	arg_1_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_1_0.onCloseView, arg_1_0)
end

function var_0_0.removeEventListeners(arg_2_0)
	if isDebugBuild and arg_2_0._click then
		arg_2_0._click:RemoveClickListener()
	end

	arg_2_0:removeEventCb(FightController.instance, FightEvent.OnSelectMonsterCardMo, arg_2_0.onSelectMonsterCardMo, arg_2_0)
	arg_2_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0.onCloseView, arg_2_0)
end

function var_0_0.onSelectMonsterCardMo(arg_3_0, arg_3_1)
	local var_3_0 = FightHelper.isSameCardMo(arg_3_1, arg_3_0.cardInfoMO)
	local var_3_1 = FightCardDataHelper.isBigSkill(arg_3_0.cardInfoMO.skillId)

	if lua_skill_next.configDict[arg_3_0.cardInfoMO.skillId] then
		var_3_1 = false
	end

	gohelper.setActive(arg_3_0.goEmitNormal, var_3_0 and not var_3_1)
	gohelper.setActive(arg_3_0.goEmitUitimate, var_3_0 and var_3_1)
end

function var_0_0.onCloseView(arg_4_0, arg_4_1)
	if arg_4_1 == ViewName.FightEnemyActionView then
		gohelper.setActive(arg_4_0.goEmitNormal, false)
		gohelper.setActive(arg_4_0.goEmitUitimate, false)
	end
end

function var_0_0._onClickOp(arg_5_0)
	if arg_5_0.cardInfoMO then
		logNormal(arg_5_0.cardInfoMO.skillId .. " " .. lua_skill.configDict[arg_5_0.cardInfoMO.skillId].name)
	end
end

function var_0_0.updateCardInfoMO(arg_6_0, arg_6_1)
	arg_6_0.cardInfoMO = arg_6_1

	local var_6_0 = lua_skill.configDict[arg_6_1.skillId]

	gohelper.setActive(arg_6_0.go, var_6_0 ~= nil)

	if not var_6_0 then
		return
	end

	local var_6_1 = FightCardDataHelper.getSkillLv(arg_6_1.uid, arg_6_1.skillId)
	local var_6_2 = FightDataHelper.entityMgr:getById(arg_6_1.uid)
	local var_6_3 = FightCardDataHelper.isBigSkill(arg_6_1.skillId)

	if lua_skill_next.configDict[arg_6_1.skillId] then
		var_6_3 = false
	end

	var_6_1 = var_6_3 and FightEnum.UniqueSkillCardLv or var_6_1 == FightEnum.UniqueSkillCardLv and 1 or var_6_1

	UISpriteSetMgr.instance:setFightSprite(arg_6_0._imgTag, "jnk_gj" .. var_6_0.showTag)

	for iter_6_0, iter_6_1 in pairs(arg_6_0._imgBgs) do
		gohelper.setActive(iter_6_1.gameObject, iter_6_0 == var_6_1)
	end

	if arg_6_0._imgBg2 and arg_6_0._imgBgs[var_6_1] then
		arg_6_0._imgBg2.sprite = arg_6_0._imgBgs[var_6_1].sprite
	end

	gohelper.setActive(arg_6_0._imgTag.gameObject, var_6_1 ~= FightEnum.UniqueSkillCardLv)
end

function var_0_0.showOpForbid(arg_7_0)
	local var_7_0 = FightCardDataHelper.getSkillLv(arg_7_0.cardInfoMO.uid, arg_7_0.cardInfoMO.skillId)
	local var_7_1 = arg_7_0._imgBgGos[var_7_0]

	if var_7_1 then
		local var_7_2 = var_7_1:GetComponent(typeof(UnityEngine.Animation))

		gohelper.onceAddComponent(var_7_1, typeof(ZProj.EffectTimeScale)):SetTimeScale(FightModel.instance:getUISpeed())

		if var_7_2 then
			var_7_2:Play("fightname_forbid_dissvelop")
		end

		arg_7_0._imgBgs[var_7_0].material = arg_7_0._imgMat.material
	end
end

function var_0_0.cancelOpForbid(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0._imgBgs) do
		iter_8_1.material = nil
	end
end

return var_0_0
