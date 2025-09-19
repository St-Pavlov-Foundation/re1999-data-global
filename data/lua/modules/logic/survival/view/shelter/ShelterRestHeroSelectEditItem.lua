module("modules.logic.survival.view.shelter.ShelterRestHeroSelectEditItem", package.seeall)

local var_0_0 = class("ShelterRestHeroSelectEditItem", SurvivalInitHeroSelectEditItem)

function var_0_0.getGroupModel(arg_1_0)
	return ShelterRestGroupModel.instance
end

function var_0_0._onItemClick(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if arg_2_0._isSelect then
		arg_2_0._view:selectCell(arg_2_0._index, false)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	else
		arg_2_0._view:selectCell(arg_2_0._index, true)
	end
end

return var_0_0
