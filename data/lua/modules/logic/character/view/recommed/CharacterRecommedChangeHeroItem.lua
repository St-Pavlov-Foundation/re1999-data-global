module("modules.logic.character.view.recommed.CharacterRecommedChangeHeroItem", package.seeall)

local var_0_0 = class("CharacterRecommedChangeHeroItem", CharacterRecommedHeroIcon)

function var_0_0._btnclickOnClick(arg_1_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local var_1_0 = arg_1_0._mo.heroId

	arg_1_0._view.viewParam.heroId = var_1_0

	CharacterRecommedController.instance:dispatchEvent(CharacterRecommedEvent.OnChangeHero, var_1_0)
end

return var_0_0
