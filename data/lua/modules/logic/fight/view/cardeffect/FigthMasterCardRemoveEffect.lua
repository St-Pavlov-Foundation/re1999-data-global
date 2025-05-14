module("modules.logic.fight.view.cardeffect.FigthMasterCardRemoveEffect", package.seeall)

local var_0_0 = class("FigthMasterCardRemoveEffect", BaseWork)
local var_0_1 = {
	"ui/viewres/fight/ui_effect_wuduquan_a.prefab"
}

function var_0_0.onStart(arg_1_0, arg_1_1)
	arg_1_0._loader = arg_1_0._loader or LoaderComponent.New()

	arg_1_0._loader:loadListAsset(var_0_1, arg_1_0._onLoaded, arg_1_0._onAllLoaded, arg_1_0)
end

function var_0_0._onLoaded(arg_2_0)
	return
end

function var_0_0._onAllLoaded(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(var_0_1) do
		local var_3_0 = arg_3_0._loader:getAssetItem(iter_3_1)

		if var_3_0 then
			local var_3_1 = var_3_0:GetResource()

			if iter_3_0 == 1 then
				arg_3_0.context.card:playAni(ViewAnim.FightCardWuDuQuan, UIAnimationName.Close)

				arg_3_0._clonePrefab = gohelper.clone(var_3_1, arg_3_0.context.card.go)

				gohelper.onceAddComponent(arg_3_0._clonePrefab, typeof(UnityEngine.Animator)):Play("close", 0, 0)
			end
		end
	end

	TaskDispatcher.runDelay(arg_3_0._delayDone, arg_3_0, 0.8 / FightModel.instance:getUISpeed())
end

function var_0_0._delayDone(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	local var_5_0 = arg_5_0.context.card._forAnimGO

	if not gohelper.isNil(var_5_0) then
		gohelper.onceAddComponent(var_5_0, gohelper.Type_CanvasGroup).alpha = 1
	end

	if not gohelper.isNil(arg_5_0._clonePrefab) then
		gohelper.destroy(arg_5_0._clonePrefab)
	end

	gohelper.setActive(arg_5_0.context.card.go, false)

	if arg_5_0._loader then
		arg_5_0._loader:releaseSelf()

		arg_5_0._loader = nil
	end
end

return var_0_0
