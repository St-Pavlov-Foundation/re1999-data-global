module("modules.logic.bossrush.view.V1a4_BossRushViewRule", package.seeall)

local var_0_0 = class("V1a4_BossRushViewRule", WeekWalkEnemyInfoViewRule)

function var_0_0.onInitView(arg_1_0)
	if not arg_1_0.viewContainer:diffRootChild(arg_1_0) then
		var_0_0.super.onInitView(arg_1_0)
	end

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._addRuleItem(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = gohelper.clone(arg_2_0._goruletemp, arg_2_0._gorulelist, arg_2_1.id)

	table.insert(arg_2_0._childGoList, var_2_0)
	gohelper.setActive(var_2_0, true)

	local var_2_1 = gohelper.findChildImage(var_2_0, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(var_2_1, "wz_" .. arg_2_2)

	local var_2_2 = gohelper.findChildImage(var_2_0, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_2_2, arg_2_1.icon)

	var_2_1.maskable = true
	var_2_2.maskable = true
end

function var_0_0._btnadditionRuleOnClick(arg_3_0)
	ViewMgr.instance:openView(ViewName.HeroGroupFightRuleDescView, {
		offSet = {
			-180,
			0
		},
		ruleList = arg_3_0._ruleList,
		closeCb = arg_3_0._btncloseruleOnClick,
		closeCbObj = arg_3_0
	})

	if arg_3_0._isHardMode then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HardModeShowRuleDesc)
	end
end

return var_0_0
