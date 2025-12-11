module("modules.logic.fight.view.FightBossRushHpTrackAIUseCardsItem", package.seeall)

local var_0_0 = class("FightBossRushHpTrackAIUseCardsItem", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	local var_1_0 = arg_1_0.viewGO

	arg_1_0.go = var_1_0
	arg_1_0.tr = arg_1_0.viewGO.transform
	arg_1_0._imgMat = gohelper.findChildImage(var_1_0, "imgMat")
	arg_1_0._imgTag = gohelper.findChildImage(var_1_0, "imgTag")
	arg_1_0._imgBgs = arg_1_0:getUserDataTb_()
	arg_1_0._imgBgGos = arg_1_0:getUserDataTb_()

	for iter_1_0 = 0, 4 do
		arg_1_0._imgBgs[iter_1_0] = gohelper.findChildImage(var_1_0, "imgBg/" .. iter_1_0)
		arg_1_0._imgBgGos[iter_1_0] = gohelper.findChild(var_1_0, "imgBg/" .. iter_1_0)
	end

	arg_1_0._imgBg2 = gohelper.findChildImage(var_1_0, "forbid/mask")

	if isDebugBuild then
		arg_1_0._imgTag.raycastTarget = true
		arg_1_0._click = gohelper.getClick(arg_1_0.go)

		arg_1_0:com_registClick(arg_1_0._click, arg_1_0._onClickOp)
	end

	arg_1_0.topPosRectTr = gohelper.findChildComponent(var_1_0, "topPos", gohelper.Type_RectTransform)
	arg_1_0.goEmitNormal = gohelper.findChild(var_1_0, "#emit_normal")
	arg_1_0.goEmitUitimate = gohelper.findChild(var_1_0, "#emit_uitimate")
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.onRefreshItemData(arg_3_0, arg_3_1)
	arg_3_0.cardData = arg_3_1
	arg_3_0.entityId = arg_3_0.cardData.uid
	arg_3_0.skillId = arg_3_0.cardData.skillId
	arg_3_0.entityData = FightDataHelper.entityMgr:getById(arg_3_0.entityId)
	arg_3_0.isBigSkill = FightCardDataHelper.isBigSkill(arg_3_0.skillId)

	if lua_skill_next.configDict[arg_3_0.skillId] then
		arg_3_0.isBigSkill = false
	end

	arg_3_0:refreshCanUseCardState()

	local var_3_0 = lua_skill.configDict[arg_3_1.skillId]

	gohelper.setActive(arg_3_0.go, var_3_0 ~= nil)

	if not var_3_0 then
		return
	end

	local var_3_1 = FightCardDataHelper.getSkillLv(arg_3_0.entityId, arg_3_0.skillId)

	var_3_1 = arg_3_0.isBigSkill and FightEnum.UniqueSkillCardLv or var_3_1 == FightEnum.UniqueSkillCardLv and 1 or var_3_1

	UISpriteSetMgr.instance:setFightSprite(arg_3_0._imgTag, "jnk_gj" .. var_3_0.showTag)

	for iter_3_0, iter_3_1 in pairs(arg_3_0._imgBgs) do
		gohelper.setActive(iter_3_1.gameObject, iter_3_0 == var_3_1)
	end

	if arg_3_0._imgBg2 and arg_3_0._imgBgs[var_3_1] then
		arg_3_0._imgBg2.sprite = arg_3_0._imgBgs[var_3_1].sprite
	end

	gohelper.setActive(arg_3_0._imgTag.gameObject, var_3_1 ~= FightEnum.UniqueSkillCardLv)
end

function var_0_0.refreshCanUseCardState(arg_4_0)
	arg_4_0.canUseCard = true
end

function var_0_0.onDestructor(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._imgBgs) do
		iter_5_1.material = nil
	end
end

return var_0_0
