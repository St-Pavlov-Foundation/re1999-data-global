module("modules.logic.survival.view.shelter.ShelterRestHeroSelectQuickEditItem", package.seeall)

local var_0_0 = class("ShelterRestHeroSelectQuickEditItem", SurvivalInitHeroSelectQuickEditItem)

function var_0_0.getGroupModel(arg_1_0)
	return ShelterRestGroupModel.instance
end

function var_0_0._onItemClick(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	local var_2_0 = arg_2_0:getGroupModel():tryAddHeroMo(arg_2_0._mo)

	if var_2_0 then
		arg_2_0._view:selectCell(arg_2_0._index, true)
		gohelper.setActive(arg_2_0._goorderbg, true)
		gohelper.setActive(arg_2_0._goframe, true)

		arg_2_0._txtorder.text = var_2_0
	else
		gohelper.setActive(arg_2_0._goorderbg, false)
		gohelper.setActive(arg_2_0._goframe, false)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnHeroEditItemSelectChange, arg_2_0._mo)
end

return var_0_0
