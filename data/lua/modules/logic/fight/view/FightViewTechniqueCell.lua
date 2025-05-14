module("modules.logic.fight.view.FightViewTechniqueCell", package.seeall)

local var_0_0 = class("FightViewTechniqueCell", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._click = gohelper.getClickWithAudio(arg_1_1)
	arg_1_0._txtName = gohelper.findChildText(arg_1_1, "effectname")
	arg_1_0._img = gohelper.findChildSingleImage(arg_1_1, "icon")
	arg_1_0._animator = arg_1_1:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._moPlayHistory = {}
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, arg_2_0._onStartSequenceFinish, arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClickItem, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._click:RemoveClickListener()
end

function var_0_0._onStartSequenceFinish(arg_4_0)
	if arg_4_0._mo and not gohelper.isNil(arg_4_0._animator) then
		arg_4_0._animator:Play("fight_effecttips_loop")
		arg_4_0._animator:Update(0)
	end
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	if (not arg_5_0._mo or arg_5_0._mo ~= arg_5_1) and not arg_5_1.hasPlayAnimin and not gohelper.isNil(arg_5_0._animator) then
		arg_5_1.hasPlayAnimin = true
		arg_5_0._moPlayHistory[arg_5_1] = true

		arg_5_0._animator:Play("fight_effecttips")
		arg_5_0._animator:Update(0)
	end

	arg_5_0._mo = arg_5_1

	local var_5_0 = lua_fight_technique.configDict[arg_5_1.id]

	arg_5_0._txtName.text = var_5_0 and var_5_0.title_cn or ""

	if var_5_0 and not string.nilorempty(var_5_0.icon) then
		arg_5_0._img:LoadImage(ResUrl.getFightIcon(var_5_0.icon) .. ".png")
	end
end

function var_0_0.onDestroy(arg_6_0)
	if arg_6_0._img then
		arg_6_0._img:UnLoadImage()

		arg_6_0._img = nil
	end

	if arg_6_0._moPlayHistory then
		for iter_6_0, iter_6_1 in pairs(arg_6_0._moPlayHistory) do
			iter_6_0.hasPlayAnimin = nil
		end

		arg_6_0._moPlayHistory = nil
	end
end

function var_0_0._onClickItem(arg_7_0)
	if GuideModel.instance:getFlagValue(GuideModel.GuideFlag.FightForbidClickTechnique) then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightMoveCard) then
		return
	end

	local var_7_0 = GuideModel.instance:getDoingGuideIdList()
	local var_7_1 = var_7_0 and #var_7_0 or 0

	if not FightModel.instance:isStartFinish() and var_7_1 > 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.FightTechniqueTipsView, lua_fight_technique.configDict[arg_7_0._mo.id])
end

return var_0_0
