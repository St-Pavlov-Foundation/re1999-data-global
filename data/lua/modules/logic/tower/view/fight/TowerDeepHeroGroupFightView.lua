module("modules.logic.tower.view.fight.TowerDeepHeroGroupFightView", package.seeall)

local var_0_0 = class("TowerDeepHeroGroupFightView", TowerHeroGroupFightView)

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)
end

function var_0_0._enterFight(arg_2_0)
	if HeroGroupModel.instance.episodeId then
		arg_2_0._closeWithEnteringFight = true

		if FightController.instance:setFightHeroSingleGroup() then
			arg_2_0.viewContainer:dispatchEvent(HeroGroupEvent.BeforeEnterFight)

			local var_2_0 = FightModel.instance:getFightParam()

			var_2_0.isReplay = false
			var_2_0.multiplication = 1

			DungeonFightController.instance:sendStartDungeonRequest(var_2_0.chapterId, var_2_0.episodeId, var_2_0, 1)
			AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
		end
	else
		logError("没选中关卡，无法开始战斗")
	end
end

return var_0_0
